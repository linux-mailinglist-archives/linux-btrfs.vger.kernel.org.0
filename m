Return-Path: <linux-btrfs+bounces-9617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCAE9C7C28
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 20:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846B028119D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560AA204095;
	Wed, 13 Nov 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smfb529f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A7180021
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526255; cv=none; b=INupRdnmxBcOnngqY1ZpvHBJSHy7N9YmU2C8NybmAo7knKI66IqdqjzBNLdt69QS7VFkMHs2/uODueeVs3VK0Jgo7q50esTm1s1hovTqaIozVUxiD3d1bEOKJ5lhDcgzwBR09T2VT5/LX0jndprFSHBegvsd37xOrpcfXiwWXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526255; c=relaxed/simple;
	bh=mWZTppmBAra9Q22120axha9pOgecnsEXeWLeqaeyT6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCMT34Rn+XNz8TkmQTIp0WOKZRosVwku/4Qf6QbJetHyRTOOCiF6suYlvK7uEdPqnOt5bNUtOPzykqsT7tCpPx0sk47gIVGelDi4/H0oL22vhqbmTrAKpgs2lOyARbc1tGwdJfHXXZk1ooLyQsvKxoSXvIns0O1StLlc371FALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smfb529f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDABC4AF09
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 19:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731526255;
	bh=mWZTppmBAra9Q22120axha9pOgecnsEXeWLeqaeyT6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Smfb529f+hv4I+o1xbbIQK2Au8m2gE2xK7pt5ZBCivuOMYSDKLO0U+WT/btIXuvAz
	 vk/ROkTzw0FWMa0JhrWiCfhsczugaufc4Pshnv5AfwVCaU8sav/6xPTg/YijOxNjB1
	 FH/NCdCSC1kpcIJZgEsqYRNCnx5536/io8k+e8vz3H1mOLaYDtdYey22TQzPz8pn5j
	 lKyIpevG7n2wJ9vpuRI16XvWKaf0GHb3mjhmhKyAb3c3dzcyHyCppwu/xHN1KJNBfK
	 KocRLLsGb1zLhAZ11b9YFpWWDzkywpC04XKxGDyCXwGLgxCpJ6LkX4f5sozP01HQxK
	 YrWAms1TGezJw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a850270e2so1332083666b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 11:30:54 -0800 (PST)
X-Gm-Message-State: AOJu0YwnYVsw/+qQH6nPwWYVVakEYrCmT1OFFyWWXNOzSD6wBAxPzkB0
	KWvKZB3JDpNTun6wtasdjMSnjZJPoDkhr/kJW6AmXYv2RW57m9GY7FTlWu7dlDH9Be8UIgWPdmx
	QncvCcbUCTJIkaE9KMAB64+yWlxw=
X-Google-Smtp-Source: AGHT+IH++7vKtF4GT0NmTlEm1o2QQcuzl2KOsuAR1caz2/UVG3PCtYGGXWwK0g33BJi+4dCETYVsWkcKDBOvdd6Tlww=
X-Received: by 2002:a17:907:804:b0:a9a:4e7d:b0a1 with SMTP id
 a640c23a62f3a-a9ef001322fmr2185893566b.49.1731526253445; Wed, 13 Nov 2024
 11:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731517699.git.jth@kernel.org> <6a8e15e68a0a2522766fd4e9668613ff0863ef4d.1731518011.git.jth@kernel.org>
In-Reply-To: <6a8e15e68a0a2522766fd4e9668613ff0863ef4d.1731518011.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Nov 2024 19:30:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53BM+PBpw16pnefkmoE1seztMOyGDA-723HPKahcXwwQ@mail.gmail.com>
Message-ID: <CAL3q7H53BM+PBpw16pnefkmoE1seztMOyGDA-723HPKahcXwwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:17=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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
> To fix this, change atomic_dec_return() to atomic_dec_and_test() to fix t=
he
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
>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 22b8e2764619..fdad1adee1a3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9089,7 +9089,7 @@ static void btrfs_encoded_read_endio(struct btrfs_b=
io *bbio)
>                  */
>                 WRITE_ONCE(priv->status, bbio->bio.bi_status);
>         }
> -       if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +       if (atomic_dec_and_test(&priv->pending)) {
>                 int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>
>                 if (priv->uring_ctx) {
> --
> 2.43.0
>
>

