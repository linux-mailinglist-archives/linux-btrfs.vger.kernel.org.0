Return-Path: <linux-btrfs+bounces-9425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACDC9C3F8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 14:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA671C217AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 13:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4BF19D075;
	Mon, 11 Nov 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IReoKAM4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E1BC58
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331680; cv=none; b=lNmAOV65tC17bdRRl6g1g7vDYdEb81JKTUeltEQSEiejlkLlbfe32Hw0Cithb1o0X/Y+WmsKMMtVYLAKpWu3DxHXBHeOhlwZKd6iwKVwrxCYnUnN0lrVXdxE22pZbLsAQjZ8LXNLHV65Qscf12saLa/0Jqs0j7gGkoE4Sg9hk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331680; c=relaxed/simple;
	bh=wd7kRrDX+FcuxUq/2cUGZ5QXMVRdLpbHl0aWe1Vy68Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SErTs07XdbwjbHPJCIky1eeY0YvGAbt4BRF4S32qL77fKrRFGHaRQkvGhIKo724QY61po/u9hU7gGtqga2qmUMkVlAWCE46kf0w/CipWxGCB49+b28QB4EHv89Uu76WqjJUDh9oT5qMfLXJxP9w4lG+xw/FPcZ+l4S1uhNVOwfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IReoKAM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAF0C4CED7
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731331680;
	bh=wd7kRrDX+FcuxUq/2cUGZ5QXMVRdLpbHl0aWe1Vy68Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IReoKAM4qoEmXM+W8K49jAvf1RbCNNF7EcOoEr/BjeC9EWP3e8WZ1gU0vNQNA7EGn
	 VVm0OH8x4D2Pvph606I6ZWvcH8ZHc5+tTknfkPBiKZS90GQX2xXIMidKckHTSOSMxZ
	 Es0sVet+F9SxKd5iaU6yNNlab8eKE13kWca1tgNgMBvX76nyL88bcuVmdvOnBxIb50
	 GPChv8C8zQpFci9oNQFMHb5Fu96cj1AtH5qZHdU9KbF6XGtrJDEUqQiBxy4LFOu2as
	 WZoQ7X99v4H3B16zbzYdIBY0xYKzr76NI5EDADIHVX8aM3wq2/x/jIQcLbmnFPhQQ9
	 DX77Z6c7h8e2w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9acafdb745so900274866b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 05:28:00 -0800 (PST)
X-Gm-Message-State: AOJu0Yz/Y0XOeCdHp6odE+RBEYwfA4WAROUGWrSufCXD3ENwcl75shOl
	S/8TVdTYto4bqpaSTqTk/uM+o/Pvi3o7uqSaJeXNjgn/P83C0xyAuLHf+grDWMcI8p6Jh1n4yjY
	pujLsYcfdLd7pFJ0fSk9xbmP0/ic=
X-Google-Smtp-Source: AGHT+IH4ebNj/favCoifuAt9cChmrzVxpGPgwqbsOnnzWLFHkIxGGD1+zWSG5vFmpQhOGO92Cc61KFH1eGFALcSPa0Y=
X-Received: by 2002:a17:906:ee86:b0:a9e:c5a2:9cda with SMTP id
 a640c23a62f3a-a9eeca85d0emr1303049566b.20.1731331678705; Mon, 11 Nov 2024
 05:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731316882.git.jth@kernel.org> <88ede763421d4f9847a057bdc944cb9c684e8cae.1731316882.git.jth@kernel.org>
In-Reply-To: <88ede763421d4f9847a057bdc944cb9c684e8cae.1731316882.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 11 Nov 2024 13:27:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7k8buoKnegzh1r4a0zmeErozBOP8JN0jfeBVLeLqDZLQ@mail.gmail.com>
Message-ID: <CAL3q7H7k8buoKnegzh1r4a0zmeErozBOP8JN0jfeBVLeLqDZLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Mark Harmstone <maharmstone@fb.com>, 
	Omar Sandoval <osandov@osandov.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:28=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
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

Can you highlight what's the corruption?
Just dumping a large structure isn't immediately obvious, I suppose
you mean it's related to the large negative values of the atomic
counters?

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
> Move the call to bio_put() before the atomic_test operation and
> also change atomic_dec_return() to atomic_dec_and_test() to fix the
> corruption, as atomic_dec_return() is defined as two instructions on
> x86_64, whereas atomic_dec_and_test() is defineda s a single atomic
> operation.

And why does this fixes the problem?

Can we also get a description here about why the corruption happens?
Having this may be enough to understand why these changes fix the bug.

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

