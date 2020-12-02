Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E272CC6E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgLBTnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgLBTnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:43:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725F2C0617A6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:43:10 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so11635808wmb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gNZgsOWM9NDBdswoYPntOxq+y+gsmXrFaIyzBe2LZb8=;
        b=R/2Zu9FmNMqMduZaHXQzicYBT/XC/p9LnmGZQlZF+DPMfigtZHLa75Z7mUXOhveTEV
         ElhbUtSZnZvElFPjoRwuB717D7VmaO0pUViVS2Szz0XTkbo/E09dQkfWXTy9oxHYZNdC
         MwycOAbuqKZZDs0kwWsH0HbqiBFhGSMxMHOVxMy7BGYD35+PfeT/TAFFp2gzNiVLSMjb
         SEJ56cA3+jrNvP8/z2dw/6seZ2dMCYor83nX0gHET1b42GVwz/YQEiXCaprHFg3+31Je
         OLtmB10UETBzBeIXNt/ncufIAdFLkDf7yBpD7GA+iANzkEmMRXwivJEtPgFmDlOFn9Qn
         bXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNZgsOWM9NDBdswoYPntOxq+y+gsmXrFaIyzBe2LZb8=;
        b=MFoXatmMqACM7wAi1jh9X2sOim3Do9dsP9ccdlEAwePVGDKvqRpFLsFOwjPtk87kM/
         xrTlqfU55bfxRc2ljHv4ZE+1JSBsTBaNXD0TYVOGFJOXQBf1gnexUoLT94JDLSCdj+0b
         1vdZUnQoLSiOEbQBTNK0tsGsYrxCeLfDAcDss7nQzt5CeLeK1HCSdo8dhhoBoS+cpPgk
         bfVjHLw3Kk5PwYGZhDfxVg6JL31ZdzmjUV0d3JQpX65fkYxwye4IxmhLNv81FBY3fAN3
         qsqmM385kaAgtaL+7UlTRd1YclxrFKURePrwJLsNQhyKMh/hh5TAiz4NImxSej2zk8VX
         XbxQ==
X-Gm-Message-State: AOAM532h7dNiwxD6PRaLqxQS8Q8vct+0xfyD9U1c4aFQzVwvMW7h1Sox
        BrGQywbbwh0fekdG6j58NPB+81ZqPdxbiw==
X-Google-Smtp-Source: ABdhPJzkNj/hUfQ2I1OBQt+1z9rUv0RumFfT1ddM2cRBfdYhDAQm0dsCYKdJTLXbmeYCEcXVU4Rb8w==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr4672186wmc.161.1606938189211;
        Wed, 02 Dec 2020 11:43:09 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q16sm3251540wrn.13.2020.12.02.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:43:08 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: don't overabuse discard lock
Date:   Wed,  2 Dec 2020 19:39:43 +0000
Message-Id: <6c0f1ab37e18683331468ca2f9aab519680e54fc.1606937659.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606937659.git.asml.silence@gmail.com>
References: <cover.1606937659.git.asml.silence@gmail.com>
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
index a338f44fec3b..cd3b23f7ceb2 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -326,28 +326,15 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
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
@@ -389,7 +376,24 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
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

