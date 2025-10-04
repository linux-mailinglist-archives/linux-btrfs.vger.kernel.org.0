Return-Path: <linux-btrfs+bounces-17427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F92BB87F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 03:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305EF3C8607
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 01:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805992045AD;
	Sat,  4 Oct 2025 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WlcBobbb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4D207A38
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542875; cv=none; b=FIyXazm2QbFxDVvMrDQeBoJaeWbOVOr1o4zltbPPHORbnPeuDQCYyus8tqmoq1vYUbWWsnIE1EmR3b7kASRrdpL/0FZ4dmhVspsv8IDdLo+B5k7X3+Ye4Tlcfy8D6tcSgk6FHJMXWnWZQtWHguEBd07mu3R8CBCKy33EomCWVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542875; c=relaxed/simple;
	bh=mwqdtz22zLDM1ib3mMryJkShOjPddoXYLXVe2JaHsUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z+6T0dXpUjqYLoRWIpkx6KMBMcu3hZ03IvopKL3Lg7qILgIEPk4Qs41y0yzZG2H/X0x39XpKR+qvjOa0UhOLZ7h+gq6kxiLbUg1UE+T47A6VGKKwUC2ubPuGc9I+gIEOEKEadARytThy7nJosRtC3+RRDreka45oPGj5sAXhJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WlcBobbb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e5980471eso13818825e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759542872; x=1760147672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BvzRkfxWzemjOrfpQpDfYeKA9Ef/jrIiRI53PNmmGi8=;
        b=WlcBobbbWNtSeTkQyfF2ApPcJOwGxZZNbwrEig7lKGGRBq4FYn9R124BWoqcY/IK6l
         UNTnrUb0reVyPakECsGIAqaciLDgUeIbSnerKfPv6XT62PxBoeq3Cl5Q4wcn/4Z88O3t
         sy1i2VK0tnLGhI8Kw+L7FsO9MpHIx7CQJLurngAjpQgIsVt5j24y3RVBIIvblO/LwXfX
         VtZSBrgCHjVNch4NEhrdCkiqLTydJFbu40GlgSyJAxPNdiMKwcSPDbdwVicIyuv8H1ii
         wROFa7I4MrKx2aFOX84UMGWa2lxRMKXC/oUBDsMQWxF6RpLPxcjh25WZ/fLUqBoHHXCm
         YRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759542872; x=1760147672;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvzRkfxWzemjOrfpQpDfYeKA9Ef/jrIiRI53PNmmGi8=;
        b=NvQPZgM0wDcDN6l3UiTAxqN1x5RTBChsf28ESS8Eo7ijX2yet/ziX2MtwE4MUtxe9C
         Kea/0d4xGIa+XeF6AwxSBz05RDD44ViQrHIo5OlYpk+I9B+xHrI968ONw2zSPc+Z0tRE
         86z6Qe4lj8CXtSLyxT/Pz23g5s5JTijUyWOkCuOMs6igY1c2Qd7jeuRxAwp5EB3KrrQN
         O8tSd/w46s0A0gHvcHUcJTe0V4WzUSNRNoKUsDfZgv8T3ROrJgQ4qaqLpwqjkeTstoe5
         EHfk5a5wqlQoXEQC4RmcYTuUDcl4qUwimuZd4yh/t0iDU9HZXuEZP5/pH/WMJgeAQeOZ
         uU9g==
X-Forwarded-Encrypted: i=1; AJvYcCUrgRGVMkcvTEhlhRjKwfx4G2IcwyDb+VbPL3O8KKwxYujDg/b1Hx2Gh7XfWRi17EaGg/gaQ08nr1TRUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykdj0opxRAb6rg5v43W+6h2eI9mHhcDXLukSBtZ2BwGF/LM1L8
	bphLrjnQCUCnKnZhIEESc1Pfz9pdfqb01tdmPQo0a8w4ppPQKHVUL4z1YQa7kpC+xmI=
X-Gm-Gg: ASbGncu4jdiSv6PXfy9BeIcDoQkEbQPy0SQ0IvwSyvKIf4wQgrKCfLFuGmtASQvmgqm
	Q5wHePCyzyOg/RZpoZCnpBy49zfVBitbe+mCZu5IG1hBRcwNVzOc5YMWkUNYZGXDH4lFeGwZlEZ
	sQOZRf0sUXBfLzgqoYi+C0W5g1lmx2ZAK6kLNge1LmbkyUCeij3eYUtNx49ESxZFix1j8uj369T
	uVKtEbyw1ge1kgsxkOuL8efREO1mAdvFizz4B8r1qCf/QGRf9ZpuLr3kmuilEfIGhKfKcednIgI
	4Fk2P9zZZWIyDGfxnxda0yjwCVkG7eY6GndrnrnCzaF64wFmqMcK5abNWvukx3tO5Dm5bVBPe3g
	CunvC8BSb6RIddBdp7VlMN2Jv5c+1bxxKH6kQTH86wPx6wE2ImJ/oNhq7xeVh0H2H0uRwp/nQIC
	E=
X-Google-Smtp-Source: AGHT+IGBu8tWFBHrh838n1k/I0brZKqRDXKtMk4SNLa7wJ8u4Gb52nNwUcLvEK00EYQp38T6fgMRng==
X-Received: by 2002:a05:6000:186f:b0:405:3028:1be4 with SMTP id ffacd0b85a97d-42567137c45mr2708568f8f.8.1759542871672;
        Fri, 03 Oct 2025 18:54:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d584esm62727975ad.107.2025.10.03.18.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 18:54:31 -0700 (PDT)
Message-ID: <55d549d2-fec1-442f-ad9f-875d2ec6c864@suse.com>
Date: Sat, 4 Oct 2025 11:24:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1759532729.git.loemra.dev@gmail.com>
 <455b9a2b102631febc1b05802006d3d304d4baeb.1759534540.git.loemra.dev@gmail.com>
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
In-Reply-To: <455b9a2b102631febc1b05802006d3d304d4baeb.1759534540.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/4 09:11, Leo Martins 写道:
> Add test to test btrfs conversion while being stressed. This is
> important since btrfs no longer allows allocating from different RAID
> block_groups during conversions meaning there may be added enospc
> pressure.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Please do not mix patches for different projects into the same patchset.

A lot of us are using b4 to merge (kernel/progs) patches, which will 
merge the whole series, including the one intended to fstests.

Thanks,
Qu
> ---
>   tests/btrfs/337     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/337.out |  2 +
>   2 files changed, 97 insertions(+)
>   create mode 100755 tests/btrfs/337
>   create mode 100644 tests/btrfs/337.out
> 
> diff --git a/tests/btrfs/337 b/tests/btrfs/337
> new file mode 100755
> index 00000000..fa335ed7
> --- /dev/null
> +++ b/tests/btrfs/337
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Meta Platforms, Inc. All Rights Reserved.
> +#
> +# FS QA Test btrfs/337
> +#
> +# Test RAID profile conversion with concurrent allocations.
> +# This combines profile conversion (like btrfs/195) with concurrent
> +# fsstress allocations (like btrfs/060-064).
> +
> +. ./common/preamble
> +_begin_fstest auto volume balance scrub raid
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_kill_fsstress
> +}
> +
> +. ./common/filter
> +# we check scratch dev after each loop
> +_require_scratch_nocheck
> +_require_scratch_dev_pool 4
> +# Zoned btrfs only supports SINGLE profile
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +# Load up the available configs
> +_btrfs_get_profile_configs
> +declare -a TEST_VECTORS=(
> +# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
> +"4:single:raid1"
> +"4:single:raid0"
> +"4:single:raid10"
> +"4:single:dup"
> +"4:single:raid5"
> +"4:single:raid6"
> +"2:raid1:single"
> +)
> +
> +run_testcase() {
> +	IFS=':' read -ra args <<< $1
> +	num_disks=${args[0]}
> +	src_type=${args[1]}
> +	dst_type=${args[2]}
> +
> +	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
> +		echo "=== Skipping test: $1 ===" >> $seqres.full
> +		return
> +	fi
> +
> +	_scratch_dev_pool_get $num_disks
> +
> +	echo "=== Running test: $1 (converting $src_type -> $dst_type) ===" >> $seqres.full
> +
> +	_scratch_pool_mkfs -d$src_type -m$src_type >> $seqres.full 2>&1
> +	_scratch_mount
> +
> +	echo "Creating initial data..." >> $seqres.full
> +	_run_fsstress -d $SCRATCH_MNT -w -n 10000 >> $seqres.full 2>&1
> +
> +	args=`_scale_fsstress_args -p 20 -n 1000 -d $SCRATCH_MNT/stressdir`
> +	echo "Starting fsstress: $args" >> $seqres.full
> +	_run_fsstress_bg $args
> +
> +	echo "Starting conversion: $src_type -> $dst_type" >> $seqres.full
> +	_run_btrfs_balance_start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full
> +	[ $? -eq 0 ] || echo "$1: Failed convert"
> +
> +	echo "Waiting for fsstress to complete..." >> $seqres.full
> +	_wait_for_fsstress
> +
> +	# Verify the conversion was successful
> +	echo "Checking filesystem profile after conversion..." >> $seqres.full
> +	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +
> +	# Scrub to verify data integrity
> +	echo "Scrubbing filesystem..." >> $seqres.full
> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "$1: Scrub found errors"
> +	fi
> +
> +	_scratch_unmount
> +	_check_scratch_fs
> +	_scratch_dev_pool_put
> +}
> +
> +echo "Silence is golden"
> +for i in "${TEST_VECTORS[@]}"; do
> +	run_testcase $i
> +done
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> new file mode 100644
> index 00000000..d80a9830
> --- /dev/null
> +++ b/tests/btrfs/337.out
> @@ -0,0 +1,2 @@
> +QA output created by 337
> +Silence is golden


