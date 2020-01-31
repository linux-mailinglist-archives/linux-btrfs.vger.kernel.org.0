Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5B14F4CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAaWgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44906 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgAaWgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so6679440qts.11
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmcZmrW0/o/7qkPrbKGRRluJBaRYm1tr9cIsIRSlx1o=;
        b=tW6Et8xFEqsxst/b0QVYfuARZG0G369f0nlBlU3rU2NDDqHY08uqM6CIUzCzmNcPB4
         ygH2aYVI+wbLR+GAdln3bM8yXtewmmpepBx01i/nAvOtXTFR49QoCoZuWf992/fB0ECY
         Z9Si7whLhZk8O65mqtpHBcXUwlnvq1/9my4Lnk8SJKCbEJPiOvtDaBPERcB/e/rhJkXb
         WrSPFYPpEB48nBI352SRzL1ZVpqXZIpQzjWF2s7pJBYIhYNie8/H24ddxVSZAkqRsqmX
         txwkDiuw+e5Z3cVU8eTeKcR7AcCqMFIkGMfLTFNQo6rkjTv6pA+3oLC0Q2Z+GhvmiR1S
         hVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmcZmrW0/o/7qkPrbKGRRluJBaRYm1tr9cIsIRSlx1o=;
        b=J4JTWNcR7FK/MtYrrv+Iksc54tuug3gL+yzjO6ohjek+vusr/mTRBn3VbA9O98/uwv
         oLe2X3pvAi1yU+LJKMLSmE0dZ4QYqw06UZG230VJnBwLj3RypjS/Vpzf72GWYEIv4wWZ
         VIA8iYrls8VuZ77WY6AAWfvsvS5IRTJwkmoHDs2+Ol5vLe9ow73tcTYzRMcKgoXeTUyS
         vp5p2/a4SMg4uiCKyi5GpFBs1lt7STkkn+Dw8wIfOVAVBRsLmCPgt5jcu7tQrOC7YH9h
         jel63mzb6rLbBvN5CM3H2YjCUJGbYryOLb4Jbby/Rpfca+PKMGSzZFf9K3tHxjSwAegQ
         /L8Q==
X-Gm-Message-State: APjAAAVo5lpKQ3gQYfDe6iAFfVOSNC7wjTSsQRYqwN4H6BpzTX+8SOZh
        JnUsgeQetdIPv7yXH0+PBV2WPODNoNuTGA==
X-Google-Smtp-Source: APXvYqyeXd8Y547vW1FA3KyCea1U7ThhreLwfEpV+M460jem2DmSJAQ4tDBYKb454yMXVEWPTfGRsg==
X-Received: by 2002:ac8:3853:: with SMTP id r19mr13151040qtb.69.1580510181865;
        Fri, 31 Jan 2020 14:36:21 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s42sm5718033qtk.87.2020.01.31.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Date:   Fri, 31 Jan 2020 17:35:53 -0500
Message-Id: <20200131223613.490779-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data allocations are going to want to pass in U64_MAX for flushing
space, adjust shrink_delalloc to handle this properly.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 671c3a379224..924cee245e4a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -363,8 +363,19 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
-	items = calc_reclaim_items_nr(fs_info, to_reclaim);
-	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	if (to_reclaim == U64_MAX) {
+		items = U64_MAX;
+	} else {
+		/*
+		 * to_reclaim is set to however much metadata we need to
+		 * reclaim, but reclaiming that much data doesn't really track
+		 * exactly, so increase the amount to reclaim by 2x in order to
+		 * make sure we're flushing enough delalloc to hopefully reclaim
+		 * some metadata reservations.
+		 */
+		items = calc_reclaim_items_nr(fs_info, to_reclaim) * 2;
+		to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
@@ -569,7 +580,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2,
+		shrink_delalloc(fs_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

