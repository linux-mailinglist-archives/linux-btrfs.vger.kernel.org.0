Return-Path: <linux-btrfs+bounces-19119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6CC6CCDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 06:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D77942B524
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035D30E0E7;
	Wed, 19 Nov 2025 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBK4qS2f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D521765B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530098; cv=none; b=HuRqkRx0b4GzO3F1gnQef4R8cZN8r+4FCR9RmPmQOHP1V8mfzgcFlkIdTVUPqK4q16UqAOl2aOyYMSeG3xA4QgvQ7sBM+BMjhUd1XTL+ZH1dAV0Q4sCrOzGdTqEjpgcR4lIm7/zDCIR762XhOHRab1G8QEtfDS5ym8/Oxgko/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530098; c=relaxed/simple;
	bh=hJO6m9RjbVYHsCF61QaRvX1qqaaK0NRgDI2oFuZmaag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpzxWUNMCqQbW/meHaGgtTVD6gFU1klMo/qOzqB+g0234FwKqVPPpVIJlJ0jnXrRrwH1lOp18CeQ+YyXiIsDWcpTtuvq9XrirOD//1yE2yEjZiaWhcAb9DrqC7xhwS6FeGaZ53QhH5oTmZZ6c5Bbg9JnfetVTPOnLtqvSEX2Vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBK4qS2f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298145fe27eso85342185ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 21:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763530096; x=1764134896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/moTquEdLk1bVa6y386cGDn3Tz+QN3S+IIzvr7irM4=;
        b=iBK4qS2fm6DblOHt7hJ/a1FEEYH3CGQbOFxzjcAdonWJVofMuraNid0TiRr78lMqCE
         wLPPOSylQnEJQmCBvks8ssxtv69Bboi0FEW0znyx/IusMYabAs74jSCIc43l5Xgjffz7
         XsDiD4MGIcUrNUiZjYv/zYTuXmjoY0ppbP1cEDdNzU2yHTbZYegtjshQq4vn0ArZGKba
         NH9VQdxym1EDJOOKIN6NWxRPuJZlmDVjfo9BfSeLCmN7vYUD0qAJ2+/VdPPiGHnYehlM
         ltpWDnXRjchlMwvZkGrB0fsn4N3bh2WYpgfCTjVLExCyigFZavtHh1tsfx8axlBFT0Kt
         LvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763530096; x=1764134896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/moTquEdLk1bVa6y386cGDn3Tz+QN3S+IIzvr7irM4=;
        b=nOdtUucjIaVmgre+MkCFYYlb9jJ6wDnJjYv+nCAVg7yi9Hlv3iCg0QGgYmkg+MGE7/
         1TcPIanuLvxw7IrFS90jSrwzQLOhEDtBTOuW5BM0woWTYSUq2ncW9DHYS/LXIT8UQ3Tp
         x+cEFPn7LjOPz1RnVloarw53c9dHDiz2c3K2SqsdUt2XQgFkuNlNZcRSxQYt/pXeTjBr
         owN82ywRLTGvsUnSTmAvuOn02dT/8PMr+Xy5UW/f4f+og6Ek3NlnwrI6XvqU9vh1akJK
         phKZMALHLAOKRd/mMkV46CPSGE72ecsan4KHNKVXoAh7cF/fs27OQ//pUZpG27g0XUHF
         mYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHCZ6NWK8+MODxWUOqXw+nDVDo8GQAuPTm+VbTQZY23hZV/cr1b7hsL5P9UDOshcNWglqNTpphe3WKog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aLgwGocCkm9SG2yucxVtC79V/5BenhcwYXeQ7WKGKtm36Vnb
	tyOWiVdosY1hvpEriCS8Z8IO7buw2GOlAwIe+KQ1NHyhrVN/UnA7yDuTbFQzgg==
X-Gm-Gg: ASbGncubMf3RxKWVwHbQ0V5flAoIepdpWwqcf5cOn5fWqnaicJ1Mg9eZB127mg+BiYR
	EdwBwGMWEcZIjIl8ueE6ivIhKCBs6DlB2MWbOtf2hdDwo7QOgBBR68yx4SmzwHbC7RpQQTfZXYa
	N408XCQFhlBWHzuYLbSRUt5CVq7m9Q0vWPQT12dUd3GRk7lQF9yfsKUaZ7A4gQF2CzHNDegwWoM
	KF7mgjR633v2Zzl4uIkBFX8x8Ne/WtmJaUM+X1JWZZyrXEEcZpkgSK6w8ugGQxvuXmH+6WHwY2L
	8PYfSWfpwPID6LqDXOo6/iCPapZGUJyhPyJx5gwqjqiluEfFs8xUTPw7F5x/NTgKfgAVuW94clR
	rq++Y1ZR9+rkewm9/dTEePFoTkJ9hRhmaQhviWpUnoGzSkvqJp+vPehaEHbMEGOWWFh3MjX13pQ
	pDypv0
X-Google-Smtp-Source: AGHT+IGn6aUPitlZ+ZQfy3JAGpYrp4d9qXro/j7LocAsUSdmXLEukjfCy/tH2vvyTAILz1OIzJbcIQ==
X-Received: by 2002:a17:902:ccc7:b0:295:888e:d204 with SMTP id d9443c01a7336-2986a76b5dbmr227495715ad.57.1763530096234;
        Tue, 18 Nov 2025 21:28:16 -0800 (PST)
Received: from sidong ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2c16a1sm192519875ad.95.2025.11.18.21.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 21:28:15 -0800 (PST)
Date: Wed, 19 Nov 2025 05:28:04 +0000
From: Sidong Yang <realwakka@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs/339: test receive dump stream for different
 user
Message-ID: <aR1VZNeaMtWoSetC@sidong>
References: <20251119024034.23861-1-realwakka@gmail.com>
 <c2e01ca2-6f1b-446f-a72b-1c1626c1e5ca@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2e01ca2-6f1b-446f-a72b-1c1626c1e5ca@gmx.com>

On Wed, Nov 19, 2025 at 02:05:57PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/11/19 13:10, Sidong Yang 写道:
> > Test receive to dump stream file from different user.
> > 
> > This is a regression test for the btrfs-progs commit cd933616d485
> > ("btrfs-progs: receive: don't use O_NOATIME to open stream for
> > dumping").
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
> >   tests/btrfs/339.out |  2 ++
> >   2 files changed, 34 insertions(+)
> >   create mode 100755 tests/btrfs/339
> >   create mode 100644 tests/btrfs/339.out
> > 
> > diff --git a/tests/btrfs/339 b/tests/btrfs/339
> > new file mode 100755
> > index 00000000..728f3d9d
> > --- /dev/null
> > +++ b/tests/btrfs/339
> > @@ -0,0 +1,32 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Sidong Yang.  All Rights Reserved.
> > +#
> > +# FS QA Test 339
> > +#
> > +# Test btrfs receive dump stream from different user
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send snapshot
> > +
> > +. ./common/filter
> > +. ./common/quota
> > +
> > +_require_scratch
> > +_require_user
> > +
> > +_fixed_by_git_commit btrfs-progs cd933616d485 \
> > +	"btrfs-progs: receive: don't use O_NOATIME to open stream for dumping"
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +$BTRFS_UTIL_PROG -q subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
> 
> If you are using "-q" to suppress non-critical messages, you don't need to
> do the _filter_scratch call.
> 
> It's better just to redirect all output to seqres.full without "-q".

Thanks, I'll use it.

> 
> > +$BTRFS_UTIL_PROG -q send -f stream $SCRATCH_MNT/snap
> 
> Furthermore, the stream file is at the current working directory, and if the
> test case is interrupted before "rm stream" call, the file will be left
> uncleaned.
> 
> Please use $tmp or some location inside $TEST_DIR to store the send stream,
> and have a proper cleanup function.

$tmp would be good to use.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > +chmod a+r stream
> > +_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f stream" >> $seqres.full
> > +rm stream
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +_exit 0
> > diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
> > new file mode 100644
> > index 00000000..293ea808
> > --- /dev/null
> > +++ b/tests/btrfs/339.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 339
> > +Silence is golden
> 

