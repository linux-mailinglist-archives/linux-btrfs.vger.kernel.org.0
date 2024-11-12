Return-Path: <linux-btrfs+bounces-9519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C339C5AC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A568F283B3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5121FEFBD;
	Tue, 12 Nov 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Os1x1F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995483A14
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422759; cv=none; b=C+Ks13uARCLiL1KkqhLMXL2FlanKOacxZnSylpNeoZm9GW1QodPyUbKIhCkQ0OkxU4QPnwEi2YE0qsq6YH6bB8zzoHlG1HfQlHa6cCdsyHdKeLKHMYwEobK34UFsk5vN9ty/rTpzjneqFRkjqRSVYz1XbDUPdQeV6AwRDPEhHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422759; c=relaxed/simple;
	bh=H1jPGxMKg62FGCvZ/jSdbiYXOfanALNgpLqcRryNLmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sh1ElAZYGSnt4W7K5rpzkfj/8YK5zR4YCUZ7LLX2/8tfnut9RwP4IyJIAZXA+HFQ4V5HxZylyY00om3Dn7mVejLEavqh7RAkS+MbvlpT9ffJBYZJYc00VYxE+c2vwXeG/W4JVUzQSljvy7mBaMc4A5arsIq+A5Ve+9Go/6ofNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Os1x1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AC6C4CED6
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422758;
	bh=H1jPGxMKg62FGCvZ/jSdbiYXOfanALNgpLqcRryNLmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2Os1x1FjcH3hAtBLzEu7Bf9Y34GCaeNIb9htscY5wJJDGcX43/jRVq1hOaWH7ESK
	 B6FUkHq/ey9jupjLeXu0uBlKiVf3jFnJ4Em/XRripnCrl2rbtEJDvzZJbWzT7iJBsa
	 CgQm9u30ffzDSB6ZoCbNPLw2oyNsTb7Urr4xZKi1vIJ/QGkbt+/7SqeNRPGGDU2tCw
	 uPvxyh1QWxOrXQjMlZpRWp36tsfrJwvUEEPY9IZIypJY9Xp+eMp5RnBTXznt56w/PD
	 vfwg7fK4VFzUleEcAj3U3Ts9cmd5UjOulsD2ZlvJeMrgRX1foj02CA9/iTIXycxL/B
	 pSC73Y5lTmUuQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so8297800a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 06:45:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yz+TAntB7xJyt50yW1ybDp6ckGv8yThSrPfOechor4x1CO8Xaxt
	uOALK1xeyY/zg3nvDOyEjHraJpUPGKvo61mJjYarjHmeLeBvXbD0jyLbGqNXFMI10iHZEsh6BZm
	xY7IjEb0Il/nIaBLIWZOCvuHCdzQ=
X-Google-Smtp-Source: AGHT+IHV4Om/OKNQGnwHDPVA5u9kG/IWQhrMTLkzMx80FTrO9fzKfsmK5F60Yy+FtTgJbcfVCF/d7uycnxOrTh+SOCA=
X-Received: by 2002:a17:907:3f8a:b0:a9e:c954:6afb with SMTP id
 a640c23a62f3a-a9ef0018b25mr1696344166b.51.1731422757066; Tue, 12 Nov 2024
 06:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731407982.git.jth@kernel.org> <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
In-Reply-To: <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 12 Nov 2024 14:45:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6qyPn0aeq=LiFpubpvLH6Z7CzZ6649zYPpGFvjuVeCQg@mail.gmail.com>
Message-ID: <CAL3q7H6qyPn0aeq=LiFpubpvLH6Z7CzZ6649zYPpGFvjuVeCQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:54=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Shinichiro reported the following use-after free that sometimes is
> happening in our CI system when running fstests' btrfs/284 on a TCMU
> runner device:
>
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    BUG: KASAN: slab-use-after-free in lock_release+0x708/0x780
>    Read of size 8 at addr ffff888106a83f18 by task kworker/u80:6/219
>
>    CPU: 8 UID: 0 PID: 219 Comm: kworker/u80:6 Not tainted 6.12.0-rc6-kts+=
 #15
>    Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
>    Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x6e/0xa0
>     ? lock_release+0x708/0x780
>     print_report+0x174/0x505
>     ? lock_release+0x708/0x780
>     ? __virt_addr_valid+0x224/0x410
>     ? lock_release+0x708/0x780
>     kasan_report+0xda/0x1b0
>     ? lock_release+0x708/0x780
>     ? __wake_up+0x44/0x60
>     lock_release+0x708/0x780
>     ? __pfx_lock_release+0x10/0x10
>     ? __pfx_do_raw_spin_lock+0x10/0x10
>     ? lock_is_held_type+0x9a/0x110
>     _raw_spin_unlock_irqrestore+0x1f/0x60
>     __wake_up+0x44/0x60
>     btrfs_encoded_read_endio+0x14b/0x190 [btrfs]
>     btrfs_check_read_bio+0x8d9/0x1360 [btrfs]
>     ? lock_release+0x1b0/0x780
>     ? trace_lock_acquire+0x12f/0x1a0
>     ? __pfx_btrfs_check_read_bio+0x10/0x10 [btrfs]
>     ? process_one_work+0x7e3/0x1460
>     ? lock_acquire+0x31/0xc0
>     ? process_one_work+0x7e3/0x1460
>     process_one_work+0x85c/0x1460
>     ? __pfx_process_one_work+0x10/0x10
>     ? assign_work+0x16c/0x240
>     worker_thread+0x5e6/0xfc0
>     ? __pfx_worker_thread+0x10/0x10
>     kthread+0x2c3/0x3a0
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork+0x31/0x70
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
>
>    Allocated by task 3661:
>     kasan_save_stack+0x30/0x50
>     kasan_save_track+0x14/0x30
>     __kasan_kmalloc+0xaa/0xb0
>     btrfs_encoded_read_regular_fill_pages+0x16c/0x6d0 [btrfs]
>     send_extent_data+0xf0f/0x24a0 [btrfs]
>     process_extent+0x48a/0x1830 [btrfs]
>     changed_cb+0x178b/0x2ea0 [btrfs]
>     btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>     _btrfs_ioctl_send+0x117/0x330 [btrfs]
>     btrfs_ioctl+0x184a/0x60a0 [btrfs]
>     __x64_sys_ioctl+0x12e/0x1a0
>     do_syscall_64+0x95/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>    Freed by task 3661:
>     kasan_save_stack+0x30/0x50
>     kasan_save_track+0x14/0x30
>     kasan_save_free_info+0x3b/0x70
>     __kasan_slab_free+0x4f/0x70
>     kfree+0x143/0x490
>     btrfs_encoded_read_regular_fill_pages+0x531/0x6d0 [btrfs]
>     send_extent_data+0xf0f/0x24a0 [btrfs]
>     process_extent+0x48a/0x1830 [btrfs]
>     changed_cb+0x178b/0x2ea0 [btrfs]
>     btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>     _btrfs_ioctl_send+0x117/0x330 [btrfs]
>     btrfs_ioctl+0x184a/0x60a0 [btrfs]
>     __x64_sys_ioctl+0x12e/0x1a0
>     do_syscall_64+0x95/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>    The buggy address belongs to the object at ffff888106a83f00
>     which belongs to the cache kmalloc-rnd-07-96 of size 96
>    The buggy address is located 24 bytes inside of
>     freed 96-byte region [ffff888106a83f00, ffff888106a83f60)
>
>    The buggy address belongs to the physical page:
>    page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810=
6a83800 pfn:0x106a83
>    flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
>    page_type: f5(slab)
>    raw: 0017ffffc0000000 ffff888100053680 ffffea0004917200 00000000000000=
04
>    raw: ffff888106a83800 0000000080200019 00000001f5000000 00000000000000=
00
>    page dumped because: kasan: bad access detected
>
>    Memory state around the buggy address:
>     ffff888106a83e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>     ffff888106a83e80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>    >ffff888106a83f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                ^
>     ffff888106a83f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>     ffff888106a84000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Further analyzing the trace and the crash dump's vmcore file shows that
> the wake_up() call in btrfs_encoded_read_endio() is calling wake_up() on
> the wait_queue that is in the private data passed to the end_io handler.
>
> Commit 4ff47df40447 ("btrfs: move priv off stack in
> btrfs_encoded_read_regular_fill_pages()") moved 'struct
> btrfs_encoded_read_private' off the stack.
>
> Before that commit one can see a corruption of the private data when
> analyzing the vmcore after a crash:
>
> *(struct btrfs_encoded_read_private *)0xffff88815626eec8 =3D {
>         .wait =3D (wait_queue_head_t){
>                 .lock =3D (spinlock_t){
>                         .rlock =3D (struct raw_spinlock){
>                                 .raw_lock =3D (arch_spinlock_t){
>                                         .val =3D (atomic_t){
>                                                 .counter =3D (int)-200588=
5696,
>                                         },
>                                         .locked =3D (u8)0,
>                                         .pending =3D (u8)157,
>                                         .locked_pending =3D (u16)40192,
>                                         .tail =3D (u16)34928,
>                                 },
>                                 .magic =3D (unsigned int)536325682,
>                                 .owner_cpu =3D (unsigned int)29,
>                                 .owner =3D (void *)__SCT__tp_func_btrfs_t=
ransaction_commit+0x0 =3D 0x0,
>                                 .dep_map =3D (struct lockdep_map){
>                                         .key =3D (struct lock_class_key *=
)0xffff8881575a3b6c,
>                                         .class_cache =3D (struct lock_cla=
ss *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
>                                         .name =3D (const char *)0xffff888=
15626f100 =3D "",
>                                         .wait_type_outer =3D (u8)37,
>                                         .wait_type_inner =3D (u8)178,
>                                         .lock_type =3D (u8)154,
>                                 },
>                         },
>                         .__padding =3D (u8 [24]){ 0, 157, 112, 136, 50, 1=
74, 247, 31, 29 },
>                         .dep_map =3D (struct lockdep_map){
>                                 .key =3D (struct lock_class_key *)0xffff8=
881575a3b6c,
>                                 .class_cache =3D (struct lock_class *[2])=
{ 0xffff8882a71985c0, 0xffffea00066f5d40 },
>                                 .name =3D (const char *)0xffff88815626f10=
0 =3D "",
>                                 .wait_type_outer =3D (u8)37,
>                                 .wait_type_inner =3D (u8)178,
>                                 .lock_type =3D (u8)154,
>                         },
>                 },
>                 .head =3D (struct list_head){
>                         .next =3D (struct list_head *)0x112cca,
>                         .prev =3D (struct list_head *)0x47,
>                 },
>         },
>         .pending =3D (atomic_t){
>                 .counter =3D (int)-1491499288,
>         },
>         .status =3D (blk_status_t)130,
> }
>
> Here we can see several indicators of in-memory data corruption, e.g. the
> large negative atomic values of ->pending or
> ->wait->lock->rlock->raw_lock->val, as well as the bogus spinlock magic
> 0x1ff7ae32 (decimal 536325682 above) instead of 0xdead4ead or the bogus
> pointer values for ->wait->head.
>
> To fix this, move the call to bio_put() before the atomic_test operation
> so the submitter side in btrfs_encoded_read_regular_fill_pages() is not
> woken up before the bio is cleaned up.

This is the part I don't see what's the relation to the use-after-free
problem on the private structure.
This seems like a cleanup that should be a separate patch with its own
changelog.

>
> Also change atomic_dec_return() to atomic_dec_and_test() to fix the
> corruption, as atomic_dec_return() is defined as two instructions on
> x86_64, whereas atomic_dec_and_test() is defined as a single atomic
> operation. This can lead to a situation where counter value is already
> decremented but the if statement in btrfs_encoded_read_endio() is not
> completely processed, i.e. the 0 test has not completed. If another threa=
d
> continues executing btrfs_encoded_read_regular_fill_pages() the
> atomic_dec_return() there can see an already updated ->pending counter an=
d
> continues by freeing the private data. Continuing in the endio handler th=
e
> test for 0 succeeds and the wait_queue is woken up, resulting in a
> use-after-free.

This is the sort of explanation that should have been in v1.
Basically, that the non-atomicity of atomic_dec_return() can make the
waiter see the 0 value and free the private structure before the waker
does a wake_up() against the private's wait queue.

So with bio_put() change in a separate patch:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

(or with it but with an explanation on how this relates to the
use-after-free, which I can't see)

Thanks.

>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 22b8e2764619..cb8b23a3e56b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9089,7 +9089,8 @@ static void btrfs_encoded_read_endio(struct btrfs_b=
io *bbio)
>                  */
>                 WRITE_ONCE(priv->status, bbio->bio.bi_status);
>         }
> -       if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +       bio_put(&bbio->bio);
> +       if (atomic_dec_and_test(&priv->pending)) {
>                 int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>
>                 if (priv->uring_ctx) {
> @@ -9099,7 +9100,6 @@ static void btrfs_encoded_read_endio(struct btrfs_b=
io *bbio)
>                         wake_up(&priv->wait);
>                 }
>         }
> -       bio_put(&bbio->bio);
>  }
>
>  int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
> --
> 2.43.0
>
>

