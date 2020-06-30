Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F9620F68D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgF3N7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgF3N7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:50 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF68C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q198so18637529qka.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuyJL+ch1I9ONsvNvZudfQkXqBUgJDCWj2ulphkQ96w=;
        b=AdDmwQAtl9MgdIerLu3JWtJwX0N9/DEuxFnfmjhBaMRlaH4rrc/qRQOAxqquG+/StW
         k/wOdIVRo8ncNeVwN37sZuOXAVrRchvtMCxgAhrZTbIpiRljpLT8KUjtrWq1QnrBntSd
         ma+iuYljVcbNM6Cd7B+MbjcTl8tg6CAnV9qjuoLrXMU6/InNKgzZvSAhMDXqX2zCp6QH
         drKFb1zpZvSdWIaAxuY3zSpYV/Wx73nxByTR+1Kv6dJF7A6uQB0PnrZEG2+0Zyc1oA7U
         mBL83qRqzfvorg+gOnm/tIGVWx4Ru006dFMYCgwHTqo3srS1IZwB4cX1FifdG6rRBR1z
         J6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuyJL+ch1I9ONsvNvZudfQkXqBUgJDCWj2ulphkQ96w=;
        b=Qi6ragOsJ0zVVji0KomjsFCs1O6gJSRWoKNE48feGftc0g+GWACEZu/C2YMsoTrCE2
         Yh+PdfXXlVjBi0x+Mu7T0u+b3pYcmzwkDKc8If9A8pXCpaPrVivi1+J+vFN2ODUBeUtP
         QkXp5AEllFAQUhDY0V036SSL17emulZhAOvUI11USUO3GVJMKxL8Nf1j5YLXNoP8bIc3
         0DT2fLmhJ+0ibjW9716+l1FZOHtNzWjZQeFJYO5Yx+STsucfWa9xK5SnWVE0+Hbl5m/D
         8JquYCLOhx/FIBHUxVG6yPH+0N57yj0YhsWirDlyVi8F2lmog4Uf/3y54g7pB4o5Bt1U
         kUuQ==
X-Gm-Message-State: AOAM533vQzAqC8dVKofHQxiZA5yftlubAwA8QFMEBCslZqytxesloiSY
        qwSGpY/ggJjfcXtsAmbkqGrMJbbFZoHxtg==
X-Google-Smtp-Source: ABdhPJxRxgx78dNklXMuRYLBXfPSNwt8/KrB0oCdzurNXUXiKJe2SVhn9tLvy8TvnZet48w+pXsDdQ==
X-Received: by 2002:a37:b341:: with SMTP id c62mr19462342qkf.128.1593525588972;
        Tue, 30 Jun 2020 06:59:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t35sm3118712qth.79.2020.06.30.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/23] btrfs: check tickets after waiting on ordered extents
Date:   Tue, 30 Jun 2020 09:59:09 -0400
Message-Id: <20200630135921.745612-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index 1d3af37b0ad0..0b6566a3da61 100644
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

