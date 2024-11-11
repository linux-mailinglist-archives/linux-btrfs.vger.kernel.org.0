Return-Path: <linux-btrfs+bounces-9420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C09C3ADC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB280282FED
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9D172BD5;
	Mon, 11 Nov 2024 09:28:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE158170A30
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317322; cv=none; b=dQnPpOyQTlP8ZxqIgfxdoIB85LoCqUL6DCkJwCMdTn00yD+fugelgiiXq+sMPYtu9FHCB97r0gm1fB8nowimIs4hZaL2BJ2EPTX3kTkikuLmd1Ib9PaL+Wg3cai3/idGb3yJa1UkLA8etLGLD6+Z6X+8NJ/yY5igOdUSM1bW+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317322; c=relaxed/simple;
	bh=qIZ8JnNnfX+0hPASvGLXboMYi4IMTcKCYJanJCD26Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXaK0QChsBsEm1mhNlTJC0riZ5wsXaiu/4PiiuI8+mrKxcYW5odqgrv6YwUYdrIIQEqO8hcj93Roy4DE3dqus+bwWC5w4TbrGytfgUmj/y2UaTkl3UX5ipv2uROAx+PERyfXUJOKVuUguOmrK1Hg/hd1V1p7u6eeR7njP5szL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43193678216so40890795e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 01:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731317319; x=1731922119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAWjAXPnqX68CPoYkseo6GXN9CxCZSjHhMHUI8Lr1v8=;
        b=pNTP6MVnaJUYt5dhRwPnhjJtQjxZMss8Kj1wJ/NPwJUTNAywnC6IwcDuduwScmIQp+
         +b+0GL5WL3wfV+MMfC+JK9ta5EEHmkZMH00Oyp5UHKKj8k3tX8Elndv13/pLORdRF6KD
         d0KlGBFLe0wegmFcCRBBVJrh+wtpVEAAODHLw+KnCIZDkNQgZYtvkjqvzmDDfOJUc++H
         rMRl7mjrsZ61RfqJGZFmVKkK5/bzV5PfZhAxIxeJfar5LInBNCsaBNaZRyUO/cgtcwxI
         IyWPS2v+1qpYG6TKsgxxha8F7wWhah0gu21T5ftn+xi51+n2MC7A5ne5NYEgXNz55PSx
         Gqxw==
X-Gm-Message-State: AOJu0Yylna6dZZQuGKEYN1wVxVWC4XCeOmt+/CTl6LuNqVDvC2qR1wke
	5zacNmclEkyFR64NdjJ+R0yTil9KEugsqUDJDwpNe6yhD7LWMKv9nJXI9w==
X-Google-Smtp-Source: AGHT+IEBXHxnUqTWKGrgHVP6tPVewXF2mITAnBVTQJZpDPZyMFgzruB+8NMqethmUd+CISu6ng5gtg==
X-Received: by 2002:a05:600c:5124:b0:431:46fe:4cad with SMTP id 5b1f17b1804b1-432b7501d4emr106025695e9.9.1731317318958;
        Mon, 11 Nov 2024 01:28:38 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm173711505e9.30.2024.11.11.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:28:38 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
Date: Mon, 11 Nov 2024 10:28:26 +0100
Message-ID: <88ede763421d4f9847a057bdc944cb9c684e8cae.1731316882.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731316882.git.jth@kernel.org>
References: <cover.1731316882.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Shinichiro reported the following use-after free that sometimes is
happening in our CI system when running fstests' btrfs/284 on a TCMU
runner device:

   ==================================================================
   BUG: KASAN: slab-use-after-free in lock_release+0x708/0x780
   Read of size 8 at addr ffff888106a83f18 by task kworker/u80:6/219

   CPU: 8 UID: 0 PID: 219 Comm: kworker/u80:6 Not tainted 6.12.0-rc6-kts+ #15
   Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
   Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
   Call Trace:
    <TASK>
    dump_stack_lvl+0x6e/0xa0
    ? lock_release+0x708/0x780
    print_report+0x174/0x505
    ? lock_release+0x708/0x780
    ? __virt_addr_valid+0x224/0x410
    ? lock_release+0x708/0x780
    kasan_report+0xda/0x1b0
    ? lock_release+0x708/0x780
    ? __wake_up+0x44/0x60
    lock_release+0x708/0x780
    ? __pfx_lock_release+0x10/0x10
    ? __pfx_do_raw_spin_lock+0x10/0x10
    ? lock_is_held_type+0x9a/0x110
    _raw_spin_unlock_irqrestore+0x1f/0x60
    __wake_up+0x44/0x60
    btrfs_encoded_read_endio+0x14b/0x190 [btrfs]
    btrfs_check_read_bio+0x8d9/0x1360 [btrfs]
    ? lock_release+0x1b0/0x780
    ? trace_lock_acquire+0x12f/0x1a0
    ? __pfx_btrfs_check_read_bio+0x10/0x10 [btrfs]
    ? process_one_work+0x7e3/0x1460
    ? lock_acquire+0x31/0xc0
    ? process_one_work+0x7e3/0x1460
    process_one_work+0x85c/0x1460
    ? __pfx_process_one_work+0x10/0x10
    ? assign_work+0x16c/0x240
    worker_thread+0x5e6/0xfc0
    ? __pfx_worker_thread+0x10/0x10
    kthread+0x2c3/0x3a0
    ? __pfx_kthread+0x10/0x10
    ret_from_fork+0x31/0x70
    ? __pfx_kthread+0x10/0x10
    ret_from_fork_asm+0x1a/0x30
    </TASK>

   Allocated by task 3661:
    kasan_save_stack+0x30/0x50
    kasan_save_track+0x14/0x30
    __kasan_kmalloc+0xaa/0xb0
    btrfs_encoded_read_regular_fill_pages+0x16c/0x6d0 [btrfs]
    send_extent_data+0xf0f/0x24a0 [btrfs]
    process_extent+0x48a/0x1830 [btrfs]
    changed_cb+0x178b/0x2ea0 [btrfs]
    btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
    _btrfs_ioctl_send+0x117/0x330 [btrfs]
    btrfs_ioctl+0x184a/0x60a0 [btrfs]
    __x64_sys_ioctl+0x12e/0x1a0
    do_syscall_64+0x95/0x180
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

   Freed by task 3661:
    kasan_save_stack+0x30/0x50
    kasan_save_track+0x14/0x30
    kasan_save_free_info+0x3b/0x70
    __kasan_slab_free+0x4f/0x70
    kfree+0x143/0x490
    btrfs_encoded_read_regular_fill_pages+0x531/0x6d0 [btrfs]
    send_extent_data+0xf0f/0x24a0 [btrfs]
    process_extent+0x48a/0x1830 [btrfs]
    changed_cb+0x178b/0x2ea0 [btrfs]
    btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
    _btrfs_ioctl_send+0x117/0x330 [btrfs]
    btrfs_ioctl+0x184a/0x60a0 [btrfs]
    __x64_sys_ioctl+0x12e/0x1a0
    do_syscall_64+0x95/0x180
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

   The buggy address belongs to the object at ffff888106a83f00
    which belongs to the cache kmalloc-rnd-07-96 of size 96
   The buggy address is located 24 bytes inside of
    freed 96-byte region [ffff888106a83f00, ffff888106a83f60)

   The buggy address belongs to the physical page:
   page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888106a83800 pfn:0x106a83
   flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
   page_type: f5(slab)
   raw: 0017ffffc0000000 ffff888100053680 ffffea0004917200 0000000000000004
   raw: ffff888106a83800 0000000080200019 00000001f5000000 0000000000000000
   page dumped because: kasan: bad access detected

   Memory state around the buggy address:
    ffff888106a83e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    ffff888106a83e80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
   >ffff888106a83f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                               ^
    ffff888106a83f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    ffff888106a84000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ==================================================================

Further analyzing the trace and the crash dump's vmcore file shows that
the wake_up() call in btrfs_encoded_read_endio() is calling wake_up() on
the wait_queue that is in the private data passed to the end_io handler.

Commit 4ff47df40447 ("btrfs: move priv off stack in
btrfs_encoded_read_regular_fill_pages()") moved 'struct
btrfs_encoded_read_private' off the stack.

Before that commit one can see a corruption of the private data when
analyzing the vmcore after a crash:

*(struct btrfs_encoded_read_private *)0xffff88815626eec8 = {
	.wait = (wait_queue_head_t){
		.lock = (spinlock_t){
			.rlock = (struct raw_spinlock){
				.raw_lock = (arch_spinlock_t){
					.val = (atomic_t){
						.counter = (int)-2005885696,
					},
					.locked = (u8)0,
					.pending = (u8)157,
					.locked_pending = (u16)40192,
					.tail = (u16)34928,
				},
				.magic = (unsigned int)536325682,
				.owner_cpu = (unsigned int)29,
				.owner = (void *)__SCT__tp_func_btrfs_transaction_commit+0x0 = 0x0,
				.dep_map = (struct lockdep_map){
					.key = (struct lock_class_key *)0xffff8881575a3b6c,
					.class_cache = (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
					.name = (const char *)0xffff88815626f100 = "",
					.wait_type_outer = (u8)37,
					.wait_type_inner = (u8)178,
					.lock_type = (u8)154,
				},
			},
			.__padding = (u8 [24]){ 0, 157, 112, 136, 50, 174, 247, 31, 29 },
			.dep_map = (struct lockdep_map){
				.key = (struct lock_class_key *)0xffff8881575a3b6c,
				.class_cache = (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
				.name = (const char *)0xffff88815626f100 = "",
				.wait_type_outer = (u8)37,
				.wait_type_inner = (u8)178,
				.lock_type = (u8)154,
			},
		},
		.head = (struct list_head){
			.next = (struct list_head *)0x112cca,
			.prev = (struct list_head *)0x47,
		},
	},
	.pending = (atomic_t){
		.counter = (int)-1491499288,
	},
	.status = (blk_status_t)130,
}

Move the call to bio_put() before the atomic_test operation and
also change atomic_dec_return() to atomic_dec_and_test() to fix the
corruption, as atomic_dec_return() is defined as two instructions on
x86_64, whereas atomic_dec_and_test() is defineda s a single atomic
operation.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 22b8e2764619..cb8b23a3e56b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9089,7 +9089,8 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
-	if (atomic_dec_return(&priv->pending) == 0) {
+	bio_put(&bbio->bio);
+	if (atomic_dec_and_test(&priv->pending)) {
 		int err = blk_status_to_errno(READ_ONCE(priv->status));
 
 		if (priv->uring_ctx) {
@@ -9099,7 +9100,6 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 			wake_up(&priv->wait);
 		}
 	}
-	bio_put(&bbio->bio);
 }
 
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
-- 
2.43.0


