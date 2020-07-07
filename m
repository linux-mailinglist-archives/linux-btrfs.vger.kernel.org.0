Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FBA2172B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGGPnM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0843CC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so10646604qto.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuyJL+ch1I9ONsvNvZudfQkXqBUgJDCWj2ulphkQ96w=;
        b=n+36MXH0PgSk3PfNET7i3so/vIcOM833DeKzDyfvv7rR0KX1L+r/FxFebroisPbBYp
         rcnskeqebH2/hxQGCmLzhPG/dXAasTk6CTUvoIzoN9JKN8Q6lxJzzUEWEByiFiowK/hV
         VABjuIRJMLzq1A8XAl+VJMgl+8Zu2f7ij6XreQHnH4bf9dq55vTd7LjS7HBzHdYYnz74
         l5HBSGN3Tr0AYZRL5eXpoNVt2eBkTJpR+gFoO5e8I9j6At0/Dm+nYAddLSIvudziNzkE
         CGn7gsFEc+g8sE/RSGCtLAFkZrFlyvKyaYEViN4PxSsZaA8/DvY5dyHmXoIHQefL4IU3
         +duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuyJL+ch1I9ONsvNvZudfQkXqBUgJDCWj2ulphkQ96w=;
        b=S58GyoW7T9KC6YlGA3Sheh5VsJMiuJix0BwbSjejulrXViFABR96514SHQzRVeKdGa
         jIJsqsdkcyjEXQ0+BuSu8nmXUYUYPGzJv2rBnW+eme/wFZTdQjFdbpoMFWSe+Nfm4qWd
         Ue7rlkPGtasEbXVY8ag2BF0v8EupjjU1z2Vs4cxjHvKamadIG0FUTlBoo7kMX6qN5C+U
         OetgH55Em+nnG3iMCgOVJXwq5UfLFSZ8COSldt/DqA1ZfCiD6IqIY+8Z1I2XACwieZp6
         rXh4xQjW31payFAEYjKQkc/GXqS6BoKYfHcb0bqUQUhzi7iv6G2/w0+uEhFVW/NlRpu1
         GEvg==
X-Gm-Message-State: AOAM533eZ8p0CC8nTdlxxheoeHz0YYgajfnT3X2iINeTicDgduM7eXDm
        4j0Rg88ZgjdAE+MEFBo+GrFiu9S7TJ1XOg==
X-Google-Smtp-Source: ABdhPJw1sENNZzlnYzjAzG3BLFteYVM3C7ZD7w6mvk5Sa3DwW73M9YN+zAYv2n5LJZcM932SBk+CxA==
X-Received: by 2002:ac8:24d:: with SMTP id o13mr26639944qtg.154.1594136590936;
        Tue, 07 Jul 2020 08:43:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a20sm11110316qtw.54.2020.07.07.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/23] btrfs: check tickets after waiting on ordered extents
Date:   Tue,  7 Jul 2020 11:42:34 -0400
Message-Id: <20200707154246.52844-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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

