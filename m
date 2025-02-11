Return-Path: <linux-btrfs+bounces-11370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48186A301CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 03:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3B83AA611
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 02:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3781D5CD9;
	Tue, 11 Feb 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UN4H/10E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642351D5CC1
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242470; cv=none; b=qKlSkKCxqYuqWxsgHMhrVYlJNuqYL2bMfkw0XDWSOnQjaqkTul/Nps7H6ywvuKSZzeAVhoyiTpegoduxPxL+EFtHyQ5eqPKktVLgcPHfXi6WLuVnNMxJ9H1ChVZcVguICfetzY7q5lsFMpummQprpwrPykHElMUqlnnYppglLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242470; c=relaxed/simple;
	bh=A35mwX0xmApyTckdaVPRFouOTdjJ0I47jjYdLnwlY3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q+ato7gMLrYmOJi8QUZQABPRzQb6o5wXLRTaok0FftuIaeiSUT6wBS9ahQK0X2q8n2/6uOMhkNacDRA4Fqt7kuuzr3Z5m97kcA9W385wcB5BPQBVGxMPlL9aHyIeNFfG1m+YUmWcfOVFM2h5VMygN+gMgPrW47bNMrX6C5Tj23E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UN4H/10E; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso27382125e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 18:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739242465; x=1739847265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p3gJvqMVjD3rnqzqVRiv3/39D8eS543ZhuJjfn62DnE=;
        b=UN4H/10ELrjvcttff9DlgttCvukldIDDUqlXNfuhfUYIiX3gMQoo/PGPkNOF2/2b4d
         wSZUWULQ+fPsfDPqoK+EYM9SzvKmFwEs/frcxkk5aHqitPQfkNhnwVGQvGQ9M3pzP8Xx
         jQGRlRjadO1RL0Shr1Xk1oiw+Ri0jxiI5j+FPNHaQHaQQ228pp5mrNfALLMsShHIAJtr
         0tmwFqvB/asQLZn4b59NbWWnP+aexA1HIpTFWMMAOkH0gb4afprvRqrk5NgVoB/vmuvI
         sqf47Bh8NH2d7wx1lHjTuGJXO1ROwTDr9eh9+SYsdRkKrJu6j9Kk9fW3X6MK0lvRlu4I
         T51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242465; x=1739847265;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3gJvqMVjD3rnqzqVRiv3/39D8eS543ZhuJjfn62DnE=;
        b=Ue4sYEnNEeTUOP0Wuz+Q9eH966sVdXI70qbOnEm2dKpQRfPjSrLAANn2yQmy0Zl82t
         M5yMDIbtMI32XRhgA4bfpLoM3PSrUWBd/1+/gQP8KiJa/4Hc07hEjQiwEmHmKBiafd9w
         sePIetO5qqqlDwiqM+d2vvGRpl58RLDMpr3xV06fubm5rD9unLigWFLCZyOZr7DYwqm5
         qz/drsgbDv8MyTMR3U6F465DVLxOVPmyNsFzkcGEsGWwSPkfRCbCAD8BvCKlDoNlFO/f
         uSawc0vx2dWBrTK2R3PCoBQ7OIXnZRnBSb++4NSyal5l23aPKJGK12GoWRLEj/n3aFXS
         Js2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2N4upI2wDC5HB68bmstGMaBfEHFMuogXOuP2+y2ENKtbZhLSYtooPFO+l7uj4CghxTPsggm1aOY5U2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJshh9GOsngW2zHWx6oXZLfwGM/C2kqs+UfDnCFfJRZ6b5tAh
	1gys18C14Cv5hr6KQNGWRvCN3VexoywnrQvRiFTY6CDyFa5yJVaKhX70d7VD7n4=
X-Gm-Gg: ASbGnct8pOm8d815v0cGyHU25z6kzzTiJoKTupBa1QgP8ueqFFNBkaBAJurM592JN6j
	GQjDi+P1AwubKmYoCIqpQihQvQW8wMxHD407MeLbdgA4W9C4ABf9MRNbWuDsP2ByMdvF1Nw2RNb
	/HkzDNWAOKOItTfBg4zWk4cEHgYED2J2UTVat0ShQGkxDd6p7jsW6BhMguKYC/Zn7LOyo6C3tKT
	6qrcrew3EqCgE8XBfe+ZfgtN0fiDsq5kIHXlKba+9Dk97ftrFGdWlTlfNYyoVC/DsCUtPKhq1/e
	GReH5ausL2ca2BpcLXDujKHjRp7+jZhhyo4zKv/Wbkk=
X-Google-Smtp-Source: AGHT+IE+Mc9UW2BQbC/HnN9c0oO4wjAO1rilRPsWpjHj1NR/UZHMpqEG0wWvHLOruxQ1TzPDfsv6dQ==
X-Received: by 2002:a5d:64e4:0:b0:38d:d2ea:9579 with SMTP id ffacd0b85a97d-38dd2ea96fbmr9046173f8f.46.1739242465365;
        Mon, 10 Feb 2025 18:54:25 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ec92sm84915675ad.17.2025.02.10.18.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 18:54:24 -0800 (PST)
Message-ID: <61aedc2d-9629-47b0-bb78-29af0cf64162@suse.com>
Date: Tue, 11 Feb 2025 13:24:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix btrfs_test_delayed_refs leak
To: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
References: <20250210111728.32320-2-ddiss@suse.de>
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
In-Reply-To: <20250210111728.32320-2-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/10 21:47, David Disseldorp 写道:
> The btrfs_transaction struct leaks, which can cause sporadic xfstests
> failures when kmemleak checking is enabled:
> 
> kmemleak: 5 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>> cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88810fdc6c00 (size 512):
>    comm "modprobe", pid 203, jiffies 4294892552
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 6736050f):
>      __kmalloc_cache_noprof+0x133/0x2c0
>      btrfs_test_delayed_refs+0x6f/0xbb0 [btrfs]
>      btrfs_run_sanity_tests.cold+0x91/0xf9 [btrfs]
>      0xffffffffa02fd055
>      do_one_initcall+0x49/0x1c0
>      do_init_module+0x5b/0x1f0
>      init_module_from_file+0x70/0x90
>      idempotent_init_module+0xe8/0x2c0
>      __x64_sys_finit_module+0x6b/0xd0
>      do_syscall_64+0x54/0x110
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The transaction struct was initially stack-allocated but switched to
> heap following frame size compiler warnings.
> 
> Fixes: 2b34879d97e27 ("btrfs: selftests: add delayed ref self test cases")
> Link: https://lore.kernel.org/all/20241206195100.GM31418@twin.jikos.cz/
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tests/delayed-refs-tests.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
> index 6558508c2ddf5..265370e79a546 100644
> --- a/fs/btrfs/tests/delayed-refs-tests.c
> +++ b/fs/btrfs/tests/delayed-refs-tests.c
> @@ -1009,6 +1009,7 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
>   	if (!ret)
>   		ret = select_delayed_refs_test(&trans);
>   
> +	kfree(transaction);
>   out_free_fs_info:
>   	btrfs_free_dummy_fs_info(fs_info);
>   	return ret;


