Return-Path: <linux-btrfs+bounces-7921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30A974AA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE631C21854
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 06:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A487E575;
	Wed, 11 Sep 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UGLJ+x0M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DB42052
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037508; cv=none; b=hhH9uPwD8fXYU7OQ/EEb33LBPHIdlrd5AJ6WHbBiZzOZ8Eo069DMvHOtDyt3eNF8ZRiMU/C/Y83cTKhmDedqDMg8NnuwCSXz7G/DzBtvjop7e+3bBSQz8z1U4gfxsVY5QFVL50CWUaoWAvXoAs2S3ywmWlyKJJQANnrSS3mzx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037508; c=relaxed/simple;
	bh=YZaMlbiwJ8st8DJ6Y56631+mI2dFkBsbhYwnpJcRuzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfVA0Tbg3VfOpuurwR6pscSPqjH5Vl8ihQM7fAem+m/twwHS2nS1GDzvqdEiKgqBPWEJb+6CsY+xIjO0U1YwJg8xpo9E4KiuAErP0IYtR4UxZ7aiDMNfhLUG6aACwQ4H7quf5cuDD+bIl1SnErjfPhfaVjV6br9Pc8TopiHmOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UGLJ+x0M; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726037503; x=1726642303; i=quwenruo.btrfs@gmx.com;
	bh=XeylKSyo5IRqRmljwIEVcznkPyk0uLlg+fV9zMSMZJo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UGLJ+x0MLehKEC7SIX/HeDyQKjA+yLJfiA1AMNbevXzKZhwpXoY5nXCcwd0BvogV
	 XW1apCxCAvAYb8+sL4zYORBtQ2RQjUpGak0AStrRjCxEOvIhzA0avdwuz54WGR086
	 cpEmoguGdDEqAESItmyxvWCg2UQW2kVz+R7xY9cmZHaSPYfHXdaWGXDzCXW3KQTVe
	 ScqS7S4RAm8m+fa8sxZtWm/Y7pSDJvCtF+BcNc1r/LPisGV95/WkFju+ZEQPQyh4Q
	 TKgxphuChvpHV0SLHoOG4MYwQ2GFzipz27gvYe72c4FPhuMhmgHGMf7vEFZd7zR+6
	 yr7hdKSRTgnto4wxhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1s3RIu0GEp-00xHgv; Wed, 11
 Sep 2024 08:51:43 +0200
Message-ID: <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
Date: Wed, 11 Sep 2024 16:21:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
 <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
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
In-Reply-To: <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8RpPr1UfSfzCPynYOePtu6smzUnc6OM+imn86f3Kiz5flYMnpbB
 oIEhY5ibt34rjbvxaNGyomwe1dNcPDq7DGWBPMJvv//faWlvN8ch1DbgGvqPuNwxFYf2r3f
 5doO5TshmqcnSuHXyFx/yT4/FPT3G7THZBpaip/RxDmSWTC01zJv3ClTw0D5ayMZC5uM3mv
 0IOmHlpbWEpUXPNVgZFlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i0wdzB4XdQA=;qwviRysjPBRpjrOc0mcveMfdFaP
 dzrU+zWHy/dJ7ROWtAT79Nr4D3KIagJm/8W5npoG/kAxuI2wIacydDiswXGVlT43Iqj6SgIRU
 ycdNNiL9hqwL6Ey5J79OUYcNR3RZOqHeXW2G6OCjt7+2vJpYe6XvOz/xpp77V79QmPbv6nipO
 K3XYuE0fC6+R9AuELc0gaDIdqTlnws5g9vEt0zNvLurna5b4TyjfCHrtVKP/VZCFzt05iwpMw
 n/+UPyG4OEfcRcuL0QNsNKLkBZ97p3JCJos4LdgGuGvn0rgc6NRQ5T0yY/gzkpP/XPraHWxMX
 ntTD7TNiH9qgTFj/MpN0pf+kQke3t+N5qJMwC0QaLv5GlA9OvjfShHd8F+BRTzxv1BYAWfIR1
 bw6OPydCIDfjoJCMjNUHRsgDmNrLvJ8jsfENgi/2i0mmHVXxD5+JPGZvRyZxseGo6FooNn+LJ
 rndKTqtfrHseluq4CewAIPrPU6edAAARCwaN7JDUwy9eVjh3qS143n4nyKWeCunc8+eJImKMX
 GtY4K/otLQ3B0LucLoaqHYm8J0aQyFNe1mwnnxVOrBvShf0/YVdZD+bzm/4STRTyXQEa+cbsv
 qO060rIZRDm1S6vdE+3ejR4NJuJ3R3E+nZWJhS1iRBtC5epcfeMdjK3i994WD0tLzl3Ytm8pP
 uSK4ckjYD7p9GYUhEvClOR29oc68rfA7c8Q6wpR7vfMJIFbIbg32eNipQAYNBif62Gdtn4X2+
 sOh/Vd93nXmR7BwffmDEc0X8vUml+PFfwQ8iRLOV+oLxOrOWJ/oAXX/Lj0QhNfpqSugZOSYkC
 tlxratqlTCM49mGrXnUPnT6g==



=E5=9C=A8 2024/9/11 16:10, Neil Parton =E5=86=99=E9=81=93:
> btrfs ins dump-tree -b 333413935558656 /dev/sda
> btrfs-progs v6.10.1
> checksum verify failed on 333413935558656 wanted 0x00000000 found 0xbd64=
0a79
> checksum verify failed on 333413935558656 wanted 0x00000000 found 0xbd64=
0a79
> ERROR: failed to read tree block 333413935558656

Can you provide the full dmesg of that mount failure?

Furthermore please also provide the following dump:

# btrfs ins dump-tree -b 333654787489792 /dev/sda

And if possible, also:

# btrfs check --mode=3Dlowmem /dev/sda

Thanks,
Qu
>
> On Tue, 10 Sept 2024 at 22:30, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/11 02:38, Neil Parton =E5=86=99=E9=81=93:
>>> Arch LTS system (kernel 6.6.50)
>>>
>>> Cannot mount a raid1 (data) raid1c3 (metadata) array made up of 4
>>> drives as I'm getting corrupt leaf and read time tree block corruption
>>> errors.
>>>
>>> mount -o recovery /dev/sda /mountpoint   didn't help
>>>
>>> If I blank the log on what seems to be the affected drive I can get it
>>> to mount but it will give out the same errors after a few sec and turn
>>> the file system read only.
>>>
>>> If I pull the affected drive and mount degraded I get the same errors
>>> from another drive.
>>>
>>> Trying to work out if I'm shafted or if there are steps I can take to =
repair.
>>>
>>> Critical data is backed up off site but I also have a tonne of
>>> non-critical data that will take me weeks to re-establish so nuking
>>> not my preferred option.
>>>
>>> I've managed to ssh in and here are some lines from dmesg:
>>>
>>> [   14.997524] BTRFS info (device sda): using free space tree
>>> [   22.987814] BTRFS info (device sda): checking UUID tree
>>> [  195.130484] BTRFS error (device sda): read time tree block
>>> corruption detected on logical 333654787489792 mirror 2
>>> [  195.149862] BTRFS error (device sda): read time tree block
>>> corruption detected on logical 333654787489792 mirror 1
>>> [  195.159188] BTRFS error (device sda): read time tree block
>>> corruption detected on logical 333654787489792 mirror 3
>>>
>>> [  195.128789] BTRFS critical (device sda): corrupt leaf:
>>> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
>>> invalid data ref objectid value 2543
>>> [  195.148076] BTRFS critical (device sda): corrupt leaf:
>>> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
>>> invalid data ref objectid value 2543
>>> [  195.157375] BTRFS critical (device sda): corrupt leaf:
>>> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
>>> invalid data ref objectid value 2543
>>
>> `btrfs ins dump-tree -b 333413935558656 /dev/sda` output please.
>>
>> Thanks,
>> Qu
>>>
>>> advice needed please
>>>
>

