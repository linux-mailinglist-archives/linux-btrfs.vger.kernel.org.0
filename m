Return-Path: <linux-btrfs+bounces-5160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521588CAFDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93A0B220B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5E7EF0C;
	Tue, 21 May 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g97+lkVg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA91E502
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300105; cv=none; b=ohu1gzn7AaS3USKfsl1wOKglLBx/5PeJ7iWBx1MOk4QkteOtA8DI7XbvwcGNcqfTJnhtALMmffr6lqB01O5ySDFbeO5ZMpj6YQvWZwPTUsQPhfitig+wxbC3daGRIppk/qmlMlTbV9BsklsJkRN3EvF8ps0g2OicLvhg15Mw5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300105; c=relaxed/simple;
	bh=EYqKcCI3tv2tT6clHDjGD3Z92vug3Et1dPHP3EkvB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCcmHKOD6FIPlHphPhcQGih83sZC9n4YOE+62vVIN78xZTsZGWLgVbSWHacj4oP6wBF4q1+/KyZ/PDqPqPxPZajxxsiPMYxyjJ2bxAu3oTqLm7Vo/040EX8WAVm483G+Mz/DcLjy+mF9u60VkMNJBsUzwSKxTQtuGXY75fK+aHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g97+lkVg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716300103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9UZBaBm0Gs/lAN/t3Z/bR3D6w1BaSGi3sD1JXjc9P0=;
	b=g97+lkVg32zcW6Byk4X17UkgYyIDoMezmlbMt2fuxp6oAvOrU/b4YBn492HlZAbjPivNXN
	v8KFV9WnEhFhRE5eWLSrmUa1LqmA4zAM/6mq2WaAOB+zlFzLaM9J6NhiJR3msicq33eOrZ
	5/kJHTJ9YSnddmLsP//3uuzG0s9+mAE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-j8j7LBPCOPG3UOPmJ26bQw-1; Tue, 21 May 2024 10:01:41 -0400
X-MC-Unique: j8j7LBPCOPG3UOPmJ26bQw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e54e6ba9a1so118935985ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300100; x=1716904900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9UZBaBm0Gs/lAN/t3Z/bR3D6w1BaSGi3sD1JXjc9P0=;
        b=USmBsmcNgpnEsLsyyaxp/h3axvLBMmWDZ1EUdrVCyAIv0Xtgw2DAyiXWZ+3PTQ0kt9
         tmc8KaUgXM1VtwxAYTEUo7EI873cIl4TP8e6BBAIDF+LmasZYn8cvNK1iZ9T2J52vG7N
         GW653/yZufZ/Y1eRjX7YamxMqUUs9KSLQeFJsPj8doRHqvlyX17ce1s0C3Zo6xz4RO1u
         mDA/7r6/QdHg22muf8Sf6nfLOrO9E03nhTnLMvQzpjNEUEgDw0XtbjsyPVLEUwTpoOOw
         xNPzfrZGuZEORipYzim3A+RxK1HP02gVxVPDl4NINLjC2IOv35M+zRHB+Z4p/G73hH6g
         Thsw==
X-Forwarded-Encrypted: i=1; AJvYcCU2EZE6r6yjOGKB28XaNQnLrkCG5twEaB38/p6qOQ4APaNdwa6ffJ7hVHQmf8+YVHSp1YKsPIRhcYyPc3VcDgQS+/LzDT6ErHi8Q/w=
X-Gm-Message-State: AOJu0Yxq5I4ZxdrE82dd3XoeAkksjdn6Cn1fYcWrnjezcvrxe0zj6cRf
	mAbmgg8ux4PVwobpJpYpV+Fr0yxhQ+HxMOG2oWfjw1WacccBt/FARraaQ3/f8uTPMqYHNOdAP6J
	ttv3fnVsTD1b8TQEFj/qXv7gRNXHRSmqEF4BQ/SG8UIE29rP+a4LU+7Baq/3q
X-Received: by 2002:a17:902:e546:b0:1f2:f107:5a71 with SMTP id d9443c01a7336-1f2f107618fmr102622465ad.44.1716300099070;
        Tue, 21 May 2024 07:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECtVoYVSuGzI2BlB2iJoT8bqImwLA9462R5K2Fv1nNwba64aKryGPgjWXLKArNybXPfq7WiQ==
X-Received: by 2002:a17:902:e546:b0:1f2:f107:5a71 with SMTP id d9443c01a7336-1f2f107618fmr102621755ad.44.1716300098211;
        Tue, 21 May 2024 07:01:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm222621585ad.111.2024.05.21.07.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:01:37 -0700 (PDT)
Date: Tue, 21 May 2024 22:01:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/733: add commit ID for btrfs
Message-ID: <20240521140134.gicbq65cksob5yno@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>

On Tue, May 21, 2024 at 01:01:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> As of commit 5d6f0e9890ed ("btrfs: stop locking the source extent range
> during reflink"), btrfs now does reflink operations without locking the
> source file's range, allowing concurrent reads in the whole source file.
> So update the test to annotate that commit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Make sense to me, Thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/733 | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index d88d92a4..f6ee7f71 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -7,7 +7,8 @@
>  # Race file reads with a very slow reflink operation to see if the reads
>  # actually complete while the reflink is ongoing.  This is a functionality
>  # test for XFS commit 14a537983b22 "xfs: allow read IO and FICLONE to run
> -# concurrently".
> +# concurrently" and for BTRFS commit 5d6f0e9890ed "btrfs: stop locking the
> +# source extent range during reflink".
>  #
>  . ./common/preamble
>  _begin_fstest auto clone punch
> @@ -26,8 +27,16 @@ _require_test_program "punch-alternating"
>  _require_test_program "t_reflink_read_race"
>  _require_command "$TIMEOUT_PROG" timeout
>  
> -[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 14a537983b22 \
> -        "xfs: allow read IO and FICLONE to run concurrently"
> +case "$FSTYP" in
> +"btrfs")
> +	_fixed_by_kernel_commit 5d6f0e9890ed \
> +		"btrfs: stop locking the source extent range during reflink"
> +	;;
> +"xfs")
> +	_fixed_by_kernel_commit 14a537983b22 \
> +		"xfs: allow read IO and FICLONE to run concurrently"
> +	;;
> +esac
>  
>  rm -f "$seqres.full"
>  
> -- 
> 2.43.0
> 
> 


