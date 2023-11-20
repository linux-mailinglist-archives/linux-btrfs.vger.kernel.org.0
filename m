Return-Path: <linux-btrfs+bounces-205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A97F1DFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBDB1C211DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98D374E0;
	Mon, 20 Nov 2023 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PRllUffr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8717C7
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 12:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700511940; x=1701116740; i=quwenruo.btrfs@gmx.com;
	bh=bc6netv4urZODj2PyMPV3kP8R/zLZcobC7wRRyWelz4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PRllUffr/9+5jSkVRAKQfdC4mKWDW8QkA9OblDacO+Zo/frA6wODdEoHSb2a5aGZ
	 HX/zbKI2EYo3dlzJ8KXAc4+A4DrCdOAWrmep6udqNcrhcUqIIqb59RCBQp9qq1yhj
	 Cf3z7Dld+NJhej/3uPMogfvW3a5isMsYOqfQHrC2SqEMBu1FrVaO8/52bhbVrYiIU
	 0fXe4xbKz3HuPPGnWL8LQPQdcz2HazEEWQxOrra4XVxrrd9IWyMYobu38znTPrk55
	 qo98y2KGNgZXjUj3I5gEXe5B2wDUyu1p5c/wF/+XIp4c0N5Ox0KbDc4PxKQFs0Dqn
	 zYYR6Dq2JOzjZdqixg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlf4S-1rmWHJ26N8-00ioI0; Mon, 20
 Nov 2023 21:25:40 +0100
Message-ID: <a73faeae-1925-4894-9512-7a049ff8353b@gmx.com>
Date: Tue, 21 Nov 2023 06:55:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip cross-page
 handling
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231120170015.GM11264@twin.jikos.cz>
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
In-Reply-To: <20231120170015.GM11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sp09LahtgtVggcbjKVcOYRGJIUU5+UMGKvIvjxI4lw0bcJ4DYBb
 2Lp5yrF/qOk5szJYUlbQcScidQjArQJQB39yaAVehFwKLlUEn/nnPh1XkbspN2SjE3IJeIK
 baBiwkD2o4sCBqXAVvYH5vJZZdCAceF9JAjYmilgrNMb0Vt6yVzkNAdQWS+yZQXvAmUS+Ie
 6IgRCo6GyNFvZCNa0kjSQ==
UI-OutboundReport: notjunk:1;M01:P0:5bJeMTpYqss=;rUZQckHp4/+DdadFGwFbxe8wSBA
 CST7FPvA4tZUkkRVAaROTLjAPfZ/NZeGClvKoZWyAT8U8op6XY7C1ArlGq0NoPf1CsKPqTxIq
 lpT165nT55yEkNZkGmpBdchThAJGdgbD47zUqlWc5PUZDUtVGiedaC47InsXYe66mAjvvv1fE
 mRhoLZo8YACrY/cx+WkIiMxSuUQFg8Z8Tq5QIiBDRRmJgZSsr9Nuze8q3xSI6dAkl0Y8G/anL
 PvTfQ1e4b8PzSxxEpwmtiVhvE91PkdPB1vHa8Hjer3J+/CSwgcn2LUjHEK+EUmmUhIwXgghIC
 iaQ8CA1kZ7MlKrRlGf6B8rV6IrJjugEgj5keX3apYxYUmHXfz+dZCVdACgAFK6DI2bVH6t6lQ
 +okYOmAbQueQ3WU8ZrxctuahGenelwhsEjEyS7yrqU7bYGFCwwSY/sh8hThH5i/Y3w1WqDGE/
 goA0Q0+6sPMEkD5k58eQNpG1rQH4mxYvlYHkBzUrpR1shgnLM4dp51Ozu5WdlAc9LpNU9TjcW
 eWsvvrJELhW4FRzUswTDeHELMQkVSQUuP9C3RaRDsgfN2haAyY5cEroHG6/C3y8frrFifa0+/
 FgpyrqnHcw2yL3iiqfcnxU0vGhUK897y59G62NdSyc7nw/tnNRnVlmREu+9N+mF8MKcRvlmcE
 Yx2wv7MXMfrEeF07Rug7BZFJfZqUzeiORQSes6Q39HHZGWf3pzBjFb7VEweRHgiPNNOt3r/Fs
 m5EfYQOADkVzRpluc+ujc5tAXsvibZgWQYipZRUr7FLpeENHZvH6fg5tUPyWDd2BgSp1LXfH6
 BlYjKG2mAHxrLn4SJG7FHSSBxV3F1L5LCK/PlK0+GNnqNHQisMPkjk083RMD8sEU2huHvb7FO
 t22nQZ0m920MWXIrM0F/srDG9taYCpGQlVrQCHdAo2sKQ6XuAG3I+ctt8C1Wg3x5yOPcZpmD/
 ckAc7gPFLe+WZNFOEPeKMrC6dAw=



On 2023/11/21 03:30, David Sterba wrote:
> On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
>> Currently btrfs extent buffer helpers are doing all the cross-page
>> handling, as there is no guarantee that all those eb pages are
>> contiguous.
>>
>> However on systems with enough memory, there is a very high chance the
>> page cache for btree_inode are allocated with physically contiguous
>> pages.
>>
>> In that case, we can skip all the complex cross-page handling, thus
>> speeding up the code.
>>
>> This patch adds a new member, extent_buffer::addr, which is only set to
>> non-NULL if all the extent buffer pages are physically contiguous.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> This change would increase the code size for all extent buffer helpers,
>> and since there one more branch introduced, it may even slow down the
>> system if most ebs do not have physically contiguous pages.
>>
>> But I still believe this is worthy trying, as my previous attempt to
>> use virtually contiguous pages are rejected due to possible slow down i=
n
>> vm_map() call.
>>
>> I don't have convincing benchmark yet, but so far no obvious performanc=
e
>> drop observed either.
>> ---
>>   fs/btrfs/disk-io.c   |  9 +++++++-
>>   fs/btrfs/extent_io.c | 55 +++++++++++++++++++++++++++++++++++++++++++=
+
>>   fs/btrfs/extent_io.h |  7 ++++++
>>   3 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 5ac6789ca55f..7fc78171a262 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *bu=
f, u8 *result)
>>   	char *kaddr;
>>   	int i;
>>
>> +	memset(result, 0, BTRFS_CSUM_SIZE);
>>   	shash->tfm =3D fs_info->csum_shash;
>>   	crypto_shash_init(shash);
>> +
>> +	if (buf->addr) {
>> +		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + =
BTRFS_CSUM_SIZE,
>> +				    buf->len - BTRFS_CSUM_SIZE, result);
>> +		return;
>> +	}
>> +
>>   	kaddr =3D page_address(buf->pages[0]) + offset_in_page(buf->start);
>>   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>>   			    first_page_part - BTRFS_CSUM_SIZE);
>> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf=
, u8 *result)
>>   		kaddr =3D page_address(buf->pages[i]);
>>   		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>>   	}
>> -	memset(result, 0, BTRFS_CSUM_SIZE);
>
> This is not related to the contig pages but the result buffer for
> checksum should be always cleared before storing the digest.

This just get moved before the branch, as that clearing is shared for
both cross-page and contig cases.

>
>>   	crypto_shash_final(shash, result);
>>   }
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 03cef28d9e37..004b0ba6b1c7 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3476,6 +3476,7 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>>   	struct address_space *mapping =3D fs_info->btree_inode->i_mapping;
>>   	struct btrfs_subpage *prealloc =3D NULL;
>>   	u64 lockdep_owner =3D owner_root;
>> +	bool page_contig =3D true;
>>   	int uptodate =3D 1;
>>   	int ret;
>>
>> @@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
>>
>>   		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
>>   		eb->pages[i] =3D p;
>> +
>> +		/*
>> +		 * Check if the current page is physically contiguous with previous =
eb
>> +		 * page.
>> +		 */
>> +		if (i && eb->pages[i - 1] + 1 !=3D p)
>> +			page_contig =3D false;
>
> This hasn't been fixed from last time, this has almost zero chance to
> succeed once the system is up for some time.

I have the same counter argument as the last time.

If so, transparent huge page should not work, thus I strongly doubt
about above statement.

> Page addresses returned
> from allocator are random. What I was suggesting is to use alloc_page()
> with the given order (16K pages are 2).

Nope, this patch is not intended to do that at all.

This is just the preparation for the incoming changes.
In fact alloc_page() with order needs more than those changes, it would
only come after all the preparation, including:

- Change how we allocate  pages for eb
   It has to go allocation in one-go, then attaching those pages to
   filemap.

- Extra changes to how concurrent eb allocation

- Folio flags related changes
   Remember a lot of folio flags are not applied to all its pages.

>
> This works for all eb sizes we need, the prolematic one could be for 64K
> because this is order 4 and PAGE_ALLOC_COSTLY_ORDER is 3, so this would
> cost more on the MM side. But who uses 64K node size on x8_64.

As long as you still want per-page allocation as fallback, this patch
itself is still required.

All the higher order allocation is only going to be an optimization or
fast path.

Furthermore, I found this suggestion is conflicting with your previous
statement on contig pages.
If you say the system can no longer provides contig pages after some
uptime, then all above higher order page allocation should all fail.

>
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -77,6 +77,13 @@ struct extent_buffer {
>>   	unsigned long len;
>>   	unsigned long bflags;
>>   	struct btrfs_fs_info *fs_info;
>> +
>> +	/*
>> +	 * The address where the eb can be accessed without any cross-page ha=
ndling.
>> +	 * This can be NULL if not possible.
>> +	 */
>> +	void *addr;
>
> So this is a remnant of the vm_map, we would not need to store the
> address in case all the pages are contiguous, it would be the address of
> pages[0]. That it's contiguous could be tracked as a bit in the flags.

It's the indicator of whether the pages are contig.

Or you have to check all the pages' address then determine if we go fast
path everytime, which is too slow afaik.

Thanks,
Qu

>
>> +
>>   	spinlock_t refs_lock;
>>   	atomic_t refs;
>>   	int read_mirror;
>> --
>> 2.42.1
>>
>

