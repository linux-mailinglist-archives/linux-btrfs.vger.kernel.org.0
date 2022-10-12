Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F025FC2C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLJNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJLJNj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06734BBE26
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 424D41F37C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyVMHPRVCNtAUYro1bXHOetsZ9fNLG1U95K8stMp3+k=;
        b=Ctu1DvEnNKl4egSnFde6xaSduVMuJIi3/7ciWUoxYRrTwEQpg8opEPjz71646Hk37ifx8p
        vbZ8Uv1GU7Ct1etYRnLNnliBT9fp+q92+KJjOPNPNgEI68RlywkIlRVabcvomP/qZzVH53
        GBX3OtcEQsZb4z3tEF1nyUEHeDX+89c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9939213A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBgZGT6FRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/15] btrfs: move btrfs_init_workqueus() and btrfs_stop_all_workers() into open_ctree_seq[]
Date:   Wed, 12 Oct 2022 17:13:02 +0800
Message-Id: <9bae6cc24eeaaccf90d1f1cacacada8631899a36.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
References: <cover.1665565866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those two helpers are already doing all the work, just move them into
the open_ctree_seq[] array.

There is only one small change:

- Call btrfs_stop_all_workers() inside btrfs_init_workqueus() for error
  handling
  Since open_ctree_seq[] makes all error path to call the exit function
  if and only if the corresponding init function finished without error.

  This means, if btrfs_init_workqueus() failed due to -ENOMEM, then we
  won't call btrfs_stop_all_workers() to cleanup whatever is already
  allocatd.

  To fix this problem, call btrfs_stop_all_workers() inside
  btrfs_init_workqueus() when we hit errors.
  Function btrfs_stop_all_workers() already has the checks to
  handle NULL pointers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 650eabb3d144..59775f37368f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2324,11 +2324,12 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->fixup_workers &&
 	      fs_info->delayed_workers && fs_info->qgroup_rescan_workers &&
-	      fs_info->discard_ctl.discard_workers)) {
-		return -ENOMEM;
-	}
-
+	      fs_info->discard_ctl.discard_workers))
+		goto error;
 	return 0;
+error:
+	btrfs_stop_all_workers(fs_info);
+	return -ENOMEM;
 }
 
 static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
@@ -3613,6 +3614,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_features_init,
 		.exit_func = NULL,
+	}, {
+		.init_func = btrfs_init_workqueues,
+		.exit_func = btrfs_stop_all_workers,
 	}
 };
 
@@ -3640,12 +3644,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_init_workqueues(fs_info);
-	if (ret) {
-		err = ret;
-		goto fail_sb_buffer;
-	}
-
 	mutex_lock(&fs_info->chunk_mutex);
 	ret = btrfs_read_sys_array(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
@@ -3903,7 +3901,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	free_root_pointers(fs_info, true);
 
 fail_sb_buffer:
-	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 fail:
-- 
2.37.3

