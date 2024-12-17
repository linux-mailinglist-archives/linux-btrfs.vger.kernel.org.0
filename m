Return-Path: <linux-btrfs+bounces-10452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEB9F44B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C483016ED5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562BD1EF088;
	Tue, 17 Dec 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bhCuriys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92D1DA0E0
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418560; cv=none; b=H/1sXu5p7f5oIPfzdKNkQ1m1Uo43nHkjL/W9CTXjr++BZII2NBPzr+apB7gMYHEI4rzi1Tjd0vjlvG+xqvWBkiDmC0fq+1uTEkCArClOfggdidzd6VdBj/CTEb0sbNVz6sHqu9aK/QP9jjwm6gNPJ/4XlxwcpEvNIDvBTBPFya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418560; c=relaxed/simple;
	bh=ILWzhyS7Tq1nu0MTDgDlycxlUI2hkkrg38RikzVXXj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ8FmNSqmsLmmVdOyxUSl3Xwy0pzJA81lJyzQFE2lULpY3EmJq2r4wwCgC6uGS/9Zx6bj/M9FbZePE2wBCpsEb/xwIXeFfidt/iAwGvud6rZYwaX4JETJWeJHVTaK2TjdZsbGYPeLYrQ+y1R7NFah97D8bIwBdoojxuoq6cvIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bhCuriys; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734418551; x=1735023351; i=quwenruo.btrfs@gmx.com;
	bh=ILWzhyS7Tq1nu0MTDgDlycxlUI2hkkrg38RikzVXXj4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bhCuriys9VWWjixhAqWJJSVGX51A/hGhY9I1HYTl7rutnqytqocoBdPi9kTfTsKn
	 eHFtmth2jNYBC0qZ2TkOpi+CSbgfKLxnEi5QlNOQgncgl8Qp5b1MUa0Df+DjlSX6h
	 2hWFsSrdnZX2HDhIdQIbYhWcJwtY7YhWIWlcZ8Emw07Jo8Pz/yD+7xAssiqslmy1D
	 37Vez1vXF5PBiUmquZe2rlW2La7LuUqG/4Awtb1iXP2+CtuK6uoiTDgzj7lF+Dqjp
	 gQD+2QiyGKWkWT/+yQtfz1C8xR2co6Tgbi5NzWVdskL1kLbiS5pHcpdsXMJuktcpm
	 7yEBvCX0zFnnWUxGMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1tqz0t1lfB-00hlJv; Tue, 17
 Dec 2024 07:55:50 +0100
Message-ID: <26ab3ad4-cd0e-4913-acbd-deeaba50f51c@gmx.com>
Date: Tue, 17 Dec 2024 17:25:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: j4nn <j4nn.xda@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com>
 <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
 <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com>
 <CADhu7iCYRjcQ2kHWqvaZYTnwVUY-qFaBSaDyZA_OL2MEpr6EYg@mail.gmail.com>
 <61140354-83ce-43cb-8bb6-fc7b5ecaa1f1@gmx.com>
 <CADhu7iBR-i9bOHRDN-adtWkoF8R9v=kvFhAySV_Fbfk_v8iFXg@mail.gmail.com>
 <CADhu7iBQf_vE3hSoDH7L=eCPzq9LZQyr1R8xDhF-OEXHENkD1w@mail.gmail.com>
 <CADhu7iD+kKsvxZtnX9q94tuJzS6z=zs3B7Xc9Bb4G+mnQ6_UhQ@mail.gmail.com>
 <2e3d5a0b-4cc5-48e7-80a6-7cc5454d54e3@suse.com>
 <CADhu7iDkie++6DhJD7e1Ce2LqeS57VnOhX-fDAhPFXJ13yyPpw@mail.gmail.com>
 <CADhu7iD2U1R9ssAruFVu6s+xvkcAtAr7dYj26cRJ5f5pLNmiyw@mail.gmail.com>
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
In-Reply-To: <CADhu7iD2U1R9ssAruFVu6s+xvkcAtAr7dYj26cRJ5f5pLNmiyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u/EuWn0ewTjGKp8K+4sMm5MK7g8ksGTJNHFVNyF4EKPcSMWe9OV
 ZPVafYrZtCMBWrzYL0GUdV0qk5RC6sDi0zSSd3fr5fq3WsmKtNo2Z7egXbYYDUJgj0jm5CP
 vGwlDQNbz/bW0wGrtVDhBN4HTr4aUzjoFPSGbEu0u7plcItWLguUDjZ2qdYTyjnmUspvoYD
 ttu8m/c2UX39324BgClUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ANVylCqXsTE=;U95Bn+fMRTbA3uk7QCuD+1HZzUC
 oSdUmhueyGQTcIsw0NEQS/NVdYrv2ZyWV9yLQWyRmJCK84/TZrM0j+1pChQWfv6/j5TzizObk
 2mGqLo0yBef7rsQOzw7y+X+sHMbXuY2gRahVki+/WhCF5gIeqYw9o4wCprHtQiI7BJoTlfT3i
 3MSjx4eROAi042CDdyMGinpdqqlVwHHxTjln877rPgxsFjQK+jyquHJw9EYWTE4deN0YtjR+a
 8aeQ1O6s8+ahaplkDrMH9cAJK/J03esHVijCuOL+Tzjv4QOjsOvA87xhtZieKeGoZpLa+X29O
 mYJUh8SA9u0DUsg4xGq6Symsa/Ydx9Ywcu6wHaib5ZjFw2FJcpXyfzzw4Ik7t+4yVvC6GR7ra
 OqvdT+fpzuQxL0Ux4rfn5LcWlpIfy3ujQp0F6LB/FRjJiuv2/yt1O2hxp5XLQwEbvRHHRbIF/
 Rek66MsBh9/rht+62ZOAo4qYHI/KA1lOO2S3hNA8bAnEtVSzwMwlim7nObE23c0aUYt0BORRA
 o6cn6Tl8pjoVawYr+Ks3q34vZ8m4Cum/aaFavRQrS8qRRObgKblmZaT7NOm2JfUtnpiyFzCEr
 4emyJ7lGOS/mjAYuPLbpsh74Eudln8spOcrR5U7eSMeQ7pv6Zk4XewXr+dkdSMr/3wrkYM2IQ
 5d6sd0wm48t/halKd7Xihcbs+IaTqcmC1bJFCyg8U0glb2J1ujVveQIgdmlLqjAvdXWRN05og
 t3PkRqwzDC41sz85lFigUKFJgT0UH2qQ+M8J/xTZnv4iXxaLEs4ARZjj7V7idCBs6oL2stlSQ
 hUMf8eFuDIbXHQeLeffR1q49f+hFr6CJjT/6zRLFiMw87caR75g8LHXcj+BB8kIwnX+1vOLHi
 mICqicD3+jdLd9L3Xb1PKQlrR6XOAC/np5TKDMEKrRREuL7Yw3HFxT3w6sFzVvpeyYLCywYB4
 zeQAoMduJd/CIhnjYzT5X3Q/rHBAnP6BhVafKWbNmJN7NVYgvkSQXXpeYdfPt1QiZUi8S7W5U
 6J3DJZ2Po45vme8ccRa5e7VM1EfYdjCPEaoCIl8ge7q3AqVYQ17rB+jt0pYp+ImS/FMnMnUmn
 SqIqvgwP6A34JZf5odaaVVUvmm7FMx



=E5=9C=A8 2024/12/17 17:04, j4nn =E5=86=99=E9=81=93:
> On Tue, 17 Dec 2024 at 07:10, j4nn <j4nn.xda@gmail.com> wrote:
>>
>> On Tue, 17 Dec 2024 at 06:50, Qu Wenruo <wqu@suse.com> wrote:
>>> =E5=9C=A8 2024/12/17 16:01, j4nn =E5=86=99=E9=81=93:
>>>> On Mon, 16 Dec 2024 at 19:52, j4nn <j4nn.xda@gmail.com> wrote:
>>>>>
>>>
>>> This is from the metadata writeback.
>>>
>>> My guess is, since you're transfering a lot of data, the metadata also
>>> go very large very fast.
>>>
>>> And the default commit interval is 30s, and considering your hardware,
>>> your hardware memory may also be pretty large (at least 32G I believe?=
).
>>>
>>> That means we can have several giga bytes of metadata waiting to be
>>> written back.
>>>
>>> What makes things worse may be the fact that, metadata writeback
>>> nowadays are always in nodesize, no merging at all.
>>>
>>> Furthermore since your storage device is HDD, the low IOPS performance
>>> is making it even worse.
>>>
>>>
>>> Combining all those things together, we're writing several giga bytes =
of
>>> metadata, all in 16K nodesize no merging, resulting a very bad write
>>> performance on rotating disks...
>>>
>>> IIRC there are some ways to limit how many bytes can be utilized by pa=
ge
>>> cache (btrfs metadata is also utilizing page cache), thus it may impro=
ve
>>> the situation by not writing too much metadata in one go.
>>>
>>> [...]
>>> Considering the transfer finished, and you can unmount the fs, it shou=
ld
>>> really be a false alert, mind to share how large your RAM is?
>>> 32G or even 64G?
>>
>> Yes, you are right, using both :-)
>> That is 96GB of RAM...
>>
>> Thank you for the explanations, particularly the "16K nodesize no
>> merging" metadata chunks.
>> The reported 'time' of the transfer included a 'sync' command after
>> the btrfs receive.
>
> I guess the hung task backtrace that appeared during creating of free
> space tree cache had the same cause as this simple btrfs send and
> receive?

I can only be more or less certain on the receive end. (receive is
mostly just writing data into the fs, as most of the work is done in
user space with buffered write).

The v2 cache rebuilding process is indeed problematic, but for a
different reason.

When rebuilding v2 cache can cause a huge hang, that's for sure.
We are using a single transaction to build new v2 cache for each block
group, no wonder it will hang.

Anyway I'll change the rebuilding process to at least do
multi-transactional update, to avoid holding one transaction too long.

But the rebuilding itself can still be very time consuming anyway.

Thanks,
Qu

