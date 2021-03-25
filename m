Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66A3492C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 14:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCYNK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhCYNK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 09:10:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E8C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 06:10:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l3so2007865pfc.7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVc1T/P0hNwQsCFVChQjsTf2n7slzEVl0RZcBHaX4Rk=;
        b=E6AH2w9ETdZIiT/CvtlmyZuuuz6kcH2etNxQRnikV9PQZvsmGVBFXRb+hCvgCy0W6N
         6T9Hoc1nBRNriGOYDxSjIBvnbB25DDYI78Mg6tQn6rPLbpx0gl3T3g5nRwhPLrOiOGh+
         I0oWsOyGDEEkIldPopw4Bai4raSFutvdxDujTevD3bmTE0U+t20PJzL2WmhJHUt3o+9l
         K0Gk/sHQL5ESOnVFzVprBAwXts+iIXNkhSzO5YGL5mw3mkwqVrdK0cbvzEII6qooj5Zk
         1hnvAUrsHfC3QncYRPcCQJJ87OEYBsGxjOdVNOTkOUCuCsibb3owocRZuyoh5RG0RiJn
         EO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVc1T/P0hNwQsCFVChQjsTf2n7slzEVl0RZcBHaX4Rk=;
        b=JetzQrCGgTXoJKbbagc1XDKXBO2I4+wlAY39fmfaGu5xnCaq+0gmDhorZ8YulVaOfC
         YAFB5agp2RCz3aK5qlnvWxOczBINA/mMvdmmgb0UMJEmn5+SXfGgSbn0XTROv48SdYOm
         8zbQQ+hy2gRutuB2VwfVfeHug7ijm4CPO66nxDulILWdK9GD0FKzeYZmLhlWwL8klAox
         mLfOvSNNBOZHE4Nx97r6LzEkroDQxuhFeOReB3AS4brgCjVIGrtc9kn6lXmapaLQR1sv
         YY6VSzp4oQqwAM288yMZjN3Xp1luQolpptVQFmFTYVOPwFck7Vv8sLd/40z5gEqpA5IB
         TKvA==
X-Gm-Message-State: AOAM530GjBWou7xxRjp5T6yrpf1TpR0zWR+JF7uqbVdy8Rqc43Ss93Ch
        kBvbAvimlm7X7FolYPYMF39f2GpUlPF/W20R
X-Google-Smtp-Source: ABdhPJxoY4jSvGwUbIDLBDD29O0FXnoZf7OXtKDa+DExZ4xKUvjw9baLSwIGZUPRW20YAH6N1T7Snw==
X-Received: by 2002:a17:902:fe07:b029:e6:6cba:d95a with SMTP id g7-20020a170902fe07b02900e66cbad95amr9599252plj.70.1616677824858;
        Thu, 25 Mar 2021 06:10:24 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id k11sm5513679pjs.1.2021.03.25.06.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 06:10:22 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Fox Chen <foxhlchen@gmail.com>, gregkh@linuxfoundation.org
Subject: [PATCH] btrfs-progs: utils: fix btrfs_wipe_existing_sb probe bug
Date:   Thu, 25 Mar 2021 21:10:08 +0800
Message-Id: <20210325131008.105629-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_wipe_existing_sb() misses calling blkid_do_fullprobe() to do
the real probe. After calling blkid_new_probe() &
blkid_probe_set_device() to setup blkid_probe context, it directly
calls blkid_probe_lookup_value(). This results in
blkid_probe_lookup_value returning -1, because pr->values is empty.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 common/device-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index c860b946..f8e2e776 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -114,7 +114,7 @@ static int btrfs_wipe_existing_sb(int fd)
 	if (!pr)
 		return -1;
 
-	if (blkid_probe_set_device(pr, fd, 0, 0)) {
+	if (blkid_probe_set_device(pr, fd, 0, 0) || blkid_do_fullprobe(pr)) {
 		ret = -1;
 		goto out;
 	}
-- 
2.31.0

