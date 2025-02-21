Return-Path: <linux-btrfs+bounces-11699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF9A3F7B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 15:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850987A6F9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8966820FAA1;
	Fri, 21 Feb 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrzCGozh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BA1D9688
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149484; cv=none; b=ZhXyS5LM2jvwOsODtOMsPA8vNd/rbvTgneqcrQ9tvvOUzRrCbLerxlNgYY82S2btBndJIRCE8PLZec6x6Wcfy4I85PAeiqll/WAHG8/xY0URronx8iUGxLGyLpOIN4Faz2e1krC+dONt1e/DsXH4ppQfy9TCzEvtF5W7aJnZKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149484; c=relaxed/simple;
	bh=23OzCGEQwgm/CHA9E/dnj/kxzAr290jDwVsHvtWRkj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM7xK1tzRL5Av8/ke9+jExgeVEb9oqGFMWVQ9wW0qAfD/QSiuT6FrLOlKyq0REkrxRIR/4KDACNg/ddBXJAj4mmQwEHRdT13MFyhPF8T0YlYfgDfmDpLBDK0G4cDF9bj/z3oWU0LkrbplxOVnySPvpB/8aifWcENxeka4m03zOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrzCGozh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740149482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpfHM2DEQnkkK0LFCqy07XlLDJvWgTKzpg5avap6694=;
	b=WrzCGozhHSqyc2VL/oToku9Da7S6emKnGZf7cIpJc3jrqWiApMhIcC6P065Zrk1ePZekMf
	cpuNPRuSzBHtDgd3Ua0dmxZAOV6RkP7pNlfzDJkbfCjtkkJ2yK8PY8PPIgvEJCsiK/bfS0
	cvzzB5Vn+muh3XtjaL981eDYoVbQggg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-EHQ6RWYuMWOlV5xVUN8KMQ-1; Fri, 21 Feb 2025 09:51:20 -0500
X-MC-Unique: EHQ6RWYuMWOlV5xVUN8KMQ-1
X-Mimecast-MFC-AGG-ID: EHQ6RWYuMWOlV5xVUN8KMQ_1740149480
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b3882febso13200285ab.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 06:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149480; x=1740754280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpfHM2DEQnkkK0LFCqy07XlLDJvWgTKzpg5avap6694=;
        b=FZzJw7EbxaVJ6TJBYcTPY6vwYDAnMkcsmN2jDoz+u8JPAO44BVeInexIBGN0RVvHoB
         YBTGj4pZ/SoysXVqppbD+WomxYZ7lO2QZf7RICwiaC3MpG4OiKVQi2fH+Ut4vDxH54ts
         u08NXR6yNUrsyerZ68iiFlvrEeTf7N2Vg+Xo8u0xwXeoQwrtYccxm4MxuUVOiYpzVfuq
         9oYS4DsqqdbB+YxktBlDUYMESH7RE7Wud/vvqNk2/+B7waJDJTKqnCbTxaXjVmGuzMcU
         lR/2aangiM5D15rAjp6rt6XCofN0UOguqa0OJqKBkWYWuSTG5XccuJj8vqrBUVP3Xg7/
         dweg==
X-Forwarded-Encrypted: i=1; AJvYcCWdcoPZ3Xv/2Lgx+CPoJ2fW3oz9Z2smEn52ypYBXKwCEdmhGQswh0QMm/U3RB4tOWzv81X2+DcIeLfNKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+ga2vZoN+08gVgKDjlrKaj1eujTa76M6hT84o6E0t4M/aqLG
	Il4G/D9BTS1NkCIKvceuN8432GtQYwZYgpoWb/5g1qgYhQluEYTmBktlG5OeQIUhRtPtsJl+PfS
	NdVmfFr0EoVI/2YJomBu+a8Kgzr0kdgiosODMT/+7ekmvGO8QKxcab45Z33GF
X-Gm-Gg: ASbGnctkTEg/8CswWrzNS9rgafD6HyRvPSwPzYAbqkW9dbFCVPLzByMU7NSRPXKzPjU
	4HdT5WJ4D0LS5TncSTEnvt6182fH2Ml4fn9n9WEIn3lggEDXshmJgQPW9GU6pizA6HNgbucg+D6
	og96APjjTNOWG8wZuQCiRjC5oo8FlEI+R07tTbMrf2xKE4XNfoatJ8FgyLHClFVW7DtSP6A6xyL
	jtrQh2tkWJmqSu6MM8g9Nw7MXCZVUCLwLDTQJLcdHvXgcJ7qmke4Ve1J8bUg0WefWarByrDvEF8
	CcAQx9qPDrIVxvuB3CwHnGVLB5ljN16yuECZqU0Uq1g0JBIICL/Kmkwz
X-Received: by 2002:a05:6e02:3d83:b0:3d0:1db8:e824 with SMTP id e9e14a558f8ab-3d2cae69873mr31549855ab.10.1740149480048;
        Fri, 21 Feb 2025 06:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+Yl5SrSvjCVGlZNUK+6Z95Llt1oWITKpwT/98A8RCxXxE3OYyWoy+JVJNhiktCNwfDKD18w==
X-Received: by 2002:a05:6e02:3d83:b0:3d0:1db8:e824 with SMTP id e9e14a558f8ab-3d2cae69873mr31549545ab.10.1740149479745;
        Fri, 21 Feb 2025 06:51:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eeb0f424adsm1646667173.98.2025.02.21.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:51:19 -0800 (PST)
Date: Fri, 21 Feb 2025 22:51:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add commit IDs for kernel patches that are
 already in Linus' tree
Message-ID: <20250221145115.u7ilydijaq56kvha@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <4ba5443a5789880423ce3b90406a12314626e349.1740142425.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba5443a5789880423ce3b90406a12314626e349.1740142425.git.fdmanana@suse.com>

On Fri, Feb 21, 2025 at 12:54:43PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Update a few tests to refer to the commit IDs of patches that were already
> merged into Linus' tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for doing this,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/323   | 2 +-
>  tests/btrfs/326   | 2 +-
>  tests/btrfs/330   | 2 +-
>  tests/generic/562 | 2 +-
>  tests/xfs/273     | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> index b7421f6e..08ebf194 100755
> --- a/tests/btrfs/323
> +++ b/tests/btrfs/323
> @@ -13,7 +13,7 @@ _begin_fstest auto quick seed remount volume
>  _require_command "$BTRFS_TUNE_PROG" btrfstune
>  _require_scratch_dev_pool 2
>  
> -_fixed_by_kernel_commit XXXXXXXX \
> +_fixed_by_kernel_commit 70958a949d85 \
>  	"btrfs: do not clear read-only when adding sprout device"
>  
>  _scratch_dev_pool_get 1
> diff --git a/tests/btrfs/326 b/tests/btrfs/326
> index 1fc4db06..7e6e7b77 100755
> --- a/tests/btrfs/326
> +++ b/tests/btrfs/326
> @@ -15,7 +15,7 @@ _fixed_by_kernel_commit 951a3f59d268 \
>  
>  # Another rare bug exposed by this test case where mnt_list list corruption or
>  # extra kernel warning on MNT_ONRB flag is triggered.
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 344bac8f0d73 \
>  	"fs: kill MNT_ONRB"
>  
>  _cleanup()
> diff --git a/tests/btrfs/330 b/tests/btrfs/330
> index 92cc498f..3a311a5a 100755
> --- a/tests/btrfs/330
> +++ b/tests/btrfs/330
> @@ -19,7 +19,7 @@ _cleanup()
>  
>  $MOUNT_PROG -V | grep -q 'fd-based-mount'
>  if [ "$?" -eq 0 ]; then
> -	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	_fixed_by_kernel_commit cda7163d4e3d \
>  		"btrfs: fix per-subvolume RO/RW flags with new mount API"
>  fi
>  
> diff --git a/tests/generic/562 b/tests/generic/562
> index 36bd0291..03a66ff2 100755
> --- a/tests/generic/562
> +++ b/tests/generic/562
> @@ -16,7 +16,7 @@ _begin_fstest auto clone punch
>  . ./common/reflink
>  
>  test "$FSTYP" = "xfs" && \
> -	_fixed_by_kernel_commit XXXXXXXXXX "xfs: don't drop errno values when we fail to ficlone the entire range"
> +	_fixed_by_kernel_commit 7ce31f20a077 "xfs: don't drop errno values when we fail to ficlone the entire range"
>  
>  _require_scratch_reflink
>  _require_test_program "punch-alternating"
> diff --git a/tests/xfs/273 b/tests/xfs/273
> index 9f11540a..7e743179 100755
> --- a/tests/xfs/273
> +++ b/tests/xfs/273
> @@ -24,7 +24,7 @@ _require_scratch
>  _require_populate_commands
>  _require_xfs_io_command "fsmap"
>  
> -_fixed_by_kernel_commit XXXXXXXXXXXXXX "xfs: fix off-by-one error in fsmap"
> +_fixed_by_kernel_commit a440a28ddbdc "xfs: fix off-by-one error in fsmap"
>  
>  rm -f "$seqres.full"
>  
> -- 
> 2.45.2
> 
> 


