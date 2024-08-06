Return-Path: <linux-btrfs+bounces-7017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD0949B91
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 00:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6486E1F23EEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 22:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4695B17556C;
	Tue,  6 Aug 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mTAtigSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8E174EDB
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984670; cv=none; b=WMkakIRI1oxF/wNIqdtlC/n6Wtl0KG2Af9aJGwDYt8VbZGAlxEFpPZURkiXHvXnQDGnYu+ylZBkZy1xmLwqMo2LVNYivHHKcWk91wKjlQ+hvNjZANLAgu2Zq+SCJEmtz73r3E92SwW1nLj42LP7lPNpTGDw61XZYuZgc6euEEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984670; c=relaxed/simple;
	bh=6yvECedMYTdu0SgSiWFL+oSTzQXiPMTsbbFHYPAcjk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jo3ghJJqJjR3djYMY6kM89IvNFeZLT5ufCbjYdpU9uNZeF05At4XH4gKppHqjdn1xHC5q/xPeVraPPOl20BGfC8msiITbzxvvqDNIe+JRQ9aw26qzlOEafnBJpAUU0NAlFnRh8z4lN9h8v0kPeaOTlb4QzlqdcoQtNOM5XTuNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mTAtigSB; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722984665; x=1723589465; i=quwenruo.btrfs@gmx.com;
	bh=6yvECedMYTdu0SgSiWFL+oSTzQXiPMTsbbFHYPAcjk4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mTAtigSB9fxGgWEC35KbDo5CFuU3rj1ApzSgHGeZCcwuq87vFL6S65+05Qhkit2u
	 pN6QCWP4xFnFq3OQvnYi+8N25kqPKTGQ0q0TQKFmM5Q3hrATuIghia2zT7vd6sd4E
	 Ouxe2XVQ9hD11LACnSdQCWc2x2r1/zeRRfEEXXpO8KTa7NHFV3dEEt8CjpX/xjmuY
	 s4kugY9LfpNbspg90l8ai2KVAGfQoMmaS3sjTj6qB8BAuKErzmXQnylvEhTWmzP6o
	 qaOoQq7OSwcFSpjSg+S3nAhsV2wtttEVIWto1vLCpBYrXm9JHY8DMQNHLbXCwg6j9
	 Y9dsQiM3FBeXddXY2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1sjUQ92UbV-00Q7HZ; Wed, 07
 Aug 2024 00:51:05 +0200
Message-ID: <05767a39-e59c-4615-b693-774976bd54f1@gmx.com>
Date: Wed, 7 Aug 2024 08:21:02 +0930
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
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
 <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
 <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
 <30687f37-32e9-4482-a453-7451ab05277a@gmail.com>
 <55a368af-ab0b-4bb8-b61b-53d20b163d63@gmx.com>
 <a149ff05-73bd-4232-a532-8c5efb4a69e0@gmail.com>
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
In-Reply-To: <a149ff05-73bd-4232-a532-8c5efb4a69e0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pgDEqhUPcLExup0QjUDH5gG/9DiRQ2yA4oBM9Ai/svyvLF2Ogzg
 JqGBDfRT/lDdJ8jOyytS+ZWRngXnQ7dD8eZRnrfJhG7YivlQYI4XoQapZILItuvrGLF5V29
 580VLzvXT3qSffMEiaxKRVljsIKrbqUUnBJTYu2UAptCpSzgXlz0un70GoKfIq5Am+ReYUt
 s/S+Nvp84KyPgQmsvoYLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O6DbS6PLv+8=;z42MyIVJDyzI3HCI8y2H+ggHM9o
 4HsF7AvTeRVg0H3Ji6jRNK+lJLZ40JJVWwb5oKcoQB4iss4dUFde3exImClezz9RE3h9kzcN5
 hvGVF4BrZf4K12Ua8EOF49sdXRt1aBh+ievVLB5Wvx550aTCFkXGa2Xu0UXFhIdnb4HDFgzpq
 8BGPRGLZYkUxjz2UcVCt7AmaiGKsx1gTZaKHJwxYeW0I4Z9ZZdY1Jo/CnhJ0PrvzxeaqSXy5I
 RFh3l2YoS0lXxUZp9GdZUwUIULt8hKRNS2QDQc1KDCvlQRb9GYgKdA0EuT2KKRVUUT5CSjR/0
 XRZA0Sgq9fo5st4ukpE50QzLj3eTaekDZs9HStrvef7JeLl2OeLp2QPysgv6rJjYF3CFYQzXT
 e1VOhy1DMRkmltTeOR0Qz1tXyed3WnvSr85yBGWgmS9BiHxyeo7snUZxsjuB62TgnoAQrhz1g
 Q57mZXczNEZ/1eRaQZP9fIXL6KuqncF309ZUov+7MndEilw9OqpsVF2EOyrIztCosZUq9E7r3
 GIHUUOtHfKIebYik0MoSzjwYBG0jEaRxtiqbzDOMulK+6DAVfiU/9ce8WSS+JG0hvBU7twcXw
 1HGZfx6bh04ibr432UReh6QnIDgL7oemTohGUFEXEXtIeSz8JMu02tuIqLFKu8oxjvwaxlJa4
 2cReP8vWCbhEVRtGFRnLMrKkzjAoHDEeMSR16k8kjycYe6J4Tm3pojdE63Wq8Vib2qlXCV9yR
 EGqjY51QTTQLF/M5GJ15TKbyV0uwHG/gbLfC90Ny7Tf96ypZx0Mw99gP2P3WvRRDiwD8vzRrj
 mHD8TDnoqQcEP6Wpn6UQ63bw==



=E5=9C=A8 2024/8/7 08:12, Hanabishi =E5=86=99=E9=81=93:
> On 8/6/24 22:10, Qu Wenruo wrote:
>
>> But you're using btrfs for its super fast snapshot, and that will force
>> data COW, causing all the complexity.
>
> For me the data checksumming is more of a selling point. I.e. yes, using
> Btrfs in a NOCOW mode kinda defies the point.

In that data csum (and COW) case, then I guess one has to choose if
preallocation is really wanted very carefully.

Or it's super easy to cause unexpected on-disk space waste.
(COW is already going to cause space waste, but preallocation amplifies
that much faster)

>
>> It means, even you have written 10GiB new data, as long as our
>> transaction is not committed, you will only get all the old data after =
a
>> power loss (unless it's explicitly fsynced).
>> That's another point very different from old non-COW filesystems.
>>
>> Instead "commit=3D" with a lower value is more helpful for btrfs, but t=
hat
>> would cause more metadata writes though.
>
> What about "flushoncommit" mount option? Does it make data view more
> resilient?
>

If combined with lower commit=3D value, yes, it will be data view more
consistent with transactions.

But as usual, it amplifies the metadata writes, which is already pretty
bad for btrfs.

And may worse the extra space usage problem too, if using data COW (as
it forces dirty pages writeback at every transaction commit, causing
smaller writes)

(I guess a UPS would be better for everyone except the budget?)

Thanks,
Qu

