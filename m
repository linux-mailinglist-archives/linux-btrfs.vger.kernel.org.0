Return-Path: <linux-btrfs+bounces-7007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06146949273
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094C3B28C51
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C81EA0CE;
	Tue,  6 Aug 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMbpMpln"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549491EA0BD
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951954; cv=none; b=k2cwJjwU3XMeXUiqy0x0Iy+hc56TK8UlJpKsgesNcsICgGeO/cq6oO1CZHU87IkQ+g48LjzglbHEob2F8SUZN96s3A8Nid+pP7G6jwn8rhJYOYslPf1rB3bECyh6izZxBBqfkCYccOAcck5mCbVHl4aGxPu7KerAgJXm3XPYqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951954; c=relaxed/simple;
	bh=JntuWFDuBdyUVzja1Lml9181G6EzygSOut5mWGJZMro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqH7vsDNLxJE/LgyAmEHA5wElSvKhtj53Ei+WhMp9lGIz6ltaYjQDLHrCa4htIa3fi/i24lvKPG5HuD03guQyjmZtER5cnd4vqNPQeE8FOMm4oC/Vb7Xdwug44GMsVrfU2z3FXyTpwVIPFcEeGt1BNzTxMj+/Jt1K2dcYhKYOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMbpMpln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722951951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14kaEXJ/fYktRDtIF6Cwxo38R5BK66laylWRL8R7wds=;
	b=jMbpMplnT9A3eSEzbIbiAkcICtUlgQc26w331nj4rRWR+3QH63G1q5xOGtU6L6tSQvgxgW
	TyWoDEaGNrBdZ0f0Vga0a0IoDfbKgOFPnTHAsffh5fw3kxLwbk33MqDPbqpxu9OfLRNGW2
	NI+4IDJUTDQni09uhvwbB069tL4hdMo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Vj9rpaSRPB-akxRA4nBy0w-1; Tue, 06 Aug 2024 09:45:50 -0400
X-MC-Unique: Vj9rpaSRPB-akxRA4nBy0w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71050384c9aso964493b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 06:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951948; x=1723556748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14kaEXJ/fYktRDtIF6Cwxo38R5BK66laylWRL8R7wds=;
        b=jManSbn//Q1E93AXrsDWfy9asI/px/OSipuFFbQQ/v5DmvxqsAzN74dCwzOKp91emK
         WmeWxb5xAlaqJ4aBuns2NjFqr4Jg82pYfC1T3nVAFznAjZkOiediSm6GAtnem/py2B4L
         aniiWIF/kCBFxmrqO0j1YybPt8o6Fuxc5rYegEsb9ch7504uhg3xXmuqZHzBSLD9orL9
         QIKy9cu114v7NLpncy7Z+LWkCQLNmX65Xgjhw/P+yCbJxb4kkqap/+58Eq/J6ejzb2WU
         uWLpMu6U02tjhNOZKYsRNqlCyXASZ2Z1Ydp67rSB8clivViMA560m2JZpBHJuxSc922a
         0B5g==
X-Gm-Message-State: AOJu0Yyg766FHlFTdEEUsMo/Wnwn0GiTJ+r5EFxIU/seSpLY9s5jvY2e
	iF6j0jjwF9rUzzOzbUJL6yg1qMufK/BPTsBJll/srLKGCXGyNJLs9EYNdJ1M9t9uD36WHzipzhP
	gvrj5vUqx4UiepJGjYSBeDLRWKbblBK1OhV6SAYx9YEPiZjJ8T2JLy6mQa6BmJ5CZRIDU
X-Received: by 2002:a05:6a00:85a3:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7106da29926mr22346875b3a.7.1722951948526;
        Tue, 06 Aug 2024 06:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXjTyXs51jnjR9/RjTLvCCIFrptmDXVJRuIrd9w21T7YgzeIHDoifLFEORcsrnF11QNrW1jg==
X-Received: by 2002:a05:6a00:85a3:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7106da29926mr22346837b3a.7.1722951948018;
        Tue, 06 Aug 2024 06:45:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763562989sm7063427a12.34.2024.08.06.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:45:47 -0700 (PDT)
Date: Tue, 6 Aug 2024 21:45:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: add test for btrfstune squota enable/disable
Message-ID: <20240806134543.hbnyllmwokss5z4u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>

On Fri, Jul 12, 2024 at 11:52:36AM -0700, Boris Burkov wrote:
> btrfstune supports enabling simple quotas on a fleshed out filesystem
> (without adding owner refs) and clearing squotas entirely from a
> filesystem that ran under squotas (clearing the incompat bit)
> 
> Test that these operations work on a relatively complicated filesystem
> populated by fsstress while preserving fssum.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---

By checking the fstests@ mailing list, I found this patch was missed. As
Filipe has reviewed it, I'll add this patch to "patches-in-queue" branch
at first, then push it if no other review points. Sorry for this missing.

Thanks,
Zorro

> Changelog:
> v4:
> - redirected stdout of both btrfstune commands to .full file. Re-tested
>   on 1. correct progs (passes) and 2a. buggy progs with a leaked eb and
>   2b. buggy progs that hits a uptodatebuffer error while committing the
>   txn. Everything behaved as expected.
> v3:
> - switched btrfstune commands from '|| _fail' to filtered golden output.
>   Got rid of redirecting stderr to .full because some aberrant output
>   (like eb leaks) shows up in stderr and I think it is helpful to treat
>   those as errors.
> v2:
> - added needed requires invocations
> - made fsck and btrfstune command failures matter 
> 
> 
>  tests/btrfs/332     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/332.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/332
>  create mode 100644 tests/btrfs/332.out
> 
> diff --git a/tests/btrfs/332 b/tests/btrfs/332
> new file mode 100755
> index 000000000..7f2c2ff9c
> --- /dev/null
> +++ b/tests/btrfs/332
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/332
> +#
> +# Test tune enabling and removing squotas on a live filesystem
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +# Import common functions.
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_enable_simple_quota
> +_require_no_compress
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_fssum
> +_require_btrfs_dump_super
> +_require_btrfs_command inspect-internal dump-tree
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
> +	_notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-quota)"
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
> +	_notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-quota)"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# do some stuff
> +d1=$SCRATCH_MNT/d1
> +d2=$SCRATCH_MNT/d2
> +mkdir $d1
> +mkdir $d2
> +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> +
> +# enable squotas
> +_scratch_unmount
> +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full
> +_check_btrfs_filesystem $SCRATCH_DEV
> +_scratch_mount
> +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> +[ "$fssum_pre" == "$fssum_post" ] \
> +	|| echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
> +
> +# do some more stuff
> +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +_check_btrfs_filesystem $SCRATCH_DEV
> +
> +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full
> +_check_btrfs_filesystem $SCRATCH_DEV
> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE_QUOTA'
> +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUOTA' -e 'QGROUP'
> +
> +_scratch_mount
> +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +[ "$fssum_pre" == "$fssum_post" ] \
> +	|| echo "fssum $fssum_pre does not match $fssum_post after disabling squota"
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> new file mode 100644
> index 000000000..adb316136
> --- /dev/null
> +++ b/tests/btrfs/332.out
> @@ -0,0 +1,2 @@
> +QA output created by 332
> +Silence is golden
> -- 
> 2.45.2
> 
> 


