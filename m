Return-Path: <linux-btrfs+bounces-8053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CA979F89
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B6A1C22CBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227414F9E2;
	Mon, 16 Sep 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a2YkoHV5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952914F11E
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483152; cv=none; b=DWtSriYLKnmBJkxdfuNAF3bLssMDyYZIS8Pq4Lmg6fHv1U2jyMGHfLICyewD0W9N1nIzGNWT9TQpLGFemN/97BMKn+nKCpIEEbI1Nq7Hmeel+luCobRC8XG5N1gX/zRy+iEydMEn9nxGC00xE6t4felAdvUrwgeWOqbxAqvXzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483152; c=relaxed/simple;
	bh=rhGg4hiCoh7q3hi9unyrnEkYlGV0+NLPw8BHB9s+eNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljr+LDOmBUOkwCmDzQteYPWQcyS15VoC4w/abDRJoIT2To5n8mQAH5e3t8XMae4/LIbs9trKLulM+D+KvFd9Sl8YONMKcqpQ7jBa4WZrKLEMh2PeyfeLpMt31lpajnLnz6fyoAE0F6+XLaP83qkTEquyPsAbw1IRe48TF5vAf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a2YkoHV5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f759688444so35787161fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726483148; x=1727087948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eVvEX3bODTdipfMWo1uF/Teahl5RLPzWBtF4acVb5ek=;
        b=a2YkoHV5maFx/HeD8xSJ0tjTJHD4Fz7OnhfuK2CpkRD09j4zQGUGkS6wC43/gZeeIc
         KxlqK8hrbDze53QYkBjfihfHTs8zG0lu1AW13DYLYn1TSrQdyqQk4YOVAe2N6aoP2+Ou
         zVcbWQPFygVYQFrxVXb2NlF2qyQ20wYeI40qSepuGjaZDJMlUSws/Wvon6uqVCDIlfjU
         P3LDP0Phol10Ncx/3G0G/ejTF+ixCxxRQ5P94DdIxkKVLnyfOcCSHOoYa93QCSJvSWn4
         uDJhhqpG/IUT4cNZDtY9cUSG+p6VXovtQ4wQXzWHFErY62o+ERasfItB/gj097vMumIZ
         h9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483148; x=1727087948;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVvEX3bODTdipfMWo1uF/Teahl5RLPzWBtF4acVb5ek=;
        b=uoTBua89tZZCpA8mqIUKTuEULA5YtIX7dq1N+X1wEdFLXOkTApcDnR7Prw0MyUwfpD
         DaBI/rguqfVE3/kcGReNreKoItmQ5ha4TrrABH4905xz0s2MxnDpeA5+XZnByTRLZK5I
         9cyYNKUKnxhUQRDL/1heTN+Mk+ktVvADFKVX7fxDXhpdLN/4R8z3OoROJFRVUs0fd2HC
         vZBpR/LlAi0timL6WGioUHEgRAPX3+yXSWLCc5EpG3qaT/PQ+WkSEF/+tnlfMg0nrIu7
         2pBzhBitNp1LNbuCImlSb3ba/pQuUJWk4yx4HdcktaxVNrnUg4oavIt8TnkE+tvAnIQP
         dAIw==
X-Forwarded-Encrypted: i=1; AJvYcCUj/Gt+x1DjXtRyhZnUZvQPqOM/Qmlr67sMi/tuEZI1Y0yq7K2PEhzVSCBuj1Z6vxOtXrqh/47OYTYCTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gh/JvAjAuSuN3Mm4KPBK4d8W52DSBIYpDT5ziqJyduhfQwDP
	aJFpeJROxD2QSMj42IG/Vr/IaThMLAyfO5ULQ/rGrH88EQ18PMoU5yMa6/0jJV0=
X-Google-Smtp-Source: AGHT+IGciascvsaL0ZRfuXoDDfpj2NaWX2dSIy7WKRYDYGtMtCTxZTPAsAAJ2eOPJpQYKfYbYelM4g==
X-Received: by 2002:a2e:859:0:b0:2f7:70d3:face with SMTP id 38308e7fff4ca-2f787f56debmr55703371fa.38.1726483146903;
        Mon, 16 Sep 2024 03:39:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719449b370fsm3465567b3a.0.2024.09.16.03.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:39:06 -0700 (PDT)
Message-ID: <98991e9d-cce0-48ad-b77c-b7d3eff71dca@suse.com>
Date: Mon, 16 Sep 2024 20:09:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] btrfs: Split remaining space to discard in chunks
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
 <20240916101615.116164-3-luca.stefani.ge1@gmail.com>
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
In-Reply-To: <20240916101615.116164-3-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/16 19:46, Luca Stefani 写道:
> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> mostly empty although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.
> 
> We now split the space left to discard based on BTRFS_MAX_DATA_CHUNK_SIZE
> in preparation of introduction of cancellation signals handling.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>   fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..cbe66d0acff8 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1239,7 +1239,7 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   			       u64 *discarded_bytes)
>   {
>   	int j, ret = 0;
> -	u64 bytes_left, end;
> +	u64 bytes_left, bytes_to_discard, end;
>   	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
>   
>   	/* Adjust the range to be aligned to 512B sectors if necessary. */
> @@ -1300,13 +1300,27 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   		bytes_left = end - start;
>   	}
>   
> -	if (bytes_left) {
> +	while (bytes_left) {
> +		if (bytes_left > BTRFS_MAX_DATA_CHUNK_SIZE)
> +			bytes_to_discard = BTRFS_MAX_DATA_CHUNK_SIZE;

That MAX_DATA_CHUNK_SIZE is only possible for RAID0/RAID10/RAID5/RAID6, 
by spanning the device extents across multiple devices.

For each device, the maximum size is limited to 1G (check 
init_alloc_chunk_ctl_policy_regular()).

So you can just limit it to 1G instead.
(If you want, you can also extract that into a macro as a cleanup).

Furthermore, you can use min() instead of a if ().

So you only need:

		bytes_to_discard = min(SZ_1G, bytes_left);

Otherwise this looks good enough to me.
If the 1G size is not good enough, we can later tune it to smaller values.

Personally speaking I think 1G would be enough.

Thanks,
Qu
> +		else
> +			bytes_to_discard = bytes_left;
> +
>   		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					   bytes_left >> SECTOR_SHIFT,
> +					   bytes_to_discard >> SECTOR_SHIFT,
>   					   GFP_NOFS);
> -		if (!ret)
> -			*discarded_bytes += bytes_left;
> +
> +		if (ret) {
> +			if (ret != -EOPNOTSUPP)
> +				break;
> +			continue;
> +		}
> +
> +		start += bytes_to_discard;
> +		bytes_left -= bytes_to_discard;
> +		*discarded_bytes += bytes_to_discard;
>   	}
> +
>   	return ret;
>   }
>   

