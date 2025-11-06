Return-Path: <linux-btrfs+bounces-18766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F82C39CE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DAE3B6D21
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5830C379;
	Thu,  6 Nov 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SMWWyRzs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56C30BF69
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421095; cv=none; b=hYZ6lq2hd2/KztjFqWURigcdQ51MuX1SGRcF6R5Lt8U3PxzhQhzmUnTPQgOzSr0zDyIxQcrRrgzxq9KAgdaQbEXEzAHgMWYswhuph5MKEpvZYCkBsWWmmpiA6NCTx7GQM9swNOalyEXM0ZtF0q5W1yfHvycvfsAZC0wRs9ry5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421095; c=relaxed/simple;
	bh=BCqYDKh00cXSzJzTCuAstrD+C7rr6UmRVTIiypzC44A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ9ub3Hm5+aG89dkODBloxzM+KmcBdL+kY5aQ26xg8l9AWrxPtzbZg2L+2da1asDUbSTrs9DJxFh2qPI776dHk4Afb5bucW8VVo85QDvGzRNgCS4xWEwcNV9uemn8Fg8HQ1limWXQN6yWaa8ezmsZ94QrwRCtfdmq0Dx/cXhHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SMWWyRzs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so1278086a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 01:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762421091; x=1763025891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fAsTE1ZH42sqCAGnjeBp33hKukKrNpUL4EW/Cn702hc=;
        b=SMWWyRzsUuSOPGBGBwJaTan6sqyHHJM8Y9dUFsKG4FMln12SouEl0bDm/9JMb5pJag
         /+AbAoYo45P7CaTFrI2O9r+UtCTI90/wbMGPzkkDdIxHgE+g7zg2sKdeumQgQIwFzvuL
         vhDZ8gobnqkL8EK06ErUe3DQOq0HRMe88qjwrC+5xlb6sJkUDWvYSEyknmhG/789FYEd
         h/j57mXLhGtpALiyCQ2PZvkrLm/8ELb9/DVH9tXi0WUqbwor5l0fnL6Hb5Z+wPv9tHmJ
         6EwQt6aZY4dFAXkqk8S0FJFthXRdIa2Gm9DkdnbZEEuFfeMbGZf7hDFXVGOvR0LGoKTg
         OPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762421091; x=1763025891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAsTE1ZH42sqCAGnjeBp33hKukKrNpUL4EW/Cn702hc=;
        b=vyvpH2QMoEwjw0axGyTYMZo6Wfnjit3B+sZnckeAGN2h7pL3MFV9EBL+zQZTB42GAU
         fqRgvRkHQfWr2IAup8MizUe5O6WaIQTZNI3q4JNrnlMf5MXsAr6deliRVQbtn9SMsjlX
         R7yN7NSRAHtxJc3ypEI4ho1+HUEXNvWfms1UU4nHrcnr6b6AGdwiuelQxtThqxdw4uwX
         Wu/ppH3ZiPqeK2BqbwyI5kySwQL2CJlO1rZrmtJcUHJt1lnCBYAuX0sYKacRe0gZvTpH
         7lL8gZEeW6tkxbi5M/t+1YscegZ7tAtjRzImwS33+bp7+bCDbr6KqTTlL97vRy42oQfL
         1eXg==
X-Gm-Message-State: AOJu0YxNcQXM4tSDUPEFKDoqFnJfcLgyZjvGTGs4dHtlafvwG7y+WoPJ
	LvwU3E6id/UMVmiNvs2RZWt6nUFvVSVYEQ7WWnvlFNzpnl1Ym7WOFFx8CKJx0D75bVQ=
X-Gm-Gg: ASbGncuIP1qdz+IihRbDZrDu8XVbgfNTzBvehth4RVpzwmp1SaMVcKHRnUxoQ17HRua
	Y92TdrD60E9cFkyaKrhyURoDahI8X1gGUxZK8YTEoyIsee8DHNISBhY/29hH6n0MUudzmMT1tjI
	V+54vhiafeIvJfDe5rq9j6ekbd6pzhEtp79U/P9/KG/1mMr6rt4BJSWpFO5kY9SJw7Nb9cf0cP+
	1Nuv2qX9PGZlL9Yg8uuTx8c8U6w4H9pS9jcyHOiuIA/QXgE+9BSB2+MZnyy0AYUW0oLG0C9hDlb
	MB2U7CBhyxjaThIqHr9r7rYUQSdLlC8qR/LT7nWMUPpeA8s/TD8NYl8Hwh4ztBP1N28IPbeu2rb
	G+DZmBg5FmYErdfNz5HNfM320osQIsTlbEqcrFb1CHPbZVL5adnW4+6Voj4vnnPbxt2iP0/HY49
	OwM6CEALB/Mx2UOYS0KJnZEL9NcD6w
X-Google-Smtp-Source: AGHT+IHc8Bepx9+34yAEAyqVjuro3dw9Q1cCG2nDvl4mmoTxgvDfPTmfSJAh++K2Uq2CaJ3gIfKK8g==
X-Received: by 2002:a17:907:d8d:b0:b71:8448:a8dd with SMTP id a640c23a62f3a-b72654dd80cmr667983366b.31.1762421091418;
        Thu, 06 Nov 2025 01:24:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm21647975ad.22.2025.11.06.01.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:24:50 -0800 (PST)
Message-ID: <d2847d68-dc0b-41cc-b417-f8379b17ab96@suse.com>
Date: Thu, 6 Nov 2025 19:54:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: extract the parity scrub code into a helper
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <2d2cfb7729a65d88ea8b9d6408611d0cc76e1ab7.1762398098.git.wqu@suse.com>
 <20251106090242.GV13846@twin.jikos.cz>
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
In-Reply-To: <20251106090242.GV13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/6 19:32, David Sterba 写道:
> On Thu, Nov 06, 2025 at 01:32:05PM +1030, Qu Wenruo wrote:
>> The function scrub_raid56_parity_stripe() is handling the partity stripe
>> by the following steps:
>>
>> - Scrub each data stripes
>>    And make sure everything is fine in each data stripe
>>
>> - Cache the data stripe into the raid bio
>>
>> - Use the cached raid bio to scrub the target parity stripe
>>
>> Extract the last two steps into a new helper,
>> scrub_radi56_cached_parity(), as a cleanup and make the error handling
>> more straightforward.
>>
>> With the following minor cleanups:
>>
>> - Use on-stack bio structure
>>    The bio is always empty thus we do not need any bio vector nor the
>>    block device. Thus there is no need to allocate a bio, the on-stack
>>    one is more than enough to cut it.
>>
>> - Remove the unnecessary btrfs_put_bioc() call if btrfs_map_block()
>>    failed
>>    If btrfs_map_block() is failed, @bioc_ret will not be touched thus
>>    there is no need to call btrfs_put_bioc() in this case.
>>
>> - Use a proper out: tag to do the cleanup
>>    Now the error cleanup is much shorter and simpler, just
>>    btrfs_bio_counter_dec() and bio_uninit().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 90 ++++++++++++++++++++++++++++--------------------
>>   1 file changed, 52 insertions(+), 38 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index e3612202ba55..8c360d941bd5 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -2113,6 +2113,56 @@ static int should_cancel_scrub(const struct scrub_ctx *sctx)
>>   	return 0;
>>   }
>>   
>> +static int scrub_raid56_cached_parity(struct scrub_ctx *sctx,
>> +				      struct btrfs_device *scrub_dev,
>> +				      struct btrfs_chunk_map *map,
>> +				      u64 full_stripe_start,
>> +				      unsigned long *extent_bitmap)
>> +{
>> +	DECLARE_COMPLETION_ONSTACK(io_done);
>> +	struct btrfs_fs_info *fs_info = sctx->fs_info;
>> +	struct btrfs_io_context *bioc = NULL;
>> +	struct btrfs_raid_bio *rbio;
>> +	struct bio bio;
>> +	const int data_stripes = nr_data_stripes(map);
>> +	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
>> +	int ret;
>> +
>> +	bio_init(&bio, NULL, NULL, 0, REQ_OP_READ);
>> +	bio.bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
>> +	bio.bi_private = &io_done;
>> +	bio.bi_end_io = raid56_scrub_wait_endio;
>> +
>> +	btrfs_bio_counter_inc_blocked(fs_info);
>> +	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
>> +			      &length, &bioc, NULL, NULL);
>> +	if (ret < 0)
>> +		goto out;
>> +	/* For RAID56 write there must be an @bioc allocated. */
>> +	ASSERT(bioc);
>> +	rbio = raid56_parity_alloc_scrub_rbio(&bio, bioc, scrub_dev, extent_bitmap,
>> +				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
>> +	btrfs_put_bioc(bioc);
>> +	if (!rbio) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	/* Use the recovered stripes as cache to avoid read them from disk again. */
>> +	for (int i = 0; i < data_stripes; i++) {
>> +		struct scrub_stripe *stripe = &sctx->raid56_data_stripes[i];
>> +
>> +		raid56_parity_cache_data_folios(rbio, stripe->folios,
>> +				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
>> +	}
>> +	raid56_parity_submit_scrub_rbio(rbio);
>> +	wait_for_completion_io(&io_done);
>> +	ret = blk_status_to_errno(bio.bi_status);
>> +out:
>> +	btrfs_bio_counter_dec(fs_info);
>> +	bio_uninit(&bio);
>> +	return ret;
>> +}
>> +
>>   static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>>   				      struct btrfs_device *scrub_dev,
>>   				      struct btrfs_block_group *bg,
>> @@ -2121,16 +2171,12 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>>   {
>>   	DECLARE_COMPLETION_ONSTACK(io_done);
> 
> This should be deleted as well, as it's in scrub_raid56_cached_parity()

Right, will sent out a v2 just in case.
As I mostly rely on b4 to handle the tags, only updating it locally 
won't make it persistent here.

Thanks,
Qu

> 
> The stack meter says that the new function adds 240 bytes (and has
> dynamic stack size) while scrub_raid56_parity_stripe() shrinks only by
> 24 bytes. So this basically adds 240 - 24 = 216 bytes to the stack.
> 
> With the completion removed is another -32 bytes it's down to 184. The
> on-stack bio is 112 bytes from that, 184 - 112 = 72 for remaining
> variables.


