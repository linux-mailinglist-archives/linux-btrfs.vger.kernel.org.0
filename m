Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9559C2281F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgGUOXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgGUOXA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95183C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so16221769qtq.11
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F24Fb8VJoZFaPNYAY7Qby2wBX99HVjadR1H3fE1tv5s=;
        b=bCSl3uurhqJNpjie5W5PSGWnknSNoaGVKefz69QfSb6ptplrQiY6YV238D7jmlJVaq
         84LOerdxVK7fDmXbPe+s9x1MNf7LoeQa+ZAl+4169b4nPvAYgIE8rEXMCjR7AB/NaUne
         lccyc2tG67lmhjc0AiHiroUR9ivJ6Rn4YDxNoaGYyyxN0ijzfFnRUR7f88ZzTujiI8Ne
         fPqijyIxHh4ir+2as9hsdMYtfHUoNwV4++r1CGUHJIkPCG0KI+oqR5FGMBSClqRXzZQE
         r0yQM5vVVmMwGZ94YdXviZlkJPhSAmGFYGqr7mFXmjw9j+p/7aSiAuOZxjWQOQeIOqIl
         8SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F24Fb8VJoZFaPNYAY7Qby2wBX99HVjadR1H3fE1tv5s=;
        b=ofLKZVLBk7yFsp485FOp24F1y7GQPttEpcAitjgXs3UDX0AV6iCU5wJpk/lDgD5C4j
         qbdjwRCB025AYB0JdVDFp8YHdtUxdDxzI/t2FXEd4uqFVhdmm3Ym/eGMXvB/iKwgB350
         iBi7Pdwvq4JqSvmaA5QrXeFP75+/0kj0wP4Jc10jcZJSW8rfgyQjtdNA4Iw4nXm62/b8
         n5sPHPBCFklr1uhMPeyxsfpHd3PSN5bhe4hRF5Ve4CcxDTZwoftjJOYh6ytQcORtHMb4
         2SrCpbvcKLu5a2h8cZoLwxU1VptKs6DYPWDhb9qldNKKRT8BDFfIvFasAyBeuJu2OB5T
         oNfA==
X-Gm-Message-State: AOAM5310giVzRmVJRumJeeYKTCL7Mxg72LlDiF55lISEfxaVIcUBgr1H
        pe4ijxkplMux6+PUCcIvAEPoUsTgrHWTUw==
X-Google-Smtp-Source: ABdhPJymy/TnG1rX8TJgGUOX9PI7sJoErvOixxxfJiDO32Y1H8gV+yJrA5Zvbj5z2IQaIQKiV3Z3SQ==
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr29635057qte.196.1595341379458;
        Tue, 21 Jul 2020 07:22:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t36sm23722809qtj.58.2020.07.21.07.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/23] btrfs: check tickets after waiting on ordered extents
Date:   Tue, 21 Jul 2020 10:22:22 -0400
Message-Id: <20200721142234.2680-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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

