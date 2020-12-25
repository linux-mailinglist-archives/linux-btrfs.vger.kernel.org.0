Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E300A2E2A2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Dec 2020 08:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgLYHr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Dec 2020 02:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgLYHr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Dec 2020 02:47:27 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A8C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 23:46:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w6so2284486pfu.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 23:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hsNIu7LNy0Y2x2NNqOaa90ZupeMz70UR7S0qnagUmfE=;
        b=iDdb2+eiTmvlMgEiiP7NwWSzoNzwUyfXEUAT/7QFbJ46hHIt4WiCfn376msZcfkn3I
         o++szpF6L8n/KkR3aLqStlEKxbwE8t3cDuhLsdwBwSN2xnLEbU7KneL0h5N7scwFLd5I
         qoitZdz/EzOGU/04Cy3NwLRvldMHA1uxLVPUsqs5AJIepyaLhYj0HvMKOvVkNr/Btj9z
         qhAkVrO2A04wjG1hPBS7ILCRo8fVfBHvWQTBgyRWPYEABVcp7/tT5GDKAuae2lFRrQ6u
         JQJuU7Me9Kv6nNSUTn9KwFDoxB7Dx3dd9Guy7V6cTXJWhXUQVDq7xy8Ea5JwiZZgGSNp
         bESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hsNIu7LNy0Y2x2NNqOaa90ZupeMz70UR7S0qnagUmfE=;
        b=rfsLAtXdWWZ67gD8yr8SLpowhZ6ST/BpjEtyl159vvMoL0O4uBRiLxcc/Ds2N1Aydm
         kJAyX3A23eCfnvAbM6Fy92FsiGH+5xnOPUiNQzRh1bhm3FyXcmYaNMAFsmM/xv0/lPNJ
         Q95Nd/2Ft2Ahreme7snyu+DAzHzKBXYS5gj+8LT0OZFsNpTF4P0DO/xxNaLGOMd5DrNp
         UD4saHRNWrYC2/Z0fQDe0Wo6kQPn9REtyLJ5Gt/ejeR0PnuJqZXtmiSKKpalFTGXCrQC
         CAKq55Ufk9bFyl+Q/71WFolIUdP16tseT/HpEng4tH8G+SH+dxKPNkjWBRZK96+oWYwc
         sg9A==
X-Gm-Message-State: AOAM5325ErI4oq3UxpStvSKwbuvvVc6hnku9tYTM8A5UWECSb7N5b4i5
        fBNIFoEE18goVzpTVDBlb/RRlIbXPOWaTHrS
X-Google-Smtp-Source: ABdhPJyzWmnZFoRkL2DLoWOql+jfoU3HFvHwYqmHNVXQGTE3djvFABpg/n3eUOyl0agqX+ZOwx+MdQ==
X-Received: by 2002:a63:d149:: with SMTP id c9mr7761000pgj.351.1608882406822;
        Thu, 24 Dec 2020 23:46:46 -0800 (PST)
Received: from imacssd.osipp.osaka-u.ac.jp ([133.1.243.7])
        by smtp.googlemail.com with ESMTPSA id 4sm4834359pjn.14.2020.12.24.23.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 23:46:46 -0800 (PST)
From:   Jiachen YANG <farseerfc@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jiachen YANG <farseerfc@gmail.com>
Subject: [PATCH] btrfs-progs: btrfs-convert: copy ext4 extra timespec
Date:   Fri, 25 Dec 2020 16:45:38 +0900
Message-Id: <20201225074538.461837-1-farseerfc@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs-convert only copies ext2 inode timestamps
i_[cma]time from ext4, while filling 0 to nsec and crtime fields.

This change copies nsec and crtime by parsing i_[cma]time_extra fields.
---
 convert/source-ext2.c | 81 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index efe73742..e397e89f 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -691,6 +691,77 @@ static void ext2_copy_inode_item(struct btrfs_inode_item *dst,
 	}
 	memset(&dst->reserved, 0, sizeof(dst->reserved));
 }
+
+/*
+ * Copied and modified from fs/ext4/ext4.h
+ */
+static inline void ext4_decode_extra_time(__le32 * tv_sec, __le32 * tv_nsec,
+                                          __le32 extra)
+{
+        if (extra & cpu_to_le32(EXT4_EPOCH_MASK))
+                *tv_sec += (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
+        *tv_nsec = (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
+}
+
+#define EXT4_COPY_XTIME(xtime, dst, tv_sec, tv_nsec)					\
+do {											\
+	tv_sec = src->i_ ## xtime ;							\
+	if(inode_includes(inode_size, i_ ## xtime ## _extra)) {				\
+		tv_sec = src->i_ ## xtime ;						\
+		ext4_decode_extra_time(&tv_sec, &tv_nsec, src->i_ ## xtime ## _extra);	\
+		btrfs_set_stack_timespec_sec(&dst->xtime , tv_sec);			\
+		btrfs_set_stack_timespec_nsec(&dst->xtime , tv_nsec);			\
+	}else{										\
+		btrfs_set_stack_timespec_sec(&dst->xtime , tv_sec);			\
+		btrfs_set_stack_timespec_nsec(&dst->xtime , 0);				\
+	}										\
+}while (0);
+
+/*
+ * Decode and copy i_[cma]time_extra and i_crtime{,_extra} field
+ */
+static int ext4_copy_inode_timespec_extra(struct btrfs_inode_item *dst,
+				ext2_ino_t ext2_ino, u32 s_inode_size, ext2_filsys ext2_fs)
+{
+
+	struct ext2_inode_large *src;
+	u32 inode_size, tv_sec, tv_nsec;
+	int ret, err;
+	ret = 0;
+
+	src = (struct ext2_inode_large *)malloc(s_inode_size);
+	if (!src)
+		return -ENOMEM;
+	err = ext2fs_read_inode_full(ext2_fs, ext2_ino, (void *)src,
+				     s_inode_size);
+	if (err) {
+		fprintf(stderr, "ext2fs_read_inode_full: %s\n",
+			error_message(err));
+		ret = -1;
+		goto out;
+	}
+
+	inode_size = EXT2_GOOD_OLD_INODE_SIZE + src->i_extra_isize;
+
+	EXT4_COPY_XTIME(atime, dst, tv_sec, tv_nsec);
+	EXT4_COPY_XTIME(mtime, dst, tv_sec, tv_nsec);
+	EXT4_COPY_XTIME(ctime, dst, tv_sec, tv_nsec);
+
+	tv_sec = src->i_crtime ;
+	if(inode_includes(inode_size, i_crtime_extra)) {
+		tv_sec = src->i_crtime;
+		ext4_decode_extra_time(&tv_sec, &tv_nsec, src->i_crtime_extra);
+		btrfs_set_stack_timespec_sec(&dst-> otime , tv_sec);
+		btrfs_set_stack_timespec_nsec(&dst-> otime , tv_nsec);
+	}else{
+		btrfs_set_stack_timespec_sec(&dst-> otime , tv_sec);
+		btrfs_set_stack_timespec_nsec(&dst-> otime , 0);
+	}
+out:
+	free(src);
+	return ret;
+}
+
 static int ext2_check_state(struct btrfs_convert_context *cctx)
 {
 	ext2_filsys fs = cctx->fs_data;
@@ -738,13 +809,21 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 			     struct ext2_inode *ext2_inode,
 			     u32 convert_flags)
 {
-	int ret;
+	int ret, s_inode_size;
 	struct btrfs_inode_item btrfs_inode;
 
 	if (ext2_inode->i_links_count == 0)
 		return 0;
 
 	ext2_copy_inode_item(&btrfs_inode, ext2_inode, ext2_fs->blocksize);
+	s_inode_size = EXT2_INODE_SIZE(ext2_fs->super);
+	if (s_inode_size > EXT2_GOOD_OLD_INODE_SIZE) {
+		ret = ext4_copy_inode_timespec_extra(&btrfs_inode,
+			ext2_ino, s_inode_size, ext2_fs);
+		if (ret)
+		    return ret;
+	}
+
 	if (!(convert_flags & CONVERT_FLAG_DATACSUM)
 	    && S_ISREG(ext2_inode->i_mode)) {
 		u32 flags = btrfs_stack_inode_flags(&btrfs_inode) |
-- 
2.29.2

