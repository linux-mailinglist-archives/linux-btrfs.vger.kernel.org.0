Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA074A7A9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 22:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347707AbiBBVpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 16:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347708AbiBBVpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 16:45:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C7AC061714;
        Wed,  2 Feb 2022 13:45:20 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t9so986561lji.12;
        Wed, 02 Feb 2022 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aE3qgTZ4EV14XHFn1hEGCZkCDQYAt8p7KFjqQdA92jk=;
        b=ayqOVDvU4d5na7tsBgNkhyj4peZIBSfdRE4EJL2BFuAM7+R2OQ4ncjXzfwkoZuYkY+
         e/keCzvcR5ZTWRIbcWSPTTl8kALmUDM4YhqphTaTeY0bz2Y50INrzpzGNpjgsFGNpTQh
         lUscxbY+hzcWHvEfvZ2ZdWf98dBQ+PJFwrP2rh9j+PDDcFqSD4pEj39NKcuIpn4i+KLs
         V5lrEQT/EOQ2ovzxQ8FPOKUva6WfkC5gIRHpJS5cBPCXa2PVpSkkf37A7ib1MopCWrcF
         Bpu1wRCeGo8Ulz6qb63AuKjH9zN+lykBI1L94vyyh+eYVbJ1tky11mEtFMMZKJznMEwI
         NTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE3qgTZ4EV14XHFn1hEGCZkCDQYAt8p7KFjqQdA92jk=;
        b=a78gPF690ZB9nOgS1IIflHT0wWKwaRnengH6PxY3AeydidKidVRN6Bx/iJD7tL/W3v
         TVA0tSyQa3LrY+L0UAuONbamEa35IuNshngEP2YdYxk7tPISDdapvUXG9pcdwMAtmAQc
         l74gKLeixpacUPHAZ46FtOSAs0t9J0vE+wL76vdHJKTAZylJHVZGyXKwbVs2MwuC40+/
         EY8n/BT7HlBndzy+XaR5Ngj1WDlsExzrwW94A90CnnqrgENO09kzco1CgXlYMypyeFu2
         gPreQgNUU4WluZ9wqYXCGM+3UTGXCH7XHgYsWckHk5Wa8bY5afu+rQJxqXUFujt1SvFh
         f00g==
X-Gm-Message-State: AOAM533BLogNGKoA44eVbdnSraCORMdLIY6JCQ9RBv461gV1LitUd7lX
        I0EYUtUnvsPgmOAd1V366Bg/mfdXmHQ0vLhOWxI=
X-Google-Smtp-Source: ABdhPJyyYiMgSYioMz7LvaB02JSQ4QarIAlTJyDZQl5m0whQUv3Ns3lVBgDg2XUUAgkAMy1Rt0Durw==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr18543262ljj.37.1643838318842;
        Wed, 02 Feb 2022 13:45:18 -0800 (PST)
Received: from ArchRescue.. ([81.198.232.185])
        by smtp.gmail.com with ESMTPSA id p21sm3357970ljm.60.2022.02.02.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:45:18 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH 2/2] btrfs: prevent copying too big compressed lzo segment
Date:   Wed,  2 Feb 2022 23:44:55 +0200
Message-Id: <20220202214455.15753-2-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220202214455.15753-1-davispuh@gmail.com>
References: <20220202214455.15753-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compressed length can be corrupted to be a lot larger than memory
we have allocated for buffer.
This will cause memcpy in copy_compressed_segment to write outside
of allocated memory.

This mostly results in stuck read syscall but sometimes when using
btrfs send can get #GP

kernel: general protection fault, probably for non-canonical address 0x841551d5c1000: 0000 [#1] PREEMPT SMP NOPTI
kernel: CPU: 17 PID: 264 Comm: kworker/u256:7 Tainted: P           OE     5.17.0-rc2-1 #12
kernel: Workqueue: btrfs-endio btrfs_work_helper [btrfs]
kernel: RIP: 0010:lzo_decompress_bio (./include/linux/fortify-string.h:225 fs/btrfs/lzo.c:322 fs/btrfs/lzo.c:394) btrfs
Code starting with the faulting instruction
===========================================
   0:*  48 8b 06                mov    (%rsi),%rax              <-- trapping instruction
   3:   48 8d 79 08             lea    0x8(%rcx),%rdi
   7:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
   b:   48 89 01                mov    %rax,(%rcx)
   e:   44 89 f0                mov    %r14d,%eax
  11:   48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
kernel: RSP: 0018:ffffb110812efd50 EFLAGS: 00010212
kernel: RAX: 0000000000001000 RBX: 000000009ca264c8 RCX: ffff98996e6d8ff8
kernel: RDX: 0000000000000064 RSI: 000841551d5c1000 RDI: ffffffff9500435d
kernel: RBP: ffff989a3be856c0 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000001000 R12: ffff98996e6d8000
kernel: R13: 0000000000000008 R14: 0000000000001000 R15: 000841551d5c1000
kernel: FS:  0000000000000000(0000) GS:ffff98a09d640000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00001e9f984d9ea8 CR3: 000000014971a000 CR4: 00000000003506e0
kernel: Call Trace:
kernel:  <TASK>
kernel: end_compressed_bio_read (fs/btrfs/compression.c:104 fs/btrfs/compression.c:1363 fs/btrfs/compression.c:323) btrfs
kernel: end_workqueue_fn (fs/btrfs/disk-io.c:1923) btrfs
kernel: btrfs_work_helper (fs/btrfs/async-thread.c:326) btrfs
kernel: process_one_work (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:212 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
kernel: worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2455)
kernel: ? process_one_work (kernel/workqueue.c:2397)
kernel: kthread (kernel/kthread.c:377)
kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
kernel:  </TASK>

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 fs/btrfs/lzo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 31319dfcc9fb..ebaa5083f2ae 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -383,6 +383,13 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		kunmap(cur_page);
 		cur_in += LZO_LEN;
 
+		if (seg_len > WORKSPACE_CBUF_LENGTH) {
+			// seg_len shouldn't be larger than we have allocated for workspace->cbuf
+			btrfs_err(fs_info, "unexpectedly large lzo segment len %u", seg_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+
 		/* Copy the compressed segment payload into workspace */
 		copy_compressed_segment(cb, workspace->cbuf, seg_len, &cur_in);
 
-- 
2.35.1

