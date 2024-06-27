Return-Path: <linux-btrfs+bounces-6018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC891A42D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04AB2848CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915DF14A08E;
	Thu, 27 Jun 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3MSRHvm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF22149C64
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484833; cv=none; b=T0n3q1ZUwiLVq1Ws7rHnMYo2F3sYq5zUrsTAN0mqwKdUyJEUVO/RnC4xudclD1AEl+y1G8RiG62l7re95KSRGuAe0+dhtbxzUWQIpLp93FHqB2RLei+te8MAAr1dm+NO9kgCsRyIERorXGOx+Skqt+cvhwpNHGwWyF6ybsTH1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484833; c=relaxed/simple;
	bh=ykIzr4FzNYHnEUwrwZkkLwliGO2y2p0GgcOSqj4Hunk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMK75su2hSU81anDQwN6tIWu91IBZ0lxjrFTfOaYoAZkDrllBZewU2cHsON4O4Vf6mx0BYMzzkjPd7+o9HPAZB25JpmQSiyAeP+6IPh6V1Zr6PClhbr9g8c1Cefy9taoftIfUoVq6YHIUud96USkOkg6XLBEH+yVQa0QLK0e3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3MSRHvm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so85847821fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719484829; x=1720089629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=slbP+WhTJyf6EYpUbH271YhaCsjuCXzydlt3MeOX3Mo=;
        b=X3MSRHvmvHyXzyIIATh6EHeovDClnPkJd4Dhf0P+jWSAAJR0SYUeufQ8uW1E7YXiOz
         D5dsXHdOHLthT9lymnPEGkHKe13huSOwZSwp5a1J//SxdiDcVO86AgaEI9gtq61fXLdf
         B4bBVFDJQ94zKdi0AIWS8qOO6puRKzGkhojkgOyJ/Cuh5yo/RzmQG3gOHv5dn5Xz9XLW
         ERStW3e13dyATWs6oU3e1HD8hzWG+uUfF7TsQR2Ub9cLiIbE0Ktyl4qrHGVXs1OpUQ4E
         jsqLdLBuvJFJGp99m5CyGtcjSonOHBJXRbnvorHHCMZgGBMhZeMPgGygBay0uz1aM5sn
         e0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484829; x=1720089629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slbP+WhTJyf6EYpUbH271YhaCsjuCXzydlt3MeOX3Mo=;
        b=GU338kl0tvCljBRETYM/bFdCfriKUGO1XBO0ta62ZatbKX4qcQTkLjfRQ8f9FipQo/
         1/wnc3sGCsDSlqtlor4EMwzANb6O5J5URdb7HSNvFV498NWcwEYWnLAlM2IoKd04c389
         uL4iz5Rg2kL5ZpH1l6Rpy/DUVk48BLM7ygOw/ccU+oNx+isHTKGvSO5D/SatuhObd2Mu
         xlBoWwidZyg8TmeWcywfmVU7OQcHpPok+uNZpV/EIIUU5KEPbkZwzAfASMlEK8XUB03I
         5slKUEqq6aXF7i3zXfb/45usE2Y6TFY+JUGRn041gw3OUpbw8cbrVyo8JP4FAPHoHqKm
         9k8A==
X-Gm-Message-State: AOJu0YxkqNsI3qEQtvhV3hUD3BvjdGUdiE1nMcAIzVNFB7j188BLfh2C
	3y/3pWjnnhGfR4xiXbgNufY/mZvLGb3sbpQqmLVegc4gUZEPvK+56WYskcP5DCE=
X-Google-Smtp-Source: AGHT+IEWjttW+g/3yHHOFBG2igeR6zs+KkBFsFdAGQD6kEQzthU/Aw41l7bVj2LPTKzvOV9e4CQl9w==
X-Received: by 2002:a2e:9ed7:0:b0:2ec:58e8:d7a6 with SMTP id 38308e7fff4ca-2ec5b36b765mr75042771fa.5.1719484828802;
        Thu, 27 Jun 2024 03:40:28 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac99827csm10221115ad.200.2024.06.27.03.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 03:40:28 -0700 (PDT)
Message-ID: <c969431b-c2f4-4963-a25e-aef8d2b6f620@suse.com>
Date: Thu, 27 Jun 2024 20:10:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: remove the extra_gfp parameter from
 btrfs_alloc_page_array()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1719462554.git.wqu@suse.com>
 <1b08b3f46e29dbb6c88a6f7cf038c2487386bdb0.1719462554.git.wqu@suse.com>
 <CAL3q7H5OywgMv=BRRFwmNW5pEVLs7AfnuO+jDuz5hsV9CCGX5A@mail.gmail.com>
 <a6238bf2-4560-47ab-9daf-769d12be05dd@gmx.com>
 <CAL3q7H6uYdd8yrEwD5f+A7zHk=tRirKr=emC4nveuLe_tuqCKw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAL3q7H6uYdd8yrEwD5f+A7zHk=tRirKr=emC4nveuLe_tuqCKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/27 20:08, Filipe Manana 写道:
> On Thu, Jun 27, 2024 at 11:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/6/27 18:20, Filipe Manana 写道:
>>> On Thu, Jun 27, 2024 at 5:33 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> There is only one caller utilizing the @extra_gfp parameter,
>>>> alloc_eb_folio_array(). All the other callers do not really bother the
>>>> @extra_gfp at all.
>>>>
>>>> This patch removes the parameter from the public function, meanwhile
>>>> implement an internal version with @nofail parameter just for
>>>> alloc_eb_folio_array() to utilize.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/extent_io.c | 43 +++++++++++++++++++++++--------------------
>>>>    fs/btrfs/extent_io.h |  3 +--
>>>>    fs/btrfs/inode.c     |  2 +-
>>>>    fs/btrfs/raid56.c    |  6 +++---
>>>>    fs/btrfs/scrub.c     |  2 +-
>>>>    5 files changed, 29 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index dc416bad9ad8..64f8e7b4d553 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -695,22 +695,10 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
>>>>           return -ENOMEM;
>>>>    }
>>>>
>>>> -/*
>>>> - * Populate every free slot in a provided array with pages.
>>>> - *
>>>> - * @nr_pages:   number of pages to allocate
>>>> - * @page_array: the array to fill with pages; any existing non-null entries in
>>>> - *             the array will be skipped
>>>> - * @extra_gfp: the extra GFP flags for the allocation.
>>>> - *
>>>> - * Return: 0        if all pages were able to be allocated;
>>>> - *         -ENOMEM  otherwise, the partially allocated pages would be freed and
>>>> - *                  the array slots zeroed
>>>> - */
>>>> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>>>> -                          gfp_t extra_gfp)
>>>> +static int __btrfs_alloc_page_array(unsigned int nr_pages,
>>>> +                                   struct page **page_array, bool nofail)
>>>
>>> Please don't use functions prefixed with __, we have abandoned that
>>> practice, it's against our preferred coding style.
>>>
>>> Also instead of adding a wrapper function, why not just change the
>>> extra_gfp parameter of btrfs_alloc_page() to the "bool nofail" thing?
>>>
>>> You mentioned in the cover letter "callers have to pay for the extra
>>> parameter", but really are you worried about performance?
>>> On x86_64 the argument is passed in a register, which is super
>>> efficient, almost certainly better than the overhead of an extra
>>> function call.
>>
>> It's not about performance, but the burden on us reviewing/writing code
>> using that function.
>> As everytime we need to call that function, we have to check if we need
>> to use any special value for the extra parameter.
> 
> Well, that's the case for pretty much every other function call
> everywhere, we have to figure out what parameter values to pass.
> 
> If we start adding such wrappers around every case, we end up with
> plenty of these one line functions.
> And sooner or later someone will send a cleanup patch to remove them
> and make all callers pass the extra argument (we have a history of
> such cleanup patches).

OK, then I would just go rename the @extra_gfp parameter to @nofail as 
suggested.

Thanks,
Qu
> 
>>
>> The basic idea is, to keep the most common call to be simple (aka, less
>> parameters), and only for those special call sites to use the more
>> complex one.
>>
>> This is the only time I miss function overloading in C++.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>>    {
>>>> -       const gfp_t gfp = GFP_NOFS | extra_gfp;
>>>> +       const gfp_t gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
>>>>           unsigned int allocated;
>>>>
>>>>           for (allocated = 0; allocated < nr_pages;) {
>>>> @@ -728,19 +716,34 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>>>>           }
>>>>           return 0;
>>>>    }
>>>> +/*
>>>> + * Populate every free slot in a provided array with pages, using GFP_NOFS.
>>>> + *
>>>> + * @nr_pages:   number of pages to allocate
>>>> + * @page_array: the array to fill with pages; any existing non-null entries in
>>>> + *             the array will be skipped
>>>> + *
>>>> + * Return: 0        if all pages were able to be allocated;
>>>> + *         -ENOMEM  otherwise, the partially allocated pages would be freed and
>>>> + *                  the array slots zeroed
>>>> + */
>>>> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
>>>> +{
>>>> +       return __btrfs_alloc_page_array(nr_pages, page_array, false);
>>>> +}
>>>>
>>>>    /*
>>>>     * Populate needed folios for the extent buffer.
>>>>     *
>>>>     * For now, the folios populated are always in order 0 (aka, single page).
>>>>     */
>>>> -static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gfp)
>>>> +static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
>>>>    {
>>>>           struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
>>>>           int num_pages = num_extent_pages(eb);
>>>>           int ret;
>>>>
>>>> -       ret = btrfs_alloc_page_array(num_pages, page_array, extra_gfp);
>>>> +       ret = __btrfs_alloc_page_array(num_pages, page_array, nofail);
>>>>           if (ret < 0)
>>>>                   return ret;
>>>>
>>>> @@ -2722,7 +2725,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>>>>            */
>>>>           set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>>>
>>>> -       ret = alloc_eb_folio_array(new, 0);
>>>> +       ret = alloc_eb_folio_array(new, false);
>>>>           if (ret) {
>>>>                   btrfs_release_extent_buffer(new);
>>>>                   return NULL;
>>>> @@ -2755,7 +2758,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>>>>           if (!eb)
>>>>                   return NULL;
>>>>
>>>> -       ret = alloc_eb_folio_array(eb, 0);
>>>> +       ret = alloc_eb_folio_array(eb, false);
>>>>           if (ret)
>>>>                   goto err;
>>>>
>>>> @@ -3121,7 +3124,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>>>>
>>>>    reallocate:
>>>>           /* Allocate all pages first. */
>>>> -       ret = alloc_eb_folio_array(eb, __GFP_NOFAIL);
>>>> +       ret = alloc_eb_folio_array(eb, true);
>>>>           if (ret < 0) {
>>>>                   btrfs_free_subpage(prealloc);
>>>>                   goto out;
>>>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>>>> index 8364dcb1ace3..0da5f1947a2b 100644
>>>> --- a/fs/btrfs/extent_io.h
>>>> +++ b/fs/btrfs/extent_io.h
>>>> @@ -363,8 +363,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
>>>>    void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>>>>                                 struct extent_buffer *buf);
>>>>
>>>> -int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>>>> -                          gfp_t extra_gfp);
>>>> +int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
>>>>    int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array);
>>>>
>>>>    #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 92ef9b01cf5e..6dfcd27b88ac 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -9128,7 +9128,7 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
>>>>           pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>>>>           if (!pages)
>>>>                   return -ENOMEM;
>>>> -       ret = btrfs_alloc_page_array(nr_pages, pages, 0);
>>>> +       ret = btrfs_alloc_page_array(nr_pages, pages);
>>>>           if (ret) {
>>>>                   ret = -ENOMEM;
>>>>                   goto out;
>>>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>>>> index 3858c00936e8..294bf7349f96 100644
>>>> --- a/fs/btrfs/raid56.c
>>>> +++ b/fs/btrfs/raid56.c
>>>> @@ -1051,7 +1051,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
>>>>    {
>>>>           int ret;
>>>>
>>>> -       ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages, 0);
>>>> +       ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages);
>>>>           if (ret < 0)
>>>>                   return ret;
>>>>           /* Mapping all sectors */
>>>> @@ -1066,7 +1066,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
>>>>           int ret;
>>>>
>>>>           ret = btrfs_alloc_page_array(rbio->nr_pages - data_pages,
>>>> -                                    rbio->stripe_pages + data_pages, 0);
>>>> +                                    rbio->stripe_pages + data_pages);
>>>>           if (ret < 0)
>>>>                   return ret;
>>>>
>>>> @@ -1640,7 +1640,7 @@ static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
>>>>           const int data_pages = rbio->nr_data * rbio->stripe_npages;
>>>>           int ret;
>>>>
>>>> -       ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages, 0);
>>>> +       ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages);
>>>>           if (ret < 0)
>>>>                   return ret;
>>>>
>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>> index 4677a4f55b6a..2d819b027321 100644
>>>> --- a/fs/btrfs/scrub.c
>>>> +++ b/fs/btrfs/scrub.c
>>>> @@ -261,7 +261,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
>>>>           atomic_set(&stripe->pending_io, 0);
>>>>           spin_lock_init(&stripe->write_error_lock);
>>>>
>>>> -       ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages, 0);
>>>> +       ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages);
>>>>           if (ret < 0)
>>>>                   goto error;
>>>>
>>>> --
>>>> 2.45.2
>>>>
>>>>
>>>

