Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37677185E35
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgCOPcd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:32:33 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:56052 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728634AbgCOPcd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:32:33 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id DV7lj4MqSjfNYDV7mjCbni; Sun, 15 Mar 2020 16:24:22 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584285862; bh=R7mK5xKAq9CEjxlXIZqYmoBSfGAqBOtlj86nkg8n6U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hwEAH6f+BvrrCnEy/zidqbzUIyeDcGj3Mf3WUBBdw+tjjIhgheQeB6WmkxsdWXj8s
         AGDOaGv9HPtBhMC/Wj9MXbmOWwY2S2DYgVVxU75+kAb9dqgamDNk/lkwXwiMwRu9oy
         VddRsGmTUC2IPuZ2zMnLRzXOTV7rDXDHXAkNTyl13LvYup+J4Z4k2zllR9k+ixgUwa
         YWGiEDcRfAZsT6o/yrj9cpB2VTMAUGVSSOVoBoFAAydvnJf3B0CQRpQ+jZVPjh1XiC
         9UldUTm5xhMfI35ykgZ4aTv3026Bf7Y4lYqbAmtab28AJwYG9uHwUnxOzvNdSL+HBR
         EmHY+NcbLpbsg==
X-CNFS-Analysis: v=2.3 cv=BYemLYl2 c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=mwD9OnHuRjznPdVJ0v8A:9
 a=jeuyuHA8FLxcBA3v:21 a=pfrotQ26mklwY9pn:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
Date:   Sun, 15 Mar 2020 16:24:18 +0100
Message-Id: <20200315152418.7784-2-kreijack@libero.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315152418.7784-1-kreijack@libero.it>
References: <20200315152418.7784-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOmr431hnNfw2d4Mp+/zDV2+OjHLiih1/fGC8se8wcCU4zSTGtx33NwK7tsPnHoIyuDpQTWeMKW609Y3GXqVAwi3chVyWfSPc9Ho2G+UyoQfsXgAzACp
 XJ2LXjhbP7zI0+4H+zKkydJk15p2av+oWbWRPN/YwnENhyo8MFbAMXAf9M31CvsanJs7kQIYzSEaPEbPnenVycyh4tCkdIOjFxRaMeGm3dlkEylMVr3xmVxB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add a new ioctl to get info about chunk without requiring the root privileges.
This allow to a non root user to know how the space of the filesystem is
allocated.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ioctl.c           | 215 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  38 +++++++
 2 files changed, 253 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 173758d86feb..fbe8c86f0de6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2282,6 +2282,219 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	return ret;
 }
 
+/*
+ * Return:
+ *	0		-> copied all data, possible further data
+ *	1		-> copied all data, no further data
+ *	-EAGAIN		-> not enough space, restart it
+ *	-EFAULT		-> the user passed an invalid address/size pair
+ */
+static noinline int copy_chunk_info(struct btrfs_path *path,
+			       char __user *ubuf,
+			       size_t buf_size,
+			       u64 *used_buf,
+			       int *num_found,
+			       u64 *offset)
+{
+	struct extent_buffer *leaf;
+	unsigned long item_off;
+	unsigned long item_len;
+	int nritems;
+	int i;
+	int slot;
+	int ret = 0;
+	struct btrfs_key key;
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	nritems = btrfs_header_nritems(leaf);
+
+	for (i = slot; i < nritems; i++) {
+		u64 destsize;
+		struct btrfs_chunk_info ci;
+		struct btrfs_chunk chunk;
+		int j, chunk_size;
+
+		item_off = btrfs_item_ptr_offset(leaf, i);
+		item_len = btrfs_item_size_nr(leaf, i);
+
+		btrfs_item_key_to_cpu(leaf, &key, i);
+		/*
+		 * we are not interested in other items type
+		 */
+		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * In any case, the next search must start from here
+		 */
+		*offset = key.offset;
+		read_extent_buffer(leaf, &chunk, item_off, sizeof(chunk));
+
+		/*
+		 * chunk.num_stripes-1 is correct, because btrfs_chunk includes
+		 * already a stripe
+		 */
+		destsize = sizeof(struct btrfs_chunk_info) +
+			(chunk.num_stripes - 1) * sizeof(struct btrfs_stripe);
+
+		BUG_ON(destsize > item_len);
+
+		if (buf_size < destsize + *used_buf) {
+			if (*num_found)
+				/* try onother time */
+				ret = -EAGAIN;
+			else
+				/* in any case the buffer is too small */
+				ret = -EOVERFLOW;
+			goto out;
+		}
+
+		/* copy chunk */
+		chunk_size = offsetof(struct btrfs_chunk_info, stripes);
+		memset(&ci, 0, chunk_size);
+		ci.length = btrfs_stack_chunk_length(&chunk);
+		ci.stripe_len = btrfs_stack_chunk_stripe_len(&chunk);
+		ci.type = btrfs_stack_chunk_type(&chunk);
+		ci.num_stripes = btrfs_stack_chunk_num_stripes(&chunk);
+		ci.sub_stripes = btrfs_stack_chunk_sub_stripes(&chunk);
+		ci.offset = key.offset;
+
+		if (copy_to_user(ubuf + *used_buf, &ci, chunk_size)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		*used_buf += chunk_size;
+
+		/* copy stripes */
+		for (j = 0 ; j < chunk.num_stripes ; j++) {
+			struct btrfs_stripe chunk_stripe;
+			struct btrfs_chunk_info_stripe csi;
+
+			/*
+			 * j-1 is correct, because btrfs_chunk includes already
+			 * a stripe
+			 */
+			read_extent_buffer(leaf, &chunk_stripe,
+					item_off + sizeof(struct btrfs_chunk) +
+						sizeof(struct btrfs_stripe) *
+						(j - 1), sizeof(chunk_stripe));
+
+			memset(&csi, 0, sizeof(csi));
+
+			csi.devid = btrfs_stack_stripe_devid(&chunk_stripe);
+			csi.offset = btrfs_stack_stripe_offset(&chunk_stripe);
+			memcpy(csi.dev_uuid, chunk_stripe.dev_uuid,
+				sizeof(chunk_stripe.dev_uuid));
+			if (copy_to_user(ubuf + *used_buf, &csi, sizeof(csi))) {
+				ret = -EFAULT;
+				goto out;
+			}
+			*used_buf += sizeof(csi);
+		}
+
+		++(*num_found);
+	}
+
+	ret = 0;
+	if (*offset < (u64)-1)
+		++(*offset);
+out:
+	return ret;
+}
+
+static noinline int search_chunk_info(struct inode *inode, u64 *offset,
+				      int *items_count,
+				      char __user *ubuf, u64 buf_size)
+{
+	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root;
+	struct btrfs_key key;
+	struct btrfs_path *path;
+	int ret;
+	u64 used_buf = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/* search for BTRFS_CHUNK_TREE_OBJECTID tree */
+	key.objectid = BTRFS_CHUNK_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	root = btrfs_read_fs_root_no_name(info, &key);
+	if (IS_ERR(root)) {
+		btrfs_err(info, "could not find root\n");
+		btrfs_free_path(path);
+		return -ENOENT;
+	}
+
+
+	while (used_buf < buf_size) {
+		key.objectid = 0x0100;
+		key.type = BTRFS_CHUNK_ITEM_KEY;
+		key.offset = *offset;
+
+		ret = btrfs_search_forward(root, &key, path, 0);
+		if (ret != 0) {
+			if (ret > 0)
+				ret = 0;
+			goto ret;
+		}
+
+		ret = copy_chunk_info(path, ubuf, buf_size,
+				      &used_buf, items_count, offset);
+
+		btrfs_release_path(path);
+		if (ret)
+			break;
+
+	}
+
+ret:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static noinline int btrfs_ioctl_get_chunk_info(struct file *file,
+					       void __user *argp)
+{
+	struct btrfs_ioctl_chunk_info arg;
+	struct inode *inode;
+	int ret;
+	size_t buf_size;
+	u64 data_offset;
+	const size_t buf_limit = SZ_16M;
+
+
+	data_offset = sizeof(struct btrfs_ioctl_chunk_info);
+	inode = file_inode(file);
+
+	if (copy_from_user(&arg, argp, sizeof(arg)))
+		return -EFAULT;
+
+	buf_size = arg.buf_size;
+	arg.items_count = 0;
+
+	if (buf_size < sizeof(struct btrfs_ioctl_chunk_info) +
+			sizeof(struct btrfs_chunk_info))
+		return -EOVERFLOW;
+
+	/* limit result size to 16MB */
+	if (buf_size > buf_limit)
+		buf_size = buf_limit;
+
+	ret = search_chunk_info(inode, &arg.offset, &arg.items_count,
+			argp + data_offset, buf_size - data_offset);
+
+	if (copy_to_user(argp, &arg, data_offset))
+		return -EFAULT;
+
+	return ret;
+}
+
 /*
  * Search INODE_REFs to identify path name of 'dirid' directory
  * in a 'tree_id' tree. and sets path name to 'name'.
@@ -5581,6 +5794,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_GET_CHUNK_INFO:
+		return btrfs_ioctl_get_chunk_info(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..a66a4532d3e4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -713,6 +713,42 @@ struct btrfs_ioctl_received_subvol_args {
 	__u64	reserved[16];		/* in */
 };
 
+struct btrfs_chunk_info_stripe {
+	__u64 devid;
+	__u64 offset;
+	__u8 dev_uuid[BTRFS_UUID_SIZE];
+};
+
+struct btrfs_chunk_info {
+	/* logical start of this chunk */
+	__u64 offset;
+	/* size of this chunk in bytes */
+	__u64 length;
+
+	__u64 stripe_len;
+	__u64 type;
+
+	/* 2^16 stripes is quite a lot, a second limit is the size of a single
+	 * item in the btree
+	 */
+	__u16 num_stripes;
+
+	/* sub stripes only matter for raid10 */
+	__u16 sub_stripes;
+
+	struct btrfs_chunk_info_stripe stripes[1];
+	/* additional stripes go here */
+};
+
+
+struct btrfs_ioctl_chunk_info {
+	u64			offset;		/* offset to start the search */
+	u32			buf_size;	/* size of the buffer, including
+						 * btrfs_ioctl_chunk_info
+						 */
+	u32			items_count;	/* number of items returned */
+};
+
 /*
  * Caller doesn't want file data in the send stream, even if the
  * search of clone sources doesn't find an extent. UPDATE_EXTENT
@@ -949,5 +985,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_GET_CHUNK_INFO _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_chunk_info)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.25.1

