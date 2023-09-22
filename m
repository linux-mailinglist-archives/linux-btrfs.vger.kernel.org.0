Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B37AA72A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 04:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjIVCzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 22:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjIVCzw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 22:55:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99C8194
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 19:55:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A15172208F
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695351344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3IuyVpRrH+AUs1Fk08kB6Y60wHMZJ9kwB22C6Dqfh0=;
        b=FrjiiKXAs8b+Y4+cpTPew6Bzbi1Ig54StXMMJJA3i0duO8j+pGuMMIWMw5J3xMq94IxH91
        RgxlHHDxMhevzxTj6dlpVk+jnXmSkZ1wQcMVHhtUX+I1inNwLCMWmIiIASxNJnfBxIG4+Z
        ugV+Wi9BwmTw73yfJlvuj5OR+kCpzw0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C542813438
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6BGRHy8CDWV6LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: introduce "abort=data" mount option
Date:   Fri, 22 Sep 2023 12:25:21 +0930
Message-ID: <c69e93db7675afc99a4a7f543125d45bff06141e.1695350405.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695350405.git.wqu@suse.com>
References: <cover.1695350405.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if btrfs fails to write data blocks, it will not really cause
a great damage, but mostly -EIO for involved writeback functions like
fsync() or direct io for that inode.

Normally it's not a big deal, but it can be an indicator of a bigger
problem.

Thus here we introduce the new "abort=data" mount option to be
noisy and mark the whole filesystem read-only as an early warning.

This behavior covers buffered, direct writes.

Please note that, it only counts as an write error if the write to all
mirrors failed.
E.g. if data write into a RAID1 data chunk only failed for one mirror,
it will not be accounted as an write error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  8 +++++++-
 fs/btrfs/fs.h        |  1 +
 fs/btrfs/inode.c     |  9 ++++++++-
 fs/btrfs/super.c     | 10 ++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5e5852a4ffb5..d38b01412615 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -483,8 +483,14 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 				   bvec->bv_offset, bvec->bv_len);
 
 		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error);
-		if (error)
+		if (error) {
 			mapping_set_error(page->mapping, error);
+			if (btrfs_test_opt(fs_info, ABORT_DATA))
+				btrfs_handle_fs_error(fs_info, -EIO,
+		"data write back failed, root %lld ino %llu fileoff %llu",
+					BTRFS_I(inode)->root->root_key.objectid,
+					btrfs_ino(BTRFS_I(inode)), start);
+		}
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 	}
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4fc0afcf1ef2..65bfe7e60b03 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -189,6 +189,7 @@ enum {
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1ULL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1ULL << 29),
 	BTRFS_MOUNT_ABORT_SUPER			= (1ULL << 30),
+	BTRFS_MOUNT_ABORT_DATA			= (1ULL << 31),
 };
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 514d2e8a4f52..20b1628b090a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7703,13 +7703,20 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 
 	if (bio->bi_status) {
-		btrfs_warn(inode->root->fs_info,
+		btrfs_warn(fs_info,
 		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
 			   btrfs_ino(inode), bio->bi_opf,
 			   dip->file_offset, dip->bytes, bio->bi_status);
+		if (btrfs_test_opt(fs_info, ABORT_DATA))
+			btrfs_handle_fs_error(fs_info, -EIO,
+		"direct IO data write back failed, root %lld ino %llu fileoff %llu len %u",
+				inode->root->root_key.objectid,
+				btrfs_ino(inode), dip->file_offset,
+				dip->bytes);
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 41ab8c6e3fab..fb509507fb64 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -128,6 +128,7 @@ enum {
 	/* Extra abort options. */
 	Opt_abort,
 	Opt_abort_super,
+	Opt_abort_data,
 	Opt_abort_all,
 
 	/* Deprecated options */
@@ -233,6 +234,7 @@ static const match_table_t rescue_tokens = {
 
 static const match_table_t abort_tokens = {
 	{Opt_abort_super, "super"},
+	{Opt_abort_data, "data"},
 	{Opt_abort_all, "all"},
 	{Opt_err, NULL},
 };
@@ -272,10 +274,16 @@ static int parse_abort_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, ABORT_SUPER,
 				"will abort if any super block write back failed");
 			break;
+		case Opt_abort_data:
+			btrfs_set_and_info(info, ABORT_DATA,
+				"will abort if any data write back failed");
+			break;
 		case Opt_abort_all:
 			btrfs_info(info, "enabling all abort options");
 			btrfs_set_and_info(info, ABORT_SUPER,
 				"will abort if any super block write back failed");
+			btrfs_set_and_info(info, ABORT_DATA,
+				"will abort if any data write back failed");
 			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized abort option '%s'", p);
@@ -1310,6 +1318,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		print_rescue_option(seq, "ignoredatacsums", &rescue_printed);
 	if (btrfs_test_opt(info, ABORT_SUPER))
 		print_abort_option(seq, "super", &abort_printed);
+	if (btrfs_test_opt(info, ABORT_DATA))
+		print_abort_option(seq, "data", &abort_printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.42.0

