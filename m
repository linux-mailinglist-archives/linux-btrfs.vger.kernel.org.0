Return-Path: <linux-btrfs+bounces-7543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF01960105
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 07:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAFBB22DAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 05:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FA7E76D;
	Tue, 27 Aug 2024 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PX9vqxd9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31B6F2F8
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735969; cv=none; b=WWlPrifkMBfiPAhwereXokibheT5joCJ/Uizm082yq6io0r3d+cUCv3jljSxa0IYADfibhs8JaAO7LPl4rjWhpnZxNKpXtgbWJOCcxaTFJWn3sLxpvW1dFO7PLLLIFdXjPCby4RXn6EB+0/gxULMSfrsB3R0kcpgAyXMwzGmto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735969; c=relaxed/simple;
	bh=ueCMNfu8IZSCI9GQh2Lu5URg0XrZ81Qdf0h9hyD+DUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NQShyioxsYT54YlmxR6D1R+n3ymDiTecfiSJp5aRCijngBOyRa/g85Dmxohrw/658ntKb+hxZ91k5wCEyLYXaiM3Ds6diww7MCC4p4I6OXhmpf3sCwdroFf5x2R9vSGie8zdGGifu32tqGo4WuIJybhz45moOggHnFh3hqVojRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PX9vqxd9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724735962; x=1725340762; i=quwenruo.btrfs@gmx.com;
	bh=ueCMNfu8IZSCI9GQh2Lu5URg0XrZ81Qdf0h9hyD+DUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PX9vqxd9p98fd9GfxW+x3Mu+G2+zoHzcbo2LQLlWw3P1+7rvwGk4leb1PSGRJzqz
	 G6xF+yafpSxUI8PEHfjDy+vNj90iz1WiaH8f00XHv/UUeS1EnqDk0IYwZqlUjWKgd
	 rqA53E0gtKzZc8AdvKfSCzgK6S+FMr4SSF+K7AFG6gRVuVxKtS2i+FbF9dqGGC7m8
	 vDJXA0XvkkTn6S9okb0sVWGD97xQ1I03ZbSdjbHweT4ZQymxxc8T0/drKahGFf7yb
	 CMQQcjtat566cQwfA5RWz16V57M5Dfz5u0tYviH2SCIyvDVb6dFpiY5xyFqdKbm7v
	 YR6wzltVUzENZHdh9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1sYXbI1oJB-00X6xd; Tue, 27
 Aug 2024 07:19:21 +0200
Message-ID: <6f7117dd-a9ba-4c0a-be4b-6adae1be98d3@gmx.com>
Date: Tue, 27 Aug 2024 14:49:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
 <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VQpuS7NrUFiRyh1NW1AmyKJVSLV1A3qsBeQOjHMOS9Xl3N0TrzR
 Z0C5lkgh/BL0ybgMcbtddmgjfW7lWXC82/GwODOEt92hdxcrr04ae+oc5ycthejbq4IDMKj
 w8gQE6TCCO8M1Bw+ffwM2kSa3WQVueVpvQQj1vqxknCWr/oABwkARIH1RvEWihObxhSagyQ
 nr0SchEiVXKx0MPnZMWYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7F/E3k+F9Sk=;sNi5TR76nT2hoWtSuF0n2z6+sYi
 uK2oJH/bwu/XTIXuEO5U1SQFoXVkpOan5KRmYYbq3wvehzmoPTYR3p+Q5rWIHBDVCBk5e8iJs
 wg2izaByFD72OrjXqjOVPsZZHI+QpSr1rNwa6yplasXOmWSi0lcFSYh2tgp90fRJciGmqTt5+
 hur3fpuVZBrgv/f7g/Uhn7mqtobPXzpqCLYgY9IgMDjp6vWduxdyQjNdqOwWWM6YtwSzNRwlm
 UZK790dG8rssyHgbPfTqtKf5nX4MADZeh3zpxvy5BapogBB65/PQV9eH8iOcEoxVf62jSQEK6
 60sAyhN5cK8E9hajO+r9lxmBkvt6JxQCFoPrWxoeghyX8EAxDgm66XiXk+9z4bOdYuTeH7Eit
 mxj5Hj4TExTJelLBz5U/CD/zOZkPoFkevfOppPSayVA4lOIreW5IYzbvcyPuVDYsnNPtxJVhb
 2bnDQEoKuVhMvi4q5tJaf2WiSBu4lxCqx1kUKY3/LQ6VfvtNCrJULpa8TFqxAUAE24EJM7XKA
 eIZB9R+aUICZUP1QU7GMUJNnr/ggmh8G1TkSL5pepw78RUnYWfkHrChoCuP87RrkgmXX9haKk
 B1XTJthPwvRhK8zxfPiGWTv0ZZIHgURVHT+rFSk6TfYMMgmgYla4UIoMgcCRH+gemfE+njUSl
 hhB0Evzvtv5GGX4vdzYvEYQ+Nmz0j221o2hi8Sm7cDxPtQb2egcnCYwuodOStaHJ5KMqu10Tx
 rGdPEhzU6CrDzA45OcN6zlpbBAv0rp6LV4Foczs2qN118So2lbov9FL0RmHg7VvFEeL+g1bVI
 rySddIW/IUNTV2jSbVOkyI9Q==



=E5=9C=A8 2024/8/27 10:17, Pieter P =E5=86=99=E9=81=93:
> On 27/08/2024 01:18, Qu Wenruo wrote:
>> After your latest --repair try, the fs should be more or less fine, you
>> can try remove the offending file.
>>
>> Just a minor problem left with the superblock used bytes, that can be
>> fixed by another "btrfs check --repair" run very safely.
>
> No luck, unfortunately. Removing the file fails (automatically gets
> re-mounted read-only, and the file re-appears), and btrfs check --repair
> fails to repair the super bytes_used error (output attached).
>
>> Another possibility is, the fs is old and you just migrated the drive/f=
s
>> to the current platform, but I doubt about the case considering the fil=
e
>> is some browser cache, which shouldn't be that old.
>>
>> Just in case, mind to try something like memtest86+ (UEFI payload) or
>> memtester (inside the OS) to rule out the hardware problem?
>
> The fs is only around 1.5 years old, it never left the system. The file
> was last modified on July 22. I'll run another memtest.

Anyway considering it's not going to be resolved by repair, I can craft
a dedicated tool, if you can compile btrfs-progs.

That should fix modify that specific file extent (root 257 ino 50058751
filepos 0) by changing its on-disk bytenr to the correctly.

Will let you know when the tool is done (should be pretty soon)

Thanks,
Qu
>
> Thank you,
> Pieter
>

