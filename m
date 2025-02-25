Return-Path: <linux-btrfs+bounces-11814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E45A44E78
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 22:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F08189434B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC01ACED7;
	Tue, 25 Feb 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g6ggdfAv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E519ABAB
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517950; cv=none; b=pvBzD+EAMEoZYCHMCQ9+lFjVtoQ/PPJutuzRg7a+Kl5R9rY4OX4rsRVThbGDZdBZ+pxOF920LA6M8pFootwmdBUR9xPiBRyTZPcwhQt5bP3e4JYyJN8Tik/JIFxUfgFKL2I3kqOvlKYcGM3xA1k365fcjv0wUSLNw8SGpY/xzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517950; c=relaxed/simple;
	bh=daJ/jrlPtkcVhehklmGh+ABWdYsSNPEosuPwTDBY7jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzPKsf6lTwu7cDrO07PiSZjW3VDZdk7z+mSM67HR6E+VwjvMgH0fbO7zcmdztGz4/bTiixEDt3qzhbvF7HwR+75WbhZGZeEvTisgScJpnn6oywbe151Z5t3X45RoZU5n3T4emAv2wrJRkd8NCPUe+QMFfccZrgIWY4IYGFMc7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g6ggdfAv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f22fe889aso5382458f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740517945; x=1741122745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tJUFTj9xQ0Evo03vcK6h9T4tzzRGCYsYmQ7WAwUKlo=;
        b=g6ggdfAv1lmMURHEUG6KHByDpDUcLcp6yEdfpF63p16AmSvo0b9yq8zROMtm4wGTqM
         ouzt5lalz+nDLfVLkovViyyRuOeJ9+M6a4uLb7Ahw4BO/ODnE/HYpmHoIiGDPx1Y05YB
         KuFpbczyDhBvQoTtKjwY+e4oDXCwaGS0VKwWlK6yZ0iWfYDLVcksEsitYb45RrKU4pSj
         ys/Ko1Uukiuac/adRh6eLAwODjVg1tM1DQwM+LkE0viDViEc/GCnkxZft74XowLhco4V
         WTGWmKyLAWrJCoIXmdgvdemsyNmw8ax+1r6AL1DzwwHIGYQ3HFzUCHy7ilsMD1Xu9nA2
         c0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517945; x=1741122745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tJUFTj9xQ0Evo03vcK6h9T4tzzRGCYsYmQ7WAwUKlo=;
        b=HOZ2cL0X8GhIlf22GuiLiEQMn7UUu+1cL9thMqTIusm/LIAy5erRVp800SL6s6WkQ/
         dsMjgApbJk8FD5R8xHglJQw+9A+0TYB4O9l7rgDGy6d10lESEb8Yet3yET+5WVl8aNdu
         NK6YrIVi/t+nRgre8AhcYZl597+33c+362k5O7uYIlBHaEPH7x63QJ3VJA0u0U6e2mX2
         aVaZK6zAq5it85H43yo7Op3NCNnWHcPPhfQGjI2OvQxZSZ2h7M1SvrO3jrkUIOr05163
         t+xmHoVPEc1x4LmzkQCgvtfc9QSLVPMzRT+En8yb8is24Cm3Tzaufbj9vebwZMLmSrey
         VusA==
X-Gm-Message-State: AOJu0Ywn3FhcvgXdVM7+eIlYP1exfFLo4cADPetHGry00qCmL6/oBaWp
	Qx46JHCKQrm+TK3qejuQlHCblCVlEVzdo5u8P9Y0pIK+VDQ34oP9FqTMjryMA6t6RvJXHwYcg5L
	q
X-Gm-Gg: ASbGnctI2Svk7/TPW+w/4Qdbw4xrYG8NGlosE4UqYc3bn9MKt8EvulgMKxVoLldb5nE
	6pBpNhWeMEmIwspiVgn0ymnx8qxvF7d/WvW89tZ9u7sruNCirqyCwe2iZZNVoD7DCA5VaYNCihF
	bfwIqdZXkKy9Em9Mor6YFQA5AyRW5bPi40z79DFxA9Oha0tLZEmCGnn9yHd6eNrcyvPulzqMsDa
	yrmZg0je7gR5KZpIGWZooItpWa5ijQGCjw03aGWxfx+sLKSTzkUUk5Ip5FOlagDYpAdOcanYzPk
	25Utet6/tNVoLWAO8I3y4YHjNMW59RNVykheAbSFNIJq+SsFwTv8Iw==
X-Google-Smtp-Source: AGHT+IEhNAln8B8kJJg8/7QP4HBokPcTcknd6Hd38eJca+aAfYooGXnty3d6ljhlo71eAX3Wa27B3A==
X-Received: by 2002:adf:e80a:0:b0:38d:af14:cb1 with SMTP id ffacd0b85a97d-390cc63c5a1mr4138937f8f.54.1740517944388;
        Tue, 25 Feb 2025 13:12:24 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0ae9basm19067725ad.226.2025.02.25.13.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:12:23 -0800 (PST)
Message-ID: <e8b84e01-a56d-427e-b188-6c2539a0093b@suse.com>
Date: Wed, 26 Feb 2025 07:42:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs: introduce a read path dedicated extent lock
 helper
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740354271.git.wqu@suse.com>
 <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
 <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/26 03:35, Filipe Manana 写道:
> On Sun, Feb 23, 2025 at 11:47 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Currently we're using btrfs_lock_and_flush_ordered_range() for both
>> btrfs_read_folio() and btrfs_readahead(), but it has one critical
>> problem for future subpage enhancements:
>>
>> - It will call btrfs_start_ordered_extent() to writeback the involved
>>    folios
>>
>>    But remember we're calling btrfs_lock_and_flush_ordered_range() at
>>    read paths, meaning the folio is already locked by read path.
>>
>>    If we really trigger writeback, this will lead to a deadlock and
>>    writeback can not hold the folio lock.
>>
>>    Such dead lock is prevented by the fact that btrfs always keeps a
>>    dirty folio also uptodate, by either dirtying all blocks of the folio,
>>    or read the folio before dirtying.
>>
>>    But it's not the common behavior, as XFS/EXT4 both allow the folio to
>>    be dirty but not uptodate, by allowing buffered write to dirty a full
>>    block without reading the full folio.
> 
> Ok, but what happens in other filesystems doesn't affect us.
> Or did you forget to mention that some other subsequent patch or planned changes
> will introduce that behaviour?
> 
> If so, it would be best to say that, otherwise that paragraph isn't relevant.

Got it, will add the mention of the incoming feature of partial uptodate 
folio support.

But still, all the work done here is mostly to pass generic/563, which I 
have to say the EXT4/XFS behavior is still a pretty good optimizatioin.

I'll change the paraph to focus on the incoming optimization.

> 
>>
>> Instead of blindly calling btrfs_start_ordered_extent(), introduce a
>> newer helper, which is smarter in the following ways:
>>
>> - Only wait and flush the ordered extent if
>>    * The folio doesn't even have private set
>>    * Part of the blocks of the ordered extent is not uptodate
> 
> is -> are
> 
>>
>>    This can happen by:
>>    * Folio writeback finished, then get invalidated. But OE not yet
>>      finished
> 
> Ok, this one I understand.
> 
>>    * Direct IO
> 
> This one I don't because direct IO doesn't use the page cache.
> Can you elaborate here and explain why it can happen with direct IO?

Direct IO always drops the cache first, so the folio in the direct IO 
range should have no private attached just like it was invalidated.

And direct IO doesn't wait for the OE to finish, we will have the same 
case just like the previous case.

> 
>>
>>    We have to wait for the ordered extent, as it may contain
>>    to-be-inserted data checksum.
>>    Without waiting, our read can fail due to the missing csum.
>>
>>    But either way, the OE should not need any extra flush inside the
>>    locked folio range.
>>
>> - Skip the ordered extent completely if
>>    * All the blocks are dirty
>>      This happens when OE creation is caused by previous folio.
> 
> "OE creation is caused by previous folio" - what does this mean?
> You mean by a write that happened before the read?

I mean the following case, 16K page size 4K block size:


    0      8K     16K    24K     32K
    |/////////////|//////|       |

The writeback for folio 0 started, which ran delalloc range for [0, 
24K), thus we have an OE at [0, 24K).

But at the same time, since range [24K, 32K) is not uptodate, a read can 
be triggered on folio 16K.

> 
> 
>>      The writeback will never happen (we're holding the folio lock for
>>      read), nor will the OE finish.
>>
>>      Thus we must skip the range.
>>
>>    * All the blocks are uptodate
>>      This happens when the writeback finished, but OE not yet finished.
>>
>>      Since the blocks are already uptodate, we can skip the OE range.
>>
>> The newer helper, lock_extents_for_read() will do a loop for the target
>> range by:
>>
>> 1) Lock the full range
>>
>> 2) If there is no ordered extent in the remaining range, exit
>>
>> 3) If there is an ordered extent that we can skip
>>     Skip to the end of the OE, and continue checking
>>     We do not trigger writeback nor wait for the OE.
>>
>> 4) If there is an ordered extent that we can not skip
>>     Unlock the whole extent range and start the ordered extent.
>>
>> And also update btrfs_start_ordered_extent() to add two more parameters:
>> @nowriteback_start and @nowriteback_len, to prevent triggering flush for
>> a certain range.
>>
>> This will allow us to handle the following case properly in the future:
>>
>>   16K page size, 4K btrfs block size:
>>
>>   16K           20K             24K              28K            32K
>>   |/////////////////////////////|                |              |
>>   |<----------- OE 2----------->|                |<--- OE 1 --->|
>>
>>   The folio has been written back before, thus we have an OE at
>>   [28K, 32K).
>>   Although the OE 1 finished its IO, the OE is not yet removed from IO
>>   tree.
>>   Later the folio got invalidated, but OE still exists.
> 
> This last sentence to be less confusing: "The folio got invalited
> after writeback completed and before the ordered extent finished."
> 
>>
>>   And [16K, 24K) range is dirty and uptodate, caused by a block aligned
>>   buffered write (and future enhancements allowing btrfs to skip full
>>   folio read for such case).
>>
>>   Furthermore, OE 2 is created covering range [16K, 24K) by the writeback
>>   of previous folio.
> 
> What previous folio? There's no other one in the example.
> Do you mean there's a folio for range [0, 16K) and running delalloc
> resulted in the creation of an OE for the range [0, 24K)? So that OE 2
> doesn't really start at 16K but at 0 instead?

Yep, exactly.

[...]
> Normally the parameter list/description comes before describing the
> return values.
> 
>> + */
>> +static bool can_skip_one_ordered_range(struct btrfs_inode *binode,
> 
> Why binode and not just inode? There's no vfs inode in the function to
> make any confusion.

OK, will go the regular inode naming.

> 
> 
>> +                                      struct btrfs_ordered_extent *ordered,
>> +                                      u64 cur, u64 *next_ret)
>> +{
>> +       const struct btrfs_fs_info *fs_info = binode->root->fs_info;
>> +       struct folio *folio;
>> +       const u32 blocksize = fs_info->sectorsize;
>> +       u64 range_len;
>> +       bool ret;
>> +
>> +       folio = filemap_get_folio(binode->vfs_inode.i_mapping,
>> +                                 cur >> PAGE_SHIFT);
>> +
>> +       /*
>> +        * We should have locked the folio(s) for range [start, end], thus
>> +        * there must be a folio and it must be locked.
>> +        */
>> +       ASSERT(!IS_ERR(folio));
>> +       ASSERT(folio_test_locked(folio));
>> +
>> +       /*
>> +        * We several cases for the folio and OE combination:
>> +        *
>> +        * 0) Folio has no private flag
> 
> Why does the numbering start from 0? It's not code and it's not
> related to array indexes or offsets :)

Because I forgot the folio to-be-read may not even be managed by btrfs, 
and hit ASSERT()s related to that.
Thus I think the private flag should be an important prerequisite, and 
give it 0.

But you're right, in fact it's very common and should not be treated 
specially.

> 
>> +        *    The OE has all its IO done but not yet finished, and folio got
>> +        *    invalidated. Or direct IO.
> 
> Ok so I still don't understand the direct IO case, because direct IO
> doesn't use the page cache.
> Just like the change log, some explanation here would be desired.
> 
>> +        *
>> +        * Have to wait for the OE to finish, as it may contain the
>> +        * to-be-inserted data checksum.
>> +        * Without the data checksum inserted into csum tree, read
>> +        * will just fail with missing csum.
> 
> Well we don't need to wait if it's a NOCOW / NODATASUM write.

That is also a valid optimization, I can enhance the check to skip 
NODATASUM OEs.

Thanks a lot for reviewing the core mechanism of the patchset.

Thanks,
Qu


