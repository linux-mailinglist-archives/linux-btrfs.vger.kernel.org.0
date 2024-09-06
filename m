Return-Path: <linux-btrfs+bounces-7882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A094C96FDA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 23:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0791C23007
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438215A863;
	Fri,  6 Sep 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aPV9XS0A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00298155316
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659756; cv=none; b=Hn6yDsRZnlnxxpt7kiuhrzNA5j1HLL4xper5cItMB62QPFXUFjKsEMtUIMraDiXt9jafExacEah4XA6+rF4C17nfoJZ93MCxc1L7+MMr3WSIsFjFjsuiW+cnCIJEQIis7GfVWfxTQxyAd+lIqYrR11qJs57nlpupyXCg9s4xpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659756; c=relaxed/simple;
	bh=d1FT1OnaN8pZV9lrlSPeWjwXZbvRFlnclCCYMg0wJpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZXq7z9l4SIOlJFvOkax4/V2WTs72KjJFzIiqn+x4oQpsxOItm+IXs79O3Uo3ZBjrU36ZTj9f13lmpOTeO2UpDZKWkmfawYa/FzWGGH+lMWeEnvIRPoFyhfoOv9jVniinUvwwhV678mAwqawJu5z1I0ar1Pf6QAvu9uny651jZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aPV9XS0A; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725659751; x=1726264551; i=quwenruo.btrfs@gmx.com;
	bh=SE16lcDWrqjp2f1/XheJS3E/r7CamnL14pB4DmGG1AE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aPV9XS0Affz4VE+nPRo3NSq/hsq37pXKUFovkMNpJaCraakntG60rpco3W/fewJD
	 Dw8wGX+BPqVQCWmrl0/6sJ2nvYZQtkimgmd/Sz5qVxwd7AZW1XAgpPWzVsWUiek6p
	 WhcDH/3Hs8jI9UBEj2uu91qq18pWxhXMdlP6yzccgEQHdugpZATYXxSV8GTo+1ul5
	 YhBf97Mm/tMhXei6QOHKW+J5GIJKBlYSjm2Z2FXfTUThHDAs/oecbtv8JV7HYUMR3
	 l84W3CjHqSxveEbXK6gYQ67IyCIlwWY2KNknQwB8xCokMfGxkMc6Fmhclc5rVfDXA
	 Eu6DHZxJUFQXVaZCzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1s70Sl0ILw-00npY4; Fri, 06
 Sep 2024 23:55:51 +0200
Message-ID: <6fc7b8e6-ae80-411b-8313-8e89d2c3a6d7@gmx.com>
Date: Sat, 7 Sep 2024 07:25:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSD stuck in read-only mode with call trace and itemoff /
 itemsize errors
To: Brent Bartlett <brent.bartlett1@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CACSb8pLWjCPBvfYNGqFQ_6V06SFSqdm-Ea=SC6g+D9_=qygvgw@mail.gmail.com>
 <57d77231-4d07-4773-93c4-0f27bd9a851c@gmx.com>
 <CACSb8p+PLVhF8iKDjxr_jD+q8tAuG99NdF7Z2EQ5UZQqt9aJ4Q@mail.gmail.com>
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
In-Reply-To: <CACSb8p+PLVhF8iKDjxr_jD+q8tAuG99NdF7Z2EQ5UZQqt9aJ4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mFMyV9I+AE5AtDj/o1idxuaxshIsomvoVfQ1cDlCoN56aZVMNji
 //mNdultT2AuTplEoTklaN2Y2d/HAHq0LwuaA4tRCmQN6XzkNpbXPuQmE+W/+IHpKopKMbI
 ABgfwVLH5KKJXhANXjkrUInV57TlzDl1UZUrw2Ti4MzqYx/NBFEOfYcWAnCna8h1tCGDPck
 BU0zbxpQv9H7yJjV0eS/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+WPv8zsqVOQ=;IAxc6XCNYCUrZOXTE+WDBWoqj4I
 hnjtzq8yzMPaQrA/OUFv7RAklnboqFwGye8BQ1/jkqrDEzFxft1jSkONhtbsZphwjXrfubckn
 pGwiPPWQKlrPH+Y+3DD89ebhD7EmlB86zpTX/gzRuAoHbcWo4+CUNQkLSyss/K/c9UjTnhAmI
 0amqSTyMrqkLCuMCmqusAilxDViKPcd0nLrhH/sOx8dHaePdhDM8l70ocwZII56HAkeRxs0NP
 N+wMTlJSSqhEH1bpmm/ygJ/5mz1HyuuNMwstIKFlr/QUrMfvmVbvLDaOYQRyfr7hpnzodafPi
 b4Bs/bQYjnQNf+8z6+0wFrPS+9STHhPoOMTItf8MPf9OUWydl3kyRuHXF4nbTWfBbQgNV7IZ6
 L9ensD5N1VykXi507/597VdKDnXM0jd4cp3fgGnAi9nQ6jT7YJmNdtPuzSl981C8K8Vte+w9s
 40jtFd0yE3D1pS51B0q5s7hm2s9F3CAgJQEElZY4ofprihGIMLVkhOMG3Z6z5pZ573dkFJY4f
 XkEWRG3Jk+f8l5IZ0ghrvTnTBvFgFNApHt2gdBas0qAe7ycRJEtTfP2MznrtK5JlBkZebXUts
 Cs2ULRKp9HnxSZ/ubxcKn2GFpD5c8WJf/9eS6XOCuu4LF6Hb8cXV5cnD1mK2jG1RpdOj6wFBn
 7aFO0TLR5/JiCmTGdzsVK85Y/qM7Xey37By6Z3vedQ0kD7oQGVnIAwjUSpx4FEeKX8lN5WWD2
 1U48ch6dJmwPmBI2lPYmLZX/KRZ8fLS8cl9+YF2PHV8kQf2Rb4CnpaU84Bvad89BwinpHkwCt
 OY/2ugfUa9vqOGhRZifn4WcA==



=E5=9C=A8 2024/9/7 04:12, Brent Bartlett =E5=86=99=E9=81=93:
> Here's the output from btrfs check --mode=3Dlowmem <device>
>
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
> [1/7] checking root items
> [2/7] checking extents
> ERROR: extent [228558536704 16384] lost referencer (owner: 1281, level: =
0)
> ERROR: extent[335642972160, 4096] referencer count mismatch (root:
> 257, owner: 9223372036856479121, offset: 305790976) wanted: 1, have: 0
> ERROR: file extent[1703313 305790976] root 257 owner 257 backref lost
> ERROR: errors found in extent allocation tree or chunk allocation

So that's the only corruption (at least inside metadata).

IIRC "btrfs check --repair" is able to fix that, but just in case, you
may want to backup the important data first.

Meanwhile I'm more interested in the memtest result though.

Thanks,
Qu

> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs done with fs roots in lowmem mode, skipping
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 771521245184 bytes used, error(s) found
> total csum bytes: 750323744
> total tree bytes: 2901278720
> total fs tree bytes: 1938309120
> total extent tree bytes: 166903808
> btree space waste bytes: 365206037
> file data blocks allocated: 857740091392
> referenced 855826853888
>
> and here's the output from btrfs check <device>
>
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
> [1/7] checking root items
> [2/7] checking extents
> tree extent[228558536704, 16384] root 257 has no backref item in extent =
tree
> tree extent[228558536704, 16384] root 1281 has no tree block found
> incorrect global backref count on 228558536704 found 2 wanted 1
> backpointer mismatch on [228558536704 16384]
> data extent[335642972160, 4096] referencer count mismatch (root 257
> owner 1703313 offset 305790976) wanted 0 have 1
> data extent[335642972160, 4096] bytenr mimsmatch, extent item bytenr
> 335642972160 file item bytenr 0
> data extent[335642972160, 4096] referencer count mismatch (root 257
> owner 9223372036856479121 offset 305790976) wanted 1 have 0
> backpointer mismatch on [335642972160 4096]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 771521236992 bytes used, error(s) found
> total csum bytes: 750323744
> total tree bytes: 2901278720
> total fs tree bytes: 1938309120
> total extent tree bytes: 166903808
> btree space waste bytes: 365206037
> file data blocks allocated: 857740091392
> referenced 855826853888
>
> Thank you
>
> On Fri, Sep 6, 2024 at 1:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/6 10:29, Brent Bartlett =E5=86=99=E9=81=93:
>>> I have an SSD drive that was mounted by the system as read-only due to
>>> errors. I have posted my full dmesg here:
>>> https://pastebin.com/BDQ9eUVc
>>
>> Great you have posted the full output:
>>
>> [   36.195752]  item 123 key (228558536704 169 0) itemoff 12191 itemsiz=
e 33
>> [   36.195754]          extent refs 1 gen 101460 flags 2
>> [   36.195754]          ref#0: tree block backref root 1281
>>
>> This is the offending backref item for the tree block.
>>
>> But what your fs is expecting is:
>>
>> [   36.195988] BTRFS critical (device nvme0n1p2 state EA): unable to
>> find ref byte nr 228558536704 parent 0 root 257 owner 0 offset 0 slot 1=
24
>>
>> hex(1281) =3D 0x501
>> hex(257)  =3D 0x101
>>
>> Another bitflip.
>>
>> I'm pretty sure "btrfs check" will just give the same error.
>>
>> And this really looks like something wrong with your hardware memory.
>>
>>>
>>> Please let me know if you need any other information. How should I pro=
ceed?
>>>
>>
>> It's strongly recommend to run a full memtest before doing anything.
>>
>> I'd say your previous RO flips may also be caused by your faulty
>> hardware memory too.
>>
>> Other than that, please provide the following output on another system:
>> (The lowmem mode output is a little more human readable)
>>
>> # btrfs check --mode=3Dlowmem <device>
>> # btrfs check <device>
>>
>> To make sure if that's the only corruption, and we can determine what t=
o
>> do next.
>>
>> Thanks,
>> Qu

