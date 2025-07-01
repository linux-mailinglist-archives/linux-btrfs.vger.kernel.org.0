Return-Path: <linux-btrfs+bounces-15185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F218DAF068B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 00:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C111189B3CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD730204B;
	Tue,  1 Jul 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzcsEqkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C01465A1
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408894; cv=none; b=SWaj6CBh1x62bo7sBKV72Q3pgzWJ245fZ3feMvnzGuCeEBCxmfRpQn/FA1ievXAqJ0NTluUN5+nKJ3ZHjUrmhDm7cuOIaIIfGgp2mSCiFSyBBM2aGlrftVxCIhRtuuQq9Q6xuegYjijtxtDIcsA/7DOT5Z6cYKaNO+4sMWDuC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408894; c=relaxed/simple;
	bh=bytl3UhrtjrNcGdJlvkizWFGRrn4yuyWVR40LXNSPYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZmRjH6zNTPGwfAqxxxQCIu1y7Cc3sfZsNX+e0OmvfhwV+wc5orIzBd4bGRiletO3EyvhUTULfXMdtrGb+TLjEKA8OnsdO+Wc/cVPf/2n/di20dY/o2nD51XqiFG96NhdvYn++EQTwMM7Ya1dgpFc5TjCqO3mMQtzeQvhz8YomDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzcsEqkF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ab112dea41so2097310f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751408891; x=1752013691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=saQojAz1iEMDs/AvRugiPAZMW+WKYmS0rLOMXV5OONY=;
        b=WzcsEqkF7RvawznmUlwhptwz3gWUga6u4XHs1VgvOyShIwDhTRKTGQ2Fdzkp11IJjg
         95Lxgu28RKcdk6Mmpz4LfLLzBZOtWTyLd0n5KU/yLNTRZNd9KpDJytS1+qRx+wEBDXXH
         8jdBKn66EU0ldjJI/LWd2BkHpbUf57TDxSAX1YXMuk0GUUDf7Q+fSo6Nsz88wJYbaT6E
         RmlGXLhnOCGC498Mg9oRVK0JjJJP85K1cWb+C5RiuwBQ60vWO9MvurZKMIWJw9V8Z/ng
         uW1I9oAe3WMTmdqCZp0wRaxmMXHpOTiuQiHlvBiOMQshLUu5FZzI12QDfbgE2Zlx8GXe
         socA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408891; x=1752013691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saQojAz1iEMDs/AvRugiPAZMW+WKYmS0rLOMXV5OONY=;
        b=nlAg7aJwOaorMXGQf5tVDi4GqnCSnt9mnhVfsWLmsKBgedtUVpVpXUZ7ngNEefWWdi
         jRQOILVnaU8pR8fQqwMA0FJy61b0pYfsUCUjKGtRXVEYwqE2nd9pwAAEAmnVdQRZhXk/
         Me031eQ3xLuYPu1+9elwtm/lbS/CN9Szk4cHrH1TttxFaDB/29geZ8W/wChsl8XuHrn8
         XNmGemDHFziRMF2m7WuUNjRaQOIOgdjW/wWxUuwdgHi3P+s12ZK20AGFBZzUvwntbQDc
         iH+WZSy2ubWVdg41Hzq0bidfbkYdCzOePeAJwlvPR94ecJpl8386IX67Gnlm4DWUULrb
         l5OA==
X-Forwarded-Encrypted: i=1; AJvYcCXVR2G7VohZHw3DslB9lDGH/cOGTmiCblW9uoNfm0upxdFh+iOpvJXce5Nw8ywjE2Vwv0FUFqPTb8tuLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nDKiQQ1Ehqhr3jHQDh8voy4+2npPitDfl/C/+/NEVqTFsLgJ
	8yEZj6FWsqV+aTI8HZIVepZCfhzDFyZKryFSnEE4Ps19WUe0+W9Ot1GOafvbQpEcKgII8kVYjeW
	rpXlh
X-Gm-Gg: ASbGnculO2FhkS2QRNbxzh1i1X/uTp13OAtEYIzKSdJwBENxcjl2lCbJPJ9lxgowan6
	ipJ6x5U/Fkf/TMH66tIIyH5ZqFNGOFw4Xffl4C+EBWQHaDKk/sGvYBkTWNoSke3qDq7BCh8cBcZ
	qJudIWl+qF2n9XFn63g5wcbHXMH0nAvQeyFVs99df8G0eMoTnUt+RCvj46Ze8+cuwLEvDDvda4F
	GpGV57mtMPlI0oMogZ+NlXshFTp5Tw3ktsEPGa6stnJLVWN7lxYVbrHiBvWjHc1XK6DxyuZ3sjx
	nr/Z8FhmwweFhI9DMK2m3utagrtWNouDO55r9G0HsbdnDsnjO9J20rwYKXm7UTtRd0kQjVkh0IH
	wMzztniDGsX+isg==
X-Google-Smtp-Source: AGHT+IHS+3VBf4UnbsgJ4NUuKS1X+5vKwe9qcNDeiMtIoeOVoCbFMM9AAB4H2afeUl3uXyPBJsjLsw==
X-Received: by 2002:a05:6000:2187:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3b2000b0a50mr100500f8f.37.1751408890572;
        Tue, 01 Jul 2025 15:28:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e300a40dsm11420035a12.10.2025.07.01.15.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 15:28:09 -0700 (PDT)
Message-ID: <a37b6503-2ba5-4fe0-b7d8-239980c398bd@suse.com>
Date: Wed, 2 Jul 2025 07:58:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: qgroup: use btrfs_qgroup_enabled() in ioctls
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1751383079.git.fdmanana@suse.com>
 <3fe4cd28b0cf16c62d2574868fd085086c9a7319.1751383079.git.fdmanana@suse.com>
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
In-Reply-To: <3fe4cd28b0cf16c62d2574868fd085086c9a7319.1751383079.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/2 01:12, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a publicly exported btrfs_qgroup_enabled() and an ioctl.c private
> qgroup_enabled() helper. Both of these test if qgroups are enabled, the
> first check if the flag BTRFS_FS_QUOTA_ENABLED is set in fs_info->flags
> while the second checks if fs_info->quota_root is not NULL while holding
> the mutex fs_info->qgroup_ioctl_lock.
> 
> We can get away with the private ioctl.c:qgroup_enabled(), as all entry
> points into the qgroup code check if fs_info->quota_root is NULL or not
> while holding the mutex fs_info->qgroup_ioctl_lock, and returning the
> error -ENOTCONN in case it's NULL.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ioctl.c | 24 ++++--------------------
>   1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3621ed2eacd1..3c4619375bc9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3714,22 +3714,6 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
>   	return ret;
>   }
>   
> -/*
> - * Quick check for ioctl handlers if quotas are enabled. Proper locking must be
> - * done before any operations.
> - */
> -static bool qgroup_enabled(struct btrfs_fs_info *fs_info)
> -{
> -	bool ret = true;
> -
> -	mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	if (!fs_info->quota_root)
> -		ret = false;
> -	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> -
> -	return ret;
> -}
> -
>   static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
>   {
>   	struct inode *inode = file_inode(file);
> @@ -3744,7 +3728,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	if (!qgroup_enabled(root->fs_info))
> +	if (!btrfs_qgroup_enabled(fs_info))
>   		return -ENOTCONN;
>   
>   	ret = mnt_want_write_file(file);
> @@ -3814,7 +3798,7 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	if (!qgroup_enabled(root->fs_info))
> +	if (!btrfs_qgroup_enabled(root->fs_info))
>   		return -ENOTCONN;
>   
>   	ret = mnt_want_write_file(file);
> @@ -3873,7 +3857,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	if (!qgroup_enabled(root->fs_info))
> +	if (!btrfs_qgroup_enabled(root->fs_info))
>   		return -ENOTCONN;
>   
>   	ret = mnt_want_write_file(file);
> @@ -3921,7 +3905,7 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> -	if (!qgroup_enabled(fs_info))
> +	if (!btrfs_qgroup_enabled(fs_info))
>   		return -ENOTCONN;
>   
>   	ret = mnt_want_write_file(file);


