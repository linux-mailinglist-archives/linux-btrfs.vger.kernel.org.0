Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD22B9CD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKSVO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKSVO0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:14:26 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA8C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 13:14:25 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a13so6946304qkl.4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 13:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypXyZEd6FvTvAlybp7R5S3iovl/GLJqpG98MIiTuh+8=;
        b=plTGck/dVzre0rYE1vfYWAlHPlAiVIARUCldly41o8shJiUrE1XlIjOkdpsOi2R1sL
         cf8uzLVblRdrmLYJj/vTzyrpqgXfWsAStBiYFQMe9WAsz31BZHl9iopC0lvrYLxRQdaB
         lia+XlsQFD+GoC3DA1mRKVUgqqwYExZRdLOyawP9lZTvJI2obWmVVO2TVYmeHwPiQFMY
         Wrmxh5qWTV7Z27fdINDCMsZ5cXBZtrMnw78kCrd/UCBa5xHh7iMmDKYdis/xC1EGuWVv
         Fp9oExRmzghBxkaLwb29iPnYzyO/njLHtDRQItR6a7NuYYh7qx554NcrkXct1nxtOu7z
         Yydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypXyZEd6FvTvAlybp7R5S3iovl/GLJqpG98MIiTuh+8=;
        b=W4nWY189fRlN5H7pSIC+cAn6PIl+ePrS9CIj6ILEfRTEodDGWWqGPb/iae+3/57Hgb
         Fwi1iCXRTdN2FvYVVX2tCRny+ZGFCpgEkeycky0H4R1puJ95MOkALIZwXKmLzIsQ/Fgy
         guk5XG5UNH1k/VSIcbB8Q/i6JYinwPfUhP0En1dMS3nWs1gs4S54Ql/xBr2Ms7RkFfce
         JKxcLyDYNZMqPh+g7jx6IzxewIiKt94h2dSB3rJ8oUkGya17IlGzBo2pJdPqkIBq3vNz
         4t/NV+q/g9FRM3GW+2YbMZmzRBj2bN0n/GkEzBwEz1+kjCvVZBsFe0ZLJ50ZfGodV9J+
         Qrqg==
X-Gm-Message-State: AOAM530MgDmM91eQpbtxypOQ29bjLx3QYUNAZ0h6clUJ7sOtOzukxfGe
        0+MedvK88ZXIa0HGvEme/Fby6sH5U8TRiA==
X-Google-Smtp-Source: ABdhPJzqz1csBcfGdbI1cccGxYmbpRtUqQ8kU3tLa232RdNvN7P+IAlINgbxY4b6EiV8uMnOWkkz7g==
X-Received: by 2002:a05:620a:f95:: with SMTP id b21mr13269926qkn.403.1605820464091;
        Thu, 19 Nov 2020 13:14:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r19sm733432qtm.4.2020.11.19.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 13:14:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: fix invalid size check for extent items
Date:   Thu, 19 Nov 2020 16:14:20 -0500
Message-Id: <c85b0bbcfff13bafec48f8cd266fb73b345c43c3.1605820453.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to run down a corruption problem I needed to use
btrfs-image to generate known good states in between tests.  At some
point this started failing with

either extent tree is corrupted or deprecated extent ref format

This is because the fs had an extent item that was large enough that it
no longer had inline extent references, they were all keyed extent
references.  The check is bogus, we can have extent items that are >=
the extent item size, not just > than the extent item size.  Fix the
check so that we can generate metadata dumps properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 image/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/image/main.c b/image/main.c
index e59f24ff..48070e52 100644
--- a/image/main.c
+++ b/image/main.c
@@ -933,7 +933,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 			break;
 		}
 
-		if (btrfs_item_size_nr(leaf, path->slots[0]) > sizeof(*ei)) {
+		if (btrfs_item_size_nr(leaf, path->slots[0]) >= sizeof(*ei)) {
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			if (btrfs_extent_flags(leaf, ei) &
-- 
2.26.2

