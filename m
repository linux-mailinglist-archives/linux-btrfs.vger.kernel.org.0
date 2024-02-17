Return-Path: <linux-btrfs+bounces-2476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D594F85939B
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Feb 2024 00:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053061C211A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D958003B;
	Sat, 17 Feb 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y76w/wXl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACA6D1AC
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212261; cv=none; b=OtogMWUCUevEZC3rZ/OhOMwfTDqyhITC6xs6Olp+NK7UEfyROBEopvJE1T5OjKJBteeayVReQj5xkjrMRaJ4jBQSpuJCOeieBWaq/k8b3pc6Abtjn7lX44tYyNLZ0JlemBcLPmUQIJ2STuhLzzKHNXEfovYzqI4hXu803O4ssss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212261; c=relaxed/simple;
	bh=UGZhcmL5masgoj3zBez45W4RnJdRRxTTA+QFwGQYw6w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cSygvTOb2Ff3dGt0GLFluEskWhYv55K3EFV9DEDf9Ppg0MPZaI9hXq3DrVv9TJQT8IzjypPBHIrs9Ti3j/oR/MieFqUGWqeTqQU04DaIccd1uI2SDaVQ0naHeNRlZGEP2/3Z+NusZbFgTfHA3Nv+/kVRZja/UTv3KGc6H8mi+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y76w/wXl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d26da3e15so694058f8f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708212257; x=1708817057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpCoNreY2yfqccoiXU3wkd4sTcBEvr7Eq0xk9Q/NfLQ=;
        b=Y76w/wXlM6OtlBFm53zy4JeA8UJfogLIMSp2iuh3XSMBo5KOHrjHEx6PA1B2+ZcGoF
         jzF+DcbX/VdZmSzPw5cblcMR29r8Pdi1qpSY5wIbF3RjDzY7yBi5OcpDaaLuo6ij5qLG
         ThBFR1hQSX4A2pq2fHtZbgVvVy/YXwx9yMTukD88/v2gJ0jmyfBhzkNCh58vHC0tBX3n
         cL5MKs5pu4CGzpo0Q2t3OB7vexREgROCvYxypyJn9+QZtB6L8TRDPJwMKgBxDVXyLmyr
         a8ESkvjeihd2hfKGbbcU1IBx5neb/g+s1AUOctnI11YBr8PbjN8v3Y5M+JcklYqNH3FJ
         Sphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212257; x=1708817057;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpCoNreY2yfqccoiXU3wkd4sTcBEvr7Eq0xk9Q/NfLQ=;
        b=WG4a6yqhZvEgFBkRbEqRWdDIJlWo+GzSkWbarhnKln288rmtY2yKFLevUXDY5OlVym
         1JuCBSdcsMy1Eq68GgorVXEDeB4kuQHhZQ5Qx7ZNccABDHxAXsGH6kXSCidV4ihilFyB
         9Jul59tNKNjrIeZ4vLx3tnli3MvdAhFAxwM0kv5L/LHpOHtNXz9fhaM6AeU8KBNIpfHy
         nl2NyRWFZdWwNiqx4Lni3Q8O+d+JL+ew2Fy+gN+t4tM7nW/0W0XOoAOpEwi+9b0eXOIx
         97LOgFYsJXakp/Iha0DX+SLjoZ+/EOnvIJ5eTpS+G+5I4CGh8qXsOEL9GT3oiavyyRPa
         CGyg==
X-Gm-Message-State: AOJu0YzB5FZiU0Mpv2frcx305dzUDnCxteY7Qs+B2Qag78MKLhUwPVy3
	O9qC7Dhf9f5yYmljMqKtHqNB4isQwNgy2JUERja+kOPMq89GIDU3H96DXugCY1ZO4whxO+tmNK0
	iEnQ=
X-Google-Smtp-Source: AGHT+IFcLJCcLzMz6VC/R94v39qAUKMX+5xwfGMThS9CiuTxuQ4CjEw7pDkrCGBkQUNMemXosSHmjg==
X-Received: by 2002:adf:f144:0:b0:33d:3cea:8484 with SMTP id y4-20020adff144000000b0033d3cea8484mr408512wro.1.1708212256724;
        Sat, 17 Feb 2024 15:24:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id nc15-20020a17090b37cf00b00295fac343cfsm2342541pjb.8.2024.02.17.15.24.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 15:24:16 -0800 (PST)
Message-ID: <f6d63a22-934c-45c0-9cb0-ba32dd5cf672@suse.com>
Date: Sun, 18 Feb 2024 09:54:11 +1030
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
In-Reply-To: <0e21cf35395fd49b87c940cb86332961c1236157.1708160640.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/17 19:34, Qu Wenruo 写道:
> Currently all caller of lock_delalloc_pages() would assigned @end to the
> end of the page, thus if we return false, there is no more delalloc
> range in the page.
> 
> Thus there is really no need to update @start/@end when we return false,
> callers doesn't really utilize that value either.
> 
> Finally since the end is always the page end, we only need to make sure
> the @start is inside the locked page, thus the ASSERT()s can be
> simplified.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please ignore this one (at least for now).

Under certain fsstress seed, it can lead to a crash caused by some 
dirtied range not covered by an ordered extent.

The current debug shows by somehow the newer find_lock_delalloc_range() 
can ignore some delalloc range.

Would update it to fix the regression.

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c             | 34 +++++++++++++-------------------
>   fs/btrfs/tests/extent-io-tests.c | 10 ----------
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 197b9f50e75c..50c58c8568ff 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -306,16 +306,19 @@ static noinline int lock_delalloc_pages(struct inode *inode,
>    * Find and lock a contiguous range of bytes in the file marked as delalloc, no
>    * more than @max_bytes.
>    *
> - * @start:	The original start bytenr to search.
> - *		Will store the extent range start bytenr.
> - * @end:	The original end bytenr of the search range
> - *		Will store the extent range end bytenr.
> + * @start:	INPUT and OUTPUT.
> + *		INPUT for the original start bytenr to search.
> + *		OUTPUT to store the found delalloc range start bytenr.
> + *		The output value is still inside the locked page.
> + * @end:	OUTPUT only.
> + *		OUTPUT to store the delalloc range end bytenr.
> + *		The output value can go beyond the locked page.
>    *
>    * Return true if we find a delalloc range which starts inside the original
>    * range, and @start/@end will store the delalloc range start/end.
>    *
>    * Return false if we can't find any delalloc range which starts inside the
> - * original range, and @start/@end will be the non-delalloc range start/end.
> + * original range and @start/@end won't be touched.
>    */
>   EXPORT_FOR_TESTS
>   noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
> @@ -325,7 +328,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>   	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>   	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>   	const u64 orig_start = *start;
> -	const u64 orig_end = *end;
> +	const u64 orig_end = page_offset(locked_page) + PAGE_SIZE - 1;
>   	/* The sanity tests may not set a valid fs_info. */
>   	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
>   	u64 delalloc_start;
> @@ -335,12 +338,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>   	int ret;
>   	int loops = 0;
>   
> -	/* Caller should pass a valid @end to indicate the search range end */
> -	ASSERT(orig_end > orig_start);
> +	/* The original start must be inside the @locked page. */
> +	ASSERT(orig_start >= page_offset(locked_page) &&
> +	       orig_start < page_offset(locked_page) + PAGE_SIZE);
>   
> -	/* The range should at least cover part of the page */
> -	ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
> -		 orig_end <= page_offset(locked_page)));
>   again:
>   	/* step one, find a bunch of delalloc bytes starting at start */
>   	delalloc_start = *start;
> @@ -348,10 +349,6 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>   	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
>   					  max_bytes, &cached_state);
>   	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
> -		*start = delalloc_start;
> -
> -		/* @delalloc_end can be -1, never go beyond @orig_end */
> -		*end = min(delalloc_end, orig_end);
>   		free_extent_state(cached_state);
>   		return false;
>   	}
> @@ -1206,12 +1203,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>   	int ret = 0;
>   
>   	while (delalloc_start < page_end) {
> -		delalloc_end = page_end;
>   		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
> -					      &delalloc_start, &delalloc_end)) {
> -			delalloc_start = delalloc_end + 1;
> -			continue;
> -		}
> +					      &delalloc_start, &delalloc_end))
> +			break;
>   
>   		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
>   					       delalloc_end, wbc);
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index 865d4af4b303..371ec714d500 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -179,7 +179,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	 */
>   	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
>   	start = 0;
> -	end = start + PAGE_SIZE - 1;
>   	found = find_lock_delalloc_range(inode, locked_page, &start,
>   					 &end);
>   	if (!found) {
> @@ -210,7 +209,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	}
>   	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
>   	start = test_start;
> -	end = start + PAGE_SIZE - 1;
>   	found = find_lock_delalloc_range(inode, locked_page, &start,
>   					 &end);
>   	if (!found) {
> @@ -244,18 +242,12 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   		goto out_bits;
>   	}
>   	start = test_start;
> -	end = start + PAGE_SIZE - 1;
>   	found = find_lock_delalloc_range(inode, locked_page, &start,
>   					 &end);
>   	if (found) {
>   		test_err("found range when we shouldn't have");
>   		goto out_bits;
>   	}
> -	if (end != test_start + PAGE_SIZE - 1) {
> -		test_err("did not return the proper end offset");
> -		goto out_bits;
> -	}
> -
>   	/*
>   	 * Test this scenario
>   	 * [------- delalloc -------|
> @@ -265,7 +257,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	 */
>   	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
>   	start = test_start;
> -	end = start + PAGE_SIZE - 1;
>   	found = find_lock_delalloc_range(inode, locked_page, &start,
>   					 &end);
>   	if (!found) {
> @@ -300,7 +291,6 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	/* We unlocked it in the previous test */
>   	lock_page(locked_page);
>   	start = test_start;
> -	end = start + PAGE_SIZE - 1;
>   	/*
>   	 * Currently if we fail to find dirty pages in the delalloc range we
>   	 * will adjust max_bytes down to PAGE_SIZE and then re-search.  If

