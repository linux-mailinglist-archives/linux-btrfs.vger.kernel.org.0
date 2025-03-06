Return-Path: <linux-btrfs+bounces-12069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B885A5592F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 22:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF5B3A663E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B753277017;
	Thu,  6 Mar 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aQD5duth"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E2DDA8
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298185; cv=none; b=ENx0bRNgtHF23gCOMNEk9TYLM6p20Y+gD8nhvOE+MkBp44/dOiFNXNz1EO3cPwbSOAgnreheh6AyH5ER8aiYAiJMpqK74b7oVUGVsZ4oL0cQl1HIDa602FPHYSvVr3RHuwgn+XoEutoT6X8s9Ns0NMHV7bbyOueKBT5r7E4L2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298185; c=relaxed/simple;
	bh=KaBAT0PwXbX3nJKccCd0TkomAzwxGCzQyy3r13iI6dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=omlmq0HXt6/wNLoM/MMfttJNcePlcY2eRB9+1b/ln7+d4zL7KgtoYDRsgSFiLM01TjDv6OjFnEBWw/5SkPr1OPjaxO9aMb8CDQwDSExuqyIBmpGBnGqqveSfosFscj/f9z3mCJrfGDftkIr4xYC0p7OT4HNY4KD/T/X6WWdtGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aQD5duth; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so7349555e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 13:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741298182; x=1741902982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lAxtT5+7R7QDzuDKFuybeGq6UqOHKEA5uMAluYAM+jw=;
        b=aQD5duthnMm7zASZ6oRhJLYaD2yFD56nBzzUSE/0WLIeiZ+6siOui5sLhAGorLr9/n
         PlYnuFQYZQk1UJ2MZf9ybYOz66pJNoE1iQZOtXFgu1cRfCgdNF7zMyfbmAKHa4nlqFmM
         JUsBXPlKxSq/jHud2m1TchE2F/KS5d6NBw24L6lywYgsmQx20CFcY/pAs8PvbayRV4sj
         5oZz9drKeJCOncjhFhhzviC+44bRwJ0FDfMbHITaBoByZ/oZ5wLHFXIX+H9Ss3fyzVOc
         zSeb/lEMlP25vzlZW4JTkrmFcyuhurk9g7Knx5erujjKrs0OofM5H/MbcncNvH3PWoM/
         T4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298182; x=1741902982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAxtT5+7R7QDzuDKFuybeGq6UqOHKEA5uMAluYAM+jw=;
        b=h6POFSkfEfu6sWmD6El+83L7llwetpSNTZrYXzqE0SGeFTic8pLGPurQsrPrRwwxzo
         abu6NaVTjm4qd1nfwQmv6jtgI9CJUF5lNRhjPrDb2oK5ceta4S2mRG2H2CQ1BL3jy7ac
         YLX2zrxnaZ7sNGdqoLD0U6lgIYDrpXT7TzT3iIXn0KhNQi6YdbP9Cr0JsFaxVSA+H/50
         PqipKk4uayr99M/6aubvAI5zTQ/uY+Gyyz6JwfzHiRURvJXgVfSlHjcN7SO6yqwC5Dgp
         8UKuX8RKdEhVLnqYS+RbSGuXh4vgC1TU0tBIMDudOu19PUoFiDtzPMm3zmF/fm3CppWV
         ra/A==
X-Forwarded-Encrypted: i=1; AJvYcCWi2Q3elUytU6t6lojLz8Hf7DgAbgahFsIvCRASyEkyTHeZlFA2uTUahMO0vl0EEr3N8fr3eAnFLMBdLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyalJ8nhcORkU7Vi+TAkBW0udBhOLhPEzmdnoTzY7EqkdShy5iy
	s/Kwdoej6Lc+bWJLsQCZd+eSM8XqthOdBbOgvfs/YLt8SI5ZQjL4FhAkqdyH/i8=
X-Gm-Gg: ASbGncu064MCraZg5cDiKoDAl6a3S5hN/4hnh9Eg1DYbKcjVoR9DMTsIEbv2FbHcqlt
	HmZWjDKtOEuNPEzSZff8bS5CqJOR01L5/8xAo4qgcF9HgqaiP56s7BYOJHOVr3Y/plGukGqCIXj
	Jwe3SRRIxlvK6DHFi0e2ZSSWUCtlT2ZoGxEZBzgoHerGZ5JLGmnIqlUIn/0TMLn8YZbT1TOaCmM
	3NG+q0ULMb/QblopTfFvZNH8VWhsAHiadHFtd/yWE8UECoRoSFEYmOzieBbQCQXTra/Lzt3xM9K
	/zqhCC4a3aPiCy8TrfJn/8qdj8BIUjDQXaJpOsl+swD18Me00PXXz70v9/RCXPjXfKh6A7E1
X-Google-Smtp-Source: AGHT+IFr2OmHrNeYR0uwvkseHZPXrVkbVXdMpxTarmKKTwqNidzkz1P0wQjfwB4KiB0m+OhnahwQ4Q==
X-Received: by 2002:a5d:47cc:0:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-39132db0648mr559265f8f.45.1741298181628;
        Thu, 06 Mar 2025 13:56:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f6f53sm1922980b3a.99.2025.03.06.13.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:56:21 -0800 (PST)
Message-ID: <3a6878d6-d0e1-4e5c-8e11-d64967ae65b2@suse.com>
Date: Fri, 7 Mar 2025 08:26:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid linker error in
 btrfs_find_create_tree_block()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20250306105900.1961011-1-maharmstone@fb.com>
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
In-Reply-To: <20250306105900.1961011-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/6 21:28, Mark Harmstone 写道:
> The inline function btrfs_is_testing() is hardcoded to return 0 if
> CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set. Currently we're relying on
> the compiler optimizing out the call to alloc_test_extent_buffer() in
> btrfs_find_create_tree_block(), as it's not been defined (it's behind an
>   #ifdef).
> 
> Add a stub version of alloc_test_extent_buffer() to avoid linker errors
> on non-standard optimization levels. This problem was seen on GCC 14
> with -O0.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fad42da1a6ba..03320f953817 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2984,10 +2984,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
>   	return eb;
>   }
>   
> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>   					u64 start)
>   {
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   	struct extent_buffer *eb, *exists = NULL;
>   	int ret;
>   
> @@ -3023,8 +3023,14 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>   free_eb:
>   	btrfs_release_extent_buffer(eb);
>   	return exists;
> -}
> +#else
> +	/*
> +	 * stub to avoid linker error when compiled with optimizations
> +	 * turned off
> +	 */
> +	return NULL;
>   #endif
> +}
>   
>   static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
>   						struct folio *folio)


