Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04411D526
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 19:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfLLSTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 13:19:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39955 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfLLSTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 13:19:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so943134plp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 10:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uurdY/x32ZxViNUqOsiPmgf5vE6w/D0M9Djr1JuR2s=;
        b=Z89Hw9TIOR1G3futDcnDaU7I5m9FykGFJR2e5uo9/UHRdjhpXQKGHddKIjHtV3r4cw
         I3lr1KcJ77l9diTqNAojwN2pQzMpEQTDPpiYhcfPKVXkTEaz3gQs4oL1NYIyDxTyp+t3
         GYj+WLSnTwXnJaKGALwNMpQKHAXWo8ESu/rMI5nWEp5RrJpD7tkaPwDrQ/Y2VPEZGRfz
         gAcmIOyYLLarujsH56r/FS2b6GGIVORfGw1rb/EvzCLUTeoniNsM+vtjbNvvD7iQ8Kze
         3TYnOivhcsgYp0frLkLdN+A7lZHung6DxJbuPwhy82SfNaHDW0O8OQdNNVdhlXBT0b4q
         FnBg==
X-Gm-Message-State: APjAAAUE3qlac/gHv72MgypT8ee6mVF/fp7pj/j+CSgazHg9sthru18G
        +TTp1JSrNbRfRlQEHcED0ZM=
X-Google-Smtp-Source: APXvYqxBMB5yS8oTDnWxAeC1d+EB/+2f5ULrGDliTTm0d9nbof2Hvh5E/BdD/t4zBXukb8nblOhxTw==
X-Received: by 2002:a17:90a:ad85:: with SMTP id s5mr11562192pjq.142.1576174777725;
        Thu, 12 Dec 2019 10:19:37 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:f82a])
        by smtp.gmail.com with ESMTPSA id k18sm8386285pfe.7.2019.12.12.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:19:36 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:19:34 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: fix compressed write bio attribution
Message-ID: <20191212181934.GA33645@dennisz-mbp.dhcp.thefacebook.com>
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
 <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From a0569aebde08e31e994c92d0b70befb84f7f5563 Mon Sep 17 00:00:00 2001
From: Dennis Zhou <dennis@kernel.org>
Date: Wed, 11 Dec 2019 15:20:15 -0800

Bio attribution is handled at bio_set_dev() as once we have a device, we
have a corresponding request_queue and then can derive the current css.
In special cases, we want to attribute to bio to someone else. This can
be done by calling bio_associate_blkg_from_css() or
kthread_associate_blkcg() depending on the scenario. Btrfs does this for
compressed writeback as they are handled by kworkers, so the latter can
be done here.

Commit 1a41802701ec ("btrfs: drop bio_set_dev where not needed") removes
early bio_set_dev() calls prior to submit_stripe_bio(). This breaks the
above assumption that we'll have a request_queue when we are doing
association. To fix this, switch to using kthread_associate_blkcg().

Without this, we crash in btrfs/024:
[ 3052.093088] BUG: kernel NULL pointer dereference, address: 0000000000000510
[ 3052.107013] #PF: supervisor read access in kernel mode
[ 3052.107014] #PF: error_code(0x0000) - not-present page
[ 3052.107015] PGD 0 P4D 0
[ 3052.107021] Oops: 0000 [#1] SMP
[ 3052.138904] CPU: 42 PID: 201270 Comm: kworker/u161:0 Kdump: loaded Not tainted 5.5.0-rc1-00062-g4852d8ac90a9 #712
[ 3052.138905] Hardware name: Quanta Tioga Pass Single Side 01-0032211004/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
[ 3052.138912] Workqueue: btrfs-delalloc btrfs_work_helper
[ 3052.191375] RIP: 0010:bio_associate_blkg_from_css+0x1e/0x3c0
[ 3052.191377] Code: ff 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 49 89 fc 55 53 48 89 f3 48 83 ec 08 48 8b 47 08 65 ff 05 ea 6e 9f 7e <48> 8b a8 10 05 00 00 45 31 c9 45 31 c0 31 d2 31 f6 b9 02 00 00 00
[ 3052.191379] RSP: 0018:ffffc900210cfc90 EFLAGS: 00010282
[ 3052.191380] RAX: 0000000000000000 RBX: ffff88bfe5573c00 RCX: 0000000000000000
[ 3052.191382] RDX: ffff889db48ec2f0 RSI: ffff88bfe5573c00 RDI: ffff889db48ec2f0
[ 3052.191386] RBP: 0000000000000800 R08: 0000000000203bb0 R09: ffff889db16b2400
[ 3052.293364] R10: 0000000000000000 R11: ffff88a07fffde80 R12: ffff889db48ec2f0
[ 3052.293365] R13: 0000000000001000 R14: ffff889de82bc000 R15: ffff889e2b7bdcc8
[ 3052.293367] FS:  0000000000000000(0000) GS:ffff889ffba00000(0000) knlGS:0000000000000000
[ 3052.293368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3052.293369] CR2: 0000000000000510 CR3: 0000000002611001 CR4: 00000000007606e0
[ 3052.293370] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3052.293371] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3052.293372] PKRU: 55555554
[ 3052.293376] Call Trace:
[ 3052.402552]  btrfs_submit_compressed_write+0x137/0x390
[ 3052.402558]  submit_compressed_extents+0x40f/0x4c0
[ 3052.422401]  btrfs_work_helper+0x246/0x5a0
[ 3052.422408]  process_one_work+0x200/0x570
[ 3052.438601]  ? process_one_work+0x180/0x570
[ 3052.438605]  worker_thread+0x4c/0x3e0
[ 3052.438614]  kthread+0x103/0x140
[ 3052.460735]  ? process_one_work+0x570/0x570
[ 3052.460737]  ? kthread_mod_delayed_work+0xc0/0xc0
[ 3052.460744]  ret_from_fork+0x24/0x30

Fixes: 1a41802701ec ("btrfs: drop bio_set_dev where not needed")
Cc: David Sterba <dsterba@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Reported-by: Chris Murphy <chris@colorremedies.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
v2: rely on kthread_associate_blkcg() instead.

 fs/btrfs/compression.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4ce81571f0cd..de95ad27722f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -447,7 +447,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 
 	if (blkcg_css) {
 		bio->bi_opf |= REQ_CGROUP_PUNT;
-		bio_associate_blkg_from_css(bio, blkcg_css);
+		kthread_associate_blkcg(blkcg_css);
 	}
 	refcount_set(&cb->pending_bios, 1);
 
@@ -491,10 +491,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			bio->bi_opf = REQ_OP_WRITE | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
-			if (blkcg_css) {
+			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
-				bio_associate_blkg_from_css(bio, blkcg_css);
-			}
 			bio_add_page(bio, page, PAGE_SIZE, 0);
 		}
 		if (bytes_left < PAGE_SIZE) {
@@ -521,6 +519,9 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 		bio_endio(bio);
 	}
 
+	if (blkcg_css)
+		kthread_associate_blkcg(NULL);
+
 	return 0;
 }
 
-- 
2.17.1

