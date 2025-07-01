Return-Path: <linux-btrfs+bounces-15183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5ACAF0664
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 00:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67ED41C03006
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B560266560;
	Tue,  1 Jul 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QH+vkU7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46A1F582F
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408123; cv=none; b=Pxnf/GWEF/8z5gyuLi2XXlvtzIgpNcYyOw3ffBE3upWgicLpbWF+ym76ZnA4qgEsCU8VwbgWrK2L/ewSI1J2qTItaR7cchndIE7hbdffdXDb6RF7SGqp63Ba8BnbuZTbgykTY0TClq/C1ytb+oW6/fz7Bob+OcG8pcdcuHKzn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408123; c=relaxed/simple;
	bh=DRVqv2lQjK1D1unDqM6z60jBcYs3L/C7SokT4UH7tEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mgQt/DAQyiz8LfG8Bo5Vse5r49AEdofgxTlJPy7fNDVKE0m3zCfC+T44E42bqPSFV08eZgLCXOLjYDor82YB6mH3o7vg11uXCetGoDb7bZN7er33DP/92UuC1HTtFwpGlpv/NfC1AGfvbQ0BiIX+b3NrbltaN9dbnEPfV1zKkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QH+vkU7C; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3566594f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751408120; x=1752012920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=syqm6ITLtCEi6Eo8lmhpWhzIccESJTkMNohSfe3Csug=;
        b=QH+vkU7CYydaL8ZpdJ7GsNJ15Qe2KGaMoa/FVjsg3SaKTixVtNOxZuv8NkIOTma0+Q
         oopZHinTRbvRwgQ56nhQnpjdxHgAvGJE0v9MVrevhHf6rMClQWkppXCZUXb+JhCodR1d
         4HvoZA3W39Xu5OUkfgL/WQ4ee4238LCvzbwOOyJAAZyHTU+H37ruGGoBOknWn/EvJ+09
         llepJxCAEr4IMKD1XT8IrNb0igA6zCqFaGWOFBizBYMZE0WmBSpJCkprVdpjmnVYWFwL
         tVJqR7E0xWyxvb40ma2znkphAlWuCyMOTnFVPz+PseZXnbRTTqQ3IbYzrGwS6GpZtx4r
         LHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408120; x=1752012920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syqm6ITLtCEi6Eo8lmhpWhzIccESJTkMNohSfe3Csug=;
        b=kyioYinhQHAGi1BdvJOFjuUnteoJhxm/jGLhQduz6p4aEUjY7grSbw0Y7i8j127UMo
         BfbumJo4sHujWlrg9fbqanIhxub/WgHwQ9MZCrjGU/4cw4w2BDLJxmdevdCY0IvdX/Uz
         5HbCsuRP3g56LNO3vh/UDUXdjgByToyMImABLI8E0r9AbYO+Gxqad1QIydhV2hFD98oG
         JIbWgo9ffn/Je+dYpaE0GA/N1OEXrTz72KcJWxE+X1oxMcOK/762Tq5133GwI6AygD6g
         O7FD19jtKvNv6Qj1sJOu+lpcWkqlidL8Wh4axuiqs55qqXibfWQZwpWhr+6bib+wDQ7N
         QMJg==
X-Forwarded-Encrypted: i=1; AJvYcCU4MZ3GoVLqHVdCaOfygfnYHJCOQnen50PkZsIGoJw7GJL4fPtaJe4AdOleptcsap7iivxBgJT/qmtkaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpYn2E7ybuvHekp0GbjxuKirIqztqYCG1BR38le8fsll9/lqQ
	wRLDT6jtY7WIN+Hfvd7/BjAL6w05gwoYAGxgQDaGLclBXf4k/spoF52LcQr+a+ge92U=
X-Gm-Gg: ASbGncuz3yyODCeUr7N+ty35gjteJkMYCSp+5dUvfndnxx+36cobjWU2ZyZ8OBQ6nfq
	MD1Wf+sVivxDVmK7MMQxZhsZit/M7vpKprB/AE7Fv1gcy24YR8q209WynQEO++Xt3RF3kzOd2FF
	yCk5GywdSokzT1lL/J7AYRoBD3SfULtIcD7O7USCLCf87v6IQasonwrqrwj1hF3DK57Rpo3GLuT
	jBzHO4+n8j9ZCj334A1kdVHW13lAo19elHaQkqzymvAa5WhG9SmatzT+zqYoymQ0faUk6iCR8R3
	vgelKGYFpPvIZAK1Sp+ip1t72o2tTUje2FJ0ZSIiTmke9BfMpfJN8WX3Wf8DL+O+oZRuy0s4BSu
	Bz8DDL8npE6+RiQ==
X-Google-Smtp-Source: AGHT+IH2cfsCAgiIzKOuq9PILqoIDlkxV2rGjWRCpnQ3umY01CeQ2q6ufUfcyiPh3LS2rRXnBLd0wg==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b1fdc20542mr167073f8f.5.1751408119710;
        Tue, 01 Jul 2025 15:15:19 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5579d28sm12254890b3a.107.2025.07.01.15.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 15:15:18 -0700 (PDT)
Message-ID: <4d56c88c-695b-4fba-9baa-50fa3ec61a6d@suse.com>
Date: Wed, 2 Jul 2025 07:45:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: qgroup: set quota enabled bit if quota disable
 fails flushing reservations
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1751383079.git.fdmanana@suse.com>
 <6f75859e2d0736e332a568d0babf05abc4ec46ed.1751383079.git.fdmanana@suse.com>
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
In-Reply-To: <6f75859e2d0736e332a568d0babf05abc4ec46ed.1751383079.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/2 01:12, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Before waiting for the rescan worker to finish and flushing reservations,
> we clear the BTRFS_FS_QUOTA_ENABLED flag from fs_info. If we fail flushing
> reservations we leave with the flag not set which is not correct since
> quotas are still enabled - we must set back the flag on error paths, such
> as when we fail to start a transaction, except for error paths that abort
> a transaction. The reservation flushing happens very early before we do
> any operation that actually disables quotas and before we start a
> transaction, so set back BTRFS_FS_QUOTA_ENABLED if it fails.
> 
> Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I initially thought it will be a little racy when setting/clearing the 
ENABLED flag without qgroup_ioctl_mutex, but since we're already holding 
subvol_sem() for both enable and disable, it should be fine.

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 42d3cfb84318..eb1bb57dee7d 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1334,11 +1334,14 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
>   
>   	/*
>   	 * We have nothing held here and no trans handle, just return the error
> -	 * if there is one.
> +	 * if there is one and set back the quota enabled bit since we didn't
> +	 * actually disable quotas.
>   	 */
>   	ret = flush_reservations(fs_info);
> -	if (ret)
> +	if (ret) {
> +		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
>   		return ret;
> +	}
>   
>   	/*
>   	 * 1 For the root item


