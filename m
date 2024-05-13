Return-Path: <linux-btrfs+bounces-4945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4098C49A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323111C212DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7A84DF3;
	Mon, 13 May 2024 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HOjKXgxI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CC8405D
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639659; cv=none; b=L6gR3crlc14PEiMtHmgvJJb8bpbasXBhY+ufMSp+jUpd86LOcI6X5NEGOBCbojK/3SHZ7OYaT5EZEjghxy1mQtB95xV/TpI4B0tOfOhIcMCWPlsHPJusA7n7dzt0VLBG+0xfti2l/zkxrmKB+wsAC/Iytgogzg83kQ7jabDtzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639659; c=relaxed/simple;
	bh=tIAO5MIx1xdCn+aTOi9TOC1z681qxrGEoVIRc4wV1l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NW04xhEoSbC/r0SmjHHt3+/NwZlGPzDpQmbOZPobDnmlEVL1/MDGYW3pONj0ZOn0MXxkOfTjdvlTAzoAgJJDHlkxnoVtQAoCKtsGB/PI5MSopSueNJS9sF2ZdWVq5r09DkWkXj6zAMszha53LOYkk2/I4TaIO31B4SBala9SdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HOjKXgxI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715639650; x=1716244450; i=quwenruo.btrfs@gmx.com;
	bh=dnEwzAdRELbEYIeDWzblgvNQiBhG8PrOP5YAgTWyDNw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HOjKXgxIw3N8uQGym3KDMRfT9JKKamkHGGpoh0Q/aiqJ91MeyozdKuJdmWsk4/to
	 zkgOBAu2NlQh2CDwgav6/iSFcFugx86/x0k209CnScuJ1UttMcYbg+hWvYPtKaeBf
	 niDoPh12yTxZie7zsIkhlDQ2/WOYl03nw/JwPgIZOTdz6RqK0Imr7bWsmcNnGXMNY
	 zB8nH/mKeIzCdzcoUFUAbf+im/A8zszDkXqRkV2HQJJTgNVgUcEDWuQD7jkLrliib
	 IosSTi9Or3M/UgRWpXmeqESCG0ERN+cgAgZvMDTxmrTc3+tQhEqva2nhOyBLCXYf1
	 bgtJ6g9jRAOUYUrPlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDysg-1sGZrZ0by8-00B85b; Tue, 14
 May 2024 00:34:09 +0200
Message-ID: <cb485082-3361-4b3a-bf7d-5b5465da10dd@gmx.com>
Date: Tue, 14 May 2024 08:04:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] btrfs: introduce extra sanity checks for extent
 maps
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <23eef0d1cc8c482121d6958b3c131ba51648cde6.1714707707.git.wqu@suse.com>
 <CAL3q7H7BPGFcAaqhcAO2vNax8ShhbFm=HcXbvODa-GJshuSs2A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7BPGFcAaqhcAO2vNax8ShhbFm=HcXbvODa-GJshuSs2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aBpiXQCqT9MkxkzlHeGlaX1mVpiZCnCAWpCXlNHXJuys9BBIHxn
 Uo0Di0NOq4ANkYx7BlXJqSah9epR1SXGPiWjFxqSrQwGO94fjhptY0u3+2C5HRL8wR9fTE7
 lsKnjasj0RC3xeaNKo3NiGfmOaynWyHnr/YRrxBk43KbG9ylR9Hwn3RbljEaKIH0IItSFVC
 ExWX7Mix6/Jnsz9xGpmQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3GjP8EH2d1M=;PiDp4O7vlVtdaQLoSrCDevaxaz4
 APJt6vz8pWbMfWQcCeA+wR24U1//0pq0B3rG5eVfP6jpB7pzk9zatrwodm7pyhvI9l59qvv27
 7q17jmLddNUwpAWbqwMAf1pRiuJL9C9kjvJErYp+Y68gR4Y6K+Vx42zj4DvFtBYDW5BwGyjvH
 m8g59SNIU9TllWX5FKq6pERqZgLCFHQaldWbqY70ccxqeo/5uG3Fh0TEzHOHw2/nLLdgDrcwz
 oR742OKY1VPQEL7lbEin4dv6nCivT9G5BTKU/MeF6nSQeYxHoNoRHtj3hemuyKav9HYhQx6dq
 ZWNZt4sLQuLXa8W6ISQUzd1aKKsREK8asar0HKHFXB6CkE8sI/H8Qufm8qgKd0nPyscLd5xBU
 BkWgFbP9CRwt7YLscrnr5lyr4VJpaOPJnatiWP4Gi4aERqJZuYuIL14fd6r2y7OgAcpxvg0W9
 UzPl35cyn6MCxGKKzExfbHdAgJXQbw/eryYhKsIq6jVElW/XzYsC9LFu3vwMssqzdX4bbuKrY
 zj+mIPpdLxmVUIWUAxuD1Flo4kqWZKultc7EArXDTE6uwaYLgfwYwIoKoKyea1ye6CmXLZ3nv
 7Vhq+1TmuM+6UL3phnSA+Sd9FMPlwi50Zw/Q93fz0Mh2rp5SuRqhmqQg5uf9ITlvXyVJNhAhy
 AYVKbVKYwcLmGFOPxzT1LApopuzutkKseEt1KXQ/61fPsZdIHKeo90bi1ntpIE1T+5tv1s2Ab
 tv8x5WO1lyr0YVvH+iwQSmvhOB8Jssc7Y3Nc/7yg2LUdN9wbCkOFf0NIkHz1CxA57TsBc4HZz
 ANOF9Z76Dy5U8ZXV81d0UDaNGm2elfNY7coKTAVhSArnw=



=E5=9C=A8 2024/5/13 21:51, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, May 3, 2024 at 7:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Since extent_map structure has the all the needed members to represent =
a
>> file extent directly, we can apply all the file extent sanity checks to=
 an extent
>> map.
>>
>> The new sanity checks would cross check both the old members
>> (block_start/block_len/orig_start) and the new members
>> (disk_bytenr/disk_num_bytes/offset).
>>
>> There is a special case for offset/orig_start/start cross check, we onl=
y
>> do such sanity check for compressed extent:
>>
>> - Only compressed read/encoded write really utilize orig_start
>>    This can be proved by the cleanup patch of orig_start.
>>
>> - Merged data extents can lead to false alerts
>>    The problem is, with disk_bytenr/disk_num_bytes, if we're merging
>>    two extent maps like this:
>>
>>      |<- data extent A -->|<-- data extent B -->|
>>                |<- em 1 ->|<- em 2 ->|
>>
>>    Let's assume em2 has orig_offset of 0 and start of 0, and obvisouly
>>    offset 0.
>
> obvisouly -> obviously
>
> I'm confused. How can em2 have a "start" of 0?
> By "start" you mean file offset I suppose, since that's what it is
> before this patchset. That would mean em 1 would have a negative
> "start".

My bad, I screwed up the example numbers.

For "offset" I mean the the offset inside the data extent, aka,
"btrfs_file_extent_item::offset"
And for "start" I mean filepos, aka the key.offset.

And in above case, it's all dependent on the filepos of the em1/em2.

I would change the example to something like this:

em1: file pos 4k, len 4k, extent offset 4k, ram bytes 8k, disk_bytenr X,
disk_num_bytes 8K, compress none.

Then it's orig_start should be 0.

em2: file pos 8k, len 4k, extent offset 0, ram_bytes 8K,
disk_bytenr X + 8K, disk_num_bytes 8K, compress none.

And its orig_start should be 8K.

>
> And by "offset" you mean extent offset?
>
>>
>>    But after merging, the merged em would have offset of em1, screwing =
up
>
> But this suggests that by "offset" you mean file offset and not the
> offset within an extent's range.

No, I still mean "extent offset".

As the "merged" em would be:

em merged: filepos 4k, len 8K, extent offset 4K, ram_bytes 16K,
disk_bytenr X, disk_num_bytes 16K, compress none.

Thus the orig_offset would be still be 0, the same as the em1 before
merging.

> So did you mean "start" here?
>
>>    whatever the @orig_start cross check against @start.
>>
>> The checks happens at the following timing:
>>
>> - add_extent_mapping()
>>    This is for newly added extent map
>>
>> - replace_extent_mapping()
>>    This is for btrfs_drop_extent_map_range() and split_extent_map()
>>
>> - try_merge_map()
>>
>> Since the check is way more strict than before, the following code has
>> to be modified to pass the check:
>>
>> - extent-map-tests
>>    Previously the test case never populate ram_bytes, not to mention th=
e
>>    newly introduced disk_bytenr/disk_num_bytes.
>>    Populate the involved numbers mostly to follow the existing
>>    block_start/block_len values.
>>
>>    There are two special cases worth mentioning:
>>    - test_case_3()
>>      The test case is already way too invalid that tree-checker will
>>      reject almost all extents.
>>
>>      And there is a special unaligned regular extent which has mismatch
>>      disk_num_bytes (4096) and ram_bytes (4096 - 1).
>>      Fix it by all assigned the disk_num_bytes and ram_bytes to 4096 - =
1.
>
> Looking at the diff for test_case_3(), I don't see any assignment of
> 4096 - 1 anywhere.
> All the assignments I see have a value of SZ_4K or SZ_16K.

It's in fact setup_file_extents() from inode-tests.c, I got confused
with other fixes.

>
>>
>>    - test_case_7()
>>      An extent is inserted with 16K length, but on-disk extent size is
>>      only 4K.
>>      This means it must be a compressed extent, so set the compressed f=
lag
>>      for it.
>>
>> - setup_relocation_extent_mapping()
>>    This is mostly utilized by relocation code to read the chunk like an
>>    inode.
>
> Not "mostly" - it's exclusively used by the relocation code.
>
>>    So populate the extent map using a regular non-compressed extent.
>
> Isn't that what we already do? I'm confused.
> We are already creating a regular non-compressed extent, and all the
> diff does is to initialize some fields unrelated to that.

It's more like initializing the remaining members, or those
uninitialized members would not pass cross-check.

I guess I should put the missing initialization where I introduced them?

>
>>
>> In fact, the new cross checks already exposed a bug in
>> btrfs_drop_extent_map_range(), and caught tons of bugs in the new
>> members assignment.
>
> I remember one bug in btrfs_drop_extent_map_range(), which fortunately
> didn't have any consequences.
> Those tons of bugs you mention are only in the code added by the
> patchset if I understand you correctly.

Isn't that why I mention is as "in the new members assignment"?

Or should I just drop the mention completely?

Thanks,
Qu

