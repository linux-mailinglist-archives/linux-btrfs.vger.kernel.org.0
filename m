Return-Path: <linux-btrfs+bounces-12692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60656A76759
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718EC188B3A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5102135C3;
	Mon, 31 Mar 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaWpWsIJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585953234
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429895; cv=none; b=MUdTyc2E+U6lMInDwaw6xX3ZigpmF36uyc0rAlEN4uwamAYDQA6fjUVnfQtZCiOGJ84cUtl9TS1KyrKw0ONDq1Y49ibj+fRMpQG4vzKWM4XWyS+Hcpv2gMzGm4462EDOXL3lsHtfMYqF8b+IcAmIuwiBHYMRYasdXWoMnpyb96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429895; c=relaxed/simple;
	bh=7HdFVsgydu4N2NlCq68SSQPnsLUSra1IFzqCvf6r6F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d17tdYPU+dfE2nGI9KdyMr8WmLPSJGrTr8lbNADhzwt2qa/3Dr3YjFqDoswOt9wJ1GKllrV1EHwmMqu/+qOzEGv/jDP3FF1xKh/c+bSEwhL4BZQMxO6p6OgN+TWSJDVktbAc08Bm9IChrSpLJjUBQULS6gAMjIHHh0rlenfJXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaWpWsIJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSUPs/LT3mRYH17wZQqF/ZEsL4G4iiiHu3bBKIPDiBQ=;
	b=DaWpWsIJGS2kRo83iH6VH7FkqE05vXhYYLMc6nS/o4Xktf7s+wi3UyXIGbLk0aUu3CCQK8
	AGXIL6MAlRtnQP0S/zTPujOeQRa3N34R8qcDG49SVhsF3z6lf/EPCt9T12mw0sy4SrH3BJ
	AVMfvgqlCHMYy9JNFQeMZ6+Orz5n1T0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-VT6ndESmMt-4-d7AFPS7kA-1; Mon, 31 Mar 2025 10:04:51 -0400
X-MC-Unique: VT6ndESmMt-4-d7AFPS7kA-1
X-Mimecast-MFC-AGG-ID: VT6ndESmMt-4-d7AFPS7kA_1743429890
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22651aca434so82785935ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 07:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429890; x=1744034690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSUPs/LT3mRYH17wZQqF/ZEsL4G4iiiHu3bBKIPDiBQ=;
        b=tI8i30CzpeWMC4Bl2N/aIFWLSDKWysZuXwYCvUHVIyrWe+p1+Id0SoamTPyNp6W8My
         kSfAw5vxEXzNhq5L2OifEjQnPO/CT7TfZFHBhdaxrEaqNZUAcvzD+GXoVM7UlXW3rPQ9
         4j1iHpPbNTRPJc9GDNG700xqtiO2MmuegMx057aujFpRX8qojHPn682oalqD44TWruzR
         VYemOtV4D9uRC6L0bmuRjT3BEUQDqSJ55XuwgenaaJiWam+2qxTt+zsXonnPoNRzwUL9
         NVfHgNfZXJ36YKFJXCIDTIZMzrj2VntGaW22/xYymAZu0NzZDeMt5Rwwm0poOhzsG1L6
         al5w==
X-Forwarded-Encrypted: i=1; AJvYcCVhm8bHBezzz7L1MGkmEhuZAETjkebjlGohwgUiMvSXac2evkTWOA4eQy9Cmt7oVkVhF84/jiM3BEADxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXX8VbymPuRNfnW25mNdwnlFMYb6C0WiX3YYYseTRHyRduhOL
	CVpz3YAo99BGsCcEScd0SVhKayXuxrGacqTk64Z1lx2dzst1wKEAY8CBtTMqX9xz7QHmbki2TSR
	83WlUhvkdjxdzzYaho/nKlG4gJ1HXiyvP1MSSTNPT00I4byiTEoJnI4gV0xns
X-Gm-Gg: ASbGncul86xDg88RcmnCSIC3wWfE4JEw8v+DC9FS20tKeRcOVAUYUCz5ysKyd7lzYUP
	twH2HgzTdHzU/d3jBv6W5///8/fTRO9aSMmMURPuFtO3KcqNc0OBcr+Bax53BfukDsTnK6M2nHC
	gBY1tvMFSEItcvyPSPfIHiIUmSaOWy/bqtR6CTyll4XGKZ5tehmW5AChnhn1W8mrVhh/oifY66s
	41Y0yrEd+ekGpvF2ytR1rxA8Z05zJq4XY4tfqRZqWTUkgyITMJRWKmqflb4ogVBCWj6xhoVfXVg
	FXdYdPq46mdImTY2TIrdySts25xrvySmBooOWMkiBFce/6aDHkkPqrpu
X-Received: by 2002:a05:6a20:9f08:b0:1f5:58be:b1e9 with SMTP id adf61e73a8af0-2009f5bbd9emr14857250637.4.1743429889936;
        Mon, 31 Mar 2025 07:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/CjtDFO5+ARDmtdJpl9Mo3f8QgnLccxc2wrTTR9Zgt3D32sI1Ol4nNe94fmvqOJYskuSi7Q==
X-Received: by 2002:a05:6a20:9f08:b0:1f5:58be:b1e9 with SMTP id adf61e73a8af0-2009f5bbd9emr14857214637.4.1743429889607;
        Mon, 31 Mar 2025 07:04:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6a1719sm6375909a12.32.2025.03.31.07.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:04:49 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:04:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 4/5] fstests: btrfs: testcase for sysfs policy syntax
 verification
Message-ID: <20250331140445.vepkrueevvrxrtyk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <8331718c0314fc373ebb2f43655ea2272759de63.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8331718c0314fc373ebb2f43655ea2272759de63.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:22PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/329     | 19 +++++++++++++++++++
>  tests/btrfs/329.out | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
> 
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..48849ac82706
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,19 @@
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
> +_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
> +verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096

Please change the verify_sysfs_syntax to _verify_sysfs_syntax after you
update the patch 3/5.

And just be curious, do we need to make sure the $TEST_DEV is mounted
before testing the sysfs' read_policy of $TEST_DEV? For example, calls

  _require_test

Thanks,
Zorro

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
> 


