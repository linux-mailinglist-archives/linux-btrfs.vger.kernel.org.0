Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6D18C18C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 21:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCSUja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 16:39:30 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:54898 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgCSUja (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 16:39:30 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id F1wsjltlljfNYF1wtjhZ9L; Thu, 19 Mar 2020 21:39:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584650367; bh=XmVeGuRBT3ntRZr884x2JNb/Fv1SY02J2TEeJLU3J58=;
        h=From;
        b=IqKcVoiral09otoYuUsR+2PfAJBMUSJuRPF+NkKJzsyOZKluqgZhIG8gCBQ7tYDFT
         X7dqHcxEuyjB3htgFEs4UArk6TG4SG7zoXnFMNp6dNPnOnLt+ZAgDb+DQ389vwSNrA
         iXK/aoPi5CcIs7zw+Fpla1DljGSwebHlacTzZNATAf86ALYrX5AetLvKbUFMel5u6A
         lONU5Hxf/KagB+TuPputbCI7XP61/nbeURW9DaK/cmrS1lGbOLKGRslSqkBRhhREgX
         FgFwpxqSl86MyNoO7SlHgkt7dwlhNOtOQ0CA6k1fUxq+V9bjYc9yHPS/1XVTWwsrDU
         KEoI22NlxN1cw==
X-CNFS-Analysis: v=2.3 cv=IdH5plia c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=mwD9OnHuRjznPdVJ0v8A:9
 a=vXTt2OoVL83piRPc:21 a=tSWzs-S1f0lVpk_m:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
Date:   Thu, 19 Mar 2020 21:39:13 +0100
Message-Id: <20200319203913.3103-2-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200319203913.3103-1-kreijack@libero.it>
References: <20200319203913.3103-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP6Dkv1tdDxES8nKEqlWrkYgg0piWpakYdQ9WmSX0QyfUPLS50/2wQ4n/SkR6LVI3h0wuZ/yy9UQ4FgIUNjRWwEGe9Pkq/qqfk0Vb9vBggEKgOboWDYu
 cqLMaY5yZJ9r0CJKcyOsdpmnM7b5nhWrwm1rvzxykwVTsafixbsd5ND3BJgN5tUpqyegLdy8DGeFnI+L7cKCXpf6KVjTW2kwitic+BKNrWxTiV+1ys/QrPyi
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add a new ioctl to get info about chunk without requiring the root
privileges. This allow to a non root user to know how the space of the
filesystem is allocated.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  38 +++++++
 2 files changed, 249 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..b3296a479bf6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	return ret;
 }
 
+/*
+ * Return:
+ *	1		-> copied all data, possible further data
+ *	0		-> copied all data, no further data
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
+		if (key.type != BTRFS_CHUNK_ITEM_KEY)
+			return 0;
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
+		if (destsize > item_len) {
+			ASSERT(0);
+			return -EINVAL;
+		}
+
+		if (buf_size < destsize + *used_buf) {
+			if (*num_found)
+				/* try onother time */
+				return -EAGAIN;
+			else
+				/* in any case the buffer is too small */
+				return -EOVERFLOW;
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
+		if (copy_to_user(ubuf + *used_buf, &ci, chunk_size))
+			return -EFAULT;
+
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
+			if (copy_to_user(ubuf + *used_buf, &csi, sizeof(csi)))
+				return -EFAULT;
+
+			*used_buf += sizeof(csi);
+		}
+
+		++(*num_found);
+	}
+
+	if (*offset < (u64)-1)
+		++(*offset);
+
+	return 1;
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
+	int ret = -EAGAIN;
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
+	root = btrfs_get_fs_root(info, &key, true);
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
+
+		if (ret < 1)
+			break;
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
@@ -4907,6 +5116,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_GET_CHUNK_INFO:
+		return btrfs_ioctl_get_chunk_info(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 8134924cfc17..b28f7886dcbd 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -734,6 +734,42 @@ struct btrfs_ioctl_received_subvol_args {
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
@@ -972,5 +1008,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_GET_CHUNK_INFO _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_chunk_info)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.26.0.rc2

