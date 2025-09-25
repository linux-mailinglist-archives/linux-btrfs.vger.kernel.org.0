Return-Path: <linux-btrfs+bounces-17171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9941B9DD4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369681B26158
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 07:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFC2E1C7C;
	Thu, 25 Sep 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="adQah+9i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A642A82
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784671; cv=none; b=pK0+CLgcO2AJ3/bTgiu+PiP1L5z3QizqoINTYrbYQ6Iz7vtMkl0P1WwC+TPIAXfK3DHWa5Eo8u+47cMv7Tg3jtz/RbiSMVxSq6TzFSNq2uEQnYjNJA4NJacmVs5LtjvzF186lJjs+dgFv1a6KxSa07T4QPyGRpYyY8odSmZJxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784671; c=relaxed/simple;
	bh=iVHF4E0gqbOaKTeQBVTEKJ3ior2beu+vJS7pg9T5K3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eV/Bod4Xph9WD+49fJEbjtq9sLQUrn1xSr/dTV+weG098Ls0CWo+nYRCMXdnebrVxFlBGzOuLcnVT1QevLWVmKHJBvneHeMEeYBejDxDvsDXtLWNlsPv5vATs/Cl+Bj1mpewYhw8vYsPp8Tqcnomr7O3t5j5T82KZfjzxDd9YrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=adQah+9i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so627297f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758784667; x=1759389467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mpx2q+D+CU5yCm2JIOrVl2h463tx6f38xKvqaGDj5z0=;
        b=adQah+9izIlJx0W6zee53uMc8o3Om16R8li5TIlcataaTLWiBnF3k2lqZoPW+580aP
         b3IEW+lS9Y/26jdbjzFfAMLmb/A1q1FV/84sphoEl+TXrSUdPjy4VD/2PqmCEvMytHf6
         +h6YVhZkwK6dxfHjr1MsjNCzosJwXC1lGgrMkLeWdhFCKMi5mMBZ9OcMxJ8w+8mRI04z
         4jK0gfInuf/vtmRM5iCQ1nTj8Pfufpodsl7Ka1UolkWBUtVa4gTGRPlt0+B/h3oZO5pD
         rYL8kt9elmot0M724bkiGpbx9qdPmiS7ChISdOJP4tPKk4KtaUjqh8D+mAUvPW3ovszm
         0xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784667; x=1759389467;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mpx2q+D+CU5yCm2JIOrVl2h463tx6f38xKvqaGDj5z0=;
        b=az5cCiqaXbkFhKJfvUjlt5oQpeGPfFN+R/oO6GaKU7BpIi+Kn8iy9OIPzLmYNG0G8G
         IRrgB6u5RQYQ+nyrz2jAVs7DoO3MPHKYWhNY0iYcVxJ5ZfUKIKnvqX1wmr5aYH+l6VA8
         hFMrbBh8Jj8t+H6NfnSyC3yFH21Oj+7PrXzuGSXyVoRmeW6jHbOtg4jq3N/y75R3TXvV
         IDFUTAmnNaI2BzZbrhfhOk4+HaeyJDWzNviOpVDvwKgLPzV0O/a+ZIwpVCt2y0RuGMCv
         V6knhaf1EHZWv7YrcS1aZ0SIVoAacp5vqK+Q0bo1aqQMTc3xajcctgT1IhuEGpMR2Omv
         TkQA==
X-Forwarded-Encrypted: i=1; AJvYcCXg7u1f/QJ/e7JzZN8lpdX/t1KjzR9Z2kzII9jYGF24QEkPyAR3YmESkWydBGbEQhcCTSqBDhL0kHnHrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZB2NFCPzA0VQf7YNsCnISVZv3s2y0ALzTUxXjHkJ1Cd6IMVll
	8fQSBTdl+Abs9jv76haFdSx2gus500CSVOMkNrRPbOXEJPP1Vn2t2VomsQDIm/J+xvKkQhWXFgP
	FaSAi
X-Gm-Gg: ASbGncsn+GQo67DRu/0wt5pWzB4qfLn22oOGYCFIN6FrPTrocAiKStdeA5h+ozFusUL
	tjBoX3wETSSLNIP4hx3+qgSN2v3M0OHCoSPCZPy+xxk0MjxJfnYNR7jIiypFQOii96mNJ/69c/b
	6FnrW7dp8DRyR3AMMBKqW89w2LsIU39ewDMhOLEkn2FvCJUu/DCrY0XUF9rquqwDYe2XKIQt/rh
	Ah+43XOlTUfE3GY4d+4kWtLnC0jcjAmtMEdC1OWsQzev2ABzHVjUSYJPE0Af09w1FgdkDflWLLq
	Na0rIxI7sDXO56k7DFexl3X9bwFNyMcj+gA+LFDleWbfK2M79pnDItZc5d+M7RicQKFY1LothBR
	QouvWVSGb7mpAfazNo3yxLezkKn63+p9uYZN1yIestf8TSyzEjwE=
X-Google-Smtp-Source: AGHT+IHYOe3Ri69rYiuFMZlFUGhWBb146+QQPezDhVhocljyOKE+kjNxIozKfR52XZruozWmjNt6fQ==
X-Received: by 2002:a05:6000:22c7:b0:3fd:bf1d:15ac with SMTP id ffacd0b85a97d-40e43b08da3mr2314622f8f.20.1758784666532;
        Thu, 25 Sep 2025 00:17:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671738esm15017305ad.46.2025.09.25.00.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:17:45 -0700 (PDT)
Message-ID: <65ee1663-5e49-45fa-96f9-98efe146d702@suse.com>
Date: Thu, 25 Sep 2025 16:47:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: relocation bug fix and a cleanup
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1758732655.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1758732655.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/25 02:24, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Filipe Manana (2):
>    btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
>    btrfs: use single return value variable in btrfs_relocate_block_group()
> 
>   fs/btrfs/relocation.c | 51 +++++++++++++++++++------------------------
>   1 file changed, 22 insertions(+), 29 deletions(-)
> 


