Return-Path: <linux-btrfs+bounces-12932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA531A83408
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433287AA8F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 22:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA121A95D;
	Wed,  9 Apr 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lg4GEk0s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8915855E
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237179; cv=none; b=sfGQvtMtoWURBe163xZeg0yCWN1dQ8hnMfc9NrTSGQ6EnYp/9ezS8Mnr5DkPJJ20FqQNlcVIWL8byap0H+x/eR9v4kWeuJ21unFor4FOGIPMjLfeLHwca1HPRXNefxJb3b7sSGHOkJvQkszViLeDtzdeDB9o2Fm6AwO64znd4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237179; c=relaxed/simple;
	bh=DIIsmLx5Cjiyy19oL6Brlhu6Fsn8x+79nVTSTHet2hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOF9V2YAi4yMGXRl8H3Ktk9mtxTxTk4xPX/J2eYERoM1J+DX7LfBL7hI8FCnnWUL3eHAw0DM7Od1Xat3NNQUlsH4mPFZskH+zCEBKpjqqdMh6mZEEPTLyTAENT7F3x8jgJZIJMY4cjLGifpQdd8BM0iHLYUT3L9Fujj+ZZS5Vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lg4GEk0s; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c1389so53175f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744237174; x=1744841974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a3PHMSFD5PXmMUNDCs2FQaTEMR5+I8gT+S2PBhvuReY=;
        b=Lg4GEk0sBWgj2a9sOZPr4vS6ZRRq75NxaTn98QJdzspCxH8fv7rrHMivVp/NqB0YZ0
         76x7qMtqK7F+jKOnPBu2+PZBuSbnRdkSBVEYmwGJ+BPiEQ2JgzudzysHmIKlv0yrAcxE
         PmK7XgVWgK+wuE/+oRfxvISzDQqlFmiK6J0hpjTYLn+xyfKi9a0a7Zou4zXzvyvl6j5U
         VP9Kd9eGe6R6kq9V05lfvtY4t3vjG20LrtDPd+tp+JGiRW07vAYsBpL9AJNSaLr1viO2
         Am4eFw9d5hdoCgny2PEzaVis0ipPnDLg+NiY8YeBfwx98ZtCaaod15aAiUkfukFxKUUM
         pZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744237174; x=1744841974;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3PHMSFD5PXmMUNDCs2FQaTEMR5+I8gT+S2PBhvuReY=;
        b=UAxKyTey1Nn0p1z2LdgyVx904F58ZkKSdi0joqqm01k8vweBRc9A06uaNgPJe5tQEq
         3w/6gpBbpt6eSM5QfmgP8PNCgpNJFMTock3r+6nBtUoazp7yjiEi1Gs8AqyktHF0dfv2
         jCUwwJUpYCYc4+EDtGDZusw5gkjTpELfD9m0VQDU+458h4tXg4M0OD6AS54U6hw8wywW
         NGnOE/Js8UHtei8eCcEmU4n5wh3l1+bjpCT7SqAqfWH1w88rhp5r/WaqdBPpa/zT0inF
         WHNHotmOLhnylH+xVlVmgArkhCvr4yPP2/0uxd3ufV81RkOSwFO1lBAzaEsUlOwUcCcF
         pGTw==
X-Gm-Message-State: AOJu0YxU1wDXMhWhGF+jJzQDplU4mjbWxkA1yrydbhWvTWOESEC1dTbV
	VfHoebRNEFjz2+KiNZgwavhrp+PVVN+I5Yw/Y+ZUQeJF3Fcz1nogLR5KYlwRK4sUwDrLAukJy40
	p
X-Gm-Gg: ASbGncsd2JH/PSpaFvfpkugyAzCKwBXucpyCQArq4MoMnRLv/Ughw8esQlxO69TbC9l
	dcu4c+pcp+nsakpmo8znHzl1iH7MV8TjkAX/tdTH8Ac5HGxpuqWsdSCCsN8bMN4mTdQVjXlHxkx
	UHJ8xtjVySTGMCRPoTjCD6iRjzIcveyGs5a8Eayb2k2hSy/8HiA5IXzndWMbmazIHd4Wav4OKhJ
	d0DBTB8eYG3sYHg3Qo4sy22VH6PI0TcjYrEoUzumvpGya9nF+jtql2/YtN977KsBnJ+kaWPiQHc
	mmGZWbhC8QLJgWhldjdn7rw5vmCPffWuJse3KZfGIKXzsDK69LzZGcjntTVUjGvAKcGN
X-Google-Smtp-Source: AGHT+IFBVbSbNEZrjfmD74ZCKVmM4YL10MMhHmbgZ7RSnJ42AtBerwgDC+3NpNflJzuh09TdcauUEA==
X-Received: by 2002:a5d:588a:0:b0:39c:16a0:feeb with SMTP id ffacd0b85a97d-39d8fd522c2mr46954f8f.27.1744237174365;
        Wed, 09 Apr 2025 15:19:34 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb53d0sm17386435ad.175.2025.04.09.15.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 15:19:33 -0700 (PDT)
Message-ID: <8f2a68bf-8883-4d6a-a756-eacd18022a7d@suse.com>
Date: Thu, 10 Apr 2025 07:49:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] btrfs: pass a physical address to
 btrfs_repair_io_failure
To: Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-4-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/9 20:40, Christoph Hellwig 写道:
> This avoid stepping into bvec internals or complicated folio to
> page offset calculations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/bio.c     | 9 ++++-----
>   fs/btrfs/bio.h     | 3 +--
>   fs/btrfs/disk-io.c | 7 ++++---
>   3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8c2eee1f1878..10f31ee1e8c0 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -192,7 +192,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>   		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
>   				  repair_bbio->file_offset, fs_info->sectorsize,
>   				  repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
> -				  page_folio(bv->bv_page), bv->bv_offset, mirror);
> +				  bvec_phys(bv), mirror);

Just one concern, this is highmem safe?

If it's highmem safe, I'm pretty happy to go the single physical address 
way instead of folio/page + offset.

That's way more convenient to handle block size < page size cases.

Thanks,
Qu

