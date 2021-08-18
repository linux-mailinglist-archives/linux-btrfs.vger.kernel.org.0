Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491A33EF997
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbhHREkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 00:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbhHREkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 00:40:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575CC061764
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 21:39:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a12so629568qtb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s42MlTEMvYSBXe8WEZE5d03pnb37YtmVJvaQ3SGB2t8=;
        b=QYXyZGv5BTEM2E1IwNmhyTnpPF/eFDhHMnxlLOPaA/K23lM7eolgvSN8nfKxjmH+mS
         4arQ++noJb04Rt/r1aKIHTE+oX6BrSlpOrfCiPaipNroxSD9GC/Jwe8Sdo8VQpYbRVIx
         WlPWV3igWZT74DHP6DrYFzLgxmRM2T3i8TBLxrd/SXfc6T6ywm3GldakavVK45ydLMt5
         sdn7Gg/eNuc2LvDHFRuCBQXxDvIHTHNSX0YmBGtt5QO4Q55U7wC+hkY0D+3eO7lFDLx1
         8cS+yQPvr5YJGurK4neq/RiK3VDDt+BBkbnhKa0hTb9HZLBCj5NqQNH9MWJnVrtQGn7Z
         BFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s42MlTEMvYSBXe8WEZE5d03pnb37YtmVJvaQ3SGB2t8=;
        b=ipPxQ3aqfIKq6h2I+fFDNiycGQDkc2e8ySqBdBmsP52GYN+dh2XiMrXKk42HNmPEjl
         CN+0AmALFiRCE7MGHjetesj0qz3hD5GPlnzF/B8M+vbp+DjAuK4iL/aMNwkeIFQnGicO
         pbZLKcI8G1Ohc+YOJKQS0Zs7CD1kP4jpoqsWaoxCEcbgbUlNV7tEn+r7PEueEeHCL1CN
         0pOavOp7a7hZnEcpsSnwQ5D47MzXxl0eE+lllE4OuziKMPNUng4nWce6JkOVV52Lybk0
         HjIZItnqmHpbGyUvDKoh6Yy7XfmuBIO/NIOcW5ZW2xV0gXtfWuBUh5Cx4yps2y07BFQL
         +gaA==
X-Gm-Message-State: AOAM5308QPTsM3EhzgWTkBz6oOpnpcigQq469nZg4P9mUNiczJ3PxFKv
        yEmfYAu8lRiRdPVapW6osf/15HFm60/EoA==
X-Google-Smtp-Source: ABdhPJzi9Td0hMcovA2EAGmW7dZncl9tcTVqEu40lkH1g1M557/l8kK4VJ9yQEAmu/cjk1pkIfVXRQ==
X-Received: by 2002:a05:622a:353:: with SMTP id r19mr6351174qtw.3.1629261565370;
        Tue, 17 Aug 2021 21:39:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q184sm3020277qkd.35.2021.08.17.21.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:39:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs-progs: add the ability to corrupt block group items
Date:   Wed, 18 Aug 2021 00:39:20 -0400
Message-Id: <53e30ee44fcfa086685418304ae4af1ec550c02b.1629261403.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629261403.git.josef@toxicpanda.com>
References: <cover.1629261403.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing the extent tree v2 stuff I noticed that fsck doesn't detect
an invalid ->used value on the block group item in the normal mode.  To
build a test case for this I need the ability to corrupt block group
items.  This allows us to corrupt the various fields of a block group.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c | 108 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 77bdc810..80622f29 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -348,6 +348,24 @@ enum btrfs_key_field {
 	BTRFS_KEY_BAD,
 };
 
+enum btrfs_block_group_field {
+	BTRFS_BLOCK_GROUP_ITEM_USED,
+	BTRFS_BLOCK_GROUP_ITEM_FLAGS,
+	BTRFS_BLOCK_GROUP_ITEM_CHUNK_OBJECTID,
+	BTRFS_BLOCK_GROUP_ITEM_BAD,
+};
+
+static enum btrfs_block_group_field convert_block_group_field(char *field)
+{
+	if (!strncmp(field, "used", FIELD_BUF_LEN))
+		return BTRFS_BLOCK_GROUP_ITEM_USED;
+	if (!strncmp(field, "flags", FIELD_BUF_LEN))
+		return BTRFS_BLOCK_GROUP_ITEM_FLAGS;
+	if (!strncmp(field, "chunk_objectid", FIELD_BUF_LEN))
+		return BTRFS_BLOCK_GROUP_ITEM_CHUNK_OBJECTID;
+	return BTRFS_BLOCK_GROUP_ITEM_BAD;
+}
+
 static enum btrfs_inode_field convert_inode_field(char *field)
 {
 	if (!strncmp(field, "isize", FIELD_BUF_LEN))
@@ -442,6 +460,83 @@ static u8 generate_u8(u8 orig)
 	return ret;
 }
 
+static int corrupt_block_group(struct btrfs_root *root, u64 bg, char *field)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path *path;
+	struct btrfs_block_group_item *bgi;
+	struct btrfs_key key;
+	enum btrfs_block_group_field corrupt_field;
+	u64 orig, bogus;
+	int ret = 0;
+
+	root = root->fs_info->extent_root;
+
+	corrupt_field = convert_block_group_field(field);
+	if (corrupt_field == BTRFS_BLOCK_GROUP_ITEM_BAD) {
+		fprintf(stderr, "Invalid field %s\n", field);
+		return -EINVAL;
+	}
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		btrfs_free_path(path);
+		fprintf(stderr, "Couldn't start transaction %ld\n",
+			PTR_ERR(trans));
+		return PTR_ERR(trans);
+	}
+
+	key.objectid = bg;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	if (ret < 0) {
+		fprintf(stderr, "Error searching for bg %llu %d\n", bg, ret);
+		goto out;
+	}
+
+	ret = 0;
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	if (key.type != BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		fprintf(stderr, "Couldn't find the bg %llu\n", bg);
+		goto out;
+	}
+
+	bgi = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			     struct btrfs_block_group_item);
+	switch (corrupt_field) {
+	case BTRFS_BLOCK_GROUP_ITEM_USED:
+		orig = btrfs_block_group_used(path->nodes[0], bgi);
+		bogus = generate_u64(orig);
+		btrfs_set_block_group_used(path->nodes[0], bgi, bogus);
+		break;
+	case BTRFS_BLOCK_GROUP_ITEM_CHUNK_OBJECTID:
+		orig = btrfs_block_group_chunk_objectid(path->nodes[0], bgi);
+		bogus = generate_u64(orig);
+		btrfs_set_block_group_chunk_objectid(path->nodes[0], bgi,
+						     bogus);
+		break;
+	case BTRFS_BLOCK_GROUP_ITEM_FLAGS:
+		orig = btrfs_block_group_flags(path->nodes[0], bgi);
+		bogus = generate_u64(orig);
+		btrfs_set_block_group_flags(path->nodes[0], bgi, bogus);
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+	btrfs_mark_buffer_dirty(path->nodes[0]);
+out:
+	btrfs_commit_transaction(trans, root);
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int corrupt_key(struct btrfs_root *root, struct btrfs_key *key,
 		       char *field)
 {
@@ -1150,6 +1245,7 @@ int main(int argc, char **argv)
 	u64 file_extent = (u64)-1;
 	u64 root_objectid = 0;
 	u64 csum_bytenr = 0;
+	u64 block_group = 0;
 	char field[FIELD_BUF_LEN];
 
 	field[0] = '\0';
@@ -1177,11 +1273,12 @@ int main(int argc, char **argv)
 			{ "delete", no_argument, NULL, 'd'},
 			{ "root", no_argument, NULL, 'r'},
 			{ "csum", required_argument, NULL, 'C'},
+			{ "block-group", required_argument, NULL, 'B'},
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
 
-		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:",
+		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:B:",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1244,6 +1341,9 @@ int main(int argc, char **argv)
 			case 'C':
 				csum_bytenr = arg_strtou64(optarg);
 				break;
+			case 'B':
+				block_group = arg_strtou64(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1385,6 +1485,12 @@ int main(int argc, char **argv)
 		ret = corrupt_key(target_root, &key, field);
 		goto out_close;
 	}
+	if (block_group) {
+		if (*field == 0)
+			print_usage(1);
+		ret = corrupt_block_group(root, block_group, field);
+		goto out_close;
+	}
 	/*
 	 * If we made it here and we have extent set then we didn't specify
 	 * inode and we're screwed.
-- 
2.26.3

