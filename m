Return-Path: <linux-btrfs+bounces-8666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E29995978
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AD61C21DCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593C216429;
	Tue,  8 Oct 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f9NZAqpD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860E215039
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424562; cv=none; b=Lheh1Xo/AhIK+pc4KiJwvWTdCsESg6yJ7yWfDgfTVypQUysxIrhGjv7Kka+3n5UvcsSH1M2ShooJTgN48oclsG9ic0s0Rnst/DKYTPNPtWsay/j77ldI7k43hB/JAG0M2cjh9r/xSdKGxCrtnP/P4vS0+tPYKo7PZILEnlCDEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424562; c=relaxed/simple;
	bh=T5SU+feucztw7fpGKRYYxWigCdee68zQhC8tFugRmYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvDtPgoMaV+Pn3JEakTKGTpFDx+XEC4xCKt1jYiFBtj92ho0+TWx7aXWXhVAS+6cjrlWOyzHfow5RFUgBgKwr3vDOmhiJ7RPtmcK6/KJTSHoZIjSGmumj7TO/nrLOB+RVCv8co4e/AkarrqJ0JKYG47Cflf+/Lv+SLNyxjkE6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f9NZAqpD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728424556; x=1729029356; i=quwenruo.btrfs@gmx.com;
	bh=CNMoQiJ2jd2OWbxKENtm5HQPGf9B9Sm76yOG2P9fCJ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f9NZAqpDnK4gKdMC46o13v+EFLulFDmj8rqXg5USbpr7p+Lq2e9Ev35xY522j9Zu
	 AMB/J3ihzzXXWtM+19Jwq3GgBEVqmkOnIge2/lkpKDzk8/48pSihpiqzG0ieEiBiP
	 rCpkg2MycJG/nSRmU++AzRyXAwjefSaQoNyEANfgK9gd5PB3b9kIdFA6ou51Mz4kL
	 u4VsM7pYkeFFdZ0HgM3CD0aCRXW4BwFRQEHouHnwghbkcSakE04nlpKNoL9eJ3RLY
	 XHiu4qPQbQxk5ddPYDM87yByNXcyFQfb4GrVc/3RQkUioL5WmJ7HoHqgOJmyFk4BE
	 sNuy4YPjjkbEkEW3Ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhhX-1t6Ef632Tn-00DJNR; Tue, 08
 Oct 2024 23:55:56 +0200
Message-ID: <0b86a998-ae27-4fc9-8180-c95c52cb62cd@gmx.com>
Date: Wed, 9 Oct 2024 08:25:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove btrfs_set_range_writeback()
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
 <20241008164356.GC1609@twin.jikos.cz>
 <9de4892b-f1dc-4dc1-a63b-71564aaf1a94@gmx.com>
 <20241008213920.GI1609@suse.cz>
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
In-Reply-To: <20241008213920.GI1609@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z8LVLmokCzDLUOmQelvA039VolaLYZzxObfadjqPOd+c8wfKpJX
 msuji36mfui1ZQOEzzkOqKpxE6XRDXisa6TVkZDZ1jXNun5vdgdtQSN8EvbKAYN0fP2/e5T
 vTxG9SWzRDYJbggAztgiSHvr8HIifR2gI0lsVDLWvZdrbvY35x8hh8C/ClmWi3eAtmZdKMq
 53JiYqMnbcVQmXI6ilw4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FH+CTbharC0=;h2JcGC0umSsNg5gSDRa/PhT3sWK
 tYhj3jjxWl3nuiwagzca3K3nMnAgThVAoWy0RQIoG8cNjVXOliR214YpNoK0TLWSi9xZSc8Sl
 nfbKvu1ctZe3yZl1VIEpLPGLdtV7cKE4jGRlZtZ4Whmxahm2mmYcBtgzkuucJfiMR5oyygswI
 cJPmqw7iyy/m2SDkjLolIrL/ZFgiEY3XMNbivMp1nkYkJlVf5nZtnvzNAh79nrI8Xv4OO51hD
 GH/l5xlYhpzhot3DowY77/e1KTEoLqOi2Q9vvw+SVbJVJcaNLg6PUxnEo1GgclvF4XoTyVVmA
 INnyHHhFlALVlWa1qVAniStNVLVruJoM92lgrGPMV+ktOTqywIEo5BqQWhFFS33SHOcJMBPwo
 ziCI8LQqzpX/yYJdpI1E/Oa2Dr2YgCxCMj9lZaks84fm7RyOG3mpAW/Jj1WuCZlUHCzvIoRPD
 rnFPW5jFG7LrnSIkPMQJ/Ld7lfyeknsxMkWUuHWTv+0eO+nlhewTghhWhI8/xC0/U+iiCOzUj
 7Kqp2O59DlOWLmySFOgZmB7YbnWJprUoHDIY/wjF4FsFZvTanYthJ/5HmfOZOrgpYfB8M4dOl
 oX8FNiX+NP6GnM5sCYyHWrP3sGNpZ5Xnn23J2IbdM28sbOz5tbqRtP59362esoYAnYENv/ny4
 s0OosJXIcXY6ATYII0kGtg9Q0oCbvczT5PYoDqPXehcG3o/aZ41wfDnnDayB69NBRIW4tDoAz
 BsM2McXdX0vr36FvRFGvTbuWpLtwkBtDGcyccEzs6X/VANCHh7l6fQFZRqnyPRPXp0WvjuOJO
 9k19LrTQ26fgYC1d6oML56Uw==



=E5=9C=A8 2024/10/9 08:09, David Sterba =E5=86=99=E9=81=93:
> On Wed, Oct 09, 2024 at 07:26:36AM +1030, Qu Wenruo wrote:
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -8939,28 +8939,6 @@ static int btrfs_tmpfile(struct mnt_idmap *idm=
ap, struct inode *dir,
>>>>    	return finish_open_simple(file, ret);
>>>>    }
>>>>
>>>> -void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start,=
 u64 end)
>>>> -{
>>>> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>> -	unsigned long index =3D start >> PAGE_SHIFT;
>>>> -	unsigned long end_index =3D end >> PAGE_SHIFT;
>>>> -	struct folio *folio;
>>>> -	u32 len;
>>>> -
>>>> -	ASSERT(end + 1 - start <=3D U32_MAX);
>>>> -	len =3D end + 1 - start;
>>>> -	while (index <=3D end_index) {
>>>> -		folio =3D __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0=
, 0);
>>>> -		ASSERT(!IS_ERR(folio)); /* folios should be in the extent_io_tree =
*/
>>>> -
>>>> -		/* This is for data, which doesn't yet support larger folio. */
>>>> -		ASSERT(folio_order(folio) =3D=3D 0);
>>>> -		btrfs_folio_set_writeback(fs_info, folio, start, len);
>>>
>>> So the new code is just btrfs_folio_set_writeback(), with the removed
>>> comment and assertion,
>>
>> Firstly, the length check is already inside btrfs_folio_set_writeback()
>> for the subpage cases.
>> If it's not subpage, we do not even need to check the range (it's alway=
s
>> page aligned).
>>
>> Secondly for the folio, we do not need the ASSERT(), because this time
>> we have the folio pointer already.
>>
>> So for the assert part, there is no change.
>
> Ok.
>
>>> what's the status regarding large folios?
>>
>> That stays the same, no larger folio support.
>>
>> The larger folio support requires us to get rid of the per-fs
>> sectors_per_page check, but using folio_size() to do the calculation.
>>
>> That will still be a lot of work to do before we can support larger
>> folios for data.
>
> My question was about this specific place in the code, if we e.g. remove
> various assertions making sure we don't accidentally get there with
> large folios after they get enabled in the future. It's ok when other
> code makes different checks that would prevent it, but that's what I did
> not immediately see. Thanks.

Oh, in that case we have quite some such checks already in place.

For this particular case (buffered write path), we have ASSERT()
checking for the folio order at end_bbio_data_read(), the same applies
to the buffered read path too:

	ASSERT(folio_order(folio) =3D=3D 0);

So it's still fine, although a little late (at endio time vs at
submission time).

Furthermore if we're going subpage, btrfs_subpage_assert() also does the
folio order check.

So we should get the ASSERT()s triggered pretty easily if there is a
larger folio passed in.

Thanks,
Qu

