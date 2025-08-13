Return-Path: <linux-btrfs+bounces-16042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7DAB23D8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995A62A8442
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735561684A4;
	Wed, 13 Aug 2025 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0/ELgzD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3E219E0
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046980; cv=none; b=kHozUtuB8SPFJV1NhSpecrEUk9GmUWvvumRW4zhaiys/y2lv5QkEVx39aiBbJJsDoQ+G0lrq9qjjpsZy8v0vBuYmgdFPKfiyHBIeshatKq2l8VyTTOaMInRgNo5kmlj/oyTYl0oR6HYfwdQWMHZ4BQDEplq0llB3OT6f2NHElJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046980; c=relaxed/simple;
	bh=WaZgsFlIXuP8KUbetdCPbAktTP3UjIkwCZGD8i4sW4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7EbqK1f+nAz6nofeZcs+0GlQrQEAE8e8mrsHywTAk8wZZBcb9XwUEuGvhf3U1iBTIyJPlFdePoXQQ5+PhReT5gW7gqI5kPoMguCd+WUKDw17eKyOE7pBHvctxoDPAVnR+K712UjneNYwQiuPbVfgW3IlnmsiqApNbg4PvOItng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0/ELgzD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b792b0b829so5950638f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755046976; x=1755651776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zuE0W99KIXPnaB7CyxA6UJdnPhMemrEmEb4S2TyDiZY=;
        b=J0/ELgzDBjmeTNQn7xZc/e7081iGnPGcL8vrucJs0WM6xSQ/csYnLfdm09IFzrJd6i
         BK96DYsw7noKZtRuQPRZVP9IqirP16mZ/CY1sJHF3T1qJawi1kfzSoytii4EpLWcSX2T
         M5FevrQoILtGo/l38gmTFylo2eXKhzdKIOp0e5MOQOsuK83PR1FhkfCJ+EClpaC3eFCp
         Er93v8Pzu+tWxwOFQztEYTRoN5Qw7fYPgP1hpingYzt3x+nYxtjKyul5CDLwhN79KMJL
         bSPZdep3XP6Kv4K0HwWLt4+/oU+z9tdMtL9/mYNz3pjcQGRberfUi6S5amj3IYaCLnWx
         Icrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755046976; x=1755651776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuE0W99KIXPnaB7CyxA6UJdnPhMemrEmEb4S2TyDiZY=;
        b=ejH8m6097tIcfK5qs9pydG4JxHIkBvhnSndF9VMULRdzvgDdDdhq6grbvVzSxwkYdi
         nx5DYMeDyWXsQhbflogMOC6peQS16XovpixK15aQ5frEl/zW33J3cjUZLSjL8SxzKyfQ
         yQ+o2gpBFmp0e+A/ACXchZFgZK1/7u6M4KkAhN1CwwtaP5j4Hr4S0rhMcVM1sgd0I055
         LuK9nK9FKQBdrQy/gXuJlVCQxX2cN8D44ld3YALYhqOqBcFm/4u9ZjJN2GmTzRTjmm1m
         Jqckl/yCt5i3kIpYZUPxmttJJ5AZjRHNNiV18xuWAW/qLHOdv3Yu5IRnGMKXp9ZfUzFH
         jNLg==
X-Gm-Message-State: AOJu0Yzoa1VjSc7DN1DufL64GwGuG1/XF9WOy0U8SgI3l30lAD6kDvCJ
	Ni6DTKNsWIlfFr1SIbSZzCH8n/QhX4R+BlzRzFpOmePSGT+ZtaeNW9JsGPTTfTlvT+Y=
X-Gm-Gg: ASbGncsz++F7pmc751/BuvBkJt+PZ0gfPBqfksVxKQO6AeHl9EEFkghDn8aM+Ei1FWr
	Ky6oKOqotprfazaA185lS2HQf2j1Abi8+Gb3AAAT3LoyP5od8boPsLfSoweNROs6q+S49hWVrUa
	CsjJG9nTdzHTknE+SwF+eXFQU5QrnBNNWeH5PksRu/qwK6/vExeStJD0uFciucPbuj4Q4O52BMI
	hZmKCzVS/FiTvKrf8fkTRpr5dHqZWx6pm7vTSkorE3WRAeAJnwMbRG9dQzTihDt0CpzACPCbIYl
	vXwBhavP8DGmhj/kkLfxF8oblaYZfssILyNi78gbGQTI1zQO7J4RkZATIBjP9kwBtaU1LYThp8Q
	O0md7a8le5sukmQcEJbK2Y3ndh3Vmyb9rxTBIvrrOfeCJ95d/0A==
X-Google-Smtp-Source: AGHT+IFvUayhXqY/948LNPEltbDZsZV3H8suj5NT6tihiUnAvgBGn8VdPpuwQNMCp2/xEP23SVXA6g==
X-Received: by 2002:a05:6000:2887:b0:3b7:9350:44d4 with SMTP id ffacd0b85a97d-3b917e76e63mr681656f8f.11.1755046976278;
        Tue, 12 Aug 2025 18:02:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cbdsm311760475ad.75.2025.08.12.18.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:02:55 -0700 (PDT)
Message-ID: <8dcfd552-a339-46b4-929e-f01000a4edf1@suse.com>
Date: Wed, 13 Aug 2025 10:32:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix and unify mount option log messages
To: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 johannes.thumshirn@wdc.com, brauner@kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20250812180009.1412-1-sawara04.o@gmail.com>
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
In-Reply-To: <20250812180009.1412-1-sawara04.o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/13 03:30, sawara04.o@gmail.com 写道:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> This patch series fixes and unifies the log messages related to btrfs
> mount options.
> 
> The first patch addresses a regression where mount option messages were
> no longer displayed during initial mounts after the fsconfig migration.
> 
> The second patch unifies the log messages for NODATACOW and NODATASUM
> options, which were being handled with the same logic but had
> inconsistent and duplicate messages.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Thanks,
> Kyoji
> 
> Kyoji Ogasawara (2):
>    btrfs: restore mount option info messages during mount
>    btrfs: Align log messages and fix duplicates for NODATACOW/NODATASUM
> 
>   fs/btrfs/super.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 


