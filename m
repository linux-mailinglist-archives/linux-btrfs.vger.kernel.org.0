Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70602A60E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgKDJtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 04:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDJtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 04:49:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B45C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 01:49:10 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e2so1716824wme.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MfL0IVzOtW8kG8x+4UbiPZ3P/QlhiK+FFaHbYZjD+Dg=;
        b=M0m+zR1++MmibrNIuWkXV0nwZD8XKftcL+bu10CeaXQmZMBadLFzHbSkg+Q2DX8bUe
         Nj4eWh+THOmHkcjTbDauU/aEVV/sS2nwlKMfhhXzvcAVbsTsiCjV/wofGI6Y4tsll9HP
         AOMF2UYmJ4C+B643rZlcby0Xu/p9o14dxB01voYrgUknnNnTdTrYo4KpTCsVBWDe+0xf
         DwqzXk2oIg9ePBJiZh0RTWCR2nw4T6p5Q2lOzbIvGzBLC1y8wI2U+POwLkYInI+Mrvjd
         DYjAiQlGKH+KU1HMccNh0OedD9EePLHsz/mIW/n4x5Slsg+hT4eKp9ZSZ9UAXnZwR7Jd
         iGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfL0IVzOtW8kG8x+4UbiPZ3P/QlhiK+FFaHbYZjD+Dg=;
        b=ozGh77juToJ2AwEKj6vZhF7NwQAY+HDbgDBg0BVeRL7/wHk+vkTgwWh9E32zEWH4S2
         jbxGIG69qQ40gHlK7ZVb4YhEmrSwd/rl1utQukNfWWq+JeGh23MpcvXCh5YUhuO5hv4/
         n9ZujYoSicup1StQoOjiH+BT+BoERxZNeMkD1RVlZHiF/YtjCXH97VyEkmnZzWVtCK0h
         TCo2J1VwzcT89GrVWxYs8OEsxU2Rg/mXiJjr1Hx7zKF+8SaaspeK3VQmBrFRkfBCjkFc
         uXrG601jj1BWjpPaul0d8ahiDw5v7PKbLEnG6uwPArQYICqh7xN1twrac/idbTcwmXmg
         a6iw==
X-Gm-Message-State: AOAM5333VMO9eL9W3SAEYW6/ecU1SXUwZqOXNuxZNwtgzKuQlF65Sy4u
        /C++45gfIW4T4CtOSke5E+9jR9NZsInPxg==
X-Google-Smtp-Source: ABdhPJyj4SAVGkiU6N9NpNI4Ws1om1+sn+PUBVnk9yaNhTHCDFXwOOeF+3FV33T/vVpensTb8lGbgA==
X-Received: by 2002:a1c:b746:: with SMTP id h67mr3554525wmf.43.1604483349734;
        Wed, 04 Nov 2020 01:49:09 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id 3sm1478081wmd.19.2020.11.04.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:49:09 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: don't miss discards after override-schedule
Date:   Wed,  4 Nov 2020 09:45:53 +0000
Message-Id: <feb3b0aaf0d547aafcf08b6106ace158809117fd.1604444952.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1604444952.git.asml.silence@gmail.com>
References: <cover.1604444952.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If btrfs_discard_schedule_work() is called with override=true, it sets
delay anew regardless how much time left until the timer should have
fired. If delays are long (that can happen, for example, with low
kbps_limit), they might be constantly overriden without having a chance
to run the discard work.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/discard.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d43a82dcdfc0..ad71c8c769de 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -469,6 +469,7 @@ struct btrfs_discard_ctl {
 	struct btrfs_block_group *block_group;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	u64 prev_discard;
+	u64 prev_discard_time;
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
 	u64 max_discard_size;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index b6c68e5711f0..c9018b9ccf99 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -381,6 +381,15 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 			delay = max(delay, bg_timeout);
 		}
 
+		if (override && discard_ctl->prev_discard) {
+			u64 elapsed = now - discard_ctl->prev_discard_time;
+
+			if (delay > elapsed)
+				delay -= elapsed;
+			else
+				delay = 0;
+		}
+
 		mod_delayed_work(discard_ctl->discard_workers,
 				 &discard_ctl->work, nsecs_to_jiffies(delay));
 	}
@@ -466,6 +475,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	}
 
 	discard_ctl->prev_discard = trimmed;
+	discard_ctl->prev_discard_time = ktime_get_ns();
 
 	/* Determine next steps for a block_group */
 	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
@@ -684,6 +694,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 		INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
 	discard_ctl->prev_discard = 0;
+	discard_ctl->prev_discard_time = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
 	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_DEFAULT_MAX_SIZE;
-- 
2.24.0

