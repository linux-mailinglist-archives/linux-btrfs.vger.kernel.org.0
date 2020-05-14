Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D066E1D2B86
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgENJfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 05:35:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgENJfB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 05:35:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id h4so29471110wmb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 02:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V54BiqWE2+q18Xy7K4B5TR1RyZ1BOUuhwPBkGdbAJ8o=;
        b=m+Y5jiu2vKddrsFIUPx4jrQ0h6fJAfKS1L8CWbYtuFDn8lD3ESFhdDBrL51xJf2omR
         L3YMhnWvrY13fUPQk+fDfYOpiAatFW9R5nu8pEJtn3JMhAet4BLwsMvOx2rpJOw9RJXV
         /JGBMY8PN/hVnzQdqpWGK8FgSoCJtkzhqfDo9ALHmzYnA+fi/4qAH1i3TbZ5y8s/eDRC
         dKcher1vIEgOLweMayNrmUP+bn/fFntFHiM8RiavpSg+33W3wfJolP72M6/IsJ18cf6R
         PQQ+HTR8B8+gFM2OpObhrZCX0jyuv5so3eCsRq1SJEU2HamVQjBJjCR1ZJIreVHCoGSd
         /acQ==
X-Gm-Message-State: AGi0Pua7kKeqsPoEB04O6OBGcbFy5Y7V+4K/Flbtus/i0gUl+aKpySgB
        f0B7Bs+DmIMqP7RIWk28vhw=
X-Google-Smtp-Source: APiQypKYAZ9mJvO+dOEkTbatEoafS3tvWbwRae/IDQqXqx3Dg/6RnA56BmEFel47G7vuFPTHmUibIw==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr47237060wmh.11.1589448899111;
        Thu, 14 May 2020 02:34:59 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id l12sm3522750wrh.20.2020.05.14.02.34.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:34:58 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/5] btrfs-progs: pass in fs_info to btrfs_csum_data
Date:   Thu, 14 May 2020 11:34:29 +0200
Message-Id: <20200514093433.6818-2-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200514093433.6818-1-jth@kernel.org>
References: <20200514093433.6818-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For passing authentication keys to the checksumming functions we need a
container for the key.

Pass in a btrfs_fs_info to btrfs_csum_data() so we can use the fs_info as
a container for the authentication key.

Note this is not always possible for all callers of btrfs_csum_data() so
we're just passing in NULL if it is not directly possible.

Functions calling btrfs_csum_data() with a NULL fs_info argument are
currently not supported in the context of an authenticated file-system.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-sb-mod.c              |  4 ++--
 check/main.c                |  2 +-
 cmds/inspect-dump-super.c   |  2 +-
 cmds/rescue-chunk-recover.c |  2 +-
 convert/common.c            |  2 +-
 disk-io.c                   | 16 +++++++++-------
 disk-io.h                   |  3 ++-
 file-item.c                 |  2 +-
 8 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index ad143ca0..53700268 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -36,7 +36,7 @@ static int check_csum_superblock(void *sb)
 	u8 result[BTRFS_CSUM_SIZE];
 	u16 csum_type = btrfs_super_csum_type(sb);
 
-	btrfs_csum_data(csum_type, (unsigned char *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (unsigned char *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
@@ -48,7 +48,7 @@ static void update_block_csum(void *block)
 	struct btrfs_header *hdr;
 	u16 csum_type = btrfs_super_csum_type(block);
 
-	btrfs_csum_data(csum_type, (unsigned char *)block + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (unsigned char *)block + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	memset(block, 0, BTRFS_CSUM_SIZE);
diff --git a/check/main.c b/check/main.c
index bb17623f..06f32933 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5741,7 +5741,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 			while (data_checked < read_len) {
 				tmp = offset + data_checked;
 
-				btrfs_csum_data(csum_type, data + tmp,
+				btrfs_csum_data(fs_info, csum_type, data + tmp,
 						result, fs_info->sectorsize);
 
 				csum_offset = leaf_offset +
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index f22633b9..99f35def 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -39,7 +39,7 @@ static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
 
-	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index a13acc01..1f26425b 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1912,7 +1912,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 	}
 	ret = 0;
 	put_unaligned_le32(tree_csum, expected_csum);
-	btrfs_csum_data(csum_type, (u8 *)data, result, len);
+	btrfs_csum_data(NULL, csum_type, (u8 *)data, result, len);
 	if (memcmp(result, expected_csum, csum_size) != 0)
 		ret = 1;
 out:
diff --git a/convert/common.c b/convert/common.c
index 3cb2d9d4..54ed52b5 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -66,7 +66,7 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
        u16 csum_type = btrfs_super_csum_type(sb);
        int ret;
 
-       btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+       btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 		       result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
        memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
        ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
diff --git a/disk-io.c b/disk-io.c
index 529e8706..5e54a4b3 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -139,7 +139,8 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
 	}
 }
 
-int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
+int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
+		    const u8 *data, u8 *out, size_t len)
 {
 	memset(out, 0, BTRFS_CSUM_SIZE);
 
@@ -167,7 +168,8 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	u32 len;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
-	btrfs_csum_data(csum_type, (u8 *)buf->data + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(buf->fs_info, csum_type,
+			(u8 *)buf->data + BTRFS_CSUM_SIZE,
 			result, len);
 
 	if (verify) {
@@ -1411,7 +1413,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 	csum_size = btrfs_super_csum_size(sb);
 
-	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	if (memcmp(result, sb->csum, csum_size)) {
@@ -1665,8 +1667,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 	}
 	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
 		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
-		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE, result,
-				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		btrfs_csum_data(fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
 		/*
@@ -1700,8 +1702,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE, result,
-				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		btrfs_csum_data(fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
 		/*
diff --git a/disk-io.h b/disk-io.h
index b450149e..630d4754 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -189,7 +189,8 @@ int btrfs_free_fs_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
 int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
-int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
+int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
+		    const u8 *data, u8 *out, size_t len);
 
 int btrfs_open_device(struct btrfs_device *dev);
 int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
diff --git a/file-item.c b/file-item.c
index 64af5769..fb84fbd6 100644
--- a/file-item.c
+++ b/file-item.c
@@ -315,7 +315,7 @@ csum:
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	btrfs_csum_data(csum_type, (u8 *)data, csum_result, len);
+	btrfs_csum_data(root->fs_info, csum_type, (u8 *)data, csum_result, len);
 	/* FIXME: does not make sense for non-crc32c */
 	if (csum_result == 0) {
 		printk("csum result is 0 for block %llu\n",
-- 
2.26.1

