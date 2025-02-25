Return-Path: <linux-btrfs+bounces-11815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DDA44EA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 22:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C7E3B4BD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598531624F3;
	Tue, 25 Feb 2025 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XK22uSnj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DE20C476
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518175; cv=none; b=K68l8lP9rHehha4XAvCGzlmLYl7+vOcYSK9uwysrgibo16f5/qAMUmjHtX4wkcieLvM9ImPUqZNfyd/cTwtfq9gYLZP9siEYuzZ9Ko39LyHA/nsTww6voyZ16dwf7pJCVPaY+qQqdJy9hQEpDAmly9EPx7CH40ZxACzWMwVWa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518175; c=relaxed/simple;
	bh=SwT2Q4lCxEQ3sWzymfZga/0Jzut9rOhegv8Oq82h7uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB2H3mba29WUF5uL74rIeKZ9FPjgcLCVFQ+YX0syfRVF5Dwkiy900USaYJwxAMLGV+gFTDAuaB3E6+hFTRUPq6oOwMriuAr9/02kwySsO3SOAKXvMEVqCbNymhmvkk9OvQYs0WZKNilsDLej6MBKS0GOfJDG8NCDDPQk4W+yo7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XK22uSnj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso1196594966b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740518171; x=1741122971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XOlN7tJtwCDPoHB4xhHprnAcN3cujTzm1IYL3wayg68=;
        b=XK22uSnjTAI3AOTEAFKJjHn1LkEV7am+9J/ObzWr+Td2DG9M8lH1bKn96tLp6iiKCC
         kIPQ8amtQKbcflDTOPh2Gl5a2KC2UPqCn8h5XRYOW4U+TGSsCuLNCj9aolhvz08od5yE
         gf7AnvQ5YLIJ+qHUJ6AL5HJq9I9oOiMOdHPVEwHckTWxjrr14faDvKl8dLGV27L9ERP9
         ymoY5tq9Ds6Gc+AJURmu/B8ZNK7wX0M0U8H5tRgE31rqnLLDFeA14/hv1N/pq9GxW7zK
         7OyTdqqwAH91Z9aWvlppJwRWFxUe4WRK5Sp0hkr1edIrAzvnf2RS2i2q/Y6VnKeKNKeZ
         9xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518171; x=1741122971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOlN7tJtwCDPoHB4xhHprnAcN3cujTzm1IYL3wayg68=;
        b=odnHToATXMjDde9yRdns4w2ormy/85GDEZvZ6WzdR3GWpxdw5EHh59LfHakCGOSySz
         nQ85ZYpPXa2ikTrDffftZCr3LILcdfCLcA2Xg29RVA1OdzAnTyMXYMQQgrpkFlLkNL3P
         KbSMUmFWYLPn7aGt4jE8HVxnfmLRpYcPSDbYEVpIo0rHfB0DKRH0kF4lXQ/SSbfGQxG9
         Nmf7dBfIjDZ5w1STVaynkfFcS1fEwXmRLaryMqiM6udaqnr84shKJ8jHfJWVj1IyiVwU
         axYljiVdI0KxJ0NtnxQTJohf/AlZOInvjKURpWAw19yqrtgf6Qlya8UflMOgr899wHKq
         wB9w==
X-Gm-Message-State: AOJu0Yw3D8nrNTIuFqPH4836x8CFWplXJ1kdpvtOStVgIvzUZEWq3h8v
	p+g5R5emIrcbaZDXq3QnNExwc0VyNNkT9KGfV6tYXDdw+y3+vq7PAFe+y5W/KRCjEtLPQuEbhf2
	3
X-Gm-Gg: ASbGnctcE2HMJp6kUWq9M2TZeSVcR7SbZ7BnOkmzynIRC8RTUKKWCNd4c82+gjpDjLp
	9+jrDvL+CdHHxScEm5HW/YgKTD3zJpbZfKbo98GV63v5dJYa+OHWgXxPCeB1bJgsMyfl6BBpUsG
	te8n4cqV/GI7FlmaPJ8sAOV2k0v2C14kCh4TlkYxLH5v6IRem0h8nct3/CJ2eTIBr9BO9YDQSZK
	0oeLK6vdjtF8+B/PDdPiydlbI2LgwoW4TwAEejbyWJGIfalVpbdDfrnhQo83eaNThYks34HqA8a
	GfMHMtFKh/vc3fG5mdHQfQSfu1ZKhxkEXKuXpnV6IAxVRhpbZI8WwA==
X-Google-Smtp-Source: AGHT+IEit9mbajZ7yo3Gv6AtmL+UmJgYgB9X8NUR5yaJR/d1nOAPV7W/a7Miww24z91xnE3JGYf1+w==
X-Received: by 2002:a17:906:3598:b0:abe:e814:ecb4 with SMTP id a640c23a62f3a-abee814f108mr176810366b.4.1740518171285;
        Tue, 25 Feb 2025 13:16:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000a73sm19183645ad.42.2025.02.25.13.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:16:10 -0800 (PST)
Message-ID: <cf967519-c1ee-439e-90fb-6a945296dbba@suse.com>
Date: Wed, 26 Feb 2025 07:46:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] btrfs: allow buffered write to avoid full page read
 if it's block aligned
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740354271.git.wqu@suse.com>
 <c496e3bdc3be2d828684c5536800d6a6554afa5a.1740354271.git.wqu@suse.com>
 <CAL3q7H7dOsKqYAKvZdzOoe4DZNJ28P2neBDopme=dFYT-PNn6g@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7dOsKqYAKvZdzOoe4DZNJ28P2neBDopme=dFYT-PNn6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/26 04:25, Filipe Manana 写道:
> On Sun, Feb 23, 2025 at 11:47 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Since the support of block size (sector size) < page size for btrfs,
>> test case generic/563 fails with 4K block size and 64K page size:
>>
>>      --- tests/generic/563.out   2024-04-25 18:13:45.178550333 +0930
>>      +++ /home/adam/xfstests-dev/results//generic/563.out.bad    2024-09-30 09:09:16.155312379 +0930
>>      @@ -3,7 +3,8 @@
>>       read is in range
>>       write is in range
>>       write -> read/write
>>      -read is in range
>>      +read has value of 8388608
>>      +read is NOT in range -33792 .. 33792
>>       write is in range
>>      ...
>>
>> [CAUSE]
>> The test case creates a 8MiB file, then buffered write into the 8MiB
>> using 4K block size, to overwrite the whole file.
>>
>> On 4K page sized systems, since the write range covers the full block and
>> page, btrfs will no bother reading the page, just like what XFS and EXT4
>> do.
>>
>> But 64K page sized systems, although the 4K sized write is still block
>> aligned, it's not page aligned any more, thus btrfs will read the full
>> page, causing more read than expected and fail the test case.
> 
> This part "causing more read than expected" got me puzzled, but it's explained
> in the "Fix" section below. It's more like "causing previously dirty
> blocks within the page to be zeroed out".

It's not exactly the same.

Before this patch, we will never allow a folio to be dirtied if it's not 
uptodate (unless we're dirtying the full folio).

So there is no "previously dirty blocks to be zeroed out".

I have no better idea to explain the situation here, it's really about 
if we need to read the folio before buffered write.

I'm super happy if you have a better expression here so that no one 
would be confused.

Thanks,
Qu

> 
>>
>> [FIX]
>> To skip the full page read, we need to do the following modification:
>>
>> - Do not trigger full page read as long as the buffered write is block
>>    aligned
>>    This is pretty simple by modifying the check inside
>>    prepare_uptodate_page().
>>
>> - Skip already uptodate blocks during full page read
>>    Or we can lead to the following data corruption:
>>
>>    0       32K        64K
>>    |///////|          |
>>
>>    Where the file range [0, 32K) is dirtied by buffered write, the
>>    remaining range [32K, 64K) is not.
>>
>>    When reading the full page, since [0,32K) is only dirtied but not
>>    written back, there is no data extent map for it, but a hole covering
>>    [0, 64k).
>>
>>    If we continue reading the full page range [0, 64K), the dirtied range
>>    will be filled with 0 (since there is only a hole covering the whole
>>    range).
>>    This causes the dirtied range to get lost.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Looks good, thanks.
> 
>> ---
>>   fs/btrfs/extent_io.c | 4 ++++
>>   fs/btrfs/file.c      | 5 +++--
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index b3a4a94212c9..d7240e295bfc 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -977,6 +977,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>>                          end_folio_read(folio, true, cur, end - cur + 1);
>>                          break;
>>                  }
>> +               if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
>> +                       end_folio_read(folio, true, cur, blocksize);
>> +                       continue;
>> +               }
>>                  em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
>>                  if (IS_ERR(em)) {
>>                          end_folio_read(folio, false, cur, end + 1 - cur);
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 00c68b7b2206..e3d63192281d 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -804,14 +804,15 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
>>   {
>>          u64 clamp_start = max_t(u64, pos, folio_pos(folio));
>>          u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
>> +       const u32 sectorsize = inode_to_fs_info(inode)->sectorsize;
>>          int ret = 0;
>>
>>          if (folio_test_uptodate(folio))
>>                  return 0;
>>
>>          if (!force_uptodate &&
>> -           IS_ALIGNED(clamp_start, PAGE_SIZE) &&
>> -           IS_ALIGNED(clamp_end, PAGE_SIZE))
>> +           IS_ALIGNED(clamp_start, sectorsize) &&
>> +           IS_ALIGNED(clamp_end, sectorsize))
>>                  return 0;
>>
>>          ret = btrfs_read_folio(NULL, folio);
>> --
>> 2.48.1
>>
>>


