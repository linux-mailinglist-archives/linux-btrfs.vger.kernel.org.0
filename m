Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9836DE7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbhD1RkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbhD1Rjh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2BFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id q4so18919807qtn.5
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5Z+HlITea37yRj2KAzeqd5CgcmKX15/MW14kAP9zMXs=;
        b=yZNhnpHk4mc9ZHevVQ+X7tgeh94NYpyam4/Zij9ISBdvBG9xY6qD8bzXrWikL6wWKB
         QzLw5uwzwQyUQec/PFKa8/1XIijk0yljH0LR+36OghFBi23JsqHY9ADLvwH8V1TkxJ3J
         7Wk/MuD7fvd+WQ/O4/8inONpY5k0zebBRdKZwvHScUsSEVZLebedvn47HcImidRAfVTe
         otq21YRZaCZDKRfNvVGpEy0k4TgrsmeFTwR4pRvRkuurvWmT/Yz5Z3rqWpJUDG7v2zP/
         U19nkye5Ms4RqqaEGvwRUBZXkqEgBXP43yKT5Ga/mjgddFUIrQ8xN2PYwhWO7jfRa0Y4
         BNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Z+HlITea37yRj2KAzeqd5CgcmKX15/MW14kAP9zMXs=;
        b=QVTfeQRF6xBw9+2L4UOnQFkZtDLf2oatgpx5wPTMZuAh6QubrCN9HsPjQ2o6z7q76G
         1JOqilAUcERE0j+W7Fb0ypg2ImXBG3uekGByiSA4DwSmrqWPrAxEvsnO+jOq70bTnGs6
         YrPS0Bg2SN8ZnOhAxRX2Id/qV8I7GTf7OwXGdOztLf/TqNj685tzS96PORqUrmhl2A8S
         ZIhKuV2NzuwoeRIvVRADIrhB3EmiQ7OA0+gft5pbi81LoMAPGRadbIkiLTJiQ7OW82he
         gc3utXiPNogz0CKFS0hkEKMRbpeMkTUWdqbVm5dXRSBlXeX+dQAtWLMzWa1f55tcFDmc
         UCJA==
X-Gm-Message-State: AOAM533n2It7oisc3bpNHI9HFL+cpKXHjR9DCezaIS1SU9utw6wzDIxK
        /Cc0GO0UQmKt22fXVPqiWIeZ0VweyHQbyg==
X-Google-Smtp-Source: ABdhPJyTCHjBCdaIl8BMCJkj0L107ChUTFstY1ueICrnTdBQG8a69wb1gu/GPHakViwRao1SKkJ74A==
X-Received: by 2002:ac8:7612:: with SMTP id t18mr27973028qtq.102.1619631531244;
        Wed, 28 Apr 2021 10:38:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 191sm310599qkj.17.2021.04.28.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: check worker before need_preemptive_reclaim
Date:   Wed, 28 Apr 2021 13:38:42 -0400
Message-Id: <949c99db63e3f5c61dc402deee9ceae3087abae3.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

need_preemptive_reclaim() does some calculations, which aren't heavy,
but if we're already running preemptive reclaim there's no reason to do
them at all, so re-order the checks so that we don't do the calculation
if we're already doing reclaim.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2dc674b7c3b1..c9a5e003bcfa 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1588,8 +1588,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		 * the async reclaim as we will panic.
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_preemptive_reclaim(fs_info, space_info) &&
-		    !work_busy(&fs_info->preempt_reclaim_work)) {
+		    !work_busy(&fs_info->preempt_reclaim_work) &&
+		    need_preemptive_reclaim(fs_info, space_info)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
 			queue_work(system_unbound_wq,
-- 
2.26.3

