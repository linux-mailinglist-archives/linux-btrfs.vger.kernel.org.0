Return-Path: <linux-btrfs+bounces-18519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 518FCC29DFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 03:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B78E8347413
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD1285CA4;
	Mon,  3 Nov 2025 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fu0jriVc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD52857F6
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137543; cv=none; b=eYfg7yEAQuW1s1lXb/10f+7xOgvr2uQR3fHMAaIBMEEpGiNc5Rehp0ECnI4jEWlmE7fsl5npGfwFlb3LP9/hlvL9ZyxjhVJMvjfkN0hhIsy/dMZEVHE6SB7kgRtOPyNL/QWLXI4WYAxioNKdTr14uDXjx3JdbQSKNdrSrnnJbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137543; c=relaxed/simple;
	bh=OY9g0G0hsrXbhaPQ2w6Fvh4d7L4QI3hlyibz58/LJqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zh7WxO3j7Gdn8f2ZbbATM8w+OEIK+Q8ctdlLkECuYCRiru2iIX089dOxsYlU3nLaJoicpQAWRUpCCgDVhWWqdhNets+Ye+E0FhbkTBa15nY1LoMU5kolIHso09KlMluLvI7Hpd3BbEyP64ZqDoVxVzvVwNxUjApsVo8shiJdn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fu0jriVc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2419570f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Nov 2025 18:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762137539; x=1762742339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hlm3/kjrLiZguynFuGksq5XBj69uU1SnB2Ycm3MMX9E=;
        b=fu0jriVcgPbQ8Dqg6cptAEsXfvswC5NpvTu2kIjrV1X5uCsoyn9I7DT/MCITRoyc7r
         hCtbWhryVrbbqSqMpmBJqYaSC3qEOOwOue8pMrWMV5JxxEDOmsPLb2uEINHOAYnEUc7o
         ZqA6LDo6+OHFmA2+ywwMAqLJNPRcTveCCOh35cIZXm/mVVlueaogGPuwjtht+3G2Funm
         I7pnzZWp5+2lNx0bGEgeR/U7wGZTW+vosXKgwdi3NtSvUMjg3sPSKVMCuSXflmUP1If4
         qOVNcbmQw5qsvMgFIQMovD6LSz2WQ5Mdh86w6ojUJN4G9vwdRtst5s10qYSj7MSDC3Z8
         KOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762137539; x=1762742339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlm3/kjrLiZguynFuGksq5XBj69uU1SnB2Ycm3MMX9E=;
        b=InZPcXFA2zaYTa5eWE4tASo6TImZzojdZbTKSEKouzK9oV0YFIvu38yKNKWp63pGAX
         VNAbkavPejNTRIll3ko0vkIyP0BeM6RAY2amx3xIzsL7O8f/dAHfWp79GRgtSSc4dx9A
         pTCnA4GLoYz2BV16XHoR2gJBDQkSmqKxiI840RA0S0tMcjLFaWSqax/VqX1OjqF9ubhy
         MnNWb+tzrpFyWIl0A73ryuKGj50GHY7KqdMlGhRtz42E/5rE3s2b+SC9L04WpMXKN6bj
         5AzHvB9zhO4UQJO8jiI5oksuoWnF8WrzeFHbwquoggIJQQml7GzJTneSUaWRbzDP+HrM
         ofdw==
X-Forwarded-Encrypted: i=1; AJvYcCWMN/1spE5Zk2eT5fc6gk553sqxhJrk3aR57BOdUvyJ0Do1pJl/9vZhjK9vpNmaAFhBVA4zmLm6B928tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0vzWJV8Ulynmv8bYnAJIbNiPlM3JT038+1CI5dfVsORDbLt6
	KRTTXG0wXcrJsAlpRhTe3uNylJMV2M6YGHwSdrqLNanhKAJAoktfBXxKshSLBxAvGhZblsi5fzT
	c+SF8
X-Gm-Gg: ASbGncuq3x+Z/5O+Wo4TSHsO3cr+Cke9y8BsxIyDF48IeQYFI4NKquZn9sLPAEssu73
	bdctc0bTRN5pOU5XTdGQFEHngxiuy9H4zKII9VnPmzKsBKFCsxAYwIgrp28QhA2PNue9CcUUNgc
	BmcjUJO8OWdjzKkLVD7Rh8cUnkuOpp54RF9G/r1lCTc3QhJaicDWr0LvYqx0/l+AYzvDaIK1XwC
	1XfGs+1Q6+CAwy2Mqn1aR8+hxM59RhKY8RLaE03kAWF8+YoQ3YuVfFAbpmJp5SHKyAOVgsMYXpj
	6cbeHzBtSepVpAXkd7KtxQrbRHKcvukvXhSxgMEWogWFunGYmiB8o3/QUxa63B5+zQh7beB8pCC
	BzUnNjs3HLj/cx0nTagA/imUlawgXAylaZwVcRB17umcf7/HtMPdgjS4qAkxeXDuNX4XG0lkuDA
	zTZ4SPJ29SJkmuty1xbJ/wvpLV/cOVd04h+B63ZVY=
X-Google-Smtp-Source: AGHT+IHInvdwJN1Qqx8dM+A3ZRDBTmSr5y/QkF9mFS+2l6sXK674mW4vhk/NovOmsfOiBeURf2jzsw==
X-Received: by 2002:a5d:64e7:0:b0:426:da6f:2930 with SMTP id ffacd0b85a97d-429bd6a4473mr9328964f8f.33.1762137539130;
        Sun, 02 Nov 2025 18:38:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aab38b4b83sm2581080b3a.19.2025.11.02.18.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 18:38:58 -0800 (PST)
Message-ID: <1c419b6e-61eb-44fb-aa32-c31afd901497@suse.com>
Date: Mon, 3 Nov 2025 13:08:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs bug: SysRq-S SysRq-U don't sync btrfs
To: Askar Safin <safinaskar@gmail.com>, linux-btrfs@vger.kernel.org
References: <20251101150429.321537-1-safinaskar@gmail.com>
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
In-Reply-To: <20251101150429.321537-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/2 01:34, Askar Safin 写道:
> "Press SysRq-S, wait 5 seconds, press SysRq-U, wait 5 seconds, press SysRq-O"
> doesn't sync btrfs.
> 
> Here is script to reproduce this in Qemu:
> https://zerobin.net/?677f7ff6c348d96f#Ka5RFMytXRmyvrwPVp1wuMAgWzaunkJ1+A+/5ahVn2A=

Confirmed the sync_fs() callback of btrfs is not executed for the global 
sync.

Will take a look at it.

Thanks,
Qu

> 
> - The bug is reproducible on current master (e53642b87a4f)
> - The bug is reproducible with btrfs, but is not reproducible with ext4
> - The bug is reproducible both in Qemu and on real hardware
> - If I replace SysRq with "sync" or "mount -o remount,ro /disk" command,
> the bug disappeares
> 


