Return-Path: <linux-btrfs+bounces-19677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA0CB76C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 00:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68A523003847
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456F2DC773;
	Thu, 11 Dec 2025 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dUWM39PL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D5267729
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765497327; cv=none; b=GCsqLpxl0p5rfxSR9B2BVDo9kbatbTznLNZGJHpMKgQez3PoWO5hjUvNLTrv/QMWEiSwSxGYJkJ7X/HVxL/5q0mB6xqy+thRIG7bTXKRSxX8QYuVswa60RUIQVdP4tGuBrbFRHyyySwEEyd/n2UkJLQ/P5RQQ56A8O3/hZjkMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765497327; c=relaxed/simple;
	bh=DfyJG5pXuo8UbFyuUmBIW7BQ6lvNn/kzEkXGzgccCmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6g/IRD+02GMmpUi/mOAw6xXT/0vuihlDpFFz9YcRZcG7FBBTBrrcnQbm7eXMSEefYDhWeI4gVmy84885rQORKzJSH9SBuQEd5DBcf6y9mXgVmBav4UVmATn+td15xzaYb0/Tq9dBuYTt3at/F3nRpG9zBiHg0eA3jdalwSscOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dUWM39PL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so4928925e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 15:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765497323; x=1766102123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h45n5mTZUR7eR6k8c732Tpj4q4YJmSJHzrpU0dL1c94=;
        b=dUWM39PL9WLpjRaQ7hczLKzeJ/B1XHnm7BN/JgNQTqzBL1J5Qrk4d4V+jlKj1rQSJu
         E1S/CfW/sdVen9nAPDJXKjGG6868LRKeaAU1mP2uwb6xA4rm0WKnJIccNj2votenRoFq
         sxj+9q8KvLKqMaj4bMpqZ8hUo9igWXeBMKPYs/KWFW9EAq2fQr4pANDTgoNIvslrIQxP
         NHRQVjGnWPG+SK5BJ4AA9FtZyAJj2DbABOI8mUM2saBJg9dZWEn4LQ3NHealKlSlOcca
         BI2nDQ6bYZHzXNBuJT5lmVLYPrUmDfxbgUCPDhW/uqxsygwxPkeWEsorle5dKlUQW0iZ
         2SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765497323; x=1766102123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h45n5mTZUR7eR6k8c732Tpj4q4YJmSJHzrpU0dL1c94=;
        b=RcWCZzWzX3OPrpZrQZJ9vsk0wJHtrOM+wh9kx+iOGxKQlUppqXrzzI0TBeMAVJ/SVt
         x7lgpljenWG/km9q+HBkS7FRZniwdTvjMwZIsstqYlZem8vjT0JesnAVqdSFdEGntXEe
         K8Oa/GdxHcl763cNVNI26TsV1MCNvxU91w7Qy9SH3OFfvGVM97lD+w5/hzaGezNf5tsB
         UHP2S7BsQpHbUEHtX8JfpJ5Nd7Qy9Uk4DpgTWEtbDqr5TiW6eqI6At4pge8JPqUmilW5
         4Bx+m8nxnTO02hQc4zUiIGZ06lFJmJML7Tr++KhU0UsS4KJJbOoy8kDSOixZUGGzfTM5
         DMIQ==
X-Gm-Message-State: AOJu0Yx5O62mKH934jpddsLCtBpGOAWaMBd3PpMhp/ldqIrdFEWr9AU9
	fqeP+WF3/A3UB49MlFPP/sk+8bJaqKkPzggcNcRhqZ7JlEWT0KBkxNE+htaZ5BMUL9Y=
X-Gm-Gg: AY/fxX5cB1vh8/zJ3oIMOYPQCFLbBajwZMR044SKgLOri0d7R1L96DAfyue3yTsNeHr
	hsKDvfbFu2XyWN0LcHiA94j4qErtqx+NIRsYbOuavCtn38MywTOsWsN52zpl6LKh9vZVTFCSEra
	yCCQ/LC+Id6dkXkowsX3hCdfX5uJJWsneR0GfCnqycMb4UbN0HWFZ3A+T4dnxP3mFVZbWwdmBKd
	ypnU9pXp3BI3l4JYD39WFJzE9BfXQnOOngBgbcCvcsM5+6/EFUixwRVeJ/gT44XUQPQpUet8Ww5
	hbkEu/L5Aih3rKM0Qu7Oun7MCV/4tr1n2q7PDPBe7+bA8H1/dmO+zREbQuy0Gu7EreuADyfCGLK
	BoJfyz/swEnu0EUkyJAobL/WNHMlTl531x/fMzoERA4zgcJSboHwAA/125Qbgy6o2K/eKfxLj7R
	IcnIyXz6ljfkFITJpUnSCYiyV8Vk3xLjsNbPihzkE=
X-Google-Smtp-Source: AGHT+IE0VIqcnNOll5EeFVrt4q++DKOVTx3G19SmlYOtL4MHrgIE5w/dVv3oj+zxhWiP0CAyJBaj2g==
X-Received: by 2002:a05:600c:3b9f:b0:47a:7aa0:175a with SMTP id 5b1f17b1804b1-47a8f90da0fmr1028795e9.26.1765497322714;
        Thu, 11 Dec 2025 15:55:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3daf33sm74879a91.10.2025.12.11.15.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 15:55:22 -0800 (PST)
Message-ID: <123e2014-59e0-4c0a-905f-c2fee4455eb8@suse.com>
Date: Fri, 12 Dec 2025 10:25:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix memory leak of fs_devices in degraded seed
 device path
To: Deepanshu Kartikey <kartikey406@gmail.com>, clm@fb.com, dsterba@suse.com,
 miaox@cn.fujitsu.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
References: <20251210132807.3263207-1-kartikey406@gmail.com>
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
In-Reply-To: <20251210132807.3263207-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/10 23:58, Deepanshu Kartikey 写道:
> In open_seed_devices(), when find_fsid() fails and we're in DEGRADED
> mode, a new fs_devices is allocated via alloc_fs_devices() but is never
> added to the seed_list before returning. This contrasts with the normal
> path where fs_devices is properly added via list_add().
> 
> If any error occurs later in read_one_dev() or btrfs_read_chunk_tree(),
> the cleanup code iterates seed_list to free seed devices, but this
> orphaned fs_devices is never found and never freed, causing a memory
> leak. Any devices allocated via add_missing_dev() and attached to this
> fs_devices are also leaked.
> 
> Fix this by adding the newly allocated fs_devices to seed_list in the
> degraded path, consistent with the normal path.
> 
> Fixes: 5f37583569442 ("Btrfs: move the missing device to its own fs device list")
> Reported-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eadd98df8bceb15d7fed
> Tested-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ae1742a35e76..13c514684cfb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7128,6 +7128,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>   
>   		fs_devices->seeding = true;
>   		fs_devices->opened = 1;
> +		list_add(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);
>   		return fs_devices;
>   	}
>   


