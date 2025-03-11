Return-Path: <linux-btrfs+bounces-12208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB9A5D1CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 22:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15401895AD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF5264634;
	Tue, 11 Mar 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W0qs5/as"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF546263881
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728840; cv=none; b=F8qJ5d/JeYMybBAxLwaqH1Ru8d20ns4iO9FA7LgUozHmyLEeaLXPrk4athLW6pOuIQ6ErJkE/a5YEOunsCJPWPJvn8Eedrwco3LNtVmlBmlGCbRrJ9kdFVUarUBQ5F6iHyJRqx87mXxVDUivrz6vaY0JlcrqIb9x+o717QKU7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728840; c=relaxed/simple;
	bh=SXRfasQionXXN/w+od+kVyxwXfM0lb/oW6nHLSs7WN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CWdTKt4VPJOpxZoj5v7opaY5Nezknhq2+Zuu8dGWFAFdiNg78dfOxJ5D4Of9jHx0Fb2VcOTjsJLaOjQMHy5eD0fb13IYuNHv1cFaGD+Mgdij6uQVT6p+GXgt4cIXiUgLmuXUt85Pp0l1F3woW+BDFlv3nVSQ6e8Gsbf7+6cL7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W0qs5/as; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3911748893aso3618081f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741728836; x=1742333636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fZJ28s51tBxYWxu34w0CzvB59LAgctctG+pggF1wkYE=;
        b=W0qs5/asNZgTvsqmNM2cM88OhpT4eupLPCPNKWJl/VArqmjM3f02EzCxmWntaM4gwF
         XTBriKAmnOwxVSBojvf3nLazOF6SNFwWhRJBhp7iMFhuoCijXxzRUQcAv394eV6Xg0T7
         v0v2BlXB0q7zQ/UPwg/9+orZPAZwxmm3RHFPOnWLPf5TIcln4OiGgIoyWTl8Ijxapz8h
         PBWpjOhmWnNTpIp5buFcEuRxCKpbPAtN4Zm6cKIjSxxD92BuB60pNsvwj2czn+OsQ4s9
         KO7RwoGD+wfdxJ0UjeDCOnABZYC+uyncmjCakh7yx9VTodpvw8okf1ICGXZSw5vtktwZ
         o60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741728836; x=1742333636;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZJ28s51tBxYWxu34w0CzvB59LAgctctG+pggF1wkYE=;
        b=ZRfMl9iV9xwl59dnFCG7ZCWBK8c2Ria6JYb6CreV/i3PKLiznBtxKKHoUkdY6Othn4
         eEeV5JP0vhTCeJPOqsZMlHKPJC0dcPs/nEblSasfXOeTNIWvrLwQwsoCuyrT5MyruJUP
         8a24bNXiRTajXRZPYx6BbC4IwfQYrtgbMaxyPKn9ekAqU1ByspMtodEZ+hXwPCYc10+f
         +vgzh+Hlk3E7fZskY66QL5r2KST6ri+7mrjl9XGO+b44YROVH3DV2yLchJEMpS6WFgpk
         zl9FRfbVDlkaAhMJVAmPWrts4EXYwo51wlZbdcyTi77iMoynsOdLdqBf0HWHGGkpaVxo
         YrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqTYLbwNQjbWzF6Nw0de6/+1EP/0MpTS+eMOTlyPAh2TYscyuWDOQZSJVI5IgOBvl/eFuP0Ikns4yQNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQJPj1js7VBWHglZ+WyEMdtPdLheW+FZ0M6CWs6MY1XaQo62J
	WlHwH6WSTiUUtnwxG6Kp083lfNfoFRvIym+GUe5Bs/zgv0DXmY4TUv8Qpua8aVc=
X-Gm-Gg: ASbGncsIzcFZiEBVa13vZww0ijHOCxrGj7959kQxjFj6aavb6Po8eqIFBwzSlJPdp7g
	T+YGBPvmXnHY1xYuAGN9Jr2A8xpHFnkPXkqP4oVXv4BhrtPZpIJCBAVGzn87vOrwk0gXFNV/lFL
	DEJrYjIz0YxR61JBATWc7Bdq+UvfJyvXGzqiBRB3utzX4m6U0dq0GGs6NKzhon+UaUaAfd3Inc4
	p0h1UupnTXXb8CpEEN7MezJTUD92ypY+fhwB2g0j4OLyFyThyJu+yzzq2nsTpfpmsY4ygiQp9aP
	L2DqLBuQ5kNV8M64a8facsCQcUgHdJbdlzInowVxqZY0b7ynayhXfEIw/Jt4nFdf/42hbJ3B
X-Google-Smtp-Source: AGHT+IHCeeMW1z/x559dlW8prJY7oETbKnUkz/bXmMzj+tTLLhIloDaKAWxQboKfIdP5BfSzL9aASg==
X-Received: by 2002:a5d:6d8c:0:b0:391:952:c728 with SMTP id ffacd0b85a97d-39132d77544mr12633864f8f.4.1741728835925;
        Tue, 11 Mar 2025 14:33:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301191cb007sm69809a91.46.2025.03.11.14.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:33:55 -0700 (PDT)
Message-ID: <79b4dc8d-560a-462b-a664-16b109d6b0f6@suse.com>
Date: Wed, 12 Mar 2025 08:03:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: add slack space for mkfs --shrink
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <fbe3a75e21a89d8fb3013c55468de7fd03b5027e.1741651032.git.loemra.dev@gmail.com>
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
In-Reply-To: <fbe3a75e21a89d8fb3013c55468de7fd03b5027e.1741651032.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/11 10:40, Leo Martins 写道:
> This patch adds an optional argument to the 'mkfs --shrink' option
> allowing users to specify slack when shrinking the filesystem.
> Previously if you wanted to use --shrink and include extra space in the
> filesystem you would need to use btrfs resize, however, this requires
> mounting the filesystem which requires CAP_SYS_ADMIN.
> 
> The new syntax is:
> mkfs.btrfs --shrink[=SLACK SIZE]
> 
> Where [SLACK SIZE] is an optional argument specifying the desired
> slack size. If not provided, the default slack size is 0.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

David has already commented on the UI part, thus I'll only focus on the 
implementation details.

[..]
>   
>   int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
> -			 bool shrink_file_size)
> +			 bool shrink_file_size, u64 slack_size)
>   {
>   	u64 new_size;
>   	struct btrfs_device *device;
> @@ -1948,14 +1948,23 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
>   		return ret;
>   	}
>   
> +	device = list_entry(fs_info->fs_devices->devices.next,
> +			   struct btrfs_device, dev_list);
> +
> +	new_size += slack_size;
> +	if (new_size > device->total_bytes) {
> +		warning("fs size with slack: %llu (%s) is larger than device size: %llu (%s)\n"
> +			"         consider decreasing slack size or increasing device size",
> +			new_size, pretty_size(new_size), device->total_bytes,
> +			pretty_size(device->total_bytes));
> +	}
> +
>   	if (!IS_ALIGNED(new_size, fs_info->sectorsize)) {
>   		error("shrunk filesystem size %llu not aligned to %u",
>   				new_size, fs_info->sectorsize);
>   		return -EUCLEAN;
>   	}

If the slack value is not aligned to the fs block size (sector size) it 
will trigger the error here.
And since the new size is based on the older size with the slack, it's 
better to do an extra check on the slack_size itself, so that the end 
user will be properly notified if the unaligned value is introduced by 
the slack.

Thanks,
Qu

>   
> -	device = list_entry(fs_info->fs_devices->devices.next,
> -			   struct btrfs_device, dev_list);
>   	ret = set_device_size(fs_info, device, new_size);
>   	if (ret < 0)
>   		return ret;
> diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
> index b32fda5b..1eee3824 100644
> --- a/mkfs/rootdir.h
> +++ b/mkfs/rootdir.h
> @@ -52,6 +52,6 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *trans, const char *source_dir
>   u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
>   			u64 meta_profile, u64 data_profile);
>   int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
> -			 bool shrink_file_size);
> +			 bool shrink_file_size, u64 slack_size);
>   
>   #endif


