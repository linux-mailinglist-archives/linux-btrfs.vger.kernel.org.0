Return-Path: <linux-btrfs+bounces-2477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E247C8593A2
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Feb 2024 00:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564B01F21E05
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6C80045;
	Sat, 17 Feb 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fU5fzkZe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23814A86
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708213851; cv=none; b=A/voFBAcdo0+WdB2c8oIJEGBoOyTX0Cv+4EytjrLG5ogrpfPkLkdqmHHDJVGg9CpyvBRuWJqLw9k6qO4bE/AGzYyy9rc4e21Ahz76f6L7hO2nqCvNhI/luWHPx0ytRe7iBkrWm4xAEJbkXOvOFXFXQ6AiMZcCmogvtzMm1HyvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708213851; c=relaxed/simple;
	bh=VbkTDJEw4SHx7bEpgXHGRnipPydYBKzwqxLcJwS466g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jlV5JjHwmhsPWaWfZcjw/H/UGsZE4SRly5SyYyPA9DavB/t5xfr5irjikrsJsdB0jxMw9Cg3+8YuCQMjDXOaeIle6pvBwG0SorOH3A+tHhS98ZeVLfrPE2aaeOLl6LnaPo4dG+o3KpgNaCfZVr8l32YHk7MNVxkTzmt0xvmr/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fU5fzkZe; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0aabed735so38944411fa.0
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708213845; x=1708818645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27nL9E2AFuqMp1N6PMSkZK/jvFs/BESKn03vCFMp3/E=;
        b=fU5fzkZeNKSurNLhgrBPEw+TUb+HE3AGd5InUfQJVjHvJY4L9zRDFpfEJd0ygMBiFc
         2HgS27qn5WX3hg4lhx2BA9oA/eeYT4Dy3uwkcb5f6QxzlfkThdiZxP3xlEq+WLKrQFdj
         WJqhFHhzpuX/VjRISS8IpYWf81QgXbl6Awxws2Chtopfzt4t1Oz88OjB0ZJTTDh++Noe
         8nB3XwdVC4YerWfJmyHyr/2Zl7N+XfrZNUw1cT4zc99S+atnq20E8Xl+T4Ac6kBd6LJo
         49aq99D5YUXxRjc3tKg84DZKHko0gEHM9FrPOiEJdDJ0VFXtjDj0wwpiVVThrC4JQZ0j
         vYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708213845; x=1708818645;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27nL9E2AFuqMp1N6PMSkZK/jvFs/BESKn03vCFMp3/E=;
        b=s0F3QhbVRoutZ6SEAmysT+yiS/sE1V7Tml5rW+tA8o6UXYPXKhY8JC8Jq+6+ypreGk
         JzFbwJTzCLQG1ntGk+6CkIxxj61KKajKYwEb8urTLpmxK6+ubQzSF7zUOcVA2m2cvfoa
         L37BhAdLMxYU1kqwS73WQrMsobw/4f5nw+3tLNMW7opfdSVCBnrkrVZwTy4DBDXbiGiF
         ie4gg8lZCORd2iZCDzy2eHvYooSgH1iIgkwCukNxGAL91iBGbPIiXiyB67uUMQNZzGL2
         YQ3RQPAQrGcj9SB+m1NmY5ep4DZbOTlIJMWS/cHJlvSFv8iBlcLqXlFDaFxSzt21uLA8
         109w==
X-Gm-Message-State: AOJu0YxNFg3/MiCP8rJR/A19+qlHwuj/N5f5npvrnnAMZF8rPvFAgMfz
	d8EwjVJ/6gSux5V5PkUfJSnOP8414MfsBXxcTO5k5xuSof+f/3Gaj3zixkgJ7LSNU6atq/vNLUN
	wkvM=
X-Google-Smtp-Source: AGHT+IEQtCFp4+YbNnHj+iBGaPt9jbvApJinW3rDNKhOQBrX8OpbN6cuvKsuZ3oFQ7uv+Z+i6A6ODQ==
X-Received: by 2002:a2e:b5ce:0:b0:2d2:31e5:103b with SMTP id g14-20020a2eb5ce000000b002d231e5103bmr726853ljn.17.1708213845573;
        Sat, 17 Feb 2024 15:50:45 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001c407fac227sm1926291plb.41.2024.02.17.15.50.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 15:50:45 -0800 (PST)
Message-ID: <40b225e1-579c-4fe5-a0ac-7cc240dd5f7a@suse.com>
Date: Sun, 18 Feb 2024 10:20:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make find_lock_delalloc_range() to search until
 the page end.
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <0e21cf35395fd49b87c940cb86332961c1236157.1708160640.git.wqu@suse.com>
 <f6d63a22-934c-45c0-9cb0-ba32dd5cf672@suse.com>
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
In-Reply-To: <f6d63a22-934c-45c0-9cb0-ba32dd5cf672@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/18 09:54, Qu Wenruo 写道:
> 
> 
> 在 2024/2/17 19:34, Qu Wenruo 写道:
>> Currently all caller of lock_delalloc_pages() would assigned @end to the
>> end of the page, thus if we return false, there is no more delalloc
>> range in the page.
>>
>> Thus there is really no need to update @start/@end when we return false,
>> callers doesn't really utilize that value either.
>>
>> Finally since the end is always the page end, we only need to make sure
>> the @start is inside the locked page, thus the ASSERT()s can be
>> simplified.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Please ignore this one (at least for now).
> 
> Under certain fsstress seed, it can lead to a crash caused by some 
> dirtied range not covered by an ordered extent.
> 
> The current debug shows by somehow the newer find_lock_delalloc_range() 
> can ignore some delalloc range.
> 
> Would update it to fix the regression.
> 
> Thanks,
> Qu
>> ---
>>   fs/btrfs/extent_io.c             | 34 +++++++++++++-------------------
>>   fs/btrfs/tests/extent-io-tests.c | 10 ----------
>>   2 files changed, 14 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 197b9f50e75c..50c58c8568ff 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -306,16 +306,19 @@ static noinline int lock_delalloc_pages(struct 
>> inode *inode,
>>    * Find and lock a contiguous range of bytes in the file marked as 
>> delalloc, no
>>    * more than @max_bytes.
>>    *
>> - * @start:    The original start bytenr to search.
>> - *        Will store the extent range start bytenr.
>> - * @end:    The original end bytenr of the search range
>> - *        Will store the extent range end bytenr.
>> + * @start:    INPUT and OUTPUT.
>> + *        INPUT for the original start bytenr to search.
>> + *        OUTPUT to store the found delalloc range start bytenr.
>> + *        The output value is still inside the locked page.
>> + * @end:    OUTPUT only.
>> + *        OUTPUT to store the delalloc range end bytenr.
>> + *        The output value can go beyond the locked page.
>>    *
>>    * Return true if we find a delalloc range which starts inside the 
>> original
>>    * range, and @start/@end will store the delalloc range start/end.
>>    *
>>    * Return false if we can't find any delalloc range which starts 
>> inside the
>> - * original range, and @start/@end will be the non-delalloc range 
>> start/end.
>> + * original range and @start/@end won't be touched.
>>    */
>>   EXPORT_FOR_TESTS
>>   noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>> @@ -325,7 +328,7 @@ noinline_for_stack bool 
>> find_lock_delalloc_range(struct inode *inode,
>>       struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>>       struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>>       const u64 orig_start = *start;
>> -    const u64 orig_end = *end;
>> +    const u64 orig_end = page_offset(locked_page) + PAGE_SIZE - 1;
>>       /* The sanity tests may not set a valid fs_info. */
>>       u64 max_bytes = fs_info ? fs_info->max_extent_size : 
>> BTRFS_MAX_EXTENT_SIZE;
>>       u64 delalloc_start;
>> @@ -335,12 +338,10 @@ noinline_for_stack bool 
>> find_lock_delalloc_range(struct inode *inode,
>>       int ret;
>>       int loops = 0;
>> -    /* Caller should pass a valid @end to indicate the search range 
>> end */
>> -    ASSERT(orig_end > orig_start);
>> +    /* The original start must be inside the @locked page. */
>> +    ASSERT(orig_start >= page_offset(locked_page) &&
>> +           orig_start < page_offset(locked_page) + PAGE_SIZE);
>> -    /* The range should at least cover part of the page */
>> -    ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
>> -         orig_end <= page_offset(locked_page)));
>>   again:
>>       /* step one, find a bunch of delalloc bytes starting at start */
>>       delalloc_start = *start;
>> @@ -348,10 +349,6 @@ noinline_for_stack bool 
>> find_lock_delalloc_range(struct inode *inode,
>>       found = btrfs_find_delalloc_range(tree, &delalloc_start, 
>> &delalloc_end,
>>                         max_bytes, &cached_state);
>>       if (!found || delalloc_end <= *start || delalloc_start > 
>> orig_end) {
>> -        *start = delalloc_start;
>> -
>> -        /* @delalloc_end can be -1, never go beyond @orig_end */
>> -        *end = min(delalloc_end, orig_end);
>>           free_extent_state(cached_state);
>>           return false;
>>       }
>> @@ -1206,12 +1203,9 @@ static noinline_for_stack int 
>> writepage_delalloc(struct btrfs_inode *inode,
>>       int ret = 0;
>>       while (delalloc_start < page_end) {
>> -        delalloc_end = page_end;
>>           if (!find_lock_delalloc_range(&inode->vfs_inode, page,

The root cause is, find_lock_delalloc_range() is not designed to locate 
any delalloc range inside the range [start, end], but really check if 
the extent covering byte @start is delalloc.
If not it returns false, and updates the range pointer to the current 
non-delalloc extent range.

So the scheme of find_lock_delalloc_range() is completely different with 
writepage_delalloc().

I'll fix it soon.

Thanks,
Qu

>> -                          &delalloc_start, &delalloc_end)) {
>> -            delalloc_start = delalloc_end + 1;
>> -            continue;
>> -        }
>> +                          &delalloc_start, &delalloc_end))
>> +            break;
>>           ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
>>                              delalloc_end, wbc);
>> diff --git a/fs/btrfs/tests/extent-io-tests.c 
>> b/fs/btrfs/tests/extent-io-tests.c
>> index 865d4af4b303..371ec714d500 100644
>> --- a/fs/btrfs/tests/extent-io-tests.c
>> +++ b/fs/btrfs/tests/extent-io-tests.c
>> @@ -179,7 +179,6 @@ static int test_find_delalloc(u32 sectorsize, u32 
>> nodesize)
>>        */
>>       set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
>>       start = 0;
>> -    end = start + PAGE_SIZE - 1;
>>       found = find_lock_delalloc_range(inode, locked_page, &start,
>>                        &end);
>>       if (!found) {
>> @@ -210,7 +209,6 @@ static int test_find_delalloc(u32 sectorsize, u32 
>> nodesize)
>>       }
>>       set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, 
>> NULL);
>>       start = test_start;
>> -    end = start + PAGE_SIZE - 1;
>>       found = find_lock_delalloc_range(inode, locked_page, &start,
>>                        &end);
>>       if (!found) {
>> @@ -244,18 +242,12 @@ static int test_find_delalloc(u32 sectorsize, 
>> u32 nodesize)
>>           goto out_bits;
>>       }
>>       start = test_start;
>> -    end = start + PAGE_SIZE - 1;
>>       found = find_lock_delalloc_range(inode, locked_page, &start,
>>                        &end);
>>       if (found) {
>>           test_err("found range when we shouldn't have");
>>           goto out_bits;
>>       }
>> -    if (end != test_start + PAGE_SIZE - 1) {
>> -        test_err("did not return the proper end offset");
>> -        goto out_bits;
>> -    }
>> -
>>       /*
>>        * Test this scenario
>>        * [------- delalloc -------|
>> @@ -265,7 +257,6 @@ static int test_find_delalloc(u32 sectorsize, u32 
>> nodesize)
>>        */
>>       set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, 
>> NULL);
>>       start = test_start;
>> -    end = start + PAGE_SIZE - 1;
>>       found = find_lock_delalloc_range(inode, locked_page, &start,
>>                        &end);
>>       if (!found) {
>> @@ -300,7 +291,6 @@ static int test_find_delalloc(u32 sectorsize, u32 
>> nodesize)
>>       /* We unlocked it in the previous test */
>>       lock_page(locked_page);
>>       start = test_start;
>> -    end = start + PAGE_SIZE - 1;
>>       /*
>>        * Currently if we fail to find dirty pages in the delalloc 
>> range we
>>        * will adjust max_bytes down to PAGE_SIZE and then re-search.  If
> 

