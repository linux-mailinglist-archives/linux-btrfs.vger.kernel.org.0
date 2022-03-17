Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE44DCC69
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiCQR1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiCQR13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5D114FC1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so3158053pgg.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jxmnUqzbF2hZh7PkiPw555y1MidL2Q1O9KnbDhHysc=;
        b=VCYR5uC7RDWnXMn0SZS82K9g4jiaxcBW7f8HzSzFYB251wYQ9dfgJzeAd3gsqb2mU1
         MX0ffTa3YOwF3k7x1AXa1r5WCdkIprFAZJJkb9buFCA+85Qq2MJzixnDPf1IF95x+FJ7
         nr3eFafwwXxpOKIhaP6hBol1FPH0qQSuQ09f24zumvXB6fcidespU8igo+zWOhj8XnTw
         wZBFoQBe5WmxrnoPGT8a5R9fOgDFDQXKRlLU5ueqBpI5qeaiEIxrXpIb9Ie6vsEE+8vL
         gro3QjX/gpCespRHNAQ2PFHQJIXP1ZsD//ef6QXziVFWPaYm5VcAUe8qsEW/ic4diPsI
         TsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jxmnUqzbF2hZh7PkiPw555y1MidL2Q1O9KnbDhHysc=;
        b=gosza+8I+Fe0cykm0F0z7ViqdpZRyRsOsqWYUkIVs3lp6U3iGIun75XmMbPCKnZFFD
         3nLWQuq+fNn6QIyyA/F0hDncA95cVhh2q3Cy+wdT47VD46GZTkxHzGIHYeq3ILdDkYQl
         eODtJBTQIT3L5uBr1gc5D5sUSiq1/1nqtXyxIi50cgG0KedCMqZrWJWFpcznVF6Wpw8i
         sOViLKfCg5+P9iwVHUcKlG0OS0dk0IdX0NJtGBn1dJADVloDlUepA1breqoVARZejDGi
         52JuUJzydecL/7+ENZNjZeRNJF+tOoZYZlzIDDbIcIe3qjOHJ81JGj7WN4b5JG82zZ3j
         T/gg==
X-Gm-Message-State: AOAM5337rCBPUIAk6w2ribmiV0yfUnxNyENMW20IFmUh0ClIZPztQ0jO
        SjShzvG3sOnEyZOm/BfcQSVYtOzXUhEzgA==
X-Google-Smtp-Source: ABdhPJzd2M9BBjGyAHcPw3uC8/77NhDq0R6DPxVO4dQfjIbqhqjlVXyYZ7pp4hV/1GNIA76drMTdqw==
X-Received: by 2002:aa7:968b:0:b0:4f6:fa51:c239 with SMTP id f11-20020aa7968b000000b004f6fa51c239mr5537258pfk.48.1647537971969;
        Thu, 17 Mar 2022 10:26:11 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:11 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 6/7] btrfs: send: send compressed extents with encoded writes
Date:   Thu, 17 Mar 2022 10:25:42 -0700
Message-Id: <be245954897c8dbbf8351753b61718df9b53b5c0.1647537027.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that all of the pieces are in place, we can use the ENCODED_WRITE
command to send compressed extents when appropriate.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   6 ++
 fs/btrfs/inode.c |  13 +--
 fs/btrfs/send.c  | 234 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 228 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 09b7b0b2d016..92bfee5b3ded 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3355,6 +3355,12 @@ int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate);
+int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
+					     int compress_type);
+int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
+					  u64 file_offset, u64 disk_bytenr,
+					  u64 disk_io_size,
+					  struct page **pages);
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			   struct btrfs_ioctl_encoded_io_args *encoded);
 ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78a5145353e1..6b8c0f026545 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10114,9 +10114,8 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 	}
 }
 
-static int btrfs_encoded_io_compression_from_extent(
-				struct btrfs_fs_info *fs_info,
-				int compress_type)
+int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
+					     int compress_type)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
@@ -10321,11 +10320,9 @@ static void btrfs_encoded_read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-static int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
-						 u64 file_offset,
-						 u64 disk_bytenr,
-						 u64 disk_io_size,
-						 struct page **pages)
+int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
+					  u64 file_offset, u64 disk_bytenr,
+					  u64 disk_io_size, struct page **pages)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ac2a1297027a..b0560be3053b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -614,6 +614,7 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 		return tlv_put(sctx, attr, &__tmp, sizeof(__tmp));	\
 	}
 
+TLV_PUT_DEFINE_INT(32)
 TLV_PUT_DEFINE_INT(64)
 
 static int tlv_put_string(struct send_ctx *sctx, u16 attr,
@@ -5160,16 +5161,215 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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
+	ret = btrfs_encoded_io_compression_from_extent(fs_info,
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
+	ret = btrfs_encoded_io_compression_from_extent(fs_info,
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
+	ret = btrfs_encoded_read_regular_fill_pages(BTRFS_I(inode), offset,
+						    disk_bytenr, disk_num_bytes,
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
@@ -5240,12 +5440,9 @@ static int send_capabilities(struct send_ctx *sctx)
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
@@ -5269,7 +5466,7 @@ static int clone_range(struct send_ctx *sctx,
 	 */
 	if (clone_root->offset == 0 &&
 	    len == sctx->send_root->fs_info->sectorsize)
-		return send_extent_data(sctx, offset, len);
+		return send_extent_data(sctx, dst_path, offset, len);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -5366,7 +5563,8 @@ static int clone_range(struct send_ctx *sctx,
 
 			if (hole_len > len)
 				hole_len = len;
-			ret = send_extent_data(sctx, offset, hole_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       hole_len);
 			if (ret < 0)
 				goto out;
 
@@ -5439,14 +5637,16 @@ static int clone_range(struct send_ctx *sctx,
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
@@ -5478,7 +5678,7 @@ static int clone_range(struct send_ctx *sctx,
 	}
 
 	if (len > 0)
-		ret = send_extent_data(sctx, offset, len);
+		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
 out:
@@ -5509,10 +5709,10 @@ static int send_write_or_clone(struct send_ctx *sctx,
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
2.35.1

