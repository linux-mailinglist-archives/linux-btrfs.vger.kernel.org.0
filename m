Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAF32479A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 00:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhBXXqB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 18:46:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:46337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhBXXp6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 18:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614210263;
        bh=U1sJNrxPN9haBy0ghPiFgq7iBFP65syHB4yzxlXmQn8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=S+VlpHSOXng1tHTFcUsp7X/47FV9z92dLjlKnjQXMD83zrGgmnbFF3fyI2Dt6C2JR
         hHf3G/97UcCmwu9KOhJ/bswBJLeLm6138zpgKv8bQSrEE/nnJuLZc7QFTpSTxMFYgu
         ZhYqaA61Fymd2D29jjFzCsaXeMpGEgpHL5LevQh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacSY-1lpmUX0KgE-00c9Ww; Thu, 25
 Feb 2021 00:44:23 +0100
Subject: Re: [PATCH] btrfs: do more graceful error/warning for 32bit kernel
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>
References: <20210220020633.53400-1-wqu@suse.com>
 <20210224191823.GC1993@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <550d771d-f328-8d37-b1a0-1758e683b1ca@gmx.com>
Date:   Thu, 25 Feb 2021 07:44:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224191823.GC1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mW7a5x3rRpL0JuBbtywMXpV7xmh5YgDAjjBSzerAhTTPXfqILQP
 24pOf8yNN+3NLnREFhyf00g/oswsVmdiazMLNyH9mbn2aHdrXXhkQa4aHzP7+Hhhjki0ySn
 HiZ5FsNYe4VACD+2s505N+Lq7blCVJjBGWA5l/Odo6z7ngPt5uddSMKbGuPDvU3Qf1/fuHn
 hmao1bG+KGR7ha7UFcVpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vfRlUcB3zY4=:O8Qbt/Bpi9rI2Mz2cxJ1pU
 +r23uBU1QJixlfZ2uJgAh9ZrrWwRxkZHF26ITd1npHWoE8ZY0OFwrQtRoFpdx5hRXppyeiaTs
 Mt9uQbMUMxUAQGtpJIMoeTfx/0BpB+DD4E4/rspBOG36BWZ6FcCpBGXhA5pDNdlQEfKiYjv96
 79Sw88AB/i74fPOQzwCOsswHWpmGtozPU9KwZEXPK3Zc5jt2fqcR+rMFeYNnothlyxP84KkJZ
 +HaZ0LQqp8uOb9FZxXdAa9LSVQHXx23pYQDulXzV3Fr70/OqPLnDgU4OQ+BWianHx89UJO5+F
 VxSpqpaVObjDDdc3j9GbQunbU5NI8h6HewGZAxw8q5YRNBSZwM8SOCwyf9H42rqmmolWuH+WO
 zW7SQJs9ehjnarkwf4ZyOLOfb+flgvp6Pe5MpTQvwP1dJdj0CeaLnL2p7A0KO+f3Lz/HGWnHM
 MJvWOA2wUBl9XomJdaSr1aCRKAR8IyfpNCVSL8TvCOP9/69is7+ES2vfL7wsn93BLKJAQ/OyM
 8gNkfeEu2Ws0fhHZs5om4PL+iAejdbdFuit8CBq1X5jIhalwE6K2bYuXsKh8emdMMEU54RzRb
 5CM7nF2su9k8DjIVOW+vj4u6qbu26GW3goSW4xhxILMUm36piT1GVpKAQbZoUllVo2/F5Hd47
 5q3Nu/W2mkq0twELl/M/uRZqCbkSYUNNmHPsoRv31a4MmTXiBig3D7qnLr67C3lmP5miFX2jt
 JAlkTrpHfBZy6lHpwkWDmoepLs+WCMIljoOuxlctIprujOkKDzbWjCaTOp+gsSp//6lJPSs7p
 4fk2qDvaJZMifAfXmqgrHSnAkV+dox4AgXwmQpFwE/bz0dlr+dD5/6Fi0tE7I7ZS6Z4W9Ss93
 X5R6v+dQ3gEvea6QRr+g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/25 =E4=B8=8A=E5=8D=883:18, David Sterba wrote:
> On Sat, Feb 20, 2021 at 10:06:33AM +0800, Qu Wenruo wrote:
>> Due to the pagecache limit of 32bit systems, btrfs can't access metadat=
a
>> at or beyond 16T boundary correctly.
>>
>> And unlike other fses, btrfs uses internally mapped u64 address space f=
or
>> all of its metadata, this is more tricky than other fses.
>>
>> Users can have a fs which doesn't have metadata beyond 16T boundary at
>> mount time, but later balance can cause btrfs to create metadata beyond
>> 16T boundary.
>
> As this is for the interhal logical offsets, it should be fixable by
> reusing the range below 16T on 32bit systems. There's some logic relying
> on the highest logical offset and block group flags so this needs to be
> done with some care, but is possible in principle.

I doubt, as with the dropping price per-GB, user can still have extreme
case where all metadata goes beyond 16T in size.

The proper fix may be multiple metadata address spaces for 32bit
systems, but that would bring extra problems too.

Finally it doesn't really solve the problem that we don't have enough
test coverage for 32 bit at all.

So for now I still believe we should just reject and do early warning.

[...]
>>
>> +#if BITS_PER_LONG =3D=3D 32
>> +#define BTRFS_32BIT_EARLY_WARN_THRESHOLD	(10ULL * 1024 * SZ_1G)

Although the threshold should be calculated based on page size, not a
fixed value.

[...]
>> +#if BITS_PER_LONG =3D=3D 32
>> +void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
>> +{
>> +	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
>> +		btrfs_warn(fs_info, "btrfs is reaching 32bit kernel limit.");
>> +		btrfs_warn(fs_info,
>> +"due to 32bit page cache limit, btrfs can't access metadata at or beyo=
nd 16T.");

Also for the limit.

Thanks,
Qu
>> +		btrfs_warn(fs_info,
>> +			   "please consider upgrade to 64bit kernel/hardware.");
>> +	}
>> +}
>> +
>> +void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
>> +{
>> +	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
>> +		btrfs_err(fs_info, "btrfs reached 32bit kernel limit.");
>> +		btrfs_err(fs_info,
>> +"due to 32bit page cache limit, btrfs can't access metadata at or beyo=
nd 16T.");
>> +		btrfs_err(fs_info,
>> +			   "please consider upgrade to 64bit kernel/hardware.");
>> +	}
>> +}
>> +#endif
>> +
>>   /*
>>    * We only mark the transaction aborted and then set the file system =
read-only.
>>    * This will prevent new transactions from starting or trying to join=
 this
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b8fab44394f5..5dc22daa684d 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6787,6 +6787,46 @@ static u64 calc_stripe_length(u64 type, u64 chun=
k_len, int num_stripes)
>>   	return div_u64(chunk_len, data_stripes);
>>   }
>>
>> +#if BITS_PER_LONG =3D=3D 32
>> +/*
>> + * Due to page cache limit, btrfs can't access metadata at or beyond
>> + * MAX_LFS_FILESIZE (16T) on 32bit systemts.
>> + *
>> + * This function do mount time check to reject the fs if it already ha=
s
>> + * metadata chunk beyond that limit.
>> + */
>> +static int check_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
>> +				  u64 logical, u64 length, u64 type)
>> +{
>> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
>> +		return 0;
>> +
>> +	if (logical + length < MAX_LFS_FILESIZE)
>> +		return 0;
>> +
>> +	btrfs_err_32bit_limit(fs_info);
>> +	return -EOVERFLOW;
>> +}
>> +
>> +/*
>> + * This is to give early warning for any metadata chunk reaching
>> + * 10T boundary.
>> + * Although we can still access the metadata, it's a timed bomb thus a=
n early
>> + * warning is definitely needed.
>> + */
>> +static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
>> +				  u64 logical, u64 length, u64 type)
>> +{
>> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
>> +		return;
>> +
>> +	if (logical + length < BTRFS_32BIT_EARLY_WARN_THRESHOLD)
>> +		return;
>> +
>> +	btrfs_warn_32bit_limit(fs_info);
>> +}
>> +#endif
>> +
>>   static int read_one_chunk(struct btrfs_key *key, struct extent_buffer=
 *leaf,
>>   			  struct btrfs_chunk *chunk)
>>   {
>> @@ -6797,6 +6837,7 @@ static int read_one_chunk(struct btrfs_key *key, =
struct extent_buffer *leaf,
>>   	u64 logical;
>>   	u64 length;
>>   	u64 devid;
>> +	u64 type;
>>   	u8 uuid[BTRFS_UUID_SIZE];
>>   	int num_stripes;
>>   	int ret;
>> @@ -6804,8 +6845,17 @@ static int read_one_chunk(struct btrfs_key *key,=
 struct extent_buffer *leaf,
>>
>>   	logical =3D key->offset;
>>   	length =3D btrfs_chunk_length(leaf, chunk);
>> +	type =3D btrfs_chunk_type(leaf, chunk);
>>   	num_stripes =3D btrfs_chunk_num_stripes(leaf, chunk);
>>
>> +#if BITS_PER_LONG =3D=3D 32
>> +	ret =3D check_32bit_meta_chunk(fs_info, logical, length, type);
>> +	if (ret < 0)
>> +		return ret;
>> +	warn_32bit_meta_chunk(fs_info, logical, length, type);
>> +#endif
>> +
>> +
>>   	/*
>>   	 * Only need to verify chunk item if we're reading from sys chunk ar=
ray,
>>   	 * as chunk item in tree block is already verified by tree-checker.
>> @@ -6849,10 +6899,10 @@ static int read_one_chunk(struct btrfs_key *key=
, struct extent_buffer *leaf,
>>   	map->io_width =3D btrfs_chunk_io_width(leaf, chunk);
>>   	map->io_align =3D btrfs_chunk_io_align(leaf, chunk);
>>   	map->stripe_len =3D btrfs_chunk_stripe_len(leaf, chunk);
>> -	map->type =3D btrfs_chunk_type(leaf, chunk);
>> +	map->type =3D type;
>>   	map->sub_stripes =3D btrfs_chunk_sub_stripes(leaf, chunk);
>>   	map->verified_stripes =3D 0;
>> -	em->orig_block_len =3D calc_stripe_length(map->type, em->len,
>> +	em->orig_block_len =3D calc_stripe_length(type, em->len,
>>   						map->num_stripes);
>>   	for (i =3D 0; i < num_stripes; i++) {
>>   		map->stripes[i].physical =3D
>> --
>> 2.30.0
