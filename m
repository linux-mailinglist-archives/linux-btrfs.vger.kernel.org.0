Return-Path: <linux-btrfs+bounces-19676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161FECB7631
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 00:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A0E30145B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F762C237F;
	Thu, 11 Dec 2025 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AGEER5FT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F159260569
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495676; cv=none; b=X2G6CB6QsCrc6sod3pFlx0xdV5Grco+Vx7pmiq1CTE8Bs+nuxLyyrrEmv44l2YVqPqMcL+V8Z5KOR2lk1ZGbZ6MrOWuJyMmr1VtBQg5wn2JAqOz3n3NDxxlx2twTfgByeK8Ogd9q5UCQK8F1k7AR3CQkmNFlNsWRGIjIukZLUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495676; c=relaxed/simple;
	bh=ErYrXsseykqL4vyJcZpv7WuBvkHSV25tTr6eG/X2dOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sgo+RSQwiau31WjjLI34M2+SGS9tK65yiswJgERYxid80rkWGA/iXdupPWOd7mM/v53KcPH2P+4Tf8+zpKy4Md0esuitSjMjMLutQNLhPCcaI/mzC2lhmgM1jeRKkU94Liu4pCzkqpVuqpRO3acsCQonO8iihmEQnm77JhaBkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AGEER5FT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so5334475e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 15:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765495671; x=1766100471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fYC9VHReEvX3Minrq38RSpVZe17Y9HGfiy5EpKAJvjM=;
        b=AGEER5FTjAph0iSFK4jrhBdp4HGYOjehNMGhVts6COP1fiZvhGdnRJf9FJENFN2Uhk
         nmr6N9AYVjcAu0tPjPJ5duJ55xGwWWuFkQ+PmrJEQW8PoP0KTvAwkMjEDCDYxG7FAHeh
         HTlpEHJMT7uZPcmoVXdXW5l7cG4FDZ9HOd1H1r/IFX68DlXjeFV0dOWAAbcgcGROjf4b
         ajtH2CzO9uuv9o2Irlzy+2WAPiFiNP8srVE/nnKiRfFEc34A8arZnDPVgggGPPLH6ku+
         X/WiwtbsrQ6el5y15BmwivpuxOjmpJINrh+7HFHsp83B7hfdIAN+dJqnU9kLjQT8gXoT
         MUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765495671; x=1766100471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYC9VHReEvX3Minrq38RSpVZe17Y9HGfiy5EpKAJvjM=;
        b=nGKjh+YnnABa7ZASIZCZwjXs1st6LaY1+GRRNxpQBqDJAC3aS4hrzfMqD4P4KQBs/x
         aP3fXPHh1iDECSkhvnI8DpFFVzCHFpTGQQ5rLO/+vjYSI7A2AXefksmPc+uiI4tqxmt5
         D+mmPzFZKGpTQKzHxbMGxJ+QPbFPl2YdAtt3EEJDOYvp2ZZEGUyq7GLfwiupu0UkEPkI
         xFzOhji/3iXYpM4g3Ok0RtSFwMfFtzaphUtWeepJPcsk67U8frRJ5U1KkKALdthJK9sD
         ny0qCAKicbEWpZYuyAJQMIwimT6ouqLTlYrAqFVFpAty7O+wokjF98pqwuI1NC9xKml2
         5SIA==
X-Forwarded-Encrypted: i=1; AJvYcCX7z46LGaY+IaIaVxGPvItpIcPGZU94IU3yHX8hQBJQle/wEVOAghlBH9uv1ooPMTtzdUZ85OeTB0Wptg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVrRFcmXT6qlC5D6xSpq2FMgDA5mANfHAdy0tssRQJriLB/Mr
	3Q9lyup3+TYNBpO8Q6tAPIpOKKDtjWlqVmzp75IFqrmwIF3DdPsFfezfOKNMqYvMcwlDyRBaGQ5
	1PTgY
X-Gm-Gg: AY/fxX48DdM88ZL/2uWko3sv3MJCyEFaThriGRlV/qjFs0Z/NIHnnDHOQL+SbROgUrU
	gdkzt+sEWp8hlOFTGtLuvj+acRg24IcOf+ItK/bvmTq0WHLqEpCoB58AYdldMCcdhBVXeRhRejj
	k1IHVbS3Ljqm7Vcbjfjh7Fiwy1Yj+mgQHgQfChJuKK+sGVrmHXoH1Y9jF4kkDk6zI+kAOuJ8pPg
	Js2vpD/X0Bm4m0Oob3nxHmbR8Z4uC7P0EGejFdVxdhvJpTD7ZESz3ZVxpRG2hZrgpVzeiTvAaFs
	hqLXkODxB32PURf0yzCfys6mQ+iydJx7hCb2Mh/g7Wk6F3A33z0tK9rjnSbSMDdfXtCMOoQFA6c
	8DR98z8fV2ue99G+xf1vIJzCgU0/OwH/4sLkT9Cwk/WXzeW4/cenJJsI6KuYb7W22IWzc+lPXU4
	DAqbG9h5FFv0FxItxpZ6JRVjOqsvpNxR5z9+331KQ=
X-Google-Smtp-Source: AGHT+IEWyyRzNb6JcIliJhyBJL2Ou9WabpnUcbp3AdLXrFnPDn3FcyW6fgfZP3XhkJbZEtATKnV19g==
X-Received: by 2002:a05:600c:1991:b0:479:3a87:208f with SMTP id 5b1f17b1804b1-47a8f9164d5mr484545e9.36.1765495671496;
        Thu, 11 Dec 2025 15:27:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f5ab7d87e8sm1715590b3a.25.2025.12.11.15.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 15:27:51 -0800 (PST)
Message-ID: <06ad95b1-3384-42a8-8351-7274d202765d@suse.com>
Date: Fri, 12 Dec 2025 09:57:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix changeset leak on mmap write after failure to
 reserve metadata
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <ab2ab25d0598c04467a62e9e88c9131cec159c48.1765454225.git.fdmanana@suse.com>
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
In-Reply-To: <ab2ab25d0598c04467a62e9e88c9131cec159c48.1765454225.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/11 22:27, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the call to btrfs_delalloc_reserve_metadata() fails we jump to the
> 'out_noreserve' label and there we never free the extent_changeset
> allocated by the previous call to btrfs_check_data_free_space() (if
> qgroups are enabled). Fix this by calling extent_changeset_free() under
> the 'out_noreserve' label.
> 
> Fixes: 6599716de2d6 ("btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents")
> Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/693a635a.a70a0220.33cd7b.0029.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1e0ff3d7210d..e42fd2beb1e3 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2019,13 +2019,14 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	else
>   		btrfs_delalloc_release_space(inode, data_reserved, page_start,
>   					     reserved_space, true);
> -	extent_changeset_free(data_reserved);
>   out_noreserve:
>   	if (only_release_metadata)
>   		btrfs_check_nocow_unlock(inode);
>   
>   	sb_end_pagefault(inode->vfs_inode.i_sb);
>   
> +	extent_changeset_free(data_reserved);
> +
>   	if (ret < 0)
>   		return vmf_error(ret);
>   


