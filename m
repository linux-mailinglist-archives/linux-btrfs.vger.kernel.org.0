Return-Path: <linux-btrfs+bounces-5721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C19907E22
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F181F211DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F313F421;
	Thu, 13 Jun 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MX5ECWGB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F82F50
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314111; cv=none; b=Z4NnomMSmql893r3/VTEp4EGWPfILiPA8iMlSm2C8qvwRqQRxb139qqLAUdY1T72kLEh3k0wkwjrK7i9pD0az6wLINaAXa55cChgedtm8rMZodUFSQ6PHBHvPq6rA5Moii7H9QHZsgWYp4PL5fkr94uQWP2mQ/qrUq7BKSuqWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314111; c=relaxed/simple;
	bh=Ue6hUASd4bVqptd70nRSN5ufzsIdvfVyKwyLkbCAEEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehfRoEQ+nZ3Bz9sip6fZV7AEwLgaM64aVZVsbPAb8fP6C8pHzmHYPfhAWTshlurqC4vidtcaVlRYk7WzjEjTd1CNTrNSpLXem/w0kc33Fj1KkMmWUD90KyMDhlYkIAwqIHOTuHoUcIFALAYHaYgD95OkiXw37L/VRZ99c4Qf0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MX5ECWGB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718314105; x=1718918905; i=quwenruo.btrfs@gmx.com;
	bh=bXWxpv+TwmwpbrmZxjrzMd0KUbKa5dtJTlrEAGtr/9Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MX5ECWGB+cB1nNm+fgqvR8nNbHR6aeOlR7UjGw+tti27iW5X5KVmm/U2achPirL7
	 VOx4NFSzgwhSa6oqmbOKxRAe1AKpoX7H3VjnBm9/xIgDW6TYPJl7Xh6A/0NwSyXYJ
	 5PixJJ4VqZeorXjyuEVRcSoJhW076bTLkSX07+Ca94z0IKJRpL5K2lr/mUdjeJnia
	 nbaHK2uRF6oEqWYUfPy4RKtacjAtrWGZaqOTz18eP/elqIIeX8C34PA99A59hzPvg
	 uAlhFFhX1wCxe+ZaESGnbJsozl2CAeQDzigDBPOBW5DZKkPptoh3PsbN0q4qLLPES
	 cknCI1LhOjEV5Lb4Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIwz4-1rxSl81l2Q-00I8Xv; Thu, 13
 Jun 2024 23:28:25 +0200
Message-ID: <ffa354b9-4315-4e29-af2a-124a697d0eef@gmx.com>
Date: Fri, 14 Jun 2024 06:58:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: introduce new "rescue=ignoremetacsums" mount
 option
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718082585.git.wqu@suse.com>
 <f6b9b9037ee7912ed2081da9c4b05fd367c9e8f8.1718082585.git.wqu@suse.com>
 <20240612193821.GK18508@twin.jikos.cz>
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
In-Reply-To: <20240612193821.GK18508@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XS00CGtouW3QjYOyxoViu+OcFPgsrD+tGxNx4cdQKfYTipSMSf
 84bhV29kyGBeyZ7s0cg2K1SuPUPZ+6B/HE1IBDxIVZjxW3JWkqyBTPAS+7ekBsb9hKOHJni
 Wr0cDBGrtm2UZ4nDcqupGrosqlkxAyXmmt7fWDpCzkhLnxtvwFFWlL6AutJwgVq1Ve+xLO3
 qB6KN+h1lB+jmexZy/f9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0u2cKJ87hg0=;eV0sxfWmS86sH+CrablQWgEPvlH
 byxVrXjvhlXJNjDcSeAp9wvlv0uJ0LywVD+XwugMa776nIg0WrL3bLWHCzAhZslvDGzCYYk1C
 cz3k+oYxJa+Cbj/SPCKiS6UHt15Fi7Wi7A0i4lkKzLXqXexuye+oltfffhQHyZsBY/lDElZYy
 twDJotb5xetNTHoL7AhZLgBrA0gjodL6jf2GdBFETs01aoeNVrhasanZRm8QoYBcp7lXPWL9K
 ootQv6kk7hemYTONYF/KE0aLznDbg2BXBzpsFt3F/O7FS3UsN/PYan/Xayt3jY0DhCcA4KTfO
 vjXaNsobfReVbYn3atE0Xw+cHtmBcTKVAKQJ1q11pWNIBdFQIGC3hfX+UFyXdbK+toFUZDCZy
 f521Yu6I1g1WvNhLBykdcFfdKQBQeFKXhicF1G4wYKnmWx4TTC7FDLYt+H/Ghnbz9yjj+2q52
 XaIjTZp9HQF16WHU2FyfgKzrEBLeIKmlS6UT8elmy9GAB0r3cO9DWU29AcVRgizFjPsiKjv+3
 9JuNqNBiyR9ziNbt9cXdaUYFu014PHJSQWJABU85sV2BjZE/1ItNt5uR3LPdnuhwBaLBA3nBK
 WFPLObVyC9N/fMR0GBuB5ZyJDEKfXfEaRWcKN8INofzxIfForNe56h5X02+8OKQao2xWPad/F
 7+OSa61SlbhssLAbDfnzgGeMRQL9AjzYS3fokLbKodn5Bgt1rkBxHFP2pOYSK4954jfx4ck5m
 BE6vdKTQWp/9XAVM8smR704C21JkDdgm2vaUynznazsm0ovllyqmsd80WE/og5jR2cd03i5WT
 Zq0Iiy6vZEA2zxzAlh82aiilLxJosq5UR40ZRiO8IZL/8=



=E5=9C=A8 2024/6/13 05:08, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jun 11, 2024 at 02:51:37PM +0930, Qu Wenruo wrote:
>> This patch introduces "rescue=3Dignoremetacsums" to ignore metadata csu=
ms,
>> meanwhile all the other metadata sanity checks are still kept as is.
>>
>> This new mount option is mostly to allow the kernel to mount an
>> interrupted checksum conversion (at the metadata csum overwrite stage).
>>
>> And since the main part of metadata sanity checks is inside
>> tree-checker, we shouldn't lose much safety, and the new mount option i=
s
>> rescue mount option it requires full read-only mount.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -367,6 +367,7 @@ int btrfs_validate_extent_buffer(struct extent_buff=
er *eb,
>>   	u8 result[BTRFS_CSUM_SIZE];
>>   	const u8 *header_csum;
>>   	int ret =3D 0;
>> +	bool ignore_csum =3D btrfs_test_opt(fs_info, IGNOREMETACSUMS);
>
> const
>
>> --- a/fs/btrfs/messages.c
>> +++ b/fs/btrfs/messages.c
>> @@ -20,7 +20,7 @@ static const char fs_state_chars[] =3D {
>>   	[BTRFS_FS_STATE_TRANS_ABORTED]		=3D 'A',
>>   	[BTRFS_FS_STATE_DEV_REPLACING]		=3D 'R',
>>   	[BTRFS_FS_STATE_DUMMY_FS_INFO]		=3D 0,
>> -	[BTRFS_FS_STATE_NO_CSUMS]		=3D 'C',
>> +	[BTRFS_FS_STATE_NO_DATA_CSUMS]		=3D 'C',
>
> There should be the status also when the metadata checksums are not
> validated, the letters are arbitrary but should reflect the state if
> possible, I'd suggest to use 'S' here.

I'd prefer to change the NO_DATA_CSUMS one to use 'D' or 'd' (for data),
meanwhile for metadata we go 'M' or 'm'.

But on the other hand, I do not think data/meta csum ignoring really
deserves a dedicated state char.

It's not really that special compared to trans aborted or dummy fs.
(The same for dev-replacing)

I can add it for now, but I believe we need some better discussion on
the fs_state_chars.

>
> What I'm missing is the sysfs.c update, all options supported by rescue
> need to be listed in rescue_opts.
>
That would be updated in the next update.

Thanks,
Qu

