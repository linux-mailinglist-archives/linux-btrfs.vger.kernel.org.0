Return-Path: <linux-btrfs+bounces-7000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C56948CFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7468F1F2507F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA791BF311;
	Tue,  6 Aug 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lcSiIY4u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506E1BE85D
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940934; cv=none; b=AFRwx9chJMgYci54BWOprW4q5+Bi0P/QhHIjGtFQ+VqH/UeYI9ehZISd3s8WldphZEGvFf6MRhRLYvARFw+4hn3LR5mBjx6lIqhcRqY9oVXkNpi/JRKL3Z6MAZBrNP/50+GCFhJ6ihHOMBTqR7vqT6n55AoF9Kz9LLPdPsGbzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940934; c=relaxed/simple;
	bh=3QI3LqNbeitKdHWGF9hBJB1lKqD+3KMb1L4/Amg1wi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/qO4XMEJXO7gJPgdPMdtR3pJqsDr2w4U+TKfyQ5cv7f4Bv85qhFj8vG12NGqReEwYTEA4Q5sqE0I6PIH7vGNXhXfjdwWnlT5WPterILuN2qQHNgA37p39VjGZ1rTN7MFT9P9AP13jeyJNr4oQqGRMbcGAlvLEyISh3Rmozz3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lcSiIY4u; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722940929; x=1723545729; i=quwenruo.btrfs@gmx.com;
	bh=3QI3LqNbeitKdHWGF9hBJB1lKqD+3KMb1L4/Amg1wi8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lcSiIY4uBzIAecZWlrggjhgenwTuHZfbQ7aF1rNFdrhDjMHvGQqxaabkiyAUIlkS
	 7Fxttc6uOaf2MFh/dO4epRS9etVm2HBJZ7dR7nbLcPfuV+UqaMH71/GLQlNqATwig
	 gIGhjLQaiNxAPWE96qvlwZQgq4fSJb+E2kVUdWQcj3qscmVhFz9tLRP4jVvOJzmlI
	 4v+x66QnmpsttVfFDQ48YIayfkUfCevLnc9iHDLN/s1HzCSVZI/Sr1D1eLIPosmvr
	 ghMOqzeAiVk68FZK622KNO4UTM5xOQVEI+nlKXxcqp0+setvuqX5qGXfomQpagK3I
	 kB7roOrBM17dtd7kCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9kM-1sRJts3hqG-009jYN; Tue, 06
 Aug 2024 12:42:09 +0200
Message-ID: <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
Date: Tue, 6 Aug 2024 20:12:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
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
In-Reply-To: <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EdVO76lfv/J6fXz6SkQWO6tLSd0lMA5Oq37gIpskHuVdVe/Wyrt
 cZ+IfWhw3wzu8nl51hXjvYCeTBCjDPZlCEL41n96Es8IKQmiT5tI1AV1mcio2HkBb6oPPwu
 ryhYhhDx0rjs87CJGF8qw1wI+8fj6SMzo+fIA1cNG63UHmZ42bXTbyhREBLNG1F8u5vdbvH
 +cwNJ2XNSaKpWeym6wcBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:70KKwbX8BlA=;cmrjWIx5D9DSNGoyAnHQvShYXoD
 NivZPiVM9scXNfpnoaZRCmdD2jg3tzPTmjY1bOrp6FrUQKuUlG68mGAgLeKr+lnCdFnnMcomp
 BVP5+j/7eXiwSuFygbNSlgKwukYgDPm6vsPdeYSH0P9/+zIcrrk7Ff/pe1KhssTtCNUjUpV/G
 6Tuj35cXErpQeEGNMamA3CnzWGK2+qvmNrdOvwDAVJcETWVMgtcmkmKeLmSYXjtPjzjdg92Ey
 7ComDBw2IvixWhzxlc1PE0x3YuHa9pKMMN1ft0NXN0+FK+E7YBUhBGCR364qENXBfRBP+z7c5
 RRSfZHtHCDL+skBdNg8qrrBtfMOkBYmDqLHlh1CQLPfo4NQkF4s5aBNp//YM/gBFO0uTnRFPC
 0rFp1a3QymnRLhNp7v9twiHvVcrSYRRGJCFJZtr0UVnRaT1cBz0PRajhDZzBdxlUM7QeY3v/A
 Y9vB/KawAS486QFs0BD582IliIJwTEl3JBukHA/TlhOjPxeEroSwsOBGvXR2ERoA27RV3Asd/
 IJlmWhWU+KUnAe/7Syy+WvCR0F/RONq97BgI8ngIydaxlUJHDiaAJnABiXZUGb9jTIAliZXfD
 9iJGTttgojXZseJqnQGd37cGfk2X5edir32iO7j44KSr7mbj/ladD5JZ0PSbGB3RidHNgQE4a
 pYAWhjscCVfjlvNmeiqpN6+ZOThH2cuxO/j0qj273o6gqEZ4RW238SQlFK3d6xgMjacMncMa5
 DDLDKBpt+MJZNT9rEa/Iy0OCV4PGRIBwVcjAqDX0oeCpWecvLe0uLH9RGsUM7Ddd2YCtl3fwl
 Ytuk1QNehPU1glo72NW8aVGw==



=E5=9C=A8 2024/8/6 19:53, Hanabishi =E5=86=99=E9=81=93:
> On 8/6/24 09:55, Qu Wenruo wrote:
>
>> So either there is something like cgroup involved (which can limits the
>> dirty page cache and trigger write backs), or some other weird
>> behavior/bugs.
>
> Yes, this line reveals something. I do have modified dirty page cache
> values. I tend to keep it on low values.
>
> Now playing around with it - yes, it is seems to be the cause. When I
> tune 'vm.dirty_ratio' and 'vm.dirty_background_ratio' up to higher
> values, the problem becames less prevalent.
>
> Which means lowering them cranks up the problem to extremes. E.g. try
>
> # sysctl -w vm.dirty_bytes=3D8192
> # sysctl -w vm.dirty_background_ratio=3D0
>
> With that setup defrag completely obliterates files even with default
> threshold value.

At least I no longer need to live under the fear of new defrag bugs.

This also explains why defrag (even with default values) would trigger
rewrites of extents, because although fiemap is only showing a single
extent, it will be a lot of small extents on the larger pre-allocated rang=
e.

Thus btrfs believe it can merge all of them into a larger extent, but VM
settings forces btrfs to write them early, causing extra data COW, and
cause worse fragmentation.

Too low values means kernel will trigger dirty writeback aggressively, I
believe for all extent based file systems (ext4/xfs/btrfs etc), it would
cause a huge waste of metadata, due to the huge amount of small extents.

So yes, that setting is the cause, although it will reduce the memory
used by page cache (it still counts as memory pressure), but the cost is
more fragmented extents and overall worse fs performance and possibly
more wear on NAND based storage.

Thanks,
Qu

