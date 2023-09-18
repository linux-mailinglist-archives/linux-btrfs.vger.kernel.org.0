Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0036F7A4EE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjIRQ37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIRQ3q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 12:29:46 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91A86BC
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 09:26:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65637c04014so11856786d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695054401; x=1695659201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QHcjmABnlZEaFIuGOP1pDjFbE7OjIHdfMwuO+6fVSo=;
        b=ePV48g+wxyH3fmIQJ2uNYqHX9muwJOgGswsW4d7cEh6P6aB7KRX8beYYDFFLVvLXdX
         L3+WUOgYMPIRxdCijSYiMgJgcKu+HCnlARxT36qBhREQ9aBoDkxYHXOQiPaAJYDhOqA0
         AgBykZ7H916Y+OQb6/3NS2KIERaUsZYJJ1ef1tWObpD1yWksyh1rKaauAxYnHqQ9nBOA
         ZptqApeaKucMp4GB8rAkEiEHJd0zVStL+sdjhpswjiQU6TyWDZFUG6s9lzR1JsCByGwA
         /X2n+9R/6h9M4r9FQM7ANF1fBZXmsRuQ290rxjOSU5A19/Lzk00RFI7XCubgyxWwiGRz
         6ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054401; x=1695659201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QHcjmABnlZEaFIuGOP1pDjFbE7OjIHdfMwuO+6fVSo=;
        b=qivzBwTGagRRUQiEOssQuGGMZUPa8T0GNFbGO+2D23T7JzGoEXiUHWE6wYH12G96mQ
         70hbd/GW6uHS8K95MsEUffu79K6uwhp6vyxsRhkS9jEp/dDIimAcNI2ypV47NjRlHFxU
         kAf9xyUYhfyLWoaqq7+T5RwuEnOlBSlByMShsJUB+/DtMGR2SV9nbZaxw8fP7fIt/jAn
         UdpAiWz2o7HeLPwA7hFYVjSYUHGBRKzAOq4sKD/OAHlyu06fERQCaR0XWdef11SHF9Wa
         Blz7ogDnRwWu5FkMqZpM6Ho1Zo2J0McvnJVDljx/6VvBNrgkDSpQbjHCoM3hGsqBDUSe
         vFKw==
X-Gm-Message-State: AOJu0Yy0Nd0XReFpFZJ2YltIxJOEc9nzwoKDySb/YGFavTslRS/K/O4O
        8PdCWqNWb6yRGzUgJZWaFi4mMDAVROysAULtsAB/Ig==
X-Google-Smtp-Source: AGHT+IFKQ7mxSR7tvg7UxWqDjtsFDb6WFzjTt3tpMFnKOwx6CJ5MqjerOUgXU/GiZhpPluvKevasqg==
X-Received: by 2002:a05:6358:9385:b0:139:b4c0:94d with SMTP id h5-20020a056358938500b00139b4c0094dmr9873294rwb.12.1695047695996;
        Mon, 18 Sep 2023 07:34:55 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n6-20020a0c8c06000000b00655dd38f65fsm3507190qvb.114.2023.09.18.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:34:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: properly report 0 avail for very full file systems
Date:   Mon, 18 Sep 2023 10:34:51 -0400
Message-ID: <a9e6b02e9eb7a0532c401a898661b0511c31d0e8.1695047676.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

A user reported some issues with smaller file systems that get very
full.  While investigating this issue I noticed that df wasn't showing
100% full, despite having 0 chunk space and having < 1mib of available
metadata space.

This turns out to be an overflow issue, we're doing

total_available_metadata_space - SZ_4M < global_block_rsv_size

to determine if there's not enough space to make metadata allocations,
which overflows if total_available_metadata_space is < 4M.  Fix this by
checking to see if our available space is greater than the 4M threshold.
This makes df properly report 100% usage on the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index cffdd6f7f8e8..470ca9238544 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2117,7 +2117,8 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh ||
+	     total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
-- 
2.41.0

