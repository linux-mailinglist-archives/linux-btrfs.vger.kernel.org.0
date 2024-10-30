Return-Path: <linux-btrfs+bounces-9256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70839B6FA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 23:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83611C2199B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 22:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526222144D2;
	Wed, 30 Oct 2024 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jfiewKPu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61F1991DF;
	Wed, 30 Oct 2024 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730325718; cv=none; b=qIr9T6W9i00xqZFB1o9YlnrpZguF1BRU0P/dZBQkTo5thBr97FhmOnatu49Bg45T5tam8KMHdNduI/gb/HItPbExjQYqa57uM5Il2tQBKbsDI7wiRmqOLuexCTPSxUHCBrjS6/+TI8FRyxzRNC8ZXX2KCRcdgmVXsUyxupNdLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730325718; c=relaxed/simple;
	bh=rJV2D6Plr4LfbnmTXbxs2ZMIPn0FTjvTS2EdkNm+PaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2sL2pjkovRXzL+vRrM9E4FEUqlEuw1bOtHhnSc6O9yXCNhs5khBVKR31L3Rc5g5dRb07gxeUFBP6gmNy0pWcnpi9EgVszVWxOALRMUcZp1Se8yMkEmjE6MrSAS6Uh6IT0P0Wno85zLi4CmDSCg6W+em/JfNxTFO9kTpzX834iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jfiewKPu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730325701; x=1730930501; i=quwenruo.btrfs@gmx.com;
	bh=rJV2D6Plr4LfbnmTXbxs2ZMIPn0FTjvTS2EdkNm+PaU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jfiewKPu0kc+D8vZfch32OjP0dQrOe1UUQyxwL9K/JZ+5lQXX20DJmVOQ5/pQHtU
	 i7JI8eE3svi7dNLvrz/+be/yzTrZAh6BtEGpNARSpr/sBKeF6b8+8Iq6H0e5BdW/k
	 zwEF3lYT3Ry+XEm24UyLfnxvqRcrc6TqPnnc8rh+bQYEc8/a2+lS6lYioY5UfE+Y/
	 WUGyjOFcsZoWQpURoPGFTUKluCRuWhVS6kUYLQ5V40RA6Y/EWq8Ho97vGth4kneZR
	 iD+0nkgCD6/EzbriIen9YJTJJjQCTdyHzRz9CsYmeLPxYp/lzEiiHlZQU2QsvpuVL
	 v8geFChxVgDPsnXvfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKHm-1u4hTc2Hm8-00qr5P; Wed, 30
 Oct 2024 23:01:41 +0100
Message-ID: <19596057-5403-4ecd-a817-efdc5d69adc6@gmx.com>
Date: Thu, 31 Oct 2024 08:31:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: simplify regions mark and keep start unchanged
 in err handling
To: dsterba@suse.cz
Cc: iamhswang@gmail.com, linux-btrfs@vger.kernel.org, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com, boris@bur.io,
 linux-kernel@vger.kernel.org, Haisu Wang <haisuwang@tencent.com>
References: <20241025065448.3231672-1-haisuwang@tencent.com>
 <20241025065448.3231672-3-haisuwang@tencent.com>
 <4d0603d4-1503-4e8f-bfe2-ed205b598072@gmx.com>
 <20241030152836.GA31418@twin.jikos.cz>
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
In-Reply-To: <20241030152836.GA31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YQl52prO9scIDpgld1zYeo/yD238m14tPdwLTacSkOfpIfpK5U1
 HwJGFgsnQ3TyP5Kq6reG7nP6x65JsNF2qyOZ1JL2/46xiDJQcoDiSPvZ+lve3bPq/wObKxG
 etbWYTkBk/cfmrxvmjT/CigMBye8tMQoSv/B1N7gm2g+3DvqSZiTIylRxnKqAns+SZ7oulV
 /llMHVrtjvDaWkLzCvo/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XacmrmYyPko=;h5NZ5d0hO2VLLvewvuNljg6jQ2/
 NEyZ9Z5LaWnTcvpnh4GA5WkSnG0NT5mN5/FzGH3QDJSwTgISTVZjRTgm8/124a+guqkU1uoqA
 gRClmVeHKgaP75GNG7lxo7Q1E83//MjtffrxunP6SlEndtBLmX3wFg0EOOmDYsg6IrS3NZlAe
 X3ZfLc0RXBzcxG7LTFCDra+lvk905LesIcdbYWkxYCHRN9iosUdwIU1fPRkyGCW6xcOm2OZE/
 iqE10DF/iO0h9rVMaHDzksCo+WAoQrdLpMrr0zpDoBS+JBuQcVshhOGor4DoBPY+NqRVlGOXN
 GFCxgqt0nygzEbMLzRyjM57YFnFnyDih1LLQHJ9+c/41uLmDWDwGlsayJNg54MVp0e8717FgV
 h/D7BZY2a6z4K7QbmPiAXV4jw2R5Slshk29ZsTo2zz38/oM0ifhj5oQRK7RKnQnottQlvdbbO
 XjZfmF0iTd4apcm3D4cES2gikAdh7mLFkfNIrCBSYGv9WDF3nkfzJ70GScbFAGhWI6HUyrhSU
 V5GAs75HlPv84hIxmqLlMgOZSpzniCGexalF9J/9haWtk3jZiAEnm6JZuj+Mh9UfYWgxoRN4h
 2zkF6+yMtO5d/sdyixvx1Ex2lz3/VIXC9Mug7jWY15fZ2VY592d6kOWjx19AWg3hvPj7sXY1P
 IPv74INqWmuV5ZQylos6qLutrLPfN6wTcbjcrQLWQ/oqcK+g2TE5yLS3dJKp4qwFAE9Jz02dF
 /bAvBb94WrxzQybfJzsQwVcaXyx784TkyIxbqy94//eG0WK3uEQUT8o5w5mUSYWyFscNig6zZ
 O6H+KaiCZ+s/qaG2YMBNzy6w==



=E5=9C=A8 2024/10/31 01:58, David Sterba =E5=86=99=E9=81=93:
> On Wed, Oct 30, 2024 at 01:31:15PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/10/25 17:24, iamhswang@gmail.com =E5=86=99=E9=81=93:
>>> From: Haisu Wang <haisuwang@tencent.com>
>>>
>>> Simplify the regions mark by using cur_alloc_size only to present
>>> the reserved but may failed to alloced extent. Remove the ram_size
>>> as well since it is always consistent to the cur_alloc_size in the
>>> context. Advanced the start mark in normal path until extent succeed
>>> alloced and keep the start unchanged in error handling path.
>>>
>>> PASSed the fstest generic/475 test for a hundred times with quota
>>> enabled. And a modified generic/475 test by removing the sleep time
>>> for a hundred times. About one tenth of the tests do enter the error
>>> handling path due to fail to reserve extent.
>>>
>>
>> Although this patch is already merged into for-next, it looks like the
>> next patch will again change the error handling, mostly render the this
>> one useless:
>>
>> https://lore.kernel.org/linux-btrfs/2a0925f0264daf90741ed0a7ba7ed4b4888=
cf778.1728725060.git.wqu@suse.com/
>>
>> The newer patch will change the error handling to a simpler one, so
>> instead of 3 regions, there will be only 2.
>>
>> There will be no change needed from your side, I will update my patches
>> to solve the conflicts, just in case if you find the error handling is
>> different in the future.
>
> Please take care of that, the only request I have is that it's done by
> the end of this week so we have the code in linux-next and that a fix
> should come before a refactoring (due to backports). Update for-next as
> you need.

Then everything is done.

The patch itself is not touched and already in for-next branch.

The new one is part of the subpage enhancement series now, which is not
that urgent.
The subpage compression write support is already large enough for the
next release cycle.

Thanks,
Qu

