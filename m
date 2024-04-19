Return-Path: <linux-btrfs+bounces-4457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB968AB6FB
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Apr 2024 00:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D0B1F22696
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E513D26D;
	Fri, 19 Apr 2024 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gTTcxIQI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17252AEF5
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564051; cv=none; b=XQOvxlEWyF2pTEpbhYd9lkQDtspIWxmNm7tMyQdAhPS0dnEbkZ8Tv5WUmMHHQ47MCpB3G7+owLB38YRHVi/qTHWgHa0FaFCnOZHYZrQRdi4u864j3EJSnTzT9Z47MSArIVuPdi4Na5erK+WEnw8dnledHi1KqA9qmWzymlZXLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564051; c=relaxed/simple;
	bh=HSwL/OYLQtrk8ji1SflEtLIsfj9f9c7RWSL9K6YUZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9eLtHeCsFFUhP5GX53Q38VGrso0Icz92vqwIZMReV8Jm0hqBAjqNVJvm30SyXyTf+w0Kt1hojvdThnkMymuHClbVHDoFWMseP3qVTgdt3z8ECW6TEszII2YCAWl5WYIJ6J5KJ8NZZoNwvFdj6+dQEDofh3gmqQKO/DqyBj7lQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gTTcxIQI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713564045; x=1714168845; i=quwenruo.btrfs@gmx.com;
	bh=aLQgAiuzC99AmxlBwKqm9VrplCUBn9fflVyB0JvLhvA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gTTcxIQIQgaN7JWn+cHIbNdm9YuUBkB6PkmCXQH/8ar/JNx3xkcJAYbqB1Q4Ganr
	 CExjm4BKWHT+r/Py76VfnkWzN8VkGWzMhi3+Ri9KmOsf0iqoZDLhfDQUNwJe3SJ7Q
	 ILNwL27c1O5Q11HjmS8jb3Zil9IWQqzT8g35xaRjO5bd7pkIZOy9edL+hsMj8igwm
	 tXin2bB7F3y3sCa/ThG4+LcKnLMz/95P5gZpatCBrP8ghYADVuCp8DWDG/18VuELl
	 7PWFtEPApguQHevgnekADw3DYTbhjBJ8m5S880S81Jt8u7+aSKtD8qc1Nbwro3+TY
	 R93UAz8jREwJ4p6CqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWAOQ-1sChE62M4w-00XbV2; Sat, 20
 Apr 2024 00:00:45 +0200
Message-ID: <430b7a16-621c-4aae-a94c-bb3d0124ae96@gmx.com>
Date: Sat, 20 Apr 2024 07:30:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of
 btrfs_split_ordered_extent()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1713329516.git.wqu@suse.com>
 <20240419172932.GC3492@twin.jikos.cz>
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
In-Reply-To: <20240419172932.GC3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7N4DYbwhN/kgWhwxyVxNZj9XhWg48kf4/zD5ZB1/sy0tBoMN5Mp
 AXaJ98FYpzNAVnt9UqPzuata3wWupvtg3q2iVxD3f2cYT29bZs61d8wwo4nSOW6kRu82zi6
 bf1PCvUVrBjEag6YkMKiVAhDiKAhw+YbQJMi5Th8Xc1xKcA3Fgma4yMNLcciEtyhlVBVK9h
 7BPbuFbDupO7qJNF4OD8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g4xWP6U5W7I=;Xz3ag1p82yQqMFfGN29dIfmAIn2
 ToYmxzx5bFWSUyKria1Wci0BhoVBjAY/e8euDahRtlTFrgnYeDeXeCPyDcp1FNkEarQhaIH3B
 QEfyqhTOvKFxGA9hw9D8nfm8YkniMHfsWMhQzDiAVXbq0gvken8Bj6FX3lriqzuHJSmE579r1
 DGyqgL1MV/Bslga2Mdu+xFUnoB2vckdJS5wScoRi3VT6dpwG5pdeyWJp0aE3/daDBatowHSEP
 Z3y3b217FQk9y7SpcKiQli3JhMwL+ZUdslucDV4DLlt5u7TDAJEJ+VQg+EyoKJ+xFypIhrg64
 GReOwk3AJK4HtSLa/HVye8hopP4YmD5JaaoLBCIKJH7J5JVJwF51vy9OdUNQHpIc7vfgXB/pR
 /BSveqOQ4fNFQlu5CZ7rYqimWIOfat+zeVfZRcrAuPQKo7pxHl/nXD8Zl6g3/upJapLBZKJHp
 3/Vrm3bk9tYpZmHB9CpsO2jockf/bbzbTn+aodDyfwZ8ANSyJwSg0fNj4zV6QoHxQUHPmwGr1
 E7F/S7IGoDZz99zBo7wQzNQ3OAT8jhTuaf34Tx2SXoEtvm4TiJM0oBi8dJSXLLyB5p/ffT+JI
 5ioxOWWuNHmADvg9FEJLDh9ThGJGvk43/UaANRRwi+Kxs2b7syISVzXFUwv0OcZxV50+5Z1BU
 UixKpmMPIUpZb2LmXWiwBNk0uRu7I5OhNbVpUuokwNHpLeaA7rR5BlmO9/QI2sUpgXSo3bdpJ
 HxZFAk1Tve010w0J7BXAzefOx5HP6A4Y3vS2yscja6USnojcbaw6BTpRlhfFfZ34tKFvv7WmV
 mdkMBKpyBoKVs/19Z+VLvyn/iLjsnd3+a8q8N+w9a+yQg=



=E5=9C=A8 2024/4/20 02:59, David Sterba =E5=86=99=E9=81=93:
> On Wed, Apr 17, 2024 at 02:24:37PM +0930, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Update the comment on file extent item tree-checker
>>    To be less confusing for future readers.
>>
>> - Remove one fixes tag of the first patch
>>    The bug goes back to the introduction of zoned ordered extent
>>    splitting, thus that oldest commit should be the cause.
>>
>> During my extent_map members rework, I added a sanity check to make sur=
e
>> regular non-compressed extent_map would have its disk_num_bytes to matc=
h
>> ram_bytes.
>>
>> But that extent_map sanity check always fail as we have on-disk file
>> extent items which has its ram_bytes much larger than the corresponding
>> disk_num_bytes, even if it's not compressed.
>>
>> It turns out that, the ram_bytes > disk_num_bytes is caused by
>> btrfs_split_ordered_extent(), where it doesn't properly update
>> ram_bytes, resulting it larger than disk_num_bytes.
>>
>> Thankfully everything is fine, as our code doesn't really bother
>> ram_bytes for non-compressed regular file extents, so no real damage.
>>
>> Still I'd like to catch such problem in the future, so add another
>> tree-checker patch for this case.
>>
>> And since the invalid ram_bytes is already in the wild for a while, we
>> do not want to bother the end users to fix their fs for nothing.
>> So the check is only behind DEBUG builds.
>
> For testing this is OK, but would it make sense to fix the wrong values
> automatically?
>

I'm also thinking about this, two alternatives, but neither is perfect:

- Fix the value at eb level, aka, updates the ram_bytes directly at read
   time
   This should fix the problem forever, but it has its own problems
   related to read-only mounts.
   If we do not do the fix for RO mounts, then remounting to RW, and we
   would have cached result untouched.
   But if we do, we're modifying ebs, how to write them back for a full
   RO mounts (e.g. rescue=3Dall)?

- Only fix the extent_map::ram_bytes value
   This is not going to change anything on-disk.

And considering this "problem" has no real chance for corruption, I do
not believe we need all those hassles.

My plan to repair the mismatch would all be inside btrfs-progs, after I
have pinned down other call sites resulting smaller ram_bytes than
disk_num_bytes.

Thanks,
Qu

