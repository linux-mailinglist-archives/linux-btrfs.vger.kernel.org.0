Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE87788FB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjHYUUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjHYUTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB86171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:40 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-649c6ea6e72so7781056d6.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994779; x=1693599579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRjPotIUWEc4gJhIm2o/fQiRMm8MFzkSb3hRHYdvw3E=;
        b=KEhjPfodUs2KqE4WEHmGDWp5nuNTFqik/wk+XYwP/eOlZV4Op4YuqwJt4za+N7lYh5
         7/65w4HSvg4xmJCq6URt26iGtYqKIk/WjBPHB1dmtdW/MKSI9BeeBMAbTntyp9RWAFI2
         53A2X1QQ/wHtuNkg7uZSXJsgw6PVYhlN47ZLoG+ZIzYfLpdLXET+im3cEOVf2IhZrjDM
         L83RMUG+VWQHZY1Ev+fZxG9MD65e0tBwL1qRjmd4DNuqpqb3CqL9/XxWGNGl2gRFz+RS
         0Z2xFAm4PfxgSnIKnQM+N2wjtRBS9BlPzJWrMtTdwSmvW6VmekCNI1Ht51Ta3t604ls+
         4DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994779; x=1693599579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRjPotIUWEc4gJhIm2o/fQiRMm8MFzkSb3hRHYdvw3E=;
        b=JJ5Kni6oaf0S+W+W5R67OsDaTMFyhxAQ5Zv2capbYUHx9BJa++jQ6I2YtvdeW5aRVg
         65UgvegIzCZiEzee/e9/eY69pN9O5biVRHGM17Z7ecNFIEokPN9c13qRZBjq4l6plk+Z
         KU0Kwa8spEqL6vGsOnQojsxX6raiJL4zalBbpNgJgOujO+LbXXu4a/xcUWSpxxZCbWNi
         9teTnCE74EdjkxAEz+5Vg5x3PrEqQ65WHynGA5VpXDH/oGOLCMiAUuXohlMohhdCc9ev
         cxOW+2gfWXx8sqxerU968R3Ty+ZBnSYyWIQUcVDtzQu94Ac956WdYur/3OThQVtyN86z
         dpBA==
X-Gm-Message-State: AOJu0YyEVIjoe9WshlZuftptyQ/mDEh1ZWiLsPLHOYP1211ZBrMTR8c+
        /tb0vpjYfgj40ds6TdrzhgYPJZGClGNpDqdsLCU=
X-Google-Smtp-Source: AGHT+IGxIBi3ocHDDfD7swZBNvPRVBwBDnjq6Ss8z5qO0FgTVvnFAo+79RpZm0Sc5mJXWvpJvX5Z0g==
X-Received: by 2002:a0c:8ecc:0:b0:63d:651e:4133 with SMTP id y12-20020a0c8ecc000000b0063d651e4133mr18318952qvb.37.1692994779323;
        Fri, 25 Aug 2023 13:19:39 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x3-20020a0cc503000000b0063642bcc5e4sm773839qvi.9.2023.08.25.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/12] btrfs: remove btrfs_crc32c wrapper
Date:   Fri, 25 Aug 2023 16:19:20 -0400
Message-ID: <8a7ac9267cb726add7fb8bec90eb1d50ddbd0b4f.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This simply sends the same arguments into crc32c(), and is just used in
a few places.  Remove this wrapper and directly call crc32c() in these
instances.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            | 5 -----
 fs/btrfs/extent-tree.c      | 6 +++---
 fs/btrfs/free-space-cache.c | 4 ++--
 fs/btrfs/send.c             | 6 +++---
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c80d9879d931..bffee2ab5783 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -470,11 +470,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
 				((bytes) >> (fs_info)->sectorsize_bits)
 
-static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
-{
-	return crc32c(crc, address, length);
-}
-
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
        return crc32c((u32)~1, name, len);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f356f08b55cb..e4d337b78e76 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -399,11 +399,11 @@ u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
 	__le64 lenum;
 
 	lenum = cpu_to_le64(root_objectid);
-	high_crc = btrfs_crc32c(high_crc, &lenum, sizeof(lenum));
+	high_crc = crc32c(high_crc, &lenum, sizeof(lenum));
 	lenum = cpu_to_le64(owner);
-	low_crc = btrfs_crc32c(low_crc, &lenum, sizeof(lenum));
+	low_crc = crc32c(low_crc, &lenum, sizeof(lenum));
 	lenum = cpu_to_le64(offset);
-	low_crc = btrfs_crc32c(low_crc, &lenum, sizeof(lenum));
+	low_crc = crc32c(low_crc, &lenum, sizeof(lenum));
 
 	return ((u64)high_crc << 31) ^ (u64)low_crc;
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 759b92db35d7..dfeed8256c02 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -545,7 +545,7 @@ static void io_ctl_set_crc(struct btrfs_io_ctl *io_ctl, int index)
 	if (index == 0)
 		offset = sizeof(u32) * io_ctl->num_pages;
 
-	crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
+	crc = crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
 	btrfs_crc32c_final(crc, (u8 *)&crc);
 	io_ctl_unmap_page(io_ctl);
 	tmp = page_address(io_ctl->pages[0]);
@@ -567,7 +567,7 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *io_ctl, int index)
 	val = *tmp;
 
 	io_ctl_map_page(io_ctl, 0);
-	crc = btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
+	crc = crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - offset);
 	btrfs_crc32c_final(crc, (u8 *)&crc);
 	if (val != crc) {
 		btrfs_err_rl(io_ctl->fs_info,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3a566150c531..3b929f0e8f04 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -796,7 +796,7 @@ static int send_cmd(struct send_ctx *sctx)
 	put_unaligned_le32(sctx->send_size - sizeof(*hdr), &hdr->len);
 	put_unaligned_le32(0, &hdr->crc);
 
-	crc = btrfs_crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
+	crc = crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
 	put_unaligned_le32(crc, &hdr->crc);
 
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
@@ -5669,8 +5669,8 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
 	hdr->len = cpu_to_le32(sctx->send_size + disk_num_bytes - sizeof(*hdr));
 	hdr->crc = 0;
-	crc = btrfs_crc32c(0, sctx->send_buf, sctx->send_size);
-	crc = btrfs_crc32c(crc, sctx->send_buf + data_offset, disk_num_bytes);
+	crc = crc32c(0, sctx->send_buf, sctx->send_size);
+	crc = crc32c(crc, sctx->send_buf + data_offset, disk_num_bytes);
 	hdr->crc = cpu_to_le32(crc);
 
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
-- 
2.41.0

