Return-Path: <linux-btrfs+bounces-4078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8389E50D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055112829C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765615887D;
	Tue,  9 Apr 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PEtMCeYG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D714157466
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698720; cv=none; b=gE5iBsA0F58X3DDMKcGDrh67HNhXvNS/y6ZVAU3iIz4GMFZNDHUgJ9xwutSCLW/VF+zRIqVvepWCKkJmF1W9Q6c7xovipa64Z8VLUBJ/VDk50ICCaFQ82Y4J5b5j8GbvqKWkkPUMLwIQlYSd/3WQeOn5/Eir+QWWd265YBdO7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698720; c=relaxed/simple;
	bh=dYIa7HHUxd4QKeXj6ZRggcmB/HWNukylGV9wqAe7byc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABzhPxc2p0RAaw2o3ZLVHdQmKrUTT1h87V1L4LrZ3AWU37uSW42C+cCxcy1FOrGXRnqCA6yVtvXrwX45OWiLI0AotUoa07TOZshe3dOJjWDP3HPTQRbb55DU/RD9j18CFxEpmDVYC7Ns7gBb1MOrvIVloEjVSmgZxvAAAQzrziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PEtMCeYG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712698715; x=1713303515; i=quwenruo.btrfs@gmx.com;
	bh=jQZWWTMYUACkCxabdyDfWgdHDqIk0FnBDzLbnipXV+c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PEtMCeYGJVcP1Kn7e4+lQyqhcvIbJKs83v2F6o0ruTV+1xs/o3o9/0TH1luOWcX2
	 VmsO626f/r5V4mQ7CnQ1eX3mABPhgPi+PAQoEZBIUaXSpb02RbEyWorzwGsK7eOqZ
	 O7gBRzOI8RXELvTjSudjT7tVnSTg2f71LrZD3AvJswWf4yktchdR+TTK1tVuaus9R
	 0MeT7QGwzIUN7p1RYir+OZTMKrEifgV4zoW/+KLFcIoPD1AJujfIFJWtwcukLyBET
	 vMbVUftZdp3Km2y5/TkHfC+V+thcQkYalM5qxQ6jA9pBe/lsc8CubVUH39aXsZOpP
	 hT15cO0zH7y6Z3w6ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1rrY0q2gla-008LqI; Tue, 09
 Apr 2024 23:38:35 +0200
Message-ID: <2d00cb7b-6dca-4a35-9532-e7b5749cdbff@gmx.com>
Date: Wed, 10 Apr 2024 07:08:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/8] btrfs: rename extent_map::orig_block_len to
 disk_num_bytes
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712614770.git.wqu@suse.com>
 <4087de32eabbf9f14988f69e33240db2d5576f5d.1712614770.git.wqu@suse.com>
 <20240409145832.GH3492@twin.jikos.cz>
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
In-Reply-To: <20240409145832.GH3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bluP/1oUWnfaKTbLxr79q7FOpVGOmV2nB1mrhD7+nWzMzzSWrZ2
 4nzZDddBoG4bwccAkWkKtTvPdwcWBDDybnI35NhiLXses57hJE2egeDO+ca4jRsEF950vtr
 oBTtP+5vh1jUmVwXxYvByAGly6luifU4DQS4R1tAhre4ozPyVevWOxXG2BORH25nt5bIoyf
 hPs8cbpzLKm576G4bx/Aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DamfXTod0dY=;2CEtoA0DOS5Gq44E8FNs2LA8saD
 AMI5QIM7Vv5lHTZsf8UQvA1EF25FLKhQy6ixGidHmnZWuYFjzhlplvd2W3BUU4NfhcRkt5he3
 Af8fKXFNgcLRcMKWrI4cGucvzNvN+Psic3Z1dGZMi45GRwOmgZjoIHIHll0Vx/ZcobEybb0fw
 zAqlf2BB5PfHSgAnPzqcPwtr4S8ggyEbHqQl1MoD7cUdQGNyFpFYWZOb8vUASvECO+1+OYyhs
 GulermWMNzVdGvmDH+OnMeQuCGDb/l+mnmMxAltKehYbzADJajxLX3E0lzhE8sGvReW/U8SE0
 /VGuH9MkMXLhRKC7XEt3o+euCIXBIBqvqF3M4AByIzBL3akWDnLR97Z/dZsFJuFt61dQI2NpS
 E/+k2DpGK/yCeEdQfRxByAQL2C/3OtgVJ9t2Chbh2os2aFjIzByjHXzunRfWimj2bOYE1ucsv
 kuMSHH5z3nfybDNpPri1RZ/zwTX0wGpNmP7hGQ1jnCADxmFVKSpmzkj7mlBDobA84fHrmuk8p
 0mkB465Gqt95LkNmk5JgYp9MBvl3UmnUoKKynXgZf5NJTho1N1IjBr3g5LKvFQRvH849D3E+J
 bdnlzoYVVAsm2foT5N3Gp9Xhg9C/IIVM0cOCHGYzQMgrLdGiCMF3pIM44hJ7v4WXrIxVIR+oe
 7ziFV0rx5v7UQ7TTI5Xtd9CnUWcib6M980brN4M5Ao5bHnb9lRtaSagaWeppW+mH+w3ivH9/0
 zLcKZql6y1CDKndSO0OEJjGZPwyWsdTkxvtosXENFEDRgYq9moELMFJIltrYQb+ii5J4Ukf9K
 AL6YW6uRTu0n08Eq1LPegSXibdjrXB3yP3S+2qaTiefvU=



=E5=9C=A8 2024/4/10 00:28, David Sterba =E5=86=99=E9=81=93:
> On Tue, Apr 09, 2024 at 08:03:40AM +0930, Qu Wenruo wrote:
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -2872,7 +2872,7 @@ static inline void btrfs_remove_log_ctx(struct bt=
rfs_root *root,
>>   	mutex_unlock(&root->log_mutex);
>>   }
>>
>> -/*
>> +/*
>
> There is a whitespace change but please check your patches that they
> don't contain such fixups unless it's in the modified code. Thanks.
>
It turns out to be LSP server.

Every time I modified a file, clangd seems to fix all whitespaces.

I'll need to find out the option not to do that.

Thanks,
Qu

