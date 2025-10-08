Return-Path: <linux-btrfs+bounces-17555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4EBC6AFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 23:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004BB4034B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3132C0F79;
	Wed,  8 Oct 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ccvz4eac"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA22C0267
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Oct 2025 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958885; cv=none; b=e5nw1vc86qbZf6MTvcfV5Jyr+Mnx57V0+cdaqrwsapCmahaQA5dX7GQOLNdvhniz3bF9Fvdh+Rgu87Dc29JKm8lbzLQjw9adY7v281h5yFsgGtJvCbcRVpbCqFhlQdn9EJ+viDFKZEjzfABBfbUVDHVXP9nK3/DPNcDjhlMtLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958885; c=relaxed/simple;
	bh=E5N2Fgy9mJ0mvj1n6CWlymPq/Ag30DuQ861RwNTamHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shcDf/P55rJUx3d5jfECkpTpWJRJWeEa7BMdRvgSkh0qHm7iLlbLMSEqigZWY5bFpFXz/E1IXaiYWdeu4tmKi0oY7TLG6d4FAlFa7ov6XBvAMvSKKUBxY9Lky7zftVKMsJl4mzcEy7i4OFqeSuHSXCkDD/Jac46XYJkfS/Vn1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ccvz4eac; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso262461f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Oct 2025 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759958882; x=1760563682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3EUCRhmhoMUd045LVIlT60xGnWKT3phek8gUNMDC4=;
        b=ccvz4eacBoXB5hmIFxrybCA+MYrhv1C6RrbKlKEBgy1SxB8Wj42EXCInZYK0MZWZBv
         GYt60iIqxKRFoAr1LBx0M8rxlYreHJkjq20eKALxXBY1AP5/eEFdxBJ50KU5UI9mzqHF
         ACu9Kq5vE7o/9IN8XUlZdJJvYU0OsbGOCTC0FDakQTz/1wo87h4yLuRqgInKQQVR9Fw+
         zOYtF4tZ8pXZmigi+X5jo1nvOUMS5NPWiqXGH33BviAZiRMU1skRiJGsa3KESiM5vxNn
         eK2MDBkSs6KupaXJg3Jb9cNEZs0Td4BP6aa2ocYxKmEaBSe0Il0S5ZZcO2zSf7mD9YDA
         PSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958882; x=1760563682;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D3EUCRhmhoMUd045LVIlT60xGnWKT3phek8gUNMDC4=;
        b=Fr+xD4708SLGaxxm1NAMTZxnRU7g5cjJvefKYttmMEnZZkrTSEdiMx+sQkQsaLRVMN
         s/KrDV1bTVKsUQ8n4QkxSVpzGEspmyIqKbh4JzeP6D3wt21CX7yKU9xh9MhfrO6qafIZ
         JF7zU5MGM4fkdqSTnQdYHggXya7Z5sKxZx3tnIF2fAWgwn0hFSfvYgpt8RCgLvlEyn9r
         ZXgJjdA9a1XEwq1V0nqI0R+W5WhoCiESfgm9H+/Gwq7rPXLObJBedQ+uPRTK2/qwevgf
         O0pn4K3jNewY3KDfzFW0BjLUMBxZCI7iP8lS298Z1c/5XyaGTJsZNEyNOsD5iitnErJY
         5VXw==
X-Forwarded-Encrypted: i=1; AJvYcCXIjR3w0ockIhVPpClPR7VFkVCOamvT+XcRw+VrLqe88OpVIKie8VW0v4NV+KtTeYBO8mn/pqUNzRCtlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGjF8gGf8gV3zcK5B3vV7qnBFRSv9+jfoVXJWOHv7weais6DF
	5LPbA2N0K/19y7baRcvFOg9x1lB3l7vTorN1Y5q0TcTpFxFuE3zvoZo7bDikY7b+np4=
X-Gm-Gg: ASbGncvBL1LV2v6gyh6/3/pXoyEE51bRCaPDHAZxaAqNom8h+J2vN6i1hHNBJQt5i1f
	In0OL2hIfSfTOqf0LloUwZwSllrsY5Ai//GThwIpoeqq8euT7aGCCqJW5MPVfLJFBNY90itHpCc
	vdnSBnAA7uskzqW18eC4MUZtRtbg3W2PCKDksCz9UVexmcmhAErlzkQXnAcliuXMh3hMyUxLEVF
	BwWlp9/Zcih2ZTrvSrQmrQu5OiSKIMJN4pSCzr98YQDv9VSQs9YVxM1t6xKmqOEcVPMXenHrsbT
	krtYegosafOQjrkkpuE71D53rU1CR1DZFDQEdN7+nD/ULnPgTKXgXe1PNQDpSwoxISDMsn20jSV
	EGnVom9b+aME8O5BjTOph8pbAcNhJNDIeSh9l7xxOW1FanbUYyIy+3tdDa2Z7wATsg2cmIvLedB
	s=
X-Google-Smtp-Source: AGHT+IFeqI/ZwivgLiNFVO4l3oOVEHmh6kuhLEznUX/5OJiNg1nVk/Ecd7EB2BNW+Jn42ULb498vFg==
X-Received: by 2002:a05:6000:2087:b0:3ee:1563:a78b with SMTP id ffacd0b85a97d-42667177dc7mr3205640f8f.20.1759958882005;
        Wed, 08 Oct 2025 14:28:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b63201d6996sm5644011a12.2.2025.10.08.14.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:28:01 -0700 (PDT)
Message-ID: <34156b7a-b8b4-4f0a-8379-f212951b8d57@suse.com>
Date: Thu, 9 Oct 2025 07:57:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: Fix bounds check in
 check_inode_extref()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aOZ-inc8o7T63QHT@stanley.mountain>
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
In-Reply-To: <aOZ-inc8o7T63QHT@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/9 01:38, Dan Carpenter 写道:
> The parentheses for the unlikely() annotation were put in the wrong
> place so it means that the condition is basically never true and the
> bounds checking is skipped.
> 
> Fixes: aab9458b9f00 ("btrfs: tree-checker: add inode extref checks")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Nice catch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ca30b15ea452..c10b4c242acf 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1797,7 +1797,7 @@ static int check_inode_extref(struct extent_buffer *leaf,
>   		struct btrfs_inode_extref *extref = (struct btrfs_inode_extref *)ptr;
>   		u16 namelen;
>   
> -		if (unlikely(ptr + sizeof(*extref)) > end) {
> +		if (unlikely(ptr + sizeof(*extref) > end)) {
>   			inode_ref_err(leaf, slot,
>   			"inode extref overflow, ptr %lu end %lu inode_extref size %zu",
>   				      ptr, end, sizeof(*extref));


