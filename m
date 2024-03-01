Return-Path: <linux-btrfs+bounces-2969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500486E313
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 15:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFC1F216A3
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1D6F068;
	Fri,  1 Mar 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4luTfMw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64667E8D
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302361; cv=none; b=k3h5VkFubnsGBxGsGF6e+ZLvS/myAbi1MEjTrwACr7woHD35kK1okw8gbKzLpTfx8uU6IFAwrvZsXW91t2vhdsFWWVIN6oLuZbSey5bzYibLgijUujrKjzLQMFYTTBTey51Pt8YdbRPL5Ylb/iyafr8OsvjQZ+0/U2hFADcHYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302361; c=relaxed/simple;
	bh=pIfWibMpp5XPXyNj1sNFiUM1Hfjlj5ujCxHao5zNgEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laMZJgMhyA7/v+aeLmhRvWcif2nDgly++C2XGlNqLU6XqFFoArauGYAYO3pdiphJeSfBT8Fw622ocKEWyV56o4NOkNBGvIDMsY7DSc35ZZ5cK3vHSNA1ZX+mWtoMx5JhtCmBsRFqJscXdnRZvz4yvaj+Ehb/csIZn4utd3K6Vxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4luTfMw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709302358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YSORZ73UJDAidZR+pC0izmOtZN3r6vj44aflxQx8oM=;
	b=L4luTfMw4dfQZubert2zLPB6zIrnVJdwK5ZFa/F9inb0RBDS3J5eIfjpMZmcJFYw96w+az
	Nz315YQLaM1nxcxAdnUiAjDS/ooJZ9ovyWyLQxc0N3APBizoSCwrasugq64lPAjUor8ahM
	EKbVVoZ/MnFzyuv8WPd3accghS6Wno0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-nk1h_tOpNdii3kEiG-E09w-1; Fri, 01 Mar 2024 09:12:37 -0500
X-MC-Unique: nk1h_tOpNdii3kEiG-E09w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e5ad4376e7so1390556b3a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Mar 2024 06:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302356; x=1709907156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YSORZ73UJDAidZR+pC0izmOtZN3r6vj44aflxQx8oM=;
        b=k/f130chtwTcEbhItSod7TKMLLdrpPFT1IjcVV2Ei9rfUZCjKhhvFc9HhDSDCG5iVI
         xKammtCLQYa9CuKf2o79VHa1RMwnOqp2ObXchy88QZBe8fVHZKc2DS/m6EjbAXqm0/Wy
         ZaZTnMD+rvQcGnPzcrTta4MlBaKUgl4ruCPBAfpYwbfQZ8OWCJPCE2ItoOWB4ZgL9HL3
         /vVo/8naY47YesH5eM50htHbtShQz0BNqczXVVbIEwERUODjk/SVLtckxMFN4VIMac3o
         o67NkZJM4jxLp7RRkp8zT/1b7JBfa4VL1D1BNh5obWkZDb1WDHrf4RRLcFinQlPax+lR
         oAYg==
X-Gm-Message-State: AOJu0YyiiG5L9+iALAKYCnjuE4KfYdUsoHMyL7QquWL5bpckFm4+Cq8k
	6HlSoHuYnQ05fJOswveqKlRDHgWxQJcLl1LOZ9s4GTXvItsD2UencvjnlNOBv+ZTmFvRxues5Le
	w/3qdGa6RfFcg/FyqL3r7YpI6iwEYpN4gob0gAIAWJUL1GM40hcOn1+IEZ/yS
X-Received: by 2002:a05:6a00:cc5:b0:6e1:482b:8c8e with SMTP id b5-20020a056a000cc500b006e1482b8c8emr1989362pfv.17.1709302356376;
        Fri, 01 Mar 2024 06:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuxBK7zBihtdvgKHRlq/iODTmyT4skyvDkmj2PsD0ftCUsDrOJPIG5oa8I6dVTHxivHy0kBw==
X-Received: by 2002:a05:6a00:cc5:b0:6e1:482b:8c8e with SMTP id b5-20020a056a000cc500b006e1482b8c8emr1989332pfv.17.1709302355968;
        Fri, 01 Mar 2024 06:12:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b006e543b59587sm2963979pfu.126.2024.03.01.06.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:12:35 -0800 (PST)
Date: Fri, 1 Mar 2024 22:12:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/310: test qgroup deletion
Message-ID: <20240301141232.komz4o2ir63nptfj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ce4a79cafb6790ef6d1e141d65195f72f469ae4d.1706035378.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4a79cafb6790ef6d1e141d65195f72f469ae4d.1706035378.git.boris@bur.io>

On Tue, Jan 23, 2024 at 10:45:12AM -0800, Boris Burkov wrote:
> When using squotas, an extent's OWNER_REF can long outlive the subvolume
> that is the owner, since it could pick up a different reference that
> keeps it around, but the subvolume can go away.
> 
> Test this case, as originally, it resulted in a read only btrfs.
> 
> Since we can blow up the subvolume in the same transaction as the extent
> is written, we can also increment the usage of a non-existent subvolume.
> 
> This leaves an OWNER_REF behind with no corresponding incremented usage
> in a qgroup, so if we re-create that qgroup, we can then underflow its
> usage.
> 
> Both of these cases are fixed in the kernel by disallowing
> creating subvol qgroups and by disallowing deleting qgroups that still
> have usage.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - removed enable quota helper
> - removed unneeded commented cleanup boilerplate
> - change test number 304 -> 310 (based on v2024.01.14)

You don't need to write the number of a test case in commit subject, due to
it might be changed. If you write a new case, the subject can be "btrfs: ...."
or "fstests/btrfs: ..." or others similar you like.

Thanks,
Zorro

> 
>  tests/btrfs/301     | 14 ++------
>  tests/btrfs/310     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  6 ++++
>  3 files changed, 91 insertions(+), 12 deletions(-)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index db4697247..4c1127aa0 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -157,16 +157,6 @@ do_enospc_falloc()
>  	do_falloc $file $sz
>  }
>  
> -enable_quota()
> -{
> -	local mode=$1
> -
> -	[ $mode == "n" ] && return
> -	arg=$([ $mode == "s" ] && echo "--simple")
> -
> -	$BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
> -}
> -
>  get_subvid()
>  {
>  	_btrfs_get_subvolid $SCRATCH_MNT subv
> @@ -186,7 +176,7 @@ prepare()
>  {
>  	_scratch_mkfs >> $seqres.full
>  	_scratch_mount
> -	enable_quota "s"
> +	$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
>  	$BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
>  	local subvid=$(get_subvid)
>  	set_subvol_limit $subvid $limit
> @@ -397,7 +387,7 @@ enable_mature()
>  	# Sync before enabling squotas to reliably *not* count the writes
>  	# we did before enabling.
>  	sync
> -	enable_quota "s"
> +	$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
>  	set_subvol_limit $subvid $limit
>  	_scratch_cycle_mount
>  	usage=$(get_subvol_usage $subvid)
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 000000000..02714d261
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Test various race conditions between qgroup deletion and squota writes
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup subvol clone
> +
> +# Import common functions.
> +. ./common/reflink
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_scratch_enable_simple_quota
> +_require_no_compress
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: forbid deleting live subvol qgroup"
> +_fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: forbid creating subvol qgroups"
> +
> +subv1=$SCRATCH_MNT/subv1
> +subv2=$SCRATCH_MNT/subv2
> +
> +prepare()
> +{
> +    _scratch_mkfs >> $seqres.full
> +    _scratch_mount
> +    $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG subvolume create $subv1 >> $seqres.full
> +    $BTRFS_UTIL_PROG subvolume create $subv2 >> $seqres.full
> +    $XFS_IO_PROG -fc "pwrite -q 0 128K" $subv1/f
> +    _cp_reflink $subv1/f $subv2/f
> +}
> +
> +# An extent can long outlive its owner. Test this by deleting the owning
> +# subvolume, committing the transaction, then deleting the reflinked copy.
> +# Deleting the copy will attempt to free space from the missing owner, which
> +# should be a no-op.
> +free_from_deleted_owner()
> +{
> +    echo "free from deleted owner"
> +    prepare
> +    subvid1=$(_btrfs_get_subvolid $SCRATCH_MNT subv1)
> +
> +    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG subvolume delete $subv1 >> $seqres.full
> +    $BTRFS_UTIL_PROG qgroup destroy 0/$subvid1 $SCRATCH_MNT >> $seqres.full
> +    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +    rm $subv2/f
> +    _scratch_unmount
> +}
> +
> +# A race where we delete the owner in the same transaction as writing the
> +# extent leads to incrementing the squota usage of the missing qgroup.
> +# This leaves behind an owner ref with an owner id that cannot exist, so
> +# freeing the extent now frees from that qgroup, but there has never
> +# been a corresponding usage to free.
> +add_to_deleted_owner()
> +{
> +    echo "add to deleted owner"
> +    prepare
> +    subvid1=$(_btrfs_get_subvolid $SCRATCH_MNT subv1)
> +
> +    $BTRFS_UTIL_PROG subvolume delete $subv1 >> $seqres.full
> +    $BTRFS_UTIL_PROG qgroup destroy 0/$subvid1 $SCRATCH_MNT >> $seqres.full
> +    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG qgroup create 0/$subvid1 $SCRATCH_MNT >> $seqres.full
> +    rm $subv2/f
> +    _scratch_unmount
> +}
> +
> +free_from_deleted_owner
> +add_to_deleted_owner
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 000000000..d7d4bc0ae
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,6 @@
> +QA output created by 310
> +free from deleted owner
> +ERROR: unable to destroy quota group: Device or resource busy
> +add to deleted owner
> +ERROR: unable to destroy quota group: Device or resource busy
> +ERROR: unable to create quota group: Invalid argument
> -- 
> 2.43.0
> 
> 


