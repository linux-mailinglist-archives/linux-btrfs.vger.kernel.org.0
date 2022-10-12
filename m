Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F10D5FC2CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJLJOA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJLJNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8528BC452
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40ED321DB9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6IpvYPleLr42kO/paU0rVPG33uckx8pPgZtp9YJQo0=;
        b=RauTsfwRKhh7XJlEgbx/cS8Kj1WTlOhX9CszYQ1hhBrm1pFujcKNFbvIS9HW5vqcsH7y/6
        /D2OFU/sGqShl9MHw18YA4/ueOmyIHv87C0UU9TOA9YHHyykFmcS75/CbBH8zig3UgYNhj
        5N2MRWG5HQ429DJNBbP7511Kq24Vuk8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B8B813A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sCTkGUaFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/15] btrfs: move qgroup init/exit code into open_ctree_seq[] array
Date:   Wed, 12 Oct 2022 17:13:10 +0800
Message-Id: <0790f9d45d6c67abab31a739a8b821f3f4d49edb.1665565866.git.wqu@suse.com>
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

The qgroup related code is already extracted into two functions,
btrfs_read_qgroup_config() and btrfs_free_qgroup_config().

They are perfect matches for open_ctree_seq[], so just move them into
open_ctree_seq[] array.

And with the usage of open_ctree_seq[], there is no more need for @err
variable, just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2d1f178cdecd..8e49a6dee207 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3946,6 +3946,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_kthread_init,
 		.exit_func = open_ctree_kthread_exit,
+	}, {
+		.init_func = btrfs_read_qgroup_config,
+		.exit_func = btrfs_free_qgroup_config,
 	}
 };
 
@@ -3955,7 +3958,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
 	int ret;
-	int err = -EINVAL;
 	int i;
 
 	fs_info->sb = sb;
@@ -3971,10 +3973,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_read_qgroup_config(fs_info);
-	if (ret)
-		goto fail;
-
 	if (btrfs_build_ref_tree(fs_info))
 		btrfs_err(fs_info, "couldn't build ref tree");
 
@@ -3983,10 +3981,8 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
 		btrfs_info(fs_info, "start tree-log replay");
 		ret = btrfs_replay_log(fs_info, fs_devices);
-		if (ret) {
-			err = ret;
-			goto fail_qgroup;
-		}
+		if (ret)
+			goto fail;
 	}
 
 	if (sb_rdonly(fs_info->sb))
@@ -4023,9 +4019,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
-fail_qgroup:
-	btrfs_free_qgroup_config(fs_info);
-
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
 		if (!open_ctree_res[i] || !open_ctree_seq[i].exit_func)
@@ -4034,9 +4027,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = false;
 	}
 	btrfs_close_devices(fs_info->fs_devices);
-	if (ret < 0)
-		err = ret;
-	return err;
+	return ret;
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
-- 
2.37.3

