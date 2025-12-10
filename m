Return-Path: <linux-btrfs+bounces-19618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D15CB2751
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF56303524A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728C3019CB;
	Wed, 10 Dec 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bYKuc97b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705231EFFB4
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765356627; cv=none; b=RtdTBGoR3/AscL3uWqFv+Mj6NRMqBgpReBgLhv21tZOhVRsFK5ZsxGkTpEu8Hewhi5zUsPZSyuQGTF5E0FVcXznY7vjCKKXtYod568W78qJLM0OTU3CGzBpsHunsmQ1Sh7i2L0D/DQNFnfDE/1lYNwt2+qtZNNBEL+kPhVe5mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765356627; c=relaxed/simple;
	bh=xACxhM9c9ASzjpd5SktpLQE+U7MQ//p8B1CT/c5Lzto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JucQRrCpALPppRSLpjgLGQBf8IbYlipr6h3Exb93ACZUR9byk3uDFbwnia+FMoKilxfFv/HXgGh2YXznFMGEYdsg1qzME0/zCtXf5BtPGzpMsl3fN3TPvKbfFoyOG/je3AbfdV0V+qujfyaL+if7bIgSLF8aj8DKyUZKgBFr+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bYKuc97b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so61420495e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 00:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765356623; x=1765961423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=++Di7vHS5OWxq4kt9P5CwRICjbjak9JxFjzLldBUrew=;
        b=bYKuc97bnqn0TkiD0/Mkc9qqkkrpbJqU+sjQJhjuBNc54jSceQ2yWKgrlbJhjGv7Vp
         3S5HV4vBkvHwB1+yGsmcL3uEY+5VgWsxCFiDkfZW/BV/kj46WJO96N9ElI1sJE5Qz9m9
         7EyrIh0hhBaWNnvSfnqzhspCIKK8apUU/9Cx2Du2gwwBM4u3lyt1TC/rdNmUVs81EALf
         1QJvZsgVJA//dn9DeRzmnGKGjmVim/t1p/xG9nsG+IhtcosGGsMRRhrUzPYmasme7DuR
         ypWs/DAFGBLo5tg2isXVXppz/BEYjRtBy2B/8nUy6RGWbwbUJMiJZX/P36AGpEo/6DVY
         V4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765356623; x=1765961423;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++Di7vHS5OWxq4kt9P5CwRICjbjak9JxFjzLldBUrew=;
        b=FBu/rJSW8WBWpuBaJtzkcfZ9VzV6KphbfINrWraj/xmofByjTWiTZz9+keDYsoMijs
         ANKA8q26oaLa55yH1XKQ0SWtzRP4uFHCKDPS2IcQ+4RTKeo7WEX2IhldS0sr5jLQAG23
         Rpi7YKqR7nqyDrsJniXmvubSOHB5Cg+xJ+27J64hm7Kuw3WZmL3yhmBONlCDdgChxLF3
         onxAkXcy02ATjNShW2WjkGKZjjWH5sBWtsb2eiFyt8AZRgEvdfisbragNmZ8UCDDm7vX
         otG8V3eUbYUOeJxqMRsXenrTryyv+mYvo3NW6FFhpCq2P01lqcRiJ/pNuXH5mxy5/tAC
         cRNQ==
X-Gm-Message-State: AOJu0YyuSaQyZMJoAnl9sa5ORnM6LI4xUXSLAEj9OS9oO9kbJEG4hqM9
	hZ308Py3feFY9HaRRMmlOdTUpRiePeequP9ntG3niVu7ywIo9hSsAaBSHYCA/JN7g38=
X-Gm-Gg: ASbGncutR+ydFohE4xgOV22RQCB6QkT8X4uRKD6WrULqi98DHQgiTVXj7UtBolPvqqL
	GuEywfwUTeo2PWXUkC/Jdr/tb/FtXfCbfaQNQ2z2pmOdam0ey6gS8ts8i8hlh85ZTG0mL2KC1Az
	GGNIzIGazz/FKj/WFqq8+HZvLwC7LyoweEzanqXz7umdTPnRNxN3OEwJOWTVtE1Tk4bSIehKPNU
	g+hroHOlivalHCrYB44jQHMrgXUBIE3bvB1e/nvmSXL6REMBEkTcVn0uSbDDyARSk3miIzrESRl
	39EHmwI/bges+ZdBRok9rKzYZXiqHlFwV8kxjqkluGeRpblX7N48AwMFwJQVVFnuGF29YFCdreY
	at4udglG2r5RijJ7bbO2wBAFM1G0wM8xHirbolZxT888Kz/QLkjTfMSsPvie/gSCuXDmtH1li3T
	uP8fb1De12OgPe5KFXVoIdu4hFr/k1ido9It0OMXWrkrk2TYE0rQ==
X-Google-Smtp-Source: AGHT+IFcNU+hGc1YkDSHChkZSf64/iz+G1askmvctNUJ7ccY0DC52iyKawfO+BaUxmZvWwauDwFryQ==
X-Received: by 2002:a05:600c:1910:b0:477:b734:8c22 with SMTP id 5b1f17b1804b1-47a8376e3d9mr15733425e9.8.1765356622514;
        Wed, 10 Dec 2025 00:50:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a0a0066asm18424061b3a.29.2025.12.10.00.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 00:50:21 -0800 (PST)
Message-ID: <3c610ad4-b091-4fe2-9c18-689d6f9d3af3@suse.com>
Date: Wed, 10 Dec 2025 19:20:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are
 properly truncated
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
 <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/25 21:15, Filipe Manana 写道:
> On Tue, Nov 25, 2025 at 8:08 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [POSSIBLE BUG]
>> If there are multiple ordered extents beyond EOF, at folio writeback
>> time we may only truncate the first ordered extent, but leaving the
>> remaining ones finished but not marked as truncated.
>>
>> Since those OEs are not marked as truncated, it will still insert an
>> file extent item, and may lead to false missing csum errors during
>> "btrfs check".
>>
>> [CAUSE]
>> Since we have bs < ps support for a while and experimental large data
>> folios are also going to graduate from experimental features soon, we
>> can have the following folio to be written back:
>>
>>    fs block size 4K
>>    page size 4K, folio size 64K.
>>
>>             0        16K      32K                  64K
>>             |<---------------- Dirty -------------->|
>>             |<-OE A->|<-OE B->|<----- OE C -------->|
>>                 |
>>                 i_size 4K.
>>
>> In above case we need to submit the writeback for the range [0, 4K).
>> For range [4K, 64K) there is no need to submit any IO but mark the
>> involved OEs (OE A, B, C) all as truncated.
>>
>> However during the EOF handling, patch "btrfs: truncate ordered extent
>> when skipping writeback past i_size" only calls
>> btrfs_lookup_first_ordered_range() once, thus only got OE A and mark it
>> as truncated.
> 
> And there's a reason why the patch only looks for one ordered extent.
> 
> Because there shouldn't be more than one: btrfs_truncate() calls
> btrfs_wait_ordered_range() when we truncate the size of a file to a
> smaller value.
> The range goes from the new i_size, rounded down by sector size, to
> (u64)-1. And btrfs_wait_ordered_range() flushed any delalloc besides
> waiting for ordered extents.

Couldn't something like 18de34daa7c6 ("btrfs: truncate ordered extent 
when skipping writeback past i_size") happen? E.g. with more holes:

     0          16K    32K     36K   48K    52K   60K    64K
     |//////////|      |///////|     |//////|     |//////|

The range [0, 64k) is inside a large folio or just a single page (64K 
page size), and above "//" range is dirtied by buffered write.

Then we truncate the inode size to 16K, which set the inode size to 16K 
first, then call btrfs_truncate() which triggers 
btrfs_wait_ordered_range()->btrfs_fdatawrite_range() to do the writeback.

Then we start writing back the large folio 0 for range [0, 64K), 
creating ordered extents for [0, 16K), [32K, 36K), [48K, 52K), [60K, 64K).

Then call extent_writepage_io() to do the submission, which will only 
submit [0, 16K).
And the current code will only mark OE [32K, 36K) as truncated, missing 
[48K, 52K) and [60K, 64K).

Normally the file extent item insertion and later truncation (which 
drops all the inserted file extents) are inside the same transaction.

But if the transaction committed after the file extent items insertion 
but before the transaction dropping file extent items, then power loss 
happened, we got the same ordered extents beyond EOF and without csum.

Or did I miss something?

Thanks,
Qu

> 
> So how can we find more than one ordered extent after this?
> 
> I think this changelog should explain that, it makes no mention of
> this detail about btrfs_truncate().
> 
> Thanks.
> 
> 
>>
>> But OE B and C are not marked as truncated, they will finish as usual,
>> which will leave a regular file extent item to be inserted beyond EOF,
>> and without any data checksum.
>>
>> [FIX]
>> Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle all
>> OEs of a range, and mark them all as truncated.
>>
>> With that helper, all OEs (A B and C) will be marked as truncated.
>> OE B and C will have 0 truncated_len, preventing any file extent item to
>> be inserted from them.
>>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
>>    Since the range passed in is to the end of the folio during writeback
>>    path, there is no guarantee that there is always one or more ordered
>>    extents covering the full range.
>>
>>    This get triggered during fsstress runs, especially common on bs < ps
>>    cases.
>>
>>    Remove the ASSERT() and exit the oe search instead.
>>
>> Resend:
>> - Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
>>    calls for buffered write path'
>>    As this is a bug fix, which needs a little higher priority than
>>    the remaining optimizations.
>>
>> - Fix various grammar errors
>>
>> - Use @end to replace duplicated calculations
>>
>> - Remove the Fixes: tag
>>    The involved patch is not yet merged upstream.
>>    Just mention the patch subject inside the commit message.
>> ---
>>   fs/btrfs/extent_io.c    | 19 +------------------
>>   fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
>>   fs/btrfs/ordered-data.h |  2 ++
>>   3 files changed, 36 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 2d32dfc34ae3..2044b889c887 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>>                  cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
>>
>>                  if (cur >= i_size) {
>> -                       struct btrfs_ordered_extent *ordered;
>> -
>> -                       ordered = btrfs_lookup_first_ordered_range(inode, cur,
>> -                                                                  folio_end - cur);
>> -                       /*
>> -                        * We have just run delalloc before getting here, so
>> -                        * there must be an ordered extent.
>> -                        */
>> -                       ASSERT(ordered != NULL);
>> -                       spin_lock(&inode->ordered_tree_lock);
>> -                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>> -                       ordered->truncated_len = min(ordered->truncated_len,
>> -                                                    cur - ordered->file_offset);
>> -                       spin_unlock(&inode->ordered_tree_lock);
>> -                       btrfs_put_ordered_extent(ordered);
>> -
>> -                       btrfs_mark_ordered_io_finished(inode, folio, cur,
>> -                                                      end - cur, true);
>> +                       btrfs_mark_ordered_io_truncated(inode, folio, cur, end - cur);
>>                          /*
>>                           * This range is beyond i_size, thus we don't need to
>>                           * bother writing back.
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index a421f7db9eec..3c0b89164139 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>          spin_unlock(&inode->ordered_tree_lock);
>>   }
>>
>> +/*
>> + * Mark any ordered extents io inside the specified range as truncated.
>> + */
>> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
>> +                                    u64 file_offset, u32 len)
>> +{
>> +       const u64 end = file_offset + len;
>> +       u64 cur = file_offset;
>> +
>> +       ASSERT(file_offset >= folio_pos(folio));
>> +       ASSERT(end <= folio_pos(folio) + folio_size(folio));
>> +
>> +       while (cur < end) {
>> +               u32 cur_len = end - cur;
>> +               struct btrfs_ordered_extent *ordered;
>> +
>> +               ordered = btrfs_lookup_first_ordered_range(inode, cur, cur_len);
>> +
>> +               if (!ordered)
>> +                       break;
>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>> +                       ordered->truncated_len = min(ordered->truncated_len,
>> +                                                    cur - ordered->file_offset);
>> +               }
>> +               cur_len = min(cur_len, ordered->file_offset + ordered->num_bytes - cur);
>> +               btrfs_put_ordered_extent(ordered);
>> +
>> +               cur += cur_len;
>> +       }
>> +       btrfs_mark_ordered_io_finished(inode, folio, file_offset, len, true);
>> +}
>> +
>>   /*
>>    * Finish IO for one ordered extent across a given range.  The range can only
>>    * contain one ordered extent.
>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>> index 1e6b0b182b29..dd4cdc1a8b78 100644
>> --- a/fs/btrfs/ordered-data.h
>> +++ b/fs/btrfs/ordered-data.h
>> @@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
>>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>                                      struct folio *folio, u64 file_offset,
>>                                      u64 num_bytes, bool uptodate);
>> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct folio *folio,
>> +                                    u64 file_offset, u32 len);
>>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>>                                      struct btrfs_ordered_extent **cached,
>>                                      u64 file_offset, u64 io_size);
>> --
>> 2.52.0
>>
>>


