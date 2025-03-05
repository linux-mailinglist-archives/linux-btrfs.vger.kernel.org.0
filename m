Return-Path: <linux-btrfs+bounces-12040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7083A50F36
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 23:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00F8166DAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C811020897C;
	Wed,  5 Mar 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pqv1hlSd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAF207643
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215297; cv=none; b=m+j0hTC1b2MZD9oln+QWRE71zhCniiFnV2B0q7dXTL+r/cr0jOlQBrmM1WjAB6W9qNveZh2k/g5EOEdCmENOb7OiWC3cB7NngMkjPUWvQ+PZwJBYXxhY6Su8cXrWFgPch4jCTfy5VhRwZ0rZ6ZgUrp2Eo6PuY2Z1Urr9Qcs9FV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215297; c=relaxed/simple;
	bh=3UX2uzd+n3tzjDgIu8jd7SuH3U+eXIMWg6qy480eSv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wu+RsOxucwuhu+TualFbgKIsOw5ISnKUioE+Ud4cbcPr+/B2LvfpcMfybiw+NtVCBdxVhqz4Ye8AEfTWi6jd51iFZIXMs+FKPUfznnNNeeDB4j1QUyLtPTNh/FZFrjyNXP0cqMdvQNuugcY06bkLwRmuv5n7tbTrqeomKaAyG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pqv1hlSd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bbb440520so44438515e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741215293; x=1741820093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUCOuQwVPEcvDDzqV7AiHuj3+mscY3cn+etknefLZ88=;
        b=Pqv1hlSdUWUQ3YJasPUu9YsvVjpeIktCer4jrrdviQbpfX8m7klRGZ3F0P30EimhmI
         sRNyk/UgbXJngH3kkXt1B5sjuviLttnRiqVjX/Ch2rm57qh2dyIVxPonG1ys3MEydwSk
         5U7nzdTOIKjAuHzpuuqtEo639nNGQDmqWtdvNiOBo7rWvugS9kaAkV41MN94wJAcxUfc
         YFs9+50L4TUvs5uTn25Ko8Xz++K1uHphl6Ylq9tMqIuGjiy+diPJszj23xTb0plxeMHS
         1ZlBYQHyruIXAOagK4ecOAHmpEa3tyr96xaJIjFlyl1wYAfn8eMzUK0jhVMWIF0EW6UA
         8xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215293; x=1741820093;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUCOuQwVPEcvDDzqV7AiHuj3+mscY3cn+etknefLZ88=;
        b=odwzrxotgkIm/1V6tiLhLvird5t2IlmULl9ZH8c2cZV6Ab1GrQiFVLkATrBxygUDK2
         mKD94NeYz0ghkRLR8sfMmqinmaZ7rI44X5/Vr88+vq8BaFksPFK45Fe0kievdPSqAi9t
         FQ7NEyx/qrrBK6pPAARAGcSBICt7ZVv3OfJj0ykto5dnOAifInokRRtqNHJ7kgvogGHe
         B+V1u288OCgPbfZrscmiEJmXPtSk0C6fPZ7XfjkVc7QDockDa+gvH7DuvzjO00jNa2oy
         DtwfuGNOSwezSb+flPXPRQ0tJ8QJLxpmTBCFLRNcMMph2zKJvutzLZQRq3M/lho+84fq
         yUkw==
X-Forwarded-Encrypted: i=1; AJvYcCUmqW1DOkL9Iuja3KTD5hACPHLGtxM3Y1ajSetDyoe2R9fDNAmX789EPS1AazdOjclhfO0BkDcWUi1JBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkPQHyR53qSNHU3dWbxnOL9ymrpm8BPv8Zdmn4m1zyKrjFe4W
	GGYdr3Kel7Ud54tuX8cckM3naQ7ouLlffNhUlo1OQ18ZmbFKmLF01UOON2x5+8g=
X-Gm-Gg: ASbGncvOP8Rb6EmhpE2YzJw3QXYo75jXunm83UJIlUyX59i4H+fX6EHQJ6kYtkLvAit
	aJIr45fGgtWiOr8uVv+iRYxnxj3vY+kZMW16EgEHupWohk4+Izl9zRwPS8zJ5UDeoES/3FjsBHG
	DCzU8VZNyXdpfym9+EecQHmEP9SYl+PPOxWvrbBJxP8T5gkLnTvpQ5N8UnxQ/OIjbz3chPNR1uo
	Z52Wc+34pKfuiHCHZt2Aouun8dUaed9z3yhJMnQVVqY3YG5MBVMY5Bb0JmYB0QYJjmc2xL4rbos
	9/+GueOGAqfesi+wkO7YI+x92+/AeMpMAsu5e8L0DUBquvURKcPRGm789pBQ+3OHgmaKqoNy
X-Google-Smtp-Source: AGHT+IEfosorFo+Y2VAbZ5qW8nZwI9EremrJoVoq5pJWahlf+toWBb41pgGiqBD9AuMkMfdLfOcTlQ==
X-Received: by 2002:a05:6000:2a5:b0:391:11b:c7e9 with SMTP id ffacd0b85a97d-3911f757308mr4943185f8f.28.1741215292865;
        Wed, 05 Mar 2025 14:54:52 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223f5a4105csm17640425ad.249.2025.03.05.14.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 14:54:52 -0800 (PST)
Message-ID: <50b22e68-2980-4030-9c73-1aafdf2a838d@suse.com>
Date: Thu, 6 Mar 2025 09:24:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: fix unexpected delayed iputs at umount time
 and cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1741196484.git.fdmanana@suse.com>
 <cover.1741198394.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1741198394.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/6 04:47, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a couple races that can result in adding delayed iputs during umount after
> we no longer expect to find any, triggering an assertion failure. Plus a couple
> cleanups. Details in the change logs.
> 
> V2: Removed the NULL checks for the workqueues in patches 1 and 2, as they
>      can never be NULL while at close_ctree() (they can only be NULL in error
>      paths from open_ctree()).

Commented on the first patch that the fixed tag should be the uncached 
io enablement.
Since before that we only handle data read operations in endio_workers, 
which should not get ordered extent involved at all.

(Thankfully we get that feature disabled for now)

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Filipe Manana (4):
>    btrfs: fix non-empty delayed iputs list on unmount due to endio workers
>    btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
>    btrfs: move __btrfs_bio_end_io() code into its single caller
>    btrfs: move btrfs_cleanup_bio() code into its single caller
> 
>   fs/btrfs/bio.c     | 36 ++++++++++++++----------------------
>   fs/btrfs/disk-io.c | 21 +++++++++++++++++++++
>   2 files changed, 35 insertions(+), 22 deletions(-)
> 


