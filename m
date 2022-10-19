Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F45604A1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiJSO6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiJSO5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12252DCE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c23so11794689qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JU4VKhg8LTV9enNbcbYCihSMv9ZppQGg8e3plhOGyps=;
        b=vuejGXOuA0sanOBhIa8Xp68FmmAviQem7VKusna6JqWlKacrGG4NU5zognFf8njrz6
         YOvppPQTQqG4pwY4MTfWzt6RfsOJ/7VjmBPtuOGB063q6U01HujM7RRrG52PQKUfS1Rv
         zkAiKsGN1X6Mm07aP6YniX/UWARBhMECR0EQ5NWtO1eHoq0Gb24Bj1cbjw9NoMxPhOMs
         nQw12ZeiUzZmTU4pAoBtjnIvCC3eDseygxALes7N3zfjR7iYMlCGRfccpa95z9xt5rpk
         Nf7mWUknmtNFzkkTDIaPMD/sEcXR2rzpQjpJlKSHZRaX+d6zkL6Vc389B+UxCIgXVepM
         NEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU4VKhg8LTV9enNbcbYCihSMv9ZppQGg8e3plhOGyps=;
        b=jxtCJjDSKVnd08LzOv/fGKxwA1Awt9+tTlgRyF8H07B608sRz3M2XUKLBxSX5AwqT9
         T3M70pw3EEhcHYcN4rNf+c2Tmb4dOC6cLJkSbuKz7bbniZ+ozkaDDdvA6DdediMV5KfJ
         lYk4Injeij2DDJZOvmK50lviQX6mRCEbDsXiTbSBB6KjPoZ/uRoF6Xpdo6z/GZrClBEJ
         YNA05WG516NS1QWWLUMDmhcSheLG3VjARv4jE6Hew9GlKIdh18A3Lb5etKDK+D2Fn6/d
         xQb0PEBqH4u8bc9LbgUTu0uAFoG7g4uLi4GLKilciRpuRJoXrWaz2oxI+EVYi+ZktHMv
         9CvQ==
X-Gm-Message-State: ACrzQf2SJml+spaTbDPpNTEKyEp5EB8YixNMp0DyujYlJWJe6IRGFtiB
        vip/SDLezGCpBzDAe6Nmi1QofLBBpBtCJQ==
X-Google-Smtp-Source: AMsMyM41bnR7ZEHM3fZDd1n0cjQqyTL5UMKbzm04WFEoos7zJknrCtIUhhC1oh/itT7koJWeTAIcrA==
X-Received: by 2002:ac8:5bc9:0:b0:39a:348b:857e with SMTP id b9-20020ac85bc9000000b0039a348b857emr6737821qtb.462.1666191071014;
        Wed, 19 Oct 2022 07:51:11 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a2a0e00b006cbc00db595sm5217082qkp.23.2022.10.19.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 06/15] btrfs: convert incompat and compat flag test helpers to defines
Date:   Wed, 19 Oct 2022 10:50:52 -0400
Message-Id: <ddf7048a28c82a3d640d173c1f27a9dec6e8b549.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

These helpers use functions not defined in fs.h, they're simply
accessors of the super block in fs_info, convert them to define's so
that we don't have a weird dependency between fs.h and accessor.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index c4786e838ee0..857caa07fd77 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -44,6 +44,12 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				const char *name);
 
+#define __btrfs_fs_incompat(__fs_info, flags)		\
+	(!!(btrfs_super_incompat_flags((__fs_info)->super_copy) & flags))
+
+#define __btrfs_fs_compat_ro(__fs_info, flags)		\
+	(!!(btrfs_super_compat_ro_flags((__fs_info)->super_copy) & flags))
+
 #define btrfs_set_fs_incompat(__fs_info, opt) \
 	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
 				#opt)
@@ -66,20 +72,6 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 #define btrfs_fs_compat_ro(fs_info, opt) \
 	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
 
-static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_incompat_flags(disk_super) & flag);
-}
-
-static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
-}
-
 static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
 {
 	/*
-- 
2.26.3

