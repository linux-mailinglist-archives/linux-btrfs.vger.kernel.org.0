Return-Path: <linux-btrfs+bounces-4514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF78B079C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E25BB21001
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510515959F;
	Wed, 24 Apr 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSlW2hCg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A021428F9
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955522; cv=none; b=PpwW/TtCRosCQ4sJKdgKwHHEyNuNF2+9ZMLE/TTm4Kv1MTMw0+7Xg4JPacmJypuS01wtUPNwB4BGhnUmS7hGF7zusyfdFgHCRFID40uOJqQUMd7w7tatuCBA6wLIfaoWAB5yHfUgnucHNItpAEyYXixjM5mNivm63tEliVpWltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955522; c=relaxed/simple;
	bh=oYdr+4ECfPljc9nZHDgEev1XJp4TZPmPq1RsiCQieqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9L4KaMUGs8sz8guF4pL/20bpVajh9cnVGLpozLmkr2pV2hBXO5g+iUi8CvJdwQ6EQICL19SO27KRdPvkA3Uh13cLtBjhtZw/RFF9wL2ptqomIuWfEFnujuZovHCr4hvPNZFNcrXKuGzwMeEAt7rKZXP3MUVNcO5XAc3mrc6cOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSlW2hCg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713955518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhLKBDyUWL12GpGYJ1jx0HSvWWh5C5Y3SvvgqgF+lpc=;
	b=YSlW2hCgGm04dm0pQu+LWT7wGRc1W9I2NSmicq8WN1EjJPqDnKKYuDSoD20v34dFldQgKI
	SMjwJuzyQmNznKXeblxg3sl57hHv6WPwfUqHhKi10VAW2+5CGbz+VFGUgC5v5Ptq8yxz5Z
	3j09lSAVzQ7UfJ9omEYEf12xtJGFB0s=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-TuZwNi3fNPKnPA-9z91dRA-1; Wed, 24 Apr 2024 06:45:16 -0400
X-MC-Unique: TuZwNi3fNPKnPA-9z91dRA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-22e9d830d8dso6103510fac.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 03:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955516; x=1714560316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhLKBDyUWL12GpGYJ1jx0HSvWWh5C5Y3SvvgqgF+lpc=;
        b=uhtf3NvHASk2KiCqDf344Iu1xpODKhiVVp4IKh/dkXeBc08ubh7xkZ2l/Bt8L0Eloi
         QHGNrWsya1uBPtROA3q1fQMeibhBIO/yCeRxjEw2t5gpnKJOoA2v5tYFNex17Bvf7Gk/
         gmqUGetWUIIn8T+/nMIrswyJ/vetSOC0jIOBzOiJFkSOSOp71qBVPyoS9ab10E44A51d
         NXUVIyuyRVhcSbrqb1TTdoyO6Ul2EqdgyiN6v3aN+AkqsenzMOKvD4Oj1V4VLxN+qWnB
         yK7rCyPXlDI5DVFjbSzpLFl/xAYth0p8OmxNgUjy0y+yiNoerU8MdPtG9RP3l9Ccerk7
         iYag==
X-Forwarded-Encrypted: i=1; AJvYcCU8Zcd14bMcmBSnVS+/34090tg1B7EpacFCSTDk7hP+NREoUJLrjHVSycZWfp251PKXVh5soi63sM8jKp5LK7+uOWaxvKsasutDZz0=
X-Gm-Message-State: AOJu0Yy6uLUalBLIxV3ZdbmC6TJDd/usGQfgmyr6234M2G1zBdgdrWc9
	r7+XSMaPbJ85Zv0IrZJAN09olTc/FUKrbo8TvNUBzthMPi/ZCd1GPdD0S8q1RcUJG7NX5lnbXGa
	e34o8hbMNOMl/PwiuyJEbqUDe39IJKiCccGVTlqSuec7Hw3RjzYFLpvmzOhcC
X-Received: by 2002:a05:6870:b629:b0:22b:a8f3:36b7 with SMTP id cm41-20020a056870b62900b0022ba8f336b7mr2066599oab.55.1713955515975;
        Wed, 24 Apr 2024 03:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOgye3ggXXpsi1HlvXAJ6YrfSfe6rqzYNGfAQcUGgQdgPn48hZzxDjU8Xi4nnBZ0T36aOSZA==
X-Received: by 2002:a05:6870:b629:b0:22b:a8f3:36b7 with SMTP id cm41-20020a056870b62900b0022ba8f336b7mr2066582oab.55.1713955515268;
        Wed, 24 Apr 2024 03:45:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b006ed0199bd57sm11931942pfg.177.2024.04.24.03.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:45:14 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:45:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/1] generic: move btrfs clone device testcase to the
 generic group
Message-ID: <20240424104510.oopqvmtqlyc3e442@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <670fe32950d328b6a6dd071a53d8a25e50ce6647.1712673602.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670fe32950d328b6a6dd071a53d8a25e50ce6647.1712673602.git.anand.jain@oracle.com>

On Tue, Apr 09, 2024 at 10:43:42PM +0800, Anand Jain wrote:
> Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> test case btrfs/312, which assesses the functionality of cloned filesystem
> support, can be refactored to be under the generic group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3:
> Move back to generic
> 
> v2:
> Move to shared testcase instead of generic.
> commit log updated,
> add _require_block_device $TEST_DEV.
> add _require_duplicated_fsid
> 
> https://lore.kernel.org/all/440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com/T/#m576217a155aee49af607aa1f2aaa102ac92835e9
> 
> v1:
> https://lore.kernel.org/linux-btrfs/dd10c332377f315cd17abc46e08f296b87aed31c.1709970025.git.anand.jain@oracle.com/
> 
>  common/rc             | 14 +++++++
>  tests/btrfs/312       | 78 --------------------------------------
>  tests/btrfs/312.out   | 19 ----------
>  tests/generic/744     | 87 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/744.out |  4 ++
>  5 files changed, 105 insertions(+), 97 deletions(-)
>  delete mode 100755 tests/btrfs/312
>  delete mode 100644 tests/btrfs/312.out
>  create mode 100755 tests/generic/744
>  create mode 100644 tests/generic/744.out
> 
> diff --git a/common/rc b/common/rc
> index 3ef70dfdddaa..6b9d218e3b1c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5495,6 +5495,20 @@ _random_file() {
>  	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
>  }
>  
> +_require_duplicate_fsid()
> +{
> +	case "$FSTYP" in
> +	"btrfs")
> +		_require_btrfs_fs_feature temp_fsid
> +		;;
> +	"ext4")
> +		;;
> +	*)
> +		_notrun "$FSTYP cannot support mounting with duplicate fsid"

We didn't do a visible "mount" at here, how about say:
  "$FSTYP does not support duplicate fsid" ?

> +		;;
> +	esac
> +}

OK, with this helper, we can move it into generic/. I'm not familar with
other filesystems, if any of other filesystems supports this feature, please
remind me.

> +
>  init_rc
>  

[snip]

> diff --git a/tests/generic/744 b/tests/generic/744
> new file mode 100755
> index 000000000000..5c7edf6499c1
> --- /dev/null
> +++ b/tests/generic/744
> @@ -0,0 +1,87 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 744
> +#
> +# Set up a filesystem, create a clone, mount both, and verify if the cp reflink
> +# operation between these two mounts fails.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone volume tempfsid

I think it's not "quick" enough, right? It still need to take ~60s.

> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +
> +	$UMOUNT_PROG $mnt2 &> /dev/null
> +	rm -r -f $mnt2
> +	_destroy_loop_device $loop_dev2 &> /dev/null
> +	rm -r -f $loop_file2
> +
> +	$UMOUNT_PROG $mnt1 &> /dev/null
> +	rm -r -f $mnt1
> +	_destroy_loop_device $loop_dev1 &> /dev/null

The _destroy_loop_device will exit directly if it fails, so the "&> /dev/null"
isn't helpful. If the test _notrun by a _require_xxx helper, I doubt the
_destroy_loop_device might cause _fail. So how about use `losetup -d` directly?

$UMOUNT_PROG $mnt2 &> /dev/null
$UMOUNT_PROG $mnt1 &> /dev/null
[ -b "$loop_dev2" ] && losetup -d $loop_dev2
[ -b "$loop_dev1" ] && losetup -d $loop_dev1
[ -n "$seq" ] && rm -rf $TEST_DIR/$seq

> +	rm -r -f $loop_file1
> +}
> +
> +. ./common/filter
> +. ./common/reflink
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_duplicate_fsid
> +_require_cp_reflink
> +_require_test
> +_require_block_device $TEST_DEV
> +_require_loop
> +
> +clone_filesystem()
> +{
> +	local dev1=$1
> +	local dev2=$2
> +
> +	_mkfs_dev $dev1
> +
> +	_mount $dev1 $mnt1
> +	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
> +	$UMOUNT_PROG $mnt1
> +
> +	# device dump of $dev1 to $dev2
> +	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
> +}
> +
> +mnt1=$TEST_DIR/$seq/mnt1
> +rm -r -f $mnt1
> +mkdir -p $mnt1
> +
> +mnt2=$TEST_DIR/$seq/mnt2
> +rm -r -f $mnt2
> +mkdir -p $mnt2

You might want to remove the "$TEST_DIR/$seq" directly, e.g.

mnt1=$TEST_DIR/$seq/mnt1
mnt2=$TEST_DIR/$seq/mnt2
rm -rf $TEST_DIR/$seq
mkdir -p $mnt1 $mnt2


> +
> +loop_file1="$TEST_DIR/$seq/image1"
> +rm -r -f $loop_file1
> +truncate -s 300m "$loop_file1"
> +loop_dev1=$(_create_loop_device "$loop_file1")
> +
> +loop_file2="$TEST_DIR/$seq/image2"
> +rm -r -f $loop_file2
> +truncate -s 300m "$loop_file2"
> +loop_dev2=$(_create_loop_device "$loop_file2")
> +
> +clone_filesystem ${loop_dev1} ${loop_dev2}
> +
> +# Mounting original device
> +_mount $loop_dev1 $mnt1
> +$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
> +
> +# Mounting cloned device
> +_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
> +
> +# cp reflink across two different filesystems must fail
> +_cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir

Don't we need to make sure the $FSTYP supports reflink feature? The
_require_cp_reflink only checks if the "cp" command has "reflink" option.

There's not a helper to check if $mnt1 and $mnt2 support reflink directly, but
I think we can use "_require_test_reflink".

Thanks,
Zorro


> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/744.out b/tests/generic/744.out
> new file mode 100644
> index 000000000000..1850a0ea2a5e
> --- /dev/null
> +++ b/tests/generic/744.out
> @@ -0,0 +1,4 @@
> +QA output created by 744
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +cp: failed to clone 'TEST_DIR/744/mnt2/bar' from 'TEST_DIR/744/mnt1/foo': Invalid cross-device link
> -- 
> 2.39.3
> 
> 


