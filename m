Return-Path: <linux-btrfs+bounces-16454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEDCB387DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 18:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8716B4633B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7642D24B7;
	Wed, 27 Aug 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzAZ6xw+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050A26A095
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312809; cv=none; b=AnZ0bl+jnxg9t3lEBDlKBorJPz6/x8sGw6CNVf0Duvldl7yUklB7rbyA+MLtaJqB5rmCFQ4xnFiAfiZ0kFnnZR7pD79HMlX9zqjbhFWWN20sLPsz7GzvkynG3ZrY4tJISUzdDDrbRCEFeNehrMjx3UHxCQF1ISptIHMhSk+ymf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312809; c=relaxed/simple;
	bh=3DyqViW9SnsZpYfArz4gNl8m4ECPoFoV6uIDCOz6k4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r10SQfBY7NeSkBlfOQNA6sKcbVHel30wWO2c+ZKE1VrzvVvqtpZf9tKPwmbdwa5lwwmXHdrGpqWX9GJLECGdZYucFpDf3lDwYVTqut6TOksRYVVJSP/bItw1qhxVsM9MaWYdERS6o8W+B0whAYF2e0tjoqFdVOzHRqpOgf/dDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzAZ6xw+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756312806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dX9VvPl9xyx3qg69IKipIupVW77+weRrThJTx756bsw=;
	b=YzAZ6xw+hE78Mjc9OeXE+/UgRgjPPt32n64ji82y8GwLr3afbEK9pqWwJ9QZUjxuRnrdr0
	dAyA48ImRvChH4TSYWrcQDcOvI3RQKjVk/tyCclCsHE6A4pqisA1UkoSdlo9gRLed3zceY
	VCIyG3t3tOqD9SDxDurCnbf9TDbm0XM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-lRKnk7gEPQmw8vIJkU-hSA-1; Wed, 27 Aug 2025 12:40:04 -0400
X-MC-Unique: lRKnk7gEPQmw8vIJkU-hSA-1
X-Mimecast-MFC-AGG-ID: lRKnk7gEPQmw8vIJkU-hSA_1756312803
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e2f5b5dcso93281b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 09:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756312803; x=1756917603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX9VvPl9xyx3qg69IKipIupVW77+weRrThJTx756bsw=;
        b=guXpv5byM/7chUyCfZSkSuY7JBlK4pS5hyu4rDcAdyzpRak1nyLpXkl+rKcf3Oh/2x
         S0cwc1478t7c9b/tZgaQ8UwlnCdDv2NI5w1xEr8dUOw6PenL5tX9VUcA9AA6BPHe17h7
         3u2PLbd4I5yZ2XgCSahNDqFYBc2WFuYlnObKu61rqD3RjdsTfHMN2WMZm9cGdhbSYu05
         nYT2SnErfCWesQGcx7G7CKbAkuX3NGnwAr8yMu6MPVVF6ohMbZZZcdzuJJwYJ+lhQ9An
         ASpLi1d/bCyMxtowznRll/CZXo6UgM2x/wumIDgt9HikIVQTBUDSo6DvjgseRMARakxu
         yCPw==
X-Gm-Message-State: AOJu0YyZrmP2AmyOLetwL1n86YotQyYS3qpL15/5KIQGea8eFcrS2ulP
	vez6uzbNz4EuJiY9x0D90qCNu2EpkDwW0IIlD9zz0Y3pEHnaQ+aIIY5KN4ew/dfk3U6XvvPAKIK
	5OGyUWaaZ+o4IPfyc7pjtnsC/4l0lDjL7jlFNm7o5lTPlR8r9fyA2UBSlFVdDxKwC
X-Gm-Gg: ASbGncukKJqAVRU6PdMs4rHqD4/OFDZKWxjQj9D0kUM/azfrUtIcdZ6ErPu8m273C+B
	Z3CwFcpeAKb8f32HagWm728KZfUYp4Usv6Vs37c/PFrGFd8VV5K/mAjen5IzpjxUJJftsk6NcxZ
	YRFcUfZiiZ93R4Uj4ye2pEXgui2EUI/OlEHm5Ic5ZwIpNLUpeqvf2UY/d7NcHvouLLAD38glk7L
	71iVtEzdM1I3L3JzD7mOe2SE8gYD4ZSAxfztKCc/vqZCnx1VTW0bnfaRCHtF2DyauWe7KX90ppF
	8JEZtJmpBtSvzmpnKpjVt3d78+/LeYfn1J1wTRJTKAWiaXPMR399+ToOT+95oXaaNkNz/Uv0pip
	ESSEt
X-Received: by 2002:a05:6a00:a22:b0:76e:3545:d64b with SMTP id d2e1a72fcca58-7702f9f094cmr25870319b3a.8.1756312803066;
        Wed, 27 Aug 2025 09:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvyTNoiSmHafTjwaeVDRFo0b8zO2Q9T0YV3zu+AFT0kujXDeMnVY0rcr4pZZzYr/3Fhb9UFQ==
X-Received: by 2002:a05:6a00:a22:b0:76e:3545:d64b with SMTP id d2e1a72fcca58-7702f9f094cmr25870285b3a.8.1756312802547;
        Wed, 27 Aug 2025 09:40:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771eaa6792dsm7810711b3a.48.2025.08.27.09.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:40:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 00:39:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: add a new test case to verify
 compressed read
Message-ID: <20250827163958.oarsi5vriw65aetp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250827014250.170552-1-wqu@suse.com>
 <20250827163010.wli3kz2nfmvl3w4a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827163010.wli3kz2nfmvl3w4a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Aug 28, 2025 at 12:30:10AM +0800, Zorro Lang wrote:
> On Wed, Aug 27, 2025 at 11:12:50AM +0930, Qu Wenruo wrote:
> > The new test case is a regression test related to the block size < page
> > size handling of compressed read.
> > 
> > The test case will only be triggered with 64K page size and 4K btrfs
> > block size.
> > I'm using aarch64 with 64K page size to trigger the regression.
> > 
> > The test case will create the following file layout:
> > 
> >   base:
> >   [0, 64K): Single compressed data extent at bytenr X.
> > 
> >   new:
> >   [0, 32K): Reflinked from base [32K, 64K)
> >   [32K, 60K): Reflinked from base [0, 28K)
> >   [60K, 64K): New 4K write
> > 
> >   The range [0, 32K) and [32K, 64K) are pointing to the same compressed
> >   data.
> > 
> >   The last 4K write is a special workaround. It is a block aligned
> >   write, thus it will create the folio but without reading out the
> >   remaing part.
> > 
> >   This is to avoid readahead path, which has the proper fix.
> >   We want single folio read without readahead.
> > 
> > Then output the file "new" just after the last 4K write, then cycle
> > mount and output the content again.
> > 
> > For patched kernel, or with 4K page sized system, the test will pass,
> > the resulted content will not change during mount cycles.
> > 
> > For unpatched kernel and with 64K page size, the test will fail, the
> > content after the write will be incorrect (the range [32K, 60K) will be
> > zero), but after a mount cycle the content is correct again.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v3:
> > - Fix the golden output which is generated by an unpatched kernel
> > 
> > v2:
> > - Remove the unnecessary sync inherited from the kernel fix
> > - Use _hexdump instead of open-coded od dumps
> > - Use the correct 'clone' group instead of 'reflink'
> > - Minor grammar fixes
> >   All thanks to Filipe.
> > ---
> 
> Hi Qu,
> 
> This patch is good to me, just a few picky points below:
> 
> >  tests/btrfs/337     | 55 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/337.out | 23 +++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> >  create mode 100755 tests/btrfs/337
> >  create mode 100644 tests/btrfs/337.out
> > 
> > diff --git a/tests/btrfs/337 b/tests/btrfs/337
> > new file mode 100755
> > index 00000000..9c409e4d
> > --- /dev/null
> > +++ b/tests/btrfs/337
> > @@ -0,0 +1,55 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test 337
> > +#
> > +# Test compressed read with shared extents, especially for bs < ps cases.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick compress clone
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +	"btrfs: fix corruption reading compressed range when block size is smaller than page size"
> > +
> > +. ./common/filter
> 
> Looks like you didn't use any helpers of common/filter in this case :)
> 
> > +. ./common/reflink
> > +
> > +_require_btrfs_support_sectorsize 4096
> > +_require_scratch_reflink
> > +
> > +# The layout used in the test case is all 4K based, and can only be reproduced
> > +# with page size larger than 4K.
> > +_scratch_mkfs -s 4k >> $seqres.full
> 
>  || _fail "...."
> 
> Fail the test if the mkfs fails.
> 
> > +_scratch_mount "-o compress"
> > +
> > +# Create the reflink source, which must be a compressed extent.
> > +$XFS_IO_PROG -f -c "pwrite -S 0x0f 0 32K" \
> > +		-c "pwrite -S 0xf0 32K 32K" \
> > +		$SCRATCH_MNT/base >> $seqres.full
> > +echo "Reflink source:"
> > +_hexdump $SCRATCH_MNT/base
> > +
> > +# Create the reflink dest, which reverses the order of the two 32K ranges.
> > +#
> > +# And do a further aligned write into the last block.
> > +# This write is to make sure the folio exists in filemap, so that we won't go
> > +# through the readahead path (which has the proper handling) for the folio.
> > +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/base 32K 0 32K" \
> > +		-c "reflink $SCRATCH_MNT/base 0 32K 32K" \
> > +		-c "pwrite 60K 4K" $SCRATCH_MNT/new >> $seqres.full
> > +
> > +# This will result an incorrect output for unpatched kernel.
> > +# The range [32K, 60K) will be zero due to incorrectly merged compressed read.
> > +echo "Before mount cycle:"
> > +_hexdump $SCRATCH_MNT/new
> > +
> > +_scratch_cycle_mount
> > +
> > +# This will go through readahead path, which has the proper handling, thus give
> > +# the correct content.
> > +echo "After mount cycle:"
> > +_hexdump $SCRATCH_MNT/new
> > +
> > +status=0
>    ^^^
> "_exit 0" does "status=0", so you can save this line.
> 
> Others looks good to me, with above changes:
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

These're simple enough changes, I've helped to change them, you don't need to
send one more version (except you hope to change more, please tell me :)

Thanks,
Zorro

> 
> > +_exit 0
> > diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> > new file mode 100644
> > index 00000000..cecbbbcf
> > --- /dev/null
> > +++ b/tests/btrfs/337.out
> > @@ -0,0 +1,23 @@
> > +QA output created by 337
> > +Reflink source:
> > +000000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> > +*
> > +008000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> > +*
> > +010000
> > +Before mount cycle:
> > +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> > +*
> > +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> > +*
> > +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > +*
> > +010000
> > +After mount cycle:
> > +000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
> > +*
> > +008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
> > +*
> > +00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > +*
> > +010000
> > -- 
> > 2.49.0
> > 
> > 


