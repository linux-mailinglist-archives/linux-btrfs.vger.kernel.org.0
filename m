Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33420325A60
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 00:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhBYXp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 18:45:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:54681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhBYXpU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 18:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614296620;
        bh=tLIbjF/GAcFHyQW9t2XRVbMK0NrRR9xwDB8TML0f0tg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HA3jFUnxjBLRYcqyyNZBeusgpLPVAi8prJqUGYIjwClBA3xyxQliEhwITlr6eZO6v
         2mPwp1FgTn94JXmaiaHptm2ctpykk0H4Tu/8SOhsbHtmVuqcgBtb80GuEkBb5foCPw
         aYGvLQPKbd46XzTO1zgT5oVLHtHcvLhFqcxCjpG0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDhhN-1l8VbA1ukh-00ArO1; Fri, 26
 Feb 2021 00:43:40 +0100
Subject: Re: [PATCH] btrfs: do more graceful error/warning for 32bit kernel
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>
References: <20210220020633.53400-1-wqu@suse.com>
 <20210224191823.GC1993@twin.jikos.cz>
 <550d771d-f328-8d37-b1a0-1758e683b1ca@gmx.com>
 <20210225153443.GD7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <47f12020-b3c1-0f05-53c2-6b3230dd6bc8@gmx.com>
Date:   Fri, 26 Feb 2021 07:43:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225153443.GD7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EZEVB+mahJvB8KUz+AtqRSEukBjpfp71TkbCjyA4UhVwcjG3D77
 hUYfvDiJ9v6waVvP8NyiOhaW08aisZkJTy2FN8vwozcwu0AIlhGfK/s4tDqDHmmsUiBU0lQ
 OU1F1HuWd1JPDn7rpDu0IyWaKe1RtpNp4lkxWAxHbMG/hAl9L6nIkBeMP9iuWpLMoNZCzEe
 bkzT73r2HjeoNmB/piXSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8x4GqigEn8o=:2ka3H0SsmgqaXwNZPhskAa
 h1PUxzLav0/3AUNIATM6OZDBElDgUTM/XZc9m1MAtNtKmtO46KiHbLls4XPiFf02YWuA3rsrN
 M603Of+U7rE2YoEq+pAbMRyms5+JLewyHd3Fctev96LlMlYK86oAgjEj/6nj2snhLRTOutmVr
 mx+50GuTGu3KefVLbAf/M1HEMsWXBbHX/mR2P/Je/JbnkI6RlL9SDMWMaEMBkFQG+N9JTzvGC
 azSESdnlRT4kzdOuqOvsbNCmNO/mtkG8ZUNdr5Zsjahv7a9wjUAYLXP7a1gmOOjQBj+isSmAY
 +XAq9AWFOHChAi25VThSKjHObmyikHmYhhda+vcXPV00wh/TYjjrvjgvJiBBhQFsUABrhrnxW
 cE0sw4t5Gi4hoTfW59MDC4vdigSLSJEZFaiC169y8mYnOb0OKn7iUtGvD+EfoLvo8kEYa1VEx
 mkWl1yvmch0CqccyBS1D0R6aYTCPqrYYWU+eAL/bQ8iTqkOh9n+Yjte9CPkV4KYzGUd4anIe+
 1HSPm6nqU4n1biOKvDzcLyUVOzqvfJ80illGq5tCqQzFjdGMas54CXTUJrLhL7rg0Pd7xQIRj
 aIWtfZ9WDPe0+TGQ/izB1K6uTkxwAVl3Uf6Zp/BI/mxpmnbpyzXsFIFXLXhmtbjTVbNFAQGNd
 +7XC/OOqZf5CoiSM8F6KXcDmWa+jZcu78runJ2kiKg+OwTq33kDE4Gtb54qvR3IqTEJ8KOcZf
 cn2JbgqqKa9sOLXNInJUtbrUO+2RCCv5QB+hyteAU+xsgUQ2ZcLFvbbFNp2QvXHEHp3Tgsh59
 OmXgAcZps3xrlGY73D6l9Tb2JlUvXKaXEr3d6CIzSZ96RhtnqpzEKQ+PbEcuKugRWzX2Ch+Vq
 OO+MhUqVgacy0u1HLX+A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/25 =E4=B8=8B=E5=8D=8811:34, David Sterba wrote:
> On Thu, Feb 25, 2021 at 07:44:19AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/2/25 =E4=B8=8A=E5=8D=883:18, David Sterba wrote:
>>> On Sat, Feb 20, 2021 at 10:06:33AM +0800, Qu Wenruo wrote:
>>>> Due to the pagecache limit of 32bit systems, btrfs can't access metad=
ata
>>>> at or beyond 16T boundary correctly.
>>>>
>>>> And unlike other fses, btrfs uses internally mapped u64 address space=
 for
>>>> all of its metadata, this is more tricky than other fses.
>>>>
>>>> Users can have a fs which doesn't have metadata beyond 16T boundary a=
t
>>>> mount time, but later balance can cause btrfs to create metadata beyo=
nd
>>>> 16T boundary.
>>>
>>> As this is for the interhal logical offsets, it should be fixable by
>>> reusing the range below 16T on 32bit systems. There's some logic relyi=
ng
>>> on the highest logical offset and block group flags so this needs to b=
e
>>> done with some care, but is possible in principle.
>>
>> I doubt, as with the dropping price per-GB, user can still have extreme
>> case where all metadata goes beyond 16T in size.
>
> But unlikely on a 32bit machine. And if yes we'll have the warnings in
> place, as a stop gap.
>
>> The proper fix may be multiple metadata address spaces for 32bit
>> systems, but that would bring extra problems too.
>>
>> Finally it doesn't really solve the problem that we don't have enough
>> test coverage for 32 bit at all.
>
> That's true and it'll be worse as distributions drop 32bit builds. There
> are stil non-intel arches that slowly get the 64bit CPUs but such
> machines are not likely to have huge storage attached. Vendors of NAS
> boxes patch their kernels anyway.
>
>> So for now I still believe we should just reject and do early warning.
>
> I agree.
>>
>> [...]
>>>>
>>>> +#if BITS_PER_LONG =3D=3D 32
>>>> +#define BTRFS_32BIT_EARLY_WARN_THRESHOLD	(10ULL * 1024 * SZ_1G)
>>
>> Although the threshold should be calculated based on page size, not a
>> fixed value.
>
> Would it make a difference? I think setting the early warning to 10T
> sounds reasonable in all cases. IMHO you could keep it as is.

The problem is page size.

If we have 64K page size, the file size limit would be 256T, and then
10T threshold is definitely too low.

So in the submitted v2, the threshold is changed to 5/8 of the max file
size.

Thanks,
Qu

>
>> [...]
>>>> +#if BITS_PER_LONG =3D=3D 32
>>>> +void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
>>>> +{
>>>> +	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
>>>> +		btrfs_warn(fs_info, "btrfs is reaching 32bit kernel limit.");
>>>> +		btrfs_warn(fs_info,
>>>> +"due to 32bit page cache limit, btrfs can't access metadata at or be=
yond 16T.");
>>
>> Also for the limit.
>>
>> Thanks,
>> Qu
>>>> +		btrfs_warn(fs_info,
>>>> +			   "please consider upgrade to 64bit kernel/hardware.");
>>>> +	}
>>>> +}
>>>> +
>>>> +void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
>>>> +{
>>>> +	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
>>>> +		btrfs_err(fs_info, "btrfs reached 32bit kernel limit.");
>>>> +		btrfs_err(fs_info,
>>>> +"due to 32bit page cache limit, btrfs can't access metadata at or be=
yond 16T.");
>>>> +		btrfs_err(fs_info,
>>>> +			   "please consider upgrade to 64bit kernel/hardware.");
>>>> +	}
>>>> +}
>>>> +#endif
>>>> +
>>>>    /*
>>>>     * We only mark the transaction aborted and then set the file syst=
em read-only.
>>>>     * This will prevent new transactions from starting or trying to j=
oin this
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index b8fab44394f5..5dc22daa684d 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -6787,6 +6787,46 @@ static u64 calc_stripe_length(u64 type, u64 ch=
unk_len, int num_stripes)
>>>>    	return div_u64(chunk_len, data_stripes);
>>>>    }
>>>>
>>>> +#if BITS_PER_LONG =3D=3D 32
>>>> +/*
>>>> + * Due to page cache limit, btrfs can't access metadata at or beyond
>>>> + * MAX_LFS_FILESIZE (16T) on 32bit systemts.
>>>> + *
>>>> + * This function do mount time check to reject the fs if it already =
has
>>>> + * metadata chunk beyond that limit.
>>>> + */
>>>> +static int check_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
>>>> +				  u64 logical, u64 length, u64 type)
>>>> +{
>>>> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
>>>> +		return 0;
>>>> +
>>>> +	if (logical + length < MAX_LFS_FILESIZE)
>>>> +		return 0;
>>>> +
>>>> +	btrfs_err_32bit_limit(fs_info);
>>>> +	return -EOVERFLOW;
>>>> +}
>>>> +
>>>> +/*
>>>> + * This is to give early warning for any metadata chunk reaching
>>>> + * 10T boundary.
>>>> + * Although we can still access the metadata, it's a timed bomb thus=
 an early
>>>> + * warning is definitely needed.
>>>> + */
>>>> +static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
>>>> +				  u64 logical, u64 length, u64 type)
>>>> +{
>>>> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
>>>> +		return;
>>>> +
>>>> +	if (logical + length < BTRFS_32BIT_EARLY_WARN_THRESHOLD)
>>>> +		return;
>>>> +
>>>> +	btrfs_warn_32bit_limit(fs_info);
>>>> +}
>>>> +#endif
>>>> +
>>>>    static int read_one_chunk(struct btrfs_key *key, struct extent_buf=
fer *leaf,
>>>>    			  struct btrfs_chunk *chunk)
>>>>    {
>>>> @@ -6797,6 +6837,7 @@ static int read_one_chunk(struct btrfs_key *key=
, struct extent_buffer *leaf,
>>>>    	u64 logical;
>>>>    	u64 length;
>>>>    	u64 devid;
>>>> +	u64 type;
>>>>    	u8 uuid[BTRFS_UUID_SIZE];
>>>>    	int num_stripes;
>>>>    	int ret;
>>>> @@ -6804,8 +6845,17 @@ static int read_one_chunk(struct btrfs_key *ke=
y, struct extent_buffer *leaf,
>>>>
>>>>    	logical =3D key->offset;
>>>>    	length =3D btrfs_chunk_length(leaf, chunk);
>>>> +	type =3D btrfs_chunk_type(leaf, chunk);
>>>>    	num_stripes =3D btrfs_chunk_num_stripes(leaf, chunk);
>>>>
>>>> +#if BITS_PER_LONG =3D=3D 32
>>>> +	ret =3D check_32bit_meta_chunk(fs_info, logical, length, type);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	warn_32bit_meta_chunk(fs_info, logical, length, type);
>>>> +#endif
>>>> +
>>>> +
>>>>    	/*
>>>>    	 * Only need to verify chunk item if we're reading from sys chunk=
 array,
>>>>    	 * as chunk item in tree block is already verified by tree-checke=
r.
>>>> @@ -6849,10 +6899,10 @@ static int read_one_chunk(struct btrfs_key *k=
ey, struct extent_buffer *leaf,
>>>>    	map->io_width =3D btrfs_chunk_io_width(leaf, chunk);
>>>>    	map->io_align =3D btrfs_chunk_io_align(leaf, chunk);
>>>>    	map->stripe_len =3D btrfs_chunk_stripe_len(leaf, chunk);
>>>> -	map->type =3D btrfs_chunk_type(leaf, chunk);
>>>> +	map->type =3D type;
>>>>    	map->sub_stripes =3D btrfs_chunk_sub_stripes(leaf, chunk);
>>>>    	map->verified_stripes =3D 0;
>>>> -	em->orig_block_len =3D calc_stripe_length(map->type, em->len,
>>>> +	em->orig_block_len =3D calc_stripe_length(type, em->len,
>>>>    						map->num_stripes);
>>>>    	for (i =3D 0; i < num_stripes; i++) {
>>>>    		map->stripes[i].physical =3D
>>>> --
>>>> 2.30.0
