Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12D7C4137
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjJJU2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjJJU2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FAA4
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:33 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7b92cd0ccso18786867b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969712; x=1697574512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQcM66izjkkHNOvP6iDeJB5xjXS7gzV4FjRngbaMKvQ=;
        b=Vbx3AEed7lVN/jMCcHBG/jR+2q9bgS7SXXgdRRy8Xp6p6BLjqGDuxDzSJKsn3VSw6a
         g6sDU78+duGoV18a51aWmhqTXLzFeJzc69epj4nLsE/jGQFRQ5cKF9YoHCAd3zwibDBI
         rPbpyN12cVa1IoA3Z2wvWuIAvBP0Jj2gM9gudOpqc578yAWesHEfnacXKpb3QL2aJj0l
         h4E0JgAfCGcPa3Nep9W/AbrggLiecUORr1U/6gOdF54ZiPymuNJB1M6WmxIJGzbgALrD
         uf6/HuGeDncJiL/AVju6ak+NNTo7IKPo2mAsL3LRzECHX+XHKEQrrcWQBhE0yjn65UaF
         GpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969712; x=1697574512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQcM66izjkkHNOvP6iDeJB5xjXS7gzV4FjRngbaMKvQ=;
        b=LT1x650U/4AF6DImYorC6fRNxFYmu1qJboslRIwusF0qC4S5P/AFlRCIZGksKk/G9u
         7ScNc9VdNfdZL1r/y2pBj0CH2w6jU0rPXc9PO3u+nr8LzrfQ+CsgNiBEWjrRGMDL0nv0
         NEmgG1iyjSI5k0zN6f3tqSSHYYVC/3NKeb4e0meaHLAakZOypkC2/mGlfM+mm/SIm+LL
         VJ1Th8LFMN6fKB3glRampTc4Br6Lp/uSl6553Iv8uO4HA1HIstSc0KsyyEwju6gH4K2t
         kN4jQLW0Eyykfu/ls+gCdPhvA9wsGHFAkcsKRfM3+Q9eHH7BsEYtO1E038iI5ZoIXjJj
         TQbw==
X-Gm-Message-State: AOJu0YwFwrbi6Z84vUQnkNAEZ18qT9eYwEHu1rApcsrSbxZ9/p92kH7n
        ChI/f/sOq5O4MCd8rlK7qwrAspVi8of9RItoibnXLw==
X-Google-Smtp-Source: AGHT+IFWnZNCGiFe9IqnpC67uyPvginJ837m6qhil5MvjltxZoO357m1lJ9w8cnTZyKeRmVhExXfVA==
X-Received: by 2002:a81:78d3:0:b0:5a7:a817:be43 with SMTP id t202-20020a8178d3000000b005a7a817be43mr4645258ywc.6.1696969712140;
        Tue, 10 Oct 2023 13:28:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ft18-20020a05690c361200b0059b20231f1dsm3382648ywb.121.2023.10.10.13.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 2/8] btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Date:   Tue, 10 Oct 2023 16:28:19 -0400
Message-ID: <8328d47baed55c7e275eef41ddcab003c2c43e3a.1696969632.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969632.git.josef@toxicpanda.com>
References: <cover.1696969632.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Matches kernel change by the same name.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/ctree.h      | 3 ++-
 kernel-shared/uapi/btrfs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 59533879..6c9ff866 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -103,7 +103,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34 |		\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID |		\
 	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
+	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89..cd00be93 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -356,6 +356,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.41.0

