Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493FD3E97BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhHKShp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhHKShp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 14:37:45 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142C6C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 11:37:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e15so2907732qtx.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xD+VK3L998w69TK+GIGcMqW+brd/MxrzVzDmY1Ufij0=;
        b=hoQHHm0+saPiVOe+74eP6G+yhPNIcnWxhODC3QgUKCJ5SPFjl4sBoRpNs/wH0miDvj
         SiYir2Kpuc6mMJK8eFVrxiBvQDezY5w4evjgbUDrosuQ0EdsXYeqrFNUmts+CHHld8ch
         1iUQNUFCi0gADY0NIbbiXcUDC56SC3+v6JkSYARKhGu0sTmOlAC75kWf8fMG9GTut+jP
         aRlmm7uivk4/iQ8l2AG1YsZwU+hDCr0YT6JeMptbw80MPtPNr5V8GnuIrVPa5HsgDYDu
         BBS+Z65w0iINr39jy+GOn/1uRQzM/ciXonfzBHSHRXnpyVCL7gqoK/H6wzWBHyOPLYUf
         DnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xD+VK3L998w69TK+GIGcMqW+brd/MxrzVzDmY1Ufij0=;
        b=ZM4GsfJiWxK+s313Lndwi5Nnq3JkWCXX857iOt750frDvbYIOG/H2glTC+mPcRaa0E
         bhNjPxRhAnW6/i4W1Vcu91TJSK+zVgk/llw4ESzDlPJdkciI8UVLZBqk8CNeJ8vSqW9R
         mRrrUKknYEpbax8I14RJWcwCPazRlgyTLmS3Uv57PSu9tMqRD3keELuTpd9T2GsFIiC5
         HIXvQHP7ZR0+CO3oFmldxXQjlalUmABNSXTUCSwn3LNgWdQZXfEaL3eOJmXEDsZCnJqI
         /4cTDuU08jyjOusO1TPTAVn4Cf5aPv2eN8Q69VsIMp+es7VRQllGuPM7mxhOb8Sj6n+6
         Tz7g==
X-Gm-Message-State: AOAM531/kWXiFkODrE3xsFDP9LGWxDIGvQCpBq7NrSb6JjgsjaDPcSQW
        iZY+J7mfHISvIrCwm0SCRmemjYDciUupcA==
X-Google-Smtp-Source: ABdhPJztTCx/5084L51L6LtWQ7hfa69eNMV+2VsaeGS/+VQO5DUTF8mj+YSfH5TEhwCZ3Rd2Yxwr0g==
X-Received: by 2002:ac8:4e88:: with SMTP id 8mr87703qtp.269.1628707039857;
        Wed, 11 Aug 2021 11:37:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h6sm31299qtb.44.2021.08.11.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:37:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org
Subject: [PATCH 1/2] btrfs: reduce the preemptive flushing threshold to 90%
Date:   Wed, 11 Aug 2021 14:37:15 -0400
Message-Id: <465ed2e70752cf6922f9ecdc2eaf4f2663654b68.1628706812.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1628706812.git.josef@toxicpanda.com>
References: <cover.1628706812.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The preemptive flushing code was added in order to avoid needing to
synchronously wait for ENOSPC flushing to recover space.  Once we're
almost full however we can essentially flush constantly.  We were using
98% as a threshold to determine if we were simply full, however in
practice this is a really high bar to hit.  For example reports of
systems running into this problem had around 94% usage and thus
continued to flush.  Fix this by lowering the threshold to 90%, which is
a more sane value, especially for smaller file systems.

cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=212185
Fixes: 576fa34830af ("btrfs: improve preemptive background space flushing")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d9c8d738678f..ddb4878e94df 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -733,7 +733,7 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 {
 	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
 	u64 ordered, delalloc;
-	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+	u64 thresh = div_factor(space_info->total_bytes, 9);
 	u64 used;
 
 	/* If we're just plain full then async reclaim just slows us down. */
-- 
2.26.3

