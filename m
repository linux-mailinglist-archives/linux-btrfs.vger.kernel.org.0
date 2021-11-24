Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3245C872
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhKXPU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 10:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhKXPUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 10:20:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D58C061714
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 07:17:44 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id g28so3141283qkk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJMnl51hQ0OwhZ0gFTr7o3/duIRSwAy8JZ2VpMbFu4w=;
        b=H33OD67+XM2JUi4W2SrkckZmmOnXzHfAGnjDrE+tm0Tj7Rvy4OithnDSQi5E7NjUk7
         2hWuPsFodiLqUCebeZuusev3V3r716qlKe0JqPkag4J0xy9ax4Nj+9MaYHWRbra6HugK
         hnpGwQI0kf1bi+kUHQrSWViO+phpfweeOLAJAeuCkryfRSfsFOYo0kxFkGJMxgq5K8+y
         effUKyv7LOnblTfcso0B2ZKs+Fk9q6piZ1eMuyef2eXooAV7JQEm9bhCocI0LjoDS3Ix
         Y5peFhY7IuHPtGZhO32Xh6Y/o0qlZ9HYh/e5fsATORs1Jjq0qTc3XF29ZiDxhQjShCH6
         q7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJMnl51hQ0OwhZ0gFTr7o3/duIRSwAy8JZ2VpMbFu4w=;
        b=uiLQtdCyjDedS2KiUnl6uoszF/jnNQmrOQH4yCR8/6muqCO5vzjZtCjHssToE2t+kf
         b5iBd0na/MVlPIbGGM9l3pRo2nb2QLx1M1BcBu5sBxgFL0/0zKWe7iQXMM7No+6gSyWL
         rOFP/I8BdNz18pe91fZi0wOL/dVOfF9TgiRFRTYDvHZxEFB9HGQhgENbSlzRRW8E8DoQ
         UbVANi1zpA0m1jipJDK+9IXa0Z8DKBhCClCA7BLNm2eMQFOI3/EoGPPCLrBHrpzZnJyr
         7vHYawmCkTwmn3OpEpSk3VtGu6h54AHB3mgwom+pdmUZjtGCPRzqwnUmm6k862kNvUwM
         8VlQ==
X-Gm-Message-State: AOAM531eJKiOFy37iFVFKz9oR4vPwkdsH71H1V1tK8h/iiw2iF2yZyCt
        zpk+sZ4ef3cO6IS/MsM9IW/5lMnSxZDbxg==
X-Google-Smtp-Source: ABdhPJy3h2Z7ck2vWkvPS3yAWIakp+2IWlSXBfpkkWSpcet2rXGoC+AyUyI6iRN59zlVVoqPME7qww==
X-Received: by 2002:a37:f619:: with SMTP id y25mr6712621qkj.201.1637767063006;
        Wed, 24 Nov 2021 07:17:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c3sm9158qkp.47.2021.11.24.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:17:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: btrfs/176: redirect _format_swapfile to null
Date:   Wed, 24 Nov 2021 10:17:40 -0500
Message-Id: <c7b5fe8406c425736f638f4d9eba9fc707a1d9db.1637767047.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since bb0ab7b2 ("common/rc: Enable _format_swapfile to return the swap
size") we started echo'ing out the swap file size, which is polluting
the golden output for btrfs/176 causing it to fail.  Fix this by
redirecting the output to /dev/null.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/176 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 4cd510b6..33f9a061 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -47,7 +47,7 @@ _check_scratch_fs "$scratch_dev2"
 echo "Replace device"
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
-_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
+_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # Again, we know the swap file is on device 1.
-- 
2.26.3

