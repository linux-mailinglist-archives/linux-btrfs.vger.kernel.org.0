Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574063F8A58
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhHZOpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhHZOpc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 10:45:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D5C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 07:44:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n12so1938796plk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOjtI3qx0M254KDq+vV2lIwjyICRboqTWxAI+H38ssM=;
        b=I8xq/NoOFhh/5x68+L8ADT+Ep4HxR1ViP0XuLL7ZbDp0uRZaY9XoQgO3dNXBZr3rae
         MaH9NQnf0wRzcSqeW8zB3DfopN0uXX+bhyr9mM7CBIwi5yarenXmFOEjk5/WQcxHyX/A
         JM/NwRBlTWlDN1u4RzQe6Ntz4/e9iXKUj+ZxN2y1kkUFUm+sMb994+Sa9vW0HwNcBlVy
         Yj27lPEEBhoDhDGrgfzunmYeHh0K24EoRJA/r2eqJz2gGXWa5Vuynf6IgIY0+iTQFl6j
         +A2nunmksb7jS2/y8g7Qx+dD75oWUANvCqXTTG5UwlTi75/+mWh+tILMd3d2LV/wVtiM
         oX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOjtI3qx0M254KDq+vV2lIwjyICRboqTWxAI+H38ssM=;
        b=FFZ+tse/wDsQ0EcgIfB1nbSUyuM2R0N8L60smetKqJhZ0iI0yDZnScf/oTY/H2QF3r
         X4TgFv9KGvj7XafoSgb5y5sCwTTvGhI3GDzLQwlgS3z1VDbrIHQsOu4T6CWQ2DjOmo0v
         IQPG1j5WuEjhBgKX3w0KJEMpoAciDWcH0AVPn8EIg5Azx/w+mYP+Hvj1YxAu8Q3OMC9L
         Z92khSBjIQ4N09/B5n0qjw+74Kz8aumZWjLDy2Z+kXWYXLJA4bjfkqU1C964A8SZ/PYN
         5P3K+SeSKk5YHbI0v6/xllRm/ar5yotC1quorolbUUICwol6q78xNi3Q/pmehEzuZJcD
         DgZA==
X-Gm-Message-State: AOAM530wFUinGeh5EHNzIU1ddX3XP4EZdHG4YnKA6Gzdry8xvEnhkYOx
        XrbOB6X9nVcAVttvMDiaVEU=
X-Google-Smtp-Source: ABdhPJx8PNlI0Wl9kkfQvrhH73q3j3ItVYoYEgdppEXuoaSVqGar6snGgPjopUwsDXYAr/oHEb98EQ==
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr16686522pja.114.1629989084595;
        Thu, 26 Aug 2021 07:44:44 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y67sm3390306pfg.218.2021.08.26.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:44:44 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     David Sterba <dsterba@suse.cz>, Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3] btrfs: reflink: Initialize return value to 0 in btrfs_extent_same()
Date:   Thu, 26 Aug 2021 14:44:36 +0000
Message-Id: <20210826144436.19600-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch fixes a warning reported by smatch. It reported that ret
could be returned without initialized. 0 would be proper value for
initializing ret. Because dedupe operations are supposed to to return
0 for a 0 length range.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Removed assert and added initializing ret
v3:
 - Changed initializing value to 0
---
 fs/btrfs/reflink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9b0814318e72..c71e49782e86 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -649,7 +649,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 			     struct inode *dst, u64 dst_loff)
 {
-	int ret;
+	int ret = 0;
 	u64 i, tail_len, chunk_count;
 	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
 
-- 
2.25.1

