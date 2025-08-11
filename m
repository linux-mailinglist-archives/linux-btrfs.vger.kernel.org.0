Return-Path: <linux-btrfs+bounces-16001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC8B21806
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 00:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ECE46319D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7476219E8C;
	Mon, 11 Aug 2025 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aSlPwcRN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13F17E4;
	Mon, 11 Aug 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950529; cv=none; b=rADT3jGuWN1wNdvIgwGb/ej09AQOss2hBUKo8HxNvjrlhlXQfza54MNOP9u/i2APIXvtSdPD/Qt6PLC5TfTPvsnmkxlIcO1g9poKBm1kKNUIy1VHK9yDxHfE3SZo5v36QY25r6v3SBdhM0pxXqNSwzDvHgP0N557zqdLEhpjcm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950529; c=relaxed/simple;
	bh=EMH4tUFc5ZewptmaecBi3nUTIpVQ0pvApfAM5jE0lP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAuuCzCVO4mI05yPY4sUZ4Yvzra35XtBrUXH6xQV60Xp4CKlJDvy8raTk3hRwW3V5ihHyeY/W9FOVSVT3t4K85SRRwKuUDxwRAsMLNv5l/a+SyAW6z/qFJBthiDdcDH7gl7KgrUFPtYULem4GbA1p0szOvhOedELDKmN0lc23O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aSlPwcRN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754950525; x=1755555325; i=quwenruo.btrfs@gmx.com;
	bh=/dBhs+alLt/rNTstM7ifaMDWDx/ZfCf0ujjODfmFkoM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aSlPwcRNN3963HOozqyARPcF4CNBUUe4VuZpB5NYN82ocsyj9hyRXccPnG21bbOH
	 tbAAyfBjzW1OSFkJV/zlFoA62/9oUKkmFdA1VaDehI7dRKi/vocj0g3XxGceQEBFV
	 hYUM4MWahzmlftctvBbWWvnjUkN9JoxrUFxvHv+dU1dEvMrMvVORTf3rUBU9dTcG9
	 mxC66CMIle8kUBlmwl7b8kXUdNNsY/tOBcv44dCQEcBCi4MvjrvQoQqpu9nlZqEIF
	 Gy7jZkZm7KmeZN66MtRcjXI4Hu3a/pROy+InJKoNhuPqwu4beVXPyekbgSHJgaNZ5
	 S7mxtdsmbXv6rV3VAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1uz0ub26Hh-00Z9x3; Tue, 12
 Aug 2025 00:15:25 +0200
Message-ID: <8c6d3196-66db-42cf-aa70-b69e8a210cc1@gmx.com>
Date: Tue, 12 Aug 2025 07:45:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] INFO: task hung in __alloc_workqueue (2)
To: Tejun Heo <tj@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: syzbot <syzbot+ead9101689c4ca30dbe8@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, clm@fb.com, dsterba@suse.com, frederic@kernel.org,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de, jiangshanlai@gmail.com
References: <6899154b.050a0220.51d73.0094.GAE@google.com>
 <e3424457-8786-45dd-a0d9-ecc8bfae0829@suse.com>
 <aJozN9LVgaPFX9dX@slm.duckdns.org>
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
In-Reply-To: <aJozN9LVgaPFX9dX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wIM2hI2YJnmJ1k4Jhx0s/5E83VBjluoiSN3Hh/7Iw+wZsXU1qGj
 IizCuf4eFfKKXYqyZK5YrHOhH0tRtrMxjpLd610bcdDUpLm8QNnak82cnxVERojlBz20g+h
 kPVxaVrCvFwOLzmQEXvq/f5sDFWZ0LiR39xPo/GT1woeVBigu/iDxrxMPmws9OCYUUhxDY3
 RmAkZ7ZHsW5b8VyAeUKwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pbgauaYChyk=;IS4ZLP0og4h5ScUD1UD4MJuj7XT
 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



=E5=9C=A8 2025/8/12 03:45, Tejun Heo =E5=86=99=E9=81=93:
> Hello,
>=20
> On Mon, Aug 11, 2025 at 08:02:40AM +0930, Qu Wenruo wrote:
> ...
>>> Call Trace:
>>>    <TASK>
>>>    context_switch kernel/sched/core.c:5357 [inline]
>>>    __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
>>>    __schedule_loop kernel/sched/core.c:7043 [inline]
>>>    schedule+0x165/0x360 kernel/sched/core.c:7058
>>>    schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
>>>    do_wait_for_common kernel/sched/completion.c:100 [inline]
>>>    __wait_for_common kernel/sched/completion.c:121 [inline]
>>>    wait_for_common kernel/sched/completion.c:132 [inline]
>>>    wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
>>>    kthread_flush_worker+0x1c6/0x240 kernel/kthread.c:1563
>>
>> This is flushing pwq_release_worker during error handling, and I didn't=
 see
>> anything btrfs specific except btrfs is allocating an ordered workqueue
>> which utilizes WQ_UNBOUND flag.
>>
>> And that WQ_UNBOUND flag is pretty widely used among other filesystems,
>> maybe it's just btrfs have too many workqueues triggering this?
>>
>> Adding workqueue maintainers.
>=20
> That flush stall likely is a secondary effect of another failure. The
> kthread worker is already spun up and running and the work function
> pwq_release_workfn() grabs several locks. Maybe someone else is stalling=
 on
> those unless the kthread is somehow not allowed to run? Continued below.
>=20
>>> Showing all locks held in the system:
>>> 1 lock held by khungtaskd/38:
>>>    #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acqu=
ire include/linux/rcupdate.h:331 [inline]
>>>    #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock=
 include/linux/rcupdate.h:841 [inline]
>>>    #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: debug_show_al=
l_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
>>> 1 lock held by udevd/5207:
>>>    #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: write_lock_irq in=
clude/linux/rwlock_rt.h:104 [inline]
>>>    #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: ep_poll fs/eventp=
oll.c:2127 [inline]
>>>    #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: do_epoll_wait+0x8=
4d/0xbb0 fs/eventpoll.c:2560
>>> 2 locks held by getty/5598:
>>>    #0: ffff88823bfae8a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_r=
ef_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>>>    #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_=
tty_read+0x444/0x1410 drivers/tty/n_tty.c:2222
>>> 3 locks held by kworker/u8:3/5911:
>>> 3 locks held by kworker/u8:7/5942:
>>> 6 locks held by udevd/6060:
>>> 1 lock held by udevd/6069:
>>> 1 lock held by udevd/6190:
>>> 6 locks held by udevd/6237:
> ~~~trimmed~~~
>=20
> That's a lot of locks to be held, so something's not going right for sur=
e.
>=20
>>> Sending NMI from CPU 1 to CPUs 0:
>>> NMI backtrace for cpu 0
>>> CPU: 0 UID: 0 PID: 5911 Comm: kworker/u8:3 Tainted: G        W        =
   6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT_{RT,(full)}
>>> Tainted: [W]=3DWARN
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 07/12/2025
>>> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
>>> RIP: 0010:get_timer_this_cpu_base kernel/time/timer.c:939 [inline]
>>> RIP: 0010:__mod_timer+0x81c/0xf60 kernel/time/timer.c:1101
>>> Code: 01 00 00 00 48 8b 5c 24 20 41 0f b6 44 2d 00 84 c0 0f 85 72 06 0=
0 00 8b 2b e8 f0 bb 49 09 41 89 c5 89 c3 bf 08 00 00 00 89 c6 <e8> 0f c1 1=
2 00 41 83 fd 07 44 89 34 24 0f 87 69 06 00 00 e8 4c bc
>>> RSP: 0018:ffffc90004fff680 EFLAGS: 00000082
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: f9fab87ca5ec6a00
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
>>> RBP: 0000000000200000 R08: 0000000000000000 R09: 0000000000000000
>>> R10: dffffc0000000000 R11: fffff520009ffeac R12: ffff8880b8825a80
>>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000802
>>> FS:  0000000000000000(0000) GS:ffff8881268cd000(0000) knlGS:0000000000=
000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f46b6524000 CR3: 000000003afb2000 CR4: 00000000003526f0
>>> Call Trace:
>>>    <TASK>
>>>    queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2559
>>>    queue_delayed_work include/linux/workqueue.h:684 [inline]
>>>    batadv_forw_packet_queue+0x239/0x2a0 net/batman-adv/send.c:691
>>>    batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:842 [inline=
]
>>>    batadv_iv_ogm_schedule+0x892/0xf00 net/batman-adv/bat_iv_ogm.c:874
>>>    batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-ad=
v/bat_iv_ogm.c:1714
>>>    process_one_work kernel/workqueue.c:3236 [inline]
>>>    process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
>>>    worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>>>    kthread+0x711/0x8a0 kernel/kthread.c:463
>>>    ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>>>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>    </TASK>
>=20
> So, task hung watchdog triggered and making all cpus dump their backtrac=
es
> and it's only one CPU. Is this a two CPU setup in a live lockup? I don't=
 see
> anything apparent and these are time based conditions that can be trigge=
red
> by severely overloading the system too. If you can reproduce the conditi=
ons,

That's the problem, it looks like I'm either cursed or really unlucky, I=
=20
have a very low chance of reproducibility of syzbot bugs.

And it's the same failed-to-reproduce here.

Thanks,
Qu

> seeing how the system is doing in general and whether the system can unw=
ind
> itself after killing the workload may be useful.
>=20
> Thanks.
>=20


