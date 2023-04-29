Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5656F2659
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjD2UU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjD2UUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:23 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50AE75
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9d87dffadfso839969276.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799619; x=1685391619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI+tMtCS1cRg9bCuzsW79Nd+86IuOy0IUtwtsNBAgDw=;
        b=Xb2nYgJ0eRaLiDzn1WsZc+ryRmoIM0T01I1vxhfgbdeCPykqCUoLDMmtvfYc5Ar+ba
         oLTYS3m2z+ONtmG8b0MhKRX2Uut/hmqITDdf47JKHJ3DoVMOqcWytRe1iIHlpHWx1HJa
         cftwPNayIgR34ojk5SEi+qYxXMD8CaZLOP0AFcEfXBdqc0En3jcfn2FqIU7yzLvfG5R9
         4BKND+E0L+NUSuAH2JHqEn6wB9WgLEWXaZeh6sWyM6+HHWmlk/c52nrzI/vBDwCfaRAE
         FImLjOtUsPPomwQdhOIhwiY6MlWu3IFIHUZku4nIP269js8/+TyPo596PFgNjCc9VeON
         T8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799619; x=1685391619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI+tMtCS1cRg9bCuzsW79Nd+86IuOy0IUtwtsNBAgDw=;
        b=NOQYkt7T5XzEMuoCw1UfqD8zu52MsaZxkREasnTDkTuNXk5ABc363I8ClLZYJ6pR5j
         Pd5NxGw+B7l/Omxv8s4wMbJPjfW5EOlSJoXX+NqrmMob8s/XX61esK/qH7q43PZkBV9/
         GXBNXwTtBEtiMDYinrXzaEbmrT1rDYznm3/IPYMNl1i7y2qEGkEgHdwcFisvcckdvpLJ
         +QQ60QMI995qxS/9UOEXxbA19iH/aUJw51mRkyIoNdCyXOcY2WhhQtJ7hMdLTnBUAym0
         CPYR0qubIUatQZT0s434h9rnD5tPBFjP5808y8ZJVc/WzMAcEyoMmMm0PZJlVspBdmKU
         8Tkw==
X-Gm-Message-State: AC+VfDzF3QL0EUZKb4ZHCKfhfM4YiQ3Fu6Il3hbdIkB2Ah5CP1pPskam
        Nq/f8YMeJvQ+y/r2GQJvR3XwEnY3psF9J0nR/oUTZQ==
X-Google-Smtp-Source: ACHHUZ7SVw7Q/pG6Z7CVCmtBDgxIhXcusC+9vjnKJ9EEM9ppkdhFpVFFuU0xHZpmzgnWhRFU5ZmzAg==
X-Received: by 2002:a25:1fc1:0:b0:b8f:4e38:4560 with SMTP id f184-20020a251fc1000000b00b8f4e384560mr7574525ybf.2.1682799619454;
        Sat, 29 Apr 2023 13:20:19 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 62-20020a250c41000000b00b8f6ec5a955sm5861111ybm.49.2023.04.29.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/26] btrfs-progs: change how we check supported csum type
Date:   Sat, 29 Apr 2023 16:19:44 -0400
Message-Id: <adac7e6d30d7b3fe266651bddd6542f161f7eeb1.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

In the kernel we have a basic btrfs_supported_super_csum() helper in
disk-io.c to validate the csum type.  Update progs to do the same thing
that the kernel does and then drop the btrfs_super_num_csums() helper as
it doesn't exist upstream and is no longer used.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c   |  5 -----
 kernel-shared/ctree.h   |  1 -
 kernel-shared/disk-io.c | 15 ++++++++++++++-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 97164cb8..0bd24646 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -65,11 +65,6 @@ const char *btrfs_super_csum_name(u16 csum_type)
 	return btrfs_csums[csum_type].name;
 }
 
-size_t btrfs_super_num_csums(void)
-{
-	return ARRAY_SIZE(btrfs_csums);
-}
-
 u16 btrfs_csum_type_size(u16 csum_type)
 {
 	return btrfs_csums[csum_type].size;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b3e73e35..cab8f71b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1064,7 +1064,6 @@ void btrfs_set_item_key_unsafe(struct btrfs_root *root,
 u16 btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
 u16 btrfs_csum_type_size(u16 csum_type);
-size_t btrfs_super_num_csums(void);
 
 /* root-item.c */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3e0c3534..b7a98c4c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1713,6 +1713,19 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 	return info->fs_root;
 }
 
+static bool btrfs_supported_super_csum(u16 csum_type)
+{
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_XXHASH:
+	case BTRFS_CSUM_TYPE_SHA256:
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Check if the super is valid:
  * - nodesize/sectorsize - minimum, maximum, alignment
@@ -1737,7 +1750,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 
 	csum_type = btrfs_super_csum_type(sb);
-	if (csum_type >= btrfs_super_num_csums()) {
+	if (!btrfs_supported_super_csum(csum_type)) {
 		error("unsupported checksum algorithm %u", csum_type);
 		return -EIO;
 	}
-- 
2.40.0

