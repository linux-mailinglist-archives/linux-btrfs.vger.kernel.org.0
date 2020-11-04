Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58F2A60E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgKDJtL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 04:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDJtK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 04:49:10 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681AC061A4A
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 01:49:10 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v5so1727948wmh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=whDSf4Tz1Xq7gfrWNMCMjK8THmT23tBpaXB1TzI9T+s=;
        b=dNAcZpvZhSsi1I7RXzUlof9YxA16yostaBuxRdCbaBLvG/m3xmfgTZzOyXsBUX1Zex
         23E/UC/OZIPJ038V84wHRPxCIEsSoHPWYEvqSdsx7n+O87QBu8/Ppm0AzxxURB7sX0FX
         mTnhvQv7NfxYpatBoiv+7cJj8D97PLKCu8vwL4ycyQ28F2E/ln/sAkfwGRCNIR/C1PnW
         KhL7yi12bnx+G0qvuRaA2Azh2laKnI9v/CbZ/Q+FvP7WeCZaSV2u91tFYTGbSFlACbld
         665wuOVa00/Frkon41vwWl6vgK5cKR3pVuY2HNyZLZYHpK3JFshzGyKrkVulrsUmGeEc
         QfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whDSf4Tz1Xq7gfrWNMCMjK8THmT23tBpaXB1TzI9T+s=;
        b=iXxvRhAklTOfieeK3qpotwAhoxIwZcX6DHLh7LCZxtaPQkS7W/3VoHGtfy+lQM0PnP
         KmYV8beoni2OLbSSKZH+AKAMp5VTWmN1FVjj5EjuoGJf1VvQFr2hp5wTpUBEjXQd2QbJ
         u8Fp4nyO+uEtmvrI1u3Sii4ll41kO16i+ABvStI+bSsGX2T57Z8GfT1Eb7FKOW5lu8Tb
         jdUKcpLc7IgF+Xpt3wxAUFhCUACGQZ0c2KkngaeNcmjuUzeqBL3NK/xtb4aSQ4BjSy3Y
         o0B5xFu06fGSjo/vB7Gkky+N7ImAW0E3hiGqHuPXtT0jTyryCGqxlk6SMVcF+BKdYQFm
         EcVQ==
X-Gm-Message-State: AOAM533Bf7Q5PjbwxY6XbFGsj74J8brGOsav6b3ZnYHPVQoY4K4lZP//
        ZYlwCUiSi6MHXxdCS4Vi/HUFTmZRhpuVkw==
X-Google-Smtp-Source: ABdhPJxONh463ZJDTBN1Zbi0/riLyzNLbULJrF8F3PpHF4CRqE1inB4iFdi9FlgiLMrZ+opf52jW9w==
X-Received: by 2002:a1c:7303:: with SMTP id d3mr3872935wmb.152.1604483348811;
        Wed, 04 Nov 2020 01:49:08 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id 3sm1478081wmd.19.2020.11.04.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:49:08 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: discard: save discard delay as ns not jiffy
Date:   Wed,  4 Nov 2020 09:45:52 +0000
Message-Id: <5be2ccce4a6ebe7c96274f63091a04aeba9af9d8.1604444952.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1604444952.git.asml.silence@gmail.com>
References: <cover.1604444952.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most of calculations are done in ns or ms, so store discard_ctl->delay
in ms and convert the final delay to jiffies only in the end.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/ctree.h   |  2 +-
 fs/btrfs/discard.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..d43a82dcdfc0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -472,7 +472,7 @@ struct btrfs_discard_ctl {
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
 	u64 max_discard_size;
-	unsigned long delay;
+	u64 delay_ms;
 	u32 iops_limit;
 	u32 kbps_limit;
 	u64 discard_extent_bytes;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 76796a90e88d..b6c68e5711f0 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -355,7 +355,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 
 	block_group = find_next_block_group(discard_ctl, now);
 	if (block_group) {
-		unsigned long delay = discard_ctl->delay;
+		u64 delay = discard_ctl->delay_ms * NSEC_PER_MSEC;
 		u32 kbps_limit = READ_ONCE(discard_ctl->kbps_limit);
 
 		/*
@@ -366,9 +366,9 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 		if (kbps_limit && discard_ctl->prev_discard) {
 			u64 bps_limit = ((u64)kbps_limit) * SZ_1K;
 			u64 bps_delay = div64_u64(discard_ctl->prev_discard *
-						  MSEC_PER_SEC, bps_limit);
+						  NSEC_PER_SEC, bps_limit);
 
-			delay = max(delay, msecs_to_jiffies(bps_delay));
+			delay = max(delay, bps_delay);
 		}
 
 		/*
@@ -378,11 +378,11 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 		if (now < block_group->discard_eligible_time) {
 			u64 bg_timeout = block_group->discard_eligible_time - now;
 
-			delay = max(delay, nsecs_to_jiffies(bg_timeout));
+			delay = max(delay, bg_timeout);
 		}
 
 		mod_delayed_work(discard_ctl->discard_workers,
-				 &discard_ctl->work, delay);
+				 &discard_ctl->work, nsecs_to_jiffies(delay));
 	}
 out:
 	spin_unlock(&discard_ctl->lock);
@@ -555,7 +555,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 
 	delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
 		      BTRFS_DISCARD_MAX_DELAY_MSEC);
-	discard_ctl->delay = msecs_to_jiffies(delay);
+	discard_ctl->delay_ms = delay;
 
 	spin_unlock(&discard_ctl->lock);
 }
@@ -687,7 +687,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
 	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_DEFAULT_MAX_SIZE;
-	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
+	discard_ctl->delay_ms = BTRFS_DISCARD_MAX_DELAY_MSEC;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->kbps_limit = 0;
 	discard_ctl->discard_extent_bytes = 0;
-- 
2.24.0

