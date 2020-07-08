Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97A72189AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgGHOAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8CC061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:38 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t11so18413666qvk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ci5z3yMI3h5IFqCrR0RnubjoKZNhhjifg4W5m/gO7o=;
        b=d+7Q+fKi9A3tdYihFobpUsUw4s2Z0brjIPWkzyxmhSDdITzAMUyyz+LGgKOGYKrWeu
         S70M+2lHcewu0eRUJpPEzzoriokfDVCCHmeYHluFSyuWwlc/QtyIXZSzngJ0Znz0Du9h
         Vs4YYTsxDOlsAea6KpOC8tjeyrpQ23xyheA9hQWOR22oCxaq3U3U4L1YiJgGlGI4ozKq
         hfZmaZD5q+iJ2x3rpUe+U5R6P5wlrVCa/H7DHCiQDVrHA+5jmkm9ePtVRyw6S5J/O0HG
         bUOebyX5dsOcyNstkgFU69qn7FQmpunug+hmD0DZMP2C3uUpzC/zAzSic/KzvXaTHPFX
         8OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ci5z3yMI3h5IFqCrR0RnubjoKZNhhjifg4W5m/gO7o=;
        b=E1ab/4D1Up+vJpY8BOENKgbU1IzgOqhhvA8BUvvO8iK3lsh6Zf5URJZk/FjIb9e253
         H5683cXzffulhZv5Ib2LE1j4wYBQytgOQ6d2i1U9PCYQValkcJFE9aXoWA5aNIaD1Pz7
         NlbP/rnGW74AJaXvdUloFm7UWZ+WPWfRniq2rwL1BD+rDOl7IoXz3LzN87YMDN839Q9k
         LBA2P9/nIXeEuCJvFQ/Vk+5WS0SH8llAq4P2rL/+Tq0pUu8nzekc7YjQ1JLuNv588GNE
         OKDm5VmTTCV8pxNMuHtmLIIujUy/HL3EFC7fLwB+Y/qM8bxTz9FOeoZ+E0Qhw2W91Y37
         jZRQ==
X-Gm-Message-State: AOAM532WTA5nRBrXu21ZwB1ag79zsrzM9qQSk8xVFWk/B7Q/ESR1bTD6
        g3KSQo6GxlV/Lg7G11mKBgrbGR2ziJ+VzA==
X-Google-Smtp-Source: ABdhPJzp0HYy+GldPW3OdNbxFdWEd19YF9lLA8Rsxq3ABUfMeWk+2mQde+SRXIn+wiPF0NVmJ5rQOg==
X-Received: by 2002:a0c:e903:: with SMTP id a3mr56969749qvo.144.1594216837080;
        Wed, 08 Jul 2020 07:00:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i21sm30029717qke.9.2020.07.08.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Wed,  8 Jul 2020 09:59:59 -0400
Message-Id: <20200708140013.56994-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to use the ticket infrastructure for data, so use the
btrfs_space_info_free_bytes_may_use() helper in
btrfs_free_reserved_data_space_noquota() so we get the
try_granting_tickets call when we free our reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 0e354e9e57d0..0a41bdcc14d1 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -277,9 +277,7 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
 	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
 
 	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	spin_unlock(&data_sinfo->lock);
+	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
 }
 
 /*
-- 
2.24.1

