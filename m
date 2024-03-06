Return-Path: <linux-btrfs+bounces-3043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723A87449D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 00:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1621F1F2922F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 23:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D6524D2;
	Wed,  6 Mar 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GS2GP/+7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899524D9E6
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Mar 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768504; cv=none; b=srFzjGc8VS0tl8+c7SMC8i8inAikmDnLahUIdt+PrzdnSqht/QxaNP25cuQGkCU5i5tZmWhIxbq5pTpX0oSd06zSIkzApZdvbMcA9ObSLVqgQZ4R9utaRLq7h3NVQSuSZiEvyj5I/C37NpcYNFfRBf6XjAPsEbALsD9HtRl+LS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768504; c=relaxed/simple;
	bh=wrqDzQ07Z2+Nr7O5gIepGAi9tmm0f8TPEfaw5XRs3aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDEfzxuQ8ZfhF1EjCej+ghpxLC4XNMEyjY8zmXhx63yaN9y+eYq77HU1GnPyyvyljIWbP8jelsNp/djAwsOprLU43e5MUulkakLWvA2jVQMxGHblqG3vjx8Wfg0Jx5TbAcDP7SLJ7Qxi/LCqF+J7I/vgwXzXyQ51GaTqx8bMxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GS2GP/+7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so8897275e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Mar 2024 15:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709768498; x=1710373298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEI+a/RxQQIOalMKLpUdL5n7/G0UDZcyPfU8ULYbXUw=;
        b=GS2GP/+7ejFjeCyWLAmjxu9djPk6MnEUEtAgEv7rgekI1I0CMgRhhDUUmoYB/IBySr
         Ya/rePqbt/NlmiGpNR+814c3H5VWibLeM4KrEZzpY0ifFd9IxfT40Iy7H+2dKBFPev0z
         fJkI3MbJs567aKp84McmlnDlAH6AQEefRZ4VOzbGrM7nQeWpaQTk3/Pll42FZGrK5yfh
         z8MLqMIiVXnv/uKI562j8XoBN/N81tvcEsXaw/Mz8BF7zTW+NNzdU5B2ivj1IR3qozNB
         w+qnK6ekdUTbKf1E0UvaFcEqjyO6MrFBBv4scPw/RRMwjVvnhmieFRtDjOSLNjDOGAD2
         Tq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768498; x=1710373298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEI+a/RxQQIOalMKLpUdL5n7/G0UDZcyPfU8ULYbXUw=;
        b=BPGBFItHqoSNyhvqm7ZfE3/8pUA2CLiTFmPBKgmMJlLK49Cc/EGRZYXyGSRoZPwdz9
         6Nf9oRy+PzCTSCQMLgp3CKRkamIBkriPMzXRBo/AemSSTjTSleT4zxwc58muBqj2zvxI
         EntjhTQ5r6r7Sj7o8+BD6CmwU/U/8PXLEAN2odsqZj/q5EHfA+tWQNiJiZvm/cLiz+Qc
         ELAwPly7YJb1Io1EkaqVBISirFGWjRw25hr62VPceDJDA5MlHVanZtalbcZ/FCs6h1af
         jampwYkckjZRulZmU2KiZAEW+0btSFIRCQAhRkCkzDwdZue59T6r6AdGr4Vy/H1kctXX
         zymw==
X-Gm-Message-State: AOJu0Yxjd1cbaX1fuFonEKUQhs0b1rEkkYUUDFQI+3pkkQvaO0L1WZuf
	so0UB6WT0gLGtgMXv3SoL6jVEM1hv5rznVtcYUu9nL4LOaMac2/57wfhmzP2IhQ=
X-Google-Smtp-Source: AGHT+IGpWqZhiVeIyD378asVazZxn8BygF2EgocWjv4OGqx76XfO/9DarXFq1WhUPoPuKWJ/XgjI0w==
X-Received: by 2002:adf:b212:0:b0:33e:21ac:b89d with SMTP id u18-20020adfb212000000b0033e21acb89dmr6572271wra.6.1709768497706;
        Wed, 06 Mar 2024 15:41:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001dcc2847655sm13189856plh.176.2024.03.06.15.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:41:37 -0800 (PST)
Message-ID: <eab5accc-3107-4fc5-931b-f5356a5fc7a6@suse.com>
Date: Thu, 7 Mar 2024 10:11:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: make extent_write_locked_range() to handle
 subpage dirty correctly
Content-Language: en-US
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <7737c2e976c0bb2d36339ed0563cdbd07d846363.1709626757.git.wqu@suse.com>
 <3medpvju2zv5p6p2a6qyu3qmh74a6poggtfgc2cujdzkk5qfee@i2lpjrufiqgv>
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
In-Reply-To: <3medpvju2zv5p6p2a6qyu3qmh74a6poggtfgc2cujdzkk5qfee@i2lpjrufiqgv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/7 01:53, Naohiro Aota 写道:
> On Tue, Mar 05, 2024 at 06:49:25PM +1030, Qu Wenruo wrote:
>> [BUG]
[...]
>>
>> It looks like we have already more than enough infrastructure for zoned
>> devices, as find_lock_delalloc_range() would already return a range
>> no larger than max zone append size.
> 
> Yes, and basically it is to ensure one extent = one bio rule.
> 
> But, I'd like to lift that limitation. Even if one extent is handled
> by multiple bios, the current extent split code (in end_bio path) should
> keep it merged if they are written sequentially. So, there is an
> opportunity to have a larger extent == less metadata. However, I hit a bug
> when I lifted the restriction, so that's not done yet.

OK, so there are still some pitfalls, thanks for verifying that.

> 
>>
>> Thus it looks to me that, we're fine to go without a dedicated
>> run_delalloc_cow() just for zoned.
>>
>> And since the delalloc range would be locked during
>> find_lock_delalloc_range(), the content of all the pages won't be
>> changed, thus I didn't see much reason why we can not go the regular
>> cow_file_range() + __extent_writepage_io() path.
> 
> While the delalloc range is locked, pages except the first page are
> unlocked in cow_file_range() -> extent_clear_unlock_delalloc(). That allows
> another thread to grab the unlocked pages and send a bio from that thread.
> That will break one extent == one bio rule.

Although cow_file_range() unlocked the remaining page of the delalloc 
range (except the first page), those pages are still dirty and not 
marked writeback.

And we only clear and mark those (sub)pages writeback during 
__extent_writepage_io().

The only difference is in the page lock lifespan:

- The non-zoned COW path
   Pages locked during run_delalloc_range(), then unlocked.
   Relocked in extent_write_cache_pages() for submissioin.

- The zoned COW path
   Pages kept locked until submission is done.

Although I'd say the zoned COW path has much simpler lifespan
(run_delalloc and submission happen for the same range, without page 
unlocking).

Anyway I have eventually pinned down the root cause for subpage + zoned 
error, and it's related to that full page_clear_dirty_for_io() call 
inside extent_write_locked_range().

Personally speaking I'm not a big fan of how we handle delalloc and 
submission, and the zoned one looks a little more nature to me.
I'll check if we can make every write path to follow the same behavior.

Thanks,
Qu
> 
> Well, as I said above, current end_bio can handle that case well (not
> tested, though). So, it's more meant for optimization nowadays, to have
> less extent split.
> 
>>
>> Of course I'll try to dig deeper to fully solve all the subpage + zoned
>> bugs, but if we have more shared code paths, it would make our lives
>> much easier.
>>
>> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
>> Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index fb63055f42f3..e9850be26bb7 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2286,13 +2286,15 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
>>   		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
>>   		u32 cur_len = cur_end + 1 - cur;
>>   		struct page *page;
>> +		struct folio *folio;
>>   		int nr = 0;
>>   
>>   		page = find_get_page(mapping, cur >> PAGE_SHIFT);
>>   		ASSERT(PageLocked(page));
>> +		folio = page_folio(page);
>>   		if (pages_dirty && page != locked_page) {
>>   			ASSERT(PageDirty(page));
>> -			clear_page_dirty_for_io(page);
>> +			btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
>>   		}
>>   
>>   		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
>> @@ -2302,8 +2304,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
>>   
>>   		/* Make sure the mapping tag for page dirty gets cleared. */
>>   		if (nr == 0) {
>> -			set_page_writeback(page);
>> -			end_page_writeback(page);
>> +			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
>> +			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
>>   		}
>>   		if (ret) {
>>   			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
>> -- 
>> 2.44.0

