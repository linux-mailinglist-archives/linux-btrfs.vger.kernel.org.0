Return-Path: <linux-btrfs+bounces-14262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AAAC5CD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FB18842D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F06214A64;
	Tue, 27 May 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W9tlTRBP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B41F4CBE
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384226; cv=none; b=E3TURs/wX0aPTYaYwnl2OlvmOBBAy9gSz6zFCQW9zXiFcY7qdYg9t8L6zp7iJLy+2CpAHj9v4dsZ1Fxtmji1n2G/JszELmtxohxmnkwSMLobm4CWjr2oAl5tbp1Ul66WWthjvcrEPYQcomKpf8+xckMuRBwKEm6/xk1274FbUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384226; c=relaxed/simple;
	bh=h9L05fdHtzibmS+bex/Ag5VfXeXEfxDXYiojSqDM7ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DIk9yK1d/PgYwgp4UYqihOncjUeGvtaGIK4DOcrNWWopvsHumN7qLmEK3OdvgNzVRaO8sjwSzA0WnRIllM34OY2cOLs28RM+o83faZf1iaJ+CUHjIKlBlw8ck6XbwMgUS6Ik7ZcDRT+0Z6NF2A8rGb6Ghbp/XF9I09TEVAtWSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W9tlTRBP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf257158fso33515935e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748384222; x=1748989022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iCmAHzhYG+1rB+8zSdq4EBYzmPT0ML/CLbcsZb/VKHw=;
        b=W9tlTRBPQ9KXWEKLNfXShaFHNSxC6bUDU7ev+U7vhlJSld7pw6v2aTrP5ARAa/hm+S
         1rZpnyHoyedFF9NaElyMMA3KwRYjJaUgnJXfClD5ic1wSRU2PwOl5LGehUxUqc5lKAfT
         7IfpWh2lCbfRODSknEUumk98YHMpuwevT76MptVL2pIK1QkuhWk1wlMeioSwtdYsWANf
         Ux9Y9M8BT6wTMBpfSM8OeeL5W2704Fvg/pTUAONUH2jMhJdjbVsIXirkQn9ShmcXATVq
         z7Mpu4AmN6EShrui/Mm26TkELGQ9Cd9GYm5RDtMx6Bh8s9zX11S4hkpnxpY/PyinFxYR
         vENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748384222; x=1748989022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCmAHzhYG+1rB+8zSdq4EBYzmPT0ML/CLbcsZb/VKHw=;
        b=WLmqTHf/ai1EwLG19/flTotgNWG64s08p6mpYoZSVcvc4r2/eT22UwxWOAxMsuUi2L
         4voosr2SbTPA7KTMsfrkddeQNhTJqJ/nTM3nyk2sFqPm1EpQSixgQ7plfMxHKFaYj3rk
         8uOnNqMHOn6faaFh+SssWrQ/6SEHmFa80Oyf6Bd7BazHP1pQCotjnO9CAnDVZlwT+QJ8
         orC5wAAOzY/Vna1F5OuFoaLNut7hlUbUbGPhnussoc5tvdXHHlEMZ8pdD8byYkrmWGTV
         MhTAL02U5n2t6QH9s/x+ZXGnHHB9k0nq500mx/kvR1tBpJ/h3Vu3PHQJ3lygvoJ7NC9X
         xJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ibgmKK9UkzK7BiVLXr9nR403q5jQ2/3UOQoGrg36bBNwDwb5qhD5c3pqQGVjv9ZYT9ydjWMHRBpe8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEJVVBAzizxsEk7A3hahPa1PRhy1vVdBKXJ2llhipEOvkijkp
	7fYRPhXeMAhZAgC3ovv8AmK7VZSOZlHietqAv6GcP2EicOPgW5coQLb0/Yz4Uf4xCb5D7t7jbjA
	4InN+
X-Gm-Gg: ASbGncuPB3BOEEnTy9OXZ6n5yZi3YP74BHgR9YWIKHvA7As37dbsAwt/0XlvTyYxrS4
	sKKGXaYgj9RLyfHPCl1mf69zIKtTSvsTIO6pIz0+CFvAD0t5v3E5iX1GRYSbL4IlrmTsKubh4VX
	cfp8n6anFFTlPNpoNLLg0AgF3e6XLMbQ9Ew6Jtp6Pe9PCqkxriVqWHWxqN+58YkvW+V5oO3HPR4
	6fZqDKrfo3p+CjmC7w4pLwPKRZ9cxWJSviqMFvJPsVKsWk5EbI6PQltIGRrro+r2fts7/NOk694
	aOIZfqOhVSryYkpTmawmFnXOviB/k4AFEaYjqiQUCprmIlit1Zv6Y/eH5oZwz3kxt7JGx1Q6xcq
	H+LbhtS/ruQyXmg==
X-Google-Smtp-Source: AGHT+IFjuJu/I3DUKBQGmgP6VLqBZNOlow7ll6NT+XtXQ7G0pvEn8ZWjCM3E27U/mM1VMiioYqZCBw==
X-Received: by 2002:a05:6000:430b:b0:3a4:d13b:4aaa with SMTP id ffacd0b85a97d-3a4d13b4c6emr10660017f8f.5.1748384222347;
        Tue, 27 May 2025 15:17:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc25f4ddsm722665ad.251.2025.05.27.15.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 15:17:01 -0700 (PDT)
Message-ID: <7bf0af35-45a8-4395-acec-4a98a2fbfaef@suse.com>
Date: Wed, 28 May 2025 07:46:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: warn if leaking delayed_nodes
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1748373059.git.loemra.dev@gmail.com>
 <023ae97cf64384f4187ff03d54f03830e904df39.1748373059.git.loemra.dev@gmail.com>
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
In-Reply-To: <023ae97cf64384f4187ff03d54f03830e904df39.1748373059.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/28 04:58, Leo Martins 写道:
> Add a warning for leaked delayed_nodes when putting a root. We currently do this
> for inodes, but not delayed_nodes.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1beb9458f622..3def93016963 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1835,6 +1835,8 @@ void btrfs_put_root(struct btrfs_root *root)
>   	if (refcount_dec_and_test(&root->refs)) {
>   		if (WARN_ON(!xa_empty(&root->inodes)))
>   			xa_destroy(&root->inodes);
> +		if (WARN_ON(!xa_empty(&root->delayed_nodes)))
> +			xa_destroy(&root->delayed_nodes);
>   		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
>   		if (root->anon_dev)
>   			free_anon_bdev(root->anon_dev)

