Return-Path: <linux-btrfs+bounces-9924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6949D9E5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CBC2854F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A91DE894;
	Tue, 26 Nov 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GHuXwZWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712A13AD18
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652373; cv=none; b=RVK3QO8rEDx0Y0rA99/fDFKmPZnG4rseK4/yZi5Up6GCtTp0xAPi1XXPyu41DbrdD4/6j4jY9aDGixccJvAXPmRY6ladYMv9qcNqMUZtBfy6wy8+Wh2y/q2j/NdDtNYcgOostD2GgEocZ5b+NHFLU49wBawreJB34YRBxhoRWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652373; c=relaxed/simple;
	bh=12b369pzBQ6U5ajgNObRTLsD38/43bJ8gUC9pORQmX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk1x6o55K3h1f1dxQzDmvTfEpKGsUnibg+jF53cf9TKa2LLp8+6exbcGozBPEdCt75pGPyXKFMKoHIcpzedCQOi0yF2y8U3knaT7jUexSnYaytIIGlBqcZaDG6R99sWgdZhqH9sQMEe8ZUBYPaIM9B9kfmm7J3UN3MqI9y8w8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GHuXwZWC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so55101615e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 12:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732652369; x=1733257169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2dNSUPTomNcRmsS+1bEVJZpFYySMYDqUFlQRzVqiXek=;
        b=GHuXwZWCwcuvbd8Qep5/j6aiHVSB5ZVmhhvZCgOzVdoEng/5XbAu2wcJEUUvLBPmPZ
         DoOS82SfGrH90yYH84J/lr+qQSzfNJiVsyJKKas1ne9pkHuQWD0aPLcVPLHGWp3uNXm2
         G5mJm7E4EkxsS/vNgJYzFECzoiAZiOTgaT7rz9o6E8zfSR6acTjB920cWV0qFv/0SUv5
         ROCpNnWLkzsM/U+fgO5lU0VRDGlKuZPgIZ0c8nnATJ07h/KUNnt9AqcUXGwDJAddEuMT
         X7rf4dwtjAmoNJKcGZynDRFtbhfq/cTIUgeo2/fhA7dKkV80Jbywvpxr9Ids+Fstzo0V
         tdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732652369; x=1733257169;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dNSUPTomNcRmsS+1bEVJZpFYySMYDqUFlQRzVqiXek=;
        b=TP5IiepYO54tp1Hl6HdO9Xtjp1hvUc81CJsR0K8M6wDwPwnmlYp3J0PYxo4mnOdNmo
         dbp42CxyV09D6qSo393rBRdn6QXdrjJSim+Mdqr4I4RBVqaehX3kkrcqM31Vk/1eeCsg
         kSUirAoLxSZjfvXie4TZFwIQW4pvGPhfC1Z03Lfv23fGCF4lhJwQz2yxerzkrC5JR98F
         LkO3zgC/y1LDZebkJVzL16WpJ1WHNyj2i5C5Oz68HKe3z0g1qRjTtIbJmraaWcfm4fTh
         2kXfr/sx84ttPfqYHPRtxMQQN4gtI69Qd0d0TGDEIbE94387fxDRDtlZB0BYaZusKNZj
         DuIQ==
X-Gm-Message-State: AOJu0Yx/S5vl0l9w9xZY/Et9LhUZrBJ0PHfrQliAspe92VaU86RSdmeS
	3s0iejTfyRUTdVlotu/ssvu1SYznphPjxWjovH+fnDZcn7naRItyw0WKWTOCyuo=
X-Gm-Gg: ASbGnct64TvU9dLnsNE/Zy7lDDpqNHaLjbrGmgeT583VVnpV6pk5GlwrMyF+LjFKoLe
	I0XxpBWE1cptCcI1wRbffnqOBADFbVQnPi2mHw04B71kPetwShPdkC7yjPk8E6EPhOCfRGvhI20
	2kEnQqM74QF2AlbjN5lSUupn1u5QBMYhcye3+8ulSRVwa8rQrDvUNkA96DRlwtYWOaHuQXondlu
	z3NwEQ5HkyH8fOhlqJZ3UPE1ey0HsH/eoByV6zjZvGIUE9LlPSqvr7suLr+3tzWLT4Q2bTmG77U
	MQ==
X-Google-Smtp-Source: AGHT+IF8FRNDT4xzDBWiXuqY/LVm7UmzDDcfEG7YVWQ6FtN0imydyLUVn2K2seMNM8rOEz6nXfyCoA==
X-Received: by 2002:a05:6000:1541:b0:37e:f8a1:596e with SMTP id ffacd0b85a97d-385c6eb6aeemr195024f8f.11.1732652369376;
        Tue, 26 Nov 2024 12:19:29 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454bd4sm9072994b3a.26.2024.11.26.12.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:19:28 -0800 (PST)
Message-ID: <e2047224-4fdf-4801-9006-1ef88ec53944@suse.com>
Date: Wed, 27 Nov 2024 06:49:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] btrfs: fix double accounting of ordered extents
 during errors
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1730269807.git.wqu@suse.com>
 <2faab8a96c6dd2a414a96e4cebae97ecbddf021d.1730269807.git.wqu@suse.com>
 <2327765d-c139-495e-94f0-5bab11adf440@suse.com>
 <20241126160817.GJ31418@twin.jikos.cz>
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
In-Reply-To: <20241126160817.GJ31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/27 02:38, David Sterba 写道:
> On Sun, Nov 24, 2024 at 06:01:27PM +1030, Qu Wenruo wrote:
>> I know this is part of the subpage patches, but this is really a bug fix
>> for the existing subpage handling.
>>
>> Appreciate if anyone can give this a review.
> 
> Looks correct to me. One suggestion to clean up the parameters and to
> pass bio_ctrl and read the last_sibmitted and the bitmap directly, so
> something like that:
> 
> cleanup_ordered_extents(BTRFS_I(inode), folio, &bio_ctrl, cur_end + 1);
> 
> replacing the parameters with the values in the function. Though after
> another thought, the explicit expressions like
> "page_start + PAGE_SIZE - bio_ctrl->last_submitted"
> and "cur_end + 1 - bio_ctrl.last_submitted" make it a bit readable. Up
> to you.

This one is replaced by this series:

https://lore.kernel.org/linux-btrfs/cover.1732596971.git.wqu@suse.com/

However I'm still hitting hangs where some ordered extent never finishes.
(At least better than crash, but still not ideal)

Thanks,
Qu

