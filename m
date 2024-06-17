Return-Path: <linux-btrfs+bounces-5752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D6890A2D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 05:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83599280DF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB017E903;
	Mon, 17 Jun 2024 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ca70nGrG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970162AD39
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594821; cv=none; b=XmHRBzQICRRtxnMoA/y/U4vB2y3uXcHm58VesJejZYQmjv8GkLK7rRnfFuKx8AyVqCnwD7Muhc5H/s1N2hvjxtBkdZkW/eyVOjXGJDy1SjmFXoq0gM9zsyPo4BtHpFEZETAa/tNFpzF8gNeH91mOUV9btCjLTnKo+OVrWc6syz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594821; c=relaxed/simple;
	bh=FJxqRL67Q6bDnccPvlDHNcnni1v6yE0gcq8L9c3avwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P5RnCpXjpBx+MCU/4W7cYwH44QuYlxmpgNMhFjVabjwMs+u7jJQr/QL0aDDqVm6L03NXfhw1rvI1mYvfimflAKXhLEHCc4EyekF7BhYcND9Ill7idmuD8z65fHM9kGDzwGu5gVnOA8LRoUcMnbNldSMqghhoNhP0ntH4HzN7R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ca70nGrG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718594811; x=1719199611; i=quwenruo.btrfs@gmx.com;
	bh=FJxqRL67Q6bDnccPvlDHNcnni1v6yE0gcq8L9c3avwQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ca70nGrGULaqLB5Opa4Kikq8GJuDAQavNV8+pWeSfhuV5GP/RFfn33eEiywqEx9c
	 5QZa/IHFYNIu8XtIYeHnU1gGJ7+qHNtu2W7N4iUuc9UDP0v4neOOLM+QMbrUI4LKW
	 6fgIUEh1iykmJYTYR8yyKlrsHzZ6xz6jb349OTZ1B7G6pL3g9G7UEB8VCtwwLNnYO
	 pG82SL0rVumrZ2iE+blzEqm0zW/lMauM5hZBkfHhLAxkdzzoCu7+AATlnQAj+Hdu3
	 4L2YFJ0ulETxq5Z6m1y3+diIXvKIH4aQlkf6M51kYOH/5JoFyUUH77rNQI5X2RMrV
	 KXzdMDi2FLNFDJaRag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLiCu-1s1W8I05g0-00Ys6V; Mon, 17
 Jun 2024 05:26:51 +0200
Message-ID: <3b0c7d87-eb84-46fd-843c-70d370c930e9@gmx.com>
Date: Mon, 17 Jun 2024 12:56:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck btrfs-transaction (deadlock?)
To: Igor Raits <igor@gooddata.com>, linux-btrfs@vger.kernel.org
References: <CA+9S74ihGsyK=t7507x-UrQmNOnE6sh3uM6E6dWEPEj=+H3vHw@mail.gmail.com>
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
In-Reply-To: <CA+9S74ihGsyK=t7507x-UrQmNOnE6sh3uM6E6dWEPEj=+H3vHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WZ29RpGSFdIcVQLczQA2cu6lpXGA0TY0mr8ZkqdnhTIHAuGqc8T
 K5ebHdRr0BU9gqT1L93DFUrFkaTYNzPSEq042EWI80Wb7FgKsYHsxoCDph3+UEIJ9OtFN5y
 WaKwMamOQEwRp1v9CTijfCjTmMwmvy2JFcAwyUejIzq9FgLo7769NYXzR+e0R2D4RtY4axw
 UnVl5uMMoEfsTGQno1d8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ESzpSmdgZIw=;lGRBZbvz66seQnP2newejy+L5Ib
 1thOC166mmpktGwxg8y+U6xCnJLzNoEGSUjJRsz9ocQrwiLLqxNgkl1j/5WWu2+HwPOrJjiZp
 SbR9wAXE5bwitZ/9ig6kT8nlb0ajQPXSZmSA+iMBpdDmUpOFU0YyNzAuG/Y3+GNnUccMVlq+F
 vESFeNH/+u6KHNJ4+yFvZOM3JHaDED6T8XeyasE18XTY2pYptD3H4l/+QKPaqKNJqgSGPRaun
 9SEbw7L9Wu/Qtpl4XzX3INw9r3fNfN4BgJQq3+tCjCF/56wqDFhU+gZ8Q39LrK8lrvvEhE8T1
 wjnVI1e7n45Vv/mowAyLXODQFkbvfuUZdv6mH+Z04JRPoM6F52cXthXSyUXJH+3DziVu+i40F
 uDUbgBT+x5chA/pSZc8nUpr7eO8ewf4Frp3pZOACAYUAX0SOoI1IUUz1EGZai7hK0v7ZSYf1+
 /tWcqYVpdHNtb1LfFmOv4BpxrDOW/SM/BZeIxORx4XovSsscMp5BBorlZXos/TlRbhv6edwXO
 +Tc9g/g0uFBJD9/y3xXtSp/Ly6c3qs0auPXv3E9tuWtU61gYLhSVPTtYO2WPUXRfdSEprGmd+
 9tx7JfzqplCI/rwN+klBjczvRlQCwealF/fBYt7BgQH+1quFEzL8POtzIXrDWbw05y5vxSsDj
 DtaTsIcpBgPXZmD+V+hGb02G/wgQGXQwkvkViiXVN6rzesktNadmZbUcDjs47ukpSw/pPNuJw
 wMDLL7FWC7wpHKJPPYlME/63/0h/vLz5FEx9e883mPf856UACq5fxgFI4vKqadIblo0T+TtuI
 bVoehlFZvqE3cLVFJ5L745lcQ5m65dpP9kF3+R1JWk69w=



=E5=9C=A8 2024/6/14 01:17, Igor Raits =E5=86=99=E9=81=93:
> Hello,
>
> We have been observing that few of our nodes get stuck recently when
> btrfs is trying to write compressed files. I believe this was
> happening on one of the latest 6.8.y and now it happens on 6.9.y.

Maybe a bug related to page::private and is fixed by upstream commit
f3a5367c679d ("btrfs: protect folio::private when attaching extent
buffer folios").

Which should only affects 6.8 and 6.9 kernels.

> Sadly (as in many cases), I do not have any reproducer for the issue
> but as it happens from time to time, we may be able to collect some
> more data if you do not have an idea from stacktrace below. We even
> tried to wipe the disk completely and write data fresh onto it.
>
> Few minutes before being stuck, there is something being read from a
> disk with 500+M/s speed, then small writes and then everything just
> stops.
> Mount options: compress-force=3Dzstd:2,ssd,discard=3Dasync,space_cache=
=3Dv2
>
> The node(s) are 48 vCPUs if this matters=E2=80=A6 It is a VM on a KVM
> hypervisor if it matters.
>
> Any help is much appreciated!

The calltrace is different from the most common ones, but it may still
be worthy to try either the latest rc with the fix, or 6.7.x to make
sure if it's really the problem.

Thanks,
Qu

>
> [1142527.677011] INFO: task btrfs-transacti:49545 blocked for more
> than 122 seconds.
> [1142527.678282] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.679218] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.680216] task:btrfs-transacti state:D stack:0 pid:49545
> tgid:49545 ppid:2 flags:0x00004000
> [1142527.681311] Call Trace:
> [1142527.681945] <TASK>
> [1142527.682545] __schedule+0x222/0x670
> [1142527.683238] schedule+0x2c/0xb0
> [1142527.683908] schedule_preempt_disabled+0x11/0x20
> [1142527.684673] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.685420] ? release_extent_buffer+0x99/0xb0 [btrfs]
> [1142527.686232] down_read+0x45/0xa0
> [1142527.686863] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.687637] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
> [1142527.688414] btrfs_search_slot+0x127/0xbd0 [btrfs]
> [1142527.689157] ? kmem_cache_alloc+0x24d/0x330
> [1142527.689819] ? kmem_cache_alloc+0x12f/0x330
> [1142527.690488] ? btrfs_del_csums+0x53/0x3d0 [btrfs]
> [1142527.691197] btrfs_del_csums+0x10b/0x3d0 [btrfs]
> [1142527.691896] cleanup_ref_head+0x27d/0x2a0 [btrfs]
> [1142527.692592] __btrfs_run_delayed_refs+0xb9/0x1a0 [btrfs]
> [1142527.693340] btrfs_run_delayed_refs+0x7b/0x130 [btrfs]
> [1142527.694064] btrfs_commit_transaction+0x68/0xb80 [btrfs]
> [1142527.694779] ? start_transaction+0xd3/0x830 [btrfs]
> [1142527.695462] transaction_kthread+0x155/0x1d0 [btrfs]
> [1142527.696152] ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> [1142527.696872] kthread+0xdc/0x110
> [1142527.697390] ? __pfx_kthread+0x10/0x10
> [1142527.697954] ret_from_fork+0x2d/0x50
> [1142527.698501] ? __pfx_kthread+0x10/0x10
> [1142527.699048] ret_from_fork_asm+0x1a/0x30
> [1142527.699602] </TASK>
> [1142527.700034] INFO: task kworker/u195:8:3259780 blocked for more
> than 122 seconds.
> [1142527.700829] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.701572] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.702360] task:kworker/u195:8 state:D stack:0 pid:3259780
> tgid:3259780 ppid:2 flags:0x00004000
> [1142527.703276] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.703989] Call Trace:
> [1142527.704397] <TASK>
> [1142527.704784] __schedule+0x222/0x670
> [1142527.705261] ? leaf_space_used+0xad/0xd0 [btrfs]
> [1142527.705827] schedule+0x2c/0xb0
> [1142527.706266] schedule_preempt_disabled+0x11/0x20
> [1142527.706792] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.707322] down_read+0x45/0xa0
> [1142527.707744] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.708315] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
> [1142527.708900] btrfs_search_slot+0x127/0xbd0 [btrfs]
> [1142527.709429] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
> [1142527.710054] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.710581] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.711139] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.711659] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.712221] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.712737] process_one_work+0x193/0x3d0
> [1142527.713184] worker_thread+0x2fc/0x410
> [1142527.713610] ? __pfx_worker_thread+0x10/0x10
> [1142527.714073] kthread+0xdc/0x110
> [1142527.714451] ? __pfx_kthread+0x10/0x10
> [1142527.714887] ret_from_fork+0x2d/0x50
> [1142527.715296] ? __pfx_kthread+0x10/0x10
> [1142527.715714] ret_from_fork_asm+0x1a/0x30
> [1142527.716149] </TASK>
> [1142527.716458] INFO: task kworker/u200:10:3338782 blocked for more
> than 122 seconds.
> [1142527.717138] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.717755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.718455] task:kworker/u200:10 state:D stack:0 pid:3338782
> tgid:3338782 ppid:2 flags:0x00004000
> [1142527.719297] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.719930] Call Trace:
> [1142527.720271] <TASK>
> [1142527.720593] __schedule+0x222/0x670
> [1142527.721010] schedule+0x2c/0xb0
> [1142527.721393] schedule_preempt_disabled+0x11/0x20
> [1142527.721890] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.722379] down_read+0x45/0xa0
> [1142527.722775] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.723322] btrfs_search_slot+0x40f/0xbd0 [btrfs]
> [1142527.723845] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.724368] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.724928] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.725447] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.726030] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.726553] process_one_work+0x193/0x3d0
> [1142527.727001] worker_thread+0x2fc/0x410
> [1142527.727421] ? __pfx_worker_thread+0x10/0x10
> [1142527.727890] kthread+0xdc/0x110
> [1142527.728263] ? __pfx_kthread+0x10/0x10
> [1142527.728676] ret_from_fork+0x2d/0x50
> [1142527.729087] ? __pfx_kthread+0x10/0x10
> [1142527.729503] ret_from_fork_asm+0x1a/0x30
> [1142527.729936] </TASK>
> [1142527.730242] INFO: task kworker/u200:6:3497930 blocked for more
> than 122 seconds.
> [1142527.730910] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.731541] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.732237] task:kworker/u200:6 state:D stack:0 pid:3497930
> tgid:3497930 ppid:2 flags:0x00004000
> [1142527.733065] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.733684] Call Trace:
> [1142527.734029] <TASK>
> [1142527.734422] __schedule+0x222/0x670
> [1142527.734833] schedule+0x2c/0xb0
> [1142527.735223] schedule_preempt_disabled+0x11/0x20
> [1142527.735900] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.736384] down_read+0x45/0xa0
> [1142527.736775] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.737318] btrfs_search_slot+0x40f/0xbd0 [btrfs]
> [1142527.737840] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.738357] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.738915] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.739429] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.740001] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.740521] process_one_work+0x193/0x3d0
> [1142527.740968] worker_thread+0x2fc/0x410
> [1142527.741389] ? __pfx_worker_thread+0x10/0x10
> [1142527.741847] kthread+0xdc/0x110
> [1142527.742235] ? __pfx_kthread+0x10/0x10
> [1142527.742660] ret_from_fork+0x2d/0x50
> [1142527.743071] ? __pfx_kthread+0x10/0x10
> [1142527.743485] ret_from_fork_asm+0x1a/0x30
> [1142527.743915] </TASK>
> [1142527.744218] INFO: task kworker/u193:13:3507784 blocked for more
> than 122 seconds.
> [1142527.744888] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.745508] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.746203] task:kworker/u193:13 state:D stack:0 pid:3507784
> tgid:3507784 ppid:2 flags:0x00004000
> [1142527.747032] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.747649] Call Trace:
> [1142527.747991] <TASK>
> [1142527.748301] __schedule+0x222/0x670
> [1142527.748712] schedule+0x2c/0xb0
> [1142527.749105] schedule_preempt_disabled+0x11/0x20
> [1142527.749587] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.750082] down_read+0x45/0xa0
> [1142527.750465] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.751016] btrfs_search_slot+0x40f/0xbd0 [btrfs]
> [1142527.751537] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.752055] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.752607] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.753136] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.753703] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.754229] process_one_work+0x193/0x3d0
> [1142527.754675] worker_thread+0x2fc/0x410
> [1142527.755107] ? __pfx_worker_thread+0x10/0x10
> [1142527.755565] kthread+0xdc/0x110
> [1142527.755952] ? __pfx_kthread+0x10/0x10
> [1142527.756367] ret_from_fork+0x2d/0x50
> [1142527.756777] ? __pfx_kthread+0x10/0x10
> [1142527.757199] ret_from_fork_asm+0x1a/0x30
> [1142527.757626] </TASK>
> [1142527.757940] INFO: task kworker/u199:9:3642616 blocked for more
> than 122 seconds.
> [1142527.758596] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.759215] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.759915] task:kworker/u199:9 state:D stack:0 pid:3642616
> tgid:3642616 ppid:2 flags:0x00004000
> [1142527.760738] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.761359] Call Trace:
> [1142527.761698] <TASK>
> [1142527.762016] __schedule+0x222/0x670
> [1142527.762417] ? leaf_space_used+0xad/0xd0 [btrfs]
> [1142527.762937] schedule+0x2c/0xb0
> [1142527.763320] schedule_preempt_disabled+0x11/0x20
> [1142527.763803] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.764300] down_read+0x45/0xa0
> [1142527.764694] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.765244] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
> [1142527.765804] btrfs_search_slot+0x127/0xbd0 [btrfs]
> [1142527.766330] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
> [1142527.766946] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.767498] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.768054] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.768577] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.769149] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.769670] process_one_work+0x193/0x3d0
> [1142527.770117] worker_thread+0x2fc/0x410
> [1142527.770540] ? __pfx_worker_thread+0x10/0x10
> [1142527.770998] kthread+0xdc/0x110
> [1142527.771368] ? __pfx_kthread+0x10/0x10
> [1142527.771783] ret_from_fork+0x2d/0x50
> [1142527.772190] ? __pfx_kthread+0x10/0x10
> [1142527.772607] ret_from_fork_asm+0x1a/0x30
> [1142527.773042] </TASK>
> [1142527.773346] INFO: task kworker/u195:9:3726533 blocked for more
> than 122 seconds.
> [1142527.774016] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.774630] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.775326] task:kworker/u195:9 state:D stack:0 pid:3726533
> tgid:3726533 ppid:2 flags:0x00004000
> [1142527.776152] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.776771] Call Trace:
> [1142527.777114] <TASK>
> [1142527.777421] __schedule+0x222/0x670
> [1142527.777828] ? leaf_space_used+0xad/0xd0 [btrfs]
> [1142527.778346] schedule+0x2c/0xb0
> [1142527.778732] schedule_preempt_disabled+0x11/0x20
> [1142527.779221] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.779709] down_read+0x45/0xa0
> [1142527.780103] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.780654] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
> [1142527.781217] btrfs_search_slot+0x127/0xbd0 [btrfs]
> [1142527.781746] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
> [1142527.782360] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.782889] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.783438] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.783967] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.784535] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.785056] process_one_work+0x193/0x3d0
> [1142527.785494] worker_thread+0x2fc/0x410
> [1142527.785913] ? __pfx_worker_thread+0x10/0x10
> [1142527.786491] kthread+0xdc/0x110
> [1142527.786872] ? __pfx_kthread+0x10/0x10
> [1142527.787287] ret_from_fork+0x2d/0x50
> [1142527.787694] ? __pfx_kthread+0x10/0x10
> [1142527.788115] ret_from_fork_asm+0x1a/0x30
> [1142527.788543] </TASK>
> [1142527.788898] INFO: task kworker/u197:5:3788059 blocked for more
> than 122 seconds.
> [1142527.790084] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.790815] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.791527] task:kworker/u197:5 state:D stack:0 pid:3788059
> tgid:3788059 ppid:2 flags:0x00004000
> [1142527.792358] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.792999] Call Trace:
> [1142527.793337] <TASK>
> [1142527.793657] __schedule+0x222/0x670
> [1142527.794072] schedule+0x2c/0xb0
> [1142527.794455] schedule_preempt_disabled+0x11/0x20
> [1142527.794949] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.795435] down_read+0x45/0xa0
> [1142527.795830] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.796379] btrfs_search_slot+0x40f/0xbd0 [btrfs]
> [1142527.796913] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.797427] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.797987] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.798516] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.799090] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.799615] process_one_work+0x193/0x3d0
> [1142527.800067] worker_thread+0x2fc/0x410
> [1142527.800506] ? __pfx_worker_thread+0x10/0x10
> [1142527.800966] kthread+0xdc/0x110
> [1142527.801340] ? __pfx_kthread+0x10/0x10
> [1142527.801779] ret_from_fork+0x2d/0x50
> [1142527.802191] ? __pfx_kthread+0x10/0x10
> [1142527.802610] ret_from_fork_asm+0x1a/0x30
> [1142527.803044] </TASK>
> [1142527.803350] INFO: task kworker/u196:19:3788213 blocked for more
> than 123 seconds.
> [1142527.804025] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.804643] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.805343] task:kworker/u196:19 state:D stack:0 pid:3788213
> tgid:3788213 ppid:2 flags:0x00004000
> [1142527.806178] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.806800] Call Trace:
> [1142527.807148] <TASK>
> [1142527.807462] __schedule+0x222/0x670
> [1142527.807887] ? leaf_space_used+0xad/0xd0 [btrfs]
> [1142527.808395] schedule+0x2c/0xb0
> [1142527.808787] schedule_preempt_disabled+0x11/0x20
> [1142527.809279] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.809773] down_read+0x45/0xa0
> [1142527.810167] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.810717] btrfs_read_lock_root_node+0x34/0x90 [btrfs]
> [1142527.811275] btrfs_search_slot+0x127/0xbd0 [btrfs]
> [1142527.811798] ? btrfs_alloc_reserved_file_extent+0x8c/0xf0 [btrfs]
> [1142527.812411] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.812942] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.813493] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.814020] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.814591] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.815119] process_one_work+0x193/0x3d0
> [1142527.815565] worker_thread+0x2fc/0x410
> [1142527.815991] ? __pfx_worker_thread+0x10/0x10
> [1142527.816442] kthread+0xdc/0x110
> [1142527.816824] ? __pfx_kthread+0x10/0x10
> [1142527.817247] ret_from_fork+0x2d/0x50
> [1142527.817659] ? __pfx_kthread+0x10/0x10
> [1142527.818079] ret_from_fork_asm+0x1a/0x30
> [1142527.818516] </TASK>
> [1142527.818825] INFO: task kworker/u193:14:3792561 blocked for more
> than 123 seconds.
> [1142527.819507] Tainted: G E 6.9.2-1.gdc.el9.x86_64 #1
> [1142527.820130] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [1142527.820868] task:kworker/u193:14 state:D stack:0 pid:3792561
> tgid:3792561 ppid:2 flags:0x00004000
> [1142527.821699] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [1142527.822325] Call Trace:
> [1142527.822673] <TASK>
> [1142527.822996] __schedule+0x222/0x670
> [1142527.823404] schedule+0x2c/0xb0
> [1142527.823793] schedule_preempt_disabled+0x11/0x20
> [1142527.824284] rwsem_down_read_slowpath+0x260/0x4f0
> [1142527.824780] down_read+0x45/0xa0
> [1142527.825179] __btrfs_tree_read_lock+0x19/0x80 [btrfs]
> [1142527.825726] btrfs_search_slot+0x40f/0xbd0 [btrfs]
> [1142527.826254] btrfs_lookup_csum+0x5c/0x150 [btrfs]
> [1142527.826775] btrfs_csum_file_blocks+0x182/0x6b0 [btrfs]
> [1142527.827332] ? btrfs_global_root+0x4d/0x60 [btrfs]
> [1142527.827866] btrfs_finish_one_ordered+0x6e9/0xa80 [btrfs]
> [1142527.828430] btrfs_work_helper+0xba/0x190 [btrfs]
> [1142527.828971] process_one_work+0x193/0x3d0
> [1142527.829412] worker_thread+0x2fc/0x410
> [1142527.829840] ? __pfx_worker_thread+0x10/0x10
> [1142527.830301] kthread+0xdc/0x110
> [1142527.830682] ? __pfx_kthread+0x10/0x10
> [1142527.831105] ret_from_fork+0x2d/0x50
> [1142527.831515] ? __pfx_kthread+0x10/0x10
> [1142527.831936] ret_from_fork_asm+0x1a/0x30
> [1142527.832364] </TASK>
> [1142527.832680] Future hung task reports are suppressed, see sysctl
> kernel.hung_task_warnings
>

