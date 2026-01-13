Return-Path: <linux-btrfs+bounces-20466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B2D1B25D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DF830486A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5236A039;
	Tue, 13 Jan 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PDxK8qky"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BC318EC5
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334880; cv=none; b=aS/Rxyr1VCwiCgVvGH8KZOOKYMXsUhpGlrtTy8Lg4Y1hEAmRIpKURo4j84HK4Zi4Yy/gwMZ1qpimeY8UOujQqmfhY+UENrYgrN23zpL8p8LACq4U7GkjbmWMvOdM1fgZHz6wzomBU/7OLBikcFmZHDdYjQDqb++diwtnic/X0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334880; c=relaxed/simple;
	bh=9YE9ZxPZOY3YF/AIc+8qzwW4Dxzo8cV8GVD3RFx2zuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QTE7TLm2yB8fwW09u4lRB+Cb1iiyadsNmP1qqBb/xZ3AVRPqDfPuQMkLYlXVuT6sFCo/qKlnl/Nke42Nfy9AF0R5kea4iNeYw4lFYSnjE94yLyIyOnkdZVioCvdgOebh746PAuAn3pI4Kg0Ct1i6LTq0vZLW4SSwYTNVVKN7P0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PDxK8qky; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so59416295e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768334876; x=1768939676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=00w6P7pOvofvv+usg84N38Zv3cqAzBm/lncIjL2Tppg=;
        b=PDxK8qky3GycUmoUP+0edYnWXFTdDH/m+XjskawUR9LQikfPa/PIxfSkYticA9+rFz
         GC8xK2kLujGetlhJp9PC0GGaL1Ocm8PYjcuKeWe/fg0ymOHLulbnOJY07Bzpzr9o4F6G
         BrDDVG8XS5eULIernTaOITcwd3i2XkKJquwmLR0CixHvtAg82fezdvKZMlryjZUI9xgZ
         hcL8BPSyxonVgL9d1OLo9oMcR+h1bKCZZTrjeulkaBWS3RRK9LJQ4NARszRuDsgiTWE/
         3KNb09ixMhjCYLzACP3Xkcz4UQ6kkoZG9mzsb+iVQ07lSHHEeXL7rYOxdx179W8aMPLc
         61pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768334876; x=1768939676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00w6P7pOvofvv+usg84N38Zv3cqAzBm/lncIjL2Tppg=;
        b=iD/6v3r/7kaXSsFz+Bcyh+QBjFIFKdXUntXmilm6RqmcbuMv1X3C4drQJ5LgqPqS5h
         YroJnhq9VTncQXSnaLRL/jGfTOu0gr6qz/heVr0YAFJ5jd1rZGkRHWVOhDPqFXPk7nj1
         5kEG11COxuvcf/m+cjzzeqBIECaoxi8ISwKR7dkdK9d/FpJbm64gdtpYwHwD6Krmdsev
         J0pEh8Z3l64RWnS3b+3sIlIe7jlvVFvoW929BJy/252SGEsWVT+tUOfAtzJYtcrAO8GR
         VbzlSbmvjALqa3J+zxrCWHT2XHH7wj2mfGFNjJl72TxZPSbYrTmVqTIK8Bn84Y+u97Ct
         LlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtCEc4sS6xDN71iPOPKt+m3yigkq5YcHTxs8sy1AK78E1GOhSOz4oxLqvohFEn6+Vcc6HRgue62QCcyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySIMxJhtYf1BEpo1hRwKrTMgqs8kKjkfoC6uCdYQiIPuarCa8n
	A98OUAmNQd1OWD0Xb0DrFvOmEHoJhBVIUlJfkG+a8whNxkuzUBi5pZTofGmMuMIF7Vz7oiJajRG
	892UiXmQ=
X-Gm-Gg: AY/fxX7BfQpZOvbrJHukSB5n/NgVxQP6xMeAUJYXkKRz4gcwkJN4IZMb643eNepc7Og
	H7JLMKW9Ola/3EJRNPlFkOe4qsudtFB2G4oJUVAt9Hp16d1P2dYVhH9FnxJDMoU7m/rJBlU64lw
	myOtizwqRF0qr0fDxLKzgmyV8edUxLtm4u6R2X/v0asuozqTslM2y/iLnwP6BBSO5mY55vSHwqP
	olborZFFOJBd2dyIusnnex9GYXeVjQ3m2/2BK6EMOAn8i03kPK5tl6Pr0dcDrWXiAUTSBVJrRzu
	FK1IHzo/Ploiwj2tpi7D+ki1PmPAyrQ/Jursvz6rHsfChVSgnM0FtN1Q1a49ezOdrRtf/ubOcR4
	8yWHm/QNpz/OHDGj6Vd89iNxh01QYUVRsB/JC+3C6MPdfOrzCaITKJk2l0++k7AaZF/el8HWZTt
	li2a4w5Q3E5A+y24smoVEhuer1/xUTIFyV0sFG9i0+fjaQdOxEuj9pJv2W+l7S
X-Received: by 2002:a05:600c:3e0d:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-47ee33ac454mr4638325e9.32.1768334875584;
        Tue, 13 Jan 2026 12:07:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm21205249b3a.54.2026.01.13.12.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 12:07:55 -0800 (PST)
Message-ID: <922f4b61-9bac-4de7-a635-d476a67a7548@suse.com>
Date: Wed, 14 Jan 2026 06:37:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix missing fields in superblock backup with
 BLOCK_GROUP_TREE
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
References: <20260113183802.17640-1-mark@harmstone.com>
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
In-Reply-To: <20260113183802.17640-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/14 05:07, Mark Harmstone 写道:
> When the BLOCK_GROUP_TREE compat_ro flag is set, the extent root and
> csum root fields are getting missed.
> 
> This is because EXTENT_TREE_V2 treated these differently, and when
> they were split off this special-casing was mistakenly assigned to
> BGT rather than the rump EXTENT_TREE_V2. There's no reason why the
> existence of the block group tree should mean that we don't record the
> details of the last commit's extent root and csum root.
> 
> Fix the code in backup_super_roots() so that the correct check gets
> made.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: 1c56ab991903 ("btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0491b799148f..54c4496c30d7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1650,7 +1650,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
>   	btrfs_set_backup_chunk_root_level(root_backup,
>   			       btrfs_header_level(info->chunk_root->node));
>   
> -	if (!btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
> +	if (!btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
>   		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
>   		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
>   


