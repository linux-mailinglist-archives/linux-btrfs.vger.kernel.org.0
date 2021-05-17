Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFF383CBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 20:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhEQSzj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhEQSzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 14:55:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F5C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 11:54:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k127so6826665qkc.6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqWQxvAJ88bYSKTMtdiWLPLu9d4OKULEhtwS3qlICNg=;
        b=qgo5Gam3Ay7h3dHPfrAmhHvUvrGNutjqjVKewli5chWWbjaCbqRgatuNzuHvdWjpz/
         d5CNJ7/4uJtgjCGiOyp/sBded5+n9GnCZ7sBk8chHhPtt1oxgRgDZIUk8og1HaYh0UZd
         2ng5ktlXzUyAL0DTo+VcS1C9ZqcV8wDyjnwXKV8lTRaoKzS3YNCg6wv+Ulb3lLJ1E6dO
         vM3AWiZ83X7Ag5Iyilssr19+3Ki8TJfGDHaaK0lSMs8w5D4EEAbDcPFefUmU+/hkhUzr
         JQYwG8IfyQm5ypquTTxWZiDZuJgtKqJ42YhFBMCN34JOZ1Dqt4aeMCCIvotOr/G1gdFG
         IY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqWQxvAJ88bYSKTMtdiWLPLu9d4OKULEhtwS3qlICNg=;
        b=g1H1lVLV7VrgQPTIslc4ZJPxZL/nUAX1uxZUrE9vJfZWXil4aoViPcomDV7NzYvSqR
         K2B7xT1A4wF/vHDe9+X16BP2tJZPtATBJ/MjWLEuFi1I7w3SLvXnriCSuWa2N7z4VbiN
         uuKSmoaSyqdTFDvLU7s2Mdd1+gfIHKIF6PBTEFxSKYOoQSqMDwIvDH9DXhMC85biB+jo
         yXsoNfxBHqiw3/Hf8XIRSkKPzYQz/JBH6SzQimqQSWeY/u7/Ve/s4a3GLTLkpgvgBFvj
         elP9t0fsm0StQmCFhpDbBWEgup7FLdyw248UdnlZ/HJRbxK32ulzwe7p/yWbsCIan+Mn
         +CFQ==
X-Gm-Message-State: AOAM532hN1NiiciD+0C2xhYuP01B2PM6q/Ph0xMpaOGlQ0PpPpwFXDIv
        301v86LHCNAp43/8dRd9e9C0es5oH/oJXA==
X-Google-Smtp-Source: ABdhPJy5a2KudiZBH/mGrehyJicEpmuxYnZ6tH5e0lxXDg4ajiQeGZTiub6+99Y7G5HHGCcXyo+LCQ==
X-Received: by 2002:a37:9dd3:: with SMTP id g202mr23873qke.177.1621277661171;
        Mon, 17 May 2021 11:54:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s24sm11196407qtx.94.2021.05.17.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:54:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not infinite loop in data reclaim if we aborted
Date:   Mon, 17 May 2021 14:54:19 -0400
Message-Id: <7f6eb36024ef0976b0051829c51d9225ec8c2fbf.1621277647.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection stressing uncovered a busy loop in our data reclaim
loop.  We will simply loop to create block groups until we have
space_info->full set or no tickets.  Unfortunately if we aborted the
transaction then we will never allocate chunks and thus never get
->full, and you'll see stack traces like this

watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/u4:4:139]
CPU: 0 PID: 139 Comm: kworker/u4:4 Tainted: G        W         5.13.0-rc1+ #328
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: events_unbound btrfs_async_reclaim_data_space
RIP: 0010:btrfs_join_transaction+0x12/0x20
RSP: 0018:ffffb2b780b77de0 EFLAGS: 00000246
RAX: ffffb2b781863d58 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000801 RSI: ffff987952b57400 RDI: ffff987940aa3000
RBP: ffff987954d55000 R08: 0000000000000001 R09: ffff98795539e8f0
R10: 000000000000000f R11: 000000000000000f R12: ffffffffffffffff
R13: ffff987952b574c8 R14: ffff987952b57400 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff9879bbc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0703da4000 CR3: 0000000113398004 CR4: 0000000000370ef0
Call Trace:
 flush_space+0x4a8/0x660
 btrfs_async_reclaim_data_space+0x55/0x130
 process_one_work+0x1e9/0x380
 worker_thread+0x53/0x3e0
 ? process_one_work+0x380/0x380
 kthread+0x118/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x1f/0x30

Fix this by also checking if we have BTRFS_FS_STATE_TRANS_ABORTED set on
the fs_info and bail out accordingly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 42d0fa2092d4..06b8b68b1cb2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1248,7 +1248,9 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
-		if (list_empty(&space_info->tickets)) {
+		if (list_empty(&space_info->tickets) ||
+		    test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
+			     &fs_info->fs_state)) {
 			space_info->flush = 0;
 			spin_unlock(&space_info->lock);
 			return;
-- 
2.26.3

