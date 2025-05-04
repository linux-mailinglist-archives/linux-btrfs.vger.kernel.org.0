Return-Path: <linux-btrfs+bounces-13641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D319AA8605
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 May 2025 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA57189AE62
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 May 2025 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE21A23B6;
	Sun,  4 May 2025 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QJtPGjTL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8171747
	for <linux-btrfs@vger.kernel.org>; Sun,  4 May 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354773; cv=none; b=KVJhM+RJfasTVt3abRsS3hgnfRPs6V5f/R/iMo7IwRBm4P93gBSGq+GciGV4HLhwf991CF0/a/wRzW1TlDpmIg8JF241CZmzq4lROreTtK5yvIxRw9HU6fQepK3pAMvPl7mw38R6nFukZE97idFyDydq7AIFebrq1qtPJeMuePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354773; c=relaxed/simple;
	bh=Q27RY7Qtaoh2hOZMOXRJrwN0bVEKHY5GIH6l7Yw0/KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uaMIIWpkUDFPB8y8vtBalxdJavSDZUWkHoWuLaP3KMVR8gapMZEGth3V419PMS2giZ5cBmwMGTFeusykVyFcKWndJbfmkJr1Tols0WoMn9sxjkJe5qKosrMBwsfcu683cLaIwCkIH9ujv3WWGCizRJpCXFCYl9F2+i57BABRqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QJtPGjTL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso3121725f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 04 May 2025 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746354769; x=1746959569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/oQhmHppfaSQbUzVCqQ0YifQY0EBx9zma6YvEdXbrw=;
        b=QJtPGjTL60y+X1r973+BUxYoTxYqUQu0Yj8aKkssKt+Z4Kgs2ck/ZaOfri3XNYU2+L
         MdQN3wPYV7McvKS4aY96G/ApCsch9bIASijQgd644JAdcBoKnxXBG1RtQ+CJ/gm6ymM1
         eUTZHLM0OwYHKtG4AbI04ZvJXtGLUihH4/MfP+LJX++5UcQ7OtxKDNV62+v8LqrJgCN/
         UdHIRBUSzZMPfhDqbf7fZXhBdoXs6qwUv2ehZcBwZRTxwDcQgov0pr9U/ETKdYbBedGc
         0pNJ4YlSo/n8CJ4vDad7obVBd9ddB8xyEcHWhnHFb5PbHqLOS3XBpvzzD7wWPUs5GuTW
         3dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746354769; x=1746959569;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/oQhmHppfaSQbUzVCqQ0YifQY0EBx9zma6YvEdXbrw=;
        b=WSS016aFuDpX0KGdBb7Fg25PIS9JN8bhl8bIV9PZz95v4cEQOcCGajocHzFspAIPpa
         W6HxPxHPRzpW2yGfxhqU9u9wUNRkB8XzoaLgDKV+85++SltAo83BYo3TzlcKiqwyFCTP
         ddEGM5nj1yCVHmpI93LVPFumJbP589QLnkbjoocD/otVoUroiBbsYbnEC624tEn68jwC
         Dis3vQjk+oRAHXTwozDKrhkfxAYeXjlAv7MI6KHzmrl06ciesXo6drAsygdsWZdJCCk7
         ArRjDatosdvsTZk2NRvgBxi2Oj1KbTBjdoNXgr/8iRQmRL8ZRe+JWaH5aegHDJfLpMiz
         iAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXCFFmuR+0fVlP1yH+o0nh8eOOYNXLozU8q3j7aXDpU87+K66MXIfjakcGZyskm77eU+ONHhHEKRaApOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQq7M6XL6iwErUpu4I20K4nkqqZdTHvZ7W2ERXLPZLtL/zUMS
	B9cMmVTQqMOkM6Zdjmjq9/H4vr/zSmx6MhBk7dm5wLj/8ZZdo/fuRS3skbpPzP4=
X-Gm-Gg: ASbGnctWJHf/2HOd3sQcatP8UfqPe28+TNuOasl7KC9Ky8SkwkV2rlTfaUMCf6ZxU7J
	iANAEHRNd0xS16+pVsLT/c93RzxbJs8GHMDjattmOPLNjI+8hkz+wEUt7HcsvRH8pa77IolA615
	M+qmSohq55TP1ED2VezzgV3rC6cRGKGcsS1nXBmhYMFZ771jciQQbA9XEb+C92DnWOHDCRRS7Nb
	SJgM9fPsAxV9aP1xZKmMi7qFh8m0xvbvnrSsNhn3hFV90HbMvqJyIw/pz5X3ATlbC28kcD9qF3r
	xj3TOyjbGlg+K6xTMWbmep9vDHcPRbCmNPTQGBm9Ntci9QqLhLqfr3i7VeB/r9ugEJWj
X-Google-Smtp-Source: AGHT+IGyq0wuMLkwD3hUGs1Df4te6r5grTyeH77LF3KeprzLwmkRg7WtNAUjXexvXUU9YsaEd3lT7A==
X-Received: by 2002:a05:6000:18a5:b0:399:737f:4e02 with SMTP id ffacd0b85a97d-3a09fdbe68emr2773301f8f.39.1746354768912;
        Sun, 04 May 2025 03:32:48 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e992fsm35736155ad.85.2025.05.04.03.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 03:32:48 -0700 (PDT)
Message-ID: <871b8620-f33d-45c4-a1a3-ca33c0f792c3@suse.com>
Date: Sun, 4 May 2025 20:01:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: check: fix false alert on missing csum for
 hole
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
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
In-Reply-To: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/3 00:02, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we log a hole, fsync a file, partially write to the front of the hole
> and then fsync again the file, we end up with a file extent item in the
> log tree that represents a hole and has a disk address of 0 and an offset
> that is greater than zero (since we trimmed the front part of the range to
> accomodate for a file extent item of the new write).
> 
> When this happens 'btrfs check' incorrectly reports that a csum is missing
> like this:
> 
>    $ btrfs check /dev/sdc
>    Opening filesystem to check...
>    Checking filesystem on /dev/sdc
>    UUID: 46a85f62-4b6e-4aab-bfdc-f08d1bae9e08
>    [1/8] checking log
>    ERROR: csum missing in log (root 5 inode 262 offset 5959680 address 0x5a000 length 1347584)
>    ERROR: errors found in log
>    [2/8] checking root items
>    (...)
> 
> And in the log tree, the corresponding file extent item:
> 
>    $ btrfs inspect-internal dump-tree /dev/sdc
>    (...)
>          item 38 key (262 EXTENT_DATA 5959680) itemoff 1796 itemsize 53
>                  generation 11 type 1 (regular)
>                  extent data disk byte 0 nr 0
>                  extent data offset 368640 nr 1347584 ram 1716224
>                  extent compression 0 (none)
>    (...)
> 
> This false alert happens because we sum the file extent item's offset to
> its logical address before we attempt to skip holes at
> check_range_csummed(), so we end up passing a non-zero logical address to
> that function (0 + 368640), which will attempt to find a csum for that
> invalid address and fail.
> 
> This type of error can be sporadically triggered by several test cases
> from fstests such as btrfs/192 for example.
> 
> Fix this by skipping csum search if the file extent item's logical disk
> address is 0 before summing the offset.
> 
> Fixes: 88dc309aca10 ("btrfs-progs: check: explicit holes in log tree don't get csummed")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   check/main.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 6290c6d4..bf250c41 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9694,10 +9694,6 @@ static int check_range_csummed(struct btrfs_root *root, u64 addr, u64 length)
>   	u64 data_len;
>   	int ret;
>   
> -	/* Explicit holes don't get csummed */
> -	if (addr == 0)
> -		return 0;
> -
>   	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>   	if (ret < 0)
>   		return ret;
> @@ -9807,12 +9803,15 @@ static int check_log_root(struct btrfs_root *root, struct cache_tree *root_cache
>   			if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
>   				goto next;
>   
> +			addr = btrfs_file_extent_disk_bytenr(leaf, fi);
> +			/* An explicit hole, skip as holes don't have csums. */
> +			if (addr == 0)
> +				goto next;
> +
>   			if (btrfs_file_extent_compression(leaf, fi)) {
> -				addr = btrfs_file_extent_disk_bytenr(leaf, fi);
>   				length = btrfs_file_extent_disk_num_bytes(leaf, fi);
>   			} else {
> -				addr = btrfs_file_extent_disk_bytenr(leaf, fi) +
> -				       btrfs_file_extent_offset(leaf, fi);
> +				addr += btrfs_file_extent_offset(leaf, fi);
>   				length = btrfs_file_extent_num_bytes(leaf, fi);
>   			}
>   


