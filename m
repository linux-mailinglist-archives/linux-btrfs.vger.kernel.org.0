Return-Path: <linux-btrfs+bounces-15068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03738AECB5C
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 07:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F5A175A44
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B191D9663;
	Sun, 29 Jun 2025 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RUE9yFMD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200C7E0FF
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751173541; cv=none; b=Z431Xmq3r1ez7/JSd5VMhAEQxpO+WUqobPsYwu5FN9Ux/+UN/ootNm+f5h2iKGp5iPZ5qUlJzK15wuJlYYj6xbaRFPBa+ifYNpfhuDP2jcgyYwnNEw1AU7ISrpTtYYv+gFbXD1fjaB8iCWuTWiRSKzwFsjjQg9yCzP3EeR0UYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751173541; c=relaxed/simple;
	bh=Ue/W5efR3ZUyfRDr877CJhtn/yC/o+yQhSbXgyHykvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5zfeSsTjV2Cuk3xF6pUXZ4KRg+9fwUYELdOdwR42vlYXKcZjEXUsPIEa/giZl5od4ZOCVKCZoNVgzeG6HLuHTvPZMkg0tOBXpi4ldbFL1UaUcs2bZfIS5Vq3h89wIrRoum9xusyAyw8D5sBfSwV/sNhV+6y+JthFsvGTpqUb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RUE9yFMD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a52874d593so845753f8f.0
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Jun 2025 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751173537; x=1751778337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb5FHZt69bViccyG3ZRFxBOBsZOgDDUL9VQu65hjfpw=;
        b=RUE9yFMDNxgKuPNnRDWc8FTx7JueU4roitNDK64YOA1cyVNzB0tfcjBMf9Qhqhfd9d
         5FLQfb/BlQthbs1pDcREhV9pLXFZFzTN/30546LFMFmC64U/e3B/MevYtTJfUFRYmLCj
         Ufi+FbUqLatZE1c9tEjOrBOqcb3Fq/PayLP6GILunKFe6rh9PKDa4JW6GdpOsJISDqHW
         RhbI8VYNJzo+n+s2MnsM6VPOPU/ExrcN45vQOfYUQiZB/y58IeebfSdpqY+NSNsZrLWO
         QsvoCsz5NkVT/szFPUaphnsOGoDd1W2DJbP7lxypFXiwaojxvMB+EnKe97CDUOSIb53g
         aFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751173537; x=1751778337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb5FHZt69bViccyG3ZRFxBOBsZOgDDUL9VQu65hjfpw=;
        b=Df0sSNSA0XRgcas4fhNNw4YWeJy5c09oISqkfFsv/63SHEQz3VALK+RhuJuH/ve02g
         f3ZIsjUtoYLjWIDa9d2cjJww4lz+jvgYzQgt32t0FTuGKLsMFv51sFdXBs4YAMPRfpi0
         bT2XmMlQ8dHMScieRoFxHffIe+BUpDzVXgy4z5mAg8z6snqojwOqJBfgz5sUlLnaeiwv
         Jsf26Ld/9+YErubIxyE55wu3rR4qVe3mHO8vSSgOvW1Akw42/+ZOKvPYxIaebk5hz8Ka
         tdIKUaG4TavcBTuZkAIEwc6KShp9/BaXjQMPPGscR0RQFd6VQ69Nn+1yWBWwaeSTfIzj
         3h3w==
X-Forwarded-Encrypted: i=1; AJvYcCUUkm7Kr9RQi0mwLG7dGLrA0dkxeZYYtxTCihIOLoQ5l5Fbuzv/vtUyAFLhLWIwNZVHKehET1OuRQxljA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycgbQK9hmkLa7TiR7Xncf8Lp3urnpPZRnOujPM7qkX7kpiKHs0
	LM4NvY9DFmTGPYmt/Dbx3nnUS8Nl1KUM7V03C0GJ1ne5nrv2zkZnhtBrRzv7+CHGtLuLsrzFpRV
	YQAq0
X-Gm-Gg: ASbGncsN80w7Xs8/qYc2p97TMbzttEQmJODMEncVA/msXbDIDrXncxHxmYNDk1DMd9w
	dEnwzUGgK8O/2PSav1Q7buu19n/E748C67H3WGCJgqw8n02UO/+tGbe9unc1bSs/2c1Dd9s+ueM
	EcmaJKx32dRXNyWan4gCLo6+F0hjbjV1ymmGSfKX4Wjf6Hy3kzqeXbyQbam/5CPVDdlu/ES4GeC
	iu4JN8UTx2zhzq5K1tdwCg4VfnEvTqSz4QAFYaiUUblwHsJITd2DO1ltMOVFdzuncNx4alG6eDf
	q7Xl5z5ItrLluBRzcmiyvYxoC6rYhGri2HM+pn6HOsNURepCUO7IwNwtstm+1V3pzlPlFfWY2T4
	imDZZLIGMLEXBcw==
X-Google-Smtp-Source: AGHT+IFkOJ0/nDWij2eK2pF1W/YuodMCeD/ZrytP6UkIlm05Wh4VH0AchsgOMKw5nwR/Fe3NcMlR4w==
X-Received: by 2002:a05:6000:64c:b0:3a4:e75f:53f5 with SMTP id ffacd0b85a97d-3a8fee6504emr8092587f8f.35.1751173537192;
        Sat, 28 Jun 2025 22:05:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f467bsm5924382b3a.170.2025.06.28.22.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 22:05:36 -0700 (PDT)
Message-ID: <66c06601-94ff-47df-a951-157a1315aa99@suse.com>
Date: Sun, 29 Jun 2025 14:35:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
To: Hillf Danton <hdanton@sina.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com, clm@fb.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <685aa401.050a0220.2303ee.0009.GAE@google.com>
 <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
 <20250624235635.1661-1-hdanton@sina.com>
 <20250625124052.1778-1-hdanton@sina.com>
 <20250625234420.1798-1-hdanton@sina.com>
 <20250629050000.2069-1-hdanton@sina.com>
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
In-Reply-To: <20250629050000.2069-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/29 14:29, Hillf Danton 写道:
> On Sun, 29 Jun 2025 13:57:43 +0930 Qu Wenruo wrote:
>> 在 2025/6/26 09:14, Hillf Danton 写道:
>>> Fine, feel free to show us the Tested-by syzbot gave you.
>>>
>> Here you go:
>>
>> https://lore.kernel.org/linux-btrfs/685d3d4c.050a0220.2303ee.01ca.GAE@google.com/
>>
>> That's based on a branch with extra patches though.
>>
> Thanks, feel free to spin with the Tested-by tag added.
> 

Normally we only add reported-by/tested-by from syzbot when the 
offending commit is already upstreamed.

Since the series is only in linux-next, not even in btrfs for-next 
branch, I believe no tags will be added in this case.

Thanks,
Qu


