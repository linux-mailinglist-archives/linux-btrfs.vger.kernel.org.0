Return-Path: <linux-btrfs+bounces-12912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5D5A821FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984831BA4989
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD8425D8F1;
	Wed,  9 Apr 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuvS/P24"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76325D1FE
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194229; cv=none; b=J5oFvms7xe6DPG8nSElvef1iLjuBXvOKOI2R08Qxb3voIJMIHutYViPKf5P6KZuHT4+XRMDGENYSF6WmHohIhEHVON57ohqfBuT/d5L76sYMGBIbtlTzx87Q1SwPUvroryZMG9giWAdxZZhQB9U0Qg4jEJ7BMH6D6QWy31V/FDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194229; c=relaxed/simple;
	bh=pyeFoEm78Vu7hsKXBNymqLj471vUb8RdNTwN5jdedmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOvm/fAk7I0e/yucXqblDffsWNfSNq3o21426QaxMd/rn1x76lLReq/N5H2L2vE7+fpYwR3brtfioENdn58KgaIeX5LPkpwH2XAwjY1FvPRHDmzJndDBOTiHzUua5i/KhmHAkJNp50QpZ7yNUqpFdUlWX41smGma3QJ3h/Xw1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuvS/P24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0k7F4odglZY3WVlCzU+CBDzfgce9j8xtA/EUvRCkJc=;
	b=XuvS/P24YaiVYJE/Hr4bZaOA3rgJh+hCl3cuvCAzSXvDhaOr7tUa6xC9iU5xtjNDBkRU/k
	FkFfrxChh3M+hwUYSutngO9OZWPptjRnwnZyFqk+cbeh50ONlxpz4BXp/7fTLPNCru3FtD
	HSJM9EaOrz0TG9EUiXweE3TdrREIo/c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-AzuaxcyaN3epB-u7Bsc-cg-1; Wed, 09 Apr 2025 06:23:44 -0400
X-MC-Unique: AzuaxcyaN3epB-u7Bsc-cg-1
X-Mimecast-MFC-AGG-ID: AzuaxcyaN3epB-u7Bsc-cg_1744194224
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736b2a25d9fso5288559b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 03:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194223; x=1744799023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0k7F4odglZY3WVlCzU+CBDzfgce9j8xtA/EUvRCkJc=;
        b=BN/0+r6T4S5AbcXaq7Zu86T1pJ7HnCL8g/DVSjmUelF/psXfAEXPl+sMucdeeqOeBC
         C3ta28jCOkmKgdtSvzJ9cmv+RBdm5KAW5aQD3y72M9sejKCXCEcmArsRR7M7mMDpUP90
         u9wE/pURDfMOn3m0Uv0q7SQwxsgBdi2hnadaYhsOtVARrnT4XrucE9yObfXG7XKEfjnY
         CqMF1SzuvNDFSuUI+WdtsL3hBO4y3JVO5aQrz7I1zYMvdvcsEp43bUVdMG8k+dQZDN6Z
         AsVPK/43KNAEvm3nwIbOKidmWO8JjSpqodrXz7tH6hrrX90IxYnWew9KJ1YSZYSvAYoq
         hvrA==
X-Forwarded-Encrypted: i=1; AJvYcCWZSep0oaaoL4QfZfDrGkxBM641LYUoNlI4Y7Dr4xNbmGdUJOBVh/AppGUrMEOmJXc/Ikyh0mBtut7w6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJfM7ZjtIpq9ZkORGKZZPxxpuEwnz3EyXotEIGT2CWbAd6+di
	/A0vhaFz2lT125SjcQN3s05npeOcCM+g/T5LLcyhQjqUArIIgeNucmYgsk8FcC/AQFKwC4bAlLl
	XJdUTrt0Cet6X2PDPaJMUjyXR1XJ33purGc0DBkmlG7CbReVqxnyU8izV5mDs
X-Gm-Gg: ASbGncu/asbffdGGtcon3tmTWRimxVxB6ObE63O/kXhdrsvUive5n530TEqzH/8PuDI
	fkvFwBDgF6ixxu9CSVcruRdB6E+JO9Uu0E/HWrxZi7nTNPntb0RNc+vypf4NnWaDgcsqFFZw1Bw
	6ltQCPh6TsMNPPNLQ7axdRE817N1bcItSar5F3EHv0EMRXQCc/4oQf3xls9kFHsH3s4Q7f2TFRf
	mo6DAgvh4szU67XM71xiNro7JElgKZYxsR7AMbBdKOGn5cDgRzABTrDAdcZDilEbPWR1Ul4joTs
	PlDHa7DVgxiKAoqW+Oyl4kywz+mXvw2/QOPwS58mjYoxqYqTYK83
X-Received: by 2002:a05:6a00:2292:b0:730:95a6:375f with SMTP id d2e1a72fcca58-73bae490ff7mr2917719b3a.3.1744194223664;
        Wed, 09 Apr 2025 03:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGrfx8aEqkXH+Rsu2T9l6BMFNcFL/SeTDqH3+NG+bKZxq+tjV1K9cz8WsTBYSRErlRIx4ug==
X-Received: by 2002:a05:6a00:2292:b0:730:95a6:375f with SMTP id d2e1a72fcca58-73bae490ff7mr2917692b3a.3.1744194223278;
        Wed, 09 Apr 2025 03:23:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d6af12sm930692b3a.80.2025.04.09.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:23:43 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:23:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 6/6] fstests: btrfs: testcase for sysfs chunk_size
 attribute validation
Message-ID: <20250409102339.s2akqjndh25hqkjr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <a53aa65a639bd7906c28418bee14ee4d006700e4.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53aa65a639bd7906c28418bee14ee4d006700e4.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:18PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax allocation/data/chunk_size.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/334     | 21 +++++++++++++++++++++
>  tests/btrfs/334.out | 14 ++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100755 tests/btrfs/334
>  create mode 100644 tests/btrfs/334.out
> 
> diff --git a/tests/btrfs/334 b/tests/btrfs/334
> new file mode 100755
> index 000000000000..d81ec921f1f2
> --- /dev/null
> +++ b/tests/btrfs/334
> @@ -0,0 +1,21 @@
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
> +_require_test
> +_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
> +
> +_verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
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


