Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB74B15EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbiBJTKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbiBJTKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9710BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso6498150pjh.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i08ylIvYePgvaN25EivFMBo8SJ6Co9ZswL+ivbeCEwI=;
        b=Jr8u/eyioRQhnFE9+I++va7uZodoAuV4CHHxlKDf/PTKpTLjfP7Um2xuI3oV/DGvMg
         EGaE3IfBA9tqIFeEPKl1jWol4K1jeHm8OBcJmF/rbIjZoN6S7OAXTPhKrILsggISwio8
         RehPj5408yCio971ZMv8Znc6MNiV5WHK55kzGPH4loJ88X8twSI2lc4MK28R8buz6L+n
         qkzOG7M8b6KcTVi8VY+QZxptVFMXYZZG4HsiJzm5WrEVsT0QmpptuHXIBlsH5rxRH6b+
         hSMwcYGVjcQPnqQqxxcaUwYVQZdOGDyxA3WzVxmGobgJKqPAO/8haB40ki9RawSM6FOi
         3zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i08ylIvYePgvaN25EivFMBo8SJ6Co9ZswL+ivbeCEwI=;
        b=6FnIKxdkFBiutCfEQgw+vMEcUFyWCj9TqoUXLjzYc8abrJ3q7DfB71YY4/HMloQ5NA
         puXRasBYZFRPVc1yM0h+i/znfaENL7C2dHkashWM8OtY9RAlEHGQTNEJLvnI6CIEz5LO
         cOjuT2U1/+zEMJZ8L6GbIjB9O4hU+5Z1aGlHjFB2MQtKfcjeZ6UEfcHngw8PQsBqSlW3
         kmmps5kUEVd3ifRNruwWuHGKsaSC6c95eGKfLrsropiDNKm4ej16rdaXQRs9+vvPrhYs
         /5/j9/21Glt3+No5k248FkJ0QJknR8YIQ9JzfOiyqMLi3+o3hqzdNu/eViUX/iqzlMjb
         Cc7w==
X-Gm-Message-State: AOAM5329WU/IdFTqyRAmaxY76dd0NSfXbz5BCyFJmOlgNuHTQGmN9iQR
        0J+oykFLLgsN/VVUvBRyiI8cVJviCJH35g==
X-Google-Smtp-Source: ABdhPJzqQ5jCvJJc/NRqogcfqLBltQZkD33xIeLvY0mq9uU1w9L0U1GeZcvRJzqCXX9tzgzdM5/29g==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr9033477pls.52.1644520244994;
        Thu, 10 Feb 2022 11:10:44 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:44 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 16/17] btrfs: send: send compressed extents with encoded writes
Date:   Thu, 10 Feb 2022 11:10:06 -0800
Message-Id: <640f9ffbfc6af75b782a4142f06723808cd5ebb5.1644519258.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
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
index 54f0bf10e885..a2da402163bf 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3295,6 +3295,12 @@ int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate);
+int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
+					     int compress_type);
+int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
+					  u64 file_offset, u64 disk_bytenr,
+					  u64 disk_io_size,
+					  struct page **pages);
 struct btrfs_ioctl_encoded_io_args;
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			   struct btrfs_ioctl_encoded_io_args *encoded);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c8c1a4bab06b..0dbf995dc75b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10133,9 +10133,8 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 	}
 }
 
-static int btrfs_encoded_io_compression_from_extent(
-						  struct btrfs_fs_info *fs_info,
-						  int compress_type)
+int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
+					     int compress_type)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
@@ -10342,11 +10341,9 @@ static void btrfs_encoded_read_endio(struct bio *bio)
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
index 2b0bb8b8f972..5192ba58459e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -614,6 +614,7 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 		return tlv_put(sctx, attr, &__tmp, sizeof(__tmp));	\
 	}
 
+TLV_PUT_DEFINE_INT(32)
 TLV_PUT_DEFINE_INT(64)
 
 static int tlv_put_string(struct send_ctx *sctx, u16 attr,
@@ -5234,16 +5235,215 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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
@@ -5314,12 +5514,9 @@ static int send_capabilities(struct send_ctx *sctx)
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
@@ -5343,7 +5540,7 @@ static int clone_range(struct send_ctx *sctx,
 	 */
 	if (clone_root->offset == 0 &&
 	    len == sctx->send_root->fs_info->sectorsize)
-		return send_extent_data(sctx, offset, len);
+		return send_extent_data(sctx, dst_path, offset, len);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -5440,7 +5637,8 @@ static int clone_range(struct send_ctx *sctx,
 
 			if (hole_len > len)
 				hole_len = len;
-			ret = send_extent_data(sctx, offset, hole_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       hole_len);
 			if (ret < 0)
 				goto out;
 
@@ -5513,14 +5711,16 @@ static int clone_range(struct send_ctx *sctx,
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
@@ -5552,7 +5752,7 @@ static int clone_range(struct send_ctx *sctx,
 	}
 
 	if (len > 0)
-		ret = send_extent_data(sctx, offset, len);
+		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
 out:
@@ -5583,10 +5783,10 @@ static int send_write_or_clone(struct send_ctx *sctx,
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

