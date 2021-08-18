Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9703F0D68
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhHRVeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhHRVeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5933C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t190so4769856qke.7
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q74zopsXykN2lNWEGAhZ8fcvtFizImgt1JxUWfbB6yc=;
        b=J2Yo2wjZu3UQ9w6oU704YrEirr26CvjpuNR+zvqk2nv3t6LWBvs9yiV8W+u/ttzjxd
         sZX4SrirxaG0eNBfory3t2cWqJAZ4dDeHYeuVQkV77WwHVZwE8f0ksvKcBIZR1cODNil
         hnBzU91kAVJ2QuFAb8AnjUritDgg7vI+TwWt3tIpS7U20KuhOwPbLkifecX8hASM23bK
         3+eCkFjUYMoPiVLlnNOCLr+3IJ1yqA5C4RpQyjIDGYFZsLaZjCo2p3sHP3t5Orm5gf16
         Y+d897SYY6NEUL4/DvaeR1V36JY83bBVnmyxdo2+6DatwfPulkiHC4+CEiawhFAV4TsB
         TxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q74zopsXykN2lNWEGAhZ8fcvtFizImgt1JxUWfbB6yc=;
        b=T+MlwCl9VnJBJPQlluoAuOb4+qKzlod7v6FjVaXEAzpSH5+4CI7aGVA4+z/s2v3+Wb
         Qk/2Lp9RRQ15J2wxzMm0xNdcRtxOW31KJg8K11tMvvvuKxpsEzSj22ap38w0TElTiGkH
         91K3vvG+jxau54884x+lgKuSEjokPQqrPgqGftxDf4Cq7h3e4/TC91Ia+cNwsPCz8grS
         K036+McTur1Xf1bGaiLf5zVGezlywsH1bI8Gu3HBZaujitsSwa6b3LaexplEzPBAmZ3u
         7TtR8cNjfZ0F0fcWLdtPv1Ory45iZIU9FVmw/a0RKMcWZYFnXGSDfo6RR8189nAStJSH
         GVBw==
X-Gm-Message-State: AOAM532NuXY69kXO5hSeLRY2x+vQiXe9+j1N5CKHbSJ6tS0Owxugel83
        DQ0Z4axr/oYHMNS84JD9LSt6HXvWWPB0aw==
X-Google-Smtp-Source: ABdhPJydgtIyvBiGkFNYfXUnrrRXq6pGTXLvuh5FNSVVna0FwRqFWwf0MHbVsZz89Ob0k08MIbxZpg==
X-Received: by 2002:a37:6697:: with SMTP id a145mr376286qkc.5.1629322417610;
        Wed, 18 Aug 2021 14:33:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y13sm615104qkj.124.2021.08.18.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/12] btrfs-progs: add the ability to corrupt fields of the super block
Date:   Wed, 18 Aug 2021 17:33:19 -0400
Message-Id: <7c5a5c52f3cf9ba6b0188b5509e39de93f6bb662.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Doing the extent tree v2 work I generated an invalid super block with
the wrong bytes_used set, and only noticed because it affected the block
groups as well.  Neither modes of fsck check for a valid bytes_used, so
add the ability to corrupt this field so I can generate a testcase for
fsck.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 80622f29..7e576897 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -355,6 +355,24 @@ enum btrfs_block_group_field {
 	BTRFS_BLOCK_GROUP_ITEM_BAD,
 };
 
+enum btrfs_super_field {
+	BTRFS_SUPER_FIELD_FLAGS,
+	BTRFS_SUPER_FIELD_TOTAL_BYTES,
+	BTRFS_SUPER_FIELD_BYTES_USED,
+	BTRFS_SUPER_FIELD_BAD,
+};
+
+static enum btrfs_super_field convert_super_field(char *field)
+{
+	if (!strncmp(field, "flags", FIELD_BUF_LEN))
+		return BTRFS_SUPER_FIELD_FLAGS;
+	if (!strncmp(field, "total_bytes", FIELD_BUF_LEN))
+		return BTRFS_SUPER_FIELD_TOTAL_BYTES;
+	if (!strncmp(field, "bytes_used", FIELD_BUF_LEN))
+		return BTRFS_SUPER_FIELD_BYTES_USED;
+	return BTRFS_SUPER_FIELD_BAD;
+}
+
 static enum btrfs_block_group_field convert_block_group_field(char *field)
 {
 	if (!strncmp(field, "used", FIELD_BUF_LEN))
@@ -460,6 +478,41 @@ static u8 generate_u8(u8 orig)
 	return ret;
 }
 
+static int corrupt_super_block(struct btrfs_root *root, char *field)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	enum btrfs_super_field corrupt_field;
+	u64 orig, bogus;
+
+	corrupt_field = convert_super_field(field);
+	if (corrupt_field == BTRFS_SUPER_FIELD_BAD) {
+		fprintf(stderr, "Invalid field %s\n", field);
+		return -EINVAL;
+	}
+
+	switch (corrupt_field) {
+	case BTRFS_SUPER_FIELD_FLAGS:
+		orig = btrfs_super_flags(fs_info->super_copy);
+		bogus = generate_u64(orig);
+		btrfs_set_super_flags(fs_info->super_copy, bogus);
+		break;
+	case BTRFS_SUPER_FIELD_TOTAL_BYTES:
+		orig = btrfs_super_total_bytes(fs_info->super_copy);
+		bogus = generate_u64(orig);
+		btrfs_set_super_total_bytes(fs_info->super_copy, bogus);
+		break;
+	case BTRFS_SUPER_FIELD_BYTES_USED:
+		orig = btrfs_super_bytes_used(fs_info->super_copy);
+		bogus = generate_u64(orig);
+		btrfs_set_super_bytes_used(fs_info->super_copy, bogus);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return write_all_supers(fs_info);
+}
+
 static int corrupt_block_group(struct btrfs_root *root, u64 bg, char *field)
 {
 	struct btrfs_trans_handle *trans;
@@ -1240,6 +1293,7 @@ int main(int argc, char **argv)
 	int corrupt_di = 0;
 	int delete = 0;
 	int should_corrupt_key = 0;
+	int corrupt_super = 0;
 	u64 metadata_block = 0;
 	u64 inode = 0;
 	u64 file_extent = (u64)-1;
@@ -1274,11 +1328,12 @@ int main(int argc, char **argv)
 			{ "root", no_argument, NULL, 'r'},
 			{ "csum", required_argument, NULL, 'C'},
 			{ "block-group", required_argument, NULL, 'B'},
+			{ "super", no_argument, NULL, 's'},
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
 
-		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:B:",
+		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:B:s",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1344,6 +1399,9 @@ int main(int argc, char **argv)
 			case 'B':
 				block_group = arg_strtou64(optarg);
 				break;
+			case 's':
+				corrupt_super = 1;
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1491,6 +1549,12 @@ int main(int argc, char **argv)
 		ret = corrupt_block_group(root, block_group, field);
 		goto out_close;
 	}
+	if (corrupt_super) {
+		if (*field == 0)
+			print_usage(1);
+		ret = corrupt_super_block(root, field);
+		goto out_close;
+	}
 	/*
 	 * If we made it here and we have extent set then we didn't specify
 	 * inode and we're screwed.
-- 
2.26.3

