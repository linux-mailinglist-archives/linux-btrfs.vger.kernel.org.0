Return-Path: <linux-btrfs+bounces-8164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13D97E7F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 10:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D79C1C210D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A349649;
	Mon, 23 Sep 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DTjZ2KNz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503859160;
	Mon, 23 Sep 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081659; cv=none; b=Uc2v3yeI9/5UllwWZY/AyWfXJFcLNuTNLvme4+muOUwZYsYEGPN9+Cq7YH+U6+er7e+qpPsClkshgx3uCCqfX8bTY1+ahta16rfz4bpw3LmGVwNqWueyRT9rO3MQC9Z8S3ILfXVXVfWPZsXaupOGoykItFz9yHFjTTQ9hVOjnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081659; c=relaxed/simple;
	bh=tVr2b1WrKsl9NvsB8FTYYQJE2FLcLKEHGH9mE06IYqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tx0OhIFu6WENSPPLRUsco56IHaz9Xb/sp/rla8vIQ+ahyi87WSel20jE83XwVJ13/QnpJZRpNzxd2+yXCEmkqtY5Ljem90pKWleXDb+DFqswi/o4Pa2sS8gClMCFL85VJT6znR9KIqPbOUOKgfnhqA+6L7Zq0mqq0/aGnJXbOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DTjZ2KNz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727081643; x=1727686443; i=quwenruo.btrfs@gmx.com;
	bh=tVr2b1WrKsl9NvsB8FTYYQJE2FLcLKEHGH9mE06IYqo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DTjZ2KNzUn9UxtF2aqhaV+cYgSEd9cbmklm945vpelNr6uylD+FYdVE0aDJT2MtT
	 KalQpw4SlcH6S0k3cDWYRp4ttOMU0zCMgbI7o91EtqNYq+PetPxaFsYHTpQwA6IQJ
	 iLGJShVdBOmUZhsa76owgwjZP2WzkjTpo2I7khGeONy7fmQE+qTO2SQhHaqy6nchX
	 yXmpJqECPRhsw1nLZF9DX6j5HM5Mrv/IK7NyJhOQ5z2R4ePWJbNyHxZlF+BITpMLO
	 dBLl0l06SHygtJ0FylqeB/OFphHlH+eWsMxv7mgOMrtUnY3QKk4Jcr7HBhXhh7TVT
	 y3XQIolwQb/UX7eomA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1s7kp20hT5-00gNLi; Mon, 23
 Sep 2024 10:54:03 +0200
Message-ID: <47d0f003-ebc8-4959-a22c-ccf9ea7ef35a@gmx.com>
Date: Mon, 23 Sep 2024 18:23:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
 <d42756f6-d5a8-4f44-a6f0-6056f5c1015b@gmx.com>
 <aacb742c-2081-441e-ac52-d9e0f580ab1e@wdc.com>
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
In-Reply-To: <aacb742c-2081-441e-ac52-d9e0f580ab1e@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T35gwD+QKh88bGFZ9hUqesqIj1j1atNXZ39CCrTNAxpCwj8bWda
 fr1UYurovMxKkgl5PRt6buLkYaCJa+q9i+ocRDUMT/2cMtsjnt4rVa+vF1d6/VhBSB95aqJ
 YRHgLUFmcklf90UedrJ7FxM5XdE041GEwUfi3NXjtJfU8a38RMFqxxL5m/elFYnkN9293vW
 vOIadC+xCaqwkOFocKX8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cEy3TkyX550=;BZCiwRWq8AqkiCzUi/dCJZleQod
 sjW+Jc5Cv+fymc4wa6MdJ65LIeoEGSzpmVkb7Hdfw0RvcC7pBgXUm0TpKjylFJoAm1GAnL5ol
 d96IgYZCJP2Ijpx43Btgy7S+64xM72H7y+VE2J1JknpDdMG25tbjg3R1JJeQWLFUQ9sbaH4hd
 IjdKuF4y4yRzYRTY6npsxgO/fKf6+33tF6j9xnNQG073bj2wVDSZerrj+biKfo3JYWO2VpeT0
 oX6UrK9qdMIj86ZSS7vqv77t6eRGAmWhQUEoBKC7F8nKuUrr9CxJsOTmUYxilf59F9GJRcudT
 dJ1Arz3EW6ZbRbVHz4jWZDDJbCHLQaqpvOR+k8O7bTqMpPxC2cepCj0RcQfof8b6LlQvQt7Vs
 5nUeK8ELYubGlQeQV0qqWAvpG8F/9ZtsA8kRRc4S0nJ2/VHBh93+hPj1sGhr42RPFPI8x+RLT
 EuNcubRf64i5hNJVsvD68oNfAZs421LkPgH2FA0onslaOEJ6YQM9Nd088FaQbmKi68yXxLm6L
 5JFhUKwihVCBm/WvdIEv7Ib+5KZu5fubPOimxdpcukUtGILnBBhKfrrca9UAgBR2JtIw2N1TS
 66impuZNmAVSd/u1Cjb6JXn3acIqa6rbQpczOmMMs4wqbYSZTmSyT07fhFruB4/BAswWYUrHX
 OuEdz0CxdhPmU6YsUZ3dVBO7SeYwjag+riHl41lDXmAWSh+77BSpR3xc98F6ddSckElZZgSdx
 SyNo339Uk+KACe7ZCAiQ7/Aqh49tz9xL3Y/8zbsp1FnWVb/otH5dn16X2sP1SFemqje3YEKUJ
 WgDlBnqVDKhWTfLau0YK7u5w==



=E5=9C=A8 2024/9/23 17:45, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 23.09.24 09:56, Qu Wenruo wrote:
>>>> =E5=9C=A8 2024/9/23 16:15, Johannes Thumshirn =E5=86=99=E9=81=93:
>>>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>>
>>>>> NOCOW writes do not generate stripe_extent entries in the RAID strip=
e
>>>>> tree, as the RAID stripe-tree feature initially was designed with a
>>>>> zoned filesystem in mind and on a zoned filesystem, we do not allow =
NOCOW
>>>>> writes. But the RAID stripe-tree feature is independent from the zon=
ed
>>>>> feature, so we must also allow NOCOW writes for zoned filesystems.
>>>>>
>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>
>>>> Sorry I'm going to repeat myself again, I still believe if we insert =
an
>>>> RST entry at falloc() time, it will be more consistent with the non-R=
ST
>>>> code.
>>>>
>>>> Yes, I known preallocated space will not need any read nor search RST
>>>> entry, and we just fill the page cache with zero at read time.
>>>>
>>>> But the point of proper (not just dummy) RST entry for the whole
>>>> preallocated space is, we do not need to touch the RST entry anymore =
for
>>>> NOCOW/PREALLOCATED write at all.
>>>>
>>>> This makes the RST NOCOW/PREALLOC writes behavior to align with the
>>>> non-RST code, which doesn't update any extent item, but only modify t=
he
>>>> file extent for PREALLOC writes.
>>>
>>> Please re-read the patch. This is not a dummy RST entry but a real RST
>>> entry for NOCOW writes.
>>>
>> I know, but my point is, if the RST entry for preallocated range is
>> already a regular one, you won't even need to insert/update the RST tre=
e
>> at all.
>>
>> Just like we do not need to update the extent tree for
>> NOCOW/PREALLOCATED writes.
>
> But as long as there is no data on disk there is no point of having a
> logical to N-disk physical mapping. We haven't even called
> btrfs_map_block() before, so where do we know which disks will get the
> blocks at which address? Look at this example:
>
> Fallocate [0, 1M]
> virtme-scsi:/mnt # xfs_io -fc "falloc 0 1M" -c sync test
[...]
>
>
> [1] we preallocate the data for [0, 1M] @ 298844160
> [2] we have the actual written data for [64k, 128k] @ 298844160
>
> What should I do to insert the RST entry there as we get:

Do the needed write map and insert the RST entries, just as if we're
doing a write, but without any actual IO.


Currently the handling of RST is not consistent with non-RST, thus
that's the reason causing problems with scrub on preallocated extents.

I known preallocated range won't trigger any read thus it makes no sense
to do the proper RST setup.
But let's also take the example of non-RST scrub:

Do we spend our time checking if a data extent is preallocated or not?
No, we do not. We just read the content, and check against its csum.
For preallocated extents, it just has no csum.

You can argue that this is wasting IO, but I can also counter-argue that
we need to make sure the read on that device range is fine, even if we
know we will not really read the content (but that's only for now).


Furthermore, from the logical aspect, at least to me, non-RST case is
just a special case where logical address is 1:1 mapped already.

This also means, even for preallocated extents, they should have RST
entries.


Finally, I do not think it's a good idea to insert RST entries for NOCOW.
If a file is set NOCOW, it means we'll doing a lot of overwrite for it.
Then why waste our time updating the RST entries again and again?

Isn't such behavior going to cause more write amplification? Meanwhile
for non-RST cases, NOCOW should cause the least amount of write
amplification.



So again, YES, I know doing proper write map and inserting RST entries
for preallocated range makes no sense for READ.
But preallocation and NOCOW is utilized for contents we frequently
over-writes, and such RST entries save us more for those frequently
over-writes.

Thanks,
Qu
>
> [3] the physical copies starting at 298909696 on devid 1 and 277938176
> on devid 2
>
>


