Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE15B8E08
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiINRSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiINRSh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE038286D
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:35 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d1so12291705qvs.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ui2711pKWIExdweXKQc4sC7/u3yFdRQI2VQtlb+2qsk=;
        b=HNFzXw0goOMGKnoXf9eMtui+dNoMADBxESCG9BQyduLbbKgJRCUq/D8OFoVUcl6EaU
         3TEaigK0MPeGKE2m92d8QXPY44tjmuaIqS26hPzGx/bkKSLLO0HqLB1WwkgzN8yjcSyQ
         t0HT10KVHTfz7OdqoqH6ZkqOVVLEKm5I2vOyue7Mu6aqcMkRNe1CZVso4TZZF5sHUSqv
         53yHycMNKL9lzNS1s7zAjbfiyM+bgMv/AL05MEXdqJg7Aoh+nI+c2J+KJzeUTvqc39t2
         r9i4AKXorGBPqQtdnaW8znl07Wnf4KIpo4ggBAXALcYX0f8ES7816vGjstt7/DvXmSMH
         UYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ui2711pKWIExdweXKQc4sC7/u3yFdRQI2VQtlb+2qsk=;
        b=w3S5LK43KEopV8G0W40nEuFncuCGSr6DoMrx8uSHBHE3Jv/A9yAEKBexrGZpSRAZDa
         kGqZSW/LRuFw3m3IF0Zf877Xx0B2PLJlQj+qe3AqdtdMzDPEeiSIU3S1JULH4Oo3tMfi
         4eR2hvqxzSIQS2gFm6j7ZyZuyR9ta/M6dOcH9UBsnMETCM0GuTtEXVV5xK5jaZK3lL3p
         p+1CVBI/84DtwL8rIv/z8orjfVhxO0ulp8Cn2luVLMXpSUn3BqY26FamVBYxwFpzLlR7
         UtZvQy7HPtHj58PVW1bc+dixVafN8wMD8M/V5lABBMK8OAO9LEMAXo5Gm2rL3UzUcyia
         9wMQ==
X-Gm-Message-State: ACgBeo2KAeKN5MZVySHANtAuRsDsbHK9i1usChV0R4o30wrfGL5wyDop
        /5zZtbkfTHRjwaYvIik49HElkOu8UH4g+w==
X-Google-Smtp-Source: AA6agR7qxiWjLqz3WDBV2Q3rpN11M8DCBdYaI/IitPAYS8qe/p1yEw6+y9f7/42PjZNblDGZHEVWwQ==
X-Received: by 2002:a05:6214:2022:b0:4ac:b001:2c75 with SMTP id 2-20020a056214202200b004acb0012c75mr14616307qvf.83.1663175914447;
        Wed, 14 Sep 2022 10:18:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ca5-20020a05622a1f0500b0035bb732ac93sm1895756qtb.88.2022.09.14.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/16] btrfs: move incompat and compat flag helpers to fs.c
Date:   Wed, 14 Sep 2022 13:18:13 -0400
Message-Id: <3aeef7d866611a84296b74ff0ee7938351c58d88.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
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

These helpers use functions not defined in fs.h, move them to fs.c to
keep the header clean.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.c | 14 ++++++++++++++
 fs/btrfs/fs.h | 16 ++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 31cac6c6f062..32fbc7f55730 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -91,3 +91,17 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 		spin_unlock(&fs_info->super_lock);
 	}
 }
+
+bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_incompat_flags(disk_super) & flag);
+}
+
+int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
+}
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 43fd78a9f46c..5e21ca9d172a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -45,6 +45,8 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 			      const char *name);
 void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				const char *name);
+bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag);
+int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag);
 
 #define btrfs_set_fs_incompat(__fs_info, opt) \
 	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
@@ -68,20 +70,6 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
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

