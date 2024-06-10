Return-Path: <linux-btrfs+bounces-5621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A2902A8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A561F233F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2909558B6;
	Mon, 10 Jun 2024 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gKSWfAwv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35C339A8
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054690; cv=none; b=JboueBdh1vy6rERmCeNsfMKvLvt6nz8ehfkieeBUqN3Lfl9k/si+vCuCQv6qIdiVU3oAXljPgnbB95LlwckKMwK+d8y02rJmWkadux2kEZccmKm+e5yRTxL0+/rltehhlekzFEK1DSUGRWhg/KWqBWUEG+v6hbZkKE4e81s9Qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054690; c=relaxed/simple;
	bh=YIg3/vlscbAseb1+TGklES9EWI/l/cEgFyNArgNhjKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVe/kBtYJAEZGVx/+CiDXJPL0reoQ6YfdBrMf5MNK6gZBr2+FOub6WlyAZaGvH87755FeIdVS8T0KQBCjhEfRrj5jff0melEDjVze0HQJ552wxE6BAGCuLNUv1o0lOjL8UKYt0CauAp0VqZXoyKFHQn6UK8ZUfZMOrL6TtyGyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gKSWfAwv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe785b234so13361281fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718054686; x=1718659486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PtEoaEF9V+nuwOy12ocJDnJO46YJCRYL+kZzd4wvTW0=;
        b=gKSWfAwvDp7FQttlQGfNge3LfhVchVAoz+wu5uHIoAtCI1QNEFI1ji6yfgffaH4VfI
         QN5G3T657XfbMnhE3vTsD4vgD3RRh3QZVkRUo39TyxW/ddblgWAgc9bznTx7jScxiKp0
         fry4arlfJARq5f0168z1S1GTosv4zApfjvK9SCp9KFmAL/unoWR82TfNi40O5Ndb9xu6
         q9/sd+kSBkt5E2dBR3N/MKUMwu5sUUKWpVE9dJecXhqiBxeKuOs18G2jcUG4kZJDFNAY
         4yFcOcBQtfOwnM9FB5l32hcXln7S/4fLb0sJUheLvlhgUnnmPVa1nMH4RWsY2+EzJh94
         LZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718054686; x=1718659486;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtEoaEF9V+nuwOy12ocJDnJO46YJCRYL+kZzd4wvTW0=;
        b=td8wWkJ9bdlnlgC63R2COBAVBSMWn2Vrd8YY147ktD5I8BMKKELf0O+AZNhKwxa7i7
         oJkfY/cfdKGYiBVclib1uDnH5AeKpxDhGZCuxXAfqmRxVHX4UO7+pbzSvoCTkKyi53yN
         JvUkTp0vQZ9L0/X72SLHOyjKoxFJHBB5DA/BH30PKtIQa+a7X5x8NroNaU0y49iWEeaj
         370rDo8q+hDFF9WNaaoCC8mVKjKqaklTMtleiJ4X6UZc2htoqKfaTNLabZCQpQnms+FD
         zwSZynfj1SHYT+7usqQhKShTAR6V64noJY+eVL/awxqUxOTfmayoLUaB9QqsbqVNdVI7
         dErg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6yx/CdSk7roXPrKzdmp+N6THnziU3oihYbpx5FKTCYIPfrJbMp6zh4UUDwXEENwmL+Oci6maoEHF0tu+RuRfX9Q6ls04wI4JByE=
X-Gm-Message-State: AOJu0Yyx/GwcithOYSwkFMlkcdl65CTnPxjTM7RxtFw+Ozpqs7iFqLSo
	/McaRiaX3H7yfobDTVW2YT5Tps4W5xh1uUpgrQ22e36an4n8WwV/Pfwe886h7XEIVZAZhR/NA7x
	E
X-Google-Smtp-Source: AGHT+IH9ZraaGGqB/q/dfH5nwV8ZAno3tQ0suVvDOL3bhykhMz+EMC6PIRlZzcSmN16hRwuthN+V0g==
X-Received: by 2002:a2e:3519:0:b0:2eb:e1fa:4f55 with SMTP id 38308e7fff4ca-2ebe1fa4fb3mr27228071fa.12.1718054686170;
        Mon, 10 Jun 2024 14:24:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70426cc74f3sm4280479b3a.35.2024.06.10.14.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 14:24:45 -0700 (PDT)
Message-ID: <16516c00-845c-4cb8-9bb5-6e5e38bc71c3@suse.com>
Date: Tue, 11 Jun 2024 06:54:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on failed
 bios
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240610144229.26373-1-jth@kernel.org>
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
In-Reply-To: <20240610144229.26373-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/11 00:12, Johannes Thumshirn 写道:
> When running fstests' test-case btrfs/060 with MKFS_OPTIONS="-O rst"
> to force the creation of a RAID stripe tree even on regular devices I
> hit the follwoing ASSERT() in calc_sector_number():
> 
>      ASSERT(i < stripe->nr_sectors);
> 
> This ASSERT() is triggered, because we cannot find the page in the
> passed in bio_vec in the scrub_stripe's pages[] array.
> 
> When having a closer look at the stripe using drgn on the vmcore dump
> and comparing the stripe's pages to the bio_vec's pages it is evident
> that we cannot find it as first_bvec's bv_page is NULL:
> 
>      >>> stripe = t.stack_trace()[13]['stripe']
>      >>> print(stripe.pages)
>      (struct page *[16]){ 0xffffea000418b280, 0xffffea00043051c0,
>      0xffffea000430ed00, 0xffffea00040fcc00, 0xffffea000441fc80,
>      0xffffea00040fc980, 0xffffea00040fc9c0, 0xffffea00040fc940,
>      0xffffea0004223040, 0xffffea00043a1940, 0xffffea00040fea80,
>      0xffffea00040a5740, 0xffffea0004490f40, 0xffffea00040f7dc0,
>      0xffffea00044985c0, 0xffffea00040f7d80 }
>      >>> bio = t.stack_trace()[12]['bbio'].bio
>      >>> print(bio.bi_io_vec)
>      *(struct bio_vec *)0xffff88810632bc00 = {
>              .bv_page = (struct page *)0x0,
>              .bv_len = (unsigned int)0,
>              .bv_offset = (unsigned int)0,
>      }

I'm more interested in why we got a bi_vec with all zeros.

Especially if the bv_len is 0, we won't update the error bitmap at all.

So it's not simply ignore it if the IO failed.

To me it looks more like at some stage (RST layer?) the bio is 
reseted/modified unexpected?

Thanks,
Qu
> 
> Upon closer inspection of the bio itself we see that bio->bi_status is
> 10, which corresponds to BLK_STS_IOERR:
> 
>      >>> print(bio)
>      (struct bio){
>              .bi_next = (struct bio *)0x0,
>              .bi_bdev = (struct block_device *)0x0,
>              .bi_opf = (blk_opf_t)0,
>              .bi_flags = (unsigned short)0,
>              .bi_ioprio = (unsigned short)0,
>              .bi_write_hint = (enum rw_hint)WRITE_LIFE_NOT_SET,
>              .bi_status = (blk_status_t)10,
>              .__bi_remaining = (atomic_t){
>                      .counter = (int)1,
>              },
>              .bi_iter = (struct bvec_iter){
>              	 .bi_sector = (sector_t)2173056,
>                      .bi_size = (unsigned int)0,
>                      .bi_idx = (unsigned int)0,
>                      .bi_bvec_done = (unsigned int)0,
>              },
>              .bi_cookie = (blk_qc_t)4294967295,
>              .__bi_nr_segments = (unsigned int)4294967295,
>              .bi_end_io = (bio_end_io_t *)0x0,
>              .bi_private = (void *)0x0,
>              .bi_integrity = (struct bio_integrity_payload *)0x0,
>              .bi_vcnt = (unsigned short)0,
>              .bi_max_vecs = (unsigned short)16,
>              .__bi_cnt = (atomic_t){
>                      .counter = (int)1,
>              },
>              .bi_io_vec = (struct bio_vec *)0xffff88810632bc00,
>              .bi_pool = (struct bio_set *)btrfs_bioset+0x0 = 0xffffffff82c85620,
>              .bi_inline_vecs = (struct bio_vec []){},
>      }
> 
> So only call calc_sector_number when we know the bio completed without error.
> 
> Cc: Qu Wenru <wqu@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/scrub.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 188a9c42c9eb..91590dc509de 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1099,12 +1099,17 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
>   {
>   	struct scrub_stripe *stripe = bbio->private;
>   	struct bio_vec *bvec;
> -	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
> +	int sector_nr = 0;
>   	int num_sectors;
>   	u32 bio_size = 0;
>   	int i;
>   
> -	ASSERT(sector_nr < stripe->nr_sectors);
> +	if (bbio->bio.bi_status == BLK_STS_OK) {
> +		sector_nr = calc_sector_number(stripe,
> +					       bio_first_bvec_all(&bbio->bio));
> +		ASSERT(sector_nr < stripe->nr_sectors);
> +	}
> +
>   	bio_for_each_bvec_all(bvec, &bbio->bio, i)
>   		bio_size += bvec->bv_len;
>   	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;

