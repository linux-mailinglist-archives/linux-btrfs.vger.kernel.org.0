Return-Path: <linux-btrfs+bounces-15824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABCEB196EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 02:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC3C3B59AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9BA4C8F;
	Mon,  4 Aug 2025 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="byPb81hj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73320EB
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754266449; cv=none; b=ViutSdc4sBe2Y66NoLfyqsD7kCa6o63259BNnLkIQzKbIWM8Ou4kuZc4dulsUoSRRUEhYk7xLt7JEpukdu4V5TitZYxuDbanVWq1t6a9fHJhn+BqZ/hlHxJHBUkjsoHx83m0dFikpvy2AtxNvnWDTlnV4DdN5dqqZxyZh0uXdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754266449; c=relaxed/simple;
	bh=8hFIG7wRE7y739Vin2YdCr9NgsZh66zRVfopZDAFLvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YDY3j42R7wHxqqyPOqQyI6mgC3wiONhel5m8c2PumdYtgB5A3t6/VNOxkBZ/XmVHwkjloDuDiOcvW2/HzUIUh8F8F2POjs5c4vLm84pC3HbIJjeZGO0Sk+ul4Z6456ylNjSjCy9rkaAB9sbEylzn67mecQPC8QLv5MNj5dGCYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=byPb81hj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754266440; x=1754871240; i=quwenruo.btrfs@gmx.com;
	bh=vXu4RU2xbQglF0jhSqEp7C3Sb3HZnuSLi6FPqHClYCI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=byPb81hjIhr2fpzSCTEKPJwla4vMZpy4+zcUnC1xJtqxWJwItNAMvoVyUEuLAXDT
	 qOMX967mP9pmEppM8DY0nGmTemxdMZhUJI0V5xiPJsmW/Pi8A1W7coxZg0Qr5HKtr
	 SQhAZTDKOqqyuzXnDGqGgfW8ldHzfZ8gdUGU1rlOgyooz1q6m93n1rvdXQF1GVMzN
	 BvMXbrx/D9B9lJl2daIJd3nhmay0zO4D7eF6mZZg0c01iCpNqMkRc4JqfqKSIWssi
	 /unsFsGGWJyDZOikljCF6dr4JRQInovqdQ9WT0nmBO7JFTU2AE2tGEDc6Zsf0KIYO
	 zVcgIsuX57IE0ZYeyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1uXTSR29zE-015Pcz; Mon, 04
 Aug 2025 02:13:59 +0200
Message-ID: <1975b00d-6096-4d4e-87ce-23ee636348d2@gmx.com>
Date: Mon, 4 Aug 2025 09:43:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: similar deadlock of xfstests generic/475 and generic/648 on
 6.12.41
To: Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20250804075756.608E.409509F4@e16-tech.com>
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
In-Reply-To: <20250804075756.608E.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q72lhgbPNNclCRhlQ89tbSuNpy8uG/itKhJ25uPQggyOUIbOsVw
 Xamd2bfbrmu4EocsQRTRu8WbHSUtWkK0JBGD8ex5Xs8AUFGdiGTL4E7JMi1KLRQ6Tj/T+TF
 Gk8RfWXa8qkHAHbR9CRojfQRh6/oVwifKHDaJfwYmJqeXlJn5YYFY7+DjU8vgDpk4GHZ8p9
 EFsRtAEE0U2JzKPr3qZXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EWNHYSI6uY8=;QB2Wn8fRitoR1Wugp2KUUc4FbEF
 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
 a1oXUYHdDnPekR6kom8ZQWQ=



=E5=9C=A8 2025/8/4 09:27, Wang Yugui =E5=86=99=E9=81=93:
> Hi,
>=20
> similar deadlock of xfstests generic/475 and generic/648 on 6.12.41 with=
 some
> 6.17 backport.
>=20
> generic/475
> [47333.016017] sysrq: Show Blocked State
> [47333.022309] task:kworker/u81:5   state:D stack:0     pid:1766531 tgid=
:1766531 ppid:2      flags:0x00004000
> [47333.034537] Workqueue: writeback wb_workfn (flush-btrfs-3405)
> [47333.042841] Call Trace:
> [47333.047804]  <TASK>
> [47333.052328]  __schedule+0x278/0x540
> [47333.058191]  ? __blk_flush_plug+0xf5/0x150
> [47333.064627]  schedule+0x27/0xa0
> [47333.070102]  io_schedule+0x46/0x70
> [47333.075814]  folio_wait_bit_common+0x13d/0x390
> [47333.082550]  ? folio_wait_bit_common+0x10b/0x390
> [47333.089414]  ? __pfx_wake_page_function+0x10/0x10
> [47333.096317]  __filemap_get_folio+0x289/0x3b0
> [47333.102754]  cleanup_dirty_folios.isra.0+0xda/0x200 [btrfs]
> [47333.110601]  run_delalloc_nocow+0x4d7/0x6f0 [btrfs]

There is a series related to this error handling path:

https://lore.kernel.org/linux-btrfs/cover.1753687685.git.wqu@suse.com/

Which will keep the folio locked until error handling or the full range=20
successfully finished.

If you can reliably hit the same error path, extra testing with that=20
series would be appreciated.

Thanks,
Qu

> [47333.117665]  ? __clear_extent_bit+0xc0/0x4f0 [btrfs]
> [47333.124832]  btrfs_run_delalloc_range+0x8e/0x2a0 [btrfs]
> [47333.132369]  writepage_delalloc+0x1fa/0x3e0 [btrfs]
> [47333.139469]  extent_writepage+0xdb/0x260 [btrfs]
> [47333.146322]  extent_write_cache_pages+0x18f/0x410 [btrfs]
> [47333.153919]  btrfs_writepages+0x74/0x100 [btrfs]
> [47333.160717]  do_writepages+0xd6/0x240
> [47333.166440]  ? select_task_rq_fair+0x165/0x340
> [47333.172949]  ? __smp_call_single_queue+0xb0/0x120
> [47333.179738]  ? ttwu_queue_wakelist+0xf4/0x110
> [47333.186177]  __writeback_single_inode+0x41/0x260
> [47333.192893]  writeback_sb_inodes+0x21c/0x4e0
> [47333.199286]  wb_writeback+0x88/0x310
> [47333.204899]  wb_do_writeback+0x87/0x2b0
> [47333.210729]  ? set_worker_desc+0xaf/0xc0
> [47333.216634]  wb_workfn+0x49/0x150
> [47333.221958]  process_one_work+0x179/0x3a0
> [47333.227986]  worker_thread+0x24b/0x350
> [47333.233745]  ? __pfx_worker_thread+0x10/0x10
> [47333.240036]  kthread+0xde/0x110
> [47333.245151]  ? __pfx_kthread+0x10/0x10
> [47333.250834]  ret_from_fork+0x31/0x50
> [47333.256354]  ? __pfx_kthread+0x10/0x10
> [47333.262048]  ret_from_fork_asm+0x1a/0x30
> [47333.267937]  </TASK>
> [47333.272060] task:btrfs-transacti state:D stack:0     pid:3056793 tgid=
:3056793 ppid:2      flags:0x00004000
> [47333.283763] Call Trace:
> [47333.288187]  <TASK>
> [47333.292173]  __schedule+0x278/0x540
> [47333.297555]  schedule+0x27/0xa0
> [47333.302603]  io_schedule+0x46/0x70
> [47333.307924]  folio_wait_bit_common+0x13d/0x390
> [47333.314249]  ? folio_wait_bit_common+0x10b/0x390
> [47333.320778]  ? xas_init_marks+0x23/0x50
> [47333.326513]  ? __pfx_wake_page_function+0x10/0x10
> [47333.333127]  invalidate_inode_pages2_range+0x275/0x4c0
> [47333.340165]  btrfs_destroy_all_delalloc_inodes+0x187/0x220 [btrfs]
> [47333.348345]  btrfs_cleanup_transaction.isra.0+0x389/0x3f0 [btrfs]
> [47333.356454]  transaction_kthread+0x107/0x1d0 [btrfs]
> [47333.363413]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [47333.370906]  kthread+0xde/0x110
> [47333.375955]  ? __pfx_kthread+0x10/0x10
> [47333.381626]  ret_from_fork+0x31/0x50
> [47333.387100]  ? __pfx_kthread+0x10/0x10
> [47333.392732]  ret_from_fork_asm+0x1a/0x30
> [47333.398553]  </TASK>
> [47333.402611] task:fsstress        state:D stack:0     pid:3056799 tgid=
:3056799 ppid:3056794 flags:0x00000006
> [47333.414306] Call Trace:
> [47333.418668]  <TASK>
> [47333.422658]  __schedule+0x278/0x540
> [47333.428017]  schedule+0x27/0xa0
> [47333.432966]  wb_wait_for_completion+0x6b/0xa0
> [47333.439127]  ? __pfx_autoremove_wake_function+0x10/0x10
> [47333.446183]  __writeback_inodes_sb_nr+0xa2/0xd0
> [47333.452569]  sync_filesystem+0x31/0xa0
> [47333.458162]  __x64_sys_syncfs+0x41/0xa0
> [47333.463851]  do_syscall_64+0x7d/0x160
> [47333.469360]  ? __do_sys_newfstatat+0x35/0x60
> [47333.475492]  ? file_close_fd+0x45/0x60
> [47333.481090]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [47333.487821]  ? do_syscall_64+0x89/0x160
> [47333.493500]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [47333.500241]  ? do_syscall_64+0x89/0x160
> [47333.505917]  ? __do_sys_newfstatat+0x35/0x60
> [47333.512025]  ? __x64_sys_ioctl+0xa6/0xc0
> [47333.517770]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [47333.524495]  ? do_syscall_64+0x89/0x160
> [47333.530154]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [47333.536868]  ? do_syscall_64+0x89/0x160
> [47333.542526]  ? exc_page_fault+0x70/0x160
> [47333.548272]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [47333.555147] RIP: 0033:0x7f8510704b8b
> [47333.560547] RSP: 002b:00007fff6f808b78 EFLAGS: 00000202 ORIG_RAX: 000=
0000000000132
> [47333.570012] RAX: ffffffffffffffda RBX: 000000000007a120 RCX: 00007f85=
10704b8b
> [47333.579026] RDX: 0000000000000000 RSI: 0000000031eb1450 RDI: 00000000=
00000004
> [47333.588051] RBP: 0000000000000004 R08: 0000000000000060 R09: 00007fff=
6f808b3c
> [47333.597077] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
0000073a
> [47333.606092] R13: 8f5c28f5c28f5c29 R14: 00000000004045c0 R15: 00007f85=
10932b08
> [47333.615123]  </TASK>
>=20
>=20
> generic/648:
>=20
> [38896.856540] sysrq: Show Blocked State
> [38896.863859] task:kworker/u81:9   state:D stack:0     pid:1771117 tgid=
:1771117 ppid:2      flags:0x00004000
> [38896.877114] Workqueue: writeback wb_workfn (flush-btrfs-4069)
> [38896.886454] Call Trace:
> [38896.892401]  <TASK>
> [38896.897932]  __schedule+0x278/0x540
> [38896.904848]  ? __blk_flush_plug+0xf5/0x150
> [38896.912373]  schedule+0x27/0xa0
> [38896.918904]  io_schedule+0x46/0x70
> [38896.925672]  folio_wait_bit_common+0x13d/0x390
> [38896.933465]  ? folio_wait_bit_common+0x10b/0x390
> [38896.941383]  ? __pfx_wake_page_function+0x10/0x10
> [38896.949338]  __filemap_get_folio+0x289/0x3b0
> [38896.956830]  cleanup_dirty_folios.isra.0+0xda/0x200 [btrfs]
> [38896.965742]  run_delalloc_nocow+0x4d7/0x6f0 [btrfs]
> [38896.973862]  ? __clear_extent_bit+0x170/0x4f0 [btrfs]
> [38896.982121]  btrfs_run_delalloc_range+0x8e/0x2a0 [btrfs]
> [38896.990622]  writepage_delalloc+0x1fa/0x3e0 [btrfs]
> [38896.998655]  extent_writepage+0xdb/0x260 [btrfs]
> [38897.006387]  extent_write_cache_pages+0x18f/0x410 [btrfs]
> [38897.014874]  btrfs_writepages+0x74/0x100 [btrfs]
> [38897.022545]  do_writepages+0xd6/0x240
> [38897.029129]  ? requeue_delayed_entity+0x8c/0x100
> [38897.036643]  __writeback_single_inode+0x41/0x260
> [38897.044115]  writeback_sb_inodes+0x21c/0x4e0
> [38897.051205]  wb_writeback+0x88/0x310
> [38897.057606]  wb_do_writeback+0x87/0x2b0
> [38897.064277]  ? set_worker_desc+0xaf/0xc0
> [38897.071053]  wb_workfn+0x49/0x150
> [38897.077226]  process_one_work+0x179/0x3a0
> [38897.084068]  worker_thread+0x24b/0x350
> [38897.090610]  ? __pfx_worker_thread+0x10/0x10
> [38897.097665]  kthread+0xde/0x110
> [38897.103542]  ? __pfx_kthread+0x10/0x10
> [38897.110007]  ret_from_fork+0x31/0x50
> [38897.116241]  ? __pfx_kthread+0x10/0x10
> [38897.122598]  ret_from_fork_asm+0x1a/0x30
> [38897.129098]  </TASK>
> [38897.133829] task:btrfs-transacti state:D stack:0     pid:3363777 tgid=
:3363777 ppid:2      flags:0x00004000
> [38897.146101] Call Trace:
> [38897.151052]  <TASK>
> [38897.155575]  __schedule+0x278/0x540
> [38897.161482]  schedule+0x27/0xa0
> [38897.167022]  io_schedule+0x46/0x70
> [38897.172810]  folio_wait_bit_common+0x13d/0x390
> [38897.179604]  ? folio_wait_bit_common+0x10b/0x390
> [38897.186521]  ? xas_init_marks+0x23/0x50
> [38897.192628]  ? __pfx_wake_page_function+0x10/0x10
> [38897.199614]  invalidate_inode_pages2_range+0x275/0x4c0
> [38897.207025]  btrfs_destroy_all_delalloc_inodes+0x187/0x220 [btrfs]
> [38897.215553]  btrfs_cleanup_transaction.isra.0+0x389/0x3f0 [btrfs]
> [38897.223978]  transaction_kthread+0x107/0x1d0 [btrfs]
> [38897.231246]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [38897.239020]  kthread+0xde/0x110
> [38897.244329]  ? __pfx_kthread+0x10/0x10
> [38897.250208]  ret_from_fork+0x31/0x50
> [38897.255854]  ? __pfx_kthread+0x10/0x10
> [38897.261619]  ret_from_fork_asm+0x1a/0x30
> [38897.267534]  </TASK>
> [38897.271661] task:fsstress        state:D stack:0     pid:3363784 tgid=
:3363784 ppid:3363778 flags:0x00004006
> [38897.283430] Call Trace:
> [38897.287824]  <TASK>
> [38897.291824]  __schedule+0x278/0x540
> [38897.297190]  schedule+0x27/0xa0
> [38897.302188]  wb_wait_for_completion+0x6b/0xa0
> [38897.308387]  ? __pfx_autoremove_wake_function+0x10/0x10
> [38897.315428]  sync_inodes_sb+0xc4/0x100
> [38897.320978]  sync_filesystem+0x64/0xa0
> [38897.326529]  __x64_sys_syncfs+0x41/0xa0
> [38897.332173]  do_syscall_64+0x7d/0x160
> [38897.337642]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [38897.344341]  ? do_syscall_64+0x89/0x160
> [38897.349994]  ? exc_page_fault+0x70/0x160
> [38897.355733]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [38897.362623] RIP: 0033:0x7f38d7504b8b
> [38897.368019] RSP: 002b:00007fff09ab5f68 EFLAGS: 00000202 ORIG_RAX: 000=
0000000000132
> [38897.377470] RAX: ffffffffffffffda RBX: 000000000007a120 RCX: 00007f38=
d7504b8b
> [38897.386494] RDX: 0000000000000000 RSI: 0000000005d26450 RDI: 00000000=
00000004
> [38897.395514] RBP: 0000000000000004 R08: 0000000000000009 R09: 00000000=
05d32370
> [38897.404525] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000=
00000783
> [38897.413517] R13: 8f5c28f5c28f5c29 R14: 00000000004045c0 R15: 00007f38=
d7653b08
> [38897.422516]  </TASK>
>=20
> And this is a server with ECC memory and no ECC warning/errror reported.
>=20
> Is there any patch related to this problem?
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/08/04
>=20
>=20
>=20


