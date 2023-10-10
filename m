Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C57C4139
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjJJU2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjJJU2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:34 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FFE91
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:32 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a505762c9dso74916347b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969711; x=1697574511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak1Eq1xLaehOMQ0y0GL69LpJqddCMtVfYsts+ouyM4o=;
        b=XPLz61xPf+EZbDHSrxu/p0NEG2W1J+9aXT+Vc7PfC6JwLSqkBGoWpVilNPwSxHXtv8
         mL19HAQvE4y3sdNhEfBZlJWpjqceiiqft4XOrs8nmhpio/2rMY+MJcxFExgkL7FNRp9/
         iIrS08d4PriLhzCCIZ9RQ04fw0kP6KeJ3aff8GWilMlM+hBxOERUW9lJigkxBfeHsxc+
         4DKbx2zTiw6BnkZIxqjPCD1RSKFKaglrYIDPjLasYOpDscKLz097UAjXUiCisArNT4ds
         0voyd2VDiI6bb9RzcgzWiyfysT10A4x168tfconBASBH8ewGXOtafDXQClK8pHLs7PSB
         5sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969711; x=1697574511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak1Eq1xLaehOMQ0y0GL69LpJqddCMtVfYsts+ouyM4o=;
        b=ATVOc8Y3arfaNyohSHfr8NByeXL8w/NMWLWxhIkvBPdPPaEddJEzHeuQuguxE5USZi
         kbszOXrdvsHmM3BPhglJ+83eOD+hS9lQje333XQ198vjr1RPuPq+Q2uAjRbaMFQSZPA9
         iqRvhJG8p+pNovfs4izegJWedEtpoHGz1B2bF4bOL+FIZmK1v4qQqOEmxuSjmj8xjIx+
         68ERoFGLbSgBqJPZkrQs8MJgI55zgV+5QFnzonAG7889/c8J2TEGf0gBfEyPv48/ksfh
         SL+oSGTipBDsfbpvwhwRPaTn9ZA1C4WNXkBhYYqKV03yp3XIELqayKaDXwP6uZSOGvjl
         hLrw==
X-Gm-Message-State: AOJu0YxpetQBtL8C40WeCxTaH634afIcN3qMvJqdLMBES1TGmr48fb3W
        5W4X35fNaNrMI/wq6+iSkStPfS1rgKIRdz5B40+C9w==
X-Google-Smtp-Source: AGHT+IHp+EnIiIHJgyuCWCdP+gzIxdvxpQj9ZyP19mYTtMROmiKwXhL5iigQIOVU0AQ2w/vI76HtzA==
X-Received: by 2002:a81:6c8b:0:b0:59f:67f5:66c6 with SMTP id h133-20020a816c8b000000b0059f67f566c6mr19902863ywc.16.1696969711157;
        Tue, 10 Oct 2023 13:28:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i5-20020a0ddf05000000b005a23ab90366sm4637007ywe.11.2023.10.10.13.28.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs-progs: check: fix max inline extent size
Date:   Tue, 10 Oct 2023 16:28:18 -0400
Message-ID: <999dc4783e67f45b00173f1ea869136c52ea598d.1696969632.git.josef@toxicpanda.com>
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

Fscrypt will use our entire inline extent range for symlinks, which
uncovered a bug in btrfs check where we set the maximum inline extent
size to

min(sectorsize - 1, BTRFS_MAX_INLINE_DATA_SIZE)

which isn't correct, we have always allowed sectorsize sized inline
extents, so fix check to use the correct maximum inline extent size.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index d387eb25..0979a8c6 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1640,7 +1640,7 @@ static int process_file_extent(struct btrfs_root *root,
 	u64 disk_bytenr = 0;
 	u64 extent_offset = 0;
 	u64 mask = gfs_info->sectorsize - 1;
-	u32 max_inline_size = min_t(u32, mask,
+	u32 max_inline_size = min_t(u32, gfs_info->sectorsize,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
 	u8 compression;
 	int extent_type;
-- 
2.41.0

