Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738C115114C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBCUuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBCUuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so12602852qto.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Gw/2qbonorOwSTxppkLhNicTrDiDL96QTu0sp3cklM=;
        b=QtbUGBNa9I9inda3tlybH4FZcLBdl/EEgKiwB1GdHEeGWtvEXPlHNsI1MyTYHS6HfT
         iYY+P/emnjb7PzDIn7fpi9Z7WZbFpP/p7agTL9lIsk6WwlPHj0TIVmxL4zCEXH/g0ss/
         i7REVMFPSS7sNxnVyL8IT77o5wzgJBRUdJ16EcGd/eIeNYU0wZrzg+IoIbPIzkUtSaMS
         hV24rTXnFyPqwutCrCPEvsw58QATFPI4Au4O3W2CrQRIMGW5epBrf+boEDd7r/Ced5Zz
         piO310SFLN/RP53LLdyxhvG4unwEvE91gzAwxmLbU9MQqqbQ9D8/1/LNirYFB3DvYHUQ
         j+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Gw/2qbonorOwSTxppkLhNicTrDiDL96QTu0sp3cklM=;
        b=s1O+hsytyOtuiNR5R8TYY++fqo+U30oFGTUcA5FU062XaZr1nlJM0peiN+TC03Y1Zn
         kxPXVn/FEcnasyJ6VlgCxAHz6XU0+qDtcOC3cvPl0zofUJ0Gu8Jpv/2BLmhaCUvUqcuX
         ZELJQS6hkmNli6fxjilL+1AECmlISoKU46bdLGvHhNZ1KOIVuDVr6T0r5ZL8dxn/lblC
         yhM3bpYFsDGt/44fBP6zL7U8XjRyuU9rrY5bH96NDZtn2Eef/pup4WrMh110EwKb2CNy
         4ORb6cnwMgOR4yF9QwmT9glpDRCzoUJBrEEr5PJH/YJ3tU2EzuhnTTpbf2wNfKfiEqZp
         0lZA==
X-Gm-Message-State: APjAAAULP/tx/oGP7GfmcamJomQEnccmOKhyT59HF1odgd998lLkBcCX
        IS5P4sbgdg6nsCsq3Apy1FoabvINdG+0Fw==
X-Google-Smtp-Source: APXvYqz2tfllyptbrYm1ilermyuk0JiCOpa2tGq6yKGY0Y3qFo4QnCSVE+uK72K3izaJu2UNWPytEA==
X-Received: by 2002:ac8:3735:: with SMTP id o50mr25005688qtb.252.1580762999053;
        Mon, 03 Feb 2020 12:49:59 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m16sm9733715qka.8.2020.02.03.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:49:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/24] btrfs: handle U64_MAX for shrink_delalloc
Date:   Mon,  3 Feb 2020 15:49:30 -0500
Message-Id: <20200203204951.517751-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data allocations are going to want to pass in U64_MAX for flushing
space, adjust shrink_delalloc to handle this properly.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

