Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86BE64F23E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLPUQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiLPUQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:11 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A278659B3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:10 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a16so3577529qtw.10
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRj2OndmReLHyD2b6N31Fk0hqgMcbE8LEKZdUR1+ksc=;
        b=oD1mfSPOdtJgKnQGNAHxGKB8r8A0T+Oj26OHdGD/owYbmO33h0Ltyb028aei6dXJ4b
         bUDCh+nRKMfnQbuPRbzR00lD69lG20rpHm3oxnv1TO4D7HY2XsouXj8XfyX8H31O6rM+
         Qk+HotqI0sJ6NLt06Gn22RZIULYFYG1YlIf3+S/j6Sak48nbVrp+5kGAuUaybHIQeCfA
         Rmb/SVI+xYDAgZTTvos7wsfGucHzm/fh7ZvnS6fScxZ+RmIWD45yArLdnFeGtRZFqdEL
         fwgHos7VzLOGbvbvf7R6EFFkRX5u1IhLIChKdgDX+XPExyR09oYnHjhBKI/NecSzDdmb
         mPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRj2OndmReLHyD2b6N31Fk0hqgMcbE8LEKZdUR1+ksc=;
        b=KvLi2ma9taryGQ6kTnERTQ4xaIEV0m+CWar5tsQT2khoz79Vrj3W58haZ61rue54Ys
         AfgGmgYYqSKH273dzfq+sgggNGxqntCik+X5pSCTQ2fRWz/ovuW51a9Ysqpr+j8m/Gxu
         kZrh9ZlSeIH5GT9Pi3mpneF3VTrH9f3eez3lgf0LkbO2qCBewc/hF0IMMVWjvbJWw64L
         28ZQjchPAYgJiNYl3FhHgpkXgrdDLAPM3Eaif4XdxfmrAyiaBkfG2/fKcIxDtewCkeNi
         9ICf2aisPS+iIBSZwr7SO1LcKlURzOBN+ZEJjPzmo9zFaiHhTRyjoWyKQm7GBERUqMgk
         EKFQ==
X-Gm-Message-State: AFqh2kqr0zFbMX2W4URqbtmGL1by18eCGYUxU7ip3JNXSBy/Xl057FwP
        eVzFmc+UOFXxywGVQPPuGdQsZ2RZGUr18g91iqQ=
X-Google-Smtp-Source: AMrXdXtulDeu8SBFBNMIlg3mJNxVTaoPuZUCUsYqfs+x0I3lhG6bcGxO4EPSngvriDRPbBdXEjssQw==
X-Received: by 2002:a05:622a:1c14:b0:3a7:ee04:9ea7 with SMTP id bq20-20020a05622a1c1400b003a7ee049ea7mr962255qtb.16.1671221769360;
        Fri, 16 Dec 2022 12:16:09 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r3-20020a05620a03c300b006eed75805a2sm2019807qkm.126.2022.12.16.12.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: extract out zone cache usage into it's own helper
Date:   Fri, 16 Dec 2022 15:15:56 -0500
Message-Id: <af6c527cbd8bdc782e50bd33996ee83acc3a16fb.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
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

There's a special case for loading the device zone info if we have the
zone cache which is a fair bit of code.  Extract this out into it's own
helper to clean up the code a little bit, and as a side effect it fixes
an uninitialized error we get with -Wmaybe-uninitialized where it
thought zno may have been uninitialized.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/zoned.c | 73 +++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a759668477bb..f3640ab95e5e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -216,11 +216,46 @@ static int emulate_report_zones(struct btrfs_device *device, u64 pos,
 	return i;
 }
 
+static int load_zones_from_cache(struct btrfs_zoned_device_info *zinfo, u64 pos,
+				 struct blk_zone *zones, unsigned int *nr_zones)
+{
+	unsigned int i;
+	u32 zno;
+
+	if (!zinfo->zone_cache)
+		return -ENOENT;
+
+	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+	zno = pos >> zinfo->zone_size_shift;
+
+	/*
+	 * We cannot report zones beyond the zone end. So, it is OK to
+	 * cap *nr_zones to at the end.
+	 */
+	*nr_zones = min_t(u32, *nr_zones, zinfo->nr_zones - zno);
+
+	for (i = 0; i < *nr_zones; i++) {
+		struct blk_zone *zone_info;
+
+		zone_info = &zinfo->zone_cache[zno + i];
+		if (!zone_info->len)
+			break;
+	}
+
+	if (i == *nr_zones) {
+		/* Cache hit on all the zones */
+		memcpy(zones, zinfo->zone_cache + zno,
+		       sizeof(*zinfo->zone_cache) * *nr_zones);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
-	u32 zno;
 	int ret;
 
 	if (!*nr_zones)
@@ -233,32 +268,8 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	}
 
 	/* Check cache */
-	if (zinfo->zone_cache) {
-		unsigned int i;
-
-		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
-		zno = pos >> zinfo->zone_size_shift;
-		/*
-		 * We cannot report zones beyond the zone end. So, it is OK to
-		 * cap *nr_zones to at the end.
-		 */
-		*nr_zones = min_t(u32, *nr_zones, zinfo->nr_zones - zno);
-
-		for (i = 0; i < *nr_zones; i++) {
-			struct blk_zone *zone_info;
-
-			zone_info = &zinfo->zone_cache[zno + i];
-			if (!zone_info->len)
-				break;
-		}
-
-		if (i == *nr_zones) {
-			/* Cache hit on all the zones */
-			memcpy(zones, zinfo->zone_cache + zno,
-			       sizeof(*zinfo->zone_cache) * *nr_zones);
-			return 0;
-		}
-	}
+	if (!load_zones_from_cache(zinfo, pos, zones, nr_zones))
+		return 0;
 
 	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
 				  copy_zone_info_cb, zones);
@@ -274,9 +285,15 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 		return -EIO;
 
 	/* Populate cache */
-	if (zinfo->zone_cache)
+	if (zinfo->zone_cache) {
+		u32 zno;
+
+		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+		zno = pos >> zinfo->zone_size_shift;
+
 		memcpy(zinfo->zone_cache + zno, zones,
 		       sizeof(*zinfo->zone_cache) * *nr_zones);
+	}
 
 	return 0;
 }
-- 
2.26.3

