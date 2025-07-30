Return-Path: <linux-btrfs+bounces-15768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACCBB168DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 00:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353947B5922
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 22:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECD22A7E5;
	Wed, 30 Jul 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WMSJ3olL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7219C556
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913278; cv=none; b=eaPZ0vsCswaaxLxUWyG8za/0IAXPwcVJAeI6nykpxKiZUwcWAE4fu/VoSypVUbrz9vYUz//p+NdXmzItIDVJvB+KWIbMAw4++Yb2oCAcZjn6IN7pjXNG4dpv0PLpdiG4gUHc+HcwnlNpvuwFpzkuF2KGqAw1OgxIPm7tlZx00dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913278; c=relaxed/simple;
	bh=dkTHMRb1ZYI2/fDmnwHEewynmzsWQsJDJ5+wykz3plI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sam0mCMAFU9qGt3ndfWlMoAxv+0JOuj+J2PjpT3Z7fBDzLTvoh2Zs3esyXgo4xqijwxO3o23imIV4KuJ3DM723RoSKvB4//OsZRQGEfrtBVLMdWt2n+coZ3NyBiEX8agLHTtHCm/XeZcTBrroQ14HBeu7vP6yd7n1u5MohHe7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WMSJ3olL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b78310b296so158374f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753913273; x=1754518073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QpLl1Rvl9xOCuFCtx7+evaPMIc7e54haH87I+l2o8pw=;
        b=WMSJ3olL2Bk4Qcs+VWITSEhK7MLFhErH8MeOO1J4QLBYuGjUZWsLuL5wpA3sAudNpb
         fvrdPUGHd2ZTsbusUpGsZD4VvdbJqTAwwMxribMuiQ8JCHqmoM7lhvVm5p8Lx9B6Bfh1
         lU4ETA4O/pc1YgG86l0GyL1BAP31qCiUTXndVDlIsdKsv3r6tzZuG/EPqU7L3Mg/f0oc
         /5JvyZg4n8H4+0jtH9ImNfkDPx/kpDw3zdVhF0Ll6r0pNoEpjYN3lZl0dWnv3xKCwi5T
         7IX0UFTFbx95cQWao8l1TZ2RsR1c1plQOXX4HiAMlHBA05ixxt1kki0Bdh0JH2Qz2p4F
         kU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913273; x=1754518073;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpLl1Rvl9xOCuFCtx7+evaPMIc7e54haH87I+l2o8pw=;
        b=tpjGP9pCCQ4dEwyPIVrjsaHGVxVex5qVnj2kC4UE02Dw5zuil8vwn7bzztqMLKPVYY
         dFqrM+w5QjnXcKvvoMJf9P3jqlv+bLau8+N1oar0xilmosSeFFCV/tRTjgP4x2qzwHAj
         zgfC8xi6FYbs5aVrgP3Ya6q34oclADYWYOVET6NHetaaYRM5EF0kmnBlKwaOrHqpMtsF
         2LhijeKnohWt/mxR/VUkxvCW329LB8xZw2BgM08XUa9CBnsViRWT99Iu13W6U6xyNEov
         Tq55qCNEhov0XZfa8QR9dE0AQaFQSEb2mH5xGr8ntSEitPWrNnHorZ0xy4BQkG/eCIL/
         2xBQ==
X-Gm-Message-State: AOJu0Yw6zxnNdThz3pS/1C3htJ3kf5mVnIT7RQh9HFCcWDCrSOu5Gvst
	5MXpZQUSTUJRbf9PBCiXAIuYLpfZSVXhC3VWaNja4zDj6SB/cbgm70AlahxJIyjhZgY=
X-Gm-Gg: ASbGncuhbBJRpU0UcgIgq1BVKB3N4WuZii9l6nrk9sqcWUKk2Vi7u32gGz8jYQKt+qp
	wYdLgOwS+frK27rwhLEWMGD81i435+02NGBaIIBMiCeabRlBVX2qLsJS5oyGBWSU01PTcGZsGaR
	lH4UuokeKnt+iXtfKrxfPKRTwLWIQiB6Qo5UjNYnp4p/XEVrXmxQt1y2cDuWFZulWDkThtV5xvK
	PqyWfZ0NLtHyphUD47UaZbAA49pBqDQ+q/tMYAXUJFto7rY52bRKKZcN/iE6PaxEAgXlbxHFX9K
	yE1NvrSVTm6upAD81zdeKMXMrFbHXjl3qNFvaw+vZXM58RTzvy09CjEDgo5Ln2Q1Bm7SJ1nJ0Mh
	doEmZ4e3JpW9dWj9FdRQUrYB48xcmRRIs01uIxWSsTl107GTWteb6gB28gRNt
X-Google-Smtp-Source: AGHT+IGxqhsA8ZYPHy2vibgQDje9tAo3v9w6LXH7G6f1o2mVcFyQ6ODcRL5r4RNthNuSvlgxb9/+WA==
X-Received: by 2002:a05:6000:1787:b0:3b7:82a3:fdf7 with SMTP id ffacd0b85a97d-3b79501e5c3mr3952491f8f.36.1753913273182;
        Wed, 30 Jul 2025 15:07:53 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77ecc4sm53253a12.4.2025.07.30.15.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 15:07:52 -0700 (PDT)
Message-ID: <fd555c60-a492-44b2-a47d-b17f239e3a2c@suse.com>
Date: Thu, 31 Jul 2025 07:37:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: replace manual next item search with
 btrfs_get_next_valid_item()
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250730145327.22373-1-sunk67188@gmail.com>
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
In-Reply-To: <20250730145327.22373-1-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/31 00:23, Sun YangKai 写道:
> The function btrfs_get_next_valid_item() was introduced in
> commit 62142be363ae9("btrfs: introduce btrfs_for_each_slot iterator macro")
> and has never been used in other places other than
> the btrfs_for_each_slot macro.

That's because the function name is not that straight-forward.

The name btrfs_get_"next"_valid_item() implies it would move to the next 
slot, but it's not the case.

Thus this can lead to quite some confusion and we're not that excited to 
use it.

One example inlined below:

[...]
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa7a929a0461..70e73cbf6b16 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1723,18 +1723,13 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
>   		goto out;
>   
>   	while (search_start < search_end) {
> +		ret = btrfs_get_next_valid_item(root, &key, path);
> +		if (ret < 0)
> +			goto out;
> +		if (ret > 0)
> +			break;

Here just by the name, it looks like it will move to the next slot thus 
can be problematic (as it will skip the current slot).

But it's not the case, as if the current slot is not beyond the current 
leaf, we just return with the current item key stored into @key.


Another thing is, we may not need to bother the @key, or the caller will 
manually check the item key anyway. Compared to the confusing name, this 
is just a minor problem though.

But still it modifies the @key, which may or may not be what we want.


That's why we are not excited to use the new helper.

Thanks,
Qu

>   		l = path->nodes[0];
>   		slot = path->slots[0];
> -		if (slot >= btrfs_header_nritems(l)) {
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret == 0)
> -				continue;
> -			if (ret < 0)
> -				goto out;
> -
> -			break;
> -		}
> -		btrfs_item_key_to_cpu(l, &key, slot);
>   
>   		if (key.objectid < device->devid)
>   			goto next;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 245e813ecd78..8fe5b7e362c0 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -306,14 +306,13 @@ static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
> -		ret = btrfs_next_leaf(root, path);
> -		if (ret < 0)
> -			return ret;
> -		/* No dev extents at all? Not good */
> -		if (ret > 0)
> -			return -EUCLEAN;
> -	}
> +	ret = btrfs_get_next_valid_item(root, &key, path);
> +	if (ret < 0)
> +		return ret;
> +	/* No dev extents at all? Not good */
> +	if (ret > 0)
> +		return -EUCLEAN;
> +
>   
>   	leaf = path->nodes[0];
>   	dext = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_extent);


