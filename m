Return-Path: <linux-btrfs+bounces-3154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942BF8775FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414F4281916
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125511EA8D;
	Sun, 10 Mar 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0+8bLUr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930A1DDD6
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710063624; cv=none; b=maIgtzvSExQJc/4BqpL9iILbvQ0Hr30uUe8XyZPVIj2BjyP8c9jnnxRXsrQX2T8DA+y+WGQDsMNhh7Wu/xICxySFZFhbCciS2QRwhN/r17mYxL8k9VsJ6LfwRl9tcFHS0V1nPT/BiT1BRJ5Dcw9gYsPIsSdeRUMzYIez83YMFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710063624; c=relaxed/simple;
	bh=bm8ypW2UPnxfX6bbV4zwEVw2RdC3MlrH625AsocDxIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0rSPWY80X58B2GacK2c8QHoJ3isHwdVx4WqlEDrZpCX20c1m6oOYvKw9FTY9O31clukw8bEo+mBUIfkNPeWhLzs1A+P3OAqhA0LivJsmN4Jzjy00JZ4ps5b7q2FDkxnWXP9PMMHtXKYaGfkJZeB0dN1qmITAapbJAYABPe8B6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0+8bLUr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710063621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a9o7Y+xAnyErFbfnWIeD9vfrVIxewPvI3Cy4Q3YK4kw=;
	b=V0+8bLUrYCMfGfA3ATk1j/312KzOIekaRCiIB6LXC3aSGt5F7UnrTTms+xlN2bEmxkww8J
	lu2Fa6gTdLoK0KTMD15cyu8dpyv/oBvWrbYA1CY2RyUn4Wc30Ccn7uKfFk+FiilmVvnVEr
	ie9FbIGvaosKgsvbol6H/sL1HDwLxZ0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-b48x0npvNuG1s4TFqMXOmg-1; Sun, 10 Mar 2024 05:40:19 -0400
X-MC-Unique: b48x0npvNuG1s4TFqMXOmg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29ad35a8650so3451078a91.0
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 01:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710063618; x=1710668418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9o7Y+xAnyErFbfnWIeD9vfrVIxewPvI3Cy4Q3YK4kw=;
        b=Wgg/PFBdCf5HFV0GQejqkml+3LW2VMlqJpJzrnsFPlHdLFtkDWTGYPw5Vzw/hwZ5g3
         NT6jDs7SXLDK6CdNxSCJZlhgnhlffvdTvE2gSKAioJI5rwvj/9YD3AUs/DQvEshNuBm0
         v3o6izZw56mKrBhak/08+gyZ8eN/g0/EReeDefDCGDY6xEN/ksyBtyMKSl+CdC/FkxvP
         JI6CajPTrxSlV+J4XdEPI3d2bRFXjSBg+EPOFbfpXN6C7G0XAOirS9ixkm1Ub1Lho4p2
         ROlkgOtBwThkYwcrEMA4fRmIVbKaDsdz53Eutwj5S28IOwsPuFjUGkSzQAw+J7WD9Eaw
         r0gw==
X-Forwarded-Encrypted: i=1; AJvYcCVH8R7X+DnLu9C37Eg3EBn3jsx+gwysZgcAbm/4BbapLHkr/4nZuk2aAsRMgI3MPpzi3cf16z9xJ1bo2Zwj17gJ8tfpci8+vlrNgH8=
X-Gm-Message-State: AOJu0YxgAVRkIK7ts32cgG+z+YSMBWpe5PzBzWICHnutA3wmSTTxYysu
	T/vf+53MJlA3j+RFJRJlmn63aiaKj5hhzSFsEbkOaa7RZM0GaNQSA+5yan6zhRLBgmR/3qheh0K
	2+xA8QazbDA63EOLsov3CAcnR4mbzMjyL/4DNc2Anb+B1H3SdRIp1sjj7/TYp
X-Received: by 2002:a05:6a21:6d94:b0:1a1:6eee:227a with SMTP id wl20-20020a056a216d9400b001a16eee227amr4197128pzb.28.1710063618432;
        Sun, 10 Mar 2024 01:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg31fLZr5NRYKL446sGScNEjg3zv5F1SXoivuFZvdDgIEsJg2rTQfuxjRbnSjVbhEZQI5NHQ==
X-Received: by 2002:a05:6a21:6d94:b0:1a1:6eee:227a with SMTP id wl20-20020a056a216d9400b001a16eee227amr4197113pzb.28.1710063617977;
        Sun, 10 Mar 2024 01:40:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d1-20020a62f801000000b006e6253bbcb7sm2251998pfh.61.2024.03.10.01.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 01:40:17 -0800 (PST)
Date: Sun, 10 Mar 2024 17:40:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.03.08
Message-ID: <20240310094014.55u7tfm7ecip6mtd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240308144537.16995-1-anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308144537.16995-1-anand.jain@oracle.com>

On Fri, Mar 08, 2024 at 08:15:32PM +0530, Anand Jain wrote:
> Zorro,
> 
> Please pull this branch containing bug fixes.
> This changes are based on your branch for-next as below.
> 
> Thank you.
> 
> The following changes since commit 9b6df9a01ac8ee3f28a2a24d71e45792e21b6d48:
> 
>   btrfs/016: fix a false alert due to xattrs mismatch (2024-03-01 19:24:16 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests.git staged-20240308

Thanks Anand, merged into patches-in-queue branch. Will be in next release (might
be 03.17. I need to test some patches, and wait for some patches together :).

Thanks,
Zorro

> 
> for you to fetch changes up to 9a03e88a04b6cf6e161c8902a3a523ca22601277:
> 
>   btrfs: test normal qgroup operations in a compress friendly way (2024-03-08 22:31:51 +0800)
> 
> ----------------------------------------------------------------
> Anand Jain (1):
>       common/rc: specify required device size
> 
> Filipe Manana (1):
>       btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()
> 
> Josef Bacik (8):
>       btrfs/011: increase the runtime for replace cancel
>       btrfs/012: adjust how we populate the fs to convert
>       btrfs/131: don't run with subpage blocksizes
>       btrfs/213: make the test more reliable
>       btrfs/271: adjust failure condition
>       btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
>       btrfs/291: remove image file after teardown
>       btrfs: test normal qgroup operations in a compress friendly way
> 
>  check               |   6 ---
>  common/btrfs        |   2 +-
>  common/rc           |   9 ++++-
>  tests/btrfs/011     |   9 ++++-
>  tests/btrfs/012     |  14 ++++---
>  tests/btrfs/022     |  86 ++---------------------------------------
>  tests/btrfs/131     |   4 ++
>  tests/btrfs/213     |  20 +++++-----
>  tests/btrfs/271     |  11 +++---
>  tests/btrfs/287     |   4 +-
>  tests/btrfs/287.out |   2 +-
>  tests/btrfs/291     |   2 +-
>  tests/btrfs/293     |   6 +--
>  tests/btrfs/293.out |   4 +-
>  tests/btrfs/320     | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/320.out |   2 +
>  16 files changed, 164 insertions(+), 124 deletions(-)
>  create mode 100755 tests/btrfs/320
>  create mode 100644 tests/btrfs/320.out
> 


