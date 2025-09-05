Return-Path: <linux-btrfs+bounces-16684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076CB4666C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Sep 2025 00:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985EE7C3F33
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 22:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3E2ECE89;
	Fri,  5 Sep 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TNbIY5Zj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A527FB2E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110116; cv=none; b=Ptbuq/I3TbnoQ1Bn9KWZQ2v/LoHA+ljEZsERPuyqpfHVOMJ/ePRblirlLFQwXiVZ/7WhHfFpX1M6VsSvrjDtJ7tcZMp9oHqjX7UARud70fupLEjoWx5gssnuBf5/oj59CXQBR/J2kWKwBUGfHxA/svDhfch1SWhPpQe6pEyNYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110116; c=relaxed/simple;
	bh=IUQMz7vvNgFlYbND3Su2fcikT2h09bxV0/LJXbhGHpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWdYelwqtIXh+/0stDNrwLQygXs5AYQt6UI7Io+XL+hEh+yo+6rGfszpYB8ADhETGRjkqrpj1SSL3/crQLMkYYtP2W5lpxD9Cz6T/SHHZqeGnVAyuh7NannGvSZZRptHypCwqa0ryH9ZVFbxsxnuOMOZy3EKZ05fHtZgkmNXqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TNbIY5Zj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1217592f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Sep 2025 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757110112; x=1757714912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1MLCuxV81j0qc3qKPKwp2C5eg4OKYqume7T0o9yBcog=;
        b=TNbIY5Zjj/38G8xw1Lg6/dFSZTpT6v7NqXCr1o1kmRKURFKZYU8RxVvkHH4Eh/mt93
         BPLMgUOcb2iyDcD65w51BodAluWFn6fuTO7Yye26g5NMav0JGLtmHq2/xwR3YwFJ8tW/
         voLT8OTfXRn1Ur1ljmDrigolkKcPb8oBdELsMgSJCl3C9VsRXBaOMjpfrCKIDbO40luF
         jTmvOnQD+RuenUUYpehZADZZ1CpdRuC6cFlfafu10FALnQJYuIeVwWbbb0XfsTHd5kRH
         dBdDtkAMRrJaEFxO/CbbcUZlV/OYl96kONAzVOxt+tsmvIad1eVtJy8xVkRl64l7aUKv
         LfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110112; x=1757714912;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MLCuxV81j0qc3qKPKwp2C5eg4OKYqume7T0o9yBcog=;
        b=n/C0vZtzc3/AbHwLzu7FX/dvxaZLdPC93fqbJ2Hh13c+h7bHklWFO5KAWDB7C17fvB
         /bWUbZTHUHDt6DmmcTI0Urn9SGaTUP8kqOgqilUHntGTEWCHoNyIi3kqdPS5tMcwhSc1
         CRoh+7CHA1gNfPTKoeXKfVWvtu+Ld/YR4Z1XLCGqCFcEhXNLO/yZRQCUv0aXS2ewdnUG
         3evjYX5rsr00cWpJ2SEsycyFMcSbCQQUiiL8R+nyi1iSCLR6uGxI44AX3cV8bzbnrV5d
         p+eiX6GvV2VjgFFIsgtnV9kfAWzaKWTJFecgOKgMCVSkiU5C4U+jcIUkujBbC+j8bmUi
         B7nA==
X-Gm-Message-State: AOJu0YwAyfRZpoRxzKy2ZIIrwZG6NO1EKE7zNwUHZI6eSTuVQ1LgYzhp
	FR+ZqLCB1cy2a7Ab2SplSeN6CRmHdAqrZ6uPnuMURpa5yPfzyUi1bmSbVXInIAbH09s=
X-Gm-Gg: ASbGncuO3acDSfM1oSl3ehslWuVGX2O18+BpT7Ns5PJTVhkI91dDTQTf3JtZ9macw8m
	hRoawhvO3+KWl2hDSGjhCv4OqHzowQ2H4YSoIunp0SrEslIP84iszrLOTd4gSJTirtJtkDpEI3E
	1gZOuVxCO40+n2/p7hRDmvvU4TwxjkTxeSr6V9D3TkRBFNaZppOD3MWSRr6pJg0Lw7c3HNN4fUJ
	7mqSNcnxuyacZW6HCmbXNmIJhP5mfmEhaxxFYMKxIePdkY1Fc7fBaTiFAsloP89Ow+f2RlL2XB4
	Bgm0P+chGoYOJ+WS4BnUAXCNq/QuJH3LzHP3XrgC3QgeKZI0da4IHCkwWT+3VRxysXY9H/rvmLn
	0kMakmSWLCXb1rX7YqcwxUc/LbSyO4cOFX2Lc2+5hSoyx64kahuDx/Vavqg/71Q==
X-Google-Smtp-Source: AGHT+IE02AninmbMFUvF6urz4iBDnU8Sr08GxA3ArwUwwgtbf0Vzv39fnD1NYyCnC4M+g3LFy8D6qw==
X-Received: by 2002:a05:6000:2f87:b0:3e5:3d08:3a69 with SMTP id ffacd0b85a97d-3e6374655ccmr110009f8f.2.1757110112204;
        Fri, 05 Sep 2025 15:08:32 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fa1f21415sm8008689a12.18.2025.09.05.15.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 15:08:31 -0700 (PDT)
Message-ID: <87f75733-f6a6-46cb-b5af-f574314342bd@suse.com>
Date: Sat, 6 Sep 2025 07:38:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] btrfs: introduce btrfs_bio_for_each_block_all()
 helper
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1756803640.git.wqu@suse.com>
 <85543e15b7440b4d7b8f88d1e5384a0b2dafa693.1756803640.git.wqu@suse.com>
 <20250905173319.GP5333@twin.jikos.cz>
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
In-Reply-To: <20250905173319.GP5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/6 03:03, David Sterba 写道:
> On Tue, Sep 02, 2025 at 06:32:15PM +0930, Qu Wenruo wrote:
>> Currently if we want to iterate all blocks inside a bio, we do something
>> like this:
>>
>> 	bio_for_each_segment_all(bvec, bio, iter_all) {
>> 		for (off = 0; off < bvec->bv_len; off += sectorsize) {
>> 			/* Iterate blocks using bv + off */
>> 		}
>> 	}
>>
>> That's fine for now, but it will not handle future bs > ps, as
>> bio_for_each_segment_all() is a single-page iterator, it will always
>> return a bvec that's no larger than a page.
>>
>> But for bs > ps cases, we need a full folio (which covers at least one
>> block) so that we can work on the block.
>>
>> To address this problem and handle future bs > ps cases better:
>>
>> - Introduce a helper btrfs_bio_for_each_block_all()
>>    This helper will create a local bvec_iter, which has the size of the
>>    target bio. Then grab the current physical address of the current
>>    location, then advance the iterator by block size.
>>
>> - Use btrfs_bio_for_each_block_all() to replace existing call sites
>>    Including:
>>
>>    * set_bio_pages_uptodate() in raid56
>>    * verify_bio_data_sectors() in raid56
>>
>>    Both will result much easier to read code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/misc.h   | 24 +++++++++++++++++++++++
>>   fs/btrfs/raid56.c | 49 +++++++++++++++++++----------------------------
>>   2 files changed, 44 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
>> index f210f808311f..2352ab56dbb3 100644
>> --- a/fs/btrfs/misc.h
>> +++ b/fs/btrfs/misc.h
>> @@ -45,6 +45,30 @@ static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
>>   	     (paddr = bio_iter_phys((bio), (iter)), 1);			\
>>   	     bio_advance_iter_single((bio), (iter), (blocksize)))
>>   
>> +/* Helper to initialize a bvec_iter to the size of the specified bio. */
> 
> Please drop 'Helper to ...'
> 
>> +static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
>> +{
>> +	struct bio_vec *bvec;
>> +	u32 bio_size = 0;
>> +	int i;
>> +
>> +	bio_for_each_bvec_all(bvec, bio, i)
>> +		bio_size += bvec->bv_len;
>> +
>> +	return (struct bvec_iter) {
>> +		.bi_sector = 0,
>> +		.bi_size = bio_size,
>> +		.bi_idx = 0,
>> +		.bi_bvec_done = 0,
>> +	};
> 
> We don't use this kind of initializers, usually the structure is passed
> as parameter, but I can see how it makes it convenient in the for()
> initialization. The parameter way would work but would also look strange
> so I think it's acceptable.

I'd say this really makes a lot of things easier, and avoid pointer 
usage (in this particular case it allows us to use local @iter without 
the need of a caller provided pointer), it should get more usage.

I was also very surprised to see such usage when looking into the 
bcachefs code, I believe we can use this to improve our code.

Thanks,
Qu

> 
>> +}
>> +
>> +#define btrfs_bio_for_each_block_all(paddr, bio, blocksize)		\
>> +	for (struct bvec_iter iter = init_bvec_iter_for_bio(bio);	\
>> +	     (iter).bi_size &&						\
>> +	     (paddr = bio_iter_phys((bio), &(iter)), 1);		\
>> +	     bio_advance_iter_single((bio), &(iter), (blocksize)))
>> +
>>   static inline void cond_wake_up(struct wait_queue_head *wq)
>>   {
>>   	/*


