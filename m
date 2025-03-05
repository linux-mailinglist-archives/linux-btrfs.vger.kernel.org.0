Return-Path: <linux-btrfs+bounces-12038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75BA50F00
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1555B188F947
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DC2080DD;
	Wed,  5 Mar 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fu/FPmCH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C8206F3F
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214806; cv=none; b=rnbfW7rfXXbmnh5OW5U/zG6wy4d6JQ8lTAcjd1NZoF4cMTUdairnYFwL0G9NwzZB6BfP66rj76GWyUau7Sa1qTVw9fBmGSBP0EoTqQVC/OB65O2+c0nvvRNVA2Xsux8yTR2/GWlBSIlFQJuPvm53aey7d1+8Rvwzi8U7KKqbMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214806; c=relaxed/simple;
	bh=EryyDIGQKpUUi32jWOTUyMyUoBfJ1nppb6UlC9F0R24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jnhvsaxFWfZlPkuh237/r9cfLvL/rwFwGrE+PqRbmqlZE5lfKFijEPmPjpK5COZmVAKeKG5PUTPexq8xfTniK75a97+pmfg0YZAmRTpyMinaYrrnEwQc85hBouEehakVEZDMzVIgbs9xPU+2mntmkfYkPcW6xLad6jJRaarpH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fu/FPmCH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf5358984bso5853766b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741214802; x=1741819602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qWyAsg3bCbF3zmd9Amc+kdpCSKOlcstBgJMaZxcstLY=;
        b=Fu/FPmCHjkY6c6Z03a0g7xq7X3I7zTKiX8+2cZPvIz9mG1EaBfmKFqzR+j+yuP16fW
         w7bNkSKdkJrKQw0Ah3ofao1f5WwDSmVtcKmF3oz3lofTNe1x7WRWgAafOWVW56Y89HUj
         6kVvxYdKYzCMudD1K5iwKv9FMbGoQTZXpnxSeUBE+G570cAzN2g0Dc3Cvw7qD50e0ATd
         h2lDOgaphVWslybHHwTZipJ1UCMJ6qn/4btJnZN2kewFioDVsjfjFpPxuu9AIO+a+7ME
         qyn5YTqFKBSrIytAhBhIMAL3omf5OkE+waRE6iY5gyeok91LPQgFs/x07LnVoROTpyqn
         3x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741214802; x=1741819602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWyAsg3bCbF3zmd9Amc+kdpCSKOlcstBgJMaZxcstLY=;
        b=WS3GkB7NjMZf6+b2czLC1isMDqKXAeOrHrX+6b028dhGruh7/k5r8mNDA0cuvJMzAr
         Cq4OS96bFCqcUq7729Yl/tttL71BqdH+utETD3x66DVlRlRfNwgmKzkTc6VAFDU2z+Am
         NlTwkNSjUrZaXftyDsHJOdy9I6J7kcFraGUQaGI8dJhvfGD/llIXufaT2Sf6nQFXqEtH
         8QB3gBB0r5zU2G5XCKS145mpHc3Qdxa8b19GlZK6fI6TgQlriXra7SiFKVfy6+nYU6cv
         dBaOvKWXIpWOitx8mz3b5hBrhLP9hozl9IxRXxCop0TDH5jZCGQWW6Q2CoByKmoRN4li
         jwKA==
X-Forwarded-Encrypted: i=1; AJvYcCVTuaglwgOgf2TmInvzdgG3DilbWHSNxDnL6Muatp7xSVpk8W7XqH5kcIS6S9jk1B3m3fsJPwknIwKadg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8VYbCrbS2cepQVwQwJvFBFJiusP3+a/5F+fvTYpHqcpuVEVS
	ubxfopfiJMnDBjSHx6RyjBO4eJrGdNI/gNeH2e5UKzNsPzSjKvvvds+b+zo7Gv0ZXdRcPuW0Eza
	/
X-Gm-Gg: ASbGncuQqqh+V2w0U2HzJ7QnbV6eyPp2jftL8Gpmi371JK7nLPS0roXKa2hUqmf8V2Z
	gau5zw6nKUI8FoJI+gBrsQB8wRvzCDq3DYWOtHJudtZMugmmBTmKvgwOD1xNckxn72bYBGTWjlk
	gMV5uxSlXbII2eALfH9bXIhxrP6zkqHGrkK17r+aI9piXf5eAIWzsTSLesTzlPKDOFPSaz+mitx
	7SXerLcTSt/36wcmfZtuJ1ZmT/RC3F3FTw5NUQ9752EV1OvRpA8Rggjc7dGTfg8kx82Yd8CBk5Q
	eb4H7eFNmmDV86pfNFgXJwY4oWILskadebTXVPMtQei5f3N1WVcj1RVlJx6BSPyVHRxQV6qB
X-Google-Smtp-Source: AGHT+IH21PxuOLjfAYKLuLrF8H98vT9sHoEoc0cXJP8neXEPyWyHqkqxG/iwI19GL5A3Fx5fengMMg==
X-Received: by 2002:a17:907:6d15:b0:abb:ac56:fcf8 with SMTP id a640c23a62f3a-ac20db195e3mr551981366b.57.1741214802048;
        Wed, 05 Mar 2025 14:46:42 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc3b7sm118809575ad.173.2025.03.05.14.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 14:46:41 -0800 (PST)
Message-ID: <74baca21-ea92-46f1-a85a-d5834eeaa430@suse.com>
Date: Thu, 6 Mar 2025 09:16:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: fix non-empty delayed iputs list on unmount
 due to endio workers
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1741198394.git.fdmanana@suse.com>
 <e1cf2949e4b03fba268f923947543bbf4a7b6752.1741198394.git.fdmanana@suse.com>
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
In-Reply-To: <e1cf2949e4b03fba268f923947543bbf4a7b6752.1741198394.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/6 04:47, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At close_ctree() after we have ran delayed iputs either through explicitly
> calling btrfs_run_delayed_iputs() or later during the call to
> btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
> delayed iputs list is empty.
> 
> Sometimes this assertion may fail because delayed iputs may have been
> added to the list after we last ran delayed iputs, and this happens due
> to workers in the endio_workers workqueue still running. These workers can
> do a final put on an ordered extent attached to a data bio, which results
> in adding a delayed iput. This is done at btrfs_bio_end_io() and its
> helper __btrfs_bio_end_io().

But the endio_workers workqueue is only utilized by data READ 
operations, in function btrfs_end_io_wq(), which is called in 
btrfs_simple_end_io().

Furthermore, for the endio_workers workqueue, for data inodes it only 
handles btrfs_check_read_bio(), which shouldn't generate ordered extent 
either.

Did I miss something here?

Thanks,
Qu

> 
> Fix this by flushing the endio_workers workqueue before running delayed
> iputs at close_ctree().
> 
> David reported this when running generic/648.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: ec63b84d4611 ("btrfs: add an ordered_extent pointer to struct btrfs_bio")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/disk-io.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d96ea974ef73..b6194ae97361 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4340,6 +4340,15 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>   	 */
>   	btrfs_flush_workqueue(fs_info->delalloc_workers);
>   
> +	/*
> +	 * We can also have ordered extents getting their last reference dropped
> +	 * from the endio_workers workqueue because for data bios we keep a
> +	 * reference on an ordered extent which gets dropped when running
> +	 * btrfs_bio_end_io() in that workqueue, and that final drop results in
> +	 * adding a delayed iput for the inode.
> +	 */
> +	flush_workqueue(fs_info->endio_workers);
> +
>   	/*
>   	 * After we parked the cleaner kthread, ordered extents may have
>   	 * completed and created new delayed iputs. If one of the async reclaim


