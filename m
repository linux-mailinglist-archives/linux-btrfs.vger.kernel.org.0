Return-Path: <linux-btrfs+bounces-18854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53712C49AAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90255349097
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334312FF172;
	Mon, 10 Nov 2025 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dVbxv/c1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF392ED16D
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815506; cv=none; b=AobbjsUYdjF0CXmB2Xhl+7LuqQUZcG/dbqz0kuIU7lgYe4B0eBGRpxlRa7kbLvSRikGesZ6TFqiCZfgq7TzizvacfqqbQHcm5sJmUQjw7OsTiTyVPDRVNfqZk2ayy8R4IKyT7NrwRHRkyxlOAgeA1kRkjN2SAd8DY8DHiF2o5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815506; c=relaxed/simple;
	bh=4Zq0UMva3MXovksJCu4wYZxAeL+wI5UDm9aNQ7yXFnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BR7cz1MKV7eVES6XdGXRodMUKQADAqM2GsoarPPzT1WKOclhLufSL2zSY7jyaCvTs265v44DqmzahEepm3W0BhuooVoQbvmWinDSW4tl7fhNahesfPGTO4dXfLmhGhZcJzrs8Uz49YWecWDkZOEFuwiLbE9Mzi9I1ZoX3iyDDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dVbxv/c1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477770019e4so26688985e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 14:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762815502; x=1763420302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpfmoCs6eAY4BgxtY8OH9Y4P1ZuabskMON+3IkX2SBM=;
        b=dVbxv/c1UZ9s8DvMwHh4ukrWVogm1lMasOfJEgfokBw4BMT4hBK83glJOOoiqlCqeD
         fC8csIjGy0URGz4UomqL95yUJjJ8iGiFh2zR4m356S49ajXU3YePbt/X6ZYcuDGioO5C
         2iUsl9qrMwTWvGbYgOBCFMSr3Hcdj+PMFKqfwSmfaM+a1KJLf3pzrSQG2F02I76M47uc
         p7MXF9PDEnLnInqJQiGTFM9J9ifCTcZs/EIftlQWC9qIUnf+lOULEDs1zONlLZ4sXyft
         eIGkOa8hJXD06+/POe6csHLycrHJFrcttflNDfpNuYaKrQDRE7VlefG1cPWuXfkUZfPv
         2aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815502; x=1763420302;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpfmoCs6eAY4BgxtY8OH9Y4P1ZuabskMON+3IkX2SBM=;
        b=Y6hu1Xe5btb7aZgrpwu1udQT4UcvCMkzFtjUSYQozVEvIEgzIhqOs+yQsJV/SORyFg
         qsNXp9z+G7jCXo3Uvyked5mh9sUTgPKXp/9qJX1H1EE+vN48xzenW/GyLM6Pf2agZo46
         L4isW0TGxgozVuujmtAGGzNvPyG21VG684h18xNnxXiq+3OjsQ7iVtmCZEatUn75LacR
         swj2d+0MS4ySDtdwyFwZfKz2bOC1r8MZun25smM49qrdaO2UceCmeWJgUZEmwIiNZcUH
         SPUDPxy0827G/GjWBIWTzOXuQottIcsne5rKAR920in5BON4hh9CpilQNoGgUSVY0Fxs
         O18A==
X-Gm-Message-State: AOJu0YzjP72hrEwlNY3ryVYdF7MtCoVUhrZH3teW/mou+BHQ7128b5a+
	ZrxXKmeiDsU5CvVvp/5Ouj39jAmPVlzA+Xf4TE+d0+azt/PpGJQ++Ir2cbF3SrCaVOGWn5xQK8T
	ddwoT
X-Gm-Gg: ASbGncvYxW6JH3TlsFZjSmh70Qh2w0v4wrARyX7u7oboTN/sXyhX90Gdq0QLgGxK3lI
	HTQANumJ1tIxdOl3023Da/LSJJLf1wkP2eOnBwyJnMfcT8JwW5E0iJkhaW0EOLuvKr+Yh8SYJjq
	6/eq/zIBtR8HPn4xxONyn4SUoHkTQM5jODYYrVsUfGB2LF8S79dvZn7e4ZXHA4rmTucPbepNslG
	ZpgKWdyU3u4nwmWx2+LLGoE1kNN/ilG/XVVNCZR68GkSQ3WeXK+GskneSpfHM6hKl2CR/K1IyrW
	fwXQb+MwOkh+RKbsiKdrVp/uaTI+5xPlLWXC6sCY562V1zB1rung36rq14pyIF82c1kpfGXSHC0
	VG1GrsvG86oqgWKOjjVmQFPDcXTymlhMmoKB8pbLKILD2Ff+scIwGo2yGyLqrhdjYmOh98ftZjj
	C6tEkQuVrvyeLwnhb3sW0ltT4245ru
X-Google-Smtp-Source: AGHT+IGo4pZOW3UfAmNbDqn1zu4Q3JauZWeIzHzUSgXetvmLWYXRGA1RS+dtR88mzdnGhwtIKUBWtA==
X-Received: by 2002:a05:600c:3b8b:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-4777a53f6bamr68288705e9.23.1762815502137;
        Mon, 10 Nov 2025 14:58:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93cebsm157821555ad.90.2025.11.10.14.58.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 14:58:21 -0800 (PST)
Message-ID: <7970eef9-0771-4634-bb9c-412c5a21879b@suse.com>
Date: Tue, 11 Nov 2025 09:28:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: reduce memory usage for btrfs_raid_bio
 structure
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1759984060.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1759984060.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/9 15:09, Qu Wenruo 写道:
> This series replace the following members of btrfs_raid_bio:
> 
> 	struct sector_ptr bio_sectors[nr_sectors]
> 	struct sector_ptr stripe_sectors[nr_sectors]
> 
> To the following ones:
> 
> 	phys_addr_t bio_sectors[nr_sectors]
> 	phys_addr_t stripe_sectors[nr_sectors]
> 	unsigned long uptodate_bitmap[nr_sectors]
> 
> For x86_64 (4K page size) with the fixed 64K stripe size and 3 disks, the
> memory usage of those members (not the full structure) will be reduced from:
> 
> 	8 * 2 + 48 * 16 * 2 = 1552
> 
> To
> 	8 * 3 + 48 * 8 * 2 + 8 * 2 = 808
> 
> Almost halved the memory usage.

A gentle ping.

Any feedback? Further bs > ps enablement relies on this as the first step.

Thanks,
Qu

> 
> The memory saving comes from:
> 
> - Compat sector_ptr::uptodate bit into a bitmap
>    This not only saves space, but also allow us to call bitmap_*()
>    helpers when we need to set multiple bits in one go (mostly for
>    subpage cases)
> 
> - Remove sector_ptr::uptodate flag
>    We can use a special paddr (not NULL though) to indicate if the paddr
>    is valid or not.
> 
> - Get rid of sector_ptr
>    That structure has extra bits that take a full byte for each flag.
>    This is the biggest space saving.
> 
> Qu Wenruo (3):
>    btrfs: raid56: remove sector_ptr::has_paddr member
>    btrfs: raid56: move sector_ptr::uptodate into a dedicated bitmap
>    btrfs: raid56: remove sector_ptr structure
> 
>   fs/btrfs/raid56.c | 347 ++++++++++++++++++++++------------------------
>   fs/btrfs/raid56.h |  17 +--
>   2 files changed, 168 insertions(+), 196 deletions(-)
> 


