Return-Path: <linux-btrfs+bounces-5357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B3D8D4095
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 23:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67561C214E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 21:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC31C9EBD;
	Wed, 29 May 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QhqohDU1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BC1C9EA7
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019761; cv=none; b=QXXAUpKoVvA7VFiQUSVHbGKJgGlp9Xc/f6zPYqjDRDST6fZ/Fkmz3aDiUazVA1pRFEt03bJHbcpGrG8NHhnY4tErd7T0OGWHqp/sps+N/++Yn/8pwQlNTZu9OX2uI49w0u3htN3865fe2nbMa+pFGVHR2tt3I0P6nUB60S60Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019761; c=relaxed/simple;
	bh=X8bxNzZqynfjuXThf70cDd32jraPC93+2lwKwQ4ptAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twIANc/oczYSpqXknb/Ycfp3mPP1NiY/yYcYSRE7rLMwBP2GYNP0TbY9ZLX/F1nw+656mT02D50cKtYo1PdA5980PJLoSCaaO2plLqSjHsGI9KZEKJOOndMtYqFYFdB4K8PENF1ahl+RQKtPQWbzmHNVnkH7UT8qJ8Q/xiH1qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QhqohDU1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717019752; x=1717624552; i=quwenruo.btrfs@gmx.com;
	bh=mznoQytguFLtfUWPI9oQpXb9XH68rz5SCVtl/6arVQ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QhqohDU1eajqkGpKRFsY50zrrMGitY9VgYowqbQt8sJCU5cgeQ+Oxu93vNGDBNLx
	 YenXH/2K5A9csqqOd5BfYn2+HSFv7UtI6N/uJFNem5lGcWfbCozmsXP4akIC3WwW8
	 RzXsLmHmYmz5KjjDMCR0CHOS9OeQaH2G8IbSZgQtbCavR8ZAa/c5b/qyRVww7ZFyN
	 y8RBTgcXKxffSfXtAgMmw6Xczw005HnaeA1inZFB4QBoVknlEGV2vW/xbUr7/kalW
	 a2byv9ZhPwqXTs3ClMWC8mkOspAgVdz40YsxySEAqM4FdqttJ01D5m2kD1nt7z7nD
	 UT5DeiTF4NQRqrVxoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1rsScQ0zQP-00NDQu; Wed, 29
 May 2024 23:55:51 +0200
Message-ID: <932eb368-ce1c-4301-87a6-325458c29541@gmx.com>
Date: Thu, 30 May 2024 07:25:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
References: <20240528062343.795139-1-sunjunchao2870@gmail.com>
 <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com>
 <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
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
In-Reply-To: <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iTuh7aWpqW74C5esqaHTGMjROVclV/5649wVxefvpNo9gTOsIq1
 XrTdm4CwQgRRBd3a3cUvrPGclNUeAllZ00EIa/ab45HNkGzu0Vim3CwEa0vbJCmy/byXTkv
 Y9rzOrjUWT7qn7ZXfUICurBgZoPn9gDKvloIrHwFy4am/dZ7WW1zrQhcg7ttBvb9QnqvQc3
 v75EtpI6PlsN3sZAHpAeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2zGO2Ssr50A=;8HSsC8hCJI9WO0a7T077Ey0lcsM
 5IxIRPHVsBNY9qs9u+D5rVUFSrTKDd63mE2JfZjvmGujgjazTOlzeVoSOjJSfbEUUBycvwquH
 DQBwmFIudXYXOTiU0FPtlbBM4fDMq00coSmVeCg7TFr0LE8ifq6FP1/P4+wJZvOP2MjdfuXjE
 8ZIlhk98eD7ADy7XJ3fbvwygpQv3DZDBRkWH0PtH09GGYSRbJG66vfF7mWMXxNxGp2pl2T8hg
 JPb/Z9cRLTTQRfWTrbJXwGUmWAn0O3We6iezPOV6H+fs7k7CZE9sPOhR1eKdAi7uGkUKRRqZe
 /EzmuKNhYcaWHfFYHfhdGQEB0O5vn3whPqgrjBGDKF5k+f3BauZ7/c56638AvCsU6mbIcoXOc
 eSRXiVMxVvqxyGuT7YtBkV5nUPJLA08HNT5rKkKYKJX/8viV2vZAJ7gjq60Ys1SejYwgyLKkh
 pPXFN1Mtl+iUnqo+xhz40/TPCba/kCwE4VTmbHzFkxz6raayXn+ztgdIWGSMjCDLirz/cBvKE
 58bFXBuAQ57VqjgufuHr7TxSi7uy9Abs62C+yD9+9xBV2pNfnCTPo2kMUUnAR2sm7TyC1lG4r
 M4MEOTUzlD0ZMoOfKOW44K3cJ7MzF801hqSBH9qouBLdBPsWKmNZc5q5gNxpYCfNTG6gzcBvT
 Uyx6Wdvf27LSlp29fEBl/m6e+HcShcNKo3GgX7vrha4lpqoGLIxDX1BPYtt0V8JXu8edzE+pb
 ZJ+HsrNsryS1e2PtigbniyTTiC5leTwWlGK0yktFNtI6MJImb3GI4GktwY0GxrfI7urL/mgt4
 Jtl01SlRONc2goY/0DuZB2KS7VQnxcUGP7KqsfvOTr1yw=



=E5=9C=A8 2024/5/29 22:41, JunChao Sun =E5=86=99=E9=81=93:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:42=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> My bad, at the time of writing I didn't notice that qgroup is not alway=
s
>> enabled.
>>
>>> Furthermore nowadays squota won't utilize that structure either, makin=
g
>>> it less meaningful to go kmemcache.
> Thank you for your further explanation. By the way, is there anything
> meaningful todo? I saw some in code, but I can't ensure if they are
> still meaningful. I'd like to try contributing to btrfs and improve my
> understanding of it.

In fact I'm considering converting btrfs_qgroup_extent_record::node to
XArray, inspired by the recent conversion by Filipe for btrfs_root::inodes=
.

Which should reduce the memory usage for btrfs_qgroup_extent_record.


> Also, is it a meaningful to view the contents of snapshots without
> rolling them back? The company I work for is considering implementing
> it recently...

What do you mean by rolling back?

IIRC one can always access the snapshot from parent subvolume, or just
mount the snapshot.

Thanks,
Qu

>>
>> Thanks,
>> Qu
>>> ---
>>>    fs/btrfs/qgroup.h | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
>>> index 706640be0ec2..7874c972029c 100644
>>> --- a/fs/btrfs/qgroup.h
>>> +++ b/fs/btrfs/qgroup.h
>>> @@ -123,7 +123,6 @@ struct btrfs_inode;
>>>
>>>    /*
>>>     * Record a dirty extent, and info qgroup to update quota on it
>>> - * TODO: Use kmem cache to alloc it.
>>>     */
>>>    struct btrfs_qgroup_extent_record {
>>>        struct rb_node node;
>

