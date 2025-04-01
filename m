Return-Path: <linux-btrfs+bounces-12734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DBA783FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F461891635
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19144214221;
	Tue,  1 Apr 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RjX/dmWG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D64207F
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542534; cv=none; b=G/UQB//AacaQ52FxI1xtFtFWdqA3wGz9ew2uKR7GlO3FYP5xPv2KyTborBe8xnP/8IQBN4ey5bsDQO41l+1QxB9zoSdAofzGHOEzBde6OcX346QI29+ZlCJ6wiAThfwuRmWVIL0fiY7JUNu+t2WGcQGLKPdQWtHAaOgkqdszAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542534; c=relaxed/simple;
	bh=kjmdSn+NaP6+tBxRfCQZaqKvXWvziLerqQAsHRuT2So=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XfZGwCw5iucb0de6eXSQKLN05g4zJtxMUymTezpGwYvTyMXUFyF/X3utrZQnb/hOneW4vBc6CD1OPEZprQfrV23FDGuk+dX90AyQZCO57qovip2Bgc0huZg62ZuePIh3OwRQmW0pHTZxg3GGWtdwWijsZ0aHBYPwdkbvboq+OAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RjX/dmWG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso45182085e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743542530; x=1744147330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/viWeGrcserzq0O/aehARUu1DNHErfPR5+MAlg7RbfE=;
        b=RjX/dmWGjJJCLNysh357CPIfa9DzqF/4smCHrDGmKJE6cLdocXWr+ab780Gji+GK4c
         oq+8xweeJj5s6J/Pnltik6rwIQw3MAdYyk9wQVarj5g0G8HMM0pRVMY/dzMPYtXTVK4y
         rqzr5lj9nWzxm1SSzsHaAfmUgvQzdjNx31WykCQVfHVHLhE/2TNAsbmXfow0tyD7MCOW
         93rbiH8LK6nwiITRnKQDi7zOpyEnjeMFe4HBZ0XzB+3V6sCph06PCCSn0P5qiXEkiRwU
         /wsCHeMuLnAI+4KNOFWaR1NGQjJu3v1P87r05B0uFr/2DlVCBJYcV1vfLWYEedqK3W4D
         rJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743542530; x=1744147330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/viWeGrcserzq0O/aehARUu1DNHErfPR5+MAlg7RbfE=;
        b=USdUJtMsRJti3k6YX6nK0uSTtPlVVARTc+8gyfKs0gP2qdcGZU1qygpg/Tk/9aWRxP
         uO+v/UgrT4jDb/4ihyGIe4phvVkKo3nQ/RGAw04aMYp0OZKCRwzes0oE3jjtvyz7XhA9
         iX3G4lzt81DbOy1c4Fj2XxeH4XaxzgRa1FHZ4njPVrABw7/HSEfprMJD1yS4pFYwSBJV
         zMhR9rFx2KHU88eE+CnXUcxWc6ogHmGx2Q7V/OlhA9yy69WNcGONIhg3sR2qEdSxGO71
         bNEGtFeIvDSspcZ2x5DZdCmaGXzzsQ/SqcR7xaO28tPTAwyCR3pgWFS8gO0XfF8Beuof
         rlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2KVoz3xFllMtG3+ITLZ4QFDqipOGsb8p8x03IAqUpHmA/MNVaMfzNQ5Dn6yWYlnek7Gu5QCCdjdSdqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Iph8J0gUbpOt+dR7rltJSXzPdaUTzUsh/uTVCgnNg/BvjBFI
	zcVBGDUBiXdQh/ZnyTBGdBjP2t7tZZrEuKcq7VnvkbCNCVkYjphEPacvTNzC0r0=
X-Gm-Gg: ASbGncuVc5BQAo2sYkplgZo011oPKFB96SlI5X8k0rS+zSyC08iyW4jWCymZn3iqxcG
	r+pEUBjt+sRKkTpZQjdBashN4wHDCj+z1aioSmEcLcnr6wbJ8iCHU8trLZ31Mcqqqn+WD6JGaZK
	WkOgyyVSQA7eoDiI35R7htdgHUxc0uNrf0ea1fsPDbzjVQcuPSxLb/CqsZzN6KTAkCPWPeo3USl
	mwZobZ60secq6QJ9xsd+bdMukY5Xyjt2D9pyv4rKwUw1mCJ2urdwzLSzprxPI/Qt9Qo0qKi9TNg
	ZbHqCIBjXadSClqYOheAfkMNpvtWexn4+YvwEatvVJOvIlsCpbVwlC4iW8DZQiTXDJA+4EfB
X-Google-Smtp-Source: AGHT+IHh1TnpXcHN6sOU9FA3FqimVnboCFcisy+ShXW1Kk6+IffC4Fyo+cNfE9n4yKvWeulxiED89Q==
X-Received: by 2002:a05:6000:40df:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39c23646ffdmr3780438f8f.9.1743542530521;
        Tue, 01 Apr 2025 14:22:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f83c9e7sm35058a91.16.2025.04.01.14.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 14:22:09 -0700 (PDT)
Message-ID: <2cd112e3-8b0c-4cff-98b6-5a0f59336d8c@suse.com>
Date: Wed, 2 Apr 2025 07:52:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: some trivial cleanups related to io trees
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1743508707.git.fdmanana@suse.com>
 <cover.1743521098.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1743521098.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/2 01:59, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some simple cleanups related to io trees that are very trivial and were
> initally part of a larger patchset. Details in the change logs.

My bad, didn't notice the v2 series.

Still looks good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu>
> V2: Added patch 3/4.
> 
> Filipe Manana (4):
>    btrfs: use clear_extent_bit() at try_release_extent_state()
>    btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
>    btrfs: use clear_extent_bits() instead of clear_extent_bit() where possible
>    btrfs: simplify last record detection at test_range_bit_exists()
> 
>   fs/btrfs/extent-io-tree.c    |  8 +++-----
>   fs/btrfs/extent_io.c         |  2 +-
>   fs/btrfs/inode.c             |  3 +--
>   fs/btrfs/reflink.c           |  5 ++---
>   fs/btrfs/tests/inode-tests.c | 24 ++++++++++++------------
>   fs/btrfs/volumes.c           |  7 +++----
>   6 files changed, 22 insertions(+), 27 deletions(-)
> 


