Return-Path: <linux-btrfs+bounces-12818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD17A7D129
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 01:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AD6188C377
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Apr 2025 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9F21D583;
	Sun,  6 Apr 2025 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y1SN4mee"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAF20DF4
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Apr 2025 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743981554; cv=none; b=HuKNCeeAEa0A7u0HfGHLOw0GSENVZrH/hGmwj/iplkML+YcBfYd2yNY1VEmlOf1NJgq2z11l0ODt0p0GN/KBbWiwm6+YB/+gO94M+lTr8al1L1miQxrrSEv5LnzrcqT+AiyS/Vw8c4gA/Z9+RlzsX4LixmHQ49s2a2UCBbvmaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743981554; c=relaxed/simple;
	bh=zx22VHCYVOLHD9ejcQ8c2fF4xjScGztul8yHrpHyO90=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jZd/y+U7GTkaudShC04dBozcKWxB0gvsKI5/Bbekj/JN2+JU6qNqMxXJwnwOAmu7Ai2VIL/p41ugbQlWxYww4nqNJSzmsP1KvnnM7GfleJm4pTkWGxpH9JdB2IfXeEYi/F+x4yRyNba2/wp0vH/mMWO4ZVw2V77UykzbfqDovM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y1SN4mee; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso41524875e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Apr 2025 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743981550; x=1744586350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rQ7q5lzN6bHrG9FKGN6BvCoAO9aARztBdapx1CCad4=;
        b=Y1SN4meeKCz8ephjMJeTHDWfZYNztgtSdiyCE3zUPAiJHv+BEILF8wfqtGyDw8Cr6E
         sPa8Tq+GBNab5rzKuhk4FKJij2AfnV+OjUqFdPyiaNPVx0eZK9O0HGrKhxEBNGOh/qoM
         26b1wYvowJJ39CatuYS4gDoucSI4mgmuGNVpaYLEOOQPATEA6b+hrYD/gQWOi0H7avSS
         ETJ03V7KYDIESkyql3zMi0c5f+MZ2zvf/hvbwOjjw+yEoZIu4lrx1KKeXpoSwGrOTEdB
         LKW0q5lCbfyOTTA/fQmntf6XhDnXWhnjvaiphC6IkO38V+ENNjeHrgdyKlaEqkrUIxbF
         Ggtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743981550; x=1744586350;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rQ7q5lzN6bHrG9FKGN6BvCoAO9aARztBdapx1CCad4=;
        b=KYzL3pkYvOKEKqiWzDQDmYIa+r8kYJbC8sWoWLUTTJVTlgXNCUerPcNaElnIxc7rFE
         c0MknIR+OTC8zzA9acRAyMbnFJkLOR3GapomBIKuYk82ppceYGrEVTGMIfBlyRxIOx/h
         tGoX5TOPA5apBlPyptnfcIt1VnSagERCvEiddy6zvYDri1MsILOK8OVvC5qBT9ibNgnV
         +NxI1wSdSbpfoHL/VnpaBDEk8N+tQ0mxoMBHx0PnOVhuxtK5+i+Z4a28wUEXwWfvLvG8
         eT0GLExMg0dj6xA2Jg852V4tbGKgsm7wG0htb/7A/4QGaVbh7r2hAeKsG58Jq3c0vlwm
         /Ydw==
X-Gm-Message-State: AOJu0YxuPUPZrTs4PMhTblYf5Vj6ysfrA6qtbtbWhnNYX6p/nE5fjsmC
	84cfdJcaVVmx08RZKO19/rOTr+KkLNeeY5s5c5b7bviAdwZ5Clwy2/tr1KUj4IBV1aOxkW/dprg
	p
X-Gm-Gg: ASbGncsu2EiIPUsMSygVlGTGO8rYuKLJFpGU6TDEHsEknwoUYug4brK522bFHeZR8tf
	kCRkpzEDy7iMwrKkODXuVCgG28YslSVB4zUXN6n/shggEmGTJ/5T082NleCpisGl/83Dg7b/X53
	Zp/Cs/WozDNpMCEfOpSfJPoYhjj2FpKpA3AHOoQ1Cl4spH1bOiMJK/IILvrmilGEGJ5kv8hxgU+
	n14xePSIhrPTc8xrGQ5zJypWjYoQSrt6tn/chC1E8dXvM8fKPMFaoaqbuXkBtf4kuwm/PjbzVR1
	IixE6Yce4/RaX3gbmsFl6mGNJXuDp3uSWeWlcpNgpUsvjVh4vUGNefV/XyIs2cV+f6zvEEc0
X-Google-Smtp-Source: AGHT+IFEhtjPoEpqS0E8MMw/WwNZzJcWhZHzccmcxJR2R0iZ+yKWNRbtqcoi+znQqbY7n3WR7oSgtA==
X-Received: by 2002:a05:6000:2585:b0:390:f9f9:3e9c with SMTP id ffacd0b85a97d-39d0de28876mr8374496f8f.25.1743981549567;
        Sun, 06 Apr 2025 16:19:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a30974sm7417432a91.25.2025.04.06.16.19.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 16:19:09 -0700 (PDT)
Message-ID: <cac7e55d-5e60-4f72-984f-34073f7f2588@suse.com>
Date: Mon, 7 Apr 2025 08:49:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] btrfs: prepare btrfs_end_repair_bio() for larger
 data folios
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1742195085.git.wqu@suse.com>
 <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/17 17:40, Qu Wenruo 写道:
> The function btrfs_end_repair_bio() has an ASSERT() making sure the
> folio is page sized.
> 
> The reason is mostly related to the fact that later we pass a folio and
> its offset into btrfs_repair_io_failure().
> If we have larger folios passed in, later calculation of the folio and
> its offset can go wrong, as we have extra offset to the bv_page.
> 
> Change the behavior by:
> 
> - Doing a proper folio grab
>    Instead of just page_folio(bv_page), we should get the real page (as the
>    bv_offset can be larger than page size), then call page_folio().
> 
> - Do extra folio offset calculation
>    We can have the following cases of a bio_vec (this bv is moved
>    forward by btrfs read verification):
> 
>    bv_page             bv_offset
>    |                   |
>    | | | | | | | | | | | | | | | | |
>    |<-  folio_a  ->|<-  folio_b  ->|
> 
>    | | = a page.
> 
> In above case, the real folio should be folio_b, and offset inside that
> folio should be:
> 
>    bv_offset - ((&folio_b->page - &folio_a->page) << PAGE_SHIFT).

This part is a little confusing and resulted an incorrect calculation 
and ASSERT().

The more accurate (with more corner cases) example to calculate the 
offset would be something like this:

                             real_page
           bv_page           |   bv_offset (10K)
           |                 |   |
           v                 v   v
           |        |        |       |
           |<- F1 ->|<--- Folio 2 -->|
                    | result off |

In that case, we only need to care about one page pointer, the 
@real_page, which is (bv_page + (bv_offset >> PAGE_SHIFT)).

Meanwhile the offset inside the folio 2 is consisted of two part:

- The offset between folio2's head page and real_page
   We have an existing helper, folio_page_idx(), to do the calculation.
   So this part is just (folio_page_idx() << PAGE_SHIFT).

- The offset inside that @real_page
   Since it's now page based, we do not need to bother folio size, just
   offset_in_page() will do the work.

So the resulted value should be:
   (folio_page_idx() << PAGE_SHIFT) + offset_in_page(bv_offset)

Furthermore, the above cases shows that we can not use offset_in_folio() 
either, as the previous folio is no in the same order.
(offset_in_folio() will result 2K, not the correct 6K).

I'll send out an updated series with this fixed, and enable large folios 
for testing.

Thanks,
Qu

> 
> With these changes, now btrfs_end_repair_bio() is able to handle larger
> folios properly.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/bio.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8c2eee1f1878..292c79e0855f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -156,6 +156,25 @@ static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
>   	}
>   }
>   
> +static struct folio *bio_vec_get_folio(const struct bio_vec *bv)
> +{
> +	return page_folio(bv->bv_page + (bv->bv_offset >> PAGE_SHIFT));
> +}
> +
> +static unsigned long bio_vec_get_folio_offset(const struct bio_vec *bv)
> +{
> +	struct folio *folio = bio_vec_get_folio(bv);
> +
> +	/*
> +	 * There can be multiple physically contiguous folios queued
> +	 * into the bio_vec.
> +	 * Thus the first page of our folio should be at or beyond
> +	 * the first page of the bio_vec.
> +	 */
> +	ASSERT(&folio->page >= bv->bv_page);
> +	return bv->bv_offset - ((&folio->page - bv->bv_page) << PAGE_SHIFT);
> +}
> +
>   static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>   				 struct btrfs_device *dev)
>   {
> @@ -165,12 +184,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>   	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
>   	int mirror = repair_bbio->mirror_num;
>   
> -	/*
> -	 * We can only trigger this for data bio, which doesn't support larger
> -	 * folios yet.
> -	 */
> -	ASSERT(folio_order(page_folio(bv->bv_page)) == 0);
> -
>   	if (repair_bbio->bio.bi_status ||
>   	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
>   		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
> @@ -192,7 +205,8 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>   		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
>   				  repair_bbio->file_offset, fs_info->sectorsize,
>   				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
> -				  page_folio(bv->bv_page), bv->bv_offset, mirror);
> +				  bio_vec_get_folio(bv), bio_vec_get_folio_offset(bv),
> +				  mirror);
>   	} while (mirror != fbio->bbio->mirror_num);
>   
>   done:


