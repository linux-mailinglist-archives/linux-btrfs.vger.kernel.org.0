Return-Path: <linux-btrfs+bounces-2968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38286E2FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE6B22B7C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C46EEFB;
	Fri,  1 Mar 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgdaEvcj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AA6F514
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302097; cv=none; b=ljh2tgD8nANWgi0ZrwMkKiAB2ngRGd3K4e8eiiJ+/hrwiuEbux7E+TTLwXD0J6sBBpir2D+xfDL/go2kHEuajtN04RPzrfuYHnjtQdT2SOhUqFJNH12OrgdAP7UjmS7ube3AHBvj4O67qYvKvN7U32iiVtch5szbr9v59zIrccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302097; c=relaxed/simple;
	bh=QRtrVHbGg6UBQF5jFjC+e9A1xTeKiSYlPPerRwyxsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP2CBEneG36lpT0SM20Q/r7HzNdNd7UA8IghRMVBXXsL8wH+lHGEXpKI9DUOU14r9z0u5nGd9bqPVvpXVG6ZusHQvkx2B7jdfBbqfwJNCNDc+zp3AcReGRWL+wz4MSncDaspF9Ijj0B9dRPyy0lOyS2IaOmT0d7dilT5TDaaKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgdaEvcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709302094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCEh9C5EA4GsZD/OC1r5YlOqs5g+H8xXFiHuMW4Cy74=;
	b=AgdaEvcjLxjDsNsw0gx2DqyVxRLgYFnsc+81tZJpPjARHKWutLT1veDuLNcxAV0UGqoxg3
	WU1OoycwFL2lromE1fSNTyDCqAzzQc8hrinOVTRSUARqIG+aUFrxycaPLJqp5EKcO4DuVH
	OMt+N82gKG632fddn/6dlW7AaIq6d1w=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-UJF2nV3nPIeUnsQnlbxmZA-1; Fri, 01 Mar 2024 09:08:13 -0500
X-MC-Unique: UJF2nV3nPIeUnsQnlbxmZA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e5ce471890so255807b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Mar 2024 06:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302092; x=1709906892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCEh9C5EA4GsZD/OC1r5YlOqs5g+H8xXFiHuMW4Cy74=;
        b=vIamq2HJdpRa1CJB/TN4qpoyLxINyjkzykYE+xA6i/VoiF8qeqBCjkhET2HBo9r87i
         PaxMEtg0CVGwx7LDZ7vMu04MUZWWM1inpW7AjP7u520hR0ZVqIQIbYDNBW3gBJXvtbth
         7nokU3zzaC9+k7Uh9QHIsTfgIy2B907JzkjV1UBFzFxC35WwfgcmOHSpdvwmy/wIFl1r
         MHr/JWqTZJOzAV00RH27sTOR34jmBGbd9fbM9s0dgUb12fXlpmoddtSF9H5Jiw+7t04h
         5cV3DEoTZWI1eO4g9f5JvJ+k1Ta6U6ZwTIqIpMb7JPWCD1QYD7AQOlljKVg0UzXN05rX
         U2Fw==
X-Gm-Message-State: AOJu0YygNB1UuCsiddBzf/X895foMNgZMzqv79udlkrx5BBUpv4ZkJ3v
	VdpR0T5LaP7z7b6u636CYHDB90R2+YGPmhGaOHeaIHYPSHpZ+EKbmnUJ8A7szZJr0S7KFQLBERg
	v28xRJfcohJjK5HZjl8itie5qxdrE8dX9y4JiutfI0Yy5p5LbYhAb5gNWMMAF
X-Received: by 2002:a05:6a00:1707:b0:6e2:d162:6315 with SMTP id h7-20020a056a00170700b006e2d1626315mr1876137pfc.29.1709302091628;
        Fri, 01 Mar 2024 06:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4z3UoeV8S6LT9aGh3Xva9wXhKEudLeCku7yeWFpEZLdB70HoWuhrCEBidtC1j8OJMgYdRfg==
X-Received: by 2002:a05:6a00:1707:b0:6e2:d162:6315 with SMTP id h7-20020a056a00170700b006e2d1626315mr1876103pfc.29.1709302091107;
        Fri, 01 Mar 2024 06:08:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b006e560192a7dsm2983892pfh.105.2024.03.01.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:08:10 -0800 (PST)
Date: Fri, 1 Mar 2024 22:08:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] fstests: make read-repair tests md5sum the data
Message-ID: <20240301140807.a74ipz344klfk2y5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c5d3e27fd544b2ecb1a4b374f500314c1b7b9c56.1706112305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d3e27fd544b2ecb1a4b374f500314c1b7b9c56.1706112305.git.josef@toxicpanda.com>

On Wed, Jan 24, 2024 at 11:05:10AM -0500, Josef Bacik wrote:
> For validating that read repair works properly we corrupt one mirror and
> then read back the physical location after we do a direct or buffered
> read on the mounted file system and then unmount the file system.  The
> golden output expects all a's, however with encryption this will
> obviously not be the case.
> 
> However I still broke read repair, so these tests are quite valuable.
> Fix them to dump the on disk values to a temporary file and then md5sum
> the files, and then validate the md5sum to make sure the read repair
> worked properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/140     | 15 ++++++++++++++-
>  tests/btrfs/140.out | 34 ----------------------------------
>  tests/btrfs/141     | 16 +++++++++++++++-
>  tests/btrfs/141.out | 34 ----------------------------------
>  4 files changed, 29 insertions(+), 70 deletions(-)
> 
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 247a7356..8e1aafa3 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -77,6 +77,13 @@ devpath=$(get_device_path ${devid})
>  
>  _scratch_unmount
>  
> +# Grab the contents of the the area so we can compare to the final part
> +orig=$(mktemp)

We don't use mktemp for tmpfile. Please use $tmp (it's defined at the
beginning of each test case), then it'll be sure to be removed in _cleanup().

> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
> +	 _filter_xfs_io_offset > $orig
> +origcsum=$(_md5_checksum $orig)
> +rm -f $orig
> +
>  echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
>  	>> $seqres.full
>  $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
> @@ -91,10 +98,16 @@ _btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>  _scratch_unmount
>  
>  # check if the repair works
> +final=$(mktemp)
>  $XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
> -	_filter_xfs_io_offset
> +	_filter_xfs_io_offset > $final
> +finalcsum=$(_md5_checksum $final)
> +rm -f $final
>  
>  _scratch_dev_pool_put
> +
> +[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"

Might be worth outputting the $orig and $final into .full file, at least
when the test fails, to help debug.

Same review points below.

If there's not objection from the the original author of these two cases
and btrfs list, I'm good with this change if it helps for more testing.

Thanks,
Zorro

> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
> index fb5aa108..58dfb24e 100644
> --- a/tests/btrfs/140.out
> +++ b/tests/btrfs/140.out
> @@ -1,37 +1,3 @@
>  QA output created by 140
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index 90a90d00..41407f90 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -74,6 +74,14 @@ devid=$(get_devid ${logical_in_btrfs} 1)
>  devpath=$(get_device_path ${devid})
>  
>  _scratch_unmount
> +
> +# Grab the contents of the area so we can compare to the final part
> +orig=$(mktemp)
> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
> +	_filter_xfs_io_offset > $orig
> +origcsum=$(_md5_checksum $orig)
> +rm -f $orig
> +
>  echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
>  	>> $seqres.full
>  $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
> @@ -88,10 +96,16 @@ _btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>  _scratch_unmount
>  
>  # check if the repair works
> +final=$(mktemp)
>  $XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
> -	_filter_xfs_io_offset
> +	_filter_xfs_io_offset > $final
> +finalcsum=$(_md5_checksum $final)
> +rm -f $final
>  
>  _scratch_dev_pool_put
> +
> +[ "$origcsum" == "$finalcsum" ] || _fail "repair failed, csums don't match"
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
> index 4b8be189..d8c6940f 100644
> --- a/tests/btrfs/141.out
> +++ b/tests/btrfs/141.out
> @@ -1,37 +1,3 @@
>  QA output created by 141
>  wrote 131072/131072 bytes
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.43.0
> 
> 


