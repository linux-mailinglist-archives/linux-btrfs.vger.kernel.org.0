Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86760E8B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiJZTLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiJZTLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3BA139C18
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cr19so10745579qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPGamWvxIV//rvxE9Igwg+6E1rzOeRNd2q8LtG5EXFg=;
        b=qkqksgP8I4cbvpQg4YeKhX5MSrLrHD5OYcZmRu2xenclBWGXUiyQsXVk9fgHD0nsbk
         +g4tz7cxuCgvP1/dqY5J/0MDQC9xEF2hRYq7syZ6fT+sCqVxQ6V/2UM9usSzX9FWLs7H
         Oo3zGKgshwCLuKHpu/XRzpyKOC5lrot7k9b6WMt5Gd1yhtFpVGDdufZSYWFPBwdXnWgF
         tEqwtD1zB4o2p7eJ/S22B8f2OsRIA7Nryzc/qovtjj9gZTWYQj20lSOjN2A4uSJGBFrD
         9roANR1zgynh9W9gydTQjdJtYAFVnMUHNScpZCX6PEAuMOovA9rG+hHXtZMe6xjaJejt
         F9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPGamWvxIV//rvxE9Igwg+6E1rzOeRNd2q8LtG5EXFg=;
        b=6P0tRH7q1G112vfnGf6tO/kjy4gs9m9Bg9NRb/aU5eRhkaoQWvu/e5Gm/hS1CcdfUd
         q+q2LNziAZouGqCjLkVGF9pcOA26sJ5BmJl7w25uqLkyS6g9DC/XeK/eYfBhSssrU3DN
         hx0CYFn15dibGX54U3y9I4yAtwEDvzo/6CIm+ADDU2f0oheWU01pZcw43jy5Ss9+i9+D
         GQVHID9UAkNClfHmFGrdEBvgrhhldV4M8Dj7UYSoOLyacDqtu89AbXX/9KVPZoqtn5y8
         ezV/UrkrPKc8XNg0LYQMkgRtLXJPCd5BbiKPmS1EN/oP+wthyI5W08aEiG/ccwCyJtq0
         SrZw==
X-Gm-Message-State: ACrzQf38HW8cX9XiK6W9LLeNSNGQPOOpuvYr3/KerxANoNEjjswyKLm+
        OraktaGKhY3X/rofLWPEJzDVHLI0WnF5mw==
X-Google-Smtp-Source: AMsMyM4jxN+YTrywXSoKf3lSCbll8dyZuD9RfoS8pjykWyKho6C41/G+Yp8VmXIM1JuCGnHxmEl40A==
X-Received: by 2002:a05:622a:489:b0:3a4:b9dd:7af6 with SMTP id p9-20020a05622a048900b003a4b9dd7af6mr7188248qtx.511.1666811324965;
        Wed, 26 Oct 2022 12:08:44 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a454400b006ce2c3c48ebsm4353697qkp.77.2022.10.26.12.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/26] btrfs: convert discard stat defs to enum
Date:   Wed, 26 Oct 2022 15:08:16 -0400
Message-Id: <57bb11b786f8b8d28a91b031eae0d755e7a1ace6.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

Do away with the defines and use an enum as it's cleaner.

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index cab954a9d97b..a855e0483e03 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -48,9 +48,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
  * to make it clear what we're doing.  An example is discard_extents in
  * btrfs_free_space_ctl.
  */
-#define BTRFS_STAT_NR_ENTRIES	2
-#define BTRFS_STAT_CURR		0
-#define BTRFS_STAT_PREV		1
+enum {
+	BTRFS_STAT_CURR,
+	BTRFS_STAT_PREV,
+	BTRFS_STAT_NR_ENTRIES,
+};
 
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
-- 
2.26.3

