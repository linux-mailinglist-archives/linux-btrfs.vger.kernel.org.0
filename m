Return-Path: <linux-btrfs+bounces-16810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CD8B57095
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F33817BA30
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B0296BC2;
	Mon, 15 Sep 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="anwNU49S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E14291C11
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918721; cv=none; b=Oi42tvXDtrS5i4QQf4LcVQtpZI+Ord1+OOrAz8JbU+C8ekMWMibq0x7SqEHI6gK/Bsh6gEbjgZuIIwT6k6N4xe59CiTJsvBQya4xFUAJPm6G72wxdJqqEtFYOEOGbKIpWqf8nt82FGYv33DBTLi8DaNBxyVSIlhiGRCsb1ctp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918721; c=relaxed/simple;
	bh=LvFk1LzBJh06hmmcANLqkfGuGwkBBzaSVMSfwZdHnLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qk5CtsKz/HqcdDM2g5fx0VzRjZWF7Ny1yVlY4WPUSpegPBRLKARWqnycXkhEz35qqEauz3sfly9mPpTG2FjGRo7fuXJbsYcXEdmd7J6Fn4ZDWjCk7rwvAo8/ZDyehzSop3ACckd1csPKZbQux5ambBUQCYlEWmqBpXYsnas05S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=anwNU49S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e9ca387425so792342f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757918716; x=1758523516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5eMZfBGrfYCq3Qw8i6SLc+IYf1iS0lZa0W2gU7pY3g=;
        b=anwNU49Sa1GogucoqCZ8sxHlDPwpQZEuK46JrjrSL6tA66H7MWqjZMo0peyJBWsKEf
         5khAyyfWBf5MXUvPBn++KsDxkpSJWjA2P62PQ1opeWcJSVJykZm+qqOOGUJ/ogh9u6WQ
         l7UvAXomjG7C85gwV/DdQm0RH3F6JEvdXlnBSsGCVS8ghcm4+f52q4iHcOM/xwBWUQZB
         71iaWf2nZ9CoGJPMU4UxfBum1LAARkznYPucPSAKbuPdrOrBMDyXZbBbSENZ8Dx995mS
         NlLCf5Ywg75qP4UCo4FSND+53m3va7hMSjoKW4McEu77ZyC7Yql01yPFyD+4cCqLLq9Q
         wPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757918716; x=1758523516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5eMZfBGrfYCq3Qw8i6SLc+IYf1iS0lZa0W2gU7pY3g=;
        b=JG/BYTa4ThsmIAfMb8r+SLwur5tIGa4f4u/0fGT2dxUXpd6fCIyDFSjtYWdLh7PwM8
         amw7NPRUqTzCBrHMp0vyuB7y0uxMsK2kZQ4rY1PfrocxBxKYV+abDD/eLrBFkGiYhHJw
         lwgZzdqINs6Sfn/KxQoOnW0GCBpYDbTrxb3BDNMk3cYrzwMOEMsV+xkFD00MMIaC8Qif
         DobtFPxLpguax02aKz5DEe2Ay7SHKWavrddiNMIO1ruEM3nkIiecblS60gEB1+lbkf3H
         DLwQeOvAgtd/TzLLi9b7VoIVudr3LmV6wo1bo/vCrFBQxLqQVkG+XU8fRSOi3zwzcCFM
         zC2w==
X-Forwarded-Encrypted: i=1; AJvYcCVjtadGCNW5ZS0xPtGppJoU5vnHbJo5pfGRFg0rQF/6smgp2qsExAXtV7ycwgeJFmv8zgT5OFHgOw6OLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjTDn5LfqrwAJuHCrQsZ4wUepzSsAHzzw0mBm8nbFUXhouQem
	FQouYjg+Rpr/wtgYjircLa5Dnx4gTMGIaN75HqlrhiWkFjaDb/7wiWlmwzn2OWepRlI=
X-Gm-Gg: ASbGncv4D7g8XWe8Gu6nUSWbfLJT03Qc7a7MmxE6B0e4jPO2HNZ3wzRpIKgeY9vu8R2
	p3g5fIZw2Q4aVk4QaRcBbZfk50+V0n0jXbkyXouVqZ79Q2myym5EgOcvELQX+TDs0fl7HujsOK6
	AWy+wU231M4XZpwB3YAb+0oJAbL50I+TlfABZmEsOAO3YvsO+XrW0EDoF65KgRfzIx3zNDTVzjD
	0vkRjfRzMcp8aGu4VUc0y1sPPhEqKkuPDReaGQpheKzNk2DKT++cWFq5XfsSf6P/eF2s8ACrGQ4
	HjPtD47h26/xwdZ/DaIhtxsHD7hPF3JyGMLQVXB3srABhbqqgvEuf4jZpBw1u01xpPa9cfEkyFw
	pl6o9+yCBGAwLG/meiD2+Ac00j95dY5XroCN4v7Ot2VDWH8GrpRw9hNFKdL4rDg==
X-Google-Smtp-Source: AGHT+IGaJV39gA55pXixktc35ihLxDxCz7sHzyNwmoXx56Zo7WtWlpSd0v2lwd1dIL2++Etodjtlmw==
X-Received: by 2002:a5d:5f42:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-3e800683aeemr8432105f8f.60.1757918716559;
        Sun, 14 Sep 2025 23:45:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760955263fsm11836510b3a.8.2025.09.14.23.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:45:16 -0700 (PDT)
Message-ID: <28333ccd-f268-4a51-a943-557e607647a8@suse.com>
Date: Mon, 15 Sep 2025 16:15:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: ref-verify: handle damaged extent root tree
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
References: <20250915063747.39796-1-dsterba@suse.com>
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
In-Reply-To: <20250915063747.39796-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/15 16:07, David Sterba 写道:
> Syzbot hits a problem with enabled ref-verify, ignorebadroots and a
> fuzzed/damaged extent tree. There's no fallback option like in other
> places that can deal with it so disable the whole ref-verify as it is
> just a debugging feature.
> 
> Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com

Maybe a Link: tag to the original report?

> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/ref-verify.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 3871c3a6c743b5..9f1858b42c0e21 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -980,11 +980,18 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
>   	if (!btrfs_test_opt(fs_info, REF_VERIFY))
>   		return 0;
>   
> +	extent_root = btrfs_extent_root(fs_info, 0);
> +	/* If the extent tree is damaged we cannot ignore it (IGNOREBADROOTS). */
> +	if (IS_ERR(extent_root)) {
> +		btrfs_warn(fs_info, "ref-verify: extent tree not available, disabling");
> +		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
> +		return 0;
> +	}
> +
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
>   
> -	extent_root = btrfs_extent_root(fs_info, 0);
>   	eb = btrfs_read_lock_root_node(extent_root);
>   	level = btrfs_header_level(eb);
>   	path->nodes[level] = eb;


