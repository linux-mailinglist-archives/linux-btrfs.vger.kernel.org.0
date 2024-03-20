Return-Path: <linux-btrfs+bounces-3475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA348813F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F36A1C22BE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E104AECF;
	Wed, 20 Mar 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KGvp75dB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE9482D8
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946786; cv=none; b=sgwpM1Kv5eqJkaZ5fjt7MdZSJdX9BqSZbuRDpVLgZyDmqew9ClXLfhnRMPth1ojdXFQ4S0T06ctShWFDch/pPHm6fX7Dr8UusFDQA1Xaw2ASjdUWbHJsPE0PHsVhX0/m+WSmy5ZMqisvJrS2CJGyACGVDiSTjLZTY4CnPFb4pM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946786; c=relaxed/simple;
	bh=h21dVuyNVfTNxshX0y44q1WoJE9/g2XJg21dr2VXt1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNNB9QjfS/tsGTMCzECpCJ126d+Onayx7DhMNr53T0f5c7AGg27vheSqixx47XYFfs+ROUv9b+GNJsBNL1L/H04Gv/zAQVejSgIYwKfVO4MmEIgX+jihA3lqAgmstHfGNRj5E2Ehaw7CtB36zxBnmvAwUobUa+KFZhQSh/dOcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KGvp75dB; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607c5679842so74010047b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710946783; x=1711551583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OaLfQuD/RFNvrlkL0TXrzelPsLSljoHmWGFGdVJgfII=;
        b=KGvp75dBS/ZBPsNB+goeGhKMi1LJh0rqTW/PClLa6qFz8/AMVvlvijpoCUOmGoRmtb
         GsOSBcvQJJr6EsSfdCyVNKxrDSNUovv5fdsI+5eWZ0AfWagf/Y6w+Y0Q5NjB2ukeoAWd
         Q3ADiQ2MPieIQqMJoFp/JYf88L/33sXmhIUUhnWKEQ2Q2TkMb7QMvFq1pDIKbbPARecr
         QGp8W+CLP+oMpKYT0/W2T92G+ommwHTIEia1v2hjnNgzcHEMY1EwsfZH6KCDs0jnIo6O
         y+MZHSrSskGIKL15LmmpKj+0uWIF3kNmLKO5tReRd8lEZ8I9V5/IRSPfdX5htSokb+Ba
         MCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946783; x=1711551583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaLfQuD/RFNvrlkL0TXrzelPsLSljoHmWGFGdVJgfII=;
        b=rXqAtWT9MN5eSALw0gSuKyhdAGmMhUoEpj/6ACPAzmTO4vd/elaoCMm7U5bzyTSUfw
         io12veP/nt7mxovv1FQ6leIp2FCitPdoxt2/xc0/RHyAY6G3c8Sm01grDcmggWUVpm41
         vFFQ0vEjvgAtVgzal7edPkppLhpOay6acuWMG0gops4txrwnjwJlqd2wTJQv2rmuPMVF
         j2Ik/IviYgTN1QWaWBUenfB5LETi/iF+i5ghG8VMdZGY9ArB0J2hKjm4WWFQf6NQRJ0S
         EmrghHuty/uJRmxODRKwLu/p5U3lBtIDgMvap4Ww0xMvYBctLtNcEbdoJyaqu8qzg5Sh
         A4mg==
X-Forwarded-Encrypted: i=1; AJvYcCUNQ3/nza0Qt5RWOyfXiw36xNJKJx8JAoNjVU16xnMqC+TmCON9HPHtLK/xHWOj9GWLPFqvg7e4Yegacmd4xx8xHqZ+HoLUc1pcUO8=
X-Gm-Message-State: AOJu0YzpPsr/vwm4+YvbfA8BJcPD1Vi+836h6KUvy9ZInEYMoAOfE3+p
	6w67yyjdxUzRmJov6A8JUYOzdGePjyPivR+BA2cRuNTvOB6eRKF6WJ9n1+oi0v/36srZ05sSy0c
	5
X-Google-Smtp-Source: AGHT+IHKiq3fb8pd30iGz2G/+xyd0suwqzfLoUXk6KZ4kMpmBz/3c/gyBY5wDRO4JwMKv3QJTm6U5g==
X-Received: by 2002:a0d:f744:0:b0:609:fad9:1faa with SMTP id h65-20020a0df744000000b00609fad91faamr2249288ywf.40.1710946783240;
        Wed, 20 Mar 2024 07:59:43 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fg14-20020a05622a580e00b00430bddc75a5sm5254090qtb.23.2024.03.20.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:59:42 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:59:42 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: add a regression test for fiemap into an
 mmap range
Message-ID: <20240320145942.GB3091349@perftesting>
References: <b8160b6dbaf4899ff95928a7af006a126baa8f9c.1707756045.git.josef@toxicpanda.com>
 <20240313154851.zvawwfmoufhdwtel@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154851.zvawwfmoufhdwtel@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Wed, Mar 13, 2024 at 11:48:51PM +0800, Zorro Lang wrote:
> On Mon, Feb 12, 2024 at 11:41:14AM -0500, Josef Bacik wrote:
> > Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> > using that as the buffer for fiemap.  This test adds a c program to do
> > this, and the fstest creates a large enough file and then runs the
> > reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> > we pass fine.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v1->v2:
> > - Add the fiemap group to the test.
> > - Actually include the reproducer helper program.
> 
> Looks like this patch is missed (except the author changed the patch subject:),
> correct me if I'm wrong. The last review point hoped to add "src/fiemap-fault"
> to .gitignore.
> 
> > 
> >  src/Makefile          |  2 +-
> >  src/fiemap-fault.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/740     | 41 ++++++++++++++++++++++++
> >  tests/generic/740.out |  2 ++
> >  4 files changed, 117 insertions(+), 1 deletion(-)
> >  create mode 100644 src/fiemap-fault.c
> >  create mode 100644 tests/generic/740
> >  create mode 100644 tests/generic/740.out
> > 
> 
> [snip]
> 
> > diff --git a/tests/generic/740 b/tests/generic/740
> > new file mode 100644
> > index 00000000..30ace1dd
> > --- /dev/null
> > +++ b/tests/generic/740
> > @@ -0,0 +1,41 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 708
> > +#
> > +# Test fiemap into an mmaped buffer of the same file
> > +#
> > +# Create a reasonably large file, then run a program which mmaps it and uses
> > +# that as a buffer for an fiemap call.  This is a regression test for btrfs
> > +# where we used to hold a lock for the duration of the fiemap call which would
> > +# result in a deadlock if we page faulted.
> > +#
> > +. ./common/preamble
> > +_begin_fstest quick auto fiemap
> > +[ $FSTYP == "btrfs" ] && \
> > +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> 
> This commit id is "b0ad381fa769" now.
> 
> > +		"btrfs: fix deadlock with fiemap and extent locking"
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_odirect
> > +_require_test_program fiemap-fault
> > +dst=$TEST_DIR/fiemap-fault-$seq
> > +
> > +echo "Silence is golden"
> > +
> > +for i in $(seq 0 2 1000)
> > +do
> > +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> > +done
> 
> _require_sparse_files ?
> 

This is the only comment I didn't incorporate, I'm not looking for sparse files,
I'm just looking for a lot of extents.  If smb fills in the holes I suppose this
will only be a problem if it fills them in contiguously, but it'll just create a
4gib file instead of a 2gib file.  Thanks,

Josef

