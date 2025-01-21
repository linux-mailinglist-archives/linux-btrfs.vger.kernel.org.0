Return-Path: <linux-btrfs+bounces-11024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28180A1788B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 08:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D7162A8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C671ABED7;
	Tue, 21 Jan 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G7COix0Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10931D554
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737444110; cv=none; b=dFEFgPj1vFJw42EYP5p9ASY+2aXsjcSLprEGoVpOKgI+XHlYJqdfZWaq/qRabwjkPKL8/qN3o9h7V54LlEqVWA+72uKcMw+uzFqqdlgvtI2aqCzQeJ+oiZ0VJzd2LXEM2drreE8G+Razhq2QtwLH+1yriYMeE2lNEUmtEoZm9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737444110; c=relaxed/simple;
	bh=Ym3r3yuaUCnzSnhZYqJ7bkfP5yh+qIe5Q6iCXVpbltw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfU8D+qBPLwEnqQVkdBUMQ37weTusbrZzByl5edrTEyH/ftvqtt9EJpZ4XH0J8Kgor9ZGVhbFRPLtoVFv81lwWll/QRqYGmznOAYmodRPRQGCST76mPdE6BYyUrbve9/aVsllPCjZTvw6q4OTGeW4pRRzyFeXW9UoPjGygzW0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G7COix0Q; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab633d9582aso180217966b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 23:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737444106; x=1738048906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5hGOtoVXxda+b7n8MDjERF4yNiChXWj+HcztCfeXCb8=;
        b=G7COix0Q6F8rfLehEGIkUZ3wKr22ooSPe9khOJbRH62nx38WXtq9G6LMNcuwTeoU4R
         RrGYs31mAJhbJolf87ad6SgtQ3yiAe1VBBaBDCAE2Tyu3pTkvs2pFgNGJSVlp6E1iz9v
         5NZpdsftFvaYoFU9ExLhiJQTQZr5hQI4S2NI10HgMvUk6sMD0AbLet3FN9x8cUwWVgRK
         r2jxcN8iVCDfxn4Skooe6gAT5Kcy+mezZcNwKK5SVO2d6iBUmVnDEHa5VxREZnEGzguP
         JFcseRCENkhDYHye4itWZYxVD4WX7PS71wbgsV+pcXgTt65W4EA20X8o32iGmKkC/hyI
         mv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737444106; x=1738048906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hGOtoVXxda+b7n8MDjERF4yNiChXWj+HcztCfeXCb8=;
        b=qzs64gt2jhSBjtgOFFucNCOZNhWvUUEsC+e1o491Dsl2wBYMT2B0b9ozMd1oAd9G2b
         z/zqdjWwjdpp65ifHuoWdhFgbnKeEclH3wpQqxKT4YeR6FxBR0qdbIqspi61c600DeXO
         tvrVKtpNmXK4s135ViAwMs41MD4bs1FxHSN4c8CHGJCUf1R59jKk6gryBfHP8OO00NxU
         LQOL6aV7Q9Iy+f0NDnIeJhjmVgC85R2/xjbpZNvMdS+kGaV5eIdckPKH9YDCLiJcxmBD
         xCU798+aMRCQ/CWiNoOBFz+eGGtRaAVfoL6r9u7wAURR97XMHud8JYIfdj69hKXSgD71
         glUw==
X-Gm-Message-State: AOJu0Yz0Rqtg5OvPS/0fnj3nPCo38u77LnkL958cMytPYRX2yIoXzvAu
	8X0aSvixiH9Gj64mNLitYRpX6TCVw88XOxd0/h9YmXnOwQKTf3/7/itAeSXHZJE=
X-Gm-Gg: ASbGncv9TUEATRfcrvW69qdIvNJ7thuBXP3Bot7iehGgyHhg1+3eGUr8/zJQWIG0moW
	/WYow6ns4EV7jeI/mbf1xSdAU0/sU1ELe9zSpArX4XO8vjTXrN4gMaSlc/HnvNQgp9tlR7JaQ+Y
	Ji+0KAtCXFvKZwh0213ibShReJrB556YGTrFHLltQbUJe5r0vj2gGiTXDltMl8lR5Veuge/czbI
	rF20gZVR8HWe63aCEsCHUz3YwWg30upc2ofJQfPD3tZvRuIW47PZ98z6VovRobi8bZz3bTqOjDK
	pGErUQf4h0VuWkz2wilRFw==
X-Google-Smtp-Source: AGHT+IEal+dwSfjfeduItJPCq8gTahgyQMxovLMkpf2yZb5R4XtwXxFk9exSoRd7o0+p5uk0Z8ujBg==
X-Received: by 2002:a17:906:d555:b0:aa6:aa8e:c89c with SMTP id a640c23a62f3a-ab38b44d49emr1644312866b.39.1737444105679;
        Mon, 20 Jan 2025 23:21:45 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba56asm71110865ad.98.2025.01.20.23.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 23:21:45 -0800 (PST)
Message-ID: <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
Date: Tue, 21 Jan 2025 17:51:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-2-willy@infradead.org>
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
In-Reply-To: <20250121054054.4008049-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/21 16:10, Matthew Wilcox (Oracle) 写道:
> It is meaningless to shift a byte count by folio_shift().  The folio index
> is in units of PAGE_SIZE, not folio_size().  We can use folio_contains()
> to make this work for arbitrary-order folios, so remove the assertion
> that the folios are of order 0.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/btrfs/extent_io.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 289ecb8ce217..c9b0ee841501 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -523,8 +523,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>   		u64 end;
>   		u32 len;
>   
> -		/* For now only order 0 folios are supported for data. */
> -		ASSERT(folio_order(folio) == 0);

I'd prefer to keep this ASSERT(), as all the btrfs_folio_*() helpers can 
only handle page sized folio for now.

>   		btrfs_debug(fs_info,
>   			"%s: bi_sector=%llu, err=%d, mirror=%u",
>   			__func__, bio->bi_iter.bi_sector, bio->bi_status,
> @@ -552,7 +550,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>   
>   		if (likely(uptodate)) {
>   			loff_t i_size = i_size_read(inode);
> -			pgoff_t end_index = i_size >> folio_shift(folio);
>   
>   			/*
>   			 * Zero out the remaining part if this range straddles
> @@ -563,7 +560,8 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>   			 *
>   			 * NOTE: i_size is exclusive while end is inclusive.
>   			 */
> -			if (folio_index(folio) == end_index && i_size <= end) {
> +			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&

Although folio_contains() is already a pretty good improvement, can we 
have a bytenr/i_sized based solution for fs usages?

Thanks,
Qu

> +			    i_size <= end) {
>   				u32 zero_start = max(offset_in_folio(folio, i_size),
>   						     offset_in_folio(folio, start));
>   				u32 zero_len = offset_in_folio(folio, end) + 1 -
> @@ -956,7 +954,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>   		return ret;
>   	}
>   
> -	if (folio->index == last_byte >> folio_shift(folio)) {
> +	if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
>   		size_t zero_offset = offset_in_folio(folio, last_byte);
>   
>   		if (zero_offset) {


