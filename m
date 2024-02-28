Return-Path: <linux-btrfs+bounces-2848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4086A9AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 09:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC761F2AC9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 08:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FB2C6AF;
	Wed, 28 Feb 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CXr9ioQ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5212C1AC
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108305; cv=none; b=UUdL9qBj2j8bT4taxSJUCPqWpnpOTe0S4xrUbhvYSNAaYNjfng6zf1zAUvKZUISw5jPFxZxUPMFK5AKWs/5aV/BsZSkZnzF9V2MEAQz/UjD+7hyBxgpKYhyFNoFNsKCb/rqHCdcjtAnfCJcDBRBlihpP1OLGGgD61ZHfMsTlHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108305; c=relaxed/simple;
	bh=1gvAtwN4ezSnhBvpmLjADGH1viAY9/tT5iLy608eA/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=is2KyMotWW5JDlGtUsRJpSWFSexGwcXWmjpb0PFJM8S0No4u57R/J9aQPYsfZf3qYmNm48ViMxbe4ZnqwAGZEwZsJwu1pJgp4HUtqqo2SDZ73D4FGz1zqP2zf25fhi6tMQFW/dKUzF+m5ovxkPwBmsZYiPkqVQoYnYkSEcCeFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CXr9ioQ+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709108299; x=1709713099; i=quwenruo.btrfs@gmx.com;
	bh=1gvAtwN4ezSnhBvpmLjADGH1viAY9/tT5iLy608eA/c=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=CXr9ioQ+bZqYr5t91ugHeD5y8LSDbHa3SSYYqznrpZhwTfXHBIhVhpbb+JQmwxCf
	 Cn64SSDWzzmhsQbwqPyd0ak7famVlDBu60FTfgquzuoO9DH4mZ1/8pzGpDvQcee6L
	 DrF/m9bdU/GBsk06OgB7AEYToW1Pvzz0BuVX02M9BnoOvhlFHevCFy5TMoPo61a51
	 13ERx/sN9iHrTFxciaf0OpLPqRxU1T3fXM26fGrq/AD7Rl/nU/RPWbrHy/ATwoHei
	 kvaMNoOBlIVuOYND89nHa+4exS8SfdQbLWGpmK4j6qSEDBWePa8LH9/jwH889BTs6
	 OK0HMAvFJe4/dEB/1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1r1Wg62Ch6-00dogy; Wed, 28
 Feb 2024 09:18:19 +0100
Message-ID: <2020a7b4-b052-4144-8386-b05102a5465d@gmx.com>
Date: Wed, 28 Feb 2024 18:48:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.4 and 6.9 btrfs blocked and btrfs_work_helper workqueue lockup,
 is it an IO bug/hang though?
Content-Language: en-US
To: Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <ZdL0BJjuyhtS8vn1@merlins.org> <Zd5s1k8bFguE2NVl@merlins.org>
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
In-Reply-To: <Zd5s1k8bFguE2NVl@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kX7Ft7ZeTNKM82/rYXM5t9kq7p1II8JgrHyDYP6ULlgtkt+AKfx
 JBNseHw1riuSAV8fitebseaY0/560ymtmIUEYwX3lwcnWjXrhfs1j/XDi1I8eY40yyq9Qa3
 +sbxAUjMKTf6gbwbFCSTY3VI4/p/lAZrnPXH0zi49EOgmVqf3aE227jrVFwqRELlxtMb42z
 Uk2TzagLQVwAmAZp2DHCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tQFe1XIcKHQ=;LrdhQKNtx5SD3XarvAmxCTAzDDD
 7DQb7+iehZwO1a97zS8UWkHrf4NrhoN505+x2FupTYSS9QqelL41Tg9dHXe3Xwig7OB0zKVOj
 oxCgzv0cx/zgtxFUwONGmnG+R0seNBYotQIqIb4kmWgX/LCD3ZyTQWYfyHbwN8C57BIQk57Wp
 JB1F2zAr9/ZzuMnFhycRIXFh05aRwM9ha5r+NYajzkPn2UErR462twwV7mx6phmN6zr8xW3Bv
 YPh/HGnHxxX0U/KqHEVLXHvkLQ/ipYLRUWrNezj3xkCw9IvGi8Wqc7Uwz7JljfsxQSTYGZVfB
 Y2t75yKckMhPUVZXa2NEAprowRE6VATnAJpDtkDHDMB46mwUiF5TTiCpxVwG+CBf2lHcxPGW3
 6Ye5dHwl+tyXdiSB0rd9FWOmpFWBBDmMcVZB6f+0SOcCY/yZba17C/r6ixywiI74TZd8KWVhu
 g3cJRF2Yvlz3q5uoOo9xjJxzURHF1pqW3Cl7r0PThoWYuCqRuelFyMatYyrVTY7DticbOtFsy
 XWGancFNWA5+WXz0Q2xzXoSGXXfb3ze99M5VtVWrslmr41Cz5t0oEUiKxMLwmbEQGLaayO/jY
 u7DK4zhaUDeF1nkKSo+sM0zZOccrgRzEPPSXCyXeJjSFrMdVK5rCrZ0n+cDi+0POGHQnp1HFu
 HR8hV4tJaoJ9tq6MZQs9j/3QegPNO2+L8fmSovHm6wtAWU5LXulDsJ8r7+UnYQYpyNOyGd2cC
 Vgzen6rN9vy4jAgyvDJWyw+E+MWpbqIKfPw0+PMHEV4GNlSSWPW57aEV8ywGZs0sUroBv2hRu
 fFZZmc5EerIxzkLdhvknJdc7YfHrSD2iDsH8ZldfVnx+o=



=E5=9C=A8 2024/2/28 09:44, Marc MERLIN =E5=86=99=E9=81=93:
> Could anyone who can raad those things better than me, give me a clue
> whether those hangs are hardware related like I'm guessing they may be,
> or if they are potentially bugs worth looking into?
>
> Thanks,
> Marc
>
> On Sun, Feb 18, 2024 at 10:24:04PM -0800, Marc MERLIN wrote:
>> I've seen this with both 6.4.9 and 6.6.9 and had to sysrq reboot both
>> times to recover.
>> I'm trying to see if it's a hang of my raid card.
>>
>> That's the more recent hang with 6.6.9:
>>
>> The one with 6.4.9 is longer, so I put it here: https://pastebin.com/xz=
11JXWM

This one looks like it's hanging at btrfs_commit_transaction+0x26c.

But without the proper code line, it's hard to say what btrfs is waiting
for.

>>
>> Here's the 6.6.9 one here. Can someone help me confirm that at least
>> this one is likely not btrfs' fault but just underlying I/O hang?
>>
>> If so, idoes the 6.4.9 match the same symptom, or is it a different iss=
ue?
>>
>> Thanks,
>> Marc
>>
>> 135577.600958] INFO: task md12_raid1:1276 blocked for more than 120 sec=
onds.
>> [135577.621963]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
>> [135577.641401] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [135577.665522] task:md12_raid1      state:D stack:0     pid:1276  ppid=
:2      flags:0x00004000
>> [135577.691381] Call Trace:
>> [135577.699494]  <TASK>
>> [135577.706627]  __schedule+0x6af/0x702
>> [135577.717853]  schedule+0x8b/0xbd
>> [135577.727933]  md_super_wait+0x5d/0x9c
>> [135577.739287]  ? __pfx_autoremove_wake_function+0x40/0x40
>> [135577.755602]  write_sb_page+0x242/0x25d
>> [135577.767482]  md_update_sb+0x4c1/0x679
>> [135577.779072]  md_check_recovery+0x276/0x484
>> [135577.791965]  raid1d+0x46/0x10db
>> [135577.802178]  ? raw_spin_rq_unlock_irq+0x5/0x10
>> [135577.816122]  ? finish_task_switch.isra.0+0x129/0x202
>> [135577.831629]  ? __schedule+0x6b7/0x702
>> [135577.843292]  ? lock_timer_base+0x38/0x5f
>> [135577.855662]  ? schedule+0x8b/0xbd
>> [135577.866222]  ? __list_add+0x12/0x2f
>> [135577.877341]  ? _raw_spin_unlock_irqrestore+0xe/0x2e
>> [135577.892618]  md_thread+0x113/0x140
>> [135577.903553]  ? __pfx_autoremove_wake_function+0x40/0x40
>> [135577.920016]  ? __pfx_md_thread+0x40/0x40
>> [135577.932413]  kthread+0xe8/0xf0
>> [135577.942221]  ? __pfx_kthread+0x40/0x40
>> [135577.954084]  ret_from_fork+0x24/0x36
>> [135577.965583]  ? __pfx_kthread+0x40/0x40
>> [135577.977475]  ret_from_fork_asm+0x1b/0x80
>> [135577.989877]  </TASK>
>> [135577.997078] INFO: task md13_raid1:1278 blocked for more than 121 se=
conds.
>> [135578.018044]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
>> [135578.037405] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [135578.061454] task:md13_raid1      state:D stack:0     pid:1278  ppid=
:2      flags:0x00004000
>> [135578.087065] Call Trace:
>> [135578.094972]  <TASK>
>> [135578.102074]  __schedule+0x6af/0x702
>> [135578.113302]  schedule+0x8b/0xbd
>> [135578.123297]  md_super_wait+0x5d/0x9c
>> [135578.134757]  ? __pfx_autoremove_wake_function+0x40/0x40
>> [135578.151023]  write_sb_page+0x242/0x25d
>> [135578.162869]  md_update_sb+0x4c1/0x679
>> [135578.174470]  md_check_recovery+0x276/0x484
>> [135578.187342]  raid1d+0x46/0x10db
>> [135578.197352]  ? raw_spin_rq_unlock_irq+0x5/0x10
>> [135578.211262]  ? finish_task_switch.isra.0+0x129/0x202
>> [135578.226731]  ? __schedule+0x6b7/0x702
>> [135578.238278]  ? lock_timer_base+0x38/0x5f
>> [135578.250688]  ? _raw_spin_unlock_irqrestore+0xe/0x2e
>> [135578.265933]  ? __try_to_del_timer_sync+0x64/0x8b
>> [135578.280350]  ? __timer_delete_sync+0x2e/0x3d
>> [135578.293706]  ? __list_add+0x12/0x2f
>> [135578.304886]  ? _raw_spin_unlock_irqrestore+0xe/0x2e
>> [135578.320238]  md_thread+0x113/0x140
>> [135578.331038]  ? __pfx_autoremove_wake_function+0x40/0x40
>> [135578.347265]  ? __pfx_md_thread+0x40/0x40
>> [135578.359599]  kthread+0xe8/0xf0
>> [135578.369323]  ? __pfx_kthread+0x40/0x40
>> [135578.381272]  ret_from_fork+0x24/0x36
>> [135578.392702]  ? __pfx_kthread+0x40/0x40
>> [135578.404534]  ret_from_fork_asm+0x1b/0x80
>> [135578.416877]  </TASK>
>> [135578.424012] INFO: task dmcrypt_write/2:2017 blocked for more than 1=
21 seconds.
>> [135578.446256]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
>> [135578.465619] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [135578.489691] task:dmcrypt_write/2 state:D stack:0     pid:2017  ppid=
:2      flags:0x00004000
>> [135578.515301] Call Trace:
>> [135578.523384]  <TASK>
>> [135578.530433]  __schedule+0x6af/0x702
>> [135578.541490]  schedule+0x8b/0xbd
>> [135578.551650]  md_write_start+0x160/0x1a7
>> [135578.563748]  ? __pfx_autoremove_wake_function+0x40/0x40
>> [135578.579993]  raid1_make_request+0x89/0x880
>> [135578.592962]  ? sugov_update_single_freq+0x20/0x106
>> [135578.607926]  ? update_load_avg+0x372/0x39b
>> [135578.620814]  ? get_sd_balance_interval+0xf/0x3d
>> [135578.635156]  md_handle_request+0x126/0x16d
>> [135578.648040]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7=
f7c3ecde59f70e81b621d3b8f858]
>> [135578.674973]  ? _raw_spin_unlock+0xa/0x1d
>> [135578.687325]  ? raw_spin_rq_unlock_irq+0x5/0x10
>> [135578.701386]  ? finish_task_switch.isra.0+0x129/0x202
>> [135578.716851]  __submit_bio+0x63/0x89
>> [135578.728043]  submit_bio_noacct_nocheck+0x181/0x258
>> [135578.743026]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7=
f7c3ecde59f70e81b621d3b8f858]
>> [135578.769994]  dmcrypt_write+0xd1/0xfd [dm_crypt 721219ef82f7f7c3ecde=
59f70e81b621d3b8f858]
>> [135578.794848]  kthread+0xe8/0xf0
>> [135578.804612]  ? __pfx_kthread+0x40/0x40
>> [135578.816438]  ret_from_fork+0x24/0x36
>> [135578.827741]  ? __pfx_kthread+0x40/0x40
>> [135578.839744]  ret_from_fork_asm+0x1b/0x80
>> [135578.852280]  </TASK>
>> [135578.859445] INFO: task btrfs-transacti:2415 blocked for more than 1=
22 seconds.
>> [135578.881710]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
>> [135578.901270] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [135578.925345] task:btrfs-transacti state:D stack:0     pid:2415  ppid=
:2      flags:0x00004000
>> [135578.950996] Call Trace:
>> [135578.958960]  <TASK>
>> [135578.965902]  __schedule+0x6af/0x702
>> [135578.976995]  schedule+0x8b/0xbd
>> [135578.987195]  io_schedule+0x12/0x38
>> [135578.998015]  folio_wait_bit_common+0x157/0x202
>> [135579.011950]  ? __pfx_wake_page_function+0x40/0x40
>> [135579.026658]  folio_wait_writeback+0x30/0x38

But in v6.6, btrfs is only waiting for its metadata to be properly
written back, that's the only blocked btrfs thread.

On the other hand, there are a lot of md/dm related hanging, which I
believe is the cause for blocked btrfs IO.

Thanks,
Qu
>> [135579.039897]  __filemap_fdatawait_range+0x74/0xbf
>> [135579.054353]  ? __update_freelist_fast+0x17/0x1e
>> [135579.068568]  ? __clear_extent_bit+0x323/0x338
>> [135579.082257]  filemap_fdatawait_range+0xf/0x19
>> [135579.096112]  __btrfs_wait_marked_extents.isra.0+0x98/0xf3
>> [135579.113089]  btrfs_write_and_wait_transaction+0x5d/0xbf
>> [135579.129372]  btrfs_commit_transaction+0x67c/0xa62
>> [135579.144094]  ? start_transaction+0x3f7/0x463
>> [135579.157540]  transaction_kthread+0x105/0x17a
>> [135579.170970]  ? __pfx_transaction_kthread+0x40/0x40
>> [135579.185951]  kthread+0xe8/0xf0
>> [135579.195732]  ? __pfx_kthread+0x40/0x40
>> [135579.207593]  ret_from_fork+0x24/0x36
>> [135579.218942]  ? __pfx_kthread+0x40/0x40
>> [135579.230778]  ret_from_fork_asm+0x1b/0x80
>> [135579.243146]  </TASK>
>> [135579.250316] INFO: task dmcrypt_write/2:5016 blocked for more than 1=
22 seconds.
>> [135579.272593]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
>> [135579.291991] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [135579.316244] task:dmcrypt_write/2 state:D stack:0     pid:5016  ppid=
:2      flags:0x00004000
>> [135579.341930] Call Trace:
>> [135579.349929]  <TASK>
>> [135579.356826]  __schedule+0x6af/0x702
>> [135579.367910]  schedule+0x8b/0xbd
>> [135579.377939]  md_write_start+0x160/0x1a7
>> [135579.390216]  ? __pfx_autoremove_wake_function+0x40/0x40
>> [135579.406491]  raid1_make_request+0x89/0x880
>> [135579.419401]  ? update_cfs_rq_load_avg+0x176/0x189
>> [135579.434131]  ? update_load_avg+0x46/0x39b
>> [135579.446738]  ? get_sd_balance_interval+0xf/0x3d
>> [135579.461129]  md_handle_request+0x126/0x16d
>> [135579.474037]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7=
f7c3ecde59f70e81b621d3b8f858]
>> [135579.500975]  ? _raw_spin_unlock+0xa/0x1d
>> [135579.513370]  ? raw_spin_rq_unlock_irq+0x5/0x10
>> [135579.527308]  ? finish_task_switch.isra.0+0x129/0x202
>> [135579.542831]  __submit_bio+0x63/0x89
>> [135579.553918]  submit_bio_noacct_nocheck+0x181/0x258
>> [135579.568943]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7=
f7c3ecde59f70e81b621d3b8f858]
>> [135579.595885]  dmcrypt_write+0xd1/0xfd [dm_crypt 721219ef82f7f7c3ecde=
59f70e81b621d3b8f858]
>> [135579.620760]  kthread+0xe8/0xf0
>> [135579.630682]  ? __pfx_kthread+0x40/0x40
>> [135579.642699]  ret_from_fork+0x24/0x36
>> [135579.654188]  ? __pfx_kthread+0x40/0x40
>> [135579.666045]  ret_from_fork_asm+0x1b/0x80
>> [135579.678418]  </TASK>
>> [135579.685606] INFO: task dmcrypt_write/2:5286 blocked for more than 1=
22 seconds.
>> [135579.707870]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
>> [135579.727445] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [135579.751591] task:dmcrypt_write/2 state:D stack:0     pid:5286  ppid=
:2      flags:0x00004000
>> [135579.777266] Call Trace:
>> [135579.785223]  <TASK>
>> [135579.792124]  __schedule+0x6af/0x702
>> [135579.803200]  ? __pfx_wbt_inflight_cb+0x40/0x40
>> [135579.817139]  ? __pfx_wbt_cleanup_cb+0x40/0x40
>> [135579.830818]  schedule+0x8b/0xbd
>> [135579.840951]  io_schedule+0x12/0x38
>> [135579.851745]  rq_qos_wait+0xe8/0x126
>> [135579.862795]  ? __pfx_rq_qos_wake_function+0x40/0x40
>> [135579.878021]  ? __pfx_wbt_inflight_cb+0x40/0x40
>> [135579.891951]  wbt_wait+0x95/0xe4
>> [135579.902022]  __rq_qos_throttle+0x23/0x33
>> [135579.914398]  blk_mq_submit_bio+0x2b6/0x4dd
>> [135579.927273]  __submit_bio+0x29/0x89
>> [135579.938356]  submit_bio_noacct_nocheck+0x121/0x258
>> [135579.953357]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7=
f7c3ecde59f70e81b621d3b8f858]
>> [135579.980432]  dmcrypt_write+0xd1/0xfd [dm_crypt 721219ef82f7f7c3ecde=
59f70e81b621d3b8f858]
>> [135580.005323]  kthread+0xe8/0xf0
>> [135580.015088]  ? __pfx_kthread+0x40/0x40
>> [135580.026929]  ret_from_fork+0x24/0x36
>> [135580.038259]  ? __pfx_kthread+0x40/0x40
>> [135580.050266]  ret_from_fork_asm+0x1b/0x80
>> [135580.062628]  </TASK>
>> [135580.069774] Future hung task reports are suppressed, see sysctl ker=
nel.hung_task_warnings
>>
>>
>> --
>> "A mouse is a device used to point at the xterm you want to type in" - =
A.S.R.
>>
>> Home page: http://marc.merlins.org/                       | PGP 7F55D5F=
27AAF9D08
>>
>>
>

