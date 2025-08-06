Return-Path: <linux-btrfs+bounces-15878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACCB1BF76
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 05:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6B07A5AE4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 03:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CB1E5705;
	Wed,  6 Aug 2025 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hFU59For"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18719AD5C
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754452754; cv=none; b=idaZ/UYWohETuPmLxBzd4aSgXp3wkwMAl+/S2CU7arhuRt6qzNTuzrNvmVFlSscw2ZJcet+lty3oS4TXSvuvX/yf0F03Gq+GofqVV1Clxy/bx71hPWJPIDuSnOuXDMIK73Iagr3VMe11c3904BVC4RyYsSSHeGg5uEXYRJp1uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754452754; c=relaxed/simple;
	bh=T9Tk/Em3UAHv+eI0mqmDApkAYA/7hTBqKiHpjho7d4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZsKPb7iPVN7S2MvHlQ5fE3Z0rcUqPpBzsfYUU3+0McoKO4jhJQ248eWJD4ETCfeppKv6uVJWXkDkpz5uG4Ny9tGwQihHbJi7ry0cpykyKfmYSHAvB9+8oyTfou2uRpBgybLfEmbaBXFQQMl9iVFrdXEIuKSJK7aKrYooYTwajd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hFU59For; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7848df30cso274602f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754452750; x=1755057550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=acUvOJqblBXB2KnYqf+huOIR3htJjOGUOHvSmC+dF+k=;
        b=hFU59ForXA24Gzta8TJ9ruGApXuYIurJKgwNSoWrPZtV6tbnmgNXa9Z26oBdyTJly6
         0HvUlUJA3KhenVjFn+JRHQVZodlcCLbl2z481hKadd9qjQ/bRakAZB3I4LmvX7vf4FZQ
         y4L676twwkxUPCkIRlQU+w9pUfjz6/N4LP7DMUjm5ytBnIgD2URGJyhpgpQYEskzqpsB
         3/Er52bvyAdk5KlZLwzTZveXjjLqJZZFlmADwq8xU5CQs7C+Zn5uUE8ds6kYSIarVKxe
         5DCfueGn+TDRmQ4d0622jSYP/eBr4smWEeGXXay8sJS6u7RW4zlxjH+hDleEYtPs5IAI
         X2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754452750; x=1755057550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acUvOJqblBXB2KnYqf+huOIR3htJjOGUOHvSmC+dF+k=;
        b=gS6XGZl2WTvIia298ebp9+dkOyi+WuCBJwpq9Spm4xwjhvLo/HUZNQni0UeVvCUHde
         YxCJrwrFDwmPSf/Rvh/dFmTqLLM68Jkg6GtVNZ05dSHd96BFjcbx6wjd2KUWlE1Fj7wz
         C122/iOUj2POWhOecUj9gqu6sBm6EkpRkhCD9y2NM26FRN6c3TlN95eMA3GIgt9KdSFn
         meU+cJoweouIQvLWqNH0n9wwVwWO2EFXFKtCqx/2iGffJohd4Wj10/+pumuQEQpuD+aF
         CiGRbJtMMUKiSDMKmJ0IEjc5UHK3pS4N3LpmoWxqwNpb50uiQmnkOFxGcfIu/az16E4J
         nsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/jZqX5mPshUriEQwxajuSy41gXAMFsHPhvxCUZd0QItH5Xengx5t7E29Ss/vkWAQrt3FVg0AJRa4N7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9AiuHF7blEg4OX5ItQmkgEMK8N93QeGaHaWGGvqVneWGYvq2
	NGexL6I94PjF3F0Ew0YPAIOjfTJqWDqyE0EVCSJyY7ho/fGnaAuR96CDPOQHUaFTHqk=
X-Gm-Gg: ASbGnctnFnmy4pzJ3ZecXPmJ4kESuQxzNiWiC2sQDDN34+2+h3fNazkZxwXeQpzmXmQ
	JaDDmOxyTFwpFpIA3aoqB10fyUF8IMUpf/Uu+K276FNwrU9FIEZL6VHxnuuxyWu6RxSJPR203Sl
	iTUakCg+6d9yYZEY/WiLL1YnN5QwIlTAiAr4WL/QVPYv5UoE++yAs/YovF3DtDHzdvv27XlNUSJ
	OO0xX/ZEyXJ2ejbnUwdcFj8DkOSBGb5dQj+uEyZ+TqyXzjID2mLSo0GpY3HN/JsGox9cnb+JIxt
	TTl+UOCvW3iLFVf/IgjwbAQLfw65GpfPG26lQUlBKuDLQ42Ei7CngL4KE4SFmJWiSJV7BSeeYxj
	Zh0A/mS3Y5ydQvb2WtF7+75WeMp9s2vIpGE1xjbqrb/6Ffz2PlQ==
X-Google-Smtp-Source: AGHT+IFXnfL2FG6mgVXSG2+3C1d4omoh2nmtWuG02vS/2qMr/N7nKZ+eooib+zuVnqx+dQgqNg7CCQ==
X-Received: by 2002:a05:6000:2484:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b8f437e2acmr786721f8f.27.1754452749749;
        Tue, 05 Aug 2025 20:59:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm12465778a12.15.2025.08.05.20.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 20:59:09 -0700 (PDT)
Message-ID: <d352814c-5fd9-4a42-894b-ddcad4d63ae5@suse.com>
Date: Wed, 6 Aug 2025 13:29:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to
 handle loopback and device mapper devices
To: Zoltan Racz <racz.zoli@gmail.com>, linux-btrfs@vger.kernel.org
References: <20250801110318.37249-1-racz.zoli@gmail.com>
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
In-Reply-To: <20250801110318.37249-1-racz.zoli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/1 20:33, Zoltan Racz 写道:
> Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs device usage"
> which returns the sector size of a partition (or its parent). After more testing
> it turned out it couldn`t handle loopback or mapper devices. This patch adds a fix
> for them.

After more digging into the sysfs implementation and how util-linux is 
handling the sysfs block device size, it turns out that 
/sys/block/<dev>/size is always in sector unit (512 bytes).

It's not related to any block size in the queue directory.


The core code implementing this is from block/genhd.c, function 
part_size_show():

	sysfs_emit(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev));

BTW, to my surprise, this very basic member is not explained in any 
sysfs related docs...

So we don't need all those complex workaround at all, just a simple 
shift with SECTOR_SHIFT will solve the problem.

I'll update your previous fix to use /sys/block/<dev>/size with left 
shift directly.

Thanks,
Qu

> 
> Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
> ---
>   common/device-utils.c | 48 +++++++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index dd781bc5..a75194bf 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(const char *name)
>   	char sysfs[PATH_MAX] = {};
>   	char sizebuf[128];
>   
> -	snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
> +	/*
> +	 * First we look for hw_sector_size directly directly under
> +	 * /sys/class/block/[partition_name]/queue. In case of loopback and
> +	 * device mapper devices there is no parent device (like /dev/sda1 -> /dev/sda),
> +	 * and the partition`s sysfs folder itself contains informations regarding
> +	 * the sector size
> +	 */
> +	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", name);
> +	sysfd = open(sysfs, O_RDONLY);
>   
> -	if (!realpath(link_path, real_path)) {
> -		error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
> -		return -1;
> -	}
> +	if (sysfd < 0) {
> +		/*
> +		 * If we couldn`t find it, it means our partition is created on a real
> +		 * device and we need to find its parent
> +		 */
> +		snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
>   
> -	dev_name = basename(real_path);
> +		if (!realpath(link_path, real_path)) {
> +			error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
> +			return -1;
> +		}
>   
> -	if (!dev_name) {
> -		error("Failed to determine basename for path %s\n", real_path);
> -		return -1;
> -	}
> +		dev_name = basename(real_path);
>   
> -	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
> +		if (!dev_name) {
> +			error("Failed to determine basename for path %s\n", real_path);
> +			return -1;
> +		}
>   
> -	sysfd = open(sysfs, O_RDONLY);
> -	if (sysfd < 0) {
> -		error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
> -		return -1;
> +		memset(sysfs, 0, PATH_MAX);
> +		snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
> +
> +		sysfd = open(sysfs, O_RDONLY);
> +
> +		if (sysfd < 0) {
> +			error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
> +			return -1;
> +		}
>   	}
>   
>   	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));


