Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F826020AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 03:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJRB4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 21:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJRB4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 21:56:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D5D8B2F9
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 18:56:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FDFE33CD1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 01:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666058201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DsYwdBuLYqgb4q1trRW2hxyEQK/oMoD7Pv+/+TH7APc=;
        b=BRmxVVws9qAZuEFuZlJL5dVByEVmzZR9GG68p4NByIU/4B21vIJF5nUHkRHizkjMnifWdn
        hqIw9eqVM+4DKrojiBWcsIZHMJ+k8XVHC+Ey957LTaH2CYlFg6jU5M7dxXeHFTpcYepg42
        gqh70XiTtFSgyJJ86VC9AgbAIJGeS5Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01ADE1348F
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 01:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dJ2AL9gHTmNnNAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 01:56:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make thawn time super block check to also verify checksum
Date:   Tue, 18 Oct 2022 09:56:38 +0800
Message-Id: <b5eb3e1c071c9bd79dab0bb9883ad86843e00051.1666058154.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previous commit a05d3c915314 ("btrfs: check superblock to ensure the fs
was not modified at thaw time") only checks the content of the super
block, but it doesn't really check if the on-disk super block has a
matching checksum.

This patch will add the checksum verification to thawn time superblock
verification.

This involves the following extra changes:

- Export btrfs_check_super_csum()
  As we need to call it in super.c.

- Change the argument list of btrfs_check_super_csum()
  Instead of passing a char *, directly pass struct btrfs_super_block *
  pointer.

- Verify that our csum type didn't change before checking the csum

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ++++------
 fs/btrfs/disk-io.h |  2 ++
 fs/btrfs/super.c   | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9f526841c68b..5bf373f606e0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -166,11 +166,9 @@ static bool btrfs_supported_super_csum(u16 csum_type)
  * Return 0 if the superblock checksum type matches the checksum value of that
  * algorithm. Pass the raw disk superblock data.
  */
-static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
-				  char *raw_disk_sb)
+int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
+			   struct btrfs_super_block *disk_sb)
 {
-	struct btrfs_super_block *disk_sb =
-		(struct btrfs_super_block *)raw_disk_sb;
 	char result[BTRFS_CSUM_SIZE];
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 
@@ -181,7 +179,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space is
 	 * filled with zeros and is included in the checksum.
 	 */
-	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
+	crypto_shash_digest(shash, (u8 *)disk_sb + BTRFS_CSUM_SIZE,
 			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
 
 	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
@@ -3483,7 +3481,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
 	 */
-	if (btrfs_check_super_csum(fs_info, (u8 *)disk_super)) {
+	if (btrfs_check_super_csum(fs_info, disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
 		btrfs_release_disk_super(disk_super);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0a77948bb703..70f420044fd5 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -42,6 +42,8 @@ struct extent_buffer *btrfs_find_create_tree_block(
 void btrfs_clean_tree_block(struct extent_buffer *buf);
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
+int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
+			   struct btrfs_super_block *disk_sb);
 int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 688f7704d3fd..390242aac407 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2555,6 +2555,7 @@ static int check_dev_super(struct btrfs_device *dev)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
 	struct btrfs_super_block *sb;
+	u16 csum_type;
 	int ret = 0;
 
 	/* This should be called with fs still frozen. */
@@ -2569,6 +2570,21 @@ static int check_dev_super(struct btrfs_device *dev)
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
+	/* Verify the csum. */
+	csum_type = btrfs_super_csum_type(sb);
+	if (csum_type != btrfs_super_csum_type(fs_info->super_copy)) {
+		btrfs_err(fs_info, "csum type changed, has %u expect %u",
+			  csum_type, btrfs_super_csum_type(fs_info->super_copy));
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	if (btrfs_check_super_csum(fs_info, sb)) {
+		btrfs_err(fs_info, "csum for on-disk super block no longer matches");
+		ret = -EUCLEAN;
+		goto out;
+	}
+
 	/* Btrfs_validate_super() includes fsid check against super->fsid. */
 	ret = btrfs_validate_super(fs_info, sb, 0);
 	if (ret < 0)
-- 
2.38.0

