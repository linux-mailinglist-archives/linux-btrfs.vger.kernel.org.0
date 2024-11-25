Return-Path: <linux-btrfs+bounces-9902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AF9D8EBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 23:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D728110B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 22:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960B01C9B7A;
	Mon, 25 Nov 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A25Pdiqm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F216EB4C
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732575315; cv=none; b=bU57Roz3x0SUiIdNbVgmz3211NmxD08k+9RSmKgvL+56Ley8j1TSUbJKPbuU4UoPP845XFrFrx9SXGaNYUKDRJWaKNQYQVG5/CcRqZuez9vcIW7Ob57Gj7A29W+XqY5pmb/+PXNUbGeo4/Am9VPRGrdQWdIXoTtwrzkXvCMcJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732575315; c=relaxed/simple;
	bh=dYeDjb0MGWP2ArDI1qzoikFBCa6/ulvNxGTl5oiENyk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BW/ne7DXdQVGMAzVX8Elv2votKFi1ZoNN0z2gL0KbkPxj2YpKmCye56djAPL7EGrlmL3WWRTclm0AQRE2yAIM8YR3pHGwUF097GqSFSY7yhOdow5VlT31ZxhrBhWNg71+Wocda7/plqtPvkt9e+Yw2lPW+XFCRDnzaW3Gj7NMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A25Pdiqm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3823cae4be1so3080455f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 14:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732575311; x=1733180111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtlbmPVJwv4yKsEkk/utArmqSBoZPmxQnL8JrW/v+ts=;
        b=A25PdiqmqaLRlJ/euTGIjqrCDIIPz/2XjTlgWSHI0OCRrRKKT7dlVDz1HsoArjcMGZ
         05GC7mquLseClJaIxM5aZhc/yhVeI8uN+ouwtbyl7nARBJIUPF5Sn6QC6MwPDQpMqG6v
         2oVIxf58a90AyeSWbcDnKyQCeTHDzuxGhltwGqOpkxqE0uidUeNI3yLGjvNE+7oePGE9
         kE4RGKO9G149uvwECWIr3LWJBeSoWu3EQqZ2UVwJ1M9iLg4l3au0sHNDx64avqq8pc2A
         nDKmWq6aXBByvGalYHp38hKWQHEW2uDAOm2ifOqXzQW77wgCQO90MJKD8LydL6iwJnoK
         rsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732575311; x=1733180111;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtlbmPVJwv4yKsEkk/utArmqSBoZPmxQnL8JrW/v+ts=;
        b=p5XgC8zsZdZBfiVUkvQqQEqO8c4xF2Lzb0SJVs/WW68nyd+wsvYSPV4eMbvrjYSa7W
         7ftpsUOWg/+JvHjazcvHG18bNwF81SnjmnWxAym/BKf7pDQQpHpxnNiCEUN/zcIdr/iw
         Ru0FyFSYsMo+oDqbEFM+WcaXaUw+9GziHYsCh4FXdFF4TjVoZuttJfS79VRfymPhjkrp
         7pq4xB5eCRXicJWHL/Hzq0kxTCb0xJY83VFPV4v3wWW6T0RUrP6aNJePCGvPeYZtaZ8N
         z88SI4Mj1+/46yPBstp0debuOklPe8OHwRr6puJtJX2zaDaDAYR8mkEYk1z91vzaft6+
         Xchw==
X-Gm-Message-State: AOJu0Yz+rDRroDSlP5ZSslh+HUOhI5DgAfeapUO5ej+8qCG/JrfaQpE+
	yGeD2A4bESOJlkgAPERThRz2f0NZPCleAePMZ95Qf52VV97yKOiPWGjojn2AytYr7JWBviFE7rc
	o
X-Gm-Gg: ASbGncsmuXJzrNdkudXv3eijeJneZUD5jg+yN+VUqz1SHIpRoHYxwDQFXBvC90Jhm9D
	Szz4Mf81axGH1o9Oj+weitVZVjRk0L5HnIQf1WVa++glbgjy4+313eHZAaGYYkhlgu6D/A386iH
	cOBgFls6ZIzHigv702iVj66mSnd/TrqLtHTzxQkG+vdr/HRQmTrrjF8ROGSScZaqy/Xr6PLgzRd
	w3qNyfgRK3pDrfIUFvILWwMiermXUid1vbNshABkGi7KDav1kAC/nTQHVqBob1FFjC6WKb+7ko1
	DQ==
X-Google-Smtp-Source: AGHT+IH+x4+tU3l0bEOrla5/cR66Fo4qOvBfCM9oo8gHH9UJC+PZYGCJUr2Oh92FVAVJDK+Tc+BYqw==
X-Received: by 2002:a05:6000:1449:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-38260b763c5mr13546131f8f.26.1732575311389;
        Mon, 25 Nov 2024 14:55:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba22f4sm70896835ad.100.2024.11.25.14.55.09
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 14:55:10 -0800 (PST)
Message-ID: <5dfe1379-0910-4e4a-b21c-6a92fd74c83f@suse.com>
Date: Tue, 26 Nov 2024 09:25:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] btrfs: sector size < page size enhancement
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1732492421.git.wqu@suse.com>
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
In-Reply-To: <cover.1732492421.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/25 10:27, Qu Wenruo 写道:
> [CHANGELOG]
> v2:
> - Add the new fix for inline data read which can cause data corruption
>    Thankfully this doesn't affect any one until the last patch enabling
>    the partial uptodate folio support.
> 
>    But it is still required before we enabling partial uptodate folio, as
>    a btrfs can be generated on x86_64 with inline data extents, then
>    booted on an aarch64 system.
> 
> - Update the double accounting fix to cover errors from
>    writepage_delalloc()
>    WHich is the missing case which can still reproduce generic/750 crash.

Please delay the series.

At least before I got a full fix for the generic/750.

The problem is more complex than I thought, all related to the 
btrfs_run_delalloc_range() failure.

Since we can have multiple delalloc ranges inside a folio, the handling 
is way more complex.

I need to try to find out a minimal fix first and get it backported, 
then maybe a proper rework to change the behavior from 
map-map-submit-submit to something more aligned to iomap's 
map-submit-map-submit.

Thanks,
Qu
> 
> This series contains several sector size < page size fixes and
> optimization:
> 
> - Pass generic/563 with 4k sector size and 16K/64K page size
>    The last patch.
> 
>    The test case is a special cgroup one, which requires the fs to avoid
>    reading the whole folio as long as the buffered write range is btrfs
>    sector aligned.
> 
> - Fix generic/750 failure with 4K sector size and 16K/64K page size
>    It's a double ordered extent accounting for sector size < page size
>    cases, covering two different error paths.
>    The first patch.
> 
> The remaining are all preparations for the above goals.
> 
> Qu Wenruo (7):
>    btrfs: fix double accounting of ordered extents during errors
>    btrfs: fix inline data extent reads which zero out the remaining part
>    btrfs: extract the inner loop of cow_file_range() to enhance the error
>      handling
>    btrfs: use FGP_STABLE to wait for folio writeback
>    btrfs: make btrfs_do_readpage() to do block-by-block read
>    btrfs: avoid deadlock when reading a partial uptodate folio
>    btrfs: allow buffered write to skip full page if it's sector aligned
> 
>   fs/btrfs/defrag.c       |   6 +-
>   fs/btrfs/direct-io.c    |   2 +-
>   fs/btrfs/extent_io.c    |  98 +++++++----
>   fs/btrfs/file.c         |  13 +-
>   fs/btrfs/inode.c        | 362 +++++++++++++++++++++-------------------
>   fs/btrfs/ordered-data.c |  67 +++++++-
>   fs/btrfs/ordered-data.h |   8 +-
>   7 files changed, 325 insertions(+), 231 deletions(-)
> 


