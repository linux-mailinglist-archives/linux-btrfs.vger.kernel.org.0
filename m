Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AF2C896A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgK3Q0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 11:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3Q0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 11:26:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749A2C0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:25:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so17003878wrt.2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ANsuUQtzht/WXnpYQONZLUeB7Ns2kEv0d75OPH5WvpU=;
        b=A5uOHYEQchfjoKbQFalJox6Ljo246PJtCUYuzezQFYcIBSViaHQe4rP1Iaym5qMPWs
         WeXbbgvD7GeSg82OXMKDoNKJa4Juzi0adWOK9CDSIQQq+aF9/QoCvthwlnEzvCX09CMz
         a56gj/3fgGUagj2I0QVeWGk+mRr3jh1NS+M8qpFMic13nn/khlyOGNBFZnVH/qcPAGf/
         QRyFBwuRiVmtUhV+8Wsb7aLwwF2YZPq2IUcDP7rPlOwoPQNApM0Q0BfC3zxDIjrQzuIP
         +MWx8ZdvSR/e+u3/YAInVpIkJF8ybTNU2o+r4zWED6y/hhgl7NIYzdvoIskyxbgPqcLu
         vYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANsuUQtzht/WXnpYQONZLUeB7Ns2kEv0d75OPH5WvpU=;
        b=ZOyYT2YQzhjH9JHXtEZ0kT4NXVVG9yz0GF8zfL0k5EGwFu9gi8+/KXq+mU2tMNzU1/
         fRAHRxfuww67FxGBwxW2aTjYZiuFR44BV31dQC7n3+RxbLYRvZVQyDyn+y10EpaeCirH
         GKUUk6PYQdYwsqjTuS2CXr/9kx7r++Nm+4YwAWYetb50eVXVxbdq1pPuKWmYr4DDidXX
         WYHXymx0Yl0j3ufsxYHrktJlV6/jnrZz1hVhR2Lr9EeNkfwZqk/Dm6Wei8lmy5JyuFmW
         B3VClfArKDNpEPJkFFushXjKgvrEVvoUlTCMyGR0yzLqBj7Ghr+kZ0la5byOgHxec8zB
         WvAA==
X-Gm-Message-State: AOAM532JXjg1qUjM5ZnQW9CHOKyD5GvmWrLtt+uyq4kWmoGOnx4Pa8wX
        v94EJdjMqPOq/jecRhjQCd8=
X-Google-Smtp-Source: ABdhPJxHGign6+ad36xOPogDtd+mFxRF73hgN/n3ydYFUAeylHFFPheeXUXHwow/nehdkanoBTBQhQ==
X-Received: by 2002:adf:f98a:: with SMTP id f10mr29549097wrr.154.1606753540243;
        Mon, 30 Nov 2020 08:25:40 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id l16sm29539476wrx.5.2020.11.30.08.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:25:39 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: don't overabuse discard lock
Date:   Mon, 30 Nov 2020 16:22:17 +0000
Message-Id: <87ae35a07b145227e198b097865f7cbdfdde7915.1606752605.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606752605.git.asml.silence@gmail.com>
References: <cover.1606752605.git.asml.silence@gmail.com>
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
index 05e2b8150142..4120e62d7e5a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -330,28 +330,15 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
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
@@ -393,7 +380,24 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
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
 
@@ -495,9 +499,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
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

