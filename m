Return-Path: <linux-btrfs+bounces-3218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954B878DE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 05:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA46B215E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD910A0F;
	Tue, 12 Mar 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFeLIBfE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A3C2E3
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710218800; cv=none; b=gSkAEB8ST1gCu4vsjqxv69SERffT14EVU1FEr9hHGxoQaSOEw0XfQ20DywbVr7i6mZw08sxXztvO2ddrCBJS7/HXGyX2kxbaF+TVbhXJHtCfcXZxqfQRX0o9tl9kqGWlqxLFdPN1tg/7AEmB3/8784XpfUYP3tYythE0APJYFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710218800; c=relaxed/simple;
	bh=E0IxU6cPKZ1uGm+e14NzajxYBPSAavvLLpaGt7S9XkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAmxHmntImWQ5AwIlK5i19tIUeGjDjtdsF/fXm8HHOVjpnEZ1g9MMbvwxWKGhUomPPUXA4Dd1DKVn0CKSBToOq5HEdItbmEswlPqkrTIhy7FHeidW1j2ZKO+yoG9olqp1p05o4YYd5rWtsVJX139ajHmO8A88GG5mL6io+xHBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFeLIBfE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710218797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALYFTE9ArCgJgqRMgeioAqT/gpnbXNMYRRbn5EpRPFE=;
	b=jFeLIBfEcAhMYexWn4Y+1fbHwpO0xvRHOUi2wJIzBmwD47Q/QPf1JIPgVy7dg1VlFLef1i
	4o83yjNEi6yghOtVbQbcT55fVAKN9o9AYKeY99CFLXzO/ZJWSzMtg04kqnYim/fdL+/RvP
	iHmVDCe3y4QbL0sqzKlqndvUWC3IaCk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-VK5jdCHfP9O6A7y4ZiLPiw-1; Tue, 12 Mar 2024 00:46:35 -0400
X-MC-Unique: VK5jdCHfP9O6A7y4ZiLPiw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e6a1625e4bso488154b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 21:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710218794; x=1710823594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALYFTE9ArCgJgqRMgeioAqT/gpnbXNMYRRbn5EpRPFE=;
        b=YsDYWrQr68pHGd495LbhzbV6JRmOnrkRaH1JtiocHcA85tOiynA2LNrCOL0aR0wyO4
         /Vnw5PnoUx8yeh9R79J9BxaQzgGdwOf/FnOk5lGbQ0DXtfSh8OGac7Pc41sJ+Ue+cNd2
         pI/S+xh6wVLLxbLuqa1m1lAoRWrpHkjlNouZ7gy+xGCVapiACs6OhxVBC9r2brzZuuu9
         42z08MdTRi6jtnK1gC/6UTTOhWu2lm7G7dS+SKEreqHvoDce01rq0258d60WwB+XBp78
         gfb7Q59pqVSzBZ1MSMfJUsZBwGTD2uUvzKasRSqJtfnnIiQFamjRSeTF9vIicem/pcNO
         B/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVuYtZS005W+NUv08Yz78bu+bhPdk6G64WFt6olvDZ4lAiqwukFPnw5kVdjzZObP0wIfe+aKg5Orb4aR+iAuMwPpDPrZ4RKUGJ8oXA=
X-Gm-Message-State: AOJu0YzonRSXdqyG7h4YLEg1YptF8uDYCXkmU/sRqhqqPa4JHo1NKa8T
	vzA5N8hdcNKyv9RLA6PrMOqfvQT0T8d6sNgzal/DaO/c+Pmq283IDTOo/aSuBo8s9MW8Tu5nytT
	C+dbicx/+d2G4GP1ps7oICxK0jiWQLZaNXj7B6KrkeCj7nqgdCAQuEU1zHnG4
X-Received: by 2002:a05:6a00:180f:b0:6e6:6dd6:7618 with SMTP id y15-20020a056a00180f00b006e66dd67618mr9429433pfa.2.1710218794251;
        Mon, 11 Mar 2024 21:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED5OVvEIuaIeX0DEr/T1I67UQYhiZbSI6ZjHfG1JcesnIziorUwQ3s56BzzY4qM1WJTeIC0w==
X-Received: by 2002:a05:6a00:180f:b0:6e6:6dd6:7618 with SMTP id y15-20020a056a00180f00b006e66dd67618mr9429416pfa.2.1710218793717;
        Mon, 11 Mar 2024 21:46:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s67-20020a625e46000000b006e59a311e2dsm5539559pfb.92.2024.03.11.21.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 21:46:33 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:46:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: move btrfs clone device testcase to the
 generic group
Message-ID: <20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709970025.git.anand.jain@oracle.com>
 <dd10c332377f315cd17abc46e08f296b87aed31c.1709970025.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd10c332377f315cd17abc46e08f296b87aed31c.1709970025.git.anand.jain@oracle.com>

On Sat, Mar 09, 2024 at 03:40:34PM +0530, Anand Jain wrote:
> Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> test case btrfs/312, which assesses the functionality of cloned filesystem
> support, can be refactored to be under the generic group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/312       | 78 --------------------------------------
>  tests/btrfs/312.out   | 19 ----------
>  tests/generic/740     | 88 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/740.out |  4 ++
>  4 files changed, 92 insertions(+), 97 deletions(-)
>  delete mode 100755 tests/btrfs/312
>  delete mode 100644 tests/btrfs/312.out
>  create mode 100755 tests/generic/740
>  create mode 100644 tests/generic/740.out
> 
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> deleted file mode 100755
> index eedcf11a2308..000000000000
> --- a/tests/btrfs/312
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2024 Oracle.  All Rights Reserved.
> -#
> -# FS QA Test 312
> -#
> -# On a clone a device check to see if tempfsid is activated.
> -#
> -. ./common/preamble
> -_begin_fstest auto quick clone tempfsid
> -
> -_cleanup()
> -{
> -	cd /
> -	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
> -	rm -r -f $tmp.*
> -	rm -r -f $mnt1
> -}
> -
> -. ./common/filter.btrfs
> -. ./common/reflink
> -
> -_supported_fs btrfs
> -_require_scratch_dev_pool 2
> -_scratch_dev_pool_get 2
> -_require_btrfs_fs_feature temp_fsid
> -
> -mnt1=$TEST_DIR/$seq/mnt1
> -mkdir -p $mnt1
> -
> -create_cloned_devices()
> -{
> -	local dev1=$1
> -	local dev2=$2
> -
> -	echo -n Creating cloned device...
> -	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
> -
> -	_mount $dev1 $SCRATCH_MNT
> -
> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> -								_filter_xfs_io
> -	$UMOUNT_PROG $SCRATCH_MNT
> -	# device dump of $dev1 to $dev2
> -	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
> -							_fail "dd failed: $?"
> -	echo done
> -}
> -
> -mount_cloned_device()
> -{
> -	echo ---- $FUNCNAME ----
> -	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
> -
> -	echo Mounting original device
> -	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> -								_filter_xfs_io
> -	check_fsid ${SCRATCH_DEV_NAME[0]}
> -
> -	echo Mounting cloned device
> -	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
> -				_fail "mount failed, tempfsid didn't work"
> -
> -	echo cp reflink must fail
> -	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
> -						_filter_testdir_and_scratch
> -
> -	check_fsid ${SCRATCH_DEV_NAME[1]}
> -}
> -
> -mount_cloned_device
> -
> -_scratch_dev_pool_put
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
> deleted file mode 100644
> index b7de6ce3cc6e..000000000000
> --- a/tests/btrfs/312.out
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -QA output created by 312
> ----- mount_cloned_device ----
> -Creating cloned device...wrote 9000/9000 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -done
> -Mounting original device
> -wrote 9000/9000 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -On disk fsid:		FSID
> -Metadata uuid:		FSID
> -Temp fsid:		FSID
> -Tempfsid status:	0
> -Mounting cloned device
> -cp reflink must fail
> -cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
> -On disk fsid:		FSID
> -Metadata uuid:		FSID
> -Temp fsid:		TEMPFSID
> -Tempfsid status:	1
> diff --git a/tests/generic/740 b/tests/generic/740
> new file mode 100755
> index 000000000000..2b2bff96b8ec
> --- /dev/null
> +++ b/tests/generic/740
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 740
> +#
> +# Set up a filesystem, create a clone, mount both, and verify if the cp reflink
> +# operation between these two mounts fails.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone volume tempfsid
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
> +	rm -r -f $loop_file1
> +
> +}
> +
> +. ./common/filter
> +. ./common/reflink
> +
> +# Modify as appropriate.
> +_supported_fs btrfs ext4

If it only supports btrfs and ext4, then it's a "shared" case. Generally
we use "_require_xxxx" to _notrun on fs which isn't supported, except
a fs totally not be supported, we use "^$that_fs_name".

As this test need loop device, so you might need the FSTYP is a local
filesystem, so:
  _require_block_device $TEST_DEV

And...

> +_require_cp_reflink
> +_require_test
> +_require_loop
> +
> +[[ $FSTYP == "btrfs" ]] && _require_btrfs_fs_feature temp_fsid

I'm wondering if we can have a common function likes _require_duplicated_fsid ?
Then this function helps to avoid running this test on those fs which doesn't
support (e.g. xfs can't mount duplicate UUID now?)

e.g.

_require_duplicate_fsid()
{
	case $FSTYP:
	btrfs)
		_require_btrfs_fs_feature temp_fsid
		;;
	ext4)
		# not sure, does it always supports that?
		;;
	*)
		_notrun "$FSTYP can't be mounted with duplicate fsid"
		# not sure if need a real testing at here, likes mkfs
		# on an image file, copy it, then try to mount them?
		;;
	esac
}

Any thoughts about this?

Thanks,
Zorro

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
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/740.out b/tests/generic/740.out
> new file mode 100644
> index 000000000000..6ca8bb7e1b21
> --- /dev/null
> +++ b/tests/generic/740.out
> @@ -0,0 +1,4 @@
> +QA output created by 740
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +cp: failed to clone 'TEST_DIR/740/mnt2/bar' from 'TEST_DIR/740/mnt1/foo': Invalid cross-device link
> -- 
> 2.39.3
> 
> 


