Return-Path: <linux-btrfs+bounces-10447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA239F4191
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 05:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3BC7A5AA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9166146A6C;
	Tue, 17 Dec 2024 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PZQwnpkU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F3335C0
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408543; cv=none; b=nN2DnOIUlCew60bXTDymul6BIq1Ot7XEUumFz4s3dpQkfQkQk3tDS9QXTX1K5XkA6PUKP3vTHq1VgKPDKUKcN3C/9UdE5inGD6RGdoteOwoFao2NmTVscegaFR+0qEC5SDaiaVwepe8kWA8OeW7U6dXEU/48sAPMn78h06gjYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408543; c=relaxed/simple;
	bh=Z/PheDAYIjvEj96bY8LhjKyxyZeAfoZtplgwYOlZPCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAje3htacLOACcEzenobhK8+K6Jx8+lTaLHaBO4MTSuStAE7GnyDuJAw5dRfQYkwTuSY3bpzkzoeR5CZHMbxNEsJvUXnlR9LsOqtkIyeeZagAAIexucCmILaXKkDOSS28Whx6lqYiDknKRajKMJsL+jFKiLva/sU3gxO0Z/abgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PZQwnpkU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so2620149f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 20:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734408539; x=1735013339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w0q28I/U11hZGhYZ8I7aAe/H4dRhF+av7O29AlA1BCU=;
        b=PZQwnpkUGmt+92iCHFu0kqj+boi+yqbii4covXaA54cViJnETua2icN1/yt3USrMbB
         XNZpgOME+4MW3w5iTiDRqV+q2ow9psOgEFDQK85mYQx6KRq7mLNIVDQQK2IP5LvdP7uX
         zogzs23gRjQDVMI4B3mHf4EOHkrLYlsRxIOFcBBN/ppI5fvbwhmebVW8qcNJS7bE1fHB
         NroSF7n2x6GPttlMiqyc1l7RB6OfkuoSYqZP3G67lp9sX0yI4fud9JNgb+Z3DL0TkBhy
         Ql2wT5FUM470a36Xf1Pf2/colPXqLcKKlH5RLLmk/XD3Utmy+d1hPBVxlm7BVY3O2yTO
         MLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734408539; x=1735013339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0q28I/U11hZGhYZ8I7aAe/H4dRhF+av7O29AlA1BCU=;
        b=uqS34/mk8scp2LocIRXjcWwSEVlXUDym2cvq7BnvIWKcQtaS/3GGeeGev54hG3X6QP
         jt0ud7nFUpaQWmMBWC79IKIHdlCKBclAkvHV8a47C32XBuvH38Fjat5NYhnpqPUMX49Y
         q79t5etSm5lBHH337tr4O9ppegdmNafmvZGVCII8FxPq7eNZPHMvusqb8wHiOfp41dBz
         3PUFjoclKWCUPuPKvtyQ1zEolrxZnyG/0dlyJmbHu7YzaVm+TkoFiKb6WPoB3E1BxYH9
         c3g2yr/FM9IUFJKJh8NxrXeH7C24bZrTE+qUoUCBwIqX8TYCn1Na2OMxz2GGeGDIMY57
         +4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe7Yul86AGEcampip7xjSvpvSHbV66fKK0PxlRUrJiKWkftfDiX3Zkdnkig8o0SgZbhRTrfjJEaDXt+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpWUdbQxjIEuFr/u7dprmKX9n6womkq5fJlQPoBJkAzNoLQXp
	QhwChU+LTCaMmUo/hM8pMWIVyBScrveu0VqPucx48DDja8k/y7v7GPDHRIy2moY=
X-Gm-Gg: ASbGncv9R+tC6GCcRkMlCUrg5EK4KaZ5ekZw+GikbmZmHmE8CVThBJtNQML5Bj7QOek
	UPf546QbHHcvNf38NiAGyALzNoyAwbOf3ko/wyptUSlFlrXyeRw4W2wBi7b49B4fr0aJBz9pGrA
	6pJuMOPn7ywsW34aCoqs+g43rs1kUW/zqIQhEB2GSDp5NW0hQqnOAuTVj5SzbixN8/xdFB34Yve
	+FpzFaB3ViWhIewLyAT7zZA9GYsceWTp/tyOC2FsRshBEM3c+vAGyOXJhyqoFHUoMGF5e0TDkRS
	wMZqOXDY
X-Google-Smtp-Source: AGHT+IEHpSe5nckIHFWi3jYVMHcEGf/xRuFenTo7wxpGipHAbQu/OKdnn8a+zuobFOzRBTTwHgIb7w==
X-Received: by 2002:a5d:5f55:0:b0:385:faf5:eb9f with SMTP id ffacd0b85a97d-388da5b52cdmr1587298f8f.48.1734408538434;
        Mon, 16 Dec 2024 20:08:58 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5ad227csm4840128a12.42.2024.12.16.20.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 20:08:57 -0800 (PST)
Message-ID: <89d00b31-8e76-45f4-b84c-24cbcdfc559c@suse.com>
Date: Tue, 17 Dec 2024 14:38:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] btrfs: some header cleanups and move things around
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1734368270.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 03:47, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Move some misplaced prototypes, macros and functions around and some
> header cleanups. Trivial changes, details in the change logs.

Except some minor comments on possible inline functions and a possible 
optimization using mem_is_zero(), all mentioned in the corresponding 
patches, the series looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (9):
>    btrfs: move abort_should_print_stack() to transaction.h
>    btrfs: move csum related functions from ctree.c into fs.c
>    btrfs: move the exclusive operation functions into fs.c
>    btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
>    btrfs: move the folio ordered helpers from ctree.h into fs.h
>    btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
>    btrfs: move btrfs_alloc_write_mask() into fs.h
>    btrfs: move extent-tree function declarations out of ctree.h
>    btrfs: remove pointless comment from ctree.h
> 
>   fs/btrfs/ctree.c            |  67 -----------------
>   fs/btrfs/ctree.h            |  29 --------
>   fs/btrfs/extent-tree.h      |   4 ++
>   fs/btrfs/free-space-cache.c |   2 +-
>   fs/btrfs/fs.c               | 139 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/fs.h               |  24 +++++++
>   fs/btrfs/ioctl.c            |  91 -----------------------
>   fs/btrfs/ioctl.h            |   1 -
>   fs/btrfs/transaction.h      |  18 ++++-
>   fs/btrfs/volumes.c          |   2 +-
>   10 files changed, 185 insertions(+), 192 deletions(-)
> 


