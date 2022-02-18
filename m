Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF374BBBF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiBRPSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:18:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBRPR7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:17:59 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F524F0F
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:17:43 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so15291730qvf.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mN3svgAX1Cwe+Xk1Kt3VqCbStwA/aHm+Vno0DnUrYUE=;
        b=sAb0B61y/AtTlKuWwIwH1HRl0xivV4zEvVJ+ABpeWqho5sf4fZdBx7KhqoQX4XscGn
         YJQ9xbe2Gn1W5f7COHL7mVNYRPaECuZti4vzYAe1yobIBfEzAPAUgc5Cpl7Z4q2T+Sis
         C0/kF4NCe3eDJtfQkjB+uroJTYRVclKH0TvL3erSlF3bXdrnzMFVm2aLv+r2LaOamRhL
         BBalpwnYqaL0iSoudE05OQywFaXJePYJ1LyLcpbP8LzcWM0R4nblt/YbJgIAH26uIZJd
         z3LBzdXNlbGXrng/GsXYOdj8b62HAzEl2c3rFEfWtOoXxb987xl1UlyfHDasUamD/jTu
         NG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mN3svgAX1Cwe+Xk1Kt3VqCbStwA/aHm+Vno0DnUrYUE=;
        b=kdJPAKIGHrURBzk77EqOYycPz2qB0gDYBkGTyvEI8ux5kXmZ6ywFQg1lYhGvxg2uEh
         1KrXtourPbZW2u30kmDjpCFfBVgLe7duTqS9uKwl2/x1YOeTU90cNmtcyGricw7/ryjf
         Zs/as1/ViZ46x7apPMBgFDb4ZB0Y7Irc/Pzk2dgWPbNizfooSewBUmtIM+Jh2/i3kDl+
         B0f2vmfPzMhMmnuFaV46PjdcAAiKNgef/MjUxQfZsPRZerD8C5In4IyS8WfBshs8t7Bp
         gobWs2s3Jd0mh/338IMJY1e8pYm9hYxD2qzjQZ3s2gQtBKKoKg5vs2yhuFSbTMXpOFfn
         AlJg==
X-Gm-Message-State: AOAM533KIV6AkHgveZIAyDzPemkNJqeWAqE2lL00uPV1Bl7MVSQVKzti
        l4Taqrj8NcAVSJBTMhMgPgPfBzQ+ZwdMXo+M
X-Google-Smtp-Source: ABdhPJwTlxPpgs58OC74l8IQheJGluEJTkfCNi6D1YkwqLfUiZ/lWxXccAnUmnZx2Eznb5nhpRT/ng==
X-Received: by 2002:a05:6214:21e9:b0:42c:dede:56f5 with SMTP id p9-20020a05621421e900b0042cdede56f5mr6137983qvj.127.1645197461654;
        Fri, 18 Feb 2022 07:17:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s68sm8543921qkh.136.2022.02.18.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:17:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2] btrfs: do not WARN_ON() if we have PageError set
Date:   Fri, 18 Feb 2022 10:17:39 -0500
Message-Id: <d6f76c251fa224e4987129a0ea15ae77a6a052c1.1645197372.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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
it's not marked Uptodate.  On read we ClearPageError(), so if we're
!Uptodate and !Error we know we didn't do the right thing for reading
the page.

Fix this by checking !Uptodate && !Error, this way we will not complain
if our buffer gets invalidated while we're using it, and we'll maintain
the spirit of the check which is to make sure we have a fully in-cache
block while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Dropped the patch that didn't set PageError() when we failed to read.  I
  misread the code and every other file system does this, and I don't want to
  break some weird assumption.  So instead just do this patch to catch us
  invalidating the page while we're looking at it.

 fs/btrfs/extent_io.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 16b6820c913d..3eaf7fd2e919 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6848,14 +6848,25 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
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

