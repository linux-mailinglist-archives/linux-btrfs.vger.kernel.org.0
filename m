Return-Path: <linux-btrfs+bounces-18330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EAC08EED
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAE484E9DFC
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEC2EB85C;
	Sat, 25 Oct 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JKfg2thk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FA2E9722
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387217; cv=none; b=EjQc8gIZO8nzjCLD10aVX4ykwlaOaABRS9vOTE51ZXwutoGcH08gA+09AwJZyc3n43KTh7NxYZe4YByxWYMrjPd+UuaCJbLvLXnF4+ZM/4iR9pkyYfPkxQKmxV9Mwojvtwj5eJ3a4ELYiUuXyC5hSOKyXfGb6foUODwRfEnJC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387217; c=relaxed/simple;
	bh=x5Zfju5tq/4qygh6E3gfDeoUeTXHi3cFBw2ntwHfFhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+3Uo9lHk18err6uBp7jaaDb+k2/mh/8+ka0ekN7njrRalfjByQoPoBTKEE6/FxF2+JEK10BfUnZCkuELZov/iumW0dicFagZ4KTcO4atxzchMzGw7RGSZRt6Rt8Pbbh1WC5k0FvCK/N/ppVnT8N7Of+fQsoHWf230lR15RSAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JKfg2thk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-474975af41dso19849455e9.2
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761387214; x=1761992014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9PtPsexDpDiFXe6bvXUwGadaGf7cY3dlOxZFz1GquK8=;
        b=JKfg2thk4sZUJCYxN2uE2h6h1iV+dNatEMrdGsVpGjRkZd6LUT61vo00SshXeUSRsO
         eyoPMsBodYIt7gopEMt6EkBM72QkXx3pwLJJlTrTnXVAytPpGch7O+8a4UDtFADBk1up
         CH8LBsjwEknlj8uXtnIvjgU1p9oB9lMfIDCOkoAw03JNdJbBYdxwVx99SHYLiezo9jy5
         kcFWYvnE1LdhG3yU7AY3k1ZupPuP5PySQugt0a57A5rPPAyE0Vz7Bpc54DiivciT0vUP
         0o756pl2WgLu7xcQPr+4h1aGjZWgrirWpeX7WnWwTfVy3WAkWMup4FFAxfJOgxoexDpI
         aLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387214; x=1761992014;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PtPsexDpDiFXe6bvXUwGadaGf7cY3dlOxZFz1GquK8=;
        b=jSELK2/PY1P1+4Ute3stwXBZvS3Y1Oz3LMVweDYxEA9mUb+JVEyOePK9uuqvu7z6u/
         F4kI+MuLxqVaDWClvMoFw3gUGpqpoysUiYFIfG/JIkdtJieEO6ood4Pcym1y6GzhYLep
         uMWW1bIwgYl69LdeVcb7S81cf7Owd426ZiII78vjvicuqU5zkRynyeDnHbnT3xL6iPKv
         so3cegVxD4ctQNgewNbcSQ4/dROKil6lkWkoobKLo/Edd9Y2JQ+NHY6R3aVArHXN6vFr
         khqJLiUA9mYu9b19/gKlKltJf5mt90uBpp0Q1SMyDGhqXXvfyHcuesf2PNuUtly9bAs+
         cBsQ==
X-Gm-Message-State: AOJu0Yy6k/Z8vrRYaNySbR9t1/fpmraXZQ+4E6AjkvPug+qK/Tqd7JE2
	NenjT7lZeObWKxZ/QKxxEXGGD6ylq35Vbg5HhZOwn7Iamgg76VzAOGiOBxS3YRD7OCs=
X-Gm-Gg: ASbGncvfW/tUD3UuVniVJMkjEfip3+Y+z9UPqYStUUSATZWrp+r8Xo8qy6Tl6nd1XFX
	xDPVPsMZXqqccrR1us76juGf8sk8ZUZ/qJIPsi4UCyiJcJi/xAsiYJ4gmggs0xdJNzLBe8OE4az
	uoJq/0wAUaslpoqqpTUentIWUA8TsZ9xVYdgGHz7XFMzrzym1Lft2/0mM/ll4HcTXS9t+RhF5dk
	9yawt8rTvs/5oPFs8eOHXs3TOStlDefOelkiujK/dty7XWLX+RUGArcMl2nmoBz8ofaU2PkJF6t
	UtkB4RY9KfinkaaSPtOlwZqEq63ZkEhy4FNNeykjqtDa5wGqAcbHtyNCAlN6itX9k9sd3s306MG
	1cme9rso1TPq84TGKpf5Y1Bvy+5rB8mSBCTGzECTUTmwLsR9ebR/E0VZi0yLqnPloPgiUUwAVA4
	r38XRJvCcB3D7n6/qOsvPLSUulPYlCsi5KhwhdRPo=
X-Google-Smtp-Source: AGHT+IHJYhhAB98ygsyvpxZ4Q7D8SToFy9rFnyfTSxKbc6zRFxwpSVGA7ABW+SJh7DeencBNdAEA9A==
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id 5b1f17b1804b1-471178785e1mr246763685e9.8.1761387213804;
        Sat, 25 Oct 2025 03:13:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e44262sm18560465ad.102.2025.10.25.03.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 03:13:33 -0700 (PDT)
Message-ID: <bb46518c-9836-4bd2-8142-fbb8c859fd3f@suse.com>
Date: Sat, 25 Oct 2025 20:43:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test fsync of directory after renaming new
 symlink
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
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
In-Reply-To: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 22:23, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a directory that has a new symlink, then rename the
> symlink and fsync again the directory, after a power failure the symlink
> exists with the new name and not the old one.
> 
> This is to exercise a bug in btrfs where we ended up not persisting the
> new name of the symlink. That is fixed by a kernel patch that has the
> following subject:
> 
>   "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/generic/779     | 60 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/779.out |  2 ++
>   2 files changed, 62 insertions(+)
>   create mode 100755 tests/generic/779
>   create mode 100644 tests/generic/779.out
> 
> diff --git a/tests/generic/779 b/tests/generic/779
> new file mode 100755
> index 00000000..40d1a86c
> --- /dev/null
> +++ b/tests/generic/779
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 779
> +#
> +# Test that if we fsync a directory that has a new symlink, then rename the
> +# symlink and fsync again the directory, after a power failure the symlink
> +# exists with the new name and not the old one.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_symlinks
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> +
> +rm -f $seqres.full

Looks like a rouge command?


Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test dir and add a symlink inside it.
> +mkdir $SCRATCH_MNT/dir
> +ln -s foobar $SCRATCH_MNT/dir/old-slink
> +
> +# Fsync the test dir, should persist the symlink.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Rename the symlink and fsync the directory. It should persist the new symlink
> +# name.
> +mv $SCRATCH_MNT/dir/old-slink $SCRATCH_MNT/dir/new-slink
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# Check that the symlink exists with the new name and has the correct content.
> +[ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not found"
> +echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
> +
> +_unmount_flakey
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/779.out b/tests/generic/779.out
> new file mode 100644
> index 00000000..c595cd01
> --- /dev/null
> +++ b/tests/generic/779.out
> @@ -0,0 +1,2 @@
> +QA output created by 779
> +symlink content: foobar


