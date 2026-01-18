Return-Path: <linux-btrfs+bounces-20665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C715D39921
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 19:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA803009489
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F713002CF;
	Sun, 18 Jan 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7nK/1Du";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaE9Gpvm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB924CEEA
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761079; cv=none; b=aVLNZiYue0XEQteDMTkZzhBoPL4gZditTJgZAMJnpzOKBzyELZ1fw5FCiZEOMfuH5VWFyvV7cIm4UfrWqdtcCPksX7F+hfdOUAPaWJriKSjOuCbNFXJWotDQBqDpkBHIXbIOIhwhxR3Lld+XfLSffvInD6uympN1/xDPZ+OcwH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761079; c=relaxed/simple;
	bh=p4xbpahW23b6CuP5GAQIEKesjiAvJi4Rd420YvEfLM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz1c5g/ZDGIwzugKz5avXVdDo3OcXOT9l+NM99FH0uNWpZ6rhqvAnj5S87Sp4V9u+jQNQ5XGcHUPaPV60s2sKVMUp9hse6ySxU0zy2Fmc2kil6z6PWlYOzXHP6vzfAbLjVAypagBJSBfGAjW1DR/x4QBtEb4yaOZfmrhlnZoYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7nK/1Du; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaE9Gpvm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768761077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PG+WnZVURBwXNb9Mlsn+dS5PAcavg3GNKoQtMm8KL5I=;
	b=V7nK/1DuVhiyphptTV05MTkNImHoez4FF8HyrGi6CZFE9FHWno7STUk+VkpEUsUQaXNPx1
	vlUw3Wei42b+GjuU79koKJ+5ILUu3TiQAZwPvEifim2tuJkTvhJmzxkTcZ987rnujdJUEP
	/25GrVcueJiJy+7ZB3hGXol9Ynfo6Uc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-LPHkQ8vYNNq9f0bwVARMKw-1; Sun, 18 Jan 2026 13:31:15 -0500
X-MC-Unique: LPHkQ8vYNNq9f0bwVARMKw-1
X-Mimecast-MFC-AGG-ID: LPHkQ8vYNNq9f0bwVARMKw_1768761075
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso7267642a91.1
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768761075; x=1769365875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PG+WnZVURBwXNb9Mlsn+dS5PAcavg3GNKoQtMm8KL5I=;
        b=UaE9GpvmPuRdxl0OJDFiOl2bEMOE/xkiNRuKS9Kqb8LVM7FjorQI/ufvrH8as5k9Cf
         u/22h2+UhosaPZWv4UGUYqpsOjlV6ZZ7S2xNuWhWMrx4KkJzOga6lGUyBpyCpxe0cQ/F
         DEmXOXXtTeAdEkR3USr7+yflNSJaL0lf1pClBIZ+UwXrEllX4tVv2mGMnVDKDzVO/tNP
         zWRH2Mc2X0df7bCQd6wfItfC2TdhcwlYs+2gEY0lEP7ADH5qwFrsgzOoomElq3rm4jQ5
         IamS0/nK76CJC2d3665OG5mVcSEMEN8hUC59s82ap7yvioGujfXgqApTmFu+/UKgr8Y2
         ocoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768761075; x=1769365875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG+WnZVURBwXNb9Mlsn+dS5PAcavg3GNKoQtMm8KL5I=;
        b=eYa08IXRqMxS5OkXq/3r5ULvm55J6SXSFrLPymEOgf+TDrlV634JguFXCnrcMBFH3R
         Lxq2vMMLTSyN75QBKv6oYhQ0n4CFJNBQEMEFR5RiRs94ufX0yFuXcun3KLGO46U6r4o6
         FFmiUzChcIkOoldKuixV4ug/2xQhIs6BxjTip3TPSI4g4KnDRpsZxhAMDdhKCINmDIXZ
         0cg0P98smjVTu84kL26rGi5tR1uCGiBLwTWEV2ejdhqVwFLv4XSNxNMPipBdrqc87Paz
         Zr8cIIqm8Sy3+e99+J2maqjOXk25632cdgjdXcViZtW/LOk2I1HlSiQg1Y/GqbAC03f8
         ouvQ==
X-Gm-Message-State: AOJu0YynpLi/T9Ymq8deqeMETKbGgpRndvdz0/avDAuOx4jHHNP9W7Ol
	GvzqjQn2SQuxEk3ZyaTnNdT3ORIAc2ApKmceXDzqFK8zX6Ca6ybHLvxeHH7T3gN+gS9l+yGYbze
	I+4f75+w3S9/uylpmdpRLF+3KAx8h8B6p4xArVlDP1t5jMZ7eZtGcP9lQUnxcwP+B
X-Gm-Gg: AY/fxX7ctUDUtCQMsodoLbDdNjEZfvCITIPNrnX4eh3eyTPh1I/pZ1VXXyP+TScY3f/
	8/A68zhTPP5rKDaynosRtvumkq75d/++3/Faehhlwk8U8VEihvLLGKIvWtpefGKVvWL17CUeh1h
	Y5ydsekcb/rEZ6MkLj41bNDwMpgIvFxZsBkBMPLZ9/R8Wj7+atKMIuCOUJBE6O14fqI2n46IWI4
	jqMdNxjmpIzrSiPpFGBUY4Q+R8RulRAKw4Ivl0H69/HfajESkG+0U0vPfrGA95JYZeyVDnKG50H
	rRFSjsfEoHHRMZoWkhULRu4vfNTkXNGnD7+Cz03qVn/5qxjnBcYHu7+6IWP8WtJmHy40BIm3eQW
	6y2M41GcJfIWq1GStwzHcw7tWQ8tP6R+Qvok0uqEgB2Rb3xiMrA==
X-Received: by 2002:a17:90b:180b:b0:34c:253d:581d with SMTP id 98e67ed59e1d1-35272ee18e5mr7721203a91.9.1768761074591;
        Sun, 18 Jan 2026 10:31:14 -0800 (PST)
X-Received: by 2002:a17:90b:180b:b0:34c:253d:581d with SMTP id 98e67ed59e1d1-35272ee18e5mr7721187a91.9.1768761074132;
        Sun, 18 Jan 2026 10:31:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527313c2a9sm7049023a91.17.2026.01.18.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:31:12 -0800 (PST)
Date: Mon, 19 Jan 2026 02:31:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: btrfs: add a new test case that is
 future-proof
Message-ID: <20260118183108.uck7fqg3utjh7wuq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251225221553.19254-1-wqu@suse.com>
 <20251225221553.19254-3-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225221553.19254-3-wqu@suse.com>

On Fri, Dec 26, 2025 at 08:45:53AM +1030, Qu Wenruo wrote:
> Btrfs' v1 space cache is marked deprecated since commit 1e7bec1f7d65
> ("btrfs: emit a warning about space cache v1 being deprecated"), and
> soon the v1 space cache mount option will be fully dropped.
> 
> Furthermore existing features like block-group-tree, zoned, and bs != ps
> support are all rejecting v1 space cache or forcing the switch to v2
> space cache.
> 
> The existing btrfs/131 is not going to handle the future well, and that
> test case is mostly for LTS kernel testing now.
> 
> Add a new test case that is completely v1 cache free, so that it will
> support the future where v1 cache is completely dropped, meanwhile still
> keep the coverage for v2 cache and nospace_cache mount options.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/131     |   5 ++-
>  tests/btrfs/340     | 103 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/340.out |  15 +++++++
>  3 files changed, 122 insertions(+), 1 deletion(-)
>  create mode 100755 tests/btrfs/340
>  create mode 100644 tests/btrfs/340.out
> 
> diff --git a/tests/btrfs/131 b/tests/btrfs/131
> index 026d11e6..b54b8326 100755
> --- a/tests/btrfs/131
> +++ b/tests/btrfs/131
> @@ -4,7 +4,10 @@
>  #
>  # FS QA Test 131
>  #
> -# Test free space tree mount options.
> +# Test free space tree mount options, 3 options involved:
> +# - No space cache
> +# - Old (deprecated) v1 space cache
> +# - New (default) v2 space cache
>  #
>  . ./common/preamble
>  _begin_fstest auto quick
> diff --git a/tests/btrfs/340 b/tests/btrfs/340
> new file mode 100755
> index 00000000..0d558422
> --- /dev/null
> +++ b/tests/btrfs/340
> @@ -0,0 +1,103 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 340
> +#
> +# Test free space tree mount options, for newer kernels with only 2 options involed:
> +# - No space cache
> +# - New (default) v2 space cache
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-super
> +_require_btrfs_fs_feature free_space_tree
> +
> +# The block-group-tree feature relies on v2 cache, thus it doesn't support
> +# "nospace_cache" mount option.
> +_require_btrfs_no_block_group_tree
> +
> +mkfs_nocache()
> +{
> +	_scratch_mkfs >/dev/null 2>&1
> +	_scratch_mount -o clear_cache,nospace_cache
> +	_scratch_unmount
> +}
> +
> +mkfs_v2()
> +{
> +	_scratch_mkfs >/dev/null 2>&1
> +	_scratch_mount -o space_cache=v2
> +	_scratch_unmount
> +}
> +
> +check_fst_compat()
> +{
> +	compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV" | \
> +		     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
> +	if ((compat_ro & 0x1)); then
> +		echo "free space tree is enabled"
> +	else
> +		echo "free space tree is disabled"
> +	fi
> +}
> +
> +# Mount options might interfere.
> +export MOUNT_OPTIONS=""
> +
> +# When the free space tree is not enabled:
> +# -o space_cache=v2: enable the free space tree
> +# -o clear_cache,space_cache=v2: clear the old space cache and enable the free space tree
> +# We don't check the no options case or plain space_cache as that will change
> +# in the future to turn on space_cache=v2.
> +
> +mkfs_nocache
> +echo "Using no space cache"
> +_scratch_mount -o nospace_cache
> +check_fst_compat
> +_scratch_unmount
> +
> +mkfs_nocache
> +echo "Enabling free space tree"
> +_scratch_mount -o space_cache=v2
> +check_fst_compat
> +_scratch_unmount
> +
> +# When the free space tree is enabled:
> +# -o nospace_cache: error
> +# no options, -o space_cache=v2: keep using the free space tree
> +# -o clear_cache, -o clear_cache,space_cache=v2: clear and recreate the free space tree
> +# -o clear_cache,nospace_cache: clear the free space tree
> +
> +mkfs_v2
> +echo "Trying to mount without free space tree"
> +_try_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
> +
> +mkfs_v2
> +echo "Mounting existing free space tree"
> +_scratch_mount
> +check_fst_compat
> +_scratch_unmount
> +_scratch_mount -o space_cache=v2
> +check_fst_compat
> +_scratch_unmount
> +
> +mkfs_v2
> +echo "Recreating free space tree"
> +_scratch_mount -o clear_cache,space_cache=v2
> +check_fst_compat
> +_scratch_unmount
> +mkfs_v2
> +_scratch_mount -o clear_cache
> +check_fst_compat
> +_scratch_unmount
> +
> +mkfs_v2
> +echo "Disabling free space tree"
> +_scratch_mount -o clear_cache,nospace_cache
> +check_fst_compat
> +_scratch_unmount
> +
> +_exit 0
> diff --git a/tests/btrfs/340.out b/tests/btrfs/340.out
> new file mode 100644
> index 00000000..d8b99b3b
> --- /dev/null
> +++ b/tests/btrfs/340.out
> @@ -0,0 +1,15 @@
> +QA output created by 340
> +Using no space cache
> +free space tree is disabled
> +Enabling free space tree
> +free space tree is enabled
> +Trying to mount without free space tree
> +mount failed
> +Mounting existing free space tree
> +free space tree is enabled
> +free space tree is enabled
> +Recreating free space tree
> +free space tree is enabled
> +free space tree is enabled
> +Disabling free space tree
> +free space tree is disabled
> -- 
> 2.51.2
> 
> 


