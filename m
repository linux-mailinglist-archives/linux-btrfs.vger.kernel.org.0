Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3F29EC16
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJ2MnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:43:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:39783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ2MnW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603975396;
        bh=vwKn3dV2TXQ1qKij1CnvriYV6+NVkzwR0AagS2/5Q0Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ii9WhET3phdcsuq8987ox+eMTnJT3saSiRd7Htp7+aU3C8pNdptZsuqPry3WLa3IR
         HPlH9zJ+gOlK+n1BeVwSqWN3ebg9ISzk66hNxOUB0heVZjZAHVdQXYFA/SiCHwI4D9
         o3286u8/uN5h4ray0xQKet+2TMwPs/updyPei2Ac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIwzA-1kn1lG084o-00KQ7A; Thu, 29
 Oct 2020 13:43:16 +0100
Subject: Re: [PATCH v2 3/3] btrfs: file-item: refactor btrfs_lookup_bio_sums()
 to handle out-of-order bvecs
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-4-wqu@suse.com>
 <765375f6-7c4f-e9d9-f0f5-3de9bac74cce@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <55275e3c-1828-7180-e902-8344a571516e@gmx.com>
Date:   Thu, 29 Oct 2020 20:43:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <765375f6-7c4f-e9d9-f0f5-3de9bac74cce@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Y5lHsY9m1InZDw+O5+zk6JZiUkwZDrxbvUODMNcX2IxK8orvVp
 lA2hoWm6K1vteULIYPqukOjsufaJZH6by0tje3ZraLw0vXBx1jDlu5PA3fw9SJK7r2ajJRv
 0GpyyYKZ7wztuWnxAfpIf7pDL00Y3dYpi+AGWtFxl6li11aJfHwA37YaEY8hanEyl+PgW5Q
 oziEalxH0rB6W8YX2Ri3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:va1a4uMcgM8=:IYJncghSMBnfiKiIqqGWzu
 jnpLbgCr/WjQCFAiI6XZzCoMRvt53EqrJG64VbRWLmcdyKrFzdvIZcEMoLnaiYxka/DiyZ4K4
 nkQ3pN8aqpNCFMmjRPrcInZLFFNuqgkDrRvrhuSqjaeOF56QSbY1Xjq57kGclUsjaR78vBVim
 YjMuO5xFAZ6TRCvYJfBB3xUH2zQqn/4YLbtdf/vZGJxO6xPk+nnDSl4jVMqlfruF/60Jy2Jim
 gWl1s4YjgpvvqISANVxcw4Kh3ZXLNnOXy/NtXmAL62NcOvHDqZJBf47+tp8OU4YekH1lPHeBF
 qVb5K11O10SAyaVX3F10E+9eZIGCAGSLGf4mrUd5yWzoy3srssy/kCtN2Yp1jOCw6mYbVN4XK
 kWBwe0sNiwaoCXzYDa92co7mCF7zl+RnV/a5Edih7YRu/uklgBUH67u7sZB43XuXIHQcsX3Sv
 tKcmqVQwNojgrvRUnAXAh8QjdoYUgUrz/OU9x3B31IZRspMT6VWxk5sOnTaBcRXE+qmzORGuG
 w1kcJhoV8pSw08TseLEX9maJZG6zeIrNqqih3I32dIoxXwIV4hVKcnstnYWeGvB8tbZ4FWszf
 Lt/4npGxCqmVk0WVErMX2mk950+n4/omOCx6tQwGhJhSJZKjzmsg9dNogtA8ZCNMOzIoyhsXt
 fKIeLXq2wZpT5s6iMafOcmGUGnjs0TiWf7KljO5sPfjPyK4VrqExZ4iEOR+U00J0j1EsUSZe/
 EycK4joWa+aUcx3RMW2IGqUI8gKiA8L/6yVkv9YI2YYjSS86P3m6l9vu5ilDJemDQusl49IFx
 h387NVd86nZ2rZyJq0Y9y3zLQoQOvJyLOqxBIZanb+m5tmvTm+oO8YUgolAVSO/lTK599/w5a
 lwuQMDIz8ijxzgNAvkaA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/29 =E4=B8=8B=E5=8D=887:50, Nikolay Borisov wrote:
>
>
> On 29.10.20 =D0=B3. 9:12 =D1=87., Qu Wenruo wrote:
>> Refactor btrfs_lookup_bio_sums() by:
>> - Remove the @file_offset parameter
>>   There are two factors making the @file_offset parameter useless:
>>   * For csum lookup in csum tree, file offset makes no sense
>>     We only need disk_bytenr, which is unrelated to file_offset
>>   * page_offset (file offset) of each bvec is not contig
>>     bio can be merged, meaning we could have pages at different
>>     file offsets in the same bio.
>>   Thus passing file_offset makes no sense any longer.
>>   The only user of file_offset is for data reloc inode, we will use
>>   a new function, search_file_offset_in_bio(), to handle it.
>>
>> - Extract the csum tree lookup into find_csum_tree_sums()
>>   The new function will handle the csum search in csum tree.
>>   The return value is the same as btrfs_find_ordered_sum(), returning
>>   the found number of sectors who has checksum.
>>
>> - Change how we do the main loop
>>   The only needed info from bio is:
>>   * the on-disk bytenr
>>   * the file_offset (if file_offset =3D=3D (u64)-1)
>>   * the length
>>
>>   After extracting above info, we can do the search without bio
>>   at all, which makes the main loop much simpler:
>>
>> 	for (cur_disk_bytenr =3D orig_disk_bytenr;
>> 	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
>> 	     cur_disk_bytenr +=3D count * sectorsize) {
>>
>> 		/* Lookup csum tree */
>> 		count =3D find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
>> 					    search_len, csum_dst);
>> 		if (!count) {
>> 			/* Csum hole handling */
>> 		}
>> 	}
>>
>> - Use single variable as core to calculate all other offsets
>>   Instead of all differnt type of variables, we use only one core
>>   variable, cur_disk_bytenr, which represents the current disk bytenr.
>>
>>   All involves values can be calculated from that core variable, and
>>   all those variable will only be visible in the inner loop.
>>
>> 	diff_sectors =3D div_u64(cur_disk_bytenr - orig_disk_bytenr,
>> 			       sectorsize);
>> 	cur_disk_bytenr =3D orig_disk_bytenr +
>> 			  diff_sectors * sectorsize;
>> 	csum_dst =3D csum + diff_sectors * csum_size;
>>
>> All above refactor makes btrfs_lookup_bio_sums() way more robust than i=
t
>> used to, especially related to the file offset lookup.
>> Now file_offset lookup is only related to data reloc inode, other wise
>> we don't need to bother file_offset at all.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/compression.c |   4 +-
>>  fs/btrfs/ctree.h       |   2 +-
>>  fs/btrfs/file-item.c   | 256 ++++++++++++++++++++++++++---------------
>>  fs/btrfs/inode.c       |   5 +-
>>  4 files changed, 171 insertions(+), 96 deletions(-)
>>
>
> <snip>
>
>
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index acacdd0bfe2c..85e7a3618a07 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -239,39 +239,140 @@ int btrfs_lookup_file_extent(struct btrfs_trans_=
handle *trans,
>>  	return ret;
>>  }
>>
>> +/*
>> + * Helper to find csums for logical bytenr range
>> + * [disk_bytenr, disk_bytenr + len) and restore the result to @dst.
>
> nit: s/restore/store
>
>> + *
>> + * Return >0 for the number of sectors we found.
>> + * Return 0 for the range [disk_bytenr, disk_bytenr + sectorsize) has =
no csum
>> + * for it. Caller may want to try next sector until one range is hit.
>> + * Return <0 for fatal error.
>> + */
>> +static int find_csum_tree_sums(struct btrfs_fs_info *fs_info,
>> +			       struct btrfs_path *path, u64 disk_bytenr,
>> +			       u64 len, u8 *dst)
>
> A better name would be search_csum_tree.

The naming was designed to follow btrfs_find_ordered_sums(), but that
function just get deleted, thus the new naming has no thing to follow,
and the new name looks pretty sane to me.

>
>> +{
>> +	struct btrfs_csum_item *item =3D NULL;
>> +	struct btrfs_key key;
>> +	u32 csum_size =3D btrfs_super_csum_size(fs_info->super_copy);
>
> nit: Why u32, btrfs_super_csum_size is defined as returning 'int',
> however this function is really returning u16 since "struct btrfs_csums"
> is defined as u16.

It was misguided by u32 from btrfs super block, where sectorsize,
nodesize are all u32.

Any recommendation on this? Just u16 for csum_size or follow
nodesize/sectorsize to use u32?

>
>> +	u32 sectorsize =3D fs_info->sectorsize;
>> +	int ret;
>> +	u64 csum_start;
>> +	u64 csum_len;
>> +
>> +	ASSERT(IS_ALIGNED(disk_bytenr, sectorsize) &&
>> +	       IS_ALIGNED(len, sectorsize));
>> +
>> +	/* Check if the current csum item covers disk_bytenr */
>> +	if (path->nodes[0]) {
>> +		item =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +				      struct btrfs_csum_item);
>> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +		csum_start =3D key.offset;
>> +		csum_len =3D btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
>
> nit: put the division in brackets, it doesn't affect correctness but it
> makes it more obvious since multiplication and division have same
> precedence then associativitiy comes into play...
>
>> +			   csum_size * sectorsize;
>> +
>> +		if (csum_start <=3D disk_bytenr &&
>> +		    csum_start + csum_len > disk_bytenr)
>
> if (in_range(disk_bytenr, csum_start, csum_len))
>
>> +			goto found;
>> +	}
>> +
>> +	/* Current item doesn't contain the desired range, re-search */
>> +	btrfs_release_path(path);
>> +	item =3D btrfs_lookup_csum(NULL, fs_info->csum_root, path,
>> +				 disk_bytenr, 0);
>> +	if (IS_ERR(item)) {
>> +		ret =3D PTR_ERR(item);
>> +		goto out;
>> +	}
>> +found:
>
> The found label could be moved right before ret =3D div_u64 since if you
> go directly to it it's guaranteed you have already done the
> btrfs_item_to_key et al operations so you are simply duplicating them no=
w.

Right, that saves us several instructions.

>
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	csum_start =3D key.offset;
>> +	csum_len =3D btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
>> +		   csum_size * sectorsize;
>
> nit: put brackets around division.
>
>> +	ASSERT(csum_start <=3D disk_bytenr &&
>> +	       csum_start + csum_len > disk_bytenr);
>
> Use in_range macro
>
>> +
>> +	ret =3D div_u64(min(csum_start + csum_len, disk_bytenr + len) -
>> +		      disk_bytenr, sectorsize);
>> +	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
>> +			ret * csum_size);
>> +out:
>> +	if (ret =3D=3D -ENOENT) {
>> +		ret =3D 0;
>> +		memset(dst, 0, csum_size);
>> +	}
>> +	return ret;
>> +}
>> +
>> +/*
>> + * A helper to locate the file_offset of @cur_disk_bytenr of a @bio.
>> + *
>> + * Bio of btrfs represents read range of
>> + * [bi_sector << 9, bi_sector << 9 + bi_size).
>> + * Knowing this, we can iterate through each bvec to locate the page b=
elong to
>> + * @cur_disk_bytenr and get the file offset.
>> + *
>> + * @inode is used to determine the bvec page really belongs to @inode.
>> + *
>> + * Return 0 if we can't find the file offset;
>> + * Return >0 if we find the file offset and restore it to @file_offset=
_ret
>> + */
>> +static int search_file_offset_in_bio(struct bio *bio, struct inode *in=
ode,
>> +				     u64 disk_bytenr, u64 *file_offset_ret)
>> +{
>> +	struct bvec_iter iter;
>> +	struct bio_vec bvec;
>> +	u64 cur =3D bio->bi_iter.bi_sector << 9;
>> +	int ret =3D 0;
>> +
>> +	bio_for_each_segment(bvec, bio, iter) {
>> +		struct page *page =3D bvec.bv_page;
>> +
>> +		if (cur > disk_bytenr)
>> +			break;
>> +		if (cur + bvec.bv_len <=3D disk_bytenr) {
>> +			cur +=3D bvec.bv_len;
>> +			continue;
>> +		}
>> +		ASSERT(cur <=3D disk_bytenr && cur + bvec.bv_len > disk_bytenr);
>
> in_range(disk_bytenr, cur, bvec.bv_len)
>
>> +		if (page && page->mapping && page->mapping->host &&
>> +		    page->mapping->host =3D=3D inode) {
> We are guaranteed to always have a page, since this bvec will have been
> aded via bio_add_page, since those will be data pages we are guaranteed
> to have mapping and mapping->host, so you ought to only check if it's
> the same inode, no ?

Page is definitely always here, so the first check is duplicated.

But I doubt about the page->mapping part.
For cases like reading compressed data, IIRC the page can be anonymous
(allocated by alloc_page(), not bound to any inode).
Thus at least we still need to check page->mapping.

>
>> +			ret =3D 1;
>> +			*file_offset_ret =3D page_offset(page) + bvec.bv_offset
>> +				+ disk_bytenr - cur;
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
>
>> +
> <snip>
>
>> @@ -323,81 +427,53 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *=
inode, struct bio *bio,
>>  		path->skip_locking =3D 1;
>>  	}
>>
>> -	disk_bytenr =3D (u64)bio->bi_iter.bi_sector << 9;
>> -
>> -	bio_for_each_segment(bvec, bio, iter) {
>> -		page_bytes_left =3D bvec.bv_len;
>> -		if (count)
>> -			goto next;
>> -
>> -		if (page_offsets)
>> -			offset =3D page_offset(bvec.bv_page) + bvec.bv_offset;
>> +	for (cur_disk_bytenr =3D orig_disk_bytenr;
>> +	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
>> +	     cur_disk_bytenr +=3D count * sectorsize) {
>> +		int search_len =3D orig_disk_bytenr + orig_len - cur_disk_bytenr;
>> +		int diff_sectors;
>
>  This variable is misnamed, it's  really offset_sector or sector_offset.

I have no better alternatives yet, thus would use offset_sector for now.

>
>> +		u8 *csum_dst;> +
>> +		diff_sectors =3D div_u64(cur_disk_bytenr - orig_disk_bytenr,
>> +				       sectorsize);
>> +		cur_disk_bytenr =3D orig_disk_bytenr +
>> +				  diff_sectors * sectorsize;
>
> Since you already increment cur_disk_bytenr with count * sector size
> where count is the number of csums, why do you have recalculate it here?

Completely bad code from previous iterations forgot to cleanup...

> Furthermore you convert to sectors in diff_sectors and then you multiply
> it by sectorsize which gives you back just cur_disk_bytenr -
> orig_disk_bytenr so the end expression is:
>
> cur_disk_bytenr =3D orig_disk_bytenr + cur_disk_bytenr - orig_disk_byten=
r
> =3D> cur_disk_bytenr =3D cur_disk_bytenr - am I missing something?
>
>
>> +		csum_dst =3D csum + diff_sectors * csum_size;
>> +
>> +		count =3D find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
>> +					    search_len, csum_dst);
>
> Missing error handling if count is negative!

Yep, I thought it was only either 0 or 1, but is totally wrong.

Thanks for the review!
Qu

>
>> +		if (!count) {
>> +			/*
>> +			 * For not found case, the csum has been zeroed
>> +			 * in find_csum_tree_sums() already, just skip
>> +			 * to next sector.
>> +			 */
>> +			count =3D 1;
>
> <snip>
>
