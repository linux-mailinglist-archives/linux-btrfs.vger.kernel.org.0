Return-Path: <linux-btrfs+bounces-12693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382AA7675B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A128516394D
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C106718A6B6;
	Mon, 31 Mar 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjPWFx8L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A65213220
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429930; cv=none; b=M5cO3865JFOzJ6G6o/rQeb2Ikh6xS1kjxk/D0VXvCrhXGp5+23KWh2vcQgJaKFgBvnuHOsije/k4LfY83FC/bnvqzZxn/0EVOf1biGHlSPiNaGDDB+j+POmlSQy5Qoh/95tv5et9wqvMZwr9wNy8ySgI661a5uDZgmgYgTdHsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429930; c=relaxed/simple;
	bh=B+AwkAZOJEiT2q+B6HITmNEqaPPCcCX4MXwG5fdQAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhLcBhvOPyAZFH9vGaTK6QthQNy8X7sqiEdJDFJm97WPc7AXxoLQAbPlGZoZSntxItHTC348TlaUzPhzxdsfJHd0PWxBunCguYUiCg0DSIyZGtL0ADgwgo6zyA7vvmN165eFm1HdjjugqYeU4tyfGXH8J+Y3XM/Vm/vK17+e3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjPWFx8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbJE47OqdqR3/52t5jOg708wyYmsdkilsHpLK6arp/s=;
	b=WjPWFx8LdXI3nO81GJ5c4qzr4OSgLXgkmB5Xs/PHDHDGqxliENP9G+W8ZXYAtma1smjZ6b
	85Aa32S3oFOMzXmCcTnaNdelWbX1hiFYMFbO7qjFyr49aHWgKdMjTiJJTqT85wQxJ5zMPS
	dqYUovpCeQOF926DZuba9BrwhjmSjug=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22--6ZY4ALLOdWBsbnIpDzoGA-1; Mon, 31 Mar 2025 10:05:26 -0400
X-MC-Unique: -6ZY4ALLOdWBsbnIpDzoGA-1
X-Mimecast-MFC-AGG-ID: -6ZY4ALLOdWBsbnIpDzoGA_1743429924
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-227e2faab6dso70306655ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429924; x=1744034724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbJE47OqdqR3/52t5jOg708wyYmsdkilsHpLK6arp/s=;
        b=kCDH41NJRUNCPjXrCjMDydS5x1V2uHIolmJISsgLZjCd6Gncp1K3c6U5XlMRwRj/Aq
         3WNvqQdFQtS8CsFbapGZb5N1OygiMyWqnq7XVj4eXyrGx7l9HDo4yqMl7+LK+sLJhorV
         KVoSr34fzydSwC/W4S9Aas6egSyeRGzc5uUjm+vZrqT5DV/XoH5Vs1yhxkGGpzhlg03O
         cGv5DMrSeoq7Xc+BOcC0om7wcx1kN1AWdN+ZwIyS4QkECNoXuMu9sBF6CiMqVAT7Kl5D
         e6kIt4SpTDBTYlJuk/lJB1KgHPdfUYJQqNgZbeu/Zo/elD0HLBu3RjFVsGJzKR+4S3cZ
         sD9g==
X-Forwarded-Encrypted: i=1; AJvYcCU/k5X91ePHuso9v3fyV5EzMz7SFVhdxr0cTWUlPKcC7OGDKHPJXUIB/ssYyeHJE9Z12CwtMssUCxCXTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNK2VH8+pnWm5SznKpCj0GL+VWGqZ0Q6q6PHH+41zR4CtXYhDQ
	FbiW3EofzLpA+7fdNlmXcaYfi371RbYVjTMjAHe/9b4wIzTVrO5i5gAH72bTpLzNRNI7KQmeh7v
	Rq8FlgyScyiIXblHQvsMdhkqpmpfKwa410/iU1DfbTuD9G2Ujd+1wfVNqPsst
X-Gm-Gg: ASbGncsTWmHRfbKduGAWl/8zEq/VhIoHgGRBIo/4olGPr+AoxwKwc6kEPD9RXlRMzaa
	ETzCRZkUhFKNNJlBqn297sEZcBhI5O1FUHtA8b4+vSJTmSogRnBoTqvEaZzflAw0AVTjH/DtUVE
	trF6D+jb+CKu4rj+9gzdred3sOWhSSB4w1FMvUgptK5xwPZFJGoCYKm2e9VG1xx3O4pS9Vr8EgU
	wnZQ2ezDY+YYIxAd8xA0JwzzHqaJF3Hg2huv34FhSptF3+Box9MPc3AFnroDpazYSqFCJAScP4Z
	lihLbYTbBHvx12HBKyfYKUI5VWahLQiSauDD2KSbcluBQ3bmdh91yxOo
X-Received: by 2002:a05:6a00:2e18:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-7398043955emr13493800b3a.15.1743429924369;
        Mon, 31 Mar 2025 07:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOm+wZTjpuHBz9/z/NZkXD5KYjRzV24qYWQ5XAIB3MRLSHrrSWS1KF20c3rGNnimE6+Wshjw==
X-Received: by 2002:a05:6a00:2e18:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-7398043955emr13493763b3a.15.1743429923958;
        Mon, 31 Mar 2025 07:05:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109d361sm7142605b3a.138.2025.03.31.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:05:23 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:05:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 5/5] fstests: btrfs: testcase for sysfs chunk_size
 attribute validation
Message-ID: <20250331140520.r57xfhsijfiltfct@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <8b6df6ccabf016310063e75117759c835931f70a.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6df6ccabf016310063e75117759c835931f70a.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:23PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax allocation/data/chunk_size.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/334     | 19 +++++++++++++++++++
>  tests/btrfs/334.out | 14 ++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100755 tests/btrfs/334
>  create mode 100644 tests/btrfs/334.out
> 
> diff --git a/tests/btrfs/334 b/tests/btrfs/334
> new file mode 100755
> index 000000000000..532fe37a0489
> --- /dev/null
> +++ b/tests/btrfs/334
> @@ -0,0 +1,19 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 334
> +#
> +# Verify sysfs knob input syntax for allocation/data/chunk_size
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/sysfs
> +. ./common/filter
> +
> +_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
> +verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m

Same review points with patch 4/5.

> +
> +status=0
> +exit
> diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
> new file mode 100644
> index 000000000000..f64f9ac09499
> --- /dev/null
> +++ b/tests/btrfs/334.out
> @@ -0,0 +1,14 @@
> +QA output created by 334
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> -- 
> 2.47.0
> 
> 


