Return-Path: <linux-btrfs+bounces-10042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE87B9E2DC1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 22:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D446283F53
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93149207A33;
	Tue,  3 Dec 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EONdgIwK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133F3987D
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259676; cv=none; b=JDtKO1RJbHKSzzc/s2D58N8LYSjwDyQdhOM/m1ROpr4/W3O/Hg5tSFoSFdr7hoJB39F7QkHE1qGn47ABrjigoxpP6/+X6it0WIjyB7NMZOzm5MXade1e/Wzt8lHXUDqKigQLA9eQnNE/HpmaXa8jtOrtiaNVZq7q/+kLzcRJg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259676; c=relaxed/simple;
	bh=llv++qsDL/vjY24yp4K3jby1IzsCxoeN94GmrfQfJMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mBIkisa/gEzDsXx8rl9GiC6O3UVd0CQmswoyF8pJXLzgPJzl9l7yU2eNtqUZskeZb52JrUyfWdzJ2BDpeq3zIoC8zp4q5qLr+xFnhR3f0mxhPzCQoEJQ1xmApEZ3aU7MycvY/yJIw6ngIs4oanWODyfnJIBDwLotajb8F75SAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EONdgIwK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733259667; x=1733864467; i=quwenruo.btrfs@gmx.com;
	bh=zO0nP5EP2SOtq1/2bXqiRTkZg/pA2Os7vsXF2Yg37/w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EONdgIwKhQYE4BULqKGi8jQqZFBGLGl54MJljCCxGyIJGawUJFMy2Hcut+Me06jg
	 oti31laUJnetCyjYf4bOnPAkIsvlWlA024CeWibVFnIBshtd2wmgwjpbEkhd6WqfX
	 0X6vs9f7O8HGPgLA7utl2x1MbVx8rgPCiji2bewEwu+zsRz7+cHwnJr1Ma/zZNpKu
	 b09Y///zwxMgKnpVQOfrONaxuwgJQ4qNkcEmdnWoiAbLV9FIPQcz0KZrjNWXiyEyx
	 VkFQIests7yripxJHq0+Gc1z/HInQ89vPws5Z53ORl6buTBxpgcCZ6LdP/BVAP2Tz
	 tCpD6JcNc0f8gPJ/5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIwz4-1syAoq2614-00RyOP; Tue, 03
 Dec 2024 22:01:07 +0100
Message-ID: <b51b5195-b567-480c-a3b0-a304f3a69fc6@gmx.com>
Date: Wed, 4 Dec 2024 07:31:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: flush delalloc workers queue before stopping
 cleaner kthread during unmount
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b6a7ec3458c7a704fe34408a1243c6a13c08a313.1733227289.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <b6a7ec3458c7a704fe34408a1243c6a13c08a313.1733227289.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FUo5ccD64fWharmrDQse8VLtBjluUokBfjvixMuBawiwFItcYc+
 qLiqAi1VCqInsNOBsFLwgjCyB2NPj/KFnXC6GIA2lEhlS6s/3ioNXpMopsCapp2K0Q+WFNV
 0zLy33F0vCcqDG93cjmo9/rLwU0uJG7/u6+PIJSlsM2zaKKiryPRfW0HNH5K5nEfI7W62K2
 zOV7X1I6iLJJsvWmbd4kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s9DGngVlBhQ=;ky6JLFnqIpDd9k7urgK1LFyJH1n
 +okqZBaVNzGd/sGua0YN7pjz/xXkQJDr1N1yKM0EUp09gukDRhTP3wC4a7V/QVuS2oMYdFnzM
 OXaA70ra7KW26dTZB+xjlPtOv7urJSpjozIFyB7y8O3ppGqgFcOqQUS//UcHwKvoWnYmvWlg9
 SLw4nIUYAS5s+s9KbrVY3AMN5RvOucNY2vtp6K0iuJMRPma2IRGopQ5pjS5LGkGgVxhzb5B5S
 Pu+pDM8847VYegN6H89Nd3zgCkl96X117JJOSk9iqkiogvYxeh03ZR9sXJiJ/scnZ68gm+bmS
 9QPRDY9kcqKveBFZdEQtYupg8pMvnVZRg1sBI+imoeSxpCPJ2Kzu+yOcFhQu4bJSHCBB5A0Ln
 t2GFsKNkbk6/tCEMZSVzFM6DNMiCUcr3goUdzf0C5pdACBpp2ynv7us5yVl+Nhb3htUpbVAtd
 ItJ9HPK5DWswJdokpCBXXpKS7FLUbtjdn+bBJ74nPNAlJiIMF6ddsco15x8pNyvucH1PpPX8h
 atiH3FUOfrKbx1VZXHE3ft+laGW9aGn0ywgRVIE+uYNGu8+o1JzbOOLc4lwxHcRSUewKfBaVJ
 HIJsgyll9ZF4NegM2Xk4pnRxDc6BOIePUAfA97ZVDmQwc857EIjLWMmxI2aSoeZtqp12bJlkm
 ZaghXhfj1Xwcyki5V4yNZrxuXHnwOK97ZExCgZI3guWzhE018cBzuapq29H14oLS2zVkJloE3
 UV9A0bTmtxUH9LnEwPe2/qU7ht5Tyg96xyOkykl4w6DZb0qE7+NiRyVFgB6N1V7PjdPLvQlWP
 RJdTXUM6zOOTKM5lBlqoSJTfjrtmmOSZ4BbVuNhktVKpWkqVPUcj8pfNXNNkMQSzvWeYbtkir
 pl2WWsQVip+my7QJOhnu6usD5gav5eEq47tLy5dptX0DkhrLLAw+qZEYs/MerIsWWlOoD+f5v
 4xzSW8sz5lNUvzXHm8vl9wk/2/C2p2DwDeVEU8sSAtx9HQu4h0IzoME9m5YMPr41blSUhM/Nb
 9EiSrTlgGJL3xxwcpFigNUcbDjecugFckbEHb35Qx5Fbdm/m2UpDnDKk+Aeug4lQGITz+BQiE
 uaNpGoTPuyo+YhqmN9xpXbFpgnkRcs



=E5=9C=A8 2024/12/3 22:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During the unmount path, at close_ctree(), we first stop the cleaner
> kthread, using kthread_stop() which frees the associated task_struct, an=
d
> then stop and destroy all the work queues. However after we stopped the
> cleaner we may still have a worker from the delalloc_workers queue runni=
ng
> inode.c:submit_compressed_extents(), which calls btrfs_add_delayed_iput(=
),
> which in turn tries to wake up the cleaner kthread - which was already
> destroyed before, resulting in a use-after-free on the task_struct.
>
> Syzbot reported this with the following stack traces:
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     BUG: KASAN: slab-use-after-free in __lock_acquire+0x78/0x2100 kernel=
/locking/lockdep.c:5089
>     Read of size 8 at addr ffff8880259d2818 by task kworker/u8:3/52
>
>     CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.13.0-rc1-syzk=
aller-00002-gcdd30ebb1b9f #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 09/13/2024
>     Workqueue: btrfs-delalloc btrfs_work_helper
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:94 [inline]
>      dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>      print_address_description mm/kasan/report.c:378 [inline]
>      print_report+0x169/0x550 mm/kasan/report.c:489
>      kasan_report+0x143/0x180 mm/kasan/report.c:602
>      __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
>      lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inlin=
e]
>      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>      class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551=
 [inline]
>      try_to_wake_up+0xc2/0x1470 kernel/sched/core.c:4205
>      submit_compressed_extents+0xdf/0x16e0 fs/btrfs/inode.c:1615
>      run_ordered_work fs/btrfs/async-thread.c:288 [inline]
>      btrfs_work_helper+0x96f/0xc40 fs/btrfs/async-thread.c:324
>      process_one_work kernel/workqueue.c:3229 [inline]
>      process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
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
>      kasan_slab_alloc include/linux/kasan.h:250 [inline]
>      slab_post_alloc_hook mm/slub.c:4104 [inline]
>      slab_alloc_node mm/slub.c:4153 [inline]
>      kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
>      alloc_task_struct_node kernel/fork.c:180 [inline]
>      dup_task_struct+0x57/0x8c0 kernel/fork.c:1113
>      copy_process+0x5d1/0x3d50 kernel/fork.c:2225
>      kernel_clone+0x223/0x870 kernel/fork.c:2807
>      kernel_thread+0x1bc/0x240 kernel/fork.c:2869
>      create_kthread kernel/kthread.c:412 [inline]
>      kthreadd+0x60d/0x810 kernel/kthread.c:767
>      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
>     Freed by task 24:
>      kasan_save_stack mm/kasan/common.c:47 [inline]
>      kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>      kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
>      poison_slab_object mm/kasan/common.c:247 [inline]
>      __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>      kasan_slab_free include/linux/kasan.h:233 [inline]
>      slab_free_hook mm/slub.c:2338 [inline]
>      slab_free mm/slub.c:4598 [inline]
>      kmem_cache_free+0x195/0x410 mm/slub.c:4700
>      put_task_struct include/linux/sched/task.h:144 [inline]
>      delayed_put_task_struct+0x125/0x300 kernel/exit.c:227
>      rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>      rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>      handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
>      run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
>      smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
>      kthread+0x2f0/0x390 kernel/kthread.c:389
>      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
>     Last potentially related work creation:
>      kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>      __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
>      __call_rcu_common kernel/rcu/tree.c:3086 [inline]
>      call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
>      context_switch kernel/sched/core.c:5372 [inline]
>      __schedule+0x1803/0x4be0 kernel/sched/core.c:6756
>      __schedule_loop kernel/sched/core.c:6833 [inline]
>      schedule+0x14b/0x320 kernel/sched/core.c:6848
>      schedule_timeout+0xb0/0x290 kernel/time/sleep_timeout.c:75
>      do_wait_for_common kernel/sched/completion.c:95 [inline]
>      __wait_for_common kernel/sched/completion.c:116 [inline]
>      wait_for_common kernel/sched/completion.c:127 [inline]
>      wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
>      kthread_stop+0x19e/0x640 kernel/kthread.c:712
>      close_ctree+0x524/0xd60 fs/btrfs/disk-io.c:4328
>      generic_shutdown_super+0x139/0x2d0 fs/super.c:642
>      kill_anon_super+0x3b/0x70 fs/super.c:1237
>      btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2112
>      deactivate_locked_super+0xc4/0x130 fs/super.c:473
>      cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>      task_work_run+0x24f/0x310 kernel/task_work.c:239
>      ptrace_notify+0x2d2/0x380 kernel/signal.c:2503
>      ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>      ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>      syscall_exit_work+0xc7/0x1d0 kernel/entry/common.c:173
>      syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline=
]
>      __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>      syscall_exit_to_user_mode+0x24a/0x340 kernel/entry/common.c:218
>      do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>     The buggy address belongs to the object at ffff8880259d1e00
>      which belongs to the cache task_struct of size 7424
>     The buggy address is located 2584 bytes inside of
>      freed 7424-byte region [ffff8880259d1e00, ffff8880259d3b00)
>
>     The buggy address belongs to the physical page:
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0=
x259d0
>     head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
>     memcg:ffff88802f4b56c1
>     flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
>     page_type: f5(slab)
>     raw: 00fff00000000040 ffff88801bafe500 dead000000000100 dead00000000=
0122
>     raw: 0000000000000000 0000000000040004 00000001f5000000 ffff88802f4b=
56c1
>     head: 00fff00000000040 ffff88801bafe500 dead000000000100 dead0000000=
00122
>     head: 0000000000000000 0000000000040004 00000001f5000000 ffff88802f4=
b56c1
>     head: 00fff00000000003 ffffea0000967401 ffffffffffffffff 00000000000=
00000
>     head: 0000000000000008 0000000000000000 00000000ffffffff 00000000000=
00000
>     page dumped because: kasan: bad access detected
>     page_owner tracks the page as allocated
>     page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd=
20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMAL=
LOC), pid 12, tgid 12 (kworker/u8:1), ts 7328037942, free_ts 0
>      set_page_owner include/linux/page_owner.h:32 [inline]
>      post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>      prep_new_page mm/page_alloc.c:1564 [inline]
>      get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
>      __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>      alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>      alloc_slab_page+0x6a/0x140 mm/slub.c:2408
>      allocate_slab+0x5a/0x2f0 mm/slub.c:2574
>      new_slab mm/slub.c:2627 [inline]
>      ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
>      __slab_alloc+0x58/0xa0 mm/slub.c:3905
>      __slab_alloc_node mm/slub.c:3980 [inline]
>      slab_alloc_node mm/slub.c:4141 [inline]
>      kmem_cache_alloc_node_noprof+0x269/0x380 mm/slub.c:4205
>      alloc_task_struct_node kernel/fork.c:180 [inline]
>      dup_task_struct+0x57/0x8c0 kernel/fork.c:1113
>      copy_process+0x5d1/0x3d50 kernel/fork.c:2225
>      kernel_clone+0x223/0x870 kernel/fork.c:2807
>      user_mode_thread+0x132/0x1a0 kernel/fork.c:2885
>      call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
>      process_one_work kernel/workqueue.c:3229 [inline]
>      process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
>      worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>     page_owner free stack trace missing
>
>     Memory state around the buggy address:
>      ffff8880259d2700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff8880259d2780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     >ffff8880259d2800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                 ^
>      ffff8880259d2880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff8880259d2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fix this by flushing the delalloc workers queue before stopping the
> cleaner kthread.
>
> Reported-by: syzbot+b7cf50a0c173770dcb14@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/674ed7e8.050a0220.48a03.0031.G=
AE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 814320948645..eff0dd1ae62f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4262,6 +4262,15 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>   	 * already the cleaner, but below we run all pending delayed iputs.
>   	 */
>   	btrfs_flush_workqueue(fs_info->fixup_workers);
> +	/*
> +	 * Similar case here, we have to wait for delalloc workers before we
> +	 * proceed below and stop the cleaner kthread, otherwise we trigger a
> +	 * use-after-tree on the cleaner kthread task_struct when a delalloc
> +	 * worker running submit_compressed_extents() adds a delayed iput, whi=
ch
> +	 * does a wake up on the cleaner kthread, which was already freed belo=
w
> +	 * when we call kthread_stop().
> +	 */
> +	btrfs_flush_workqueue(fs_info->delalloc_workers);
>
>   	/*
>   	 * After we parked the cleaner kthread, ordered extents may have


