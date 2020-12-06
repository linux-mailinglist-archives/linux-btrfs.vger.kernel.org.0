Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC522D05CA
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Dec 2020 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLFQAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Dec 2020 11:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFQAb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Dec 2020 11:00:31 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97658C0613D2
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Dec 2020 07:59:50 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 3so11350664wmg.4
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Dec 2020 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=txZRvtdmWIP24YJQTnRPGboBxmqMtJtzwoE6MfP3IEk=;
        b=uuFWLKQiCoH1KwHzQ5C7pajA7sNxneLzn73FY2x4+6MEA2PIeSn6QQ4Vs+OqFgOvsF
         15sRg0P6EZbBCHrTKk0PqBZIrQrfdsKAE1ltLIwibzgfKSLMw+8QZc3jmU3UC/aZ5Q81
         I/oyStZCcPvuliJEb+DGJ5VNvf6R8oDE8gRofV0izk52HDAobVhnpeRbxJojx+z0CbUn
         tMDj/al3keSt3RfRjIiBxLEpQ/aatKVXTWPRozYVoWutqeDiDox81YiqQ1uJAbjf1dpf
         LZm6OEcvUeUo70FmK+pe48AHn4oQI8RC2Rm6OkL2SzE9UeIENTJTDw8USOVzck0KClpj
         NJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txZRvtdmWIP24YJQTnRPGboBxmqMtJtzwoE6MfP3IEk=;
        b=VNv0pfy8oQd6Kt+8KqiBOhwzGOFxqNVyqSEfYWpOOXgWapHQaWyoTiRtP8o0HTAGBC
         i6b5trUFOO+urIK59HF1Bs3OSpM6u8PfUub5XYZ83wNVx3v4yKkahr3yLtVJmR/L93mh
         UXCEw2nhqNwyj0HJfWjCHYuqKQWSZhUZpg85/gTzz0Jy6PXM5fLoJ94Pa862jW/O/AnW
         fkTYkIFOHSypZ00dISWrQ5iWv7Kop5c4do7tr5F2SU9NH++5Xi9fnoIzvKsZ66kEXND/
         KErDnCDux3Qccw+O/lIsmOmv2dZLV0qiyRh7rZz4YDC/sUt979DjXNYGOljbo6/qClP9
         b8OQ==
X-Gm-Message-State: AOAM531+dYPKpVeziRnXaoUq1FtHfhw+eOwVEnxa8rqiegAV8s8X6W/h
        IYr2CcgrH+/rrm/KWL1f1GALeFVEZyH1Zw==
X-Google-Smtp-Source: ABdhPJzG++kOxaIehZIbK/rkJ9fS63RS+Lsz5T1QV7B061qSXo0gnMiXACClMU1DaZ8YhaSWw9nW/g==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr14335714wmi.35.1607270389279;
        Sun, 06 Dec 2020 07:59:49 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.92])
        by smtp.gmail.com with ESMTPSA id h14sm9933355wrx.37.2020.12.06.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 07:59:48 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: fix async discard stall
Date:   Sun,  6 Dec 2020 15:56:20 +0000
Message-Id: <5667623ac4bc588fd9d715f105b5d1b38090fa71.1607269878.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1607269878.git.asml.silence@gmail.com>
References: <cover.1607269878.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Might happen that bg->discard_eligible_time was changed without
rescheduling, so btrfs_discard_workfn() wakes up earlier than that new
time, peek_discard_list() return null, and all work halts and goes to
sleep without further rescheduling even there are block groups to
discard.

It happens pretty often, but not so visible from the userspace because
after some time it usually will be kicked off anyway by someone else
calling btrfs_discard_reschedule_work().

Fix it by continue rescheduling if block group discard lists are not
empty.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/discard.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 1db966bf85b2..36431d7e1334 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -199,16 +199,15 @@ static struct btrfs_block_group *find_next_block_group(
 static struct btrfs_block_group *peek_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
 					enum btrfs_discard_state *discard_state,
-					int *discard_index)
+					int *discard_index, u64 now)
 {
 	struct btrfs_block_group *block_group;
-	const u64 now = ktime_get_ns();
 
 	spin_lock(&discard_ctl->lock);
 again:
 	block_group = find_next_block_group(discard_ctl, now);
 
-	if (block_group && now > block_group->discard_eligible_time) {
+	if (block_group && now >= block_group->discard_eligible_time) {
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
 		    block_group->used != 0) {
 			if (btrfs_is_block_group_data_only(block_group))
@@ -222,12 +221,11 @@ static struct btrfs_block_group *peek_discard_list(
 			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
 		}
 		discard_ctl->block_group = block_group;
+	}
+	if (block_group) {
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
-	} else {
-		block_group = NULL;
 	}
-
 	spin_unlock(&discard_ctl->lock);
 
 	return block_group;
@@ -438,13 +436,18 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	int discard_index = 0;
 	u64 trimmed = 0;
 	u64 minlen = 0;
+	u64 now = ktime_get_ns();
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
 	block_group = peek_discard_list(discard_ctl, &discard_state,
-					&discard_index);
+					&discard_index, now);
 	if (!block_group || !btrfs_run_discard_work(discard_ctl))
 		return;
+	if (now < block_group->discard_eligible_time) {
+		btrfs_discard_schedule_work(discard_ctl, false);
+		return;
+	}
 
 	/* Perform discarding */
 	minlen = discard_minlen[discard_index];
-- 
2.24.0

