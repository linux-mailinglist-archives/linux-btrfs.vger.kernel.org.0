Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0A5E56FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIVAHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIVAHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A2A3D70
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68E9F21AB5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZRqi+Gv9LFjZUeHT4Ca6BSK9N1zrcqMXCyMsXixOvo=;
        b=OQf7cGAdV3EfMp94bjeDeZXfkqCAh2wwd5jrTh/JBFTSA/NhXJj9OCL58PdzD/JTatPSNF
        3GBcA3EQAr1WCRSlYqNAiDmPy4ALdFpOhBvL5ATtnyRcp6Bg1QEig19B0ZcPGH2bhnaNKn
        sG+c2Qm0N9feban/UsWGusw/aV8oAnQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7E30139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cHvQIDanK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs: move qgroup init/exit code into open_ctree_seq[] array
Date:   Thu, 22 Sep 2022 08:06:32 +0800
Message-Id: <14e6387b6fef3f50b518e9d9eb8bc3edf81632c9.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663804335.git.wqu@suse.com>
References: <cover.1663804335.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 7d46c9442b0f..14dcec9a23aa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3897,6 +3897,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_kthread_init,
 		.exit_func = open_ctree_kthread_exit,
+	}, {
+		.init_func = btrfs_read_qgroup_config,
+		.exit_func = btrfs_free_qgroup_config,
 	}
 };
 
@@ -3906,7 +3909,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	bool open_ctree_res[ARRAY_SIZE(open_ctree_seq)] = {0};
 	int ret;
-	int err = -EINVAL;
 	int i;
 
 	fs_info->sb = sb;
@@ -3922,10 +3924,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = btrfs_read_qgroup_config(fs_info);
-	if (ret)
-		goto fail;
-
 	if (btrfs_build_ref_tree(fs_info))
 		btrfs_err(fs_info, "couldn't build ref tree");
 
@@ -3934,10 +3932,8 @@ int __cold open_ctree(struct super_block *sb, char *options)
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
@@ -3974,9 +3970,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
-fail_qgroup:
-	btrfs_free_qgroup_config(fs_info);
-
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
 		if (!open_ctree_res[i] || !open_ctree_seq[i].exit_func)
@@ -3985,9 +3978,7 @@ int __cold open_ctree(struct super_block *sb, char *options)
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

