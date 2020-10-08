Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD0287D72
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgJHUtL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJHUtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F539C0613D3
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m9so6276373qth.7
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjZgctdQgK8PeLrZMsiAb+aWb1LbvU4driBerUU6Nkc=;
        b=BBoCNtVADtL9omXcFb+pV9zz5jYOTz0wP7zuMZGOzBirX0ziQaLpbXk1I22kaRS352
         ov9STNmaM1csw8KY7+/ZZychF6AXWePaJM/rkKiFqG3t3gFfDgTzdmRg+94tYKMTTX0Z
         Io2jODV9aa4tT6HE00dyZRy3oPSbb/ccqy1SSegs8a96+0SS1REzpQUKfHkQXRpDhwMc
         DLBnj+uEcYXEdeMvEon7DvxB37gzaGvT7YVIzYftqYAifgSHQ5yHQM6F/JtDfcyEb1an
         8PyBqhXE+MQt4g4M3ZGe0YyFwjtIrDfzpH8oVlpepzMkKTMiNwt0y7GGcqpbPi7bIC1H
         PgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjZgctdQgK8PeLrZMsiAb+aWb1LbvU4driBerUU6Nkc=;
        b=PkN03ju+U8wQfv7R36YHimJLGHZmViU7t9CbDzoAm3btATKPydgHllaDGKQNiTOFqT
         e2nN4+ZVZpJeABPCF0PqUz0ntvLyKv1kyHvRvYk/wqgpZF45LSMXj45FkKCjwS4lyLXS
         nS1vbahhJQbmkoQ7RmygL0MNLCYo8bqeUdcmknBNa6cx50a3hyhgC865ayNHbIoVWVlD
         ILKcN9e8pJvVrVR2fcrqs3EZoyrQh4rCN0bWrwz1ZumKXQg/7+WiirkXGW7aMHgbePbh
         K7yB6hAbp1U0Gz7BVco/5Ijj6X06qK/3E1xbyVzan5TO3IqFd4jHbBQzcRuCxvwwdrmf
         fVfA==
X-Gm-Message-State: AOAM533ODZjLJfV1MFNPLkt+UBzNTUsuQoviNtcFBFZ7SOZ/pbQ8jQVJ
        PmIPclJgMYp+j43e510EWIqnvmCrxW0o/uWI
X-Google-Smtp-Source: ABdhPJx/WKyapGPrxaN9+Vb0Ns6WCXW0XU24pyXjKZwkftgsVFc50MfyENJoeWLdiKzf7GV1lDsNng==
X-Received: by 2002:ac8:6618:: with SMTP id c24mr10401087qtp.125.1602190148557;
        Thu, 08 Oct 2020 13:49:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm4868419qtg.51.2020.10.08.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 06/11] btrfs: check reclaim_size in need_preemptive_reclaim
Date:   Thu,  8 Oct 2020 16:48:50 -0400
Message-Id: <a5656914f9b6095aed984f329c02938d138e2d68.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're flushing space for tickets then we have
space_info->reclaim_size set and we do not need to do background
reclaim.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f16abb214825..7770372a892b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -814,6 +814,13 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
 		return 0;
 
+	/*
+	 * We have tickets queued, bail so we don't compete with the async
+	 * flushers.
+	 */
+	if (space_info->reclaim_size)
+		return 0;
+
 	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
 		return 0;
 
-- 
2.26.2

