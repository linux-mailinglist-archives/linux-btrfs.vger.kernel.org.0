Return-Path: <linux-btrfs+bounces-8304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A53988762
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D0E1C21A81
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6318BC1F;
	Fri, 27 Sep 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d226BJo9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB22A2D
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448258; cv=none; b=HXwDr580ulPPGjL0qAo2CeRdJ/rUeY8VaR+5uQYz3Fi4t0bKeh9zs6wLg8YytNmlRsaX4oF3tD0ajuoB+aimpoPzUPPFJC12NMlddMB+Y7td/Xj9xSAk0l1oA9DM86Vkn8MToDz1Vt4BGuZ8Pye/f3JHVrk3csec7VazYao/N+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448258; c=relaxed/simple;
	bh=9si+wJeBufkQd6NuE2kAH6PNragpFohsDv02zF0xhT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpQXHdSlMGe90stCGTVDK4COvR7ZHpZwbCYIS6JxIBhub/QOrus1afB1SrNUi4satQlz6qr8shEr4fFiCTx50S5vHza4HCNTfi+R4eZHIXChSY4d92OLkpfPFDH7tGSzLKwflHkyMmEz8AHFXg5lU6sQ+r1JSy0FuZAUSKIzESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d226BJo9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727448255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6ocO26iz8YWhK+QW95/72TL51n5ila4bkWKco8azfA=;
	b=d226BJo9vosquj0mSK6WdfTgenJYWD4Zwm3xAZhbVWLb8gsoRWkxJCXCFkGHEKqjm8s8iW
	yElJOLnIwe8/F28PvO0gTZuFRA2sY9Tslot/y2LRDRRmYOWGn/961JffcrYkpe8VekV2fs
	bmB8skxUGi77ctRlhnN/pIyInMJlaiU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-QjufU4bXPBGPRKymWpU1xA-1; Fri, 27 Sep 2024 10:44:14 -0400
X-MC-Unique: QjufU4bXPBGPRKymWpU1xA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso1932142a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727448253; x=1728053053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6ocO26iz8YWhK+QW95/72TL51n5ila4bkWKco8azfA=;
        b=NBGnNuRfGlb8RbFSfWqQytfQrNf1OgJNkp3YaR8b2hBChD0RruZgdxzaGZ4ztzzIzn
         CVSN+BV6OKsnk4wSSnS0/h/JGWnhD85LW0pIFZKJLbEyXWh2Ink4oRfxgJYv/jW9ICXg
         +5k1qc2v+YAgeZYyf5ogH3TtPP17LbuFS3V9iw0RSLky7LwI/5E41rTOsO2nvgYH+4mn
         rC39OnKWzf6rZ7m9F3GHe/kQoAVBuE8A8mqzPyJ3ayqz+Kvps5AAbn21MCsD8uixxRcx
         SHNgT3ugYy6bIQxBGkN/puqZgwXZ2vu+G+KoxY9ajmCha7toJFtD6Xty3rHw4qkb4L+A
         A+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Q0C1Wy3yHh4dOlyZ7UMUXn+9EjbEWvMHiNL9yoFlRGYw6lGAJgXBXOK9RsUiQdHsp3LyVLYdxYexuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk37K31aoFiYexPdCLXtW19gnHBliXFyxWa9sFdpBj7RHN+Ylx
	7BHmn6GohwOA3LNBwtk1MPEyAI7LTkzyXYwEFULFwpPFRWb9SthJG0YbLkp2nUikerWB9bWlZXe
	xVXxP5dbYgzlSiqKNxO8fdXRcdOPqvaYHniCzRwtIrVt3gjnC5Fvja8fFt3Va
X-Received: by 2002:a05:6a20:439f:b0:1d2:eaca:4fb0 with SMTP id adf61e73a8af0-1d4fa2021camr6083232637.6.1727448252645;
        Fri, 27 Sep 2024 07:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2zFw3HZsfYcTI2+aHRjrwaTr/BxzdDKsOz5B9Kx3C8tGt73joF74dbCerEGbCpl9d/d/ZBA==
X-Received: by 2002:a05:6a20:439f:b0:1d2:eaca:4fb0 with SMTP id adf61e73a8af0-1d4fa2021camr6083194637.6.1727448252236;
        Fri, 27 Sep 2024 07:44:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c8704sm1729252a12.52.2024.09.27.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:44:11 -0700 (PDT)
Date: Fri, 27 Sep 2024 22:44:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test an incremental send scenario with cloning of
 unaligned extent
Message-ID: <20240927144408.3ewoi6qbi4qxv5mz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>

On Fri, Sep 27, 2024 at 11:28:07AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that doing an incremental send with a file that had its size
> decreased and became the destination for a clone operation of an extent
> with an unaligned end offset that matches the new file size, works
> correctly.
> 
> This tests a bug fixed by the following kernel patch:
> 
>   "btrfs: send: fix invalid clone operation for file that got its size decreased"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/322     | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/322.out |  24 ++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100755 tests/btrfs/322
>  create mode 100644 tests/btrfs/322.out
> 
> diff --git a/tests/btrfs/322 b/tests/btrfs/322
> new file mode 100755
> index 00000000..c03f6a4c
> --- /dev/null
> +++ b/tests/btrfs/322
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 322
> +#
> +# Test that doing an incremental send with a file that had its size decreased
> +# and became the destination for a clone operation of an extent with an
> +# unaligned end offset that matches the new file size, works correctly.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send clone fiemap
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -fr $send_files_dir
> +}
> +
> +. ./common/filter
> +. ./common/reflink
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_require_test
> +_require_scratch_reflink
> +_require_xfs_io_command "fiemap"
> +_require_odirect
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: send: fix invalid clone operation for file that got its size decreased"
> +
> +check_all_extents_shared()
> +{
> +	local file=$1
> +	local fiemap_output
> +
> +	fiemap_output=$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_fiemap_flags)
> +	echo "$fiemap_output" | grep -qv 'shared'
> +	if [ $? -eq 0 ]; then
> +		echo -e "Found non-shared extents for file $file:\n"
> +		echo "$fiemap_output"
> +	fi
> +}
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +full_send_stream=$send_files_dir/full_snap.stream
> +inc_send_stream=$send_files_dir/inc_snap.stream
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> +_scratch_mount
> +
> +# Create a file with a size of 256K + 5 bytes, having two extents, the first one
> +# with a size of 128K and the second one with a size of 128K + 5 bytes.
> +last_extent_size=$((128 * 1024 + 5))
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
> +             -c "pwrite -S 0xcd -b $last_extent_size 128K $last_extent_size" \
> +             $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Another file which we will later clone foo into, but initially with
> +# a larger size than foo.
> +$XFS_IO_PROG -f -c "pwrite -b 0xef 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
> +
> +echo "Creating snapshot and the full send stream for it..."
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> +$BTRFS_UTIL_PROG send -f $full_send_stream $SCRATCH_MNT/snap1 >> $seqres.full 2>&1
> +
> +# Now resize bar and clone foo into it.
> +$XFS_IO_PROG -c "truncate 0" \
> +	     -c "reflink $SCRATCH_MNT/foo" $SCRATCH_MNT/bar | _filter_xfs_io

_require_xfs_io_command "reflink"

I'll help to add it when I merge it. Other looks good to me. Thanks!

> +
> +echo "Creating another snapshot and the incremental send stream for it..."
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $inc_send_stream \
> +		 $SCRATCH_MNT/snap2 >> $seqres.full 2>&1
> +
> +echo "File digests in the original filesystem:"
> +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> +
> +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> +
> +echo "Creating a new filesystem to receive the send streams..."
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG receive -f $full_send_stream $SCRATCH_MNT
> +$BTRFS_UTIL_PROG receive -f $inc_send_stream $SCRATCH_MNT
> +
> +echo "File digests in the new filesystem:"
> +md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
> +md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
> +
> +check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
> +check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/322.out b/tests/btrfs/322.out
> new file mode 100644
> index 00000000..31e1ee55
> --- /dev/null
> +++ b/tests/btrfs/322.out
> @@ -0,0 +1,24 @@
> +QA output created by 322
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131077/131077 bytes at offset 131072
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Creating snapshot and the full send stream for it...
> +linked 0/0 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Creating another snapshot and the incremental send stream for it...
> +File digests in the original filesystem:
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
> +Creating a new filesystem to receive the send streams...
> +At subvol snap1
> +At snapshot snap2
> +File digests in the new filesystem:
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
> +ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
> +c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
> -- 
> 2.43.0
> 
> 


