Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69343ED7BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhHPNmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 09:42:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:54901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237182AbhHPNm3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629121312;
        bh=2tfT1GoPHgw6ZCUCYnbLnXRfrBGpyMSksQ/OQc0EtNQ=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=ivfOmGubCk8yhIOfYfGfthAqbq7Ay6t0ZRIm1nPbBaU2CZeNix1euBs5mmKUzz45L
         5iDffSbRkZku0K3e5YR+Q+FKNixYb/FDX0CcTc5TGmtyo4RJL/0X2n325C0KlnaTWS
         bzhWtSs17DxULL52VI1ADGnhBRxRe1fUTeHbWHd8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvmO-1mpVv62k3a-00b3DG; Mon, 16
 Aug 2021 15:41:52 +0200
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-3-wqu@suse.com>
 <bcda08a2-c014-10d7-64c8-1ac29b0f43ab@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/2] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
Message-ID: <417cfed7-e7c6-8c51-254b-7a76533b96c8@gmx.com>
Date:   Mon, 16 Aug 2021 21:41:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bcda08a2-c014-10d7-64c8-1ac29b0f43ab@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5HGa/Fg0ZS6ADLbE5UexA3RzQqFMhWnpdev+evWhERrlCamKwZu
 WCCMhCPt1Z6X+lh37rUlLV7AK8r17oFLWCeFxMfqs6kG/5UFKDWxfyZ5wH3BL4arEoBIn+2
 dPcBrGWwq0PwaJXwn7p0gxXupaUjLrk1me/+/BnGPEx8I6aAjMGRMbSdDg2V24H497ncwHi
 x7v93EDjkM1y2OkZ4WGMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sBAWT+rccM8=:CRTFq5O8wNSkRwZj7qus1u
 1JVi38iAiUqV7UMQRBxmxyZGjdhPP01rYgV5+RFad7IXybtsOoqFsI0yfHokpQqP1r/DlXmwp
 NpJqNAHIeuMxbojHkrFpqKkc8uH9IHUSub9PJqtgrzzlBYIplM6NUeemXzYfLBLpBv+7CDPC7
 9dY4MbWu7b2RjS6dYK2UpODckxns6HAJVC+Nh3gVkdpRqFnWqChp8fXOs/Kn/3aVgSKxfWNns
 mk5EFD4Tn3GCfHBuocaMIyy5CpAucq3EsmcTlLZnFWTVvP6aPtH5z+L2nJhaNRdi8W8jqu2jZ
 CGZ+E+ZJiqQ7gbhN8L0bOwbJaVABAwV74sAXwCs5A+QusbEucfvBF4tMjIWG4AZqaSFlhXte7
 stYDVOG/BVzN2ZWbs4kC0QHW9MpvLKjWZ4zQOEqJadrK6ADD3l7236RnmCim76gV9Dve4q0c/
 oiUP8Fm/zdH9qvuDWwqOnok6IIn6QqYPhAlzvbWNxRYNAJVjhJhEM5XqE3tQwAlfD/mHGLgOU
 6bNaCwKBhEhKbkcM0q8XZB8UWlwCWonB+6O2c7BQX5kTU1kuY8t+0/jbgkEhTnInjnpv5iItq
 KkPpy0URedImqLnr0H2ZQZQU2/dMAmTBjG9GuzCHBZ01ouixFN7bsa98Y6SNP3Awm1qOzPQkR
 le3gI2dLdMN7czljTjGezkylmWI0gUGSAM/9OcFUKT4NWvvLhz0VJ/2VQV4G1F7eacVQgpPBi
 mN3Q6NlGzTF89nwL6ZkZRARrCXgj9abCK2dRCOnMTvx/d7X46QyLET72S22TBw8paqghEi9jP
 s18UhXxaeX6zf78VQCSpKckA7DCUvw2/z0bB4wJGubYnk2sj8qjYPmt3OsWGzEtHF1Xfoip2D
 lUIpfmw4qzv1w9TjPuaLOcS9VZ1qve5zI5COLYKU6Gro0re0Wewj38gmety4jLg6Oz1q4SK6H
 O7ZKHPHeTkStopxoN9zV2fhBrCfypvOe45GdPf+G6eCdr5pTxhUetLnvAO4YR8fVVt2H+Wtf4
 XfUMT5El+hpnHIadesCruR1HZlC85//Kq6sTvXpHkjbz7FeFVIkhh8JcyMw/ZPTFFhtErbhDT
 /eQfaMV184MmY/VHG5Hq36RsUjXAGLV0XJ2eECpDNQKa5Mz5OyyBhT00w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/16 =E4=B8=8B=E5=8D=886:26, Nikolay Borisov wrote:
>
>
> On 16.08.21 =D0=B3. 9:00, Qu Wenruo wrote:
>> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
>> size.
>>
>> But this u16 bitmap is not large enough to contain larger page size lik=
e
>> 128K, nor is space efficient for 16K page size.
>>
>> To handle both cases, here we pack all subpage bitmaps into a larger
>> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
>> subpage usage.
>>
>> Each sub-bitmap will has its start bit number recorded in
>> btrfs_subpage_info::*_start, and its bitmap length will be recorded in
>> btrfs_subpage_info::bitmap_nr_bits.
>>
>> All subpage bitmap operations will be converted from using direct u16
>> operations to bitmap operations, with above *_start calculated.
>>
>> For 64K page size with 4K sectorsize, this should not cause much differ=
ence.
>> While for 16K page size, we will only need 1 unsigned long (u32) to
>> restore the bitmap.
>> And will be able to support 128K page size in the future.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c |  58 ++++++++++--------
>>   fs/btrfs/subpage.c   | 137 +++++++++++++++++++++++++++++-------------=
-
>>   fs/btrfs/subpage.h   |  19 +-----
>>   3 files changed, 130 insertions(+), 84 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 543f87ea372e..e428d6208bb7 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3865,10 +3865,9 @@ static void find_next_dirty_byte(struct btrfs_fs=
_info *fs_info,
>>   	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->priv=
ate;
>>   	u64 orig_start =3D *start;
>>   	/* Declare as unsigned long so we can use bitmap ops */
>> -	unsigned long dirty_bitmap;
>>   	unsigned long flags;
>> -	int nbits =3D (orig_start - page_offset(page)) >> fs_info->sectorsize=
_bits;
>> -	int range_start_bit =3D nbits;
>> +	int nbits =3D offset_in_page(orig_start) >> fs_info->sectorsize_bits;
>
> nbits is rather dubious, by reading it I'd expect it to hold a
> count/number of bits. In fact it holds a sector index. A better name
> would be sector_index or block_index.

Not sure if "sector" in the context of bitmap is preferred.

But since nbits is only used once, deleting nbits completely would be
better.

>
>> +	int range_start_bit =3D nbits + fs_info->subpage_info->dirty_start;
>>   	int range_end_bit;
>>
>>   	/*
>> @@ -3883,11 +3882,14 @@ static void find_next_dirty_byte(struct btrfs_f=
s_info *fs_info,
>>
>>   	/* We should have the page locked, but just in case */
>>   	spin_lock_irqsave(&subpage->lock, flags);
>> -	dirty_bitmap =3D subpage->dirty_bitmap;
>> +	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end=
_bit,
>> +			       fs_info->subpage_info->dirty_start +
>> +			       fs_info->subpage_info->bitmap_nr_bits);
>>   	spin_unlock_irqrestore(&subpage->lock, flags);
>>
>> -	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bi=
t,
>> -			       BTRFS_SUBPAGE_BITMAP_SIZE);
>> +	range_start_bit -=3D fs_info->subpage_info->dirty_start;
>> +	range_end_bit -=3D fs_info->subpage_info->dirty_start;
>> +
>>   	*start =3D page_offset(page) + range_start_bit * fs_info->sectorsize=
;
>>   	*end =3D page_offset(page) + range_end_bit * fs_info->sectorsize;
>>   }
>> @@ -4613,7 +4615,7 @@ static int submit_eb_subpage(struct page *page,
>>   	int submitted =3D 0;
>>   	u64 page_start =3D page_offset(page);
>>   	int bit_start =3D 0;
>> -	const int nbits =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>> +	const int nbits =3D fs_info->subpage_info->bitmap_nr_bits;
>
> nit: do we really need nbits, given that
> fs_info->subpage_info->bitmap_nr_bits fits on one line inside the while
> expression. Also see the discrepancy - nbits here indeed holds a "number
> of bits value".

Yeah, deleteing nbits completely here would be better.

>
>>   	int sectors_per_node =3D fs_info->nodesize >> fs_info->sectorsize_bi=
ts;
>>   	int ret;
>>
>
> <snip>
>
>> @@ -7178,32 +7181,41 @@ void memmove_extent_buffer(const struct extent_=
buffer *dst,
>>   	}
>>   }
>>
>> +#define GANG_LOOKUP_SIZE	16
>>   static struct extent_buffer *get_next_extent_buffer(
>>   		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
>>   {
>> -	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
>> +	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
>>   	struct extent_buffer *found =3D NULL;
>>   	u64 page_start =3D page_offset(page);
>> -	int ret;
>> -	int i;
>> +	u64 cur =3D page_start;
>>
>>   	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
>> -	ASSERT(PAGE_SIZE / fs_info->nodesize <=3D BTRFS_SUBPAGE_BITMAP_SIZE);
>>   	lockdep_assert_held(&fs_info->buffer_lock);
>>
>> -	ret =3D radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
>> -			bytenr >> fs_info->sectorsize_bits,
>> -			PAGE_SIZE / fs_info->nodesize);
>> -	for (i =3D 0; i < ret; i++) {
>> -		/* Already beyond page end */
>> -		if (gang[i]->start >=3D page_start + PAGE_SIZE)
>> -			break;
>> -		/* Found one */
>> -		if (gang[i]->start >=3D bytenr) {
>> -			found =3D gang[i];
>> -			break;
>> +	while (cur < page_start + PAGE_SIZE) {
>> +		int ret;
>> +		int i;
>> +
>> +		ret =3D radix_tree_gang_lookup(&fs_info->buffer_radix,
>> +				(void **)gang, cur >> fs_info->sectorsize_bits,
>> +				min_t(unsigned int, GANG_LOOKUP_SIZE,
>> +				      PAGE_SIZE / fs_info->nodesize));
>> +		if (ret =3D=3D 0)
>> +			goto out;
>> +		for (i =3D 0; i < ret; i++) {
>> +			/* Already beyond page end */
>> +			if (gang[i]->start >=3D page_start + PAGE_SIZE)
>> +				goto out;
>> +			/* Found one */
>> +			if (gang[i]->start >=3D bytenr) {
>> +				found =3D gang[i];
>> +				break;
>
> Instead of break, don't you want to do got out? Break would exit from
> the inner for() loop and continue at the outter while loop.

Damn, why my subpage tests didn't catch the problem...

I guess since the function is only called in
try_release_subpage_extent_buffer(), and it only needs to exhaust all
the ebs of the page, it doesn't really care about if we returned some
wrong eb.

But still, it should be "goto out".

Thanks for catching this one.

>
>> +			}
>>   		}
>> +		cur =3D gang[ret - 1]->start + gang[ret - 1]->len;
>>   	}
>> +out:
>>   	return found;
>>   }
>>
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index 014256d47beb..9d6da9f2d77e 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -139,10 +139,14 @@ int btrfs_alloc_subpage(const struct btrfs_fs_inf=
o *fs_info,
>>   			struct btrfs_subpage **ret,
>>   			enum btrfs_subpage_type type)
>>   {
>> +	unsigned int real_size;
>> +
>>   	if (fs_info->sectorsize =3D=3D PAGE_SIZE)
>>   		return 0;
>
> offtopic: Instead of having a bunch of those checks can't we replace
> them with ASSERTS and ensure that the decision whether we do subpage or
> not is taken at a higher level ?

Nope, in this particular call site, btrfs_alloc_subpage() can be called
with regular page size.

I guess it's better to rename this function like btrfs_prepare_page()?

>>
>> -	*ret =3D kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
>> +	real_size =3D BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits) *
>> +		    sizeof(unsigned long) + sizeof(struct btrfs_subpage);
>
> real_size =3D struct_size(*ret, bitmaps,
> BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits));
>
> And the calling convention for this function is awful. Just make it
> return struct btrfs_subpage * and kill the dreadful **ret....

Above two advices indeed sound much better.

>
>> +	*ret =3D kzalloc(real_size, GFP_NOFS);
>>   	if (!*ret)
>>   		return -ENOMEM;
>>   	spin_lock_init(&(*ret)->lock);
>> @@ -324,37 +328,60 @@ void btrfs_page_end_writer_lock(const struct btrf=
s_fs_info *fs_info,
>>   		unlock_page(page);
>>   }
>>
>> -/*
>> - * Convert the [start, start + len) range into a u16 bitmap
>> - *
>> - * For example: if start =3D=3D page_offset() + 16K, len =3D 16K, we g=
et 0x00f0.
>> - */
>> -static u16 btrfs_subpage_calc_bitmap(const struct btrfs_fs_info *fs_in=
fo,
>> -		struct page *page, u64 start, u32 len)
>> +static bool bitmap_test_range_all_set(unsigned long *addr, unsigned st=
art,
>> +				      unsigned int nbits)
>>   {
>> -	const int bit_start =3D offset_in_page(start) >> fs_info->sectorsize_=
bits;
>> -	const int nbits =3D len >> fs_info->sectorsize_bits;
>> +	unsigned int found_zero;
>>
>> -	btrfs_subpage_assert(fs_info, page, start, len);
>> +	found_zero =3D find_next_zero_bit(addr, start + nbits, start);
>
> 2 argument of find_next_zero_bit is 'size' which would be nbits as it
> expects the size to be in bits , not start + nbit. Every logical bitmap
> in ->bitmaps is defined by [start, nbits] no ? Unfortunately there is a
> discrepancy between the order of documentation and the order of actual
> arguments in the definition of this function....

IT'S A TRAP!

Paramater 2 (@size) is the total size of the search range, it should be
larger than the 3rd parameter.

You can check the _find_next_bit(), where there are a lot of @start >=3D
@nbits checks.

I guess this is the tricky part when we pack the bitmaps into one larger
bitmap...

>
>> +	if (found_zero =3D=3D start + nbits)
>> +		return true;
>> +	return false;
>> +}
>>
>> -	/*
>> -	 * Here nbits can be 16, thus can go beyond u16 range. We make the
>> -	 * first left shift to be calculate in unsigned long (at least u32),
>> -	 * then truncate the result to u16.
>> -	 */
>> -	return (u16)(((1UL << nbits) - 1) << bit_start);
>> +static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned s=
tart,
>> +				       unsigned int nbits)
>> +{
>> +	unsigned int found_set;
>> +
>> +	found_set =3D find_next_bit(addr, start + nbits, start);
>> +	if (found_set =3D=3D start + nbits)
>> +		return true;
>> +	return false;
>
> This can be implemented by simply doing !bitmap_test_range_all_set no
> need to have 2 separate implementations. Given those 2 functions are
> only used in the definition oof the subpage_test_bitmap* macros I'da say
> remove one of them and simply code the macros as
> bitmap_test_range_all_set and !bitmap_test_range_all_set respectively.

TRAP CARD!

bitmap_test_range_all_set() will only return 1 if all bits in the range
are 1.

But bitmap_test_range_all_zero() should only return 1 if all bits in the
range are 0.

What if only part of the range is 1?

Thanks,
Qu


>
>>   }
>>
>
> <snip>
>
