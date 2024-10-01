Return-Path: <linux-btrfs+bounces-8366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C898B9BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85FB1F23962
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C75C19CC08;
	Tue,  1 Oct 2024 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hJr/6lII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E421A08B5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778660; cv=none; b=JLA0j6qfDt/WwhotLFUad3Z11L6cMwOQMbWaNOh1wsvI7xCzWXeC0eX64tlYxaXa2Zf7aSbpG/n/dqMNvjiwxHMJbh+MbgWUq8h7KyKA0pPFIL9rNSSm13cXYL5aH/j4aA7hPtQMRT3qtZP2mXPgju4kuRF+ZoZFlrVcx+DYVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778660; c=relaxed/simple;
	bh=RAcAkRKyOxpcYCvW0raknCjbDQV7ttDmlW9QQMQkw0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qx3jRmc4ipJ3qDoczNkH8wl7vDe59QkkTmTc4sg0HYMTz3NREhUcBP6r0GuYcNgr5Qsuc38nmxdXpd1ic6Qs2ua8cKV0H3pMfrXPCS9uWqmqdYroXt9bc1xxOjKSwWQkELm7LB2mP4qF9t5OezQQjoc9h4/CQPU6OkBwgopl27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hJr/6lII; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727778650; x=1728383450; i=quwenruo.btrfs@gmx.com;
	bh=XcaZTenxflhCm57FyRMjQMQ5Jby+wwqceaNS9A//Nhg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hJr/6lIItlh37WgYMBbHYCbr/QuhQTiqgCHn5Qn9H4TW2l5jxeOmxu0Icv7aaQ68
	 Qr/C3zOTpKSipvVpNkyWVnwno2CqjcLjUYx1uyQoPtPFKI9qmzzr4W+l+xbfqBnYc
	 ToDOahiqxydxoBB838AbU0NW2L/ZNhON0OWm+iLiav66rjWco1DWOtZaMBfrXMpoi
	 Ff7T7FPh/5o1SjZqaflO6s9wFKC7RIhpckTQJtYyOnjP4x3DY5JND83UZgXGXa4//
	 sl097s49wh1sFwX/XmZ0M6uQIEcbmmU5UZ6J3Sqvl9h4qpdI10RFpEvDnDxQ5mMkB
	 q+X9gClMaX/bFS/phA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1sRaPc1CcP-00SG77; Tue, 01
 Oct 2024 12:30:50 +0200
Message-ID: <d97425d5-f08f-4b2e-9e63-4930d6a24fbb@gmx.com>
Date: Tue, 1 Oct 2024 20:00:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: wait for fixup workers before stopping cleaner
 kthread during umount
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <91b0cff4e87fbc01a7a6fd7d068c6e54ea7296ea.1727777967.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <91b0cff4e87fbc01a7a6fd7d068c6e54ea7296ea.1727777967.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wk1CNyB3oJVXIcr4OJ4aVSH4K/WCrF5Rk3MsFOKiNNWlHG9su1d
 IVzGJ1t5/nG0+OPMnthArCAtlwLK8TUAzYPqdU4xMnK13rAov/U8f2i5cZRiYSF/+w1YQFr
 L1hLF++IKe2AVYvMZ5N+JHx6dYnF3hOmTK4bFkVDNNOAn4KJlB4mjyWyqm7J/J1KFdS0FE+
 Vd8b4TJWBnpGOFt+S0rNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IFtfHW2aDww=;gXA+QM0jcJVo6nHX2SRqt5kSiDB
 OTL7m/4jbiKqRQ7X4o8njEjvYZiSmOv/LrdfcgdlEZkJMDITPd3RLE9tTSlFbjnla6NWIyn/j
 NrbP6SIx5N3N6mKvAO/WOhOGjKQGdFqNOeGYh5MwKfr4AVpr09eQBQnrUFDWgB9JA9bn74edb
 bSKqrnXgqmG85EX0c7dZW/eTndLtuRrBWmGfNmZPFFt0epQRP1gzd/prMKpYCopXuFcNeswi/
 DUTvc4KPnLq2UeKYbVAsA0qx6RLEM1snYHv9w6tdoP/CpE8rRw4d4KiYzeDprJ87ddFHsb8eu
 4/Rb9wRlLTbUmETB1ykwZAWeYvtlj7i2ziQPRci/cI/WHLXehoQZCgtAbuHtEuZCS/jx56mLu
 CoXiGUhc4cnwNZbQyKSfSmUXOjtWoXQzd/m5nVeaUFL2sLqbfkgMwR/8bv/HfrnsbBCiUIVNc
 pshhFN6z5ZnqfFqVxP1aVwfVpiwJ4NdCR7mthhaGVlZRE6AvMXAfVB6V0Q9csHPnJRw0KsWfF
 jvadzmoMqZSY9/wbOYDsqx9omU6AFF0WiB7MocPp9+cfZpEH5JdEnSza5c9aoEskRe8puyPCI
 ebhw/Fsj5Tf7svKlg6ro8u2y0AYvou0nOrgTPTQFGr8EhKUnt3velyIIJ9x1nnwtqBZAWwMVO
 CTCFohvpiLaQMU0LnUADOdL9Btf4WA9fSid1UkOMUdWnwe4O3VDlaLyhYr0bB9va4Z+c9WhID
 ghapLrB300FspaNo9fBM1xHPZzO6A4xwegXMCpC4ADlOBOfAW1A/J9wX+XO7TYRXr4j/XRPAR
 PrY4izjzTgXY0F7RhUTXUK+MBOgCs7BAECKh/Et2+fki8=



=E5=9C=A8 2024/10/1 19:51, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During unmount, at close_ctree(), we have the following steps in this or=
der:
>
> 1) Park the cleaner kthread - this doesn't destroy the kthread, it basic=
ally
>     halts its execution (wake ups against it work but do nothing);
>
> 2) We stop the cleaner kthread - this results in freeing the respective
>     struct task_struct;
>
> 3) We call btrfs_stop_all_workers() which waits for any jobs running in =
all
>     the work queues and then free the work queues.
>
> Syzbot reported a case where a fixup worker resulted in a crash when doi=
ng
> a delayed iput on its inode while attempting to wake up the cleaner at
> btrfs_add_delayed_iput(), because the task_struct of the cleaner kthread
> was already freed. This can happen during unmount because we don't wait
> for any fixup workers still running before we call kthread_stop() agains=
t
> the cleaner kthread, which stops and free all its resources.
>
> Fix this by waiting for any fixup workers at close_ctree() before we cal=
l
> kthread_stop() against the cleaner and run pending delayed iputs.
>
> The stack traces reported by syzbot were the following:
>
>     BUG: KASAN: slab-use-after-free in __lock_acquire+0x77/0x2050 kernel=
/locking/lockdep.c:5065
>     Read of size 8 at addr ffff8880272a8a18 by task kworker/u8:3/52
>
>     CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.12.0-rc1-syzk=
aller #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 09/13/2024
>     Workqueue: btrfs-fixup btrfs_work_helper
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:94 [inline]
>      dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>      print_address_description mm/kasan/report.c:377 [inline]
>      print_report+0x169/0x550 mm/kasan/report.c:488
>      kasan_report+0x143/0x180 mm/kasan/report.c:601
>      __lock_acquire+0x77/0x2050 kernel/locking/lockdep.c:5065
>      lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inlin=
e]
>      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>      class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551=
 [inline]
>      try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4154
>      btrfs_writepage_fixup_worker+0xc16/0xdf0 fs/btrfs/inode.c:2842
>      btrfs_work_helper+0x390/0xc50 fs/btrfs/async-thread.c:314
>      process_one_work kernel/workqueue.c:3229 [inline]
>      process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>      worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>      kthread+0x2f0/0x390 kernel/kthread.c:389
>      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>      </TASK>
>
>     Allocated by task 2:
>      kasan_save_stack mm/kasan/common.c:47 [inline]
>      kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>      unpoison_slab_object mm/kasan/common.c:319 [inline]
>      __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
>      kasan_slab_alloc include/linux/kasan.h:247 [inline]
>      slab_post_alloc_hook mm/slub.c:4086 [inline]
>      slab_alloc_node mm/slub.c:4135 [inline]
>      kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4187
>      alloc_task_struct_node kernel/fork.c:180 [inline]
>      dup_task_struct+0x57/0x8c0 kernel/fork.c:1107
>      copy_process+0x5d1/0x3d50 kernel/fork.c:2206
>      kernel_clone+0x223/0x880 kernel/fork.c:2787
>      kernel_thread+0x1bc/0x240 kernel/fork.c:2849
>      create_kthread kernel/kthread.c:412 [inline]
>      kthreadd+0x60d/0x810 kernel/kthread.c:765
>      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
>     Freed by task 61:
>      kasan_save_stack mm/kasan/common.c:47 [inline]
>      kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>      kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>      poison_slab_object mm/kasan/common.c:247 [inline]
>      __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>      kasan_slab_free include/linux/kasan.h:230 [inline]
>      slab_free_hook mm/slub.c:2343 [inline]
>      slab_free mm/slub.c:4580 [inline]
>      kmem_cache_free+0x1a2/0x420 mm/slub.c:4682
>      put_task_struct include/linux/sched/task.h:144 [inline]
>      delayed_put_task_struct+0x125/0x300 kernel/exit.c:228
>      rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>      rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>      handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
>      __do_softirq kernel/softirq.c:588 [inline]
>      invoke_softirq kernel/softirq.c:428 [inline]
>      __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>      irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 =
[inline]
>      sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1=
037
>      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idte=
ntry.h:702
>
>     Last potentially related work creation:
>      kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>      __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
>      __call_rcu_common kernel/rcu/tree.c:3086 [inline]
>      call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
>      context_switch kernel/sched/core.c:5318 [inline]
>      __schedule+0x184b/0x4ae0 kernel/sched/core.c:6675
>      schedule_idle+0x56/0x90 kernel/sched/core.c:6793
>      do_idle+0x56a/0x5d0 kernel/sched/idle.c:354
>      cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
>      start_secondary+0x102/0x110 arch/x86/kernel/smpboot.c:314
>      common_startup_64+0x13e/0x147
>
>     The buggy address belongs to the object at ffff8880272a8000
>      which belongs to the cache task_struct of size 7424
>     The buggy address is located 2584 bytes inside of
>      freed 7424-byte region [ffff8880272a8000, ffff8880272a9d00)
>
>     The buggy address belongs to the physical page:
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0=
x272a8
>     head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
>     flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
>     page_type: f5(slab)
>     raw: 00fff00000000040 ffff88801bafa500 dead000000000122 000000000000=
0000
>     raw: 0000000000000000 0000000080040004 00000001f5000000 000000000000=
0000
>     head: 00fff00000000040 ffff88801bafa500 dead000000000122 00000000000=
00000
>     head: 0000000000000000 0000000080040004 00000001f5000000 00000000000=
00000
>     head: 00fff00000000003 ffffea00009caa01 ffffffffffffffff 00000000000=
00000
>     head: 0000000000000008 0000000000000000 00000000ffffffff 00000000000=
00000
>     page dumped because: kasan: bad access detected
>     page_owner tracks the page as allocated
>     page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd=
20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMAL=
LOC), pid 2, tgid 2 (kthreadd), ts 71247381401, free_ts 71214998153
>      set_page_owner include/linux/page_owner.h:32 [inline]
>      post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>      prep_new_page mm/page_alloc.c:1545 [inline]
>      get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
>      __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
>      alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>      alloc_slab_page+0x6a/0x120 mm/slub.c:2413
>      allocate_slab+0x5a/0x2f0 mm/slub.c:2579
>      new_slab mm/slub.c:2632 [inline]
>      ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
>      __slab_alloc+0x58/0xa0 mm/slub.c:3909
>      __slab_alloc_node mm/slub.c:3962 [inline]
>      slab_alloc_node mm/slub.c:4123 [inline]
>      kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4187
>      alloc_task_struct_node kernel/fork.c:180 [inline]
>      dup_task_struct+0x57/0x8c0 kernel/fork.c:1107
>      copy_process+0x5d1/0x3d50 kernel/fork.c:2206
>      kernel_clone+0x223/0x880 kernel/fork.c:2787
>      kernel_thread+0x1bc/0x240 kernel/fork.c:2849
>      create_kthread kernel/kthread.c:412 [inline]
>      kthreadd+0x60d/0x810 kernel/kthread.c:765
>      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>     page last free pid 5230 tgid 5230 stack trace:
>      reset_page_owner include/linux/page_owner.h:25 [inline]
>      free_pages_prepare mm/page_alloc.c:1108 [inline]
>      free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
>      discard_slab mm/slub.c:2678 [inline]
>      __put_partials+0xeb/0x130 mm/slub.c:3146
>      put_cpu_partial+0x17c/0x250 mm/slub.c:3221
>      __slab_free+0x2ea/0x3d0 mm/slub.c:4450
>      qlink_free mm/kasan/quarantine.c:163 [inline]
>      qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>      kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>      __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>      kasan_slab_alloc include/linux/kasan.h:247 [inline]
>      slab_post_alloc_hook mm/slub.c:4086 [inline]
>      slab_alloc_node mm/slub.c:4135 [inline]
>      kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
>      getname_flags+0xb7/0x540 fs/namei.c:139
>      do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
>      do_sys_open fs/open.c:1430 [inline]
>      __do_sys_openat fs/open.c:1446 [inline]
>      __se_sys_openat fs/open.c:1441 [inline]
>      __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>     Memory state around the buggy address:
>      ffff8880272a8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff8880272a8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     >ffff8880272a8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                 ^
>      ffff8880272a8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff8880272a8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Link: https://lore.kernel.org/linux-btrfs/66fb36b1.050a0220.aab67.003b.G=
AE@google.com/
> Reported-by: syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for the quick fix,
Qu

> ---
>   fs/btrfs/disk-io.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 25d768e67e37..1238a38c59b2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4255,6 +4255,17 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>   	/* clear out the rbtree of defraggable inodes */
>   	btrfs_cleanup_defrag_inodes(fs_info);
>
> +	/*
> +	 * Wait for any fixup workers to complete.
> +	 * If we don't wait for them here and they are still running by the ti=
me
> +	 * we call kthread_stop() against the cleaner kthread further below, w=
e
> +	 * get an use-after-free on the cleaner because the fixup worker adds =
an
> +	 * inode to the list of delayed iputs and then attempts to wakeup the
> +	 * cleaner kthread, which was already stopped and destroyed. We parked
> +	 * already the cleaner, but below we run all pending delayed iputs.
> +	 */
> +	btrfs_flush_workqueue(fs_info->fixup_workers);
> +
>   	/*
>   	 * After we parked the cleaner kthread, ordered extents may have
>   	 * completed and created new delayed iputs. If one of the async recla=
im


