Return-Path: <linux-btrfs+bounces-20655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF772D3923F
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 03:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EB3301673C
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A888D1E32A2;
	Sun, 18 Jan 2026 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hFB2/aZu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C18500972
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703835; cv=none; b=bhK+cQAX6pSj1Vo8qcB6qE1Wm/yRavf0jZMj5U3E2WeLILwuUu9OmIcItd1HeOjMPg81eXPfXX+R+qBTMe0YpR5CLrf1bBQsfEOIA2U9QX4HSXzC4DfgOD4V0gLJX0ILh1ytbkCMGOjVo85sFmmZeJO1R01AmnilbIa3nmCr2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703835; c=relaxed/simple;
	bh=Mcw6laFxyRaeDBxcPxf5RoSJ1Hj4LhowQsu/c/NHUYg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=AXNW199Mz0ThFBoSS3O/V/Xk1C/yGVSe9Es/5/+3WL+RsP8bmbXDYiyS5jcw68qjLMyExNF4po9xQVza82P6gDtGIE5gSLEiVt5reai6bygQa/T7hs+U39oPi3f9uOW7+swGHw2AlGpMoapw2XlXvZ+b1SzX0RNPfgIUR06JAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hFB2/aZu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801bc32725so14606735e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jan 2026 18:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768703832; x=1769308632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7h+9gD4fhsCiszENiroxxlCoz1JiH8Rf+CTjZsZq2I=;
        b=hFB2/aZuqHZzdpRwCrUa5Rp0kyNeWzsLZA5NPD9qRP49SdINc8bEBhAlq99hXDqvmZ
         GTasYvBaNvShnkEnT/3OLRcEfS1OfzJVaK32Lcs77sIDkiIBpqHgHGmFV+rvN2sBqcEl
         cDKynW/sumklGBc7fIySNS3k3Qm4rpkH+zaXlSzX3RwhSGIboUpxqc5kw7VPZKEpXULu
         TPR/jT5PcXjmTgvBAKXIvGl3oVsTb0JFJWL2/2TK3pNWDhQXy2v3IMVvJYsM7m8EqSxD
         YYWaREpoi9/T1cn03djXtXi8IFkD9lNsIIMgfpFfD4GVDTcZs8S5WsuA2Mc7Rttr+KtG
         R2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768703832; x=1769308632;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7h+9gD4fhsCiszENiroxxlCoz1JiH8Rf+CTjZsZq2I=;
        b=e/6iYmriPc1GyW9+JUCYv9+2QLJAZ4wAQjdtO8oKn9YriPj0fOeoJWSMEj12PQk+/s
         T0EJL/1IedRGjxVBENpVHG1uhiDFbCe8tV8YgEg/Zo7G8DBJEmCLVKCQWbS4bWIdC/9T
         Iyn+RbajxUjTadvgnhZA5OP7mm9qk0qhYkfZukNpAPWTxm4ia4uJP+tLImZEt+sQrkxY
         oZ9jBTCq/OIBxti6jezYXElZ2Dze3NY3l8tZg80IHbTpuT/FMTEkLdQU8UAKkpGNmVwd
         HuDvcB/8V5Twhhyj/AJWwxXZzxkeJkED9dXl9T2mdNzxfCaGr9Iz4k474TKoWCUiZmNy
         3W4w==
X-Gm-Message-State: AOJu0Yz3Jm4leEwUBPJssqZSGaB3S/qkSCjIPrzevCF/Z84RIodwj5dU
	Ge2O5jUffvoxV5aVZqAPOXk4wOh1ulFFBVYHc+BlKSDIWBoPLJhexEp+GwFWT203n4DIzAHVd6C
	cnsiw
X-Gm-Gg: AY/fxX6Z5dudrtgCcI7ek+CTfg69TrDFEAEZz78HvUSF2r0oGC3NqS5khDG+jSPqz2Y
	8fvF/J+nQ6wPPKwSvMvr7xYfBpnzKYvTnP2/n9LeFPvWMKhAVoIIWtPBgUO6hghIDUl884odOB3
	JbfNVLV9Jd/19+k/kDrW7KlE+KOwgg0x6Pqx10qpVMNqgFK9gVnPZqBpkcJ41WQ7RIaSuwpX3V4
	ysGWmRTa2R2/cves35j/m51P7ALenPWU0o9JJqFPouA+ekLKwLEkiyQUs9HuAi6BDs3Pl64j2tT
	dJ++QunO4wPjAdv4BVnU0/rocTlaLJDphrZ76O7Memq36G3WH+9IntZhAqfn40q8scxPQO213AI
	pSa5/Wb4TcqM7d8nXrIdlcUmQfxfd/ucUk6d9Gp0Z4gENCYrRHHJi/Ueh70Uyj+5986iR9raeQM
	id8tcFwwTGViDBaxYZtv59f9oFX2HnMiFVqC02lhY=
X-Received: by 2002:a05:600c:4e15:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4801eb181a8mr88905845e9.34.1768703831744;
        Sat, 17 Jan 2026 18:37:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190abc79sm56180495ad.9.2026.01.17.18.37.09
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 18:37:10 -0800 (PST)
Message-ID: <0cc46c0a-8352-4a44-9548-243790dd5ffa@suse.com>
Date: Sun, 18 Jan 2026 13:07:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs: introduce seperate structure to avoid
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1766725912.git.wqu@suse.com>
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
In-Reply-To: <cover.1766725912.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentle ping.

I guess the series is too invasive by introducing a new structure just 
to do the type checks, and require every caller to convert to the new 
type thus resulting a huge amount of code change.

If that's the concern, I can enhance the existing accessors to do a 
proper type check for those exclusive members to regular extents.

Thanks,
Qu

在 2025/12/26 15:42, Qu Wenruo 写道:
> The structure btrfs_file_extent_item is defined that if one file extent
> is inlined, the data starts after btrfs_file_extent_item::type, aka,
> overlapping with btrfs_file_extent_item::disk_bytenr and other members.
> 
> This makes it harder to understand btrfs on-disk format.
> 
> This also requires every user of btrfs_file_extent_item::disk_bytenr and
> other non-inline members to check btrfs_file_extent_item::type first.
> 
> But not all callers are strictly following that, and when
> access-beyond-boundary happens, we have no built-in checks to catch
> them.
> 
> This series address the problem by:
> 
> - Introduce btrfs_file_header structure to define the shared part
>    Initially I'm planning to use ms-extension to define an unnamed
>    structure inside btrfs_file_extent_item, to avoid duplicated
>    definition, but it doesn't work for arm64.
> 
>    So have to do duplicated definition.
> 
> - Introduce btrfs_file_header_*() helpers for the shared members
> 
> - Introduce btrfs_file_header_disk_bytenr() for btrfs_file_extent_item
>    This allows using the same btrfs_file_header pointer to access the
>    btrfs_file_extent_item exclusive members, with built-in ASSERT() to
>    catch incorrect types.
> 
> - Convert existing btrfs_file_extent_item pointer users to
>    btrfs_file_header
>    This also reduce the lifespan of those pointers to minimal,
>    e.g. only define them in the minimal scope, even if it means to define
>    such pointer again and again in different scopes.
> 
>    There are some exceptions:
> 
>    * On-stack ones are still using btrfs_file_extent_item
> 
>    * Certain write paths are still using btrfs_file_extent_item pointer
>      Those sites are known to handling non-inlined extents, thus
>      can still use the old pointer, but not recommended anymore.
> 
> Qu Wenruo (7):
>    btrfs: introduce btrfs_file_header structure
>    btrfs: use btrfs_file_header structure for tree-checker
>    btrfs: use btrfs_file_header structure for trace events
>    btrfs: use btrfs_file_header structure for inode.c
>    btrfs: use btrfs_file_header structure for simple usages
>    btrfs: use btrfs_file_header structure for file.c
>    btrfs: use btrfs_file_header structure for send.c and tree-log.c
> 
>   fs/btrfs/accessors.h            |  79 +++++++++++++
>   fs/btrfs/backref.c              |  36 +++---
>   fs/btrfs/ctree.c                |  33 +++---
>   fs/btrfs/defrag.c               |   8 +-
>   fs/btrfs/extent-tree.c          |  26 ++--
>   fs/btrfs/fiemap.c               |  30 ++---
>   fs/btrfs/file-item.c            |  26 ++--
>   fs/btrfs/file-item.h            |  23 ++--
>   fs/btrfs/file.c                 | 204 ++++++++++++++++----------------
>   fs/btrfs/inode-item.c           |  47 ++++----
>   fs/btrfs/inode.c                | 151 ++++++++++++-----------
>   fs/btrfs/print-tree.c           |  28 ++---
>   fs/btrfs/qgroup.c               |  11 +-
>   fs/btrfs/reflink.c              |  34 +++---
>   fs/btrfs/relocation.c           |  42 +++----
>   fs/btrfs/send.c                 | 145 +++++++++++------------
>   fs/btrfs/tree-checker.c         |  82 ++++++-------
>   fs/btrfs/tree-log.c             |  70 +++++------
>   include/trace/events/btrfs.h    |  58 ++++-----
>   include/uapi/linux/btrfs_tree.h |  61 ++++++----
>   20 files changed, 643 insertions(+), 551 deletions(-)
> 


