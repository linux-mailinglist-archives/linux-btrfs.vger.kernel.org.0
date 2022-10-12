Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0785FC2CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJLJOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJLJNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D3BC46C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4563C1F37C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ue1aiSA1mCaYMFFkl3la+YWlrpNO+FkgGBb2cuGZBTY=;
        b=umQfexSmuX7WkUhsdj+IjBkC7fTkklRAPdELti5+JpPchQkgWKPLVcu2ihG0yTs74Dx7Dd
        pOKP5keWHG/JotSO/0sj7UKyEahFm1ZjWDW2TzCEorzmvxVl4vviDl5c8jHIWcSXWpIIx2
        TWGZeRIVZkHhKDm9ygEf5d191SOyZx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E12313A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iASfGkeFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/15] btrfs: introduce a debug mount option to do error injection for each stage of open_ctree()
Date:   Wed, 12 Oct 2022 17:13:11 +0800
Message-Id: <cb7312a3d6c88100df88dc61c911e6d5e8455070.1665565866.git.wqu@suse.com>
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

With the new open_ctree_seq[] array, we can afford a debug mount option
to do all the error inject at different stages to have a much better
coverage for the error path.

The new "fail_mount=%u" mount option will be hidden behind
CONFIG_BTRFS_DEBUG option, and when enabled it will cause mount failure
just after the init function of specified stage.

This can be verified by the following script:

 mkfs.btrfs -f $dev
 for (( i=0;; i++ )) do
	mount -o fail_mount=$i $dev $mnt
	ret=$?
	if [ $ret -eq 0 ]; then
		umount $mnt
		exit
	fi
 done
 umount $mnt

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c | 14 ++++++++++++++
 fs/btrfs/super.c   | 13 +++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a4557075b5c2..6e0cd5b5bc61 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -854,6 +854,7 @@ struct btrfs_fs_info {
 
 	spinlock_t eb_leak_lock;
 	struct list_head allocated_ebs;
+	int fail_stage;
 #endif
 };
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8e49a6dee207..065d13891866 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3019,6 +3019,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
 	spin_lock_init(&fs_info->eb_leak_lock);
+	fs_info->fail_stage = -1;
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
@@ -3971,6 +3972,19 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		if (ret < 0)
 			goto fail;
 		open_ctree_res[i] = true;
+#ifdef CONFIG_BTRFS_DEBUG
+		/*
+		 * This is not the best timing, as fail_stage will only be
+		 * initialized after open_ctree_features_init().
+		 * But this is still better to cover more error paths.
+		 */
+		if (fs_info->fail_stage >= 0 && i >= fs_info->fail_stage) {
+			btrfs_info(fs_info,
+				"error injected at open ctree stage %u", i);
+			ret = -ECANCELED;
+			goto fail;
+		}
+#endif
 	}
 
 	if (btrfs_build_ref_tree(fs_info))
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bbdbd2a6e3bc..c25220bae232 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -447,6 +447,7 @@ enum {
 	Opt_enospc_debug, Opt_noenospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
 	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
+	Opt_fail_mount,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
@@ -521,6 +522,7 @@ static const match_table_t tokens = {
 	{Opt_fragment_data, "fragment=data"},
 	{Opt_fragment_metadata, "fragment=metadata"},
 	{Opt_fragment_all, "fragment=all"},
+	{Opt_fail_mount, "fail_mount=%u"},
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	{Opt_ref_verify, "ref_verify"},
@@ -1106,6 +1108,17 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_info(info, "fragmenting data");
 			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
 			break;
+		case Opt_fail_mount:
+			ret = match_int(&args[0], &intarg);
+			if (ret) {
+				btrfs_err(info, "unrecognized fail_mount value %s",
+					  args[0].from);
+				goto out;
+			}
+			btrfs_info(info, "fail mount at open_ctree() stage %u",
+				   intarg);
+			info->fail_stage = intarg;
+			break;
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 		case Opt_ref_verify:
-- 
2.37.3

