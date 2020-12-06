Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D782D05CC
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Dec 2020 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgLFQAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Dec 2020 11:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLFQAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Dec 2020 11:00:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306DC0613D4
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Dec 2020 07:59:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id f190so11437068wme.1
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Dec 2020 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l6cHtzUW0lFfnXA96r0AM7XktxyIrNASjnZRsCgM30A=;
        b=AZBuvM6ExdY2ve2CferpLCBrQytDmwhCAVXi2L2BYA30gHiYOuFOJy6k0PZ+yyub9W
         JHW8wT1hhDtjdspJhQmbNR/fahK58KN2HktD/mAOCEvrQAUKVNuLSgomSQdX6pfbDLl9
         +v3jPBLSgf6zF7+5NpqIGVnrIWNgA8WvSngk8gfVq0C+/PNMaKZbOfR7lDC+dBcGzNPq
         nfWaeuzLHrWFXb/JIdmBJT6xCQXfc5H50vaV2ZiJRO5nHRdt7YHprblEshaIOQjktkoY
         EjCLmAV+IrRARw1MmQR1dSoUIaiMJR1+RlbDI4xJ7RP/cK8MLu2yZh7l0GuinqRKEu55
         qKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6cHtzUW0lFfnXA96r0AM7XktxyIrNASjnZRsCgM30A=;
        b=kIZi51ZVRM1ABwhS1HlxYj49n7VZyrN7v1g3ooauCxhIADbcwKSa4Wvpnd7pGLQ2El
         U4K1E9lQOm/nO0F+qoMaUgERGp69riYVV9IXAzkcweTDbS8w41/6c74SqxyzWocaCxZa
         Y4B9eRmzRHXgLwVNbMspTBMVRxlcYXM5rREGV8arrXS+3pkPtYYvkn/hRKM1pCQfYnpL
         PvrmUdJFVmwZqyv0Wu8vayCS6D/VkWBbrReCGHj9saHPutxjaqSAZ6sATJ9byE77Hsqo
         ecTgL7Hi6YogE5tpAyCHna2mqafF0vyVa9KTWsDAouxueGxOgT7ueo8bRhX46GmZs7Go
         ytCw==
X-Gm-Message-State: AOAM530w0LSFfgZHcuxardoa4mjj46zTrK7lATUMREX5u1JxbRmNa+jZ
        ToX9gBE01JnF7GC1o4+tbEk=
X-Google-Smtp-Source: ABdhPJxCeyNRyXcRi3Y9DNpMHeLFVvvjw767SxajSM4DJrk5fvtJOemNWKZ2ZcOFcEUMVHhIFCkoKA==
X-Received: by 2002:a1c:5a08:: with SMTP id o8mr14288380wmb.142.1607270391384;
        Sun, 06 Dec 2020 07:59:51 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.92])
        by smtp.gmail.com with ESMTPSA id h14sm9933355wrx.37.2020.12.06.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 07:59:50 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: don't overabuse discard lock
Date:   Sun,  6 Dec 2020 15:56:22 +0000
Message-Id: <9c49efdae18b00adf78ea1c076bbf5e461df96b0.1607269878.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1607269878.git.asml.silence@gmail.com>
References: <cover.1607269878.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_discard_workfn() drops discard_ctl->lock just to take it again in
a moment in btrfs_discard_schedule_work(). Avoid that and also reuse
ktime.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/discard.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index d641f451f840..9d6ab92391a3 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -328,28 +328,15 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 		btrfs_discard_schedule_work(discard_ctl, false);
 }
 
-/**
- * btrfs_discard_schedule_work - responsible for scheduling the discard work
- * @discard_ctl: discard control
- * @override: override the current timer
- *
- * Discards are issued by a delayed workqueue item.  @override is used to
- * update the current delay as the baseline delay interval is reevaluated on
- * transaction commit.  This is also maxed with any other rate limit.
- */
-void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
-				 bool override)
+static void __btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
+					  u64 now, bool override)
 {
 	struct btrfs_block_group *block_group;
-	const u64 now = ktime_get_ns();
-
-	spin_lock(&discard_ctl->lock);
 
 	if (!btrfs_run_discard_work(discard_ctl))
-		goto out;
-
+		return;
 	if (!override && delayed_work_pending(&discard_ctl->work))
-		goto out;
+		return;
 
 	block_group = find_next_block_group(discard_ctl, now);
 	if (block_group) {
@@ -391,7 +378,24 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 		mod_delayed_work(discard_ctl->discard_workers,
 				 &discard_ctl->work, nsecs_to_jiffies(delay));
 	}
-out:
+}
+
+/**
+ * btrfs_discard_schedule_work - responsible for scheduling the discard work
+ * @discard_ctl: discard control
+ * @override: override the current timer
+ *
+ * Discards are issued by a delayed workqueue item.  @override is used to
+ * update the current delay as the baseline delay interval is reevaluated on
+ * transaction commit.  This is also maxed with any other rate limit.
+ */
+void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
+				 bool override)
+{
+	u64 now = ktime_get_ns();
+
+	spin_lock(&discard_ctl->lock);
+	__btrfs_discard_schedule_work(discard_ctl, now, override);
 	spin_unlock(&discard_ctl->lock);
 }
 
@@ -497,9 +501,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	discard_ctl->prev_discard = trimmed;
 	discard_ctl->prev_discard_time = now;
 	discard_ctl->block_group = NULL;
+	__btrfs_discard_schedule_work(discard_ctl, now, false);
 	spin_unlock(&discard_ctl->lock);
-
-	btrfs_discard_schedule_work(discard_ctl, false);
 }
 
 /**
-- 
2.24.0

