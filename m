Return-Path: <linux-btrfs+bounces-16839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A24B58722
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 00:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90FD1B23D99
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B48296BDA;
	Mon, 15 Sep 2025 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dKCk6D/R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75111E4BE
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973740; cv=none; b=AEdxkVEjUcvU4NuvKUzxKYjZ7IlmmeM+tTJO25gwi7L6HtlCbF2rTK2XnVg95WBZ2oZHL4oLQKfpCKhUahvqGSBiGVCVUmN19bHsczWvw8xJHb/XVSZ9AiyeVITK1INnaKkKpfV3q3YoGODVVryHPt+znYeezDdXwgF0x4dTUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973740; c=relaxed/simple;
	bh=ru+iKNroX2o777aIlQGtDswGrT2HCJvH3tsgoAsjM3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OtwDQHauCrY/Ua9JuG64JeEhqbH8mnIgdnOscye3hPKtOlBVl8dKCBGoK/ErubA5z2LyFCSvoXpzC1V8nF2IBbI29zLtIToPQF1BmRNXIBYv6Z2qTXNs1iB6+WfDfHypJPdcxlZDd6cam6GgYTDrD/qdug69Ibwm0KGHmo8SedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dKCk6D/R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2919453f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757973736; x=1758578536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bIqx0vZg8P49uPfpzjl3E1PIsJLm5tqwxYVUcFTMIBE=;
        b=dKCk6D/RQgNN6ZOQx9ExYRX8ofctiGRQcAhAkdGBsPdZGMSx9eKcTgEsuhhEY+Wnj6
         yfyo/Tqg5yErF7aen+lHYVju5E5GUbNFCOzgIHb104+bqGnuONfH9GyHVKchaaYY+5ai
         MNjUx2wid3FmD7iQ0vdFVd3u4mWJ+SHikGSgIv1mMFA4VGScZ4zxVeCuppQwOUmi32nG
         rBjuAjYREj2CXLxvGabDpLU4uWFeI71iC2PwEyzpZIkcdK1YHky8W6cHAOuTlXir3ju3
         qDoDIN2LUt1GbK0qAG4fcjbHZ6PtASQeIj0gVbjVOgILqzRs/vsiMKcRN5KBtFObW/jB
         gyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757973736; x=1758578536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIqx0vZg8P49uPfpzjl3E1PIsJLm5tqwxYVUcFTMIBE=;
        b=MzyVMloeL6+IBvGuTvv9A+oKgqQ9WP6fduqRb2quV7YBWcpO5CflEvzeDK+5+V85SL
         HeWSkfWW5GWr9iQkC7ctRVcXwQXuQJQNbAoaueg9L9VW9xlQ7IeKelDcL1iUmPkF+9q9
         j/z5uHPJyPZcqbVo+93928cRNK+4xqc+TIZrL8dcKKCufVF7/4DTPomtUzpMkCMifoYA
         WxTWvLScF3yjjo3VpLodXFKqldvrLDrUFwi5CJSS2qb7mE8rj4ISiI4BkVEQmrMEqhSk
         TfMWPxBzqaIiFi/UuKDc0xOyYSYPgSGKLUv9y2oGLzEzsXqARTbqjgYgNmbAV9L1danI
         53ag==
X-Forwarded-Encrypted: i=1; AJvYcCViaL57hpbsv8E27Lo0IgiOn9nM179H5r3DsPKtLlGh83oSLcMTkKP/4CfPblpKLp9MorafsEnZfgAUVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RbeBhBDANNfVHhOJshYoWqD3z13729lOC5LnUImHps5VZgPC
	L1fYM5DWJRxzx5ACNu8ilZj0vLvcmVrLVMLNOpnDBxVHTN4Cd7WW/cEu1WbI+O45uDA=
X-Gm-Gg: ASbGncuZ+dJPhs9uELpnVrUPwLqe97AFLCfXtNuFDQnAUxlQpM9c5SsViYqDHGELJxX
	NNHByddR53MY8OL0dv4SCb4UjsqtDAJfKlB2TM8RLhjxjWd4pHxkLcHlauj6hlXzMHvXxlsQq1c
	ggd9yfJngqvzQyfQi6SGmtPVgm8VHa7mU7U1y/EVQcljitoXb3hWiKUmcaWkMQJEU6ZGsDAw63f
	hK2nqKS+ZVZBspaO/yyoVyMTnXaaxSMu+Ts5DR2FhkEWH+efT2RMG2RVuMl+5kJBWWBSljjgFjc
	1sdqxrhSMPgYz9pF82ZFJ1vGXnS40oS1H8n9hBCLa6HeSNiyl3i7BLVRBLGqsPMyQFNx2D7vFnd
	efuiV3j4l43FMoPTMMYrTC3ZUpdkH3BX7fBoLXiBsHvMw+0tWWXsU2wdxKbtVCg==
X-Google-Smtp-Source: AGHT+IHg/mOHsKZdQ4D+lOOMJ13VcPENoXLxb1Cu+p0R5hqBKX3VU0ZhL+bLYxXhWsgJOxEPqmTcXQ==
X-Received: by 2002:a05:6000:4028:b0:3ea:e0fd:28e0 with SMTP id ffacd0b85a97d-3eae0fd2d1fmr3738940f8f.29.1757973735969;
        Mon, 15 Sep 2025 15:02:15 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ddb4f0a46sm15436678a91.20.2025.09.15.15.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 15:02:15 -0700 (PDT)
Message-ID: <3729713c-5888-4ef0-a933-b3f51f74f8b3@suse.com>
Date: Tue, 16 Sep 2025 07:32:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] btrfs: print-tree enhancements
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1757952682.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/16 02:07, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are several enhancements to the kernel print-tree
> implementation. These are motivated by debugging log tree leaves and
> apply to the type of items we can find in log trees, and having this
> makes the debugging much simpler. Details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

The extra attention to name printing (by not printing them at all) is 
pretty good.
> 
> Filipe Manana (11):
>    btrfs: print-tree: print missing fields for inode items
>    btrfs: print-tree: print more information about dir items
>    btrfs: print-tree: print dir items for dir index and xattr keys too
>    btrfs: print-tree: print information about inode ref items
>    btrfs: print-tree: print information about inode extref items

In fact this exposed a hole in tree-checker, where we didn't check inode 
extref at all.

I'll send out a fix to tree-checker so that we won't get possible 
truncated/overflowed inode extrefs.

Thanks,
Qu

>    btrfs: print-tree: print information about dir log items
>    btrfs: print-tree: print range information for extent csum items
>    btrfs: print-tree: print correct inline extent data size
>    btrfs: print-tree: print compression type for file extent items
>    btrfs: print-tree: move code for processing file extent item into helper
>    btrfs: print-tree: print key types as human readable strings
> 
>   fs/btrfs/print-tree.c | 256 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 222 insertions(+), 34 deletions(-)
> 


