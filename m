Return-Path: <linux-btrfs+bounces-9082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE39ABC2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 05:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1829284532
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B912EBE9;
	Wed, 23 Oct 2024 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtIfgfJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA44C3D0
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729654285; cv=none; b=RUOh2gEqvaKa+Lbx1u3a1UB0yo8Xps0xpOB+dD6yCCOhclAJPw4C3Fbtq9iAAS2HLEDhkOMmyX6FgbIz2MdWEaKjFDuMhliNpC4BnjIILuemvrGSUizLGASXV/a3FlpmLJwyoOPxhYj90hJuzZ9rGgtHPIlkOjqabpB7EaeS2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729654285; c=relaxed/simple;
	bh=lHuye/yPAGri6KcQCAc/7/ijs0MtfvV9833216vQGM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR1C3ZdP6VUjrQnQwpe8L8cfeweN1olNepKPrlkPAL+pjyFLOZCxDn4pvknQvKcRnssHTnAxh+kF+iJKkxInQqMaN/zGCh1l+LCaEXfGju1gtuOPHqbscvNerpN46uxSXulngTuIGsqMkJg9D3oQJL9LGXKTLXOK9RnCIS62SLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtIfgfJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729654283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ka79D+23BHXwETkT3vETyW64wVeFQaKZYsxP/xCDBqw=;
	b=JtIfgfJBuyc48KpA9AbMzW9yWQ5qJMIltPhfGkzJqkyAM1uiaJFfxEiHUCmXAaUx3FI00N
	1Lv5lkB520YSoHF3iuMF++EkZtgZyzrq87vO3Gafb+BGOF6GSDamsU75b3qW5KjhC+MFdA
	bdoYn9g7SbyWJUaMB6JgQ5JJp0blOZo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-wDFeFsKdO4yDGzNnrsHk3g-1; Tue, 22 Oct 2024 23:31:21 -0400
X-MC-Unique: wDFeFsKdO4yDGzNnrsHk3g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso5358807a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 20:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729654280; x=1730259080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka79D+23BHXwETkT3vETyW64wVeFQaKZYsxP/xCDBqw=;
        b=PjcSZLKRvooO3c+OIbgR8MwfOss+i0JKMgkXHj043MaS8OO5gOunJxzd92bjmVH/+a
         WDVzW+/vRv8TEAIApReqJRNF54DbIaRZ2J2QZXUcKmQB0j3XjCaJSj867v58ZjyJTcux
         zISnGDREiSdXi8kLW83dNPuQ3QC/xqQtUsWh2Th3iIQFErhmj1Isvf+t3K3tfu6Ae3H0
         +viBR7eheFr2jwRGG2a6zB3xWQpo2n1TwQrdWdl9Enk3pGUOUQ48firFPcBpkpd6WOKB
         coLMfael91O+ytJEju6faPizZSpgWafwq1Oki0KiOOPC13vuTIwtDXV/psSeY/LJvC7o
         yP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr8pfDBkI7DGfLvf5lQzVLMSK+32zZ+yLr7pB1qWZOZolJqm6ND749friihU/UapttHsKxMVr265MBNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNNiqDxX6R2TmEbABri4VyNJeZrDS38TQjZgSkP9Zhg23DnhA
	sgyUVDRS5rsK6tl16N5nla5qOeS39D01Tw3zuh8YDaHPvFG33SxW5tERy27DcgAryFKpJQjPHaj
	veO1NFOrq7eyyewrBu7b5JHwnmfKK2q5/0Z8JLm8TiVhzKee7avoscNw8njhrbLQROyZEk/E=
X-Received: by 2002:a05:6a21:1349:b0:1d9:1d2d:b656 with SMTP id adf61e73a8af0-1d978b14d28mr1399626637.15.1729654279963;
        Tue, 22 Oct 2024 20:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAOnJFG4Zct7QQbpZQmGSEafL9Fwiw+aJRF8apyJj467MpF47ejIg3d0wy8B8eROpbs8IXiQ==
X-Received: by 2002:a05:6a21:1349:b0:1d9:1d2d:b656 with SMTP id adf61e73a8af0-1d978b14d28mr1399613637.15.1729654279343;
        Tue, 22 Oct 2024 20:31:19 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f108d71sm49313845ad.304.2024.10.22.20.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:31:19 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:31:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Message-ID: <20241023033114.m6ulorsbv6rq2puo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241015153957.2099812-1-maharmstone@fb.com>
 <CAL3q7H4wLLTLi_sfKEQB8qsQ6G7VxWBfK_4FwSi4qL5Z3bkycQ@mail.gmail.com>
 <d94875db-0bed-4077-a2e7-915e7358c1db@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d94875db-0bed-4077-a2e7-915e7358c1db@meta.com>

On Fri, Oct 18, 2024 at 05:36:26PM +0000, Mark Harmstone wrote:
> On 16/10/24 12:09, Filipe Manana wrote:
> > > 
> > On Tue, Oct 15, 2024 at 4:42 PM Mark Harmstone <maharmstone@fb.com> wrote:
> >>
> >> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
> >> race could mean that csums weren't getting written to the log tree,
> >> leading to corruption when it was replayed.
> >>
> >> The patches to detect log this tree corruption are in btrfs-progs 6.11.
> > 
> > This shouldn't be needed right?
> > Because after log replay the csums are missing and 'btrfs check'
> > detects (IIRC) missing csums for extents referred by file extent items
> > in a subvolume tree - if it doesn't then it should be improved.
> 
> Yes, but we're not mounting it in the tests between the log_writes 
> calls, so the log isn't getting replayed. The patches to btrfs check 
> make it so that it identifies filesystems that would get corrupted as 
> soon as they're next mounted.
> 
> > 
> >>
> >> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> >> ---
> >> This is a genericized version of the test I originally proposed as
> >> btrfs/333.
> >>
> >>   tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
> >>   tests/generic/757.out |  2 ++
> >>   2 files changed, 73 insertions(+)
> >>   create mode 100755 tests/generic/757
> >>   create mode 100644 tests/generic/757.out
> >>
> >> diff --git a/tests/generic/757 b/tests/generic/757
> >> new file mode 100755
> >> index 00000000..6ad3d01e
> >> --- /dev/null
> >> +++ b/tests/generic/757
> >> @@ -0,0 +1,71 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +#
> >> +# FS QA Test 757
> >> +#
> >> +# Test async dio with fsync to test a btrfs bug where a race meant that csums
> >> +# weren't getting written to the log tree, causing corruptions on remount.
> >> +# This can be seen on subpage FSes on Linux 6.4.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick metadata log recoveryloop
> >> +
> >> +_fixed_by_kernel_commit e917ff56c8e7 \
> >> +       "btrfs: determine synchronous writers from bio or writeback control"
> > 
> > For generic tests what we do is:
> > 
> > [ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit .....
> > 
> > As long as the failure has not been observed and fixed on other filesystems.
> > In case one day a regression happens in another fs, we just add a
> > corresponding line using the same logic.
> > 
> > Otherwise if the test one days fails on another fs and fstests
> > suggests that that commit is missing, it would be odd.
> > 
> > Everything else looks good, so with that fixed (maybe Zorro can change
> > that when picking the patch):
> > 
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > 
> > Thanks.
> > 
> 
> Thanks Filipe. Zorro, let me know if you're happy making this change, or 
> otherwise I'll resubmit.

I can help to change that when I merge it. Thanks you and Filipe.

Thanks,
Zorro

> 
> Mark
> 
> 


