Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35E5454E6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbhKQUXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240682AbhKQUXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:16 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D1C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l8so3879513qtk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31OBZqgxa9l00VrefdLfSm02IqlsQlTwMAg8qYGjpSs=;
        b=WcRAb9uM/eTratyqcgarj7Vm90KkhyKYKA1X0tGva41FaUJZLHcfjm9rXsSicW0DXX
         qRhv9XZB4ccu5b1z5ab5ICLkZJgVhPOu3pb6w5IWPV0foMZ5k1r0e98kiMdq2Wroh7jy
         4D756qWl6ydUmVV/4WJJFmbzJgFHjgRrZ/f7HIf7SxDphyE/gXRVA1294d/7plu1xYG1
         6WyTABcl1zPTfThJLEJmJX4CtH3VayducZLUk4e9QkIaTu+LCucTVt+8FHlg1q4Z3+PD
         XQz8bHsmg2TGsd7riP5O7Ap75RpzsxiOPBawgHo0jE1vDhbysd3H3za1utL4ph5jxU0x
         cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31OBZqgxa9l00VrefdLfSm02IqlsQlTwMAg8qYGjpSs=;
        b=6szn6eYVbPtGqoYjwXeYSNNhu4s2m2M+I2ipe17FiOd2jC9gAwzmBSqoboIp3ivZzT
         dKsyBEKBLynOhMUGP6Y1EapEeNP9U5ANkl5weXJtsg2inOW2WyVuFPfEOuzZM06jlvIg
         vX4ayYHj3/LSYTkQ4WQhXcu3EFfxKFbpC4l3X+5Cf8pCv/hcc80kLfLfVd6vM49V+ukd
         QV6TGd/VRsQGY3P/C1PwJyf73UIG4sVH2YVjqEFrfQavB21ezBY7H/MB0Bu2QRy1waD7
         rUEcR1PDNmPvEjps3ieNSC1UNdDeFgSrG8iQS6mDTDdJ4sFc+r6hl+uVJO+ys9pKmnU7
         8B+Q==
X-Gm-Message-State: AOAM531+Dqo55E5TymtGox4doLJwIRmHRC6k1SW7QqBo3BP6x0aIYM8U
        u8CFb5vaLMekRFLemSNaggGwtUgMbfoCvQ==
X-Google-Smtp-Source: ABdhPJzhCvbdAHOGM1//9DphKYXxVsGQGdTDvdaDOEKYEhQt5I7Z4hAqzJDDRPoKZpEybzP1OzL/pA==
X-Received: by 2002:a05:622a:3c9:: with SMTP id k9mr20141567qtx.42.1637180415803;
        Wed, 17 Nov 2021 12:20:15 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:15 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 16/17] btrfs: send: send compressed extents with encoded writes
Date:   Wed, 17 Nov 2021 12:19:26 -0800
Message-Id: <56cc5e7ef33c02e0e0cf5f2a4b9f8534178bda2a.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that all of the pieces are in place, we can use the ENCODED_WRITE
command to send compressed extents when appropriate.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   4 +
 fs/btrfs/inode.c |  10 +-
 fs/btrfs/send.c  | 234 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 225 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 98defa9cce0e..af1bb06f9ca0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3275,6 +3275,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate);
+int btrfs_encoded_io_compression_from_extent(int compress_type);
+int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 file_offset,
+					  u64 disk_bytenr, u64 disk_io_size,
+					  struct page **pages);
 struct btrfs_ioctl_encoded_io_args;
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			   struct btrfs_ioctl_encoded_io_args *encoded);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6919dc170c93..92e1dea7af9a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10527,7 +10527,7 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 	}
 }
 
-static int btrfs_encoded_io_compression_from_extent(int compress_type)
+int btrfs_encoded_io_compression_from_extent(int compress_type)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
@@ -10731,11 +10731,9 @@ static void btrfs_encoded_read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-static int btrfs_encoded_read_regular_fill_pages(struct inode *inode,
-						 u64 file_offset,
-						 u64 disk_bytenr,
-						 u64 disk_io_size,
-						 struct page **pages)
+int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 file_offset,
+					  u64 disk_bytenr, u64 disk_io_size,
+					  struct page **pages)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_encoded_read_private priv = {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8493335ef47a..7a6a23a63950 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -609,6 +609,7 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 		return tlv_put(sctx, attr, &__tmp, sizeof(__tmp));	\
 	}
 
+TLV_PUT_DEFINE_INT(32)
 TLV_PUT_DEFINE_INT(64)
 
 static int tlv_put_string(struct send_ctx *sctx, u16 attr,
@@ -5205,16 +5206,215 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	return ret;
 }
 
-static int send_extent_data(struct send_ctx *sctx,
-			    const u64 offset,
-			    const u64 len)
+static int send_encoded_inline_extent(struct send_ctx *sctx,
+				      struct btrfs_path *path, u64 offset,
+				      u64 len)
 {
+	struct btrfs_root *root = sctx->send_root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *inode;
+	struct fs_path *p;
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_key key;
+	struct btrfs_file_extent_item *ei;
+	u64 ram_bytes;
+	size_t inline_size;
+	int ret;
+
+	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	p = fs_path_alloc();
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
+	if (ret < 0)
+		goto out;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	if (ret < 0)
+		goto out;
+
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+	ei = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
+	inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
+		    min(key.offset + ram_bytes - offset, len));
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, ram_bytes);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET, offset - key.offset);
+	ret = btrfs_encoded_io_compression_from_extent(
+				btrfs_file_extent_compression(leaf, ei));
+	if (ret < 0)
+		goto out;
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
+
+	ret = put_data_header(sctx, inline_size);
+	if (ret < 0)
+		goto out;
+	read_extent_buffer(leaf, sctx->send_buf + sctx->send_size,
+			   btrfs_file_extent_inline_start(ei), inline_size);
+	sctx->send_size += inline_size;
+
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	iput(inode);
+	return ret;
+}
+
+static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
+			       u64 offset, u64 len)
+{
+	struct btrfs_root *root = sctx->send_root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *inode;
+	struct fs_path *p;
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_key key;
+	struct btrfs_file_extent_item *ei;
+	u64 disk_bytenr, disk_num_bytes;
+	u32 data_offset;
+	struct btrfs_cmd_header *hdr;
+	u32 crc;
+	int ret;
+
+	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	p = fs_path_alloc();
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
+	if (ret < 0)
+		goto out;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	if (ret < 0)
+		goto out;
+
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+	ei = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+	disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, ei);
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
+		    min(key.offset + btrfs_file_extent_num_bytes(leaf, ei) - offset,
+			len));
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN,
+		    btrfs_file_extent_ram_bytes(leaf, ei));
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
+		    offset - key.offset + btrfs_file_extent_offset(leaf, ei));
+	ret = btrfs_encoded_io_compression_from_extent(
+				btrfs_file_extent_compression(leaf, ei));
+	if (ret < 0)
+		goto out;
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_ENCRYPTION, 0);
+
+	ret = put_data_header(sctx, disk_num_bytes);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * We want to do I/O directly into the send buffer, so get the next page
+	 * boundary in the send buffer. This means that there may be a gap
+	 * between the beginning of the command and the file data.
+	 */
+	data_offset = ALIGN(sctx->send_size, PAGE_SIZE);
+	if (data_offset > sctx->send_max_size ||
+	    sctx->send_max_size - data_offset < disk_num_bytes) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+
+	/*
+	 * Note that send_buf is a mapping of send_buf_pages, so this is really
+	 * reading into send_buf.
+	 */
+	ret = btrfs_encoded_read_regular_fill_pages(inode, offset, disk_bytenr,
+						    disk_num_bytes,
+						    sctx->send_buf_pages +
+						    (data_offset >> PAGE_SHIFT));
+	if (ret)
+		goto out;
+
+	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
+	hdr->len = cpu_to_le32(sctx->send_size + disk_num_bytes - sizeof(*hdr));
+	hdr->crc = 0;
+	crc = btrfs_crc32c(0, sctx->send_buf, sctx->send_size);
+	crc = btrfs_crc32c(crc, sctx->send_buf + data_offset, disk_num_bytes);
+	hdr->crc = cpu_to_le32(crc);
+
+	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
+			&sctx->send_off);
+	if (!ret) {
+		ret = write_buf(sctx->send_filp, sctx->send_buf + data_offset,
+				disk_num_bytes, &sctx->send_off);
+	}
+	sctx->send_size = 0;
+	sctx->put_data = false;
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	iput(inode);
+	return ret;
+}
+
+static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
+			    const u64 offset, const u64 len)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_file_extent_item *ei;
 	u64 read_size = max_send_read_size(sctx);
 	u64 sent = 0;
 
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, len);
 
+	ei = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	if ((sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	    btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
+		bool is_inline = (btrfs_file_extent_type(leaf, ei) ==
+				  BTRFS_FILE_EXTENT_INLINE);
+
+		/*
+		 * Send the compressed extent unless the compressed data is
+		 * larger than the decompressed data. This can happen if we're
+		 * not sending the entire extent, either because it has been
+		 * partially overwritten/truncated or because this is a part of
+		 * the extent that we couldn't clone in clone_range().
+		 */
+		if (is_inline &&
+		    btrfs_file_extent_inline_item_len(leaf,
+						      path->slots[0]) <= len) {
+			return send_encoded_inline_extent(sctx, path, offset,
+							  len);
+		} else if (!is_inline &&
+			   btrfs_file_extent_disk_num_bytes(leaf, ei) <= len) {
+			return send_encoded_extent(sctx, path, offset, len);
+		}
+	}
+
 	while (sent < len) {
 		u64 size = min(len - sent, read_size);
 		int ret;
@@ -5285,12 +5485,9 @@ static int send_capabilities(struct send_ctx *sctx)
 	return ret;
 }
 
-static int clone_range(struct send_ctx *sctx,
-		       struct clone_root *clone_root,
-		       const u64 disk_byte,
-		       u64 data_offset,
-		       u64 offset,
-		       u64 len)
+static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
+		       struct clone_root *clone_root, const u64 disk_byte,
+		       u64 data_offset, u64 offset, u64 len)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -5314,7 +5511,7 @@ static int clone_range(struct send_ctx *sctx,
 	 */
 	if (clone_root->offset == 0 &&
 	    len == sctx->send_root->fs_info->sectorsize)
-		return send_extent_data(sctx, offset, len);
+		return send_extent_data(sctx, dst_path, offset, len);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -5411,7 +5608,8 @@ static int clone_range(struct send_ctx *sctx,
 
 			if (hole_len > len)
 				hole_len = len;
-			ret = send_extent_data(sctx, offset, hole_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       hole_len);
 			if (ret < 0)
 				goto out;
 
@@ -5484,14 +5682,16 @@ static int clone_range(struct send_ctx *sctx,
 					if (ret < 0)
 						goto out;
 				}
-				ret = send_extent_data(sctx, offset + slen,
+				ret = send_extent_data(sctx, dst_path,
+						       offset + slen,
 						       clone_len - slen);
 			} else {
 				ret = send_clone(sctx, offset, clone_len,
 						 clone_root);
 			}
 		} else {
-			ret = send_extent_data(sctx, offset, clone_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       clone_len);
 		}
 
 		if (ret < 0)
@@ -5523,7 +5723,7 @@ static int clone_range(struct send_ctx *sctx,
 	}
 
 	if (len > 0)
-		ret = send_extent_data(sctx, offset, len);
+		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
 out:
@@ -5554,10 +5754,10 @@ static int send_write_or_clone(struct send_ctx *sctx,
 				    struct btrfs_file_extent_item);
 		disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
 		data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
-		ret = clone_range(sctx, clone_root, disk_byte, data_offset,
-				  offset, end - offset);
+		ret = clone_range(sctx, path, clone_root, disk_byte,
+				  data_offset, offset, end - offset);
 	} else {
-		ret = send_extent_data(sctx, offset, end - offset);
+		ret = send_extent_data(sctx, path, offset, end - offset);
 	}
 	sctx->cur_inode_next_write_offset = end;
 	return ret;
-- 
2.34.0

