Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD934B2A45
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 17:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351470AbiBKQYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 11:24:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiBKQYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 11:24:47 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B8F3B0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:24:45 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id o10so8744490qkg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hFxfpapv9xA9ynfF0bLFwm4wRPDNjhCtPAEGPrLPXRc=;
        b=qp12JjkvsQ9Q//4mGH8KCwKqkiWyeJXfCwMdQ977Tb1Dac0GHXlIdlEpo1wR1dTRSr
         eMs8+ue7e1EOKXmWJZInxdFIypYt6nkt+KQ/LZCzgl1j61OWtS3fNTVoXBsKJtjDuk6u
         spdny2+2eq5bidc7TiORJkizC4d1iH/uCECkF5Zlp7yBsE2chzqMaj+dCGTg/v0fzEl3
         5u8j8djpWexp6I5vLmd7pH6NSBcZqdbfpEoSj/nW3xbJuBt5ULUAKoWkwwtJcMbyYXSk
         CYKUIttk3299rvjxTQIMBk8SfTTU+xRBlMBCe3mD9EZ5BqQM1BJi3I6kSkNugHBm0gNq
         MyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFxfpapv9xA9ynfF0bLFwm4wRPDNjhCtPAEGPrLPXRc=;
        b=d/GAs5B0yaOlGv/cQhamsCjEbiJ+I7JsJehYvXTqeeAHOnkOS43uvZ3HBTI1o0uGsF
         RZKDLPmWvR48F4n77uxaXpyEJWash3+RQZ4FNnpSwZQ/UQqgkMJu1tUL8TVgOrxB8xnp
         2kRsCqhemDKZflkfnb0ns2nA4R2+BkxcUvmeO7oVw9HdzsJdSRYw3MvJhsuWsRRlxy+w
         oqr1SwyqHwZoSvd2Fj2XgK+XQIh6BM5h0cSGlrIw5kWr+rYu6GICiI1/RNbLtKsM1Qso
         G6m1/T7Qh1GPpFaZ75238rSWOyB84eF1EDr+13Zcg+PzIx9SxjH/A6ccnqGOmPE68Eaa
         pd5w==
X-Gm-Message-State: AOAM530qOHR7KMe37P38BDS2tevbvjBtQGoYcfn9BZK63zJ9RMQdJY4Q
        2tdguNoS11wVBQ4ITuXpkp3C8G5LCwgcp2V8
X-Google-Smtp-Source: ABdhPJztETcQnlCIdtDHwvAnIf8XZv4JIl5/Lz4+b058XCoylyovKP607VT3QMaDJW5XjGNUXo+WRA==
X-Received: by 2002:a05:620a:a16:: with SMTP id i22mr1179232qka.376.1644596683905;
        Fri, 11 Feb 2022 08:24:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l25sm11517598qki.85.2022.02.11.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:24:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: do not WARN_ON() if we have PageError set
Date:   Fri, 11 Feb 2022 11:24:39 -0500
Message-Id: <d680ba3fafc9c9e87bc599d59f47256677a77997.1644596294.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644596294.git.josef@toxicpanda.com>
References: <cover.1644596294.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Whenever we do any extent buffer operations we call
assert_eb_page_uptodate() to complain loudly if we're operating on an
non-uptodate page.  Our overnight tests caught this warning earlier this
week

WARNING: CPU: 1 PID: 553508 at fs/btrfs/extent_io.c:6849 assert_eb_page_uptodate+0x3f/0x50
CPU: 1 PID: 553508 Comm: kworker/u4:13 Tainted: G        W         5.17.0-rc3+ #564
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: btrfs-cache btrfs_work_helper
RIP: 0010:assert_eb_page_uptodate+0x3f/0x50
RSP: 0018:ffffa961440a7c68 EFLAGS: 00010246
RAX: 0017ffffc0002112 RBX: ffffe6e74453f9c0 RCX: 0000000000001000
RDX: ffffe6e74467c887 RSI: ffffe6e74453f9c0 RDI: ffff8d4c5efc2fc0
RBP: 0000000000000d56 R08: ffff8d4d4a224000 R09: 0000000000000000
R10: 00015817fa9d1ef0 R11: 000000000000000c R12: 00000000000007b1
R13: ffff8d4c5efc2fc0 R14: 0000000001500000 R15: 0000000001cb1000
FS:  0000000000000000(0000) GS:ffff8d4dbbd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff31d3448d8 CR3: 0000000118be8004 CR4: 0000000000370ee0
Call Trace:

 extent_buffer_test_bit+0x3f/0x70
 free_space_test_bit+0xa6/0xc0
 load_free_space_tree+0x1f6/0x470
 caching_thread+0x454/0x630
 ? rcu_read_lock_sched_held+0x12/0x60
 ? rcu_read_lock_sched_held+0x12/0x60
 ? rcu_read_lock_sched_held+0x12/0x60
 ? lock_release+0x1f0/0x2d0
 btrfs_work_helper+0xf2/0x3e0
 ? lock_release+0x1f0/0x2d0
 ? finish_task_switch.isra.0+0xf9/0x3a0
 process_one_work+0x26d/0x580
 ? process_one_work+0x580/0x580
 worker_thread+0x55/0x3b0
 ? process_one_work+0x580/0x580
 kthread+0xf0/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

This was partially fixed by c2e39305299f01 ("btrfs: clear extent buffer
uptodate when we fail to write it"), however all that fix did was keep
us from finding extent buffers after a failed writeout.  It didn't keep
us from continuing to use a buffer that we already had found.

In this case we're searching the commit root to cache the block group,
so we can start committing the transaction and switch the commit root
and then start writing.  After the switch we can look up an extent
buffer that hasn't been written yet and start processing that block
group.  Then we fail to write that block out and clear Uptodate on the
page, and then we start spewing these errors.

Normally we're protected by the tree lock to a certain degree here.  If
we read a block we have that block read locked, and we block the writer
from locking the block before we submit it for the write.  However this
isn't necessarily fool proof because the read could happen before we do
the submit_bio and after we locked and unlocked the extent buffer.

Also in this particular case we have path->skip_locking set, so that
won't save us here.  We'll simply get a block that was valid when we
read it, but became invalid while we were using it.

What we really want is to catch the case where we've "read" a block but
it's not marked Uptodate.  We do not set PageError() on failed reads,
they're just not marked as Uptodate.  We do however set PageError() when
we fail to write.

Fix this by checking !Uptodate && !Error, this way we will not complain
if our buffer gets invalidated while we're using it, and we'll maintain
the spirit of the check which is to make sure we have a fully in-cache
block while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bb3c29984fcd..28b99fecda77 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6847,14 +6847,25 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 
+	/*
+	 * If we are using the commit root we could potentially clear a page
+	 * Uptodate while we're using the extent buffer that we've previously
+	 * looked up.  We don't want to complain in this case, as the page was
+	 * valid before, we just didn't write it out.  Instead we want to catch
+	 * the case where we didn't actually read the block properly, which
+	 * would have !PageUptodate && !PageError, as we clear PageError before
+	 * reading.
+	 */
 	if (fs_info->sectorsize < PAGE_SIZE) {
-		bool uptodate;
+		bool uptodate, error;
 
 		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
 						       eb->start, eb->len);
-		WARN_ON(!uptodate);
+		error = btrfs_subpage_test_error(fs_info, page, eb->start,
+						 eb->len);
+		WARN_ON(!uptodate && !error);
 	} else {
-		WARN_ON(!PageUptodate(page));
+		WARN_ON(!PageUptodate(page) && !PageError(page));
 	}
 }
 
-- 
2.26.3

