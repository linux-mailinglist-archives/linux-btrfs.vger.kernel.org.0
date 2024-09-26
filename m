Return-Path: <linux-btrfs+bounces-8274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5EA987AF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 00:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB44FB21A34
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 22:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A32189503;
	Thu, 26 Sep 2024 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="P77MrgXS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716F1891BA
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388182; cv=none; b=YCmm9vCKvCpsPJp+fh/pXtQknT5BnT9Xt/zucGcGAGINcMO5OfAmaisimWV1pTzeFIilcbQLPzqcMzErenl4EOpx/cuUfK3atmRl76ABXVyY0nYWO3wZH4vB9i3Hp8HhKcMTt61PksCt1IHODc17xiz/7hJUmvSnMB6NbRy3tv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388182; c=relaxed/simple;
	bh=mwygBn95Tj79cP5sH7owFCYTf9lKdV1Z26dIHzgFVGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj7wD9tkdQ7U/8MzuNVwaEfpyIcvULmXTeAkK6Ret7AMf1GvqlTN0vULUKQFfs256wxrlf1w1wK7J/0bmdfnlL6Ta4PvZoc90nwWQ2Zd8b+KHEk9D5CowFaswguPGKx8k2PO4svGFJBSjGK0ShgQA42G9ZHfTVtPcNZm8pn74MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=P77MrgXS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727388172; x=1727992972; i=quwenruo.btrfs@gmx.com;
	bh=mwygBn95Tj79cP5sH7owFCYTf9lKdV1Z26dIHzgFVGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P77MrgXSOz7rkTaHRVuh39IrJbpqd4IVKbttY3o/X/qcJ73peaxT6p+WcQmnbDJE
	 xh3qje7XEotF2rNCCaGcsjRC2+QiimXsyuRkUAxC1KxmMIA2xamFKNE/bE66Kt+Rc
	 yv6ENwzosztweTBGWzeqXLT4rpcSqxz+nhJZE1lkRwWnTMOK+/dCEeVzbPW0wbTML
	 o/5GS19AHiF2gPZxEAM0pMS7nTc9ugfmjkg+Np+ci7vYtX90bWMnebCn1B69gSmSk
	 KnRvjqrhXkvj5dVSreUeG1+RK1E9bj6+HOiry9F/8VTTCY8AAVGnXWeOacbn7A2ZJ
	 P+BPuUibQQq+S/0FEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1sR0nl0tEv-00UIjz; Fri, 27
 Sep 2024 00:02:52 +0200
Message-ID: <57645a54-43e0-4a7d-9b84-4c3b662ea1f5@gmx.com>
Date: Fri, 27 Sep 2024 07:32:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: make the extent map shrinker run
 asynchronously as a work queue job
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1727174151.git.fdmanana@suse.com>
 <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
 <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com>
 <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
 <9323f10d-dab1-4826-a088-90b1c5bea38c@gmx.com>
 <CAL3q7H7LBWyfXy7XRJh7ufgLdhTBw4MGZtBtLV+2zCLJ3MrFsQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7LBWyfXy7XRJh7ufgLdhTBw4MGZtBtLV+2zCLJ3MrFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7tPMi9RwotfMGQgbl5ihIjjM+uV2CV+l+mLV4Gfjv1AMrKhrUms
 QnqF8dp0hZGPECNWC4QAd1tkGB4nJBZKr4iO0FYatJyDedNNlx+PqYIm3ZW0wJsYit/4/7A
 rS7jITyif9xxLVj0PGGhLQ1XXL7DGt3jeAf4fF4okZ7P96KQgqJhga5SgJeT5doT8c8cBgh
 Gi8lGyWu70cYamxQ5Jryw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lFYdngKLUIA=;nXTH1Vl5kPhcKKgjDa0izyQiPSy
 VUEnZnDSmDCtW6ENlH25pETQDrEbmPi9vBGFf9duCyhsI+SDODLKtYEbb3fnfa6/4raFi42bM
 BiHLkDIavX7ZSk3aYQ7GYenTYUNHkP7Qqgc0pHLhq9RbAdEyavl2gMYhxTxJoOVx3GDLOC98c
 oQdL65gkNeMJeUfau4ml9ps0Ix1Xy/i+eR/Qz8MKIdRNRD4ylsOMBtf1A/5xf0L+aV0EFLaAu
 ermqbegt6imq2wu5Zzxr1Ll/yxjk/LbFGZI3eE65mhFvdORxs0wzVGEzgP5sgBNy0NCH5dCa1
 mBRnYcYAwG+d/bmorcuTSFxmFWF2lTw0zGW4/c3HBkEpB4NvaoPbCacHQ7U+yEWqxpElR1Bxq
 ZXC99ihxwUZEr07N7uyqd/MQHeyyRREIxqYMU3x2f54PJ459MoIf+NAWnDyxFi+/9Q/GBNvj5
 JOS5ehvf+/lmQ/rWqJ/PdnisD2WDeuQCWX9pkxrwUB2ZhKFDbxdEVDDVPnzfXTvpK0thcdle3
 oQKoFE9ctTdYaDVHwFgMEoDCEfCxBmi0725fOTFqiVzW8lbTTsARKd7JUtp6doQt2UlFn4hWe
 xEDlsfQjO/bwx4ui14zFvBfF10z5wdhnYNnAykkD1QPfgmsbMTxXe6suw3K4ELhocB3BNCmqf
 K/AhznzVXyuu3TPBYtCoAhDjV2FAicK6zjPTL/5Yu/7TMomLyAgTftlSunjS87hq2/W3oQRc/
 IYWD8ewux60U1y9ZUSmUKosfxYoB8c3PZyhRknUZ/bV6YEUqshatTDjnNUH7v38iu+rGK7S8h
 yxoLXrE2XCgwnxTv8LbZrKag==



=E5=9C=A8 2024/9/26 20:11, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Sep 26, 2024 at 10:55=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
[...]
>>> What's the problem?
>>> The use of the atomic and not incrementing it, as said in the comment,
>>> makes sure we don't do more work than necessary.
>>>
>>> It's also running in the system unbound queue and has plenty of
>>> explicit reschedule calls to ensure it doesn't monopolize a cpu and
>>> doesn't block other tasks for long.
>>>
>>> So how can it cause any problem?
>>
>> Then it will be a workqueue taking CPU 100% (or near that).
>> Even there is only one running work.
>
> No it won't.
> Besides the very frequent reschedule points, the shrinker is always
> called with a small percentage of the total number of objects to free.

And there is no guarantee that a small number to reclaim is not heavy.

The latency of a scan is not directly related to the passed-in number,
but the amount of roots/inodes/ems.

E.g. we have tens of thousands of inodes to go through. Even most of
them have no extent maps, it may still take milliseconds to go through.

And if we always have a small ems pinned for IO, so even after the
current reclaim done, the next reclaim work will still get some small
number queued to reclaim, again takes several milliseconds to reclaim
may be a few extent maps, then IO creates new ems bumping up the em
counts again.

>
>>
>> The first one queued the X number to do, and the work got queued, after
>> freed X items, the next call triggered, queuing another Y number to rec=
laim.
>
> And? Work queue jobs are distributed across cores as needed, so that
> work queue won't be monopolized with extent map shrinking.

Scheduled across different CPUs won't make any difference if the reclaim
workload is queued and run again and again.

Let me be clear, reschedule and core distribution are not changing the
nature of a long running CPU heavy workload.
Just take gcc as an example, it's a user space program, which can always
be preempted, and kernel can always reschedule the user space program to
whatever CPU core.
But it's still a long running CPU heavy workload.

The same is for the em shrinker, the difference is the em shrinker is
just waked up again and again, other than a long running one.

>
>>
>> The we get the same near-100% CPU usage, it may be rescheduled, but not
>> much difference.
>> We will always have one reclaim work item running at any moment.
>
> And if that happens it's because it's needed.
> The same goes for space reclaim, it's exactly what we do for space
> reclaim. We don't add delays there and neither for delayed iputs.

Unlike delayed inodes, em shrinker needs to go through all roots and all
the inodes if we didn't free enough ems.

While delayed inodes has a simple list of all the delayed inodes, not
really much scanning.

And just as you mentioned in the changelog, the scanning itself can be
the real problem.

>
>>
>>>
>>>>
>>>> The XFS is queuing the work with an delay, although their reason is t=
hat
>>>> the reclaim needs to be run more frequently than syncd interval (30s)=
.
>>>>
>>>> Do we also need some delay to prevent such too frequent reclaim work?
>>>
>>> See the comment above.
>>>
>>> Without the increment of the atomic counter, if it keeps getting
>>> scheduled it's because we're under memory pressure and need to free
>>> memory as quickly as possible.
>>
>> Even the atomic stays the same until the current one finished, we just
>> get a new number of items to reclaim next.
>
> If we do get it's because we still need to free memory, and we have to d=
o it.
>
>>
>> Furthermore, from our existing experience, we didn't really hit a
>> realworld case where the em cache is causing a huge problem, so the
>> relaim for em should be a very low priority thing.
>
> We had 1 person reporting it. And now that the problem is publicly
> known, it can be exploited by someone with bad intentions - no root
> privileges are required.

I do not see how delayed reclaim will cause new problem in that case.
Yes, it will not reclaim those ems fast enough, but it's still doing
proper reclaim.

In fact we have more end users affected by the too aggressive shrinker
behavior than not reclaiming those ems.


And it will be a slap in the face if we move the feature into
experimental, then move it out and have to move it back again.

So I'm very cautious on any possibility that this shrinker can be
triggered without any extra wait.

>
>>
>> Thus I still believe a delayed work will be much safer, just like what
>> XFS is doing for decades, and also like our cleaner kthread.
>
> Not a specialist on XFS, and maybe they have their reasons for doing
> what they do.
>
> But the case with our cleaner kthread is very different:
>
> 1) First for delayed iputs that delay doesn't exist.
> When doing a delayed iput we always wake up the cleaner if it's not
> currently running.
> We want them to run asap to prevent inode eviction from happening and
> holding memory and space reservations for too long.

But the delayed iput doesn't need to scan through all the roots/inodes.

Thanks,
Qu

>
> 2) Otherwise the delay and sleep is both because it's a kthread we
> manually manage and because deletion of dead roots is IO heavy.
>
> Extent map shrinking doesn't do any IO. Any concern about CPU I've
> already addressed above.
>
>


