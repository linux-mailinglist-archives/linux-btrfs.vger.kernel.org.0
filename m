Return-Path: <linux-btrfs+bounces-4522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288978B0CC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6931C23B1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578615ECCF;
	Wed, 24 Apr 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei1BFnji"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352F15E1E2
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969557; cv=none; b=fbONMDaCwS0mGFQxb96AO1zypZgtZuFYQE5l6afiKBiND/MEDQhg48M6XYxPQwmXzDknNS+IQ3CG3ejiC0cmBBp9krXM47KwPjgMGKN+PMkP6pYoo/SHY+YOeRo16GR1X3/4e4ublE44n15jZYF0vLx18mC/zropb6dDhFfgVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969557; c=relaxed/simple;
	bh=XAbl9uKsSL1YQuC/vuQURtHlcvorwszjrj4XeQBG9ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUAiv6+WCykgu8BJ60SYvooZHefrJBR5JAtdpr9TXd6WFlInhA4Ye3BCVnTqCmS6+OU/0ZEKM+y3/UyZAELXwFX5qnpKnA+ZPgIIIZE1foQcoFaeB7B+v55+UlhadYqap9zflI4breCfCWvZBrvvbJTRT5x9ZJA85WTKKxVpaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ei1BFnji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713969555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep1+Ao+z80G1oChHzVrPpgBqM978Vqz/hWHbXwZj8Pg=;
	b=Ei1BFnjiSeX6tnkm3++fFyGt/gSp300vNoYGetczTxxpl84Em7v8zVf0MwV4v1B++TdASw
	HslXwwP6y6JrpwSt28V/0sPajBQ2ItNOFtyfwYDuBVP8w7Ime4Pd82Iv6MkxrVHXf3KO3G
	i3RKf5I2SjDesS2ii+IKN2Ng9P6NdSo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-y9ZjikFTNMCqjRrk2AvdHw-1; Wed, 24 Apr 2024 10:39:13 -0400
X-MC-Unique: y9ZjikFTNMCqjRrk2AvdHw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e4ad1c0fc8so95945955ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 07:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969552; x=1714574352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep1+Ao+z80G1oChHzVrPpgBqM978Vqz/hWHbXwZj8Pg=;
        b=w9SqZ+4g12JhIkcwXdw3E1I7Cd+hZ+fQF+qUZjXYpeet6huTKF1zwutxOGlQpSlAHU
         tEe8tQErAKWYwvL3E+ejhqK7l6e+Nv053VqMhIzEorwGP+qKfOhFUmjWh/Dfq6+WYIq1
         jJno/vth7UUHGx+L1F0HjKIfLhVP0TcmuY21LbZR8uRJr2rylQYebpkulyn0x62p5c+v
         02wRzE8raKyCjs5t5EIAr98sQ3Gt7R3Y6GNJPfXt/RkjkwrB0cLhyVEim15phSaMmnjM
         YGVQfVpx5YyGuWGaRNpo07O/2i0Jczwgd1BGOuXi86qgo7Boi29i8A+zvqT44utr+hVh
         oNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsVG9hfSmsu0ttPQk/TYjW+jw3iHDKMXr/XWxtwpPeIuGqBtjfrii+iT48fZYI7aoK93y7i9ix57TPlrN4BQ5IgwIUPQ2wOASBXAs=
X-Gm-Message-State: AOJu0YyZCV8y6lmCnuo8tMHishkfvK9a58fZwjrpfqWJZPsQbknbzrPS
	KJJYXGW9rDZoVS0wAtszbO1SpnUb9JjQj6XA3HR7Mlo3ioyv+T2fUgDZc8QcaeG6+BWq7euZSp2
	464X99ntOUmuEJ2ncYifaaJ3FxvIJ7FyGfbXgb2vdV9R+To5OVvkVZZym8/2C
X-Received: by 2002:a17:902:eb55:b0:1e4:3535:142d with SMTP id i21-20020a170902eb5500b001e43535142dmr2719834pli.34.1713969551571;
        Wed, 24 Apr 2024 07:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1CgEkFKSKmH7Lg7kKUrEuikfCnOhkdzATUNfqOfwX8HSis4QiBvKnpZAxgC0m0OcA7Vkulw==
X-Received: by 2002:a17:902:eb55:b0:1e4:3535:142d with SMTP id i21-20020a170902eb5500b001e43535142dmr2719811pli.34.1713969551045;
        Wed, 24 Apr 2024 07:39:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d89500b001e44578dccasm12026817plz.254.2024.04.24.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:39:10 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:39:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH v2 2/3] btrfs/290: fix btrfs_corrupt_block options
Message-ID: <20240424143906.44xupen7czhdxppb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1711097698.git.anand.jain@oracle.com>
 <4a6cada1ad70ca1f9cbb825d763364b71ac35514.1711097698.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6cada1ad70ca1f9cbb825d763364b71ac35514.1711097698.git.anand.jain@oracle.com>

On Fri, Mar 22, 2024 at 04:46:40PM +0530, Anand Jain wrote:
> Checks if the running btrfs-corrupt-block also has the options value and
> offset.
> 
> Remove btrfs-corrupt-block command's STDOUT and STDERR output redirection
> to /dev/null. Without this, debugging wasn't possible. I also noticed that
> command is quiet when successfull, so no redirect to $seqres.full is required.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/290 | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/btrfs/290 b/tests/btrfs/290
> index 61e741faeb45..281333b200f9 100755
> --- a/tests/btrfs/290
> +++ b/tests/btrfs/290
> @@ -31,7 +31,8 @@ _require_odirect
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "pread"
>  _require_xfs_io_command "pwrite"
> -_require_btrfs_corrupt_block
> +_require_btrfs_corrupt_block "value"
> +_require_btrfs_corrupt_block "offset"
>  _disable_fsverity_signatures
>  
>  get_ino() {
> @@ -58,7 +59,7 @@ corrupt_inline() {
>  	_scratch_unmount
>  	# inline data starts at disk_bytenr
>  	# overwrite the first u64 with random bogus junk
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV > /dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> @@ -72,7 +73,7 @@ corrupt_prealloc_to_reg() {
>  	_scratch_unmount
>  	# ensure non-zero at the pre-allocated region on disk
>  	# set extent type from prealloc (2) to reg (1)
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV >/dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type --value 1 $SCRATCH_DEV
>  	_scratch_mount
>  	# now that it's a regular file, reading actually looks at the previously
>  	# preallocated region, so ensure that has non-zero contents.
> @@ -88,7 +89,7 @@ corrupt_reg_to_prealloc() {
>  	_fsv_enable $f
>  	_scratch_unmount
>  	# set type from reg (1) to prealloc (2)
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV >/dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type --value 2 $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> @@ -104,7 +105,8 @@ corrupt_punch_hole() {
>  	_fsv_enable $f
>  	_scratch_unmount
>  	# change disk_bytenr to 0, representing a hole
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SCRATCH_DEV > /dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value 0 \
> +								    $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> @@ -118,7 +120,8 @@ corrupt_plug_hole() {
>  	_fsv_enable $f
>  	_scratch_unmount
>  	# change disk_bytenr to some value, plugging the hole
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639680 $SCRATCH_DEV > /dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
> +						   --value 13639680 $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> @@ -132,7 +135,8 @@ corrupt_verity_descriptor() {
>  	_scratch_unmount
>  	# key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_KEY, 1>,
>  	# 88 is X. So we write 5 Xs to the start of the descriptor
> -	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 0 -b 5 $SCRATCH_DEV > /dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 --value 88 --offset 0 -b 5 \
> +								    $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> @@ -144,7 +148,8 @@ corrupt_root_hash() {
>  	local ino=$(get_ino $f)
>  	_fsv_enable $f
>  	_scratch_unmount
> -	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 16 -b 1 $SCRATCH_DEV > /dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 --value 88 --offset 16 -b 1 \
> +								    $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> @@ -159,7 +164,8 @@ corrupt_merkle_tree() {
>  	# key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM_KEY, 0>,
>  	# 88 is X. So we write 5 Xs to somewhere in the middle of the first
>  	# merkle item
> -	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SCRATCH_DEV > /dev/null 2>&1
> +	$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 --value 88 --offset 100 \
> +							       -b 5 $SCRATCH_DEV
>  	_scratch_mount
>  	validate $f
>  }
> -- 
> 2.39.3
> 
> 


