Return-Path: <linux-btrfs+bounces-8176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290A983A12
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 01:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BFA282C64
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20812F38B;
	Mon, 23 Sep 2024 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="azBI7ogz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B81386C6;
	Mon, 23 Sep 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130800; cv=none; b=VkRsDXE+jEbfURGU5jtN8LXZ7wmEMedQfeutBI7JPPhc1JyTB8OLbidP0lLctbxv0zEzVm1wt99SQw6L9FfnnIa3gS+NwvkiC2F2882SOlqoH6+tUAud/J7DklcBfLJ5AqmJ5K2MiIbz8kOaBhkzDGjncz6wWgbkxnCGqtUAZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130800; c=relaxed/simple;
	bh=UKBYeHUPfWhbuRJkgqIQsgfanpaYzIgr0W8v0pon648=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYrdNI9nlQ1xApr0EfkbMvI2ohnARnh1erUD91oad6DjQafe+/ObwmZE5d0jgQFKcYvd+mwlWj2N+rggk+ZHVRZgQUSFdW4qOhBMqYF9UWc+iMiS2y7gQ/fmd+4gK/T1fTshYCrARSA7nxWyjk8N8QSOubP61Cz00JiWLmzWIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=azBI7ogz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727130785; x=1727735585; i=quwenruo.btrfs@gmx.com;
	bh=eo3xFrmn2u1v1T//pvecUt8zJOkujHQRVeeGOp8olaU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=azBI7ogzOvc1clvwtOrFS//HtKOCrRAnqlNkkH7k2p+APGiNxQjrkxEJ5fIGBx+7
	 4h3kiZs5glxW879st7ifJM7r+NUcS9XWgAoVOMVthc9qtqpACuE/jTPeLunmHvPz+
	 ZzuyvcKFVZJohS1NlUbhTCGo48gJwg5ZKc+djwSZ81koVyDRwD4XibMFgelDWQI1O
	 HtlQlgl4UMEqe8vOa4n6UgUU1cZofmBihOMhcRrSuiJ+YvOz9TMGvDF5Nn2JFgjxn
	 +NaOH7Le0w4gz3jnzbR4yWX4IdlkqA6tIm2r2v5fKuIBUnNXXFFJWNMagNEZj4Kfd
	 Nmw3IW5+siZ1xMPK4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1sQiug1Tru-00O9cO; Tue, 24
 Sep 2024 00:33:04 +0200
Message-ID: <d881d399-96fc-4cf5-8a40-96f2e76b7644@gmx.com>
Date: Tue, 24 Sep 2024 08:02:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
To: Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Qu Wenruo <wqu@suse.com>,
 Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <20240923152046.GA159452@perftesting>
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
In-Reply-To: <20240923152046.GA159452@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c9EcqC93ClJKcayh2bcTkwP2PdheqQz1ItYaikKJq7dWf4lwy07
 OULnOVlbyxFbQI15fcYjVxJ31tUUF5USb389f1ELYAvmcTSxRrrMWGWy++5ry86Nz9ARWNC
 ZLIIcIgEZzRGzJJvcIYH7sXUV6F2IMX5FqGHmgH3H7e/a7rHDVZNftDL1911ie+rU8xyCIG
 WqlaomQb+MUxVcdTwtAjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tIvIWx+Ene8=;ZmcigRumH6F3V3IGf6O5Nf30MsQ
 jaXbs3DpY93x+s1bG2gf+v++ZCQ5aOISlmILsEg6dO0T0sDrODj9IJIAr5x/RjngZSCeBO8v8
 LRLw0ZBCuOo5KXAYBoJ3L2GvRqtLR2tWn7xSEOh9RB0pHhECj9r7EN1SSMEpxU1tXuozql5jM
 cJ2kVBBCxC7McXI4Fg56PWjqWaoWpzmu74qpqd7U+2MOXLD98Lk0bQUMrjYy/E3JEepIN2lcO
 8xSE0c930iHjVowCsmALGCgIdu34q5MyrtWqFgWqwhXqd5+zozspkDTdFh3mmvV3l1DtOQLgm
 O48dGAH3hwht9DRq+l205+EMxpYfmOyrBmXAW3UlC0N60jzVKHSkjv478DrEK6Vihw+zcBj18
 rYi3fQic6Bj7qJuIVrur9U/RBbaP68YCYJPtetY0TsRAzyEFCZ/3AaTximadGPb9adLFFCUsU
 +QGYcf/lriNJnP9zVQPghIrbBsNLz8mRq4OBYa21opUUOpHTD3HLcaTwzFFprB6GL/dB4fKrA
 iN1zj6+WNkcPZcIAFbKX7A7f+01NJWL6wJh+CU3uQstNAzFqj9J4OVKAvDCVwpLd5/VS71AaZ
 z4UcVJyEEYlaZShhWYP3w1V2KQ9bUNPX2jOjMmFMAOk6kWPAzBidFVgVzU/A98eItqK7VXRVo
 jQrM9f1BWn9kajuTHwG2G8SF7Ijv7/jEnZbRy4iUgNoDLbAtvjmxC62ZBCpQlxE2Mwk95EMCQ
 phc6AhN4rTg5TrnDyYMzcHBrNaTuOauWCb+nJIebsr2tv+DgZ+OG21/0uMNwg/5uy276j1CAl
 pAwdy+2eJAQ54tA8hQlBPWTw==



=E5=9C=A8 2024/9/24 00:50, Josef Bacik =E5=86=99=E9=81=93:
> On Mon, Sep 23, 2024 at 04:58:34PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/9/23 16:15, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> NOCOW writes do not generate stripe_extent entries in the RAID stripe
>>> tree, as the RAID stripe-tree feature initially was designed with a
>>> zoned filesystem in mind and on a zoned filesystem, we do not allow NO=
COW
>>> writes. But the RAID stripe-tree feature is independent from the zoned
>>> feature, so we must also allow NOCOW writes for zoned filesystems.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Sorry I'm going to repeat myself again, I still believe if we insert an
>> RST entry at falloc() time, it will be more consistent with the non-RST
>> code.
>>
>> Yes, I known preallocated space will not need any read nor search RST
>> entry, and we just fill the page cache with zero at read time.
>>
>> But the point of proper (not just dummy) RST entry for the whole
>> preallocated space is, we do not need to touch the RST entry anymore fo=
r
>> NOCOW/PREALLOCATED write at all.
>>
>> This makes the RST NOCOW/PREALLOC writes behavior to align with the
>> non-RST code, which doesn't update any extent item, but only modify the
>> file extent for PREALLOC writes.
>
> I see what you're getting at here, but it creates a huge amount of probl=
ems
> later down the line.
>
> I prealloc an extent, I map that logical extent to a physical extent and=
 then I
> insert a RST entry for that mapping.  Now I rip out one of my disks, and=
 now I
> have to update RST entries for extents I'm not going to rewrite because =
they're
> prealloc.

Why do we even need to do anything update the RST entries?

RST is just an extra layer for logical bytenr mapping, and did you see
the non-RST btrfs do relocation just because one device went missing?

Can you explain more on the "have to update RST entries" part?
That mismatches from my understanding of RST.

>
> RST is a logical->physical mapping.  We do not need to update or insert =
anything
> until we create that logical->physical mapping.

Just consider the fallocate of non-RST as an example.

We DO allocate real data extents, they have real location on the disk.

Then add the RST layer. Now preallocated extent suddenly do not have RST
mapping, but still have extents allocated for them.

I do not think this is any more consistent.

>  Keeping the rules consistent
> across the different layers will make it easier to reason about and easi=
er to
> maintain.

I think all data extents should have RST mapping, that's way more
consistent than two different handling for different data extents.

Just like we do not bother if a data extent is preallocated or not in scru=
b.


>  Adding an index at endio time for NOCOW makes sense, we now have
> created a thing on disk that we need to have a mapping for.  The same go=
es for
> prealloc, adding an entry at prealloc time doesn't make logical sense as=
 we
> haven't yet instantiated that space on disk.  Thanks,

But we allocated data extents. Even if we won't really utilize them for
now, we should have RST for it.

In fact, I do not even think it's correct to insert/update RST at
endio/ordered extent time.

It will be way more consistent to update/insert RST entries at data
extent allocation time.

Thanks,
Qu

>
> Josef
>


