Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A635F45CB2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349690AbhKXRkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbhKXRkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:33 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F713C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 09:37:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q64so3654736qkd.5
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K0v71GqqPgoMTBsEfNrZS/146nG9qYc/DbquHMbDWOM=;
        b=Z4RaLSgHbAV+jA/hFgvYb3UBeP/+ucRPHEABtZ5J1BAi9+NJhsl4Uf8OZ7B+JyGpuk
         OGt6FBgSkgfhngsawxKQOvQoXGH5GW6pO/v/ADld5xkPnUbSmSTmGgD2dWp9EHKSLEJy
         ZQVjx0JgL5QX4VLXHatDLfQJhaYC1AON6Jnledxw6xcrWGQIMmBa1sWQytCswIonN+Zj
         KiEYQApts9+ayypc8+TGomipH6kZoDP7X5x9FO5XNYEp1g7VHl6i936NV5arKh6kVtnq
         JemNHhtIcrrtcBus/6WCSUHhao9uut9ws4/vHd4u4gTD9SUBVm3mCEs7xvxM90a86UYn
         U2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0v71GqqPgoMTBsEfNrZS/146nG9qYc/DbquHMbDWOM=;
        b=a+Uhn/53ybPpg33zwGXosRt68to1/Z8AkAnS1BmR8t9yvGRWYEsO3j5W/SIW/P2LzX
         7XUJCblWq1cnA8CC9scitucbMcdRrvhafIXPr4QCCr4F6SBwfmbrvBP3Jedr6cz5cpfc
         EOxW7QIAOtIhCCIg1/oOuctMDfVYMEW8Cn/QQg6YMXM9cacLPEOixLxul1ryGk8yMarm
         BJcztkZBOImc/iW2DFLsbQG4MmDegWTEIpmjy30pzZvuoCg2bEYM712lpN8mWxkrrTJl
         /FWItrrp4itEVkT9FrHQFOcVLAQYit/vAwcI6nxCiD3iPZc1RR1OiwBJtp/sXE9Y2Qb/
         ULig==
X-Gm-Message-State: AOAM533qM1c8jCG4cmbAsYvKgbve9iceA9ikfA8RNyY9NByZtvhkHDR8
        Pg0Be03As38aN3C6nNEWpSZt/r9sDHIeFA==
X-Google-Smtp-Source: ABdhPJzo/8npnZTCZZX60RjU2eyYGAI5APz4I6gE+Alpz8kOFW+nyKxbST0R5xjPcOTdPohwEPlP7A==
X-Received: by 2002:a05:620a:190b:: with SMTP id bj11mr7599737qkb.514.1637775442125;
        Wed, 24 Nov 2021 09:37:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s10sm150330qke.132.2021.11.24.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:37:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: clear extent buffer uptodate when we fail to write it
Date:   Wed, 24 Nov 2021 12:37:17 -0500
Message-Id: <9d6f5682aeb573b58009a17dc4d2ab19a264db73.1637775291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637775291.git.josef@toxicpanda.com>
References: <cover.1637775291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got dmesg errors on generic/281 on our overnight xfstests.  Looking at
the history this happens occasionally, with errors like this

------------[ cut here ]------------
WARNING: CPU: 0 PID: 673217 at fs/btrfs/extent_io.c:6848 assert_eb_page_uptodate+0x3f/0x50
CPU: 0 PID: 673217 Comm: kworker/u4:13 Tainted: G        W         5.16.0-rc2+ #469
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: btrfs-cache btrfs_work_helper
RIP: 0010:assert_eb_page_uptodate+0x3f/0x50
RSP: 0018:ffffae598230bc60 EFLAGS: 00010246
RAX: 0017ffffc0002112 RBX: ffffebaec4100900 RCX: 0000000000001000
RDX: ffffebaec45733c7 RSI: ffffebaec4100900 RDI: ffff9fd98919f340
RBP: 0000000000000d56 R08: ffff9fd98e300000 R09: 0000000000000000
R10: 0001207370a91c50 R11: 0000000000000000 R12: 00000000000007b0
R13: ffff9fd98919f340 R14: 0000000001500000 R15: 0000000001cb0000
FS:  0000000000000000(0000) GS:ffff9fd9fbc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f549fcf8940 CR3: 0000000114908004 CR4: 0000000000370ef0
Call Trace:

 extent_buffer_test_bit+0x3f/0x70
 free_space_test_bit+0xa6/0xc0
 load_free_space_tree+0x1d6/0x430
 caching_thread+0x454/0x630
 ? rcu_read_lock_sched_held+0x12/0x60
 ? rcu_read_lock_sched_held+0x12/0x60
 ? rcu_read_lock_sched_held+0x12/0x60
 ? lock_release+0x1f0/0x2d0
 btrfs_work_helper+0xf2/0x3e0
 ? lock_release+0x1f0/0x2d0
 ? finish_task_switch.isra.0+0xf9/0x3a0
 process_one_work+0x270/0x5a0
 worker_thread+0x55/0x3c0
 ? process_one_work+0x5a0/0x5a0
 kthread+0x174/0x1a0
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x1f/0x30

This happens because we're trying to read from a extent buffer page that
is !PageUptodate.  This happens because we will clear the page uptodate
when we have an IO error, but we don't clear the extent buffer uptodate.
If we do a read later and find this extent buffer we'll think its valid
and not return an error, and then trip over this warning.

Fix this by also clearing uptodate on the extent buffer when this
happens, so that we get an error when we do a btrfs_search_slot() and
find this block later.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b289d26aca0d..3454cac28389 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4308,6 +4308,12 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
 		return;
 
+	/*
+	 * A read may stumble upon this buffer later, make sure that it gets an
+	 * error and knows there was an error.
+	 */
+	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+
 	/*
 	 * If we error out, we should add back the dirty_metadata_bytes
 	 * to make it consistent.
-- 
2.26.3

