Return-Path: <linux-btrfs+bounces-9170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854479B0A5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965B1B232E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11D20BB4F;
	Fri, 25 Oct 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HisIF6Ct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480F20BB42
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875238; cv=none; b=pHxh+7T0rWYw+6oKdo4BEJeq8ABc6Uqoh1r+HHZe2NH3/WQiEYAJttsbO6xZ5l29CiOIkfB4bmiZ4FL3VXJ9nUEvevHgaHVwu/MuMYnAZu+gXrxSUz1163BkpBSc7kjJ4hQBG6pVus7mSrSTgBwaWnm24C268Cl8CnswjQP6qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875238; c=relaxed/simple;
	bh=sSYBq/xF/blFhnlo5Vs+Onf4gnOIphSaPeNe7ovGKUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g34PUBGmGkJMDTwVRh7BG8zZ+9akksphPRU7Uajg+LtKtcSDlKiwOopVTT/5Ued/gMslYE206sUNnHBFN+TIIx3nU2lUGK3GLr4COQvA8dHvR3dL4HAvJM5M58Wrywi5HeyQ0hKae7xddwimhKEEIKdE4K+gpngDuLZ85zylCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HisIF6Ct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729875235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLkaSdhoS06au728fQoj3BRyrW97t5u+D9r7+bwp0Y0=;
	b=HisIF6CtmOmDmKrsHwj/AIYz6tolhHygtXaDfltk4sa5IZQQkHSMwBUsEDiTiW8053Shn6
	w945Cu/DOJljVQ1ZSO6oE5CFp1AiSLCJeVoM2Ai6D7O9H5/G74OyFPCCJg53A+PwZtHpEf
	NcziaMN5FAMRmtU7Z2SZwvNz0Fk/Cr0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-5InseEwqMYmI_szl7U35Xg-1; Fri, 25 Oct 2024 12:53:54 -0400
X-MC-Unique: 5InseEwqMYmI_szl7U35Xg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so2181983a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 09:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875233; x=1730480033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLkaSdhoS06au728fQoj3BRyrW97t5u+D9r7+bwp0Y0=;
        b=ID5Eym8mX/2ep9tAFD9UHw1kxkbv9uAKAEQ5bjR9MuLxro2v6tT2Ed/61l1K+Q9Pqx
         Bj2tHEEKvWCBKv3uV5aS2V8BGvqQz/7iq7ZIinZR78UyhO6bOCV0u737fh+6tGO2KRZn
         NtTmKUaiFCBKEPBqb/9rbgNx0NKt2hFr+GilZSGcc9xSBdhCotIPHSe2WRvlG+eTP6lu
         YGelLSebkSvfndky7R4FeCfk+G31dWJsEAYCYmvM/ht/dN62I9iahu2TKu9SYyRo6UXU
         dButh+mMKxmKWAKKosPaM203LgVTS9JaR1KFY620GwrEpKWKoYRLbFz/+78ef8tj2cxX
         +Bgg==
X-Forwarded-Encrypted: i=1; AJvYcCWEigtGTk5UdHez9uynnSdQAvraslBS+2W3lh0Ril9UPsjqSaT6h8b4CKr+Kn9pYV36xs3l/Hd9aAE2bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFi6Yyz4zO6WARk+mPRwhnme6KFaxvhO/weEx+69b+WIqEmUDz
	BVe0JSURMcnW4TOR6LGNh2tvBqibsM3cwecZDFPbdbDK1lAv2muryAQ9M6t78SPOvGyr0nyHmwV
	vp+Zp1/r7mXn9dsyFcjmfqgHxzN5dwEpWquncYqcSuCmmisVUbFywjMWPYd5Psk4iYtB7XrQ=
X-Received: by 2002:a05:6a20:c997:b0:1d9:1dcd:b22c with SMTP id adf61e73a8af0-1d978bd014amr12289502637.47.1729875232803;
        Fri, 25 Oct 2024 09:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3iQ8c47Xa00f7HCNeZ7ROeMpT/AsSNfyZt7nMop5zeAlAtdECQhOSzT5BQ/Y7HGoyr4VOEA==
X-Received: by 2002:a05:6a20:c997:b0:1d9:1dcd:b22c with SMTP id adf61e73a8af0-1d978bd014amr12289474637.47.1729875232381;
        Fri, 25 Oct 2024 09:53:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931abesm1279778b3a.73.2024.10.25.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:53:52 -0700 (PDT)
Date: Sat, 26 Oct 2024 00:53:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test remount with "compress" clears
 "compress-force"
Message-ID: <20241025165348.dgtgksykvpkfh3mb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>

On Fri, Oct 25, 2024 at 12:27:01PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that remounting with the "compress" mount option clears the
> "compress-force" mount option previously specified.
> 
> This tests a regression introduced with kernel 6.8 and recently fixed by
> the following kernel commit:
> 
>   3510e684b8f6 ("btrfs: clear force-compress on remount when compress mount option is given")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/323     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/323.out |  2 ++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/btrfs/323
>  create mode 100644 tests/btrfs/323.out
> 
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 00000000..fd2e2250
> --- /dev/null
> +++ b/tests/btrfs/323
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# Test that remounting with the "compress" mount option clears the
> +# "compress-force" mount option previously specified.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount remount compress
> +
> +_require_scratch
> +
> +_fixed_by_kernel_commit 3510e684b8f6 \
> +	"btrfs: clear force-compress on remount when compress mount option is given"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount -o compress-force=zlib:9
> +
> +# Confirm we have compress-force with zlib:9
> +_mount | grep $SCRATCH_DEV | grep -q 'compress-force=zlib:9'

How about:

grep -wq 'compress-force=zlib:9' <(findmnt -rncv -S $SCRATCH_DEV -o OPTIONS)

> +if [ $? -ne 0 ]; then
> +	echo "compress-force not set to zlib:9 after initial mount:"
> +	_mount | grep $SCRATCH_DEV
> +fi
> +
> +# Remount with compress=zlib:4, which should clear compress-force and set the
> +# algorithm to zlib:4.
> +_scratch_remount compress=zlib:4
> +
> +_mount | grep $SCRATCH_DEV | grep -q 'compress=zlib:4'

Same as above.

Others looks good to me.

Thanks,
Zorro

> +if [ $? -ne 0 ]; then
> +	echo "compress not set to zlib:4 after remount:"
> +	_mount | grep $SCRATCH_DEV
> +fi
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> new file mode 100644
> index 00000000..5dba9b5f
> --- /dev/null
> +++ b/tests/btrfs/323.out
> @@ -0,0 +1,2 @@
> +QA output created by 323
> +Silence is golden
> -- 
> 2.43.0
> 
> 


