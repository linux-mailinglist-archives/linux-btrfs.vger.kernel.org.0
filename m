Return-Path: <linux-btrfs+bounces-4879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA18C18C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4A328332C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 21:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FF1292D8;
	Thu,  9 May 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NFQCpsom"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254231A66
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291722; cv=none; b=YU1XRIPcMqJ+E87LAkTlKQpI46grgWJE0X0yMxyRUzVPhJR/O55Qb6C9k5ue5vtSjsGfAV7mefiDy4lABFYcGyF2Rrh9DimL0/8iNQzcC6IEDTyjKVnM9/HX2uKTu1OsadIIbsBQPcqGKxGgjfayhwMF/HXMhxreEaCABo9Neq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291722; c=relaxed/simple;
	bh=Vezs6ONckP26AGsCMcyTHDvEzKDUOAJNLDEwwHSQhEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtmAeZJIPYOaa4d7plFN+j5GophVZhnbdfDrLg2W855WVT+fVRIrMhHIFsuDvGuQvY8Nfn6tPZNULidIyXviH7ENutM12TG1rrxbM8stlqom/fpS05OX3ipBsv/Y2OhQXLaqzU3ZC7mBhXF+NrCF7nQoUfCTYeKCHAn8AQnZIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NFQCpsom; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715291713; x=1715896513; i=quwenruo.btrfs@gmx.com;
	bh=o5ENmP+8mftRGdef/8TVtJmi1bWcb1CragS6CfRTztY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NFQCpsomFYoDH7E4Upunx6q6UhltqaMfAQUaGdztp12rfqG4gCyZ6VXThXBg8Ghk
	 Y57kWK8yRoYroVgiZDGioavOZoYwl3z8/IzlHurgeYR/SwhRPz0lDgYSYzIIltJah
	 q//DtbDaLGSgG9pGjHezTIq72O0tz9969doicz8oTTodq1XHMx6dPbMv2CsqC1DUW
	 v+eDfECh0WmtM5vL8Kw9AfzUk1QtTVqQx659eDnqQQ6GNXLAwaMedqhhgpY0NPrLk
	 O6Sx85jcodbydwb6mm2zW2//2DGuRvl+g0NQev5QE5OrzGm3Vh2ZQx6UE75kIONgi
	 Tm9hvSTi23gSK0xPZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1sqIFB2DmH-00wpcw; Thu, 09
 May 2024 23:55:13 +0200
Message-ID: <b8538fb0-e6bc-4dfd-addc-756048bbcad3@gmx.com>
Date: Fri, 10 May 2024 07:25:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] btrfs: export the expected file extent through
 can_nocow_extent()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <e351482ededb22c1fb81eeed217ae8e34e8e1427.1714707707.git.wqu@suse.com>
 <CAL3q7H4ruNd9xUvp7yY-CPEQAvM+6Kd+N2Nd6SDgXUpj=OhQAg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4ruNd9xUvp7yY-CPEQAvM+6Kd+N2Nd6SDgXUpj=OhQAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E+hMUcBJTHa46mbntqz7lHxn/eSc6f8JPXw4Bn6+uHl+KBaGKqx
 oTmIy1zTrrtxOQIbIf/zJB2W0dRZiGm/QX+Jqbkh1cZqPVhmLl7g3vaDF6ZuOMtrs2HRU37
 qxPkzK4fSsdmIfJgjLbxAdMz+/TYFPtbFImC3bbJ+xW1NhVOK2Q7Gjjq9N3m+we17Zka54H
 GABN7LearKIk+zWl9EKUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wl+7K0RE4BM=;Hd9nKpOouG8H3rBOdcSS5D6kiay
 ANiEwqQi2GuOyE3EJtSML/3BEhCPP9e+FezF8k3vo66vnQtHAQRHxm0wZTkfeNoHAQMrLr+L8
 A9VieZODhxi6PwFl4C1T/0aBHjZ6/WoNE/Zpci6212AdS3IHYcfGK8/PbL2iZzw0WVJUEKMmA
 M8y+tyruKnGsYZaTjzR/j1vc+KO8oY4F6Uj/qujZw55AdZ/3pV5PBalLJ040anRoXLUPQIAH7
 2OoALgdfhcSXCywVNT48A/edSjObuReIJz/mvy+/6mIVVrm89gYEZ5R/1NhFVmYrOoqHpcfsK
 GV2I73nBneaw8X2WQent5WBT75+3JSMJs5yCBTog28dPg9mM2jEkK3QmNjIp+wNjjC9GS45k3
 VPo0hl426NPnCLr+mZmllhn9oQq+oaUvEmlcb7YLK8x6AA8fThwUNUFDhT++qJHpiIFffJqmh
 YSEifc3QcBgAKPi55lQcEKdokmySKjf4mI0URwZO5L2bg7sTvwEcJFkJ+4AzQI7AWVz7fZShs
 TugYp1ZkbWMr6yQozggIxLnSb8OwP5JIbaFUuDK5xdedgvcQCRrXRkMUdCMYiPLeEpz6ED6ls
 Gdh8XvFt/YXiTUj/yjhJ2BegUAUZ9lHrwCU8Gjr1MmHQ9jDlw3Za4MXW0G8oOevjgP042sScG
 0b2bqzmiamfvQYerkRpDB8NP9WKOoXVHKAhyV/NGZmWiKT925LJ+dvi7vXfzfvjru8NPZ37gF
 3oqS8hfXjYI49b5ilI19s3RwMCpK2MmhErRk1lKCdOTqJo81h2rD71ZUaBN///dDYeQwREu6F
 mj19eztfnMQuHq4EYbYt5tZWPgXEaSYaB0F/b1dF9tjKk=



=E5=9C=A8 2024/5/10 01:52, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> + */
>> +struct btrfs_file_extent {
>> +       u64 disk_bytenr;
>> +       u64 disk_num_bytes;
>> +
>> +       u64 num_bytes;
>> +       u64 ram_bytes;
>> +       u64 offset;
>> +
>> +       u8 compression;
>
> The blank lines between the members seem kind of ad-hoc, redundant to
> me - i.e. no logical grouping.
> Maybe I missed something?

This is to separate the members so that, the disk_* ones are only
referring to a data extent uniquely.

The ram_bytes/num_bytes/offset are the ones to specify the referred
range inside the uncompressed extent.
Finally a u8 because it's not u64.

But for sure, I can remove all the new lines, because the grouping is
not that strong.

Thanks,
Qu

