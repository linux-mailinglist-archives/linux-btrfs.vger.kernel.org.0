Return-Path: <linux-btrfs+bounces-10369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AD9F19CA
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 00:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ABB1665CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19AF1B395E;
	Fri, 13 Dec 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CEWZI8AN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B3194C7D
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131873; cv=none; b=FVNqeoJCL8pt8wGwopwt9NO4VQUPgPU+JiVJ9Ji5Za+ntIJWH2yremSwu5blohK3UHwjOxNAQm4kSN0XKDxO7U7rkJ1MX/k9OHrN8qiAD95Ij+CWkbS3HmVqAINuD8tLDc1luODw8o5mT3CSe16zGv69e2zlLl0sosaxcmqTS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131873; c=relaxed/simple;
	bh=1hmc+e7YJFKdUOIXjLPQeF248HYTRQQZogeVkN9ZCpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TffDwVgF1euLFDV8pOxNtIWw6NauHAoQ1isJGlvckRc2EQ5QVrXFyRDfnBufPGpWPFCupQ41rwzRAGpBjH+xuzsB3x7kneFznQocS4OUYqKVPlAWEPAbsCmvBG0pWxua4nABN+XAJBQdfkYfPHCDA1scOxZbNoHdw4Mgd8UdGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CEWZI8AN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862df95f92so1215810f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734131868; x=1734736668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3vsbZ6NSlgx/gFwWm9MKxIp8jwezyshWOjCn/ZupbCA=;
        b=CEWZI8ANVRUN/b1MJilQS4GsPIyDXaJE06QbnRkI0MS2uA0NiTF7h1VERrDXoSXC9j
         rxQ7K3BhXFyXkTfg/KOIp57r/5NRV5qqUtSuiIolvIrkXxsglCFQzYhY3rXd5ceEuZOz
         YhXQnmhVPZmPnB5FvwaV9DrPeEbunu6kFv1UzeTXo+Djord01003li2oTefdUDVuP/HH
         FgGdAIeyg/Vp9JZauvTwLThDk5eC+oUMqqzxqxFI7C5UuPcGQKavNjDG4cnmAul1Xy2i
         4aZEvq2RhftxeM7/F+/PDgYhuv6Ah80RXh72qPOsm3Aeu+2wZzOU1QqxIidufCsUMwj9
         7gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131868; x=1734736668;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vsbZ6NSlgx/gFwWm9MKxIp8jwezyshWOjCn/ZupbCA=;
        b=O6t2KIV9Xt0imbw0STR0/1KvHFO7GvJnIJjGm+loz3OjTuq96xlg+q0fZgQpgoH8kj
         H8JHPy+ohhXIcOvO7Yi2ASFEaH8tAzPODNBB9UPXfkbRhF77CHjaxoCV13RGyovaGrt4
         Qmz+OhnYwygmN6HK2+csPSyrK11uabPF207d7vEaH2biNIom4MJVHcA7I6pQb+wbZIWj
         scmNCQuQ/w7FZEetLlfQevYAXVjCIEzoZk2FmW3RVd5u0BC+RqS+sPNLhQpb7egBpf9g
         UfCzoiULUirgN/w0lw1ZlYBMnIkCm8gjuVH8zr6MUUCYg/idN9brNo80wMrGWn7rJTHH
         jgPw==
X-Forwarded-Encrypted: i=1; AJvYcCWrAPoTw03O1UIUclcsuY3E1MPG6W26exVUTpO3hKER8SojO+95kXt+tKx7ZuGnPvhq8OmpHhJLyTN+fA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ChrM5oIn0Kp9KqDKEyTFkYd+rIXLs65MYC5gpt3MOjUDwy65
	TeYEHVK/02QjaPVy4ULw3fXQncttQ/cxQLlgV7RKyJ1UPxnElnVwqhxEs+q/ZdpWl1Kdir4BJsz
	P
X-Gm-Gg: ASbGncu6pvV+667RpWe3l01yiwZIhP/kOvgjtoEEfGxvLGsSuBpcJR4jx0UGRQ1R0gT
	b8n8c/v8vo0NBmBO8gc7WmHc7aKf879hPV67SoDKu0ut+aeRfkIxexSwc+KVlGF7kjY3aLH1Hq7
	lk2Vw7QAZYUty3mjwTvchCRrGC8IfRVdLy3L6CW1+FvZge6tqevf0QiewqiGhsBoXZkWWNOuc+u
	PsJEmDQrzeDxCZPMmUp3Ad9yoS3lVg1VwFDrlrU7FrGJ6P0T5j3LqtbtFfLtJzgDyltvUOmKp9e
	zO1/Tl40
X-Google-Smtp-Source: AGHT+IFiCl/p3IYycES084OYXO+RLfxfIAwrjHRZBO02W+XePgxGB6wWfZJmSmoP1iB/qO5X5Jt9/g==
X-Received: by 2002:a05:6000:4612:b0:385:e013:39ef with SMTP id ffacd0b85a97d-38880ac2570mr3110330f8f.6.1734131867743;
        Fri, 13 Dec 2024 15:17:47 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50cd3sm2794295ad.137.2024.12.13.15.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:17:47 -0800 (PST)
Message-ID: <032a4fcd-e24a-43b2-8ddd-da43558e23da@suse.com>
Date: Sat, 14 Dec 2024 09:47:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fixes for btrfs_read_folio races
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1734131353.git.boris@bur.io>
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
In-Reply-To: <cover.1734131353.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/14 09:43, Boris Burkov 写道:
> We have a common pattern of getting a folio (locked) checking if it is
> uptodate, then reading it with btrfs_read_folio if it is not.
> 
> btrfs_read_folio returns the folio unlocked, so we immediately lock it
> again with folio_lock. However, in the time that it is unlocked, a
> different thread can modify folio->mapping (like set it NULL with
> an invalidate) so we must also check that folio->mapping is still what
> we expect after folio_lock. Most users of btrfs_read_folio do it
> correctly (retry on mismatched folio->mapping), and this series tidies
> up a couple that were doing it wrong.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Boris Burkov (2):
>    btrfs: fix btrfs_read_folio race in relocation
>    btrfs: fix btrfs_read_folio race in send
> 
>   fs/btrfs/relocation.c | 6 ++++++
>   fs/btrfs/send.c       | 6 ++++++
>   2 files changed, 12 insertions(+)
> 


