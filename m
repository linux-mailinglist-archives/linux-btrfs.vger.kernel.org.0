Return-Path: <linux-btrfs+bounces-10658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5C9FEB0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2024 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C5161BED
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2024 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6318019CC29;
	Mon, 30 Dec 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JzBL/95j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A311991CA
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735594933; cv=none; b=S+ePHuHTUnQNEDyVfalIb59rB2rvNjEgwo+6Mj8X48NbyTcaenJ0cA/Qjq9MqgOVRR5oxuRQtMIAGsYaW3jE3HtwCrfBCUKsyx64pEguPD/RkQ5JoRp6sB8Sqomi8n1aFU5aWLf9EfcRNRHhV4LvQBX+4b7ZfmsKHgLbjle0vIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735594933; c=relaxed/simple;
	bh=/vLwhqYUZlb+LGwRjMigWlg183/2wPeMKhdLz0b+s3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bKGbsGMIH+isLaG5v28+RhsK0ZO3XU30E5WRyoIQot7KGD+W8j2tRp2w4QY4WYNOMB9CQj+cTST3LPxpkATQPaWjQ9D+mn+liRU3fiekZfdvDbFBLQbqaCtauvCF1Qw6+9cKHMz/vX2Ls82fb5CS0cluiJMSpV9opECTrV4m06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JzBL/95j; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1421222666b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2024 13:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735594930; x=1736199730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=edO4FYTZqL0lI7So2IdyuE/GYDIUy4det2H+lUlSMlg=;
        b=JzBL/95jNSLnCj+dbCH5fDarXYF6W+LQ9T30ystEcx1ZhaZVxyiWcpfoSe1Bq4ZYp7
         fs3w7XE5iYmKEPavoOoiQr6wOli8MZNO9BZO9vtYMKXsnY3NFdUkRjOjBvfOYHR9dGfT
         7s58oESpGvRn2QvzdJ5E863LC3UEAlAVuBOOfU1kjlcUxvS/EK3YEfq+kjga3ZoNHfM2
         PjgopagaG4OD4r4N/cZ8vOKk2Alm5RbwM54yKmxoy5Lb7rgrqr86oMd+NvDCHociZfDQ
         F3nhkLokXOv7OZ6Z5dG2P328pH5xz76PY4Q53iYD2N/4Xtu8UpU9d35/1rcgcP9rfh2S
         upWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735594930; x=1736199730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edO4FYTZqL0lI7So2IdyuE/GYDIUy4det2H+lUlSMlg=;
        b=XcqRWP8qrNFt/KXIIPdmzBNZ+3BJq4DqiHxSV2ZUYe8FZZXuYBZWfcWc5yQjGbuaFT
         ZmDAuDCv168SHLzCb7yJtczwdipTiQmj6mTCndPj8RW3nIWVFvcD0974ym06IjGG1Rhh
         hgGD5+IL5uhp4VeDgL+FUtgK6BZqtJwfJ6hpzsROLxXkrcxRfU9c4pXWROG+pQRfp7i7
         TH1AV1FpYpAroNshMYjHwaVJbj53PLJri7uNlnYRzwLkU4c1iAlepLNfvcqHxmWcnwwu
         oUXEVHDveze6eb/FvKiAk+SZr8kLTJlh/DE62nJx+yLeJzUKGR+0OV1xQlH2s5zPvFBK
         u0ig==
X-Forwarded-Encrypted: i=1; AJvYcCUNjA2bhWF5eBhWHhnrG8KQXNHLfy88LLrsdkC5pOon9u7A7vuchbdKcfnR8UhImWY8gjgBSh6MOprEVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwawxYCo7hnUOeJj5EPNoSInwPg/SIuF4K/TdlPNvm+SdCsAum6
	uBtxmdttKNQlf1pzjSrLUcUpxaoWG7hI4sBrSth+3FxSNwyZRSH3FkeiwFWtUEnGjWh3hmDZbld
	k
X-Gm-Gg: ASbGncuHWy3lyBJuxWm8IbIC9NmlP3SuIOOSgNok7oY4gykR0eD0HDXnOmArnqDVYG6
	0eaEN5W4fvs+etoV/mCT9CIdP5d+ZqnqnNtMr8QO0gvKA9KiFusQqxUkl4RaHpgAAoODCdZXybs
	Mj1p4YBfxOYAv3lBOfT3IlUWKll4PMAydC/j4rfJE2jjZ8QV3mEKtLDHi3FKxJrqaq5Fhawve7U
	vTYz1GdlUv2XHf22Qm7FeXuxiiYf28+vnQqZ7EC+Ctkn3gCIn40a2XBJeT8tslzA+QqBn9FcrAq
	wC6KMd66
X-Google-Smtp-Source: AGHT+IE7bdAEVNlatw1Vtn49V/MgXLmRjcg+mvGBVoiLYgbqvadcLh7q0RicH5JI5wqiDoFFnhSHfQ==
X-Received: by 2002:a17:907:1b86:b0:aae:bd6a:569a with SMTP id a640c23a62f3a-aaebd6a5d0cmr2026283566b.2.1735594929352;
        Mon, 30 Dec 2024 13:42:09 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964a73sm183026795ad.45.2024.12.30.13.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 13:42:08 -0800 (PST)
Message-ID: <5bf44064-c83c-4916-8681-192e4dc1578d@suse.com>
Date: Tue, 31 Dec 2024 08:12:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: lsblk multiple mount point issue on LTS 6.6
To: Mike Pagano <mpagano@gentoo.org>, stable@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cd99bc2f-6420-4415-8be7-de00de4742a2@gentoo.org>
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
In-Reply-To: <cd99bc2f-6420-4415-8be7-de00de4742a2@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mike,

在 2024/12/31 07:40, Mike Pagano 写道:
> Greg,
> 
> A Gentoo user found an issue with btrfs where:
> 
> "... upstream commit a5d74fa24752
> ("btrfs: avoid unnecessary device path update for the same device") breaks
> 6.6 LTS kernel behavior where previously lsblk can properly show multiple
> mount points of the same btrfs"

Thanks for the report and all the help to bring the bug to me.

> 
> There's a revert on the bug report [1].
> The fix by the author can be found on linux-btrfs [2]
> 
> [1] https://bugs.gentoo.org/947126

A revert is always possible, and I believe that will be the fastest way 
to get it fixed.

> [2] https://lore.kernel.org/linux- 
> btrfs/30aefd8b4e8c1f0c5051630b106a1ff3570d28ed.1735537399.git.wqu@suse.com/T/#u

However for stable backports, the principle is the patch should go 
upstream first.

Thus it will go through the regular btrfs review/merge process, only 
after that it can be backported to stable branches.

So I'm afraid Gentoo needs to maintain the out-of-tree patch for a 
while, before the regular kernel development.

Thanks,
Qu

> 
> Mike
> 


