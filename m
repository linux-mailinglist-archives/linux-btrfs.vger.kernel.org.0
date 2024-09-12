Return-Path: <linux-btrfs+bounces-7969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51D9766A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 12:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34022837AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49C19F43E;
	Thu, 12 Sep 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lHsQwdOn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099019EEB7
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136648; cv=none; b=JTk0y+Ydckf8eZ6W/c8hbZwmvoNqf11E0vS0ltvDnDFU5NUQ1ZkoJ2RCPgDP4Dv4aN+VbrQj2v5t22Yw5ussfQg2HTfRsgWXFQXjegbTXbMhhDy/on0U7tncUxIJuhynN662R/zK6fvY0EMUCKE+GER8STWVKlUh2Q/2Uu0u0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136648; c=relaxed/simple;
	bh=/TsYjorc+Kd0YODs6W475jiGtOZxU6f4SJn/uoLaDQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jc7Ua9D+FMxoPj2e1BZRXY090oBCOM8FP5QZMoebjENVR+IA+z+A3MndkW93ATKQ4RXWhPFf9xVVOZr1wP1keVMCN8ZqACp2DqAp0XPPTJeTQ4W09WQYHOe1U1wg8gRblN5Z7ebSjpIImFlaB34/lUFOySspdsKl0W/8nPCLBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lHsQwdOn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726136642; x=1726741442; i=quwenruo.btrfs@gmx.com;
	bh=/TsYjorc+Kd0YODs6W475jiGtOZxU6f4SJn/uoLaDQk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lHsQwdOnkCx2MJT7GawzekwBf7UcRp3NHHqpVGtHV5ZMFhAYH27SQ+iukLHIdrGw
	 aZllFHafrDDj667KTqZlVV2FZhcIegUiySQ4kvXXPjUuYLQVvh+NZqKhuDy9rf5ax
	 pb8AoBiUPsjPMp0VX31TGdm+Ukr4kwZe5zns51dujWXGPVoOBXIPd6to5grZVWEj4
	 qK/SkwE6yeN6b2+gm0pIXHj1WDPQLdJZfDL+1gL3mtdKO2TFUxtepcS3cdr64dkU2
	 aEIQ0IJSPm4rgHnoa8T0hVITJtDyo4+eBFpmvkvvB9f8xbWTxJHylw8l4K57V9juw
	 7TzHyDWQBCW+Tg1uWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRfl-1sHq9I1gan-00j8Qy; Thu, 12
 Sep 2024 12:24:01 +0200
Message-ID: <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
Date: Thu, 12 Sep 2024 19:53:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
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
In-Reply-To: <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PiSOuBfMqCEwUyfsHjHxNUtaHLPptRcYzKfxQ+ZxMXRsz268k5t
 6C/nynNDrMLvjkFK3z039F/dhUhN1FubnyR/Yvtos8XVRmcyEy8n4l2e32eRg1NO3gl6Oej
 xFR1yimPGa/lNZWVTYe2lUDURJJdPebEQluXgKDg5bLwxqk7IM7Lqn8RdSSJfeX/kMXs+iQ
 a22o0MYEmfO1Sid3tT8/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/sC2jxhBsaU=;3NdACoTnO0Ogj5T1T5xM5VctYXf
 fA+oyi/965cAxaCIiZ5+XEpYi5LPioYRfKBDOKCYOpZPRPnxa9bb/JfvNMIy9K0K+5ae5aMcF
 yeXq50uqVwFG1B/wwbOHb9UYMHnj0fTnp7wl3sWJARhtVu8exMibRp8Vg/EOTKpe6KAj6oWV4
 mg46woGhLZJmVHOwbLPuB8MLu/nqrjPOMvJbd8wk8Qex3VF9zGBNDBdG7/7L4mJ1a55AYEdh2
 /9zgKgmjRes0pDelj2yvOZbLXFIHcne3DmG7ua9u8rf68r3hH303rRy9/vDboQYpYxr6VS7j0
 BRQupWhjsWhYN8u9brVqVl+6WNdYWZOdJuDW2DcF3XC94LlHbcFI7ON3iwWkgxjEkepvHtb84
 Ww5pQlN/efYw41NimbLF3ViujcP/grYkUVY3npKOvhHZ8atHxq4MMdtXWuJhI9I+aksU27rZE
 1Scpy22gf/lAMY7efq3LzcU9lho4NnXTXMWGPcrd/n9hAr8fVypXjbDb7MT6pyix5SkxkVPeE
 amBP/IaLfeo8xDF5WIt/7utv34IzkkM7HZewKrRnZhX5pItcAz1x2l8OhZnHIS8r9MzTPR4fG
 S77dby2iAmKxe1eo6u9e4Cq2tZzMVfACt4o+WiHbP/ZNkJQSg7JDwrmoRmG+ESLbXbTbJdsO8
 /atNnFcdEltl2gT2HeivFAdX4ipdYlaDtQX7ODODaAsOIcKMRTkRG7TcRGJKRKER91Am+7L48
 MNt4vIAxpr+93ZEosXDFQFayo7ch6Zg81rcnohQMG5tq6VAEf+11fH+Rz974iEtrmVlrmMvLF
 3qZQOuVBrorWnWPz9i2DKN4FibxoqsINRnqG/jvcRcreY=



=E5=9C=A8 2024/9/12 19:34, Archange =E5=86=99=E9=81=93:
> Le 12/09/2024 =C3=A0 14:01, Qu Wenruo a =C3=A9crit=C2=A0:
>> =E5=9C=A8 2024/9/12 19:27, Archange =E5=86=99=E9=81=93:
>>> [=E2=80=A6]
>>>
>>> [3/7] checking free space tree
>>> there is no free space entry for 0-65536
>>> cache appears valid but isn't 0
>>
>> Then it's totally fine.
>>
>> For the 0-65536 problem, mind to provide the following dump?
>>
>> # btrfs ins dump-tree -t fst <device>
>>
>> I'm afraid since the fs is somewhat old, there may be some corner case
>> btrfs-check is not handling properly.
>
> ERROR: unexpected tree id suffix of 'fst': t

My bad, it should be "btrfs ins dump-tree -t free-space <device>".

And if possible, also "btrfs ins dump-tree -t extent <device>" just in cas=
e.

Thanks,
Qu
>
> Archange
>

