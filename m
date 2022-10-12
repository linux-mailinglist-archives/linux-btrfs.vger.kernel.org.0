Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD155FC2BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJLJNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJLJNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C60BBF35
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30C1D21CEE
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbIusAyDp9Yh4qbhwl8hRu3p9VXFawDV0eEV+4YB+X8=;
        b=jsQ3CUGR5TD92QQ+N8MhhtPXbrPGRhKigPk6oNdzWOlcisa75AUkyz3nTWIos8CR0VDxFn
        FcOSVOb+iwgZeE3rWqbEBbFbp/cBxI8I/HqV8QiwqIiQDTpNT9nCgQdmLWwzvCIFa2VB9s
        tbRoHPyqhQigioboQjdp1YBRMGpmecU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C35213A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yDEmEjqFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/15] btrfs: remove @fs_devices argument from open_ctree()
Date:   Wed, 12 Oct 2022 17:12:58 +0800
Message-Id: <62d2ded5f56d3ef1d56f75657a57fe1dde03bf13.1665565866.git.wqu@suse.com>
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

At the timing of open_ctree(), we have already initialized
fs_info->fs_devics, thus no need to pass a dedicated @fs_devices
argument into open_ctree().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 7 +++++--
 fs/btrfs/disk-io.h | 4 +---
 fs/btrfs/super.c   | 5 ++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c00999212c91..ba9fe0041e6f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3402,8 +3402,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	return 0;
 }
 
-int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
-		      char *options)
+int __cold open_ctree(struct super_block *sb, char *options)
 {
 	u32 sectorsize;
 	u32 nodesize;
@@ -3413,6 +3412,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	u16 csum_type;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	int ret;
@@ -3421,6 +3421,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	fs_info->sb = sb;
 
+	/* Caller should have already initialized fs_info->fs_devices. */
+	ASSERT(fs_info->fs_devices);
+
 	ret = init_mount_fs_info(fs_info);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0a77948bb703..15a1a56258c8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -42,9 +42,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 void btrfs_clean_tree_block(struct extent_buffer *buf);
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
-int __cold open_ctree(struct super_block *sb,
-	       struct btrfs_fs_devices *fs_devices,
-	       char *options);
+int __cold open_ctree(struct super_block *sb, char *options);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			 struct btrfs_super_block *sb, int mirror_num);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 688f7704d3fd..bbdbd2a6e3bc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1429,7 +1429,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 }
 
 static int btrfs_fill_super(struct super_block *sb,
-			    struct btrfs_fs_devices *fs_devices,
 			    void *data)
 {
 	struct inode *inode;
@@ -1458,7 +1457,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
-	err = open_ctree(sb, fs_devices, (char *)data);
+	err = open_ctree(sb, (char *)data);
 	if (err) {
 		btrfs_err(fs_info, "open_ctree failed");
 		return err;
@@ -1826,7 +1825,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		btrfs_sb(s)->bdev_holder = fs_type;
 		if (!strstr(crc32c_impl(), "generic"))
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
-		error = btrfs_fill_super(s, fs_devices, data);
+		error = btrfs_fill_super(s, data);
 	}
 	if (!error)
 		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
-- 
2.37.3

