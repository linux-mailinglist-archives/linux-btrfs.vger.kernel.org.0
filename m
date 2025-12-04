Return-Path: <linux-btrfs+bounces-19532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA7CA596C
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C185030B233A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD23081A1;
	Thu,  4 Dec 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aSGV91gN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B432F12B3
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886318; cv=none; b=LTnCgrcArvJq17pfg1RgSnDQqkuyJwf66qVxRHe7Zv7qsQVrkzQm7zyftUIO7u7V41Y9oxBjlI+5M4+zhlb1Zc12xzJLOSnqRbwpHBs0R5DA3g4NWxLEWSXGGeX9hNJnrPLBJVKjYhhskS4K/kdz1dkE71U4XE2m5qAIcBUSjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886318; c=relaxed/simple;
	bh=hW32CyuxDEwjy61bQ7MFURG3mJuCBe3UDTZQ4kCCXvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwGPLX/JKbiN2ETS9C8J2lCSrF+q5kAHWEnIHlYvWgSkx9Ode4j7DclodCnDomFZrSJGsc7FcI5byPcF0T7d2sgTexytUYjcljEtT5Fy3hFdPv8wpa49k5PT0fN5NLyoW+e55bRfwJ5Y0Z+3n9Sr/zD8wvW0Ye5Txhi+PA8aGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aSGV91gN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775ae77516so16537055e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764886314; x=1765491114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VzcYmHPF8I9//n8J7yjT3uFcR1fe6rs6vvVEQuDv91I=;
        b=aSGV91gNkNdNYiPn7FK9NUqknt6vVneJEp8EtdWD6DnkfbrFNtZlevSXRUp69NbnES
         WZ/jmTSVoGDGzwc8NCzr9EWsH70iVJAzTEUnmYnON13rgLqlMd+lJfyJEOzCDQsAvIVa
         FRAkidEsOnhS81J1Eyc3kY+JJclzInOvazSbSxZWZILiF9l//B44LPK2K79jOt6PZlPx
         lrTajtI1u9q5Z15MXkvF7Kx3xJn0sc2AHMP+KxJ0FznNuE6B8fhU0BiP51trsMLQT38M
         L1bOg74MYs2bPczmGV/jej2rxLRCJj3XoNBW5lAQK36xXR/iACBXMW1w8ScM6WKGtNG0
         09zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764886314; x=1765491114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzcYmHPF8I9//n8J7yjT3uFcR1fe6rs6vvVEQuDv91I=;
        b=ITA0wy7nA3AZWU6kRjHbGx8SAOJZkoc43hM6UYb6mJ0OsTaux/ihtn5H1sNsjYUv5W
         +4YpZJavURq9faIqSCD2VICpMg++Gyp3Qe7LdV5UJ5LnGkkZ/g7LfvU5wtvXr09sDGTi
         zUxlBMtVDKlM7jmdX7mLA2WIuvDvHvqYHsD0PzGslJBxf8TC4TcnfluO3g7qolUBIdb+
         iRSl5Y9Z7IGzwJoYPepDhR8KWj1C/aZ+TD0xV++egXEkLPaFaoTbyBoIq1SRXxjIukR7
         BT9BBSK6QsYuPoN0PxaeBGs959SOGYyAsFVGUiqmbZNgLHUoetqRAalgTZtj6Y35oGBR
         9OBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABX1H5pJVINriZQECvYvL7lKwBme0oxabCJ53JZrD6PYZg6WMhWmW+rypd80GAz9YGAlJtqKZpjmSmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo08MjMQCqMUA5DiLOJk9TvJJWv3AjtbB4TRbX2/J62lUUkj3R
	58kW28YHj783v8IjP6JcMzCHTNmiib/cgIxrWSPs4COCt0CdXtYpr4i7Z3zBK2lKZ6Q8ZzWjLq5
	p7nih
X-Gm-Gg: ASbGncsI8uct4QvK3d7lAQNahFoV+vKjyTysBdYBIlJqvH/uMYptNBrq8S1osTqTCwG
	f2fjJPNqmxOzcqj3KtcCOgOhJb7MddqYblw0HjzN3pVwRtpxDNvs/53DbleBPOkV/VHRFdj39qE
	MEqVCCeFLsC4Du/TcDTTIRZbwmiZE33F6R5dTfJVehsYGpHwsQXv3/9iBMPWA4Gh4bVQuAj1aV9
	4NL5RxtD6IbNqFVH/vg4o6VsR6nx8QelZdNLpZ14UAxPzST/vohfybnw0xK7lCyJZuDDr6OZIVo
	PwkhBVpBDf1DrjJKR0Zz7RWkYRdQQc/HCcPxpeTrStrX2slcJLQ2TMMsj6LXNQtJWNln7cfPlSc
	Dkm+iIjeBRTQE3O6lsHCEW2FUih5yAUEZZt94wYrogQqk+iZ5m/v1Dzy3O0nbrYJ60LZRMP31C2
	BgZP6jJ1NUDZ1IHAjtbrlcvc/xKdfjhiqK3p5WCoI=
X-Google-Smtp-Source: AGHT+IE54urcZGCq/VoCfvrFt19jKJun6QMEUyXFObZLSI6eG2qWNLebGmX1d+cKS/sL0alCTaXpzQ==
X-Received: by 2002:a05:600c:4e89:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-4792af48329mr81411935e9.32.1764886314343;
        Thu, 04 Dec 2025 14:11:54 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912a0af01sm2807083a91.6.2025.12.04.14.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 14:11:53 -0800 (PST)
Message-ID: <35a62029-142b-4882-a238-81baf00f5f1f@suse.com>
Date: Fri, 5 Dec 2025 08:41:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-3-johannes.thumshirn@wdc.com>
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
In-Reply-To: <20251204124227.431678-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/4 23:12, Johannes Thumshirn 写道:
> Remove struct btrfs_bio's csum_search_commit_root field and move it as a
> flag into the newly introduced flags member of struct btrfs_bio.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
[...]
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index d6da9ed08bfa..18d7d441c1ec 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -20,6 +20,9 @@ struct btrfs_inode;
>   
>   typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
>   
> +/* Use the commit root to look up csums (data read bio only). */
> +#define BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT	(1 << 0)
> +
>   /*
>    * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
>    * passed to btrfs_submit_bbio() for mapping to the physical devices.
> @@ -80,8 +83,7 @@ struct btrfs_bio {
>   	/* Save the first error status of split bio. */
>   	blk_status_t status;
>   
> -	/* Use the commit root to look up csums (data read bio only). */
> -	bool csum_search_commit_root;
> +	unsigned int flags;

Unsigned int is a little overkilled in this case.
We have at most 4 bits so far, but unsigned int is u32.

I think using bool bitfields is more space efficient, and the bitfields 
members are all set without race, it should be safe.

Furthermore I also tried to reduce the width of mirror_num, with all 
those work and properly re-order the members, I can reduce 8 bytes from 
btrfs_bio:

         } __attribute__((__aligned__(8)));               /*    16   120 */
         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
         btrfs_bio_end_io_t         end_io;               /*   136     8 */
         void *                     private;              /*   144     8 */
         atomic_t                   pending_ios;          /*   152     4 */
         u8                         mirror_num;           /*   156     1 */
         blk_status_t               status;               /*   157     1 */
         bool                       csum_search_commit_root:1; /*   158: 
0  1 */
         bool                       is_scrub:1;           /*   158: 1  1 */
         bool                       async_csum:1;         /*   158: 2  1 */

         /* XXX 5 bits hole, try to pack */
         /* XXX 1 byte hole, try to pack */

         struct work_struct         end_io_work;          /*   160    32 */
         /* --- cacheline 3 boundary (192 bytes) --- */
         struct bio                 bio __attribute__((__aligned__(8))); 
/*   192   112 */

         /* XXX last struct has 1 hole */

         /* size: 304, cachelines: 5, members: 13 */

The old size is 312, so a 8 bytes improvement on the size of btrfs_bio.

Thanks,
Qu

>   
>   	/*
>   	 * Since scrub will reuse btree inode, we need this flag to distinguish
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 913fddce356a..1823262fabbd 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -603,7 +603,9 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
>   	cb->compressed_len = compressed_len;
>   	cb->compress_type = btrfs_extent_map_compression(em);
>   	cb->orig_bbio = bbio;
> -	cb->bbio.csum_search_commit_root = bbio->csum_search_commit_root;
> +
> +	if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
> +		cb->bbio.flags |= BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
>   
>   	btrfs_free_extent_map(em);
>   
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2d32dfc34ae3..d321f6897388 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -166,9 +166,10 @@ static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_ctrl)
>   	if (!(btrfs_op(&bbio->bio) == BTRFS_MAP_READ && is_data_inode(bbio->inode)))
>   		return;
>   
> -	bio_ctrl->bbio->csum_search_commit_root =
> -		(bio_ctrl->generation &&
> -		 bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root->fs_info));
> +
> +	if (bio_ctrl->generation &&
> +	    bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root->fs_info))
> +		bbio->flags |= BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
>   }
>   
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 14e5257f0f04..823c063bb4b7 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -422,7 +422,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>   	 * while we are not holding the commit_root_sem, and we get csums
>   	 * from across transactions.
>   	 */
> -	if (bbio->csum_search_commit_root) {
> +	if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT) {
>   		path->search_commit_root = true;
>   		path->skip_locking = true;
>   		down_read(&fs_info->commit_root_sem);
> @@ -473,7 +473,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>   		bio_offset += count * sectorsize;
>   	}
>   
> -	if (bbio->csum_search_commit_root)
> +	if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
>   		up_read(&fs_info->commit_root_sem);
>   	return ret;
>   }


