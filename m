Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FDD3F5394
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhHWXRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:17:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:54009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233137AbhHWXRj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629760612;
        bh=5KwuG2BM2XKMVlbbnLVzAswuL1v7kq/NRv0o74paOis=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jyH+DjkQ3AktnwmRA/osL7TFRVPcUMmG95LLSgKlt8tHPN7aA8tAJ+wHMQYEwXvJn
         bQqiDpT72XsVS85ttK6oVLDfwkaoNUfeHhdzZAIS1wL9wrvyFLvmex5YYlRPLfMC+y
         iV+P6CXl82ngWyOC5+3lC0ypCnX5O0asSed7ibwM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1mRh5S0Cwc-00R5E2; Tue, 24
 Aug 2021 01:16:52 +0200
Subject: Re: [PATCH v2 4/4] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-5-wqu@suse.com> <20210823165746.GH5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4a9947e2-f92f-0b69-01e5-67cc8dc5bea5@gmx.com>
Date:   Tue, 24 Aug 2021 07:16:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823165746.GH5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vz9JsuGUqV1VTmLxP4WDue5RzMbn0qXUxh9Dk/+b+cbS2QNkP2k
 gH5eFjIsYoqTEEvch7qb5SU2MiU+zKDbx4eff6NlqKwonPqTPAHWoN+Dzm+Zfd7Q0rAcZtr
 YayrfNBsHLpGM1omL+deXA9s2o40U1D93GF1oVjUJBii4uLcIdS7hTv9iBzjJVg9xgrt2ZP
 IkGP2skXaOfzXiv9JnfGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0EfNsK0uclU=:XMpCXMYSa7VfeXYMFazIBc
 /+NAACz5DF+NxqmDgJ1Hr3lfkG8VVHGYCVnnRKHfRYeHUkf9WJNmXvPa8lgmSF0bFKJ3Y+E8d
 FhZezrxy56c1C0CL2PosyuCifXB2UViv+13QBUdfSse746RJpKZW4vcsLVx8BBhS2Tl+kCKW2
 fFitE8gPk5itZrcCtRytad58IRxN6NtrbmRXNBnypKv8apFky0npLclC13NIKdiQHwitMoRlY
 voK0kpW+Foge8Y4ksK/rZ7TcisADvdTKRcu6o4nS4mrWrYU/vnidXU743bB8MjP5TouZseuDp
 wigb5kCpLP7CNlMyw+NniQS89I5OhAo4fvWcFqHbWSVrqUXMfvYdRSVdvLPWDG/iEA+namrgn
 cggdSCWcUIq66Qr/S1aBVM7Vl04UW529iASZDGgox4O2e6kliuJxCTXdZWiQ7vu2QCc49Q+Oi
 Zq2yo09tKCu/P+vcgZaITG4fbIhIzBSb1rdGFCgd2Ee8pBZ3Qwuqwmfr8hOiOFFTbf1kZCm45
 h+UZ/AaZCbbcTB9WrEV3ic8zKYOLtzX/BPwgz1OtCIQzJM1U3JqbZqHABt8BpCv1s8nYACJNq
 Bzf0Op/7bjzaMIgNMjuZuG/eDOenGFra/pHUgyqRYU8iZAF3doY+b0qSAgUdxw3y2LWNQ1f/t
 tnM/j3FOqfc0+Vby2EhC8DRgNH1+vI53nPyKnvD7lsKkq+FXSq6OXexsC56UyHO3x73aVDXBg
 OBpVGfG+0t9y6kkWufgohwgBHLt5E3Nw41UtkCrp/M/PtyuLrVLK/yI/TVrDYPYo4oD5ahw0r
 8n2QWqJ27yi2igfokG6m+TVK0YJm/xIvoAzk7qPFqeGap2qm3hfkclMGzuNhtb1EzDg4E+BRZ
 ISh9VyubNu82bDkb2hNvONyXFRgNYSMfRPOp5FRhePhLZFrnJngaaMNf4atyIivDdpZARqzCB
 ShDe8bRI7C/zdkjYW54Gqs6OvvNSHm5ZogPCSMQWlEl7b1+bFO3JEga2vIVQ6P7yOxw45Th39
 paoyw9sGiAtCuoQsn8c2HvRTnwTvNSBVXLp9LGA8ftOSI9YYn+T8rOoNuom0CE7Ww1539Q17o
 n34CvWWOGk9rDQV+C8cgJDsXTqxGBmwcZvi6QODUCrB49c0pAC5zeRW2w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=8812:57, David Sterba wrote:
> On Tue, Aug 17, 2021 at 05:38:52PM +0800, Qu Wenruo wrote:
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
>> For 64K page size with 4K sectorsize, this should not cause much
>> difference.
>>
>> While for 16K page size, we will only need 1 unsigned long (u32) to
>> store all the bitmaps, which saves quite some space.
>>
>> Furthermore, this allows us to support larger page size like 128K and
>> 258K.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c |  59 +++++++++++--------
>>   fs/btrfs/subpage.c   | 136 +++++++++++++++++++++++++++++-------------=
-
>>   fs/btrfs/subpage.h   |  19 +-----
>>   3 files changed, 129 insertions(+), 85 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 3c5770d47a95..fcb25ff86ea9 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3856,10 +3856,9 @@ static void find_next_dirty_byte(struct btrfs_fs=
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
>> +	int range_start_bit =3D fs_info->subpage_info->dirty_offset +
>> +		(offset_in_page(orig_start) >> fs_info->sectorsize_bits);
>
> There are several instances of fs_info->subpage_info so that warrants a
> temporary variable.
>
>>   	int range_end_bit;
>>
>>   	/*
>> @@ -3874,11 +3873,14 @@ static void find_next_dirty_byte(struct btrfs_f=
s_info *fs_info,
>>
>>   	/* We should have the page locked, but just in case */
>>   	spin_lock_irqsave(&subpage->lock, flags);
>> -	dirty_bitmap =3D subpage->dirty_bitmap;
>> +	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end=
_bit,
>> +			       fs_info->subpage_info->dirty_offset +
>> +			       fs_info->subpage_info->bitmap_nr_bits);
>>   	spin_unlock_irqrestore(&subpage->lock, flags);
>>
>> -	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bi=
t,
>> -			       BTRFS_SUBPAGE_BITMAP_SIZE);
>> +	range_start_bit -=3D fs_info->subpage_info->dirty_offset;
>> +	range_end_bit -=3D fs_info->subpage_info->dirty_offset;
>> +
>>   	*start =3D page_offset(page) + range_start_bit * fs_info->sectorsize=
;
>>   	*end =3D page_offset(page) + range_end_bit * fs_info->sectorsize;
>>   }
>> @@ -4602,12 +4604,11 @@ static int submit_eb_subpage(struct page *page,
>>   	int submitted =3D 0;
>>   	u64 page_start =3D page_offset(page);
>>   	int bit_start =3D 0;
>> -	const int nbits =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>>   	int sectors_per_node =3D fs_info->nodesize >> fs_info->sectorsize_bi=
ts;
>>   	int ret;
>>
>>   	/* Lock and write each dirty extent buffers in the range */
>> -	while (bit_start < nbits) {
>> +	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
>>   		struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->pri=
vate;
>>   		struct extent_buffer *eb;
>>   		unsigned long flags;
>> @@ -4623,7 +4624,8 @@ static int submit_eb_subpage(struct page *page,
>>   			break;
>>   		}
>>   		spin_lock_irqsave(&subpage->lock, flags);
>> -		if (!((1 << bit_start) & subpage->dirty_bitmap)) {
>> +		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
>> +			      subpage->bitmaps)) {
>>   			spin_unlock_irqrestore(&subpage->lock, flags);
>>   			spin_unlock(&page->mapping->private_lock);
>>   			bit_start++;
>> @@ -7170,32 +7172,41 @@ void memmove_extent_buffer(const struct extent_=
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
>> +				goto out;
>> +			}
>>   		}
>> +		cur =3D gang[ret - 1]->start + gang[ret - 1]->len;
>>   	}
>> +out:
>>   	return found;
>>   }
>>
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index c4fb2ce52207..578095c52a0f 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -142,10 +142,13 @@ struct btrfs_subpage *btrfs_alloc_subpage(const s=
truct btrfs_fs_info *fs_info,
>>   					  enum btrfs_subpage_type type)
>>   {
>>   	struct btrfs_subpage *ret;
>> +	unsigned int real_size;
>>
>>   	ASSERT(fs_info->sectorsize < PAGE_SIZE);
>>
>> -	ret =3D kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
>> +	real_size =3D struct_size(ret, bitmaps,
>> +			BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits));
>> +	ret =3D kzalloc(real_size, GFP_NOFS);
>>   	if (!ret)
>>   		return ERR_PTR(-ENOMEM);
>>
>> @@ -328,37 +331,60 @@ void btrfs_page_end_writer_lock(const struct btrf=
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
>> +static bool bitmap_test_range_all_set(unsigned long *addr, unsigned in=
t start,
>> +				      unsigned int nbits)
>>   {
>> -	const int bit_start =3D offset_in_page(start) >> fs_info->sectorsize_=
bits;
>> -	const int nbits =3D len >> fs_info->sectorsize_bits;
>> +	unsigned int found_zero;
>>
>> -	btrfs_subpage_assert(fs_info, page, start, len);
>> +	found_zero =3D find_next_zero_bit(addr, start + nbits, start);
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
>> +static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned i=
nt start,
>> +				       unsigned int nbits)
>> +{
>> +	unsigned int found_set;
>> +
>> +	found_set =3D find_next_bit(addr, start + nbits, start);
>> +	if (found_set =3D=3D start + nbits)
>> +		return true;
>> +	return false;
>>   }
>>
>> +#define subpage_calc_start_bit(fs_info, page, name, start, len)		\
>> +({									\
>> +	unsigned int start_bit;						\
>> +									\
>> +	btrfs_subpage_assert(fs_info, page, start, len);		\
>> +	start_bit =3D offset_in_page(start) >> fs_info->sectorsize_bits;	\
>> +	start_bit +=3D fs_info->subpage_info->name##_offset;		\
>> +	start_bit;							\
>> +})
>> +
>> +#define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
>> +	bitmap_test_range_all_set(subpage->bitmaps,			\
>> +			fs_info->subpage_info->name##_offset,		\
>> +			fs_info->subpage_info->bitmap_nr_bits)
>> +
>> +#define subpage_test_bitmap_all_zero(fs_info, subpage, name)		\
>> +	bitmap_test_range_all_zero(subpage->bitmaps,			\
>> +			fs_info->subpage_info->name##_offset,		\
>> +			fs_info->subpage_info->bitmap_nr_bits)
>> +
>>   void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
>>   		struct page *page, u64 start, u32 len)
>>   {
>>   	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->priv=
ate;
>> -	const u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len=
);
>> +	unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>> +							uptodate, start, len);
>>   	unsigned long flags;
>>
>>   	spin_lock_irqsave(&subpage->lock, flags);
>> -	subpage->uptodate_bitmap |=3D tmp;
>> -	if (subpage->uptodate_bitmap =3D=3D U16_MAX)
>> +	bitmap_set(subpage->bitmaps, start_bit,
>> +		   len >> fs_info->sectorsize_bits);
>
> All the bitmap_* calls like this and the parameter fit one line.
>
But that's over 80 chars.

I understand now our standard no longer requires 80 chars as hard limit,
but isn't it seill recommended to keep inside the 80 chars limit?

Thanks,
Qu
