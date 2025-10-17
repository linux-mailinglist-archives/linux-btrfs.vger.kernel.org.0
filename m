Return-Path: <linux-btrfs+bounces-17974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A6BEB499
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985383BD70C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A683328EB;
	Fri, 17 Oct 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT/6E6nR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE32877C2
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727407; cv=none; b=qTCdVOLbWtFvZapVBSdQg4HytTSbUNHeioWc4fCDgEFY7mR4UhpKH87lJRUmw75USC5DYbD6BzeQ+gV74YnQcI0fq+Qc2Traa5dqu2xsv2VefOObaczV3rUp6oA2oMQjAO7PTGvjagyPBOzC5EtND7qvvgpQJJToR8s8i1nlcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727407; c=relaxed/simple;
	bh=d5EYSvZWE21MAW/5ducNnSAuwHg4mPYcU9kcJd5FPu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW6VPYA0ELKvJIClswFoRQ1JSeW6H4MrePBP8DMnhipgcTYJhtv4gGeRQhl6aaG633LEvT0+eNdyPad7EZfioG5vCLLl//ZADsyy2tTm57J1OJsD4Ze5Z9mFq2HIGLyOfPV+otiglNwHbTP9eXYjDMBBxMby07Vey3KpHqyhiCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT/6E6nR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760727405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYprDHVp8YGKTFNY5McgCFcGhbJLnpr1suYb15I8Fy4=;
	b=iT/6E6nRXi5Eya79ZTH8+GPw5uxTXYtOw2s/mkuGRUMOGnavLh0kmj0k2VZ1I5LNXnHzRC
	wwM8rUTM6fSlvSfgMJ2kdUl5KjaFQUEdXo3lQzkFp/oneCPmZsYycz94feNKbhEcv59URu
	J/E9ZP/EwwoQK0xGOrssBfPspZ3BWb8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-KdS3V-VRO--64nREyUEVWA-1; Fri, 17 Oct 2025 14:56:41 -0400
X-MC-Unique: KdS3V-VRO--64nREyUEVWA-1
X-Mimecast-MFC-AGG-ID: KdS3V-VRO--64nREyUEVWA_1760727401
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909e6471a9so17619585ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 11:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760727401; x=1761332201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYprDHVp8YGKTFNY5McgCFcGhbJLnpr1suYb15I8Fy4=;
        b=qAJOkIx0tvTEzKvnYQS1ZoeYOVqpxycH6QZM7gPtu2N6zWOjDLVRWNuQKtcXwzTX78
         KVXNYdnnP5MYyndd/5EGcXEfWxiZYFI5Cq5I5iDVN/QYEXQgaoJzSkuoVURcYu5+iPTz
         9Ay88AHq48GwRQIToHIQjvgUqxoHwoy7/TcbpPb0r3Up5Kr26l705Pv2qgxEVO4G2d0h
         QsDG8+Uabe2kort2yRql1rNZ2oi0oZMi7wpsiWwqlzfQK+m7siu56RWUShVgqE8XqcQN
         Xp7mHHalb7WFPKF1RU6762yCjfo32lF84m7mxI+MyGNMSNEBykCWmiVTmuqE8HlROQOi
         kWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV75vHMq+xwQ1HLPFka+/KGfTxGlNjz0CDyHwz4syC2iOa/J/dN1ROxD9ruZxvYOu3XaWncoL6FcpGAHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFC8l0oFS768IjXSrRTzDuI8wmOaFTIU1RzCGlUN5k9FaH4pp3
	YB2cGDpo6ujiAvyUHX5wpUkpsZB+tC/qXT2Ez8pzTyITVbDW6aIjR06w/bO5N91l8rbNXaOnlQa
	FS9v4i2azMMVz8esS9wT1ufb3H4eb75xt6kev09VbPzLp4a8e6/gcVMnk6CMjAPRL
X-Gm-Gg: ASbGncvIQDV5uOGuhL2cwFZ/ofXHH0jNj715wTrXJLZVoc0Gjhba3+TNWqvVXKqrq/y
	YI325hbKl31fpxBuSf5m1JJMsymHXqeC8cupMVSxx35BV5j/gO06fbraIfEVRjz2I9OhfG0/jkH
	y8zchFMmC33DT8MS5CO7Sg2K0NljL0m7Mw3Gov0MtD/+FZ+51SxoTiqDZ65eBOtas8+tAbB3Vyp
	mFoVNGJqzfglnut6KWDzMEpeodOK4iIOPXezfb3hfSRhiRNeP2BkSQZczSpTWurM621fofeP4Pj
	DO9YGT44VAvBfWbnwBMzxiJ1nc98Rcl1yb+82JWygM9UpsqXILaK/5+OQ8PddCLuNiDUuRBPis7
	UNGBBa1HsH48ul0TvoiUO2jBz2RVGzhJqEir039o=
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr56491665ad.7.1760727400542;
        Fri, 17 Oct 2025 11:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKCO/8OEf5q9MtiPSZhBTjjXT9lJOMBbtv23Dt9GU9oMRJ+VlU3uAZY3eoFQ0b7rxF/ekGBw==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr56491375ad.7.1760727400090;
        Fri, 17 Oct 2025 11:56:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm2531175ad.52.2025.10.17.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:56:39 -0700 (PDT)
Date: Sat, 18 Oct 2025 02:56:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152032.654284-4-johannes.thumshirn@wdc.com>

On Thu, Oct 16, 2025 at 05:20:32PM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 conventional and 62 sequential zones,
> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/772     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..10d2556b
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Smoke test for FSes with ZBD support on zloop
> +#
> +. ./common/preamble
> +. ./common/zoned
> +
> +_begin_fstest auto zone quick
> +
> +_cleanup()
> +{
> +	_destroy_zloop $zloop

        cd /
        rm -r -f $tmp.*

> +}
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_scratch_size $((16 * 1024 * 1024)) #kB

_require_scratch_size contains _require_scratch.

> +_require_zloop
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +mkdir -p $mnt
> +zloop=$(_create_zloop $zloopdir 256 2)
> +
> +_try_mkfs_dev $zloop >> $seqres.full 2>&1 ||\
> +	_notrun "cannot mkfs zoned filesystem"

Does this mean the current FSTYP doesn't support zoned?

As this's a generic test case, the FSTYP can be any other filesystems, likes
nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
If not, how about _notrun if current FSTYP doesn't support.

> +_mount $zloop $mnt
> +
> +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
> +
> +umount $mnt

Please make sure the zloop device is unmounted and destroied in _cleanup, due
to someone might kill the test process suddenly.

Thanks
Zorro


> +
> +echo Silence is golden
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/772.out b/tests/generic/772.out
> new file mode 100644
> index 00000000..98c13968
> --- /dev/null
> +++ b/tests/generic/772.out
> @@ -0,0 +1,2 @@
> +QA output created by 772
> +Silence is golden
> -- 
> 2.51.0
> 


