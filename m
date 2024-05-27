Return-Path: <linux-btrfs+bounces-5307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DAE8D100B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 00:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587D21C21A8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0EC16728B;
	Mon, 27 May 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dl6J4mJZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F7167268;
	Mon, 27 May 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847761; cv=none; b=hwyXECOG4J132UewfL/yOwgXzzD+svC8TX7tSRv7+SQBuPHtI6c6zZfHXCxLUd0vA87GhF9Q0j+kaZL913dH1BJyGjvsPLES0dA5rfzXV+UqhzfaUVGwVcCw7Wwe8uGopMEGks4srL6o8iETB7+aheiPtCACK8sJ/byaEAwWYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847761; c=relaxed/simple;
	bh=LejF+lbDllU+PLUCkYss+jeUlPDjp0RUG6VcxNTB00c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0p/V0jmchShKSTzhS1ySIduRopCFnT4uhQzUbl1r1IajGHH1JTosFm54J/xz/FeuEMWkkYZ55sSgWY133meP6Jyb1MQEb0dooDouCXlBkQy1ftmWgtgXbauY0LRaysHRRbDEiURqlO0/v51VtjD4hNb5lgLXCiTpUDjoyeXHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dl6J4mJZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716847754; x=1717452554; i=quwenruo.btrfs@gmx.com;
	bh=5NrbD5yDT8j/S9sunqGjgkg3ffPU9cWiimgHKo1bj3s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dl6J4mJZCdTyreXW1JeeQjpvLlwy6JslJ5R9HA0uW8vrQpZ2QO3rW3AcNr5I8xUn
	 Sqw+0Jxsas70/M16T7lsnW+ovhTIlQXIGu81m+nCPAIls7UIMms8FJnMrtozEvmef
	 jsTjFfAAa7PWq/kjXHRTNicA0YozAF2XJvsG53GNmgzWDxBsJ7MOKQYwDd+82+iDB
	 pEmkw4rhABrFZ1bKgdnrs5+3xUeBnnEXD1CSZb/OthG/u0k2l+miQhkgC3W/k0PFw
	 w4QGcFAIjIuaacMnEOJrJeQPgH7PlUJiSxzIqZziSKPIg85h8mIhatVjeYoKTghB0
	 9OegvTj8Cr8yKeIRug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79yQ-1sZ4sf1Upo-017XE0; Tue, 28
 May 2024 00:09:14 +0200
Message-ID: <a24ef846-95f9-413d-abfa-54b06281047a@gmx.com>
Date: Tue, 28 May 2024 07:39:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zlib: do not do unnecessary page copying for
 compression
To: Zaslonko Mikhail <zaslonko@linux.ibm.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
 <08aca5cf-f259-4963-bb2a-356847317d94@linux.ibm.com>
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
In-Reply-To: <08aca5cf-f259-4963-bb2a-356847317d94@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38KOF2XBhgcnOElfLhrhwKqhUdPmn15/7UfViG+KAVis31oiOgi
 bJxx11oJBj5ATI2XGS4W0WOuAggrdh+nkLZEvfgEPxWkwDT+q6/7MD7SvauRSgoH0KBm9/M
 xP2QZ5kUzFidpmBcLDQ1qtPtO1+kInBJ8axSd/hFFuq5D719XsH7Rw7WwszpS2du+5LYHhw
 BhBYxoUBR91vFz8DXM4fQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ibswbUFPcJU=;vdFSdoNXbw9tBLlN8yoWQ9M+ksa
 LKCEzic7Aq3FTMPVVBrf1hMbdLpBqEC7Z9xw51PaB8oAsYrWCbTjnpdtLALR0U2i4yrKnzuO9
 4CRVsVeIKQVVCi1VvR0gv+rrwA7eh+wUalGzL3iJlgpRrvGYTctzxiplAwz2bf2n3n7qR7k1F
 OCo0YTMif+My6dZvozbWT8YQk+ls0aMlvHzqHMiy4HLgYuoXpJQQBA2ZxFzqeW6O3MK1JOORh
 DEw7+VJf56T7JXM3oEol0N8E4UDQHenhZ1enh6gMrl/s44/IuZAdZfb7e42YSH5M4mRYQ7sE3
 nEYctlFrMdudq76ro3VfkyMSzpOjLPqKEY28iOCUjxcZjPZdcRrCHtjZEaEwgDCr/ABm5GYcZ
 WdetopLzPCJDoI1kgaT9IbTE1hpilzSAJKcK5OxsOkbHjHTr85zrabSxDoOrxIN2zxuP8qOi4
 BA0IARhwwx7V4oz8GRwISsVfRnyKYTlpOGGh1t5jF7WhZJFlgJDH5Vmb+UR0nfYZCS8BXR+pJ
 DDerd21YZTIlRVNmpuHHd8UmffKn4l37W9Am4dmPeNrt3dEm8agPGZ+mwbCdN+uLKrrTNgK4n
 vxa3xcAUC3w2WdzMwTj3ZW34RjCLJqddEpbVNpB0OhcnNs9VC8qkTowzHbyeq07WrsoCifBcG
 GhoKCEAAjuJdatkdZUdrH1GAT4n6CxDpu2SQTRZmgKFb48vL1/P8SdEYpBW1v9X3BixXVWoRP
 3IxOo9K0tqLUQsBguJN2lEueK6khMennTsBbLp//FL3TMGS9akBIaDVpMLSuJQkF7i+/pWGZV
 +nWf9FZKxEL9FcUsKlQXHqZR5/FCUln7bqtDUHOeMjE7A=



=E5=9C=A8 2024/5/28 01:55, Zaslonko Mikhail =E5=86=99=E9=81=93:
> Hello Qu,
>
> I remember implementing btrfs zlib changes related to s390 dfltcc compre=
ssion support a while ago:
> https://lwn.net/Articles/808809/
>
> The workspace buffer size was indeed enlarged for performance reasons.
>
> Please see my comments below.
>
> On 27.05.2024 11:24, Qu Wenruo wrote:
>> [BUG]
>> In function zlib_compress_folios(), we handle the input by:
>>
>> - If there are multiple pages left
>>    We copy the page content into workspace->buf, and use workspace->buf
>>    as input for compression.
>>
>>    But on x86_64 (which doesn't support dfltcc), that buffer size is ju=
st
>>    one page, so we're wasting our CPU time copying the page for no
>>    benefit.
>>
>> - If there is only one page left
>>    We use the mapped page address as input for compression.
>>
>> The problem is, this means we will copy the whole input range except th=
e
>> last page (can be as large as 124K), without much obvious benefit.
>>
>> Meanwhile the cost is pretty obvious.
>
> Actually, the behavior for kernels w/o dfltcc support (currently availab=
le on s390
> only) should not be affected.
> We copy input pages to the workspace->buf only if the buffer size is lar=
ger than 1 page.
> At least it worked this way after my original btrfs zlib patch:
> https://lwn.net/ml/linux-kernel/20200108105103.29028-1-zaslonko@linux.ib=
m.com/
>
> Has this behavior somehow changed after your page->folio conversion perf=
ormed for btrfs?
> https://lore.kernel.org/all/cover.1706521511.git.wqu@suse.com/

My bad, I forgot that the buf_size for non-S390 systems is fixed to one
page thus the page copy is not utilized for x86_64.

But I'm still wondering if we do not go 4 pages as buffer, how much
performance penalty would there be?

One of the objective is to prepare for the incoming sector perfect
subpage compression support, thus I'm re-checking the existing
compression code, preparing to change them to be subpage compatible.

If we can simplify the behavior without too large performance penalty,
can we consider just using one single page as buffer?

Thanks,
Qu

