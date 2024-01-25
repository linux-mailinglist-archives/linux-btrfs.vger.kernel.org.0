Return-Path: <linux-btrfs+bounces-1776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A183BDD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49927B31E21
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C131BDEE;
	Thu, 25 Jan 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GGRueA3E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67E1CF95;
	Thu, 25 Jan 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175549; cv=none; b=ZpSvS9UF/h3zkkcIvumA5BV7XzQ7L0uks9MXGg5dq/8+PObdiB/g6BEPPQz6jINR6N/UqFbxfyxiLqJ7VbHIpmC7unnTpHzG+DY3oB0CaEXpxSRcU+99sRzHLjzGgVDqTzHw/rxWhyoCOEbEBEzb1miG6D5bmS3GzUji/pD304U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175549; c=relaxed/simple;
	bh=FneVe5TmqfUlCW7s3vSev2G+8n4GIBcMwrnxiCW5Axg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/Uw7Zz33rryllQcYj9FrnuGrrwRYwTTCYDt7rM9OzQIdAGXB5gtaL7IlCx/KTZbtoRd5gJB6PFV9mEgbRao7+2NJaY0qgFqp3q43Mi6mZhej4RmFypk7CIZIN90V9bKa1O5XOVfhs9B01COcr8INYTX4Z4Ao3JVXs4FFQnBYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GGRueA3E; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706175542; x=1706780342; i=quwenruo.btrfs@gmx.com;
	bh=FneVe5TmqfUlCW7s3vSev2G+8n4GIBcMwrnxiCW5Axg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GGRueA3EL+CzzKjBmNo8tYjwxXVeyG4J8OqILMZpf3/35HXLzUEaqkH8jcfec/tH
	 Ah4YaC9FDbxaBBRX0rcEFSuXFm76lNzcuDgd1Ru63VctCyI9sWMO0164Xx65T95z0
	 lpNAvAITXR3NaiPFP7vU8QdP6+Dn6pVbEQyOYO1OR1dhlx6MXu9zwSGRPBycu+YuI
	 3wFxfzWkvs/TLITRhTdBU8FvNmJIybfDKW+LZGhNqdE1TI8Cx0nSjQ279H4WyvK8/
	 WLC1KvsNPbQJjfjscbWLoaa4p3PLvkKYY8bDMUhdoN4ZJVC8VB/J8dQbldDmMT31K
	 8aiDKI7IIqFSVgXNyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1qobhA34Zx-00llF1; Thu, 25
 Jan 2024 10:39:02 +0100
Message-ID: <738c8d76-9f7d-4503-8ad7-ba1d038e33ab@gmx.com>
Date: Thu, 25 Jan 2024 20:08:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] btrfs: fix infinite directory reads
To: Eugeniu Rosca <erosca@de.adit-jv.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 Rob Landley <rob@landley.net>, stable@vger.kernel.org,
 David Sterba <dsterba@suse.com>,
 Maksim Paimushkin <Maksim.Paimushkin@se.bosch.com>,
 Eugeniu Rosca <eugeniu.rosca@de.bosch.com>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>
References: <88ce65d61253e3474635c589a7de9e668108462e.1706153625.git.wqu@suse.com>
 <20240125093504.GA2625557@lxhi-087>
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
In-Reply-To: <20240125093504.GA2625557@lxhi-087>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S9qlyXeGM7wCpRNPJENLiHK2adVIuJeSgy8yyVWtjZq2LVUaA/G
 u6dLOF1lKDiC9opLKS+4VHtaD3vouaJawFAjl+GiD95fpAwwa+BPl2H/NW5Sy0nR9ak8cZh
 KfBvsxO/H5u8cE86LSRQ1Cp3uEGipUoxyMRToFOj8FFtnmMKDtShQtpegezMXxoe4dikVCU
 BjNrMUzdBqaWZfBJyx/XA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5uXJoBO6ZHg=;ZOQZ51MMYO2VavS7ELt1lPIenfe
 7YvOB+e1yMnpkvfAmV3+h9+3E/uXoYusvos1iUqbse/3xp6ECf87NZGGeoEyJMK9We2hOFaSA
 exGhMnJTBUTTES9b0aCRzEizJHei90yMohcJbSoQVVX5oNcCzE6my1/hrcdzIzXkUcPtIA9A+
 ue4Kxm81OFFRDHm3kGfoeEQ9Ry4vCpDyJUSF+JHmFrbITO3efyl2tmKmmiK9zV0e4rRGHG0kP
 GX/StpY+pyGVmeB6cyGFhqCGJnJElKlrHc+WOcN7cioT6YFZYzZOaS3JRIpORwgxLuNUTLZHK
 qTcSW9aQYCKju5/ba20MeWchcT7A4wNG+kp0KhS6zxeUmlgepnwuEcXZbcwlLobL1GPo+3fWU
 N2fXMP/eye9liGaoucxltzecSiGv1R70FibL7nnusbDrXCHrQs4LbHTA5wZvw1Hf5isdTAvbl
 17FiamvHTpXLv0/Yw31fCN2Dtt4Wit7Vt2OTqyYD4jKXISmV/3ak5aa89+Hh5LgnO6MGcPUt1
 hVq0JAVcbQjG6Kq17G0htlBRqJv3xFVBdvEsOtOUm73L920/2UhUuxyVTCm7r0Tbyrw/58n8H
 G5Nrt3zRnx+SeIaAO4sjNPMctJDIyFO7MfHJ9CBrbWbFf/2YUZi9L0VhcT9TTV8JSYpEvLcLM
 wQaf4pYOUIi2jBDhajdNhP+F+EbCIXulE2MunamAa2WOXuBIbn1YIhOvDh+ngnj2Ag0L1JfgY
 Ca5axx6k1Ca2KK7ZeLUTAmXHfvG0zOD172SyXrNMiFyLKTvIKoMBZWJAxeCuYyhUz8zXKrbwW
 /r193y7wouk+bQQ6YKuNB2eWWskmUb5bPCqHtIw9fX0fBMdWBZ2tZAcsMoPG+kUNz8gv3HBsq
 ltfkxHAuJ57hBSH5461WCWlCKjNcNYPpDmWkSZvVdPfDALuDh7gQqqguGNATit7gGmARqkXZT
 xKq1ZLdXEGXa35LGR4b/e84RtjI=



On 2024/1/25 20:05, Eugeniu Rosca wrote:
> Hello Qu,
>
> On Thu, Jan 25, 2024 at 02:17:08PM +1030, Qu Wenruo wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>
> Many thanks for the backport!
> Conflict resolution looks surprisingly clean!
> Please, give some time for verification.
>
>> [ Upstream commit b4c639f699349880b7918b861e1bd360442ec450 ]
>
> PS: Not sure the "Upstream commit" is the right one.
> Should it be 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 ?

My bad, my clipboard has over 20 commits (all from my failed full
backport attempt).

Would fix it soon.

Thanks,
Qu
>
> BR, Eugeniu
>

