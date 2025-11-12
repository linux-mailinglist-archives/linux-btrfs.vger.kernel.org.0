Return-Path: <linux-btrfs+bounces-18921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB6C5484A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 968FF348D62
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB92D876A;
	Wed, 12 Nov 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b1HP/Gqu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914B2C21C6
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980943; cv=none; b=DqpusCrXIcBobWsxDKduJF3YQOWYUxN1F48wPq29/fCMk+6DlZduEUxQ7rIDEeLHyrrYxhRYdDhubnO2JfG+ti1+aMddVR+C0Ctaatt8LkPF2+IpZriYFWFQRQOwnRpOdp4V1PX5wYm38EXGjGQpOqPoqXqy4UKBVOw7R5wjap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980943; c=relaxed/simple;
	bh=Qsgwm9lvsBQgoK1mBrAcm9euPoWrDq8iUiZhrYjY8Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqIMT6soQRdP4jmfuBNhKRb83/rvWvNqUCg3d8ngYS3vBpTWLih03U5+vjNlHI1ro1ci1gQ5L92ff3unDZmbHwAUmAgXChJJ7wP+yOvGJiYEeD+jybdZPFQNv2DvTNKid3FhUT2R4vJm5l5U57RjcwHIT8nI5JFXrc/h4n1y70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b1HP/Gqu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso925925e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762980939; x=1763585739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mIQW6jHndAhBdqeoGwTHc6AkYYrAWg+NBbxYFatebgo=;
        b=b1HP/GquyAfosg2X1jNwXDWKJStDV/VmKsqaSYC7QoMjpN7Z+Wdvah1CgpfDVksRCu
         tKD/2Id32cD+SVPfhzcwtaAJbgtaUAYIm0KfSRwBmsxI4IYv+1u7hNNds31bhZV8SrNp
         2vy8qjAYFq5F2u7yV4evjPVDmGesKGdLz1DhPRLBTNrW6Ox2xs+hrSv1um+A+RU5L0Gt
         3Tx5fR9JIOgIoXOBn8lLApcHd8myT7Y0eQOaw143HCsk4YMEJk549b7gWarZoXNSsFbx
         6rhM/9YZ4llVuGgL/nYm6TJIuVFvA7W3akbFvdyUJNxQNZzAmbDs2v5qtHgECOr2fnd+
         5TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980939; x=1763585739;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIQW6jHndAhBdqeoGwTHc6AkYYrAWg+NBbxYFatebgo=;
        b=eIn8si8KFfqWw0svkoLoVKIVUOKzCs4o+myCV+uqy/Lez6SB5lMBvB+zBjU1brEVBe
         +d21zdPvyeumvUEPYQeegZnY5H9YzVzxOtIeJ54uSPULNsr/Ga3r8vQcNgKP+hx5ITeq
         OlMz4sDuKBcP7CCESPxx7Os6r0cPSGGW0sFKMKKfZo/hMmVmv0IRok/chibKyFjkc4xx
         LZqmMdpIOF3/FUHa5oOzre3kKmO2kFneqGgsHhrjLVooMbCI1GKmvVwrU7962JpjIXzk
         G6sTpHPje57qAAinVALO4ejrT7r6gJBRljrf/L7yv7qEPGUkpMUtD0RurLaVlpsL6MCB
         0V8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKc8l+WhfrWex1o5DdCgptaWBZPbMrvbtPqQ816VBSz6VDFu3NIX/sAWMDZxNiVTUZLIRUIwAOWNY9Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQoItyCdImHF1/z9HKn6PF9VCNwzOKB7OLldWGQrc1h/eJbat
	Hn+WP8IrwI4wqJ+eBNV4mDGiRhWhhPf9p5YCCmx4CHUmKpmp1z1jgYm/aVOyMl9FGfM=
X-Gm-Gg: ASbGncuMuLZEGzhPzMa4N3WoCKS1+ls7iW9XnXrMrrqBenvBQEQvdx4NUaKkTanAMMo
	vIkYXDIy/sitl/UgWVhTBfMjoDrvB6KZJVl74Kcl1MxzRIz3LVEoGVagUe3y8Emfbh3M2RZg5DK
	NcZp4Ke1RG27o91JNyqIcWkbKoZboWu5v1n5swSnmvnpUm4+Bb2Q0uGThSEg/eB2yp6B4vymr5B
	IlioNgh6JjmHrqXneoMMKVmosj2b8af9+fb2xoHmJ2HqvI2TXdiSqRBvDMM3enNek459Yw1jIzV
	luWoo/1hI5cHP0zwVo+vAZJmDEn6snKcEvLkbR4QvuCwyFDhnmb/Q3Ct5juBCFOazd/lyilDbfU
	QwSLNql7cdd8cEA5hyiD4HOsZiEHUyrAs8L7liEDlsN30II7fFdd4GtZdy1d08iU+jFwGl5pZlH
	MJwTCEDA8pCNfWX+prYMNw+nxkPB/9
X-Google-Smtp-Source: AGHT+IGFdGsO6QqcJkRmPINaxilC4q49m19G4rUZHJ/iqgJco38+vTEe4EOoO4897RRplycDCmoqhQ==
X-Received: by 2002:a05:600c:138a:b0:477:19b7:d3c0 with SMTP id 5b1f17b1804b1-4778703d63emr46416085e9.2.1762980938449;
        Wed, 12 Nov 2025 12:55:38 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea6dc70dsm296655a91.1.2025.11.12.12.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:55:38 -0800 (PST)
Message-ID: <31b5e88c-0979-44cc-9e7a-1cb3320caf39@suse.com>
Date: Thu, 13 Nov 2025 07:25:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] use cleanup.h in btrfs
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762972845.git.foxido@foxido.dev>
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
In-Reply-To: <cover.1762972845.git.foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/13 05:19, Gladyshev Ilya 写道:
> This series represents my experimentation with refactoring with
> cleanup guards. In my opinion, RAII-style locking improves readability
> in most cases and also improves code robustness for future code changes,
> so I tried to refactor simple cases that really benefits from lock guards.

Although I totally agree with the guard usages, it's not yet determined 
we will fully embrace guard usages.

> 
> However readability is a subjective concept, so you can freely disagree
> and reject any of those changes, I won't insist on any. Please note that
> patches 1-3 can be useful even without lock guards.
> 
> I didn't know how to split this series, mostly because it's just a lot of
> small changes... so I tried to split it by types of transformation:

And even if we're determined to go guard path, I doubt if it should be 
done in such a rushed way.

There are already some cases where scope based auto-cleanup conversion 
led to some regressions, no matter how trivial they seem.
Thankfully they are all caught early, but we have to ask one critical 
question:

   Have you run the full fstest test cases?

If not, please run it first. Such huge change is not really that easy to 
review.


Although I love the new scope based auto cleanup, I still tend to be 
more cautious doing the conversion.

Thus my recommendation on the conversion would be:

- Up to the author/expert on the involved field
   E.g. if Filipe wants to use guards for send, he is 100% fine to
   send out dedicated patches to do the conversion.

   This also ensures reviewablity, as such change will only involve one
   functionality.

- During other refactors of the code
   This is pretty much the same for any code-style fixups.
   We do not accept dedicated patches just fixing up whitespace/code-
   style errors.
   But if one is refactoring some code, it's recommended to fix any code-
   style related problems near the touched part.

So I'm afraid we're not yet at the stage to accept huge conversions yet.

Thanks,
Qu

> 
> 1. Patches 1-3 include some preparation work and simple fixes I noticed.
> 2. Patches 4-6  gradually increase the complexity of the refactored
>    situations, from simple lock/unlock pairs to scoped guards.
> 3. Patch 7 refactors functions which control flow can really benefit from
>    removed cleanups on exit. E.g. we can get rid of obscure if statements
>    in exit paths.
> 4. Patch 8 is kinda an example of overdone code refactoring and I predict
>    that it will be dropped anyway.
> 
> There is no TODOs for this series, but it's junk enough to be marked as
> RFC.
> 
> Gladyshev Ilya (8):
>    btrfs: remove redundant label in __del_qgroup_relation
>    btrfs: move kfree out of btrfs_create_qgroup's cleanup path
>    btrfs: simplify control flow in scrub_simple_mirror
>    btrfs: simplify function protections with guards
>    btrfs: use cleanup.h guard()s to simplify unlocks on return
>    btrfs: simplify cleanup via scoped_guard()
>    btrfs: simplify return path via cleanup.h
>    btrfs: simplify cleanup in btrfs_add_qgroup_relation
> 
>   fs/btrfs/block-group.c      |  24 ++----
>   fs/btrfs/compression.c      |  13 ++-
>   fs/btrfs/discard.c          |  20 ++---
>   fs/btrfs/disk-io.c          |   9 +-
>   fs/btrfs/extent-io-tree.c   |  72 ++++++----------
>   fs/btrfs/extent-tree.c      | 104 ++++++++++-------------
>   fs/btrfs/extent_io.c        |  33 ++++----
>   fs/btrfs/file-item.c        |   6 +-
>   fs/btrfs/free-space-cache.c |  87 +++++++------------
>   fs/btrfs/fs.c               |   9 +-
>   fs/btrfs/inode.c            |   3 +-
>   fs/btrfs/ordered-data.c     |  67 ++++++---------
>   fs/btrfs/qgroup.c           | 165 ++++++++++++++----------------------
>   fs/btrfs/raid56.c           |  20 ++---
>   fs/btrfs/scrub.c            |  19 ++---
>   fs/btrfs/send.c             |  40 ++++-----
>   fs/btrfs/space-info.c       |   4 +-
>   fs/btrfs/subpage.c          |  41 +++------
>   fs/btrfs/tree-log.c         |  28 +++---
>   fs/btrfs/volumes.c          |   3 +-
>   fs/btrfs/zoned.c            |  13 +--
>   fs/btrfs/zstd.c             |  13 +--
>   22 files changed, 299 insertions(+), 494 deletions(-)
> 
> 
> base-commit: 24172e0d79900908cf5ebf366600616d29c9b417


