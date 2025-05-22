Return-Path: <linux-btrfs+bounces-14184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BEAC15DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF74CA42976
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3792550DE;
	Thu, 22 May 2025 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XBsKsYn7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE711E9B34
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949088; cv=none; b=jyWLcwMKW4wGaWEfp/oNJhgO93aHr9dv8c8r9JoU+HD/wkSG9eyJXtBeARNO3SuFIAGkdnvpblbN+XYV7pG+k835qxB6b3GQ5L8QqyGYGz286gToVrnaDLetF5ktDlXenJrkGlniVGZNTpFP5+6YMANwPKBb/XVhD0RpnfdSCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949088; c=relaxed/simple;
	bh=bqzLToNEC8LzRIM0jniEaCaV6a2N5YuhqmZpk1rJ1fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lmDO3gQVNXpOYA3pNMrevcNffBUBovAo0BJlOUr62Zu4zQXNyk5UYbGCKOg9+SLac0vwIsMUGcUoTu3FUjofFSujOT3y4zex0Xthb7YLzGdZb/+HBQ15air2EUJUN2AG3ToS4JOhDaZoh1hKFCLQws37iO8g00WcrV72OwvsoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XBsKsYn7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a361b8a664so6589304f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747949085; x=1748553885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y17ccTuRUN/K7TpNLJpy7CUap4PUdnVEtxdx2hqwIJA=;
        b=XBsKsYn75yO+OoDh+sWWbWdFhQSVTbHSrhBjNcWIkuIGbpjFCetqf/utgVJXNnQNZm
         ibacBEFOE7Xco8WNFAQCmVKdlkyNEiHUVBdYA3OTNSwcPzOrNJjILSQoq8Alt2aLr6dh
         yeaBaGwJ9sME85x1OWwWi9FMtA+DB/WT9ZriYuHxuqdu8fSPDW20HgVlFAtKpRQFZpRv
         xktkyEvBr8V0z7T79zB+XSaVVo3uY2HY0Bt12/Oo3PZm1Ecq6iNEfuMe8L43uv4a0JYl
         XPt7imdjqLG2pNw4jpyXZFlzaWwJLhFshso+xU1lkvPqFGBT+1zMjg+jhD5tzcVR5Q8Z
         lQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747949085; x=1748553885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y17ccTuRUN/K7TpNLJpy7CUap4PUdnVEtxdx2hqwIJA=;
        b=XpzQaDOLGhf4zW8C+Nj/rdCfkXoaA2Wgmb+De3MhbaWKnK6iM2mSPr/WwkQ0e4puD0
         GVy3m6FiqyulusbdLj+84AdxfVqGZXP2gBNSJtyP8NLODmNs3zyeb/KTS2+T3PVPanqX
         VJV+pNHOnrT6h4EUjbhX0Y5QtE4x/qWuxE7jTZhIwu75k3yG61IdUZtF+cWm3eY1nid3
         Thd1lpeP8lqZ9WgdY7LMp6daTTkipLikxjxxjCfEfdyL2h8Vs++6Vc+qsSby4ew3G7R3
         3azHSEapF45uSXtqn/fWrC7tG/nS7aiaTwWBBNtsolcDxxbB/WI2huoHVjWkcmXBvb/M
         Ha8A==
X-Forwarded-Encrypted: i=1; AJvYcCV934CXjmdJ3tbn3FQ5l/EqeIG+wiD9GqVz/RgWGRE/rUVsBKn8Wy3wcRNUW/rpjACqMdvlU0wVC5MEDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS16U4doBrtf3nKxeBVfJOJgu1XAaLLVNnURvk0jy6tkgnYdf7
	CVhb4AprWKwZcYyz3V9MlhclvVHjy4z01nRbuQQ+PtsRop9JVYKz5MLmQeP9NQjt8bnwkqwlheM
	Y6lGO
X-Gm-Gg: ASbGncuYyPgMwrnuLrU4anqTZbwd7mDeYkYJ2unE6czGGoXT2VweNC36eT/BU0Y8U20
	JC6E4GKZ0RxO9tnZETx+ZW2btSQa/CsQVeN8e+/u8Qq9tXKDvVk36OXVxEZF5rVXk/aJrBCTn/p
	XfGKXu86qv+CGD0i2TmqU4lIryjzyZwfX5uyfQdK77M/KBRJtn55Qy5DVetWI7HhVRkHbwTvMQy
	A7nGOL9kkm0hvJ7OB4WA33nD5xOCqf3Bo4wez4/lgexClyYWs/dFeSw7wioovU3+30wQY9gqrHq
	zJ1CwTUH4cQK1T5l9sr+Yo3N3ObIbI98Vb6Q1mEVR+iCGHdfT3X7+DhwD+9CSZNnHItlev7Y8pI
	TY7k=
X-Google-Smtp-Source: AGHT+IGQ0ZBjBXoJE8gaySdIIVrllPQcjpE+L1gBTutznFFZLkRvqdpSKVHLM3jasXwocvK7ZNXuhA==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:7382:d6d1 with SMTP id ffacd0b85a97d-3a47382d7bcmr6955360f8f.18.1747949084532;
        Thu, 22 May 2025 14:24:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829cb7sm11648549b3a.111.2025.05.22.14.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:24:44 -0700 (PDT)
Message-ID: <afbb6ba5-4d6e-4575-9b6b-8a7d337ae235@suse.com>
Date: Fri, 23 May 2025 06:54:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: include root in error message when unlinking inode
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <a5d6ade388b810520d18ea92fce0d94c33e72768.1747926978.git.fdmanana@suse.com>
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
In-Reply-To: <a5d6ade388b810520d18ea92fce0d94c33e72768.1747926978.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 00:49, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> To help debugging include the root number in the error message, and since
> this is a critical error that implies a metadata inconsistency and results
> in a transaction abort change the log message level from "info" to
> "critical", which is a much better fit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick which can be addressed at merge time.> ---
>   fs/btrfs/inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7d27875600d6..161a19316dfa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4250,9 +4250,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>   
>   	ret = btrfs_del_inode_ref(trans, root, name, ino, dir_ino, &index);
>   	if (ret) {
> -		btrfs_info(fs_info,
> -			"failed to delete reference to %.*s, inode %llu parent %llu",
> -			name->len, name->name, ino, dir_ino);
> +		btrfs_crit(fs_info,
> +	   "failed to delete reference to %.*s, inode %llu parent %llu root %llu",

For most error messages involving both root and ino, we put root id 
before inode.

E.g. checksum verification in inode.c, zstd.c, lzo.c etc.

Thanks,
Qu

> +			   name->len, name->name, ino, dir_ino, btrfs_root_id(root));
>   		btrfs_abort_transaction(trans, ret);
>   		goto err;
>   	}


