Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94632189AE
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgGHOAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgGHOAn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B98C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so4200557qtm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F24Fb8VJoZFaPNYAY7Qby2wBX99HVjadR1H3fE1tv5s=;
        b=0hFEMEsatxRUiSgQxuXZNKphY7PGIBw5vWllylpZXh8Cbxi7gCrknxQONBPs3It2DX
         IBQSS02i1Uo9/gLld5ANKL8urq+TVD3dba/WZPyfVUq4fmNCmbSe5wHazrTp+cSlhQCG
         N89VF9Y3Lx9dgN0JzozOqA/i7oqMYacq3oUh1EGkMR9TluSUogl8KyqNErn0j9Np0Cej
         EqKWo60HXeGh+hr3iBUmD6Cq1P0Gb4LYNsn4KNXpL0iXbRT6Egurh6FWfAn1WheYsBY1
         jryQcFEHow4c2cYeC2NXko+Ip/O3H1LUBDrcy7guUzLXM50gdj4UwHH8j5LfAIpkiJGC
         bUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F24Fb8VJoZFaPNYAY7Qby2wBX99HVjadR1H3fE1tv5s=;
        b=TgiluIeUMVMfZ0VsrTagmRjCchhwEMfkUVPm4uPm8fSTCRZWbphxApvPCU4LN5yIIt
         VNLY3nuy007j/N8nsw6yOvb3R/iYtOSqT16PqMaX6LlKpBNPssQ/3CmbAgCbGjn9SaL1
         Zmrm/HgBK5DuPQu9kYMKW7R6R1ZO9usob13RkL6GcxrGcfuGTn6aL5112LJ0g89PKoBP
         S0zUk88kElFLhWXCD6cpcPLQjNtiSONQQpSr8xpC1uOGSlB884aAH1PI3DdrLmt1tHMX
         6qq/vo5YiX//eMxvZL05kw8aTQJGffx+hSaYM0xLs3ICQEJdatdceMcnnlK9yOgCrUe3
         VwvA==
X-Gm-Message-State: AOAM530vxnpXZDvPRx6OyDVYGs2O7NVX827xPQIRG+iJP/nDwOcSJhrg
        9wjPO7tE+C/k766WbtRHU9JVwBSzzpsJUw==
X-Google-Smtp-Source: ABdhPJxuP3iCSPDPBxJryAoFNtExcTGS8JylL0NsANVO8SP2toS/1lEjrpdTFojnhFcYr6y+ziWC/w==
X-Received: by 2002:ac8:3528:: with SMTP id y37mr59841025qtb.308.1594216841853;
        Wed, 08 Jul 2020 07:00:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4sm32661903qtf.43.2020.07.08.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/23] btrfs: check tickets after waiting on ordered extents
Date:   Wed,  8 Jul 2020 10:00:01 -0400
Message-Id: <20200708140013.56994-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right now if the space is free'd up after the ordered extents complete
(which is likely since the reservations are held until they complete),
we would do extra delalloc flushing before we'd notice that we didn't
have any more tickets.  Fix this by moving the tickets check after our
wait_ordered_extents check.

Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index de8a49de5fdb..3b5064a2a972 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -545,14 +545,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
 		btrfs_start_delalloc_roots(fs_info, items);
 
-		spin_lock(&space_info->lock);
-		if (list_empty(&space_info->tickets) &&
-		    list_empty(&space_info->priority_tickets)) {
-			spin_unlock(&space_info->lock);
-			break;
-		}
-		spin_unlock(&space_info->lock);
-
 		loops++;
 		if (wait_ordered && !trans) {
 			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
@@ -561,6 +553,15 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 			if (time_left)
 				break;
 		}
+
+		spin_lock(&space_info->lock);
+		if (list_empty(&space_info->tickets) &&
+		    list_empty(&space_info->priority_tickets)) {
+			spin_unlock(&space_info->lock);
+			break;
+		}
+		spin_unlock(&space_info->lock);
+
 		delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
 		dio_bytes = percpu_counter_sum_positive(&fs_info->dio_bytes);
-- 
2.24.1

