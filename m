Return-Path: <linux-btrfs+bounces-5148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32B8CAA38
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1484A2821D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3D65478B;
	Tue, 21 May 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="diXPPN0v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D16286BD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281142; cv=none; b=WnReFj2wZNLl0uYyYHZ3pWhjvD5ST8PFT+zMHK4ujm+GCD912D2BAsNE/6oHv22dGpK6RdOSm006P+UfobDlRCqLnUlNk5GLzvwhcim08Aw+7rkDxSkRZGmRjXgAMxu5eiOw61NoA+kPMGEUwEh7/OjwesYEsZrvj5B0bTZBENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281142; c=relaxed/simple;
	bh=ri7JZrLwsN5CNu/jmEkf9XLtZ2DPL6FQGdGBc2KGUp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMRANFOZMHWLfeimtMTwd3LABYnyd64ZyQBq6j/6eK9g7/BBoG9kHtfqaykdpe1ZUWJKiHoFtHeav+8UvN30eaQWQl6TqFeBj6rOX4uA5NdZpP6KGbFysYx3aP7yQkVpNXYBHUITWFllt99WOzxcnAIfpOSjS0gccRNHqxXpz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=diXPPN0v; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso63801251fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716281138; x=1716885938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7zE6iPVpP2hGR1kvL0+UHS19qkKQMI0J0vRCiQLDFFI=;
        b=diXPPN0vZtY3YPA8Jch1ri3/5RFxX0ybQV/SePGz9NfvLWC4vEPKb6sqXsjGicybbb
         zeDonY7oWHvTehPaqMWbztE9pl6/sd5dtoY9OuDsp3W4eV1eOeh/TtD+Jw/kHrw0tUtz
         6+21n71x7Dgmh6t+dqQ7EnUdUfmFixAgcdOOYqAIjA7q0Qx5e1Yix80mkdpe/Td66sP9
         UQOFHKAQKcebSBEqR1Gc644ysTl7u9ywJzMS9BjtccyT90zZNMaaekmGZUy3eWwRsNQ+
         95vn3jj7nL6LqborP7Z+r1MyCcVs22Ygu0VaTcRczHE2Q11sEgEM5iyWLzfw7hB+CQOS
         8NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716281138; x=1716885938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zE6iPVpP2hGR1kvL0+UHS19qkKQMI0J0vRCiQLDFFI=;
        b=Wu8P1sFvsD8UKozPoLpF6O1IXG0/PwzCu1vEvZ9+BDNIf27yweDmklCUC0N3PCdHqQ
         dEDpFYZwkish0PrzO2QN+2vuD4lieORv3A+WAhpY5U/0Nt+5OshFz19/FXUtwSJDQVTu
         bM0ygqGMhxtG8N8E8nUKnly8e7xzQu21oII73GyJ1m02hUinnU/8QIC2aEKyBF+ZlF3b
         VAvi0ePhtoxG1L9hjyZF3H1HIlxdgoEg7Ir+OMOIaQs5GVYZNjGFU3D3Dqw1wMevhksm
         pK4+oRSkHV0mPs6dSF2e/h5NBMhC83PHTMlm4i6pQdBHGHzXrvIlZPiXlwccdiVuGhfk
         Cz4g==
X-Gm-Message-State: AOJu0YyYX1lQoHyt9VN/LUMWhfdO7dleBfOaelXMCIWMnQAjxmaeHExI
	JtYfy2P3N9gRvZatOqeYu9tlUQ2U3I2fz/mvfXTVDNuCXjclafoS8PG4zV8GaQA=
X-Google-Smtp-Source: AGHT+IGZzjEv3XwXRoYml124w4Q68zXqt9PWgFAQ0RGaOmXkqsLc64WJmGFvAn6P49iSqCi22P/Fbw==
X-Received: by 2002:a2e:d09:0:b0:2e5:2eaf:b09c with SMTP id 38308e7fff4ca-2e52eafb202mr237194631fa.37.1716281137734;
        Tue, 21 May 2024 01:45:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449faasm20337528a12.10.2024.05.21.01.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 01:45:37 -0700 (PDT)
Message-ID: <30371f39-18b1-4c3f-af31-b4927eab99a5@suse.com>
Date: Tue, 21 May 2024 18:15:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <cover.1716008374.git.wqu@suse.com>
 <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
 <7oxv5xm6n4yg5r523pzm7hxql5pihrfylrducrsiwlk5k4jl7a@wxvlrl6w6cbu>
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
In-Reply-To: <7oxv5xm6n4yg5r523pzm7hxql5pihrfylrducrsiwlk5k4jl7a@wxvlrl6w6cbu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/21 17:41, Naohiro Aota 写道:
[...]
> Same here.
> 
>>   	while (delalloc_start < page_end) {
>>   		delalloc_end = page_end;
>>   		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
>> @@ -1240,15 +1249,68 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>>   			delalloc_start = delalloc_end + 1;
>>   			continue;
>>   		}
>> -
>> -		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
>> -					       delalloc_end, wbc);
>> -		if (ret < 0)
>> -			return ret;
>> -
>> +		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
>> +					    min(delalloc_end, page_end) + 1 -
>> +					    delalloc_start);
>> +		last_delalloc_end = delalloc_end;
>>   		delalloc_start = delalloc_end + 1;
>>   	}
> 
> Can we bail out on the "if (!last_delalloc_end)" case? It would make the
> following code simpler.

Mind to explain it a little more?

Did you mean something like this:

	while (delalloc_start < page_end) {
		/* lock all subpage delalloc range code */
	}
	if (!last_delalloc_end)
		goto finish;
	while (delalloc_start < page_end) {
		/* run the delalloc ranges code* /
	}

If so, I can definitely go that way.

> 
>> +	delalloc_start = page_start;
>> +	/* Run the delalloc ranges for above locked ranges. */
>> +	while (last_delalloc_end && delalloc_start < page_end) {
>> +		u64 found_start;
>> +		u32 found_len;
>> +		bool found;
>>   
>> +		if (!btrfs_is_subpage(fs_info, page->mapping)) {
>> +			/*
>> +			 * For non-subpage case, the found delalloc range must
>> +			 * cover this page and there must be only one locked
>> +			 * delalloc range.
>> +			 */
>> +			found_start = page_start;
>> +			found_len = last_delalloc_end + 1 - found_start;
>> +			found = true;
>> +		} else {
>> +			found = btrfs_subpage_find_writer_locked(fs_info, folio,
>> +					delalloc_start, &found_start, &found_len);
>> +		}
>> +		if (!found)
>> +			break;
>> +		/*
>> +		 * The subpage range covers the last sector, the delalloc range may
>> +		 * end beyonds the page boundary, use the saved delalloc_end
>> +		 * instead.
>> +		 */
>> +		if (found_start + found_len >= page_end)
>> +			found_len = last_delalloc_end + 1 - found_start;
>> +
>> +		if (ret < 0) {
> 
> At first glance, it is strange because "ret" is not set above. But, it is
> executed when btrfs_run_delalloc_range() returns an error in an iteration,
> for the remaining iterations...
> 
> I'd like to have a dedicated clean-up path ... but I agree it is difficult
> to make such cleanup loop clean.

I can add an extra bool to indicate if we have any error, but overall 
it's not much different.

> 
> Flipping the if-conditions looks better? Or, adding more comments would be nice.

I guess that would go this path, flipping the if conditions and extra 
comments.

> 
>> +			/* Cleanup the remaining locked ranges. */
>> +			unlock_extent(&inode->io_tree, found_start,
>> +				      found_start + found_len - 1, NULL);
>> +			__unlock_for_delalloc(&inode->vfs_inode, page, found_start,
>> +					      found_start + found_len - 1);
>> +		} else {
>> +			ret = btrfs_run_delalloc_range(inode, page, found_start,
>> +						       found_start + found_len - 1, wbc);
> 
> Also, what happens if the first range returns "1" and a later one returns
> "0"? Is it OK to override the "ret" for the case? Actually, I guess it
> won't happen now because (as said in patch 5) subpage disables an inline
> extent, but having an ASSERT() would be good to catch a future mistake.

It's not only inline but also compression can return 1.

Thankfully for subpage, inline is disabled, meanwhile compression can 
only be done for a full page aligned range (start and end are both page 
aligned).

Considering you're mentioning this, I would definitely add an ASSERT() 
with comments explaining this.

Thanks for the feedback!
Qu

> 
>> +		}
>> +		/*
>> +		 * Above btrfs_run_delalloc_range() may have unlocked the page,
>> +		 * Thus for the last range, we can not touch the page anymore.
>> +		 */
>> +		if (found_start + found_len >= last_delalloc_end + 1)
>> +			break;
>> +
>> +		delalloc_start = found_start + found_len;
>> +	}
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (last_delalloc_end)
>> +		delalloc_end = last_delalloc_end;
>> +	else
>> +		delalloc_end = page_end;
>>   	/*
>>   	 * delalloc_end is already one less than the total length, so
>>   	 * we don't subtract one from PAGE_SIZE
>> @@ -1520,7 +1582,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
>>   					       PAGE_SIZE, !ret);
>>   		mapping_set_error(page->mapping, ret);
>>   	}
>> -	unlock_page(page);
>> +
>> +	btrfs_folio_end_all_writers(inode_to_fs_info(inode), folio);
>>   	ASSERT(ret <= 0);
>>   	return ret;
>>   }
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index 3c957d03324e..81b862d7ab53 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -862,6 +862,7 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
>>   void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
>>   				 struct folio *folio)
>>   {
>> +	struct btrfs_subpage *subpage = folio_get_private(folio);
>>   	u64 folio_start = folio_pos(folio);
>>   	u64 cur = folio_start;
>>   
>> @@ -871,6 +872,11 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
>>   		return;
>>   	}
>>   
>> +	/* The page has no new delalloc range locked on it. Just plain unlock. */
>> +	if (atomic_read(&subpage->writers) == 0) {
>> +		folio_unlock(folio);
>> +		return;
>> +	}
>>   	while (cur < folio_start + PAGE_SIZE) {
>>   		u64 found_start;
>>   		u32 found_len;
>> -- 
>> 2.45.0

