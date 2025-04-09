Return-Path: <linux-btrfs+bounces-12911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A03A821FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7030E1BA5378
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4A25D8FC;
	Wed,  9 Apr 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYwoNvTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88C25C6FB
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194172; cv=none; b=o/lYa/0Fd7aRuoZUK4WAsZ5thb1nDLHojVs31vOTJhm/uRvr5kSwUuo1kbrzZIVy28xpq89QgHCcsisyUBS3ZPcrmPmPtQwmEtkPYh1M0QknqwtrBayX+iAKTNdyBqIgCMz9S5m90jfvcPBviDd6CqMDXt9FEwejJgYOfhBWV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194172; c=relaxed/simple;
	bh=dcg9diGmOETxHl3X0pFjL22l8wT63J1MgIIDDThjJoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPR2JGLvVVttDatx0EHg8XdoQ7moR+TMyj1btJW2ZGcM2TfW02q2DRAgRSUoxd+x98yvBx4KrVE8crIIiuDUWaB2/yFGjcP8oenfqrrffFi37JDsa2OFTYKBGWyt/cB6z+Wq1fssAxNW1PN+m3g9dxTsBhQnjkOmypIUWvgGQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYwoNvTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcrGQST1e8wmHt/n1CJ2fai9C3J4yAUkIfuo/b2aXHE=;
	b=aYwoNvTnVH/qRSLEB4R5pV8FEBoucjmbhGLgIHX8/x17AdW3XUHBfm4W7veVmENcSOaCCi
	7vnR9s582wO+6ti034PONnO2hh7JRWRxEql/lo1EWbfw4n0I+FGdDbUuSzRU6yDgBMJehL
	tq+npVA+6YFn2wb0RIShHs3PzyEpqk0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-Cg1JrYSNNImEQ_8D9G3ddA-1; Wed, 09 Apr 2025 06:22:46 -0400
X-MC-Unique: Cg1JrYSNNImEQ_8D9G3ddA-1
X-Mimecast-MFC-AGG-ID: Cg1JrYSNNImEQ_8D9G3ddA_1744194166
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225974c6272so5278645ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 03:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194165; x=1744798965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcrGQST1e8wmHt/n1CJ2fai9C3J4yAUkIfuo/b2aXHE=;
        b=SO37seioRMER/jSH1bvSLy+xy4Py6P6TSevwOP+b1SfTYrdIXTQUCn4hE0HLsi72xF
         zSZw0Ai2Ioat3zAO+3fzp2aOs15zK8SUJpLcGGw10Ylm3pd7DM5qOmGnmur444Oylh39
         E8dnEOIo6Nkjnoa3fKiIBUZUTgNv9NHV3QuXv5oUuIEtTVIgnzL41rMLOJj2MyPdibLI
         K5KaAHtb63GYno43mdvfaJ/pq9iS/njwwg3RbkFjP4WJ+HRv52VK0qegeaXajiiRO1g5
         Uz6Vuml/Y/nC5pFzsaejO3a+92ldUDvHb7QoFsIemvWBGbkHb2LM2uT1r111p8XWm64r
         rQPA==
X-Forwarded-Encrypted: i=1; AJvYcCXNqemUlDOb46xZz2U+MP8VuhvxFwSmGx4q/vRq5lZa7qi3cXHv+Mg4AzB44BbBOGrPIoapMEh8bqR1iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7x5HwgMMkUiWDlCiymnZ0Bp6EsWlJSI1vl/VnB9dpl3o1k47Y
	UAN4BwCGD394sLGTzbXYBuNNOMrWBJQ/hIXl0dQW8WP6y7acPCCcCygAcaL33hh5Xa6goxlrydc
	83VlJQZHLGdr8PNZWpMdUsVmdhLYzF6bW5y6/du4QkkpJlY3tVUV2NF9olVQT
X-Gm-Gg: ASbGncs/FAQBVsTLrlN87y3udmzTDmLMKalW4k+u8TE7t62tk5XFalfIcSbChT1JbLL
	ZHyK/maYH+VOFsXe0qyjnXndSzbngmhMzXNkgJNld2DGc+R1OyrRWUgRNGCxdciORBnn172LRC8
	96c0l0EQrm4g8Cpn7srN0tmmhnknbObLnZl3DG1gy7VIrZQUIkg8UnXkPooZpZuqG+ca6TSUqx8
	n2mk9yAK68rXNL67/tJNANL8xAOW2ZwMxdRLzQnYhJrOd7spJTxxcdyZ+6eCETd/KJHTMmLjck4
	s83HbTeNXP6MDZc2GW7ueu5UaaJebDo+Sax7OnM5neB+wfr53s7w
X-Received: by 2002:a17:902:d50e:b0:223:607c:1d99 with SMTP id d9443c01a7336-22ac3177406mr28365785ad.0.1744194165646;
        Wed, 09 Apr 2025 03:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEZkdchgkOCqLThdgbAgpbOQbj3drE9E5QtEXp78hPTcXegSMcL6XPMa2v3LzeqTILr/DjOg==
X-Received: by 2002:a17:902:d50e:b0:223:607c:1d99 with SMTP id d9443c01a7336-22ac3177406mr28365565ad.0.1744194165311;
        Wed, 09 Apr 2025 03:22:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628edsm8232085ad.10.2025.04.09.03.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:22:44 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:22:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 5/6] fstests: btrfs: testcase for sysfs policy syntax
 verification
Message-ID: <20250409102241.vj52t3vqqhoitkdl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <b4a2791c47d6d5b4ed32762044d0d3dfce24a11c.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a2791c47d6d5b4ed32762044d0d3dfce24a11c.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:17PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/329     | 21 +++++++++++++++++++++
>  tests/btrfs/329.out | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
> 
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..f4faddedf076
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,21 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# Verify sysfs knob input syntax for read_policy round-robin
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/sysfs
> +. ./common/filter
> +
> +_require_test
> +_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
> +
> +_verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
> new file mode 100644
> index 000000000000..eff7573adb6a
> --- /dev/null
> +++ b/tests/btrfs/329.out
> @@ -0,0 +1,19 @@
> +QA output created by 329
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
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> -- 
> 2.47.0
> 


