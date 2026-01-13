Return-Path: <linux-btrfs+bounces-20470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE056D1B577
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 22:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6707B30383A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBA318BBD;
	Tue, 13 Jan 2026 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TZiYetla"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF2EEBB
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338281; cv=none; b=i9rBb7iLRAshisPhWwpgGJIwHBbmLfR+J8JI/5nHV2TAyDkRBWppXrfDXvWecdd7lHUhHj4Qar5u8Fktq8XcXV3/64sL65Yy5XxoJAhdYuNagGN7dUoBl6MGPche/W2Iww7jamiR7Fk/W/9P4ql/9EWqmYeBe3MfMV7rdHsYK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338281; c=relaxed/simple;
	bh=PvWteaDQv9H82dBJMNmY3RVDDYCHfUQxUBvezCPYRno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U3palmcPHDCgR3aafSsgm3h86w+If2Se5oORzr5NcpkgQu0ejgKwtZHs+pbVmudU+mw/l8TOqsPgY+K+6CT7I71xoIz5wHR3lt0R0iNtrIhts/vMO6cdKnwCb5URUDMqjd2ceT3G/Pq4ydKjWWgGJ+xRcV20cKutYizdtZ98A8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TZiYetla; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so59695625e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768338278; x=1768943078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr6I4sFLOF7pEQXQtE49ONSOXQ3w+siiUs6sZfttsSo=;
        b=TZiYetlaRKrtRm3sU5Dh5TlWvGsiFGLEdYj0DsEbd/4oZ//GGx7+bM2ceN2Y8VxqeS
         MdhAInSzD8vN6B/u3fcudINZWvKyulSGJvTQURTejDo6JZTGLs6PdzO7kuoJhmT1HG6E
         OAUEr2YcpWF9bBxB/I1LomsoesA1kJOKOJhVCsdzyXlXx7nx3HAPJeD4beNy0TcHibOG
         IT1UCNBXXCYU3aITMgPfEDHD7r+GJWodZZW4dzj4q8wrgQ+ZykJpVHG4VF78JomQa0C+
         zsiyqcBhTZLbT7Pa4kvmju3mYWGAUrPP2qP4co2CIqzXsoSGxXf04RZol+Jps39yOQQa
         Xj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768338278; x=1768943078;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr6I4sFLOF7pEQXQtE49ONSOXQ3w+siiUs6sZfttsSo=;
        b=thOYXSqyPMAXV2ol0s5EZkSiD+YhJfa0MFyoam+k8Sh79NmpxiaodUedj9/l575XqI
         MZBSn40HMwO+CMTu6ZkjXFFS5AhS7UIJrpSzqvz9jZCzFUTTLkeUdqOJpHT107n0VloK
         8j7OOyFgj5q8OMquQ3ktyUvOV2zX9yQp2cEwmg00mL5g4SopgRN7w65gzCsvEF7Yn9Dx
         8BZ8kM6bBIYRNgoXZhTxjMtkJtW49+KihJz5/RMfmeDQTKowVT98rzzoCEx3YlqI7VfV
         uONws/DWhvPL7fcEbX7NHcszB2JCCYZmzyoqIYcdjbioUMZxpmM0fAB6cqo8h3hd4Tct
         FsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtrD/JEcTN6JeFao+kY5oAQsDWZRUddQKusXDdVJpG97ZIWsHqq40lvNP+eeFxg1ApOEPqf428lmXXTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8Radt/5JZHKpAPsumFZH+Tm51l8PULLiovtPv7NJ72xPv/JX
	6cgwDXKMA2EkALJtddVIbJ7K3ldxpSJ1ufEDJVioM6rWbTcylVA3vQfvqurCf7KoAIs=
X-Gm-Gg: AY/fxX5N4CxzxXFMBhoGrViHJVfd73otKrtUsoN9CJnUUB+HrXLx2d6D3Zd+3OcHfHr
	qBC+XhelNwPUrImRvOI//YUZzli4UyybdW774RHorIv2xaHfiZgKtnhlSaiY34sJmHnbukp07+a
	t4GkE7v3BYvjL1Bd/+0XkfJgs/mWQmYoQ5hXsDxn2SmQgTVhQO3SsTuobwUwIWOqAD86gBEpzxs
	V7SU3f4lwAfMKd5Cv2k9M92MZ05VJFN6iekiA7mTjMfiYi/teFW9HUabTrYjW89XW8+6FzrNBl6
	GH5vDTpLqueBRUjZwKhR3QKcceH2Fic3HJpxqPY8fmvMQh4PIWp/hFo1IynCVkGfbLxV93+Hilo
	j4iKVqUO26x1Snm3aE5e5QSbV+lm/dUfBxH1q5h5PHBk0lcASJRdf7W41kyaVOy/uPpkHG6IbdC
	AYvkv8YHM0B1zm+s39S28JQxax978GLazU/QY3lXM=
X-Received: by 2002:a05:600c:6989:b0:477:9a28:b09a with SMTP id 5b1f17b1804b1-47ee306b1b0mr6848775e9.0.1768338277973;
        Tue, 13 Jan 2026 13:04:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e042e75b1sm9318044b3a.21.2026.01.13.13.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 13:04:37 -0800 (PST)
Message-ID: <d0295334-1288-417c-9832-d7647460cb35@suse.com>
Date: Wed, 14 Jan 2026 07:34:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: get rid of a BUG() in run_one_delayed_ref()
 and cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1768322747.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1768322747.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/14 03:20, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Remove a BUG() call in run_one_delayed_ref() and a couple trivial cleanups
> in that function.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (3):
>    btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
>    btrfs: remove unnecessary else branch in run_one_delayed_ref()
>    btrfs: tag as unlikely error handling in run_one_delayed_ref()
> 
>   fs/btrfs/extent-tree.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 


