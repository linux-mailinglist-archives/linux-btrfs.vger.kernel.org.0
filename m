Return-Path: <linux-btrfs+bounces-11444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4522A33A94
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469083A9319
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C020CCCD;
	Thu, 13 Feb 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iq3wo5ZS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95EB20C488
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437385; cv=none; b=U+QIC45Tc5i6qiqnXv72itgYSIUI3nbQeswudOiC8SA6iG9ZGQ2uFEU2LDDYy81PFLgC/RB/GGJA933j5s9n+bfUnq9/9TZAmH39EGTlPBeK9YZ6bhZG98XCNx+j4v0QYqTDLOufY0OPKq+7+q8l23AL/D51ry0OusYVJtWcQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437385; c=relaxed/simple;
	bh=TAjco7brsSFel2FUEUod3lLMZm5CRiCYppYO6vaABbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiMp+Q7+h4f6h48IdQseBn4naUwT0mQbfqWlxAss2IW8J8FvWN5GC4Palnf6w5n3gsC7WgoYjtkDO5KmC5h8ITzxkZ55NqiDyDM+ZKySSmlPK/ichFTQfpF813+l8Xc+OZPeWIFitD6aewAaU0vKtzMm2ltlFQdNSqkMVtDIoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Iq3wo5ZS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a39e659cso3898385e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 01:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739437381; x=1740042181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/gzmySvA2+T0uLumROLCLv0roFEGFEf5laTHOqnpnU=;
        b=Iq3wo5ZSpAUwGJcuaKtI24W6sF1/rhtzwaANchAc0Tlb2KlxXH2MEA2WmdwATI6dt6
         DcX6mzWGkDWNCr2HnAlBGb22SSnk9bNyuVjqHCBzik+t33D6LNKNGjvNIuhL7pTAjLHl
         tsOuDV7pnP1S5cPSIzZi/GMuePnmnT2FnDRzRvyKm1QGMEDto5Y3XsP4P4Q0rnpUbFGh
         nAI88BwlCWgkXiWNxge1gc0DlHM2/6CcGGKmc67R81bBYUv1DBQidyoiKYCWPgLWdopF
         v7zgZ9mcLocI/Bc+GLWW1QnS7Nq7QtxzWnkUI8RYjB21RH1vK6yKe2V64d2J/uDh/M7U
         tGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437381; x=1740042181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/gzmySvA2+T0uLumROLCLv0roFEGFEf5laTHOqnpnU=;
        b=OUwkDVG+Nr9rgt7A645IQ/Hh30Ry426XdOdaakh6HLNvCTo5G8fPfvZVKhyjrKzfe2
         0maOK95k/gtpkZK1LZ8qA4FG0/SSv6/0SeTWhMoBu7Hthud1zuZFfLwyl6aAE7LZMSJw
         XwwuNezE34JcBpZfycCa2GGnjGbfxRdmedAbpK6BC2qCGgviFR+nUFGJY8ycl044e49M
         Ww65oVpkZ55k+x9AGi56DiNYgCdx6E42FaXT5WktPbTbvthVhPN4v+E/LKuRi0ejBosH
         QB7Cd+DpkH6cs4MruTzrHd6l8C7RKIvIHG9mp4hB5j4oxltGdk1iSGSgvMyfxoCkZGvP
         hq/w==
X-Gm-Message-State: AOJu0YwR/RW1WkDiB246dlcTO9K2tegduA6hmlbwAI+DQlx2/knpGAUS
	GJMCeLW5uOxNOwlmtOrjYJpd403LkSvWEH7H1RGKIYNK7ovyZzF4AH861B9eLjg=
X-Gm-Gg: ASbGncuNnWAk1P+lsG6JPJ0/JmdKZsOI8f3WlSei80oC2YsnI4DQOBVhMDXdxQDXmgb
	FQlINZqBLVzR96LLem9ZGcTVEhph7sIaJL9BDIPPnbiq+FAZsrxCiWhz2RHg0bmAsDgYolgeWZ/
	okPOfeCbGH8Opz244BdMc8mGRFZOD6/O50+bDkAvVVHWlND93EJAL3VwsNMiql7lV8wCQ9rOFWi
	MgsCzvbdxOlfz9gW4eaZkHD6Xi2YaLCAGGdP4yOGiX/vBJV67rVgYdIwBMSdt67GLKX38aBqox+
	fbW3PpWalIec1uk0vDacqbCLM0wUWFMqTdsAolq3W2Y=
X-Google-Smtp-Source: AGHT+IFQvHDRlSfWZTJbqB6B3OQWqnHIS1BDD5iz9Udut2Z9dii53jjyFsv1tXhX7Sy9Vi5Ix+cILw==
X-Received: by 2002:a5d:658f:0:b0:38d:dbbc:3b01 with SMTP id ffacd0b85a97d-38dea2f79f1mr4441942f8f.52.1739437380481;
        Thu, 13 Feb 2025 01:03:00 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364403sm8025965ad.62.2025.02.13.01.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:02:59 -0800 (PST)
Message-ID: <2eb9ad91-9c02-486e-bda5-e213a1828f70@suse.com>
Date: Thu, 13 Feb 2025 19:32:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] fstests: btrfs: fix test failures when running
 with compression or nodatasum
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
 <cover.1739403114.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/13 10:04, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several tests fail when running with the compression or nodatasum mount
> options. This patchset fixes that by either skipping the tests when those
> mount options are present or adapting the tests to able to run.
> Details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> V2: Updated patch 5/8, the chattr must stay as we really want to create
>      an inline compressed extent, otherwise it wouldn't be exercising
>      cloning of an inline extent. So skip the test instead of nodatasum
>      is present and add a comment about it.
> 
>      Added some collect review tags.
> 
> Filipe Manana (8):
>    btrfs: skip tests incompatible with compression when compression is enabled
>    btrfs/290: skip test if we are running with nodatacow mount option
>    common/btrfs: add a _require_btrfs_no_nodatasum helper
>    btrfs/333: skip the test when running with nodatacow or nodatasum
>    btrfs/205: skip test when running with nodatasum mount option
>    btrfs: skip tests exercising data corruption and repair when using nodatasum
>    btrfs/281: skip test when running with nodatasum mount option
>    btrfs: skip tests that exercise compression property when using nodatasum
> 
>   common/btrfs    |  7 +++++++
>   tests/btrfs/048 |  3 +++
>   tests/btrfs/059 |  3 +++
>   tests/btrfs/140 |  4 +++-
>   tests/btrfs/141 |  4 +++-
>   tests/btrfs/157 |  4 +++-
>   tests/btrfs/158 |  4 +++-
>   tests/btrfs/205 |  5 +++++
>   tests/btrfs/215 |  8 +++++++-
>   tests/btrfs/265 |  7 ++++++-
>   tests/btrfs/266 |  7 ++++++-
>   tests/btrfs/267 |  7 ++++++-
>   tests/btrfs/268 |  7 ++++++-
>   tests/btrfs/269 |  7 ++++++-
>   tests/btrfs/281 |  2 ++
>   tests/btrfs/289 |  8 ++++++--
>   tests/btrfs/290 | 12 ++++++++++++
>   tests/btrfs/297 |  4 ++++
>   tests/btrfs/333 |  5 +++++
>   19 files changed, 96 insertions(+), 12 deletions(-)
> 


