Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6D60D016
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiJYPNM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiJYPNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 11:13:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E616A4E2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 08:13:09 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u7so8785525qvn.13
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2MVn5FbBHJpSxxpyrShxu6sDTgZ2XsEfRyeV3BK9m4=;
        b=Sl4J2mb8cyWvGTRZes00x56FHBGTkl+mWnMno/qjB4u8vPrYg2G3rRak9g48bCND+l
         RwRUPTqMwNu95YkqDyoWpJ+iv65ykGKW5MCIcBGWw1so29BaKFy0kyJx14F2rt708fpd
         yuRJdgud5qEtZL2yXRxPby7z6XizAYbBokSrqKSof6gqYSkEVnqt/RVa3jvYRjft4w+v
         csL0VdJUzsCKrgJ/PjAwkOVOor6jxUYcMxOKy9/iTFzQghsJh1j9LRFg3htomInzUteb
         RilqEX9dr3UMknah3dO9lrVU4180dmr5JWJW8S/HcFgvt/w2QkZtU6Zor8ya1eFnEvrR
         o0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2MVn5FbBHJpSxxpyrShxu6sDTgZ2XsEfRyeV3BK9m4=;
        b=VIE9puStrL09nlmI4RfzftAkIvjs1bWEyPFeLqLmp0X+QAeW5ObO3f7NPJU/2XTaW/
         OOFOzjQxrx0Wdk06fREtMS9MlqkmyLrZ8qRduhawLEVWCKYWoKA/eaWJm10UsLDAfugS
         0pVE4ZNGhIoj9OffIPfoZmzY6kFB2lGhmj1S9LN6MgVlkV9AMdYVeqpdN+gcBwiuWcDX
         JIV150aJZtBWAReucNYiS0SLes4jmewtB5JnlA2KO11fA8IBnRWOQui5eTG9g9xeilO8
         vuKl3u7cSBJy/SymHLTdKhYkwxZM4AP1HAPzxf7EKr6N8WMhAphLTC3itH0W/cuHq4V6
         2p5Q==
X-Gm-Message-State: ACrzQf2sQx7+OsHLTWatMbBOdPiHqMNh3tBKYZWzg8hoeOg3o09AsuAa
        lq9NxpIkSVLKbknuzt/t+S6+P/aRHjWBPQ==
X-Google-Smtp-Source: AMsMyM4Yttvy2rLhciUgxu47ieXyEtJ+WpDNGm24m0nzgvUINvuV4/aQ3OM2ejsvsCtYLwgeeO6PHQ==
X-Received: by 2002:ad4:5c8c:0:b0:4b9:fe5:e7a8 with SMTP id o12-20020ad45c8c000000b004b90fe5e7a8mr22537354qvh.99.1666710788003;
        Tue, 25 Oct 2022 08:13:08 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b003a494b61e67sm620519qtk.46.2022.10.25.08.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:13:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: remove unused btrfs_cond_migrate_bytes
Date:   Tue, 25 Oct 2022 11:13:06 -0400
Message-Id: <f108ebbe38bbcec67c8551f35c68dc38d342addf.1666710777.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

The last user of this was removed in 7f9fe6144076 ("btrfs: improve
global reserve stealing logic"), drop this code as it's no longer called
by anybody.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 25 -------------------------
 fs/btrfs/block-rsv.h |  3 ---
 2 files changed, 28 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index fc1e6c894edd..bd30c3069355 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -325,31 +325,6 @@ void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 	spin_unlock(&block_rsv->lock);
 }
 
-int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *dest, u64 num_bytes,
-			     int min_factor)
-{
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-	u64 min_bytes;
-
-	if (global_rsv->space_info != dest->space_info)
-		return -ENOSPC;
-
-	spin_lock(&global_rsv->lock);
-	min_bytes = div_factor(global_rsv->size, min_factor);
-	if (global_rsv->reserved < min_bytes + num_bytes) {
-		spin_unlock(&global_rsv->lock);
-		return -ENOSPC;
-	}
-	global_rsv->reserved -= num_bytes;
-	if (global_rsv->reserved < global_rsv->size)
-		global_rsv->full = false;
-	spin_unlock(&global_rsv->lock);
-
-	btrfs_block_rsv_add_bytes(dest, num_bytes, true);
-	return 0;
-}
-
 void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 578c3497a455..7e9016a9e193 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -70,9 +70,6 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
 			    struct btrfs_block_rsv *dst_rsv, u64 num_bytes,
 			    bool update_size);
 int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv, u64 num_bytes);
-int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *dest, u64 num_bytes,
-			     int min_factor);
 void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 			       u64 num_bytes, bool update_size);
 u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-- 
2.26.3

