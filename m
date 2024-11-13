Return-Path: <linux-btrfs+bounces-9610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA29C79C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 18:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212801F24F4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C2201275;
	Wed, 13 Nov 2024 17:17:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F414D452
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518231; cv=none; b=OBFI1nYhL9uiI6EH5B1krjxWmXNfnj1meuWoTuSiJIRrYbSLjN+B2uxSH7aw2FPHh76cLJk3NX2xD8sfE0jUfKy9QjbscSe0ZXuH11ydN6l7Ey+24WjTWm6xxEY9EnlT/Q1dFDJFJB7EDVk5yNopiUXvmz7agnH0BbDoxi+i0aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518231; c=relaxed/simple;
	bh=RUcNlEUoQDOeMEyOTqOL2HBoM8g1PN1ON1dqM2omi14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDZEzpFkF5ZiS7HjjvIk/zhf1P9H7wBTRFGjqZITTbaKBBImg9b3N5PiPvRBGnQHvHV9meOaMrndzCJOhRkpFFnIZX7+F2EtuDSI/ErnxmB1a3C1d5bqevVfbNmELHKvcNqXuBfeRC97qRQqoPMT7+R/GWv8thBGB7wvI5TLmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so62624965e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 09:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518228; x=1732123028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FjXYxACEmmuFcrs3TfysJzGxIwWklMaeRlRvdgrRZM=;
        b=hfvGH4jfN2N9wq7g6TgNj+igbtDBi2WyUSHmAlTMLky6U8KDMUifCxeADYXI4XlTRO
         tYvtBNmSUfyazu9Rb0NUuWayTRbG/hpE0jOx+0ny4UYIm/G7x3/qoDfQA5srcC5SySgr
         QJ3lWET4X5p1GXOGvK0Nb7dkSJJbKUz/oq0xcqUEVmwz/pbHAOfQMW+AfmDCp2vp41p4
         KRsbL3zK95yVeMGoRX30+UHC1Ph2UDsR/WCHPUasFulBtPjHOSfX0usCbDyu+igudjmI
         yv+RmDJr2z8i7sjZcsPmslCdcIKGuIOcGibyfrcifacMYur3QfQoPESWP8wbHy/WH8Lk
         lERw==
X-Gm-Message-State: AOJu0YzekW5FyKDBO2RCvVblWC90vzPP2dfY4u36D/JMFax8SvZ15vzn
	/10AK7Ef6QBBpC1OsXLBruM0vq3Aud8VXkHzPDKtvCbuoTCXyoVp8SdTcA==
X-Google-Smtp-Source: AGHT+IFIfgZchtMBlkLRzAqE6ltLWDG0y9xjxgxFYaCTeC8A29rnazUN72+aS3akbCDqQQxNmIZPEA==
X-Received: by 2002:a05:600c:3ac8:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-432d4a4cf25mr36896105e9.0.1731518226014;
        Wed, 13 Nov 2024 09:17:06 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea6b5sm19157660f8f.84.2024.11.13.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:17:05 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH v3 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
Date: Wed, 13 Nov 2024 18:16:48 +0100
Message-ID: <6a8e15e68a0a2522766fd4e9668613ff0863ef4d.1731518011.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731517699.git.jth@kernel.org>
References: <cover.1731517699.git.jth@kernel.org>
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

Here we can see several indicators of in-memory data corruption, e.g. the
large negative atomic values of ->pending or
->wait->lock->rlock->raw_lock->val, as well as the bogus spinlock magic
0x1ff7ae32 (decimal 536325682 above) instead of 0xdead4ead or the bogus
pointer values for ->wait->head.

To fix this, change atomic_dec_return() to atomic_dec_and_test() to fix the
corruption, as atomic_dec_return() is defined as two instructions on
x86_64, whereas atomic_dec_and_test() is defined as a single atomic
operation. This can lead to a situation where counter value is already
decremented but the if statement in btrfs_encoded_read_endio() is not
completely processed, i.e. the 0 test has not completed. If another thread
continues executing btrfs_encoded_read_regular_fill_pages() the
atomic_dec_return() there can see an already updated ->pending counter and
continues by freeing the private data. Continuing in the endio handler the
test for 0 succeeds and the wait_queue is woken up, resulting in a
use-after-free.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 22b8e2764619..fdad1adee1a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9089,7 +9089,7 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
-	if (atomic_dec_return(&priv->pending) == 0) {
+	if (atomic_dec_and_test(&priv->pending)) {
 		int err = blk_status_to_errno(READ_ONCE(priv->status));
 
 		if (priv->uring_ctx) {
-- 
2.43.0


