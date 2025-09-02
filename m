Return-Path: <linux-btrfs+bounces-16584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E3B3FA35
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81B64E1FE4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD02EAB89;
	Tue,  2 Sep 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dHOH+v+t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2F3D987
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804937; cv=none; b=ZDW9KiJhFs3KHGiTAsPJVB2scCMtgIC2lvH7FQZGU5E6cVdpx3KiJtXbAYHvY7yCH/0bjSU1P5tMcvfObP+ITBKSwToBoh6EmdDXEhFciUwjgbfVR2NOHYhfvgEvz2VFww3QPkM8VCuzMs81gBXWxrWwwk0aff85pE66l7DNfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804937; c=relaxed/simple;
	bh=QRSgmZ12JSc0o8qaiKBg/Sj2yeUUeOh45UTU4dbHoM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bWDtVazRR4xLsv1nJ/gWFnrHURpQqUmGEdXLJSjHVkIAEgRkC9YoD/+hnjnztuI6d+HAoQmoReDct5ojBF78Cj1z3gd2MtDNlEOtlnkauupDIqXtIh628HTqS8/wD+Js5tmcGgHRxjwzC7OZq5oLcIwvg2nXgKV0oharPdXW5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dHOH+v+t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d48b45f9deso1410748f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756804933; x=1757409733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/wXLBU0LeF1QhPnht9MGr3M8J3T6hGawzHOEVcbBEkY=;
        b=dHOH+v+tO+f+Gzm7wSB8yx1n16hAqnyNchN0sYmF79Jje+MYeruS/ybI2j2F2M8C+E
         DBuzduiO3l5agPDzAeTiW34iOVp8wema51TF/CqpbKp7nWx74JIZ6JDXwTqiZl+ThhtG
         xr96/NI51n9ZOyCMjyN53ZT8rGnJGL0effuIZuMIsHmD9Lj4OiDwFxJBcR/oUOa4BHoX
         NIX3XBDVCC2kiFEdsKnWdgBFmuyS66X2l3GIkae9qJCHgcIRT5NJV7h1X3wT0d0l5JSp
         B1620J7ktRquFGDe3LuYUF6clW3R6tTDzj2DmYKroHpWL6SGOs3VVzXQKiwbMRVEmdE2
         tlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804933; x=1757409733;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wXLBU0LeF1QhPnht9MGr3M8J3T6hGawzHOEVcbBEkY=;
        b=mkjPVPhzhu93LpHu+dw7POL9JkBjGZFhc8utqsGnEDRNqpl8ROEK1a0ZczzBtk8hHA
         FHQpoZy2q3ox4EOmvrLXxLbajqFWSKhmzUScAIFCe/e5GQwsuFNqC8SeG+YfKC384wbj
         9hPap71xMbF03g2KWU/VcDkBchrJJwAH/94falOgV6tMH98ZSN5o4z8jnM5Ju9ooSpLv
         AKcLqq8VPdZ2w6IckpYDTt1lR97z6J3hgp97nia+1Qdomubzl5k8JqU8a9rYZSBHb5O2
         webck98nj56cCrL4IIZN5+WcEgifKFwhMujU5kt2ybsu3dGGBeHwdkfK4hXOQ4KmVCMl
         eI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvSu/QZG+vBN7M80i1rf+nTHsoq+9cIz9cFemeGNZYuKnBPoWMdv3E1F3f3zfyWxkNmSRv0yOKBplxuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzuRTDAlVagyEothxjWEEMytRdlkZxaNiykQy62FsuuEIKgOLh
	iecUxQI2szF0Uz8Mko5Xdv+BBlbt6A9+gOa/YgOOjsVhfccyf3OfydKxjQrmHCpTuj7MwXGT3US
	g7X1U
X-Gm-Gg: ASbGncsjGjR7ETCHXCQL5EzEdngq9Awa6wFSFloTX19ttOUB/Qk7EOihw2H6Rq3tedQ
	jhRO7HRQkp0G8fPUxpgk/5wmhCAjwApSkLamzRhuwQ46R5+V7wRKG+Zb50HWPyBtAAUa8yLFI7G
	3sGd7PE8pPs9OP2uuhTon5P+bNzLF9gu+vV0iqGg1jW1GquTu/Ex91qCtJ+TkEWXP7HlnKQKm/W
	BA7WoYulBFwCxkwuYPTBcaAlGPMwHvLGy0bM9ZTV3cfYaA2NN8OHaHaTLH/1Hc5Xk2F16VABMqm
	gCJbXUz+9J62EyqShfr0vkBjn7eFOx29vSghG9fH2Fktu7xv8EZ47RezalJ/sUKmBnJguzYK7WY
	iVLqxrRPnI3rXoVvwHsukP3V8+/3xn3AIujHwnIGILvSuvVOF5PnMhL9CUT0YPQ==
X-Google-Smtp-Source: AGHT+IGcfX3qexg35gTxLyJq42TUCiS/5qVvIEdE7gBJP38Hot6fN3C1LszIZhMGtSGaHicBlM2tZg==
X-Received: by 2002:a05:6000:2011:b0:3c7:36f3:c352 with SMTP id ffacd0b85a97d-3d1df444ad2mr7469675f8f.59.1756804932539;
        Tue, 02 Sep 2025 02:22:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e05adsm5549521b3a.86.2025.09.02.02.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:22:12 -0700 (PDT)
Message-ID: <7f3398a0-9ea1-470f-83d2-f9e0f449246d@suse.com>
Date: Tue, 2 Sep 2025 18:52:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned
 device
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-4-naohiro.aota@wdc.com>
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
In-Reply-To: <20250902042920.4039355-4-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/2 13:59, Naohiro Aota 写道:
> This new test is based on mkfs-tests/001-basic-profiles, and it goes
> through the profiles to mkfs and do some basic checks.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Despite the cond_wait_for_nullbdevs() usage, the test case itself looks 
good to me.

With the comment in patch 2 addressed, feel free to add:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/mkfs-tests/039-zoned-profiles/test.sh | 98 +++++++++++++++++++++
>   1 file changed, 98 insertions(+)
>   create mode 100755 tests/mkfs-tests/039-zoned-profiles/test.sh
> 
> diff --git a/tests/mkfs-tests/039-zoned-profiles/test.sh b/tests/mkfs-tests/039-zoned-profiles/test.sh
> new file mode 100755
> index 000000000000..f40648cd06e1
> --- /dev/null
> +++ b/tests/mkfs-tests/039-zoned-profiles/test.sh
> @@ -0,0 +1,98 @@
> +#!/bin/bash
> +# test various blockgroup profile combinations, use nullb devices as block
> +# devices. This test is based on mkfs-tests/001-basic-profiles.
> +
> +source "$TEST_TOP/common" || exit
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +check_global_prereq blkzone
> +
> +setup_root_helper
> +# Create one 128M device with 4M zones, 32 of them
> +setup_nullbdevs 4 128 4
> +prepare_nullbdevs
> +dev1=${nullb_devs[1]}
> +
> +test_get_info()
> +{
> +	local tmp_out
> +
> +	tmp_out=$(_mktemp mkfs-get-info)
> +	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
> +	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
> +
> +	# Work around for kernel bug that will treat SINGLE and single
> +	# device RAID0 as the same.
> +	# Thus kernel may create new SINGLE chunks, causing extra warning
> +	# when testing single device RAID0.
> +	cond_wait_for_nullbdevs
> +	run_check $SUDO_HELPER mount -o ro "$dev1" "$TEST_MNT"
> +	run_check_stdout "$TOP/btrfs" filesystem df "$TEST_MNT" > "$tmp_out"
> +	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
> +		rm -- "$tmp_out"
> +		_fail "temporary chunks are not properly cleaned up"
> +	fi
> +	rm -- "$tmp_out"
> +	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
> +	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
> +	run_check $SUDO_HELPER umount "$TEST_MNT"
> +}
> +
> +test_do_mkfs()
> +{
> +	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$@"
> +	if run_check_stdout $SUDO_HELPER "$TOP/btrfs" check "$dev1" | grep -iq warning; then
> +		_fail "warnings found in check output"
> +	fi
> +}
> +
> +test_mkfs_single()
> +{
> +	test_do_mkfs "$@" "$dev1"
> +	test_get_info
> +}
> +test_mkfs_multi()
> +{
> +	test_do_mkfs "$@" ${nullb_devs[@]}
> +	test_get_info
> +}
> +
> +test_mkfs_single
> +test_mkfs_single  -d  single  -m  single
> +test_mkfs_single  -d  single  -m  dup
> +
> +test_mkfs_multi
> +test_mkfs_multi   -d  single  -m  single
> +
> +if [ -f "/sys/fs/btrfs/features/raid_stripe_tree" ]; then
> +	test_mkfs_single  -d  dup     -m  single
> +	test_mkfs_single  -d  dup     -m  dup
> +
> +	test_mkfs_multi   -d  raid0   -m  raid0
> +	test_mkfs_multi   -d  raid1   -m  raid1
> +	test_mkfs_multi   -d  raid10  -m  raid10
> +	# RAID5/6 are not yet supported.
> +	# test_mkfs_multi   -d  raid5   -m  raid5
> +	# test_mkfs_multi   -d  raid6   -m  raid6
> +	test_mkfs_multi   -d  dup     -m  dup
> +
> +	if [ -f "/sys/fs/btrfs/features/raid1c34" ]; then
> +		test_mkfs_multi   -d  raid1c3 -m  raid1c3
> +		test_mkfs_multi   -d  raid1c4 -m  raid1c4
> +	else
> +		_log "skip mount test, missing support for raid1c34"
> +		test_do_mkfs -d raid1c3 -m raid1c3 ${nullb_devs[@]}
> +		test_do_mkfs -d raid1c4 -m raid1c4 ${nullb_devs[@]}
> +	fi
> +
> +	# Non-standard profile/device combinations
> +
> +	# Single device raid0, two device raid10 (simple mount works on older kernels too)
> +	test_do_mkfs -d raid0 -m raid0 "$dev1"
> +	test_get_info
> +	test_do_mkfs -d raid10 -m raid10 "${nullb_devs[1]}" "${nullb_devs[2]}"
> +	test_get_info
> +fi
> +
> +cleanup_nullbdevs


