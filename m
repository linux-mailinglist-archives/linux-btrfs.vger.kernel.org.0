Return-Path: <linux-btrfs+bounces-15559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A4B0ABB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2AB1C82779
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B322156F;
	Fri, 18 Jul 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G9dy4gtc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590C21CC68
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874614; cv=none; b=M/Ve0Ne/KepxyR9A++ingbq8UhPaTqn+tCiS77qVDxN9cmKj8YWs5cZIHonsfdKwO3zhmGJhA77d/RV9VVTzBAfp0h5Zn8i0mbDjes5RZZdZgkplpKzq5HOP5LaEzUOsA2tCclxUMqboi4DWV2cBUpRW7nRzLdf6B9aNgEn5ej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874614; c=relaxed/simple;
	bh=eTVI5FGU0c0e5yUlr/3nhqLHgcBCC+iPZieL2IxFVxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dA8d5EmdRIQUBf6X7xg5Q3r3UGNxZbSS/1EVPu9gMkt080luufj2sRBUBekpiR0WoRAuRPZmlQttShfUU/v1LvvSqVo+P6AFSsJuxa3rnOcWjvQC1A4w59RL6Qw8IVODG5e/E9j2CFrfKWN0fWgC8VMeBPBv0AWkqmXistBzyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G9dy4gtc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752874609; x=1753479409; i=quwenruo.btrfs@gmx.com;
	bh=1kN1GHk2dhwB+hvTGWTAnA1jY1ifvk7cMj0p3AVjXfQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G9dy4gtco4hHWa9OqQFUB45cgjJ16ETRnqin90zj3V4Ifm05PgFCdnvveQNp8jfI
	 lw6+7HlCzxjJ/U6K2wJAyqfWrh70VhZMNH5mRoQFi4h2pQkfvuqXGtxuNg9je5Qbk
	 SnV+bC4P2CMIDPxng9Ne5wBmJnFuoBfOX5IhmMFVIRdRNcGQsDn6m9mJdrlys+zXF
	 QE1ZBjc+Jd/4NxrfHBTVPD2Op3EEUkv1of5zTuzXYthUEmFAmgX9x/ozRG1u9Gza0
	 7+OBCuPkcwJA44Pi5dZuiAUBZ6+hw2e/kIjiM9NyeLvf3fg6IT9Y+ODmSPK2GQ3ad
	 idxTBqkXnE3nXIOgZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1vClLL346R-00gQSR; Fri, 18
 Jul 2025 23:36:49 +0200
Message-ID: <0ae559d6-ba95-489c-96fc-feca35a83f9a@gmx.com>
Date: Sat, 19 Jul 2025 07:06:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix subpage deadlock
To: Boris Burkov <boris@bur.io>, Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
 <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>
 <rk53fmeujogdqpwxh5zhrr4p62bd7io2pvxyuxn3w7eo57ygd6@nfb4wxhrorgw>
 <20250718183706.GA4097590@zen.localdomain>
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
In-Reply-To: <20250718183706.GA4097590@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:trJY4U8z24llwIlVEOV6XMCIfqVwnV1ctZpvv9gzLVqUbXh+Def
 tEXVF3OFIryLXsj0+1ZJiYZK+RyveCv5Ze2Rdzv4TDqwPXtUNci5mfbWNpKhpkqgARKiKde
 qasTgTD5BkR2e6bXNO4A66hYRSLNTg51PLh2aJ+o585+njIl59GVUecb71x9afGR21RPgqu
 rrtSyenQQf2hnYwmuR5aA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gwfzjLv8KPs=;kE+kGXOsdzIeHgRyzc3WGwxvc0X
 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
 kgYvbUoWRAd6/E=



=E5=9C=A8 2025/7/19 04:07, Boris Burkov =E5=86=99=E9=81=93:
> On Fri, Jul 18, 2025 at 10:40:28AM -0700, Leo Martins wrote:
>> On Fri 18 Jul 10:18, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2025/7/18 09:14, Leo Martins =E5=86=99=E9=81=93:
>>>> There is a deadlock happening in `try_release_subpage_extent_buffer`
>>>> because the irq-safe xarray spin lock `fs_info->buffer_tree` is being
>>>> acquired before the irq-unsafe `eb->refs_lock`.
>>>>
>>>> This leads to the potential race:
>>>>
>>>> ```
>>>> // T1					// T2
>>>> xa_lock_irq(&fs_info->buffer_tree)
>>>> 					spin_lock(&eb->refs_lock)
>>>> 					// interrupt
>>>> 					xa_lock_irq(&fs_info->buffer_tree)
>>>> spin_lock(&eb->refs_lock)
>>>> ```
>>>>
>>>
>>> If it's a lockdep warning, mind to provide the full calltrace?
>>>
>>
>>             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>             WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>>             6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G  =
          E    N
>>             -----------------------------------------------------
>>             kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>>             ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_rele=
ase_extent_buffer+0x18c/0x560
>>            =20
>> and this task is already holding:
>>             ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_re=
lease_extent_buffer+0x13c/0x560
>>             which would create a new lock dependency:
>>              (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{=
3:3}
>>            =20
>> but this new dependency connects a HARDIRQ-irq-safe lock:
>>              (&buffer_xa_class){-.-.}-{3:3}
>>            =20
>> ... which became HARDIRQ-irq-safe at:
>>               lock_acquire+0x178/0x358
>>               _raw_spin_lock_irqsave+0x60/0x88
>>               buffer_tree_clear_mark+0xc4/0x160
>>               end_bbio_meta_write+0x238/0x398
>>               btrfs_bio_end_io+0x1f8/0x330
>>               btrfs_orig_write_end_io+0x1c4/0x2c0
>>               bio_endio+0x63c/0x678
>>               blk_update_request+0x1c4/0xa00
>>               blk_mq_end_request+0x54/0x88
>>               virtblk_request_done+0x124/0x1d0
>>               blk_mq_complete_request+0x84/0xa0
>>               virtblk_done+0x130/0x238
>>               vring_interrupt+0x130/0x288
>>               __handle_irq_event_percpu+0x1e8/0x708
>>               handle_irq_event+0x98/0x1b0
>>               handle_fasteoi_irq+0x264/0x7c0
>>               generic_handle_domain_irq+0xa4/0x108
>>               gic_handle_irq+0x7c/0x1a0
>>               do_interrupt_handler+0xe4/0x148
>>               el1_interrupt+0x30/0x50
>>               el1h_64_irq_handler+0x14/0x20
>>               el1h_64_irq+0x6c/0x70
>>               _raw_spin_unlock_irq+0x38/0x70
>>               __run_timer_base+0xdc/0x5e0
>>               run_timer_softirq+0xa0/0x138
>>               handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>>               ____do_softirq.llvm.17674514681856217165+0x18/0x28
>>               call_on_irq_stack+0x24/0x30
>>               __irq_exit_rcu+0x164/0x430
>>               irq_exit_rcu+0x18/0x88
>>               el1_interrupt+0x34/0x50
>>               el1h_64_irq_handler+0x14/0x20
>>               el1h_64_irq+0x6c/0x70
>>               arch_local_irq_enable+0x4/0x8
>>               do_idle+0x1a0/0x3b8
>>               cpu_startup_entry+0x60/0x80
>>               rest_init+0x204/0x228
>>               start_kernel+0x394/0x3f0
>>               __primary_switched+0x8c/0x8958
>>            =20
>> to a HARDIRQ-irq-unsafe lock:
>>              (&eb->refs_lock){+.+.}-{3:3}
>>            =20
>> ... which became HARDIRQ-irq-unsafe at:
>>             ...
>>               lock_acquire+0x178/0x358
>>               _raw_spin_lock+0x4c/0x68
>>               free_extent_buffer_stale+0x2c/0x170
>>               btrfs_read_sys_array+0x1b0/0x338
>>               open_ctree+0xeb0/0x1df8
>>               btrfs_get_tree+0xb60/0x1110
>>               vfs_get_tree+0x8c/0x250
>>               fc_mount+0x20/0x98
>>               btrfs_get_tree+0x4a4/0x1110
>>               vfs_get_tree+0x8c/0x250
>>               do_new_mount+0x1e0/0x6c0
>>               path_mount+0x4ec/0xa58
>>               __arm64_sys_mount+0x370/0x490
>>               invoke_syscall+0x6c/0x208
>>               el0_svc_common+0x14c/0x1b8
>>               do_el0_svc+0x4c/0x60
>>               el0_svc+0x4c/0x160
>>               el0t_64_sync_handler+0x70/0x100
>>               el0t_64_sync+0x168/0x170
>>            =20
>> other info that might help us debug this:
>>              Possible interrupt unsafe locking scenario:
>>                    CPU0                    CPU1
>>                    ----                    ----
>>               lock(&eb->refs_lock);
>>                                            local_irq_disable();
>>                                            lock(&buffer_xa_class);
>>                                            lock(&eb->refs_lock);
>>               <Interrupt>
>>                 lock(&buffer_xa_class);
>>            =20
>>   *** DEADLOCK ***
>>             2 locks held by kswapd0/66:
>>              #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance=
_pgdat+0xe8/0xe50
>>              #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: t=
ry_release_extent_buffer+0x13c/0x560
>>            =20
[...]

Thanks a lot for the call trace.

Please add the above part into the commit message for the next update.
(The dependency part is too length and can be skipped)

>>
>>> I'm wondering at which exact interruption path that we will try to acq=
uire
>>> the buffer_tree xa lock.
>>>
>>> Since the read path is always happening inside a workqueue, it won't c=
ause
>>> xa_lock_irq() under interruption context.
>>>
>>> For the write path it's possible through end_bbio_meta_write() ->
>>> buffer_tree_clear_mark().
>>>
>>> But remember if there is an extent buffer under writeback, the whole f=
olio
>>> will have writeback flag, thus the btree_release_folio() won't even tr=
y to
>>> release the folio.
>>>
>>
>> Interesting, that makes sense. So this deadlock is impossible to hit?

No, just as Boris explained, it's still possible. I just want to be sure=
=20
that I'm not missing anything critical.

And it turns out that indeed there is a small window here.

>> What do you think about this patch? Should I pivot and try and figure
>> out how to express to lockdep that this deadlock is impossible?

I think we still need to address the lockdep wanring.

>>
>=20
> I just looked at that codepath and I don't think that the writeback flag
> is actually protecting us.
>=20
> the relevant code in end_bbio_meta_write() running in irq context is:
>=20
> 	bio_for_each_folio_all(fi, &bbio->bio) {
> 		btrfs_meta_folio_clear_writeback(fi.folio, eb);
> 	}
>=20
> 	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
>=20
> So we will clear writeback on the folio then take the xarray spinlock.
> So I believe the following interleaving is possible in practice, not
> just in lockdep land:
>=20
>     T1 (random eb->refs user)                                 T2 (releas=
e folio)
>=20
>          spin_lock(&eb->refs_lock);
>          // interrupt
>          end_bbio_meta_write()
>            btrfs_meta_folio_clear_writeback()
>                                                          btree_release_f=
olio()
>                                                            folio_test_wr=
iteback() //false
>                                                            try_release_e=
xtent_buffer()
>                                                              try_release=
_subpage_extent_buffer()
>                                                                xa_lock_i=
rq(&fs_info->buffer_tree)
>                                                                spin_lock=
(&eb->refs_lock); // blocked; held by T1
>            buffer_tree_clear_mark()
>              xas_lock_irqsave() // blocked; held by T2
>=20

Thanks a lot, this is indeed a window that can lead to the problem.

>=20
> And even if I missed something in that analysis and the writeback flag
> does save us, is there a way we can tell lockdep that this is in fact a
> safe locking relationship? "Theoretically", it's wrong, even if some
> other synchronization saves us..

I don't think it's theoretical only, since the lockdep is a runtime=20
detection tool, if there is something really preventing it from=20
happening, then it should not report this call site at all.

[...]
>>>> @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(=
struct folio *folio)
>>>>    	unsigned long end =3D index + (PAGE_SIZE >> fs_info->nodesize_bit=
s) - 1;
>>>>    	int ret;
>>>> -	xa_lock_irq(&fs_info->buffer_tree);
>>>> +	rcu_read_lock();

According to the docs, xa_for_each_range() is already taking and=20
releasing RCU lock by itself, thus the extra RCU lock may not be=20
necessary at all.

Maybe you can try with the xa_lock_irq() removed for this call site?


Another thing is, since the problem is only possible as metadata write=20
endio is happening in an IRQ context, the other solution is to delay the=
=20
metadata endio to happen in a workqueue.

By that we can even replace the usage of xa_lock_irq() with regular=20
xa_lock(), but that may be a little huge change, thus such change should=
=20
be only the last-resort method.

Thanks,
Qu

