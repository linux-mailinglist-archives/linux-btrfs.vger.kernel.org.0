Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19071792AC2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjIEQmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348682AbjIEQSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 12:18:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BABE10DB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 09:17:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76dbe786527so132163085a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693930530; x=1694535330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c+4mgWymJllYxdw6MPgfiSrmi/utWGrIQjRR/GK84A=;
        b=ipHQ0GPj673JTlRYZSSAc5ANvfFqMGsrLjJb90dwJQgzl1caYch1sj6XxgbULFNg1G
         n5s00NX3uByw2YdYTWMPggAqbfAflzDdtwaSh+7a1rzrwuAThjLmcxIotu2aFcFdmRoJ
         QGGcVmD6yRIwQTrHoPcqha/IUOmArdHCofuPjs2Px16wTrPWE7AMzkN64XgFQ4CemFCM
         1gNXfUgxViN4up8orZlJ7HTuowbX0/t/GGiCa5r1+6SBXMGLTJ3t1wkXdfIBikatoV+g
         R2gCJfJVFXMDX8wYo/LjSKAqeAm48ysZ/1VrbE0QPvY0QkKuYLe0Odqt9hd+NqTkd//o
         0uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930530; x=1694535330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c+4mgWymJllYxdw6MPgfiSrmi/utWGrIQjRR/GK84A=;
        b=jMNEVD2CzZjFOjGgTgEm9Rc/FRtNv4Kflp+osczX0bGoGjSoV0GZ7o1MgJfTv/YxE/
         Rsd4vW43qXjMlbfbtSbnMAj3yPr/7v7RWYU5JUqfc3+dD/EI8uS0dX657ZN2jyG6cQAJ
         7b/0H6ynkrTgEaos0kQiWmByOmIhE0lJu3kj+P48hSQ1QUHDWsxSiBYZ0fLxU5XVInYg
         o6LX1U0VyBG5AgpYb+JPbskEJsTVajH3iZ4WG/et4RfLaF2NzaRljVt8BM5ZgF/G2Xrd
         /o2ioFPLF9Zkp9bf/yYsEnKoZ7xmrdrRCGsVmLoHhvDvlfRVz1rlCuYwr8rRQjaXQHps
         nriA==
X-Gm-Message-State: AOJu0YzkTywSo6m7gdm4QrUoc7Z9QgPqCDLC3GiY/+ZMqTVBdiZyle/m
        fOJ2WDJV/dfrdz/MZrSaZD+viS2loMn2J58VRA0=
X-Google-Smtp-Source: AGHT+IEmT0fQxnnk9fw3K64UJvFuaNIZVt/sRR7rT/ws+83t8GzX74J1YmgahK4HyDeBzt9sFRQMZw==
X-Received: by 2002:a05:620a:f14:b0:76c:9eab:41ad with SMTP id v20-20020a05620a0f1400b0076c9eab41admr13105006qkl.32.1693930529960;
        Tue, 05 Sep 2023 09:15:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a167b00b0076825e43d98sm4203186qko.125.2023.09.05.09.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:15:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] btrfs: make sure to initialize start and len in find_free_dev_extent
Date:   Tue,  5 Sep 2023 12:15:23 -0400
Message-ID: <3223c8646dd74cc0252e3b619a7a2cd6b078d85a.1693930391.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693930391.git.josef@toxicpanda.com>
References: <cover.1693930391.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jens reported a compiler error when using CONFIG_CC_OPTIMIZE_FOR_SIZE=y
that looks like this

In function ‘gather_device_info’,
    inlined from ‘btrfs_create_chunk’ at fs/btrfs/volumes.c:5507:8:
fs/btrfs/volumes.c:5245:48: warning: ‘dev_offset’ may be used uninitialized [-Wmaybe-uninitialized]
 5245 |                 devices_info[ndevs].dev_offset = dev_offset;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
fs/btrfs/volumes.c: In function ‘btrfs_create_chunk’:
fs/btrfs/volumes.c:5196:13: note: ‘dev_offset’ was declared here
 5196 |         u64 dev_offset;

This occurs because find_free_dev_extent is responsible for setting
dev_offset, however if we get an -ENOMEM at the top of the function
we'll return without setting the value.

This isn't actually a problem because we will see the -ENOMEM in
gather_device_info() and return and not use the uninitialized value,
however we also just don't want the compiler warning so rework the code
slightly in find_free_dev_extent() to make sure it's always setting
*start and *len to avoid the compiler error.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b0e441227b2..08dba911212c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1594,25 +1594,23 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 	u64 search_start;
 	u64 hole_size;
 	u64 max_hole_start;
-	u64 max_hole_size;
+	u64 max_hole_size = 0;
 	u64 extent_end;
 	u64 search_end = device->total_bytes;
 	int ret;
 	int slot;
 	struct extent_buffer *l;
 
-	search_start = dev_extent_search_start(device);
+	max_hole_start = search_start = dev_extent_search_start(device);
 
 	WARN_ON(device->zone_info &&
 		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
 
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	max_hole_start = search_start;
-	max_hole_size = 0;
-
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
 again:
 	if (search_start >= search_end ||
 		test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
-- 
2.41.0

