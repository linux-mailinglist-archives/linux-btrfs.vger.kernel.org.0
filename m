Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAC3F0D67
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhHRVeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhHRVeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B4C061796
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id n11so4805665qkk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s42MlTEMvYSBXe8WEZE5d03pnb37YtmVJvaQ3SGB2t8=;
        b=TRnYiIZsFql9KsyEt8AtYntkVuZnUy8A9yipUA9Uuegh6PhG6nXS8nIsy432+zztBC
         inLO3crNyRq9HpJErINscOIKU931ILziTEkojBBvtk/VVGsZA7bRvNtTKf2q/04F3KQg
         zg7UHGr931uFGU6L68zgoyl9U847gH3na3dBEze6d09XBmGn7NGYN2podWgqq/OmRlPp
         1CRT+oHl9Kswxsfm+LG1/fZsuVlgH2vjiGAjudB1e+w5N9Mjh+zqAVJFpcvZOjxabCEg
         6USIckAatl9uwVoY4Qvf+C5d3W2khFmXv0N/0B1JjoTP0UIbkoPPe2POfgyB8bahv2rc
         pIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s42MlTEMvYSBXe8WEZE5d03pnb37YtmVJvaQ3SGB2t8=;
        b=sY5TK9ssj0AW/UBBuGWxTXhI3BP0f2vx5GWp9wxJqywXPc9u6BQ8oD5hkoBAUF0OjX
         8I5MlJKNDDZWlBoGCGl6y1pcCSc4krlAqqEiUM5srrq3HDvHaPrwjWTFCWNRlK6EBeaW
         Q09S3SYi7swB8TmzEfe4B3t1F4LoNPMYcSQ+s79FtlcOr/a1I4MU+y78OrG+rC8vuh2M
         VrUZG99iL6qLH12rmLK3b7PCw11J7Yn8AJgCMC0j3Yhw3wdaodBuxb+pRHRzPluqCuAy
         lkyfCY3MnWbGE5Zs4CGQV4C5fEFIbcOezPZUcjjz0w4muaMS552/zd398nRyNhfxqYYt
         21Fw==
X-Gm-Message-State: AOAM532qtjjLrqdkk4DO5vrPLGgBV10DUJfDDivdRBTUR1+Tm0hlks2/
        9xAPL6k4y9JgYN/W76XRspovwsQtYEdxaQ==
X-Google-Smtp-Source: ABdhPJwZn7osVkJDtN5Gzf52xG+FTkKhB73qCmGF/827wF5FREkteQOLfdsXfov3j3jPROsmnSyxQw==
X-Received: by 2002:a05:620a:214f:: with SMTP id m15mr356332qkm.59.1629322416067;
        Wed, 18 Aug 2021 14:33:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i67sm547537qkd.90.2021.08.18.14.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/12] btrfs-progs: add the ability to corrupt block group items
Date:   Wed, 18 Aug 2021 17:33:18 -0400
Message-Id: <a7d7bcfc46aa3ee37d509686cb2b43d7638df24f.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
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

