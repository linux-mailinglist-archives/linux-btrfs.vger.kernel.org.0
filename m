Return-Path: <linux-btrfs+bounces-16811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB5B570AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 08:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1115F3B6A2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C42C028E;
	Mon, 15 Sep 2025 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OSJrx71L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363AB2C0292
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919230; cv=none; b=oy60O3VZhI1TZO5sRm85JRpsBXHE9rc1dfeO2iaeu5AVVx+pTLPXL2yHNWeCLmUFCnq7lVc1wl3B03BZrPW/4jHwSinUAG0MwVogFW1x261RHckH0YqmHXiLUPAbH19rmkfIOC5EnuzMoNghvuzmaqCy2vBPzHH76rIcD8HCxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919230; c=relaxed/simple;
	bh=f4s/6jqWLBsvkwV9XkPsk9Ak93YUa7YpcwmSAqPJ/ac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=m3sE8ts22p9qO+lU3vAGyCS87Id/wNe6Bu7vPgrSc+d6U4Tx3Bys5uKTWDpMInDvDEJ0zyj0jbfTbRxD+IBS1FgmGqzikz3ZIv5qDwZgpEB44PSkKCjFTPFGfK2fFex+cw9sfCT7e8PIFbEuhDcjG/7kaKdCvqv4MsfrkZEYHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OSJrx71L; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so273031f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757919225; x=1758524025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kt+0bn89xYkR9u6hv3SgxCCuB5TnrLHBR0iySPOdd6E=;
        b=OSJrx71Lax+R6W3JzVKmQRBO8pBfunLKcReUZZWqhxd8dK40KTrvBbDsK8fNzJWdFb
         VxgU28iaIBF5m6hNNdXYb1mbm5o828SeHw4M27/q/333eKJ7eY9mnUhmRocjnNnatTRK
         DhmtjVlKCzbXUrHGh6IT9IHugU5haBF0FlW3BapgfL72l55GWicdlop0UphKwWnt3Twe
         0T/tlmDe6MDNVpMirmIU2+iPjoF6sqW5k3Nkh9KwpLMX1cu2uf4xfT3uFPSds5DfgqXE
         vzbUntFFQJ5lGv/HS8l/bHFqHEm5DPtraoupca0qKyWgbq5EvIdvOOcIXtJgZr52aRzb
         TFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919225; x=1758524025;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kt+0bn89xYkR9u6hv3SgxCCuB5TnrLHBR0iySPOdd6E=;
        b=XvPJyWYy7l+1d2jOpyWmedqp626lyeHVN3Av+Yty6txbqe7BONbZkndr/OKGkSXR2A
         Op5O2r4IjBqZ62+BepwPGdk21spyrHT04mezuU/CeuRjty9YxGIxZsEsAW1qQm9/2555
         L22t7lnE0KJ/0l9RWxP/v2A39wkz5l4CBvhHlbf2uItzJSomrTtTB3Djry7iqjtSwYQP
         AmIXBtGAvDZ5e+nIMttzqkjmBw2aQWxcuqtMCbILo6dMbb6Vo5cNOrIIxLkNrtC+cgyg
         KDTtxGGKwaEdlgq/b6m4k+9ol978ICbs9VodK3NSXIZlOEdr+nwV5nEl6NPauJ0jphCi
         nGLQ==
X-Gm-Message-State: AOJu0Ywz2YR11yqEQCZZ1FjGX/nxCohGv6WPUAh68qW0rgRcFtruktuf
	aeBbpfNdWu6BzUNil3tKgN0ogbQNqTzfndhXicvEhl30elREUzXkLQ3W+ybY8RMlth4afvXA8+F
	NI8Xc
X-Gm-Gg: ASbGncvdK5T3CCIFn+47EarvcE+/1P5EhEdIpawEkjGdrARywiGEvzOVCCfDtBnwxNO
	iJnXo3kRIYP2xAkQQM6MZ3xXcUFiC6qv5wVNX373p28nMW8jLmfanhIk/sLlzKKwmLJt7OXlDV2
	xUSKXl5wk8aTq4b5WxgQbAjD4JykMG3/QII2a8yfPP2gyDxbPW3flHGwejfc15OmzWoyTvh+RvF
	04S1gd/qYl7YrsaQXY7+t2GV0CdU3d1R3jpDHIcls18ynTncYlqnyCj6lZ85Ut+ZpnjG3izwgQ6
	mFrDMxZ8RTWGFdgdiI5YJNE2jToufPe6Uj6Xj4EowEILpo0RhUkOGwvfrvzhOlSlZtBYvqB8oey
	2zddTBsXMqpqZUeLVgHwKV7YXox+faQNOGoCKrOwhbEGEmJos88N89sQpVEUs2Q==
X-Google-Smtp-Source: AGHT+IGuzCF0lgz3bWyqIpzHTfY2REQr8jlR51d0dsV/+fefKOFCUiiDKovfzQ/sxAVOURVpvNQN+g==
X-Received: by 2002:a05:6000:2f81:b0:3e5:5261:9fae with SMTP id ffacd0b85a97d-3e75e0fd387mr15523543f8f.12.1757919225377;
        Sun, 14 Sep 2025 23:53:45 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b307225sm118331615ad.145.2025.09.14.23.53.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:53:44 -0700 (PDT)
Message-ID: <0998dcff-c3f5-47b3-abe2-b16b818fbd7b@suse.com>
Date: Mon, 15 Sep 2025 16:23:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: prepare compression for bs > ps support
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1757481354.git.wqu@suse.com>
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
In-Reply-To: <cover.1757481354.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/10 14:48, Qu Wenruo 写道:
> [CHANGELOG]
> v2:
> - Fix a missing callsite inside btrfs_compress_file_range() which only
>    zeros the range inside the first page
>    The folio_zero_range() of the last compressed folio should cover the
>    full folio, not only the first page.

And there is a missing call site in btrfs_decompress() which uses 
ASSERT() to check against PAGE_SIZE, not folio size and can crash 
btrfs/056 during tests.

(Yep, I'm already testing bs > ps with fstests now, and it can reach 
btrfs/056 except a weird crash in btrfs/004 that I'm still debugging)

Will update the series when no more compression bugs exposed by default 
fstests runs.

Thanks,
Qu

> 
> This is the compression part support for bs > ps cases.
> 
> The main trick involved is the handling of compr folios, the main
> changes are:
> 
> - Compressed folios now need to follow the minimal order
>    This is the requirement for the recently added btrfs_for_each_block*()
>    helpers, and this keeps our code from handling sub-block sized ranges.
> 
> - No cached compression folios for bs > ps cases
>    Those folios are large and are not sharable between other fses, and
>    most of btrfs will use 4K (until storage with 16K block size got
>    popular).
> 
> - Extra rejection of HIGHMEM systems with bs > ps support
>    Unfortunately HIGHMEM large folios need us to map them page by page,
>    this breaks our principle of no sub-block handling.
> 
>    Considering HIGHMEM is always a pain in the backend and is already
>    planned for deprecation, it's best for everyone to just reject bs > ps
>    btrfses on HIGHMEM systems.
> 
> Please still keep in mind that, raid56, scrub, encoded write are not yet
> supporting bs > ps cases.
> 
> For now I have only done basic read/write/balance/offline data check
> tests on bs > ps cases with all 4 compression algorithms (none, lzo, zlib,
> zstd), so far so good.
> 
> If some one wants to play with the incomplete bs > ps cases, the
> following simple diff will enable the work:
> 
>   --- a/fs/btrfs/fs.c
>   +++ b/fs/btrfs/fs.c
>   @@ -96,8 +96,7 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
>            */
>           if (IS_ENABLED(CONFIG_HIGHMEM) && blocksize > PAGE_SIZE)
>                   return false;
>   -       if (blocksize <= PAGE_SIZE)
>   -               return true;
>   +       return true;
>    #endif
>           return false;
>    }
> 
> The remaining features and their road maps are:
> 
> - Encoded writes
>    This should be the most simple part.
> 
> - RAID56
>    Needs to convert the page usage into folio one first.
> 
> - Scrub
>    This relies on some RAID56 interfaces for parity handling.
>    Otherwise pretty like RAID56, we need to convert the page usage to
>    folios first.
> 
> Qu Wenruo (4):
>    btrfs: prepare compression folio alloc/free for bs > ps cases
>    btrfs: prepare zstd to support bs > ps cases
>    btrfs: prepare lzo to support bs > ps cases
>    btrfs: prepare zlib to support bs > ps cases
> 
>   fs/btrfs/compression.c | 38 +++++++++++++++++++-------
>   fs/btrfs/compression.h |  2 +-
>   fs/btrfs/extent_io.c   |  7 +++--
>   fs/btrfs/extent_io.h   |  3 ++-
>   fs/btrfs/fs.c          | 17 ++++++++++++
>   fs/btrfs/fs.h          |  6 +++++
>   fs/btrfs/inode.c       | 16 ++++++-----
>   fs/btrfs/lzo.c         | 59 ++++++++++++++++++++++-------------------
>   fs/btrfs/zlib.c        | 60 +++++++++++++++++++++++++++---------------
>   fs/btrfs/zstd.c        | 44 +++++++++++++++++--------------
>   10 files changed, 163 insertions(+), 89 deletions(-)
> 


