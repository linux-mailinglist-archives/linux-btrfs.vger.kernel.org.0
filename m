Return-Path: <linux-btrfs+bounces-19078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ECFC661CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56BEA4EC03F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF132ED5D;
	Mon, 17 Nov 2025 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfYIpuhM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC531AF06
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411469; cv=none; b=JyeoY6RTaCvWuZ0BmNHdy+DtdSznEm44Ym/l+Sh2s/QaHir8KVWYM1XdbN76cvtlZfSjM9RaWRXI1z4QzfIhHSR+//OAoyI1UIKvZP4sKDujbj/OEhqsITtIRbpAqIKfaCxzcQZuTXJ/CxhziH4SOEyQP/jrPAKkdPGgRqMX6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411469; c=relaxed/simple;
	bh=X6o8p011b2eh4ZJHG/tpphjxmMX16oyZRn65ebpozbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=crgUZH4wQoyZPv8jWfrmRZ+i1/VW5z7ySrbseN50nbzO/SmQJA0EGjt98zL4JV2h0wAN9d2DYWjop6JHh3LnSde9p+dPUNcxuJwreQ+RtbOBkNmQVDlEsSW8mo0yGS6BAj31T/lfTDNr24nUTN+wD55jQBuBaTEJAXZJwtWHOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfYIpuhM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso13456635e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763411464; x=1764016264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D0gqGVVc1lq7F18CmzGoGGki4DWLXFl0Mojss7YM3UI=;
        b=OfYIpuhMZEl7W4El1HGxst79MueNoHu+gq8EdQoyc9O1JcpIbFijgYrCG4Q5RvbI1m
         +k8ce7WxWYM0zs7/WrSXuwd7rICxS+ZJJLgBCgQynGQVS+LHTyEijhBIo9dEpiL20DiB
         XF5O1s7LLcAw0ZsohBJEj/iRPmm5eVxWE3Nh8+LLZFrPkl0DQZajD8yzTnbCVL8Ujp2I
         qH6xHs7LyIpETjVC7OzxNVnpeZFW5hmQ65OjLCmh5ta6FN5Y9O0f0PC9cCPD91nhn9ja
         d1IdKJazdtuPgrn2XoHNz/KW7hFhrpekhJ3yS3h0lYRvjXRCSCZ3EFq3LreGcIxBnIy0
         POXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411464; x=1764016264;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0gqGVVc1lq7F18CmzGoGGki4DWLXFl0Mojss7YM3UI=;
        b=a9YwWmC9SW4o6hp7lGYvKCAaCoe9PCoQPmghRM6+riOZ5BOU30LA/Qt+G1jZLvvInJ
         f4dS+sPe6BcPGw/kUta60PcaoiPXfOBnIdyLij0KbgGLmzwW1LE72ao6gvG58k9vWh/E
         StrF51IMHPoZyUmZKuXQ7OxsTa9Ocbwx9QH13Fklolw7YyBmkXYXgH9fNx51yv/aL3qT
         SaSvnfud5oYp7SYBijiw2U2YiFqy45kAJ2+tddaQ9lLljODVCIPrwCs8Fp/+c62/5t0u
         iM6mDx+lRsW73yRvLn9FOYCCseKsNUY1ODQa0QehgXkt6DBP1JrHhuSbWfPXup4blPUi
         TRyg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Talh7hHe7Kzv8ns1+IcZnkL3d+KM6n+A5yYFVH5BDKcOWwCamgulf6pyI/ybjqu9BuOFlj/3C1HCwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+yecCy0OWzZYAXbqxmHY/1aySy2NWJyRJOr3GI09Y6Hc8M0p
	T8njHukhxTjYilVfjd4xyHqKn2S+YXx76H64WOgbv74TeVdeZ2iHzX5PB7eq5qDw4n3SsMa5Le9
	tLLL1
X-Gm-Gg: ASbGnctlujHMwMRXy+ugvZbUryL+Rg1so6FPb3BPxIyHaDXqYiLzhR7j5dpORsiwRwk
	qDCXQEjhZ/vCO5WVOxe35jw7UPVuyqDO2VAx3f6t9EYsZr/535o5YgMLsF8Ys0Q7KlB0E2j40fG
	w/jBoHVeJpyczqK70IIo421H/viClTbWFBmxcW+UYhvrVZfabFxn2v7P1OloeCmYlA0W9A/Fyld
	LLiFiX4fF+flWfgru34zMqWZlcmFwEIsyxQORLngEUSZrPN3uQ5GZFWH/pMTmor91Dg2l8Fwxx0
	RzwunHHjxUrhORGvgOt16o5zMDunJd4VBHSxGKpDxUXswUlt0nP/bzJ/DRMGhg+gOK71Om9L5t5
	x1AVRMcYtPuij4TxJkoWvQyF/sVvC5YmHRlx/m79/kF1H0GpZ3FmdDz16dMCtFTgKBdZN4PnE6f
	3VBcU8+IriwJAXVXvglV69rVXqdtGD
X-Google-Smtp-Source: AGHT+IH/3uF+3OY0GEKgeAZmSzo9idEzemNgtL6Kymh7SyD0XSs21jOD7tUKvG0WxjkG76nBxaMYew==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr114798895e9.32.1763411464536;
        Mon, 17 Nov 2025 12:31:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-299daf12fe9sm56266115ad.74.2025.11.17.12.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 12:31:04 -0800 (PST)
Message-ID: <4589428d-1ed3-48a7-b125-9bb4d6c980bf@suse.com>
Date: Tue, 18 Nov 2025 07:01:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: reduce size of struct find_free_extent_ctl
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1763381954.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1763381954.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/17 22:56, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Reduce the size of struct find_free_extent_ctl and use bool type for
> some arguments that are defined as int but used as booleans. Details
> in the change logs.
> 

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Filipe Manana (2):
>    btrfs: use booleans for delalloc arguments and struct find_free_extent_ctl
>    btrfs: place all boolean fields together in struct find_free_extent_ctl
> 
>   fs/btrfs/block-group.c |  2 +-
>   fs/btrfs/block-group.h |  2 +-
>   fs/btrfs/direct-io.c   |  2 +-
>   fs/btrfs/extent-tree.c | 16 +++++++---------
>   fs/btrfs/extent-tree.h | 24 ++++++++++++------------
>   fs/btrfs/inode.c       |  8 ++++----
>   6 files changed, 26 insertions(+), 28 deletions(-)
> 


