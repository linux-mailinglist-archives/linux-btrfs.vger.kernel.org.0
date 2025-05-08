Return-Path: <linux-btrfs+bounces-13827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD49AAF6BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 11:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9451BA63CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A97C263C68;
	Thu,  8 May 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MZXuYfd6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B51212B3A
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696552; cv=none; b=Qq6PN8GK0P2cqbN09Y18wFLuPeEe/ugvgLZTigHfXh5K9nEoRcK4+DZHrwfHcNTT7wdYYe+kfh30d2vH+/rZ5I4SxU1NjAktQKvhfoIvfxOrkCPgQ2TyvBKfJsZ/DGdlBaayKBuAOvAnjSHPD53+qEa4sLnKuiCCEaasAR/o/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696552; c=relaxed/simple;
	bh=6F7GV4ssBJ6tpLXnJ9XCktIpxuVg/M87FLs8u08ZizQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxAj/rWUl4gFsv532jxArTlAWerIpUo2OlCwfUg3sCdNgy0hWtX3aQKH6zOjeH2vTxtl6gkeJ2FT2Utp8o+iYgnhzM4AnJB6AGnq6Mc+Wws8Nq/luLMDUuhd/IOhdGrc2VQHiG/0JxrAHEsc9BEO1miWKuMy0xZZ74EpUJwi8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MZXuYfd6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso126536666b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746696549; x=1747301349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=opfiCfUXENQMpzh2yphnVtVlQqtDZdSXf+/9PLMPkjg=;
        b=MZXuYfd6AZGhtatl/poiIw6s6uJn1qmh58MgfltDu9D6+a3xHndqZmUqcRYxP4tH01
         HIuZZv0U420/guMRvh8f6vzhM26k5he4l4Gu98wEep8q54oS4Dr8PoCtLYezN8mBj8NS
         zw8VKAe3sw+l+uNfYDk5A45SbGTLHRoZhBdo3ZdODBQMAf5l0Kkgwi4ix2TKwgAS2MqE
         yCdwhNmZxazd9AO/OjHDnrcEHTGMoM1d2etLP1NLKvtnIdQEyOBcnGV+zJxgjstcvAmZ
         wdyluWQZSutGdn9nz/M7r9uqVx9xrODAvExvDahJWr+etP1V+MICZpc7ALzZUgmOD2gA
         wvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746696549; x=1747301349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opfiCfUXENQMpzh2yphnVtVlQqtDZdSXf+/9PLMPkjg=;
        b=BcuuDuj3IRtxhZajX2u60RTUp5JcJYuOpezCduvM4WXJ6jjtoeBWz07N97SExBmmay
         PGfd5eD1ikKNq4ED84KJ+AdykLzjiIeE9DuDBv3tWs0tN7sS2shA3eIDPV+XuO1YukSW
         +8BopAB0IsOHGgRjEyhrHNYdZi3h+KlVJcBAQEPlkAYeJMwK2TOlU588xC9DivdLs5ER
         zGBuJb8JrvxjhYs06daAWe5O624on3IimHqSVF1Ulrt/VU2BF3U/2Gd5eW/2LC3KHG0e
         6Ik4NwrfZVtexa/PxXeDAeVEzGiL+cKFNS3IQUB++NkIAXu0SMq+AqKkNRNW6mN/AstN
         c3pw==
X-Gm-Message-State: AOJu0YzfRByepFBYa1HbJbwLRiK1xi8cGTeOjeH9L1L4B/w3cx6GXT5c
	c88/BjlaixfE5Uf0uxf8vWd9zCU70gEam6/TI5C5syw2TdlnOaGozSs0IP9NoCk=
X-Gm-Gg: ASbGnct7ZiQb6lx20N4wTYE7hTWsH5Pgi3XLcColQha6BPHqEGiDAPTI9U1Dkpjntb0
	QXLJxP1f9M5l9FAkVqAUrk+dHe5n0iarHBjLONJ7s3vy67k/rV1vf5KcWHCsi+WXs+dipJWNZd/
	cDhyLmelmqYakuj/KFyTMJ5fttIASNbDviHTK0D2RXsjMdyVVm3hjGMQ7o8mzIxl129a51mx4BO
	5dm2MVg6TSjUd5YuN3aaY5W+YQZj0yGEOrvl1I0UJbh54tkZ4msC5kbL8m6sGQKRgr35x9iP8RP
	DqYk/54a3J2XUcZWWoEGQ2WnubVIb4TR4332lSWYSLl+IIr/g25l+jATahFwLmvMncWWv+BOslq
	RJxc=
X-Google-Smtp-Source: AGHT+IGdYaYNv3ROChfHXSgpO45jNEPsYzW9OFewKO5xVmDUgDHoPI7eWDbjD+1ly/pW6XkUenfq0A==
X-Received: by 2002:a17:907:c242:b0:ace:3a24:97d with SMTP id a640c23a62f3a-ad1fe677a1amr245411066b.4.1746696548748;
        Thu, 08 May 2025 02:29:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d56976sm1737872a91.27.2025.05.08.02.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 02:29:08 -0700 (PDT)
Message-ID: <9a49247a-91dd-4c13-914a-36a5bfc718ba@suse.com>
Date: Thu, 8 May 2025 18:59:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
References: <20250505030345.GD2023217@ZenIV> <20250506193405.GS2023217@ZenIV>
 <20250506195826.GU2023217@ZenIV>
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
In-Reply-To: <20250506195826.GU2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/7 05:28, Al Viro 写道:
> [Aaarghh...]
> it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> no need to mess with ->s_umount.
>      
> [fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Qu Wenruo <wqu@suse.com>
Test-by: Qu Wenruo <wqu@suse.com>

Although the commit message can be enhanced a little, I can handle it at 
merge time, no need to re-send.

Thanks,
Qu

> ---
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7121d8c7a318..592ed044340c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1984,17 +1984,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>    * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
>    * work with different options work we need to keep backward compatibility.
>    */
> -static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
> +static int btrfs_reconfigure_for_mount(struct fs_context *fc)
>   {
>   	int ret = 0;
>   
> -	if (fc->sb_flags & SB_RDONLY)
> -		return ret;
> -
> -	down_write(&mnt->mnt_sb->s_umount);
> -	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> +	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
>   		ret = btrfs_reconfigure(fc);
> -	up_write(&mnt->mnt_sb->s_umount);
> +
>   	return ret;
>   }
>   
> @@ -2047,17 +2043,18 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>   	security_free_mnt_opts(&fc->security);
>   	fc->security = NULL;
>   
> -	mnt = fc_mount(dup_fc);
> -	if (IS_ERR(mnt)) {
> -		put_fs_context(dup_fc);
> -		return PTR_ERR(mnt);
> +	ret = vfs_get_tree(dup_fc);
> +	if (!ret) {
> +		ret = btrfs_reconfigure_for_mount(dup_fc);
> +		up_write(&dup_fc->root->d_sb->s_umount);
>   	}
> -	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
> +	if (!ret)
> +		mnt = vfs_create_mount(dup_fc);
> +	else
> +		mnt = ERR_PTR(ret);
>   	put_fs_context(dup_fc);
> -	if (ret) {
> -		mntput(mnt);
> -		return ret;
> -	}
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);
>   
>   	/*
>   	 * This free's ->subvol_name, because if it isn't set we have to
> 


