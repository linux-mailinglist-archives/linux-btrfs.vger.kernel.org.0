Return-Path: <linux-btrfs+bounces-13013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27921A88FDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 00:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE921895531
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC971F3BBB;
	Mon, 14 Apr 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mwwsp0vM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E31BC07B
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671519; cv=none; b=XLy23icq/ys/m1QDtSBVQEfR1QMrbUz2TaE2QjaL3O2rAHEcolZ9ARtg9NofJFKg/nLeo2YDro+1M/haQlaNvI9AH4rz5sD6YlrlRT1Z1VUzbxjYFSQ1kX33h7DSIjooOPRJ55P8P5aZej/QkIzxw3xNz1sFgLOVYtxmd8ZSVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671519; c=relaxed/simple;
	bh=x7qc/eea8+0f4XIGqceOFTZsLgwDisQVjSHfVPuCC+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKYwwjRU/NrhpsojMWH4rD5o7j8i7fd/mSZ4YTLZbN5doWJVbEYLXmD9FCqzzxTYm567WoAalodEXqH95bnDc3gUjKQxND0v95BgLFCU6Yw0mTTB5GAtn8QrxqPz9XtvCq2zc3ZvDv5XvDvmOde6CiiBmtRewo9em8+9G5ZMPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mwwsp0vM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so39561905e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 15:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744671513; x=1745276313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=piyvJ4PCWe/bUdBotnMVnqLsKc9VV98h66ZmWh/+rlQ=;
        b=Mwwsp0vM7ehSdk4BLx9PaXunEZLRFg6BLx4kMz4UwhdxxRwrfrTDuHd87Fwds0zsMu
         JDy63z1UlxWeNf31ZDAMUCN3Uf0yj8JO1x5bmcsT2VUCeJk+jhAwMBq8IEXMSwkcizag
         uF75sLyWRPB2mixvbwgiZfNGthL6CqFqJI+11BJvsrgluOd8R1sCYaxqEGl8emqIGXo7
         O5PgwLlA3v7/Dpc5aAkGCeFl7RdpJ3cPrdKD5+R5xqb7PEL+6khDg9m9InXrKm71TFs2
         Gn/ddLIcQoEEEvej2RKI77Ik+K3am8+cp8AAL/JxzoROFFJX/tkbXwWRgQ04v+lL5wbT
         mS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744671513; x=1745276313;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piyvJ4PCWe/bUdBotnMVnqLsKc9VV98h66ZmWh/+rlQ=;
        b=RbIQbrW8TUXMp6fEg3DC21FAgLJn9dDWuBOcJFBHYwmJ3Q5bx/F7FOYHPgTnHyzX1+
         7nnte5qzW/xT9+0ZZlr+6F54jpi49668N4OtNdZagIiN14hdWtF1n3xvmISNx++86hA3
         Cjar1Clw88JXzlT9oEXzB+8BeXA5jOtxJFioEC9Z5ZNWYi17a16SOLDOmcRy1Wude6r6
         2S/B2kszm04W0pnKk+JzNADk1AQFAUtwJBxyaiXuxDM/3t7eIJjUA5YuUwJ0PpVdjd/B
         gUXWeIVAvUOtzQXkHgx7TabjypdqQGUOMrDeUpmGYtaErQajEKovVJFT/QoiJXqVjiUl
         tKXw==
X-Gm-Message-State: AOJu0Yy1GtvmTv7lGm09KT3ES+kNsueiHsIRbKaJrEKrpJ59IGTcHTcC
	p144GnCdx9RYdcDaosWg/y1apHvpPmV6g/Ka+e0VimzXG5KGePH4dKkN79DtUcw=
X-Gm-Gg: ASbGncvP9cjG5GDUr2fYBqTXBUmCvMSU+MpCIyic0m4aEcdvnORcEXqiBd9XE2GiiUj
	mO5+10ltLyHQcN5sTUglMc4CPZMdD1rFcdblJtj2W9UleDgIEtDqaB3QGByr+gfc9gccZMUppOV
	N1img8YYjTlG8GvUIJo6Qy/rWn395VWCCCNmOeA2M3Mzu2ySZ48D9P/zst0daoAGDrazM98vOkj
	t63WFtR3w+4LtoHW+GBjDloWC4Mus45lrtesP9KO0oB2oXssU0gxpkZKNeckPSjJ48NNeey4PIY
	6Z51VWLCpJ+6qjSF4SLxE8ykknEV3tnLKYAecHhcZCDAvlSNki7WrA2N/Wjh2rT1xD0c
X-Google-Smtp-Source: AGHT+IFNojUUlDXqi7y8FEmhZ//AFSsMIsqjkvOEMAIYPe0st48iH1G9tePiCWjQaQiPjx8dRH90Xw==
X-Received: by 2002:a05:6000:2283:b0:399:7f2b:8531 with SMTP id ffacd0b85a97d-39eaaebc752mr9998775f8f.38.1744671513344;
        Mon, 14 Apr 2025 15:58:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2198a7esm7201538b3a.31.2025.04.14.15.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:58:32 -0700 (PDT)
Message-ID: <d5826f39-da49-44be-ac3d-9e697ce54793@suse.com>
Date: Tue, 15 Apr 2025 08:28:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: prepare btrfs_end_repair_bio() for larger data
 folios
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1744005845.git.wqu@suse.com>
 <f679cbeedbb0132cc657b4db7a1d3d70ff2261f0.1744005845.git.wqu@suse.com>
 <CAL3q7H7x+cH6gAjuyO2pW=An6NkJwm_TCbGzVVygLHvvwzfz+g@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7x+cH6gAjuyO2pW=An6NkJwm_TCbGzVVygLHvvwzfz+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 23:55, Filipe Manana 写道:
> On Mon, Apr 7, 2025 at 7:09 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The function btrfs_end_repair_bio() has an ASSERT() making sure the
>> folio is page sized.
>>
>> The reason is mostly related to the fact that later we pass a folio and
>> its offset into btrfs_repair_io_failure().
>> If we have larger folios passed in, later calculation of the folio and
>> its offset can go wrong, as we have extra offset to the bv_page.
>>
>> Change the behavior by:
>>
>> - Doing a proper folio grab
>>    Instead of just page_folio(bv_page), we should get the real page (as the
>>    bv_offset can be larger than page size), then call page_folio().
>>
>> - Do extra folio offset calculation
>>
>>                       real_page
>>     bv_page           |   bv_offset (10K)
>>     |                 |   |
>>     v                 v   v
>>     |        |        |       |
>>     |<- F1 ->|<--- Folio 2 -->|
>>              | result off |
>>
>>     '|' is page boundary.
>>
>>     The folio is the one containing that real_page.
>>     We want the real offset inside that folio.
>>
>>     The result offset we want is of two parts:
>>     - the offset of the real page to the folio page
> 
> "to the folio page", this is confusing for me. Isn't it the offset of
> the page inside the folio?
> I.e. "the offset of the real page inside the folio"

That's correct.

> 
> Also, this terminology "real page", does it come from somewhere?
> Aren't all pages "real"?

The "real" part is compared to bv_page, which is not really the page 
we're working on if the bvec is a multi-page one.

> 
>>     - the offset inside that real page
>>
>>     We can not use offset_in_folio() which will give an incorrect result.
>>     (2K instead of 6K, as folio 1 has a different order)
> 
> I don't think anyone can understand where that 2K and 6K come from.
> The diagram doesn't mention how many pages per folio (folio order),
> page sizes, and file offset of each folio.
> So mentioning that 2K and 6K without all the relevant information,
> make it useless and confusing IMO.
> 
>>
>> With these changes, now btrfs_end_repair_bio() is able to handle not
>> only large folios, but also multi-page bio vectors.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c | 61 ++++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 54 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 8c2eee1f1878..3140aa19aadc 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -156,6 +156,58 @@ static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
>>          }
>>   }
>>
>> +/*
>> + * Since a single bio_vec can merge multiple physically contiguous pages
>> + * into one bio_vec entry, we can have the following case:
>> + *
>> + * bv_page             bv_offset
>> + * v                   v
>> + * |    |    |   |   |   |   |
>> + *
>> + * In that case we need to grab the real page where bv_offset is at.
>> + */
>> +static struct page *bio_vec_get_real_page(const struct bio_vec *bv)
>> +{
>> +       return bv->bv_page + (bv->bv_offset >> PAGE_SHIFT);
>> +}
>> +static struct folio *bio_vec_get_folio(const struct bio_vec *bv)
> 
> Please add a blank line between function delcarations.
> 
>> +{
>> +       return page_folio(bio_vec_get_real_page(bv));
>> +}
>> +
>> +static unsigned long bio_vec_get_folio_offset(const struct bio_vec *bv)
>> +{
>> +       const struct page *real_page = bio_vec_get_real_page(bv);
>> +       const struct folio *folio = page_folio(real_page);
>> +
>> +       /*
>> +        * The following ASCII chart is to show how the calculation is done.
>> +        *
>> +        *                   real_page
>> +        * bv_page           |   bv_offset (10K)
>> +        * |                 |   |
>> +        * v                 v   v
>> +        * |        |        |       |
>> +        * |<- F1 ->|<--- Folio 2 -->|
>> +        *          | result off |
>> +        *
>> +        * '|' is page boundary.
>> +        *
>> +        * The folio is the one containing that real_page.
>> +        * We want the real offset inside that folio.
>> +        *
>> +        * The result offset we want is of two parts:
>> +        * - the offset of the real page to the folio page
>> +        * - the offset inside that real page
>> +        *
>> +        * We can not use offset_in_folio() which will give an incorrect result.
>> +        * (2K instead of 6K, as folio 1 has a different order)
> 
> Same comment here, as this is copied from the change log.
> 
> Codewise this looks good to me, but those comments and terminology
> ("real page") make it confusing IMO.

Although this patch will be dropped, as Christoph's physical address 
solution is simpler overall, and he is not happy with us poking with the 
bvec internals.

Thanks,
Qu

> 
> Thanks.
> 
>> +        */
>> +       ASSERT(&folio->page <= real_page);
>> +       return (folio_page_idx(folio, real_page) << PAGE_SHIFT) +
>> +               offset_in_page(bv->bv_offset);
>> +}
>> +
>>   static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>>                                   struct btrfs_device *dev)
>>   {
>> @@ -165,12 +217,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>>          struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
>>          int mirror = repair_bbio->mirror_num;
>>
>> -       /*
>> -        * We can only trigger this for data bio, which doesn't support larger
>> -        * folios yet.
>> -        */
>> -       ASSERT(folio_order(page_folio(bv->bv_page)) == 0);
>> -
>>          if (repair_bbio->bio.bi_status ||
>>              !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
>>                  bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
>> @@ -192,7 +238,8 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>>                  btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
>>                                    repair_bbio->file_offset, fs_info->sectorsize,
>>                                    repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
>> -                                 page_folio(bv->bv_page), bv->bv_offset, mirror);
>> +                                 bio_vec_get_folio(bv), bio_vec_get_folio_offset(bv),
>> +                                 mirror);
>>          } while (mirror != fbio->bbio->mirror_num);
>>
>>   done:
>> --
>> 2.49.0
>>
>>


