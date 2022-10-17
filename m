Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93FC6016FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJQTJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJQTJ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F863AF
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a5so7273411qkl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JU4VKhg8LTV9enNbcbYCihSMv9ZppQGg8e3plhOGyps=;
        b=h/Yafw0H5jBxCAPNXTGoheLcxwziXJDk6aM5az71rJ7yM0ctwMWhlCW3CVUvudZPra
         M6X3LDQeDiqZivslZolfGrxOGVZzfYEBoqFjehJ+uNcwFV1jI+BKUocDgmwNCxAdwE37
         5k0bbIxSjST4Gc1TWv2Hvy2pvMT2BvbSb4IqwVwl+wK70pmF21S9RBOW+Yf5TE+bpCcY
         ZXd1dmoIT9hPcyxADzBwyF6bO+JjgBAP9YAqYooDDzGWFwceelysG3kIgjFVM0EYsln8
         D4iRPg4O6oWQBBgLeO3PsvOnmLVEGIoZchQsCGaEoTg2K4NkwSpy/iz3elO7BQJwtj4/
         e5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU4VKhg8LTV9enNbcbYCihSMv9ZppQGg8e3plhOGyps=;
        b=0LDBSBs4g4fzCfSUkFuiWNMxAovwiC8HsrP4/iRG69XDpvnV0VPMFqAn9P4JzyhRz5
         ue/RuZBdDUIGvJ3EsccAqvkIoVEu7nK2RDcLiMyDX+RaNPKuA7tZT6Q/DaanD6cqKHmI
         GyIQLR5t26dFvOqxiuSw4oVnOu83fK+wrK9OxjosyITFCsZog9DxdtKBpomX0fsO/dHM
         GQm2chuocjGwzcNqOtHSVIc/NYKMoI5IAAJOZp81iM69Yu7HI1F4WvI2A7bQW17wyiSu
         ZunXvOIJ/RVWcMbu5WdkSu8Jir7/giCCzqPJSPoK3zyE7RxgoCqJpu9AtJwuVrZkW7Qe
         ZvcQ==
X-Gm-Message-State: ACrzQf2muMvZ1PgA+KavP5hHe4rd1NfjId4YeKMmm1s9M0mspRff2meS
        /k8VcJyioqFY4UhEgLKHYKHHdhYEqrmv0w==
X-Google-Smtp-Source: AMsMyM5QzamlqX0fbhvttCyYVl8P/ctIXuu98F6FU44Mq3b685kJ36q09fe20R4mBry74byuOj6qIQ==
X-Received: by 2002:a05:620a:4042:b0:6ec:2343:17f8 with SMTP id i2-20020a05620a404200b006ec234317f8mr8825543qko.307.1666033764912;
        Mon, 17 Oct 2022 12:09:24 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id 5-20020a370805000000b006ec09d7d357sm441461qki.47.2022.10.17.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/16] btrfs: convert incompat and compat flag test helpers to defines
Date:   Mon, 17 Oct 2022 15:09:04 -0400
Message-Id: <b0865d613f9bf886670806b3d2487d149b770745.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
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

