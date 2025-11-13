Return-Path: <linux-btrfs+bounces-18962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF8C59F18
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 21:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E84E7CB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F030EF6E;
	Thu, 13 Nov 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YyvzxPfi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164629CEB
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064990; cv=none; b=TYrZKmvbKjs6tZH4Up2qGh8tvTybL9HgPAFpC3CTj1udTqyKw57m+EoTlQNM2+P7hVxJySzX5jr5W6PxqDYZf0cIBHRBNnqEhHqeyj3eN4fndr563Z2mgwFtTqEwkSYmizQoK7LuD23ufyB7miJ9v9KXAUft/oCrn2r3rUM5f64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064990; c=relaxed/simple;
	bh=SjKZOFqkfHe+3R5wuy7Vjzpay2DHX4C5h6TFOSQWAj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaSBhaEMVYFG7ya+Oq0o0kCemM1h6FXdc21Qyp5HB9SrTUoNcpqLejjFw1qtjlBHz1ihnKaj93ojDQ3unO9kvq7U2Ni/3uCJH1+tXJnppdFUZfiniSn/HCtc68UrvvE0kaHWT4z4aY8h96AvYTcsP9jPfen0CdkImWogfvjd8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YyvzxPfi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477775d3728so12570465e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763064987; x=1763669787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Md77JygJk49bJhHa1GNdcQcbETs4Y4SUj1qyNYvdOk=;
        b=YyvzxPfipmRoxb8Pe4Pax2KBUfCWQu7DVKV9BqnqGhcwoppmHCajIhLeUv1iDXuNW+
         RzqM7ez7+cTCpjWNI77KOLwcMVvBGz3tUAIQcTwo48kNPbwP5hd32ATlYhaPd9o+olqb
         U9diE/ubJD0cPptxYocopiY2jl12zFLilyJDy5ijPqB/ysv6vLrd0d1nfCFikJYw75cC
         Twyt8C0/fCq2s4px5X836lzoDpEa25CPK6krSMqqPGzRsl5VUcqns6vrCYecVTUyQVyg
         hRar/NpUMA/MNDtxhLw/yX+UaN4sFfOoVkjNPSbOidYxkO1MG1AKVamve1UQWtIxwm/t
         ePPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064987; x=1763669787;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Md77JygJk49bJhHa1GNdcQcbETs4Y4SUj1qyNYvdOk=;
        b=Um3Z5S4GfZEWWu8IzbX/EzvKZOQbUcJjT9kuFVzJLDZ6e7iQXcKoS5mdKZ74VkI9vx
         VE4lZeLFvoXdLDQU1ujbI1QZyPmeN3sErtEwzMIdZAabaWpm9Wp7e4c9JJd0YGZgJCoa
         4JqeUh+hIlgVyUdMTCsrveUaNe7i2sFW6o1uwer8X5w0Y7j/g/Qbjy9xCpaFLbaW0RGq
         HqvRAk2a1TH9TqGniX4fiHOjrUGKZ54yolhh5H7d1NPm1yCc5CTtrMn/pWJlZjDFiou0
         EyRD2Zq1PGid86vbMkuwZagqpPPI5nrMj/dx8xVDuD2c1O9SgD4z1R549r2WahFaAb+Y
         z37g==
X-Forwarded-Encrypted: i=1; AJvYcCVAyxHsrvfqI27PFQ2z0uA7omuStsWPyLDB+mKPg/+wqWq/OED1qErau7WOudSI2WNs40sil5N7PEh1rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDS5nqeYHii8zHTfzieDjpUVi6pmdXW0545xKPTgMmaTMC3eDo
	mW80/shSE5av1ghElOTAwaWkeKdz0WOz3XSakHZmYtNuu8apl6Hg3j+t7qSGLYbim1w=
X-Gm-Gg: ASbGncsTt26d0x2gpthgwNadIFK1NVl+GHIIKju1RwHsAzcF3MBCgb18kkQXeC2GcAH
	ylZJMCHTAOsdK9w7YEHKnkOPmQJ+f9i+J4XWB/tox3b8Hx2C++1IIh/efO7/YICsL+E/FCbkeA7
	qI37/5GoktrtuZX9BOoFQiBluZPVA+19ndCF7DQrz6xab+qLHY/pTRJ4jLslQCks/93zEuK2U8w
	0p06kuZC/NRyhrK7E3GRG8h2tq9WOptYu5KDxFxeqVDnC/ZNoKP41oYIECMfXSTH7Yf3PjT/xOl
	YiD5eHaGZpwuLg7yifp+Y90M8kxQfVPT/f+FyX6pmSEmsZVF0hl9Tgig/ZbhSWhxT85YN6pcNyx
	JvGZIRIYnXa7Iti5kEZ2Nz9Zgf/wzeX+xcCQI6iiVZRmOvg/6fuxCOLGJTyLaZAIeRHDIk+OSxe
	cKqw+JuvwlANAkT4jv68Q0WGKVV/SxM/yZDcz4ajY=
X-Google-Smtp-Source: AGHT+IH0yzURWuPv8VW/RjUUl9qa9zt/enWEU1D5SthlED3mzF6tQgAt/2S+5vm9CtTptImNeHaaWA==
X-Received: by 2002:a05:600c:1d1b:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4778fe679d3mr8062235e9.17.1763064986742;
        Thu, 13 Nov 2025 12:16:26 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc377039a55sm2848374a12.32.2025.11.13.12.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:16:26 -0800 (PST)
Message-ID: <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
Date: Fri, 14 Nov 2025 06:46:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
 <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/14 05:37, Daniel Vacek 写道:
> On Wed, 12 Nov 2025 at 22:02, Qu Wenruo <wqu@suse.com> wrote:
>> 在 2025/11/13 06:06, Daniel Vacek 写道:
>>> From: Josef Bacik <josef@toxicpanda.com>
>>>
>>> We only ever needed the bbio in btrfs_csum_one_bio, since that has the
>>> bio embedded in it.  However with encryption we'll have a different bio
>>> with the encrypted data in it, and the original bbio.  Update
>>> btrfs_csum_one_bio to take the bio we're going to csum as an argument,
>>> which will allow us to csum the encrypted bio and stuff the csums into
>>> the corresponding bbio to be used later when the IO completes.
>>
>> I'm wondering why we can not do it in a layered bio way.
>>
>> E.g. on device-mapper based solutions, the upper layer send out the bio
>> containing the plaintext data.
>> Then the dm-crypto send out a new bio, containing the encrypted data.
> 
> This is similar but fscrypt works on FS level. It gets the original
> plaintext bio (the btrfs_bio::bio one) and gives us a callback with
> the encrypted bio to calculate the checksum of the encrypted data. No
> plaintext bio goes to the storage layer.

Then why put the original bio pointer into the super generic btrfs_bio?

I thought it's more common to put the original plaintext into the 
encryption specific structure, like what we did for compression.

Thanks,
Qu

> 
> --nX
> 
>> The storage layer doesn't need to bother the plaintext bio at all, they
>> just write the encrypted one to disk.
>>
>> And it's the dm-crypto tracking the plaintext bio <-> encrypted bio mapping.
>>
>>
>> So why we can not just create a new bio for the final csum caculation,
>> just like compression?
>>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>>> ---
>>> Compared to v5 this needed to adapt to recent async csum changes.
>>> ---
>>>    fs/btrfs/bio.c       |  4 ++--
>>>    fs/btrfs/bio.h       |  1 +
>>>    fs/btrfs/file-item.c | 17 ++++++++---------
>>>    fs/btrfs/file-item.h |  2 +-
>>>    4 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>> index a73652b8724a..a69174b2b6b6 100644
>>> --- a/fs/btrfs/bio.c
>>> +++ b/fs/btrfs/bio.c
>>> @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
>>>        if (bbio->bio.bi_opf & REQ_META)
>>>                return btree_csum_one_bio(bbio);
>>>    #ifdef CONFIG_BTRFS_EXPERIMENTAL
>>> -     return btrfs_csum_one_bio(bbio, true);
>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, true);
>>>    #else
>>> -     return btrfs_csum_one_bio(bbio, false);
>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, false);
>>>    #endif
>>>    }
>>>
>>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>>> index deaeea3becf4..c5a6c66d51a0 100644
>>> --- a/fs/btrfs/bio.h
>>> +++ b/fs/btrfs/bio.h
>>> @@ -58,6 +58,7 @@ struct btrfs_bio {
>>>                        struct btrfs_ordered_sum *sums;
>>>                        struct work_struct csum_work;
>>>                        struct completion csum_done;
>>> +                     struct bio *csum_bio;
>>>                        struct bvec_iter csum_saved_iter;
>>>                        u64 orig_physical;
>>>                };
>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>> index 72be3ede0edf..474949074da8 100644
>>> --- a/fs/btrfs/file-item.c
>>> +++ b/fs/btrfs/file-item.c
>>> @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
>>>        return ret;
>>>    }
>>>
>>> -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
>>> +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, struct bvec_iter *iter)
>>>    {
>>>        struct btrfs_inode *inode = bbio->inode;
>>>        struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>>        SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>> -     struct bio *bio = &bbio->bio;
>>>        struct btrfs_ordered_sum *sums = bbio->sums;
>>> -     struct bvec_iter iter = *src;
>>>        phys_addr_t paddr;
>>>        const u32 blocksize = fs_info->sectorsize;
>>>        int index = 0;
>>>
>>>        shash->tfm = fs_info->csum_shash;
>>>
>>> -     btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>>> +     btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
>>>                btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
>>>                index += fs_info->csum_size;
>>>        }
>>> @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_struct *work)
>>>
>>>        ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
>>>        ASSERT(bbio->async_csum == true);
>>> -     csum_one_bio(bbio, &bbio->csum_saved_iter);
>>> +     csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
>>>        complete(&bbio->csum_done);
>>>    }
>>>
>>>    /*
>>>     * Calculate checksums of the data contained inside a bio.
>>>     */
>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async)
>>>    {
>>>        struct btrfs_ordered_extent *ordered = bbio->ordered;
>>>        struct btrfs_inode *inode = bbio->inode;
>>>        struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>> -     struct bio *bio = &bbio->bio;
>>>        struct btrfs_ordered_sum *sums;
>>>        unsigned nofs_flag;
>>>
>>> @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>>>        btrfs_add_ordered_sum(ordered, sums);
>>>
>>>        if (!async) {
>>> -             csum_one_bio(bbio, &bbio->bio.bi_iter);
>>> +             struct bvec_iter iter = bio->bi_iter;
>>> +             csum_one_bio(bbio, bio, &iter);
>>>                return 0;
>>>        }
>>>        init_completion(&bbio->csum_done);
>>>        bbio->async_csum = true;
>>> -     bbio->csum_saved_iter = bbio->bio.bi_iter;
>>> +     bbio->csum_bio = bio;
>>> +     bbio->csum_saved_iter = bio->bi_iter;
>>>        INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>>>        schedule_work(&bbio->csum_work);
>>>        return 0;
>>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
>>> index 5645c5e3abdb..d16fd2144552 100644
>>> --- a/fs/btrfs/file-item.h
>>> +++ b/fs/btrfs/file-item.h
>>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>>>    int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>>>                           struct btrfs_root *root,
>>>                           struct btrfs_ordered_sum *sums);
>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async);
>>>    int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>>>    int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>>>                             struct list_head *list, int search_commit,
>>


