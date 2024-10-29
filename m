Return-Path: <linux-btrfs+bounces-9200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10339B4243
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 07:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9923328378C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 06:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B220125C;
	Tue, 29 Oct 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="METqrzLD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C9201246
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182612; cv=none; b=o+/isiW61QWOH9MTyiCXWnqBrswX+bFu8IuiZFqkgLQW+L6rr3Tj959mgr4jdh59D4MOyaoNmyoAorzMCcvarky/Vp7dgCPoaq1Ebe6Z8U31ZZkYpO1wcwkXKZIjig9QJT+kLwPBkWhj0Bh0ChyI0h6EnYt47pj/TTMwi8afqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182612; c=relaxed/simple;
	bh=XrmeIbjHbnjuaUwQoNA/YbY499+ndPeQJjspgVyiRpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHMuUtFoC8sSK68i1FLtvdZRO43kg110yrMMidwKRh+zml9qPbqjE2nf3svV0idykPm9iE3ZUpnBaeDpQVP6956eaSUqhfcej0k9MhNFXzX0B1P577WdGCWdRp47++9lDM6tcb0q4TqlC9vv8M5v0h9FR2lHOcD4DgtEc9F/fbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=METqrzLD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730182609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Or3+CxHdnioWL/qi6wXUXvbnWL0KyBWluBUWDiViLJA=;
	b=METqrzLDJJ/4wjkSZqr2DzkJjwD9C26lxdnfPhdRQip/JyL8/It6NIugMZmHLOFIyb6rLd
	3mkzQVonSyPEuLJt66EPj8mAbsjzj1C5jxFk1JJoSzemT1b60GPBar0AxbpWevhBcMN7py
	E7onvIE9qMJuvqEc6c5QI8c9/hWO+RM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-s7tV46nKPVS_QP2N5Lmrcw-1; Tue, 29 Oct 2024 02:16:47 -0400
X-MC-Unique: s7tV46nKPVS_QP2N5Lmrcw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2e146c77cso6348159a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 23:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730182606; x=1730787406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Or3+CxHdnioWL/qi6wXUXvbnWL0KyBWluBUWDiViLJA=;
        b=jHo8ikfx9cCi+VAv3Ydq1vGwqxYw0EHFAei/OOhBNkhlKf1MIuRd143F5E7SC9+G27
         Ooby9JplMMtRisg7SYYyJdVkgWpaY0htMvVix3pqjQ1R2X4FTjPOHyBlfHbUfUNqqX+o
         3GIbBWHb7xlHvC9xc27Xs1TnixL4GOwYG6qsdtD4CmudXpKvOQ2/XF823ItiRKQGQZWk
         8r5SEMmVVVdrvxjo45mqCZ5Ury4hxVrJYExJhkJgkEJLd26OG/Cxobrs87xu3M8wA2sP
         ZfTz/3B1q6L3jXn1WkV0zDTzuo3PhpF3PuEowyviIhkzc2u9MzMXRP4tUVrjlDtaoFi6
         R1pw==
X-Forwarded-Encrypted: i=1; AJvYcCU+mQU+KXBkTEPsF4OgEI75hVDcJMHbTjIc56oAEkomnV6lR7Vt2VcwxFn5loeAx1ruS6GBB44t8XEq6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74ThmsGSQ8u3q4g8XItCMXeKnMwXqcWFc2zoY/bfJIMGJbrs1
	kmD/FSgog/yEok83VVqeY8lyCFLdshyJ4ZYg0hgNKEjsi/oj7LoLrtPGwI2FFMA6YvORUGh+myS
	VDAs2fFRnRnQIKfoS45KsPwPymHdff+/dUtvA2UYBTDBCUkWCOn/bdFPow8Gk
X-Received: by 2002:a17:90b:17cb:b0:2e2:cc47:ce1a with SMTP id 98e67ed59e1d1-2e8f104ec26mr14407869a91.1.1730182606282;
        Mon, 28 Oct 2024 23:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWIvLNo2JBvAu4HMlptuic4O2nf6gBjOH4r4QTrT6sy9OT17UxChmQ7zEIcRSnldJbOuOzoQ==
X-Received: by 2002:a17:90b:17cb:b0:2e2:cc47:ce1a with SMTP id 98e67ed59e1d1-2e8f104ec26mr14407856a91.1.1730182605939;
        Mon, 28 Oct 2024 23:16:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771814sm8481218a91.52.2024.10.28.23.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:16:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:16:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/366: add a new test case to verify
 if certain fio load will hang the filesystem
Message-ID: <20241029061642.xehxncr42utyd4oy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241028233525.30973-1-wqu@suse.com>
 <20241029055639.hskowarhtrowgiwe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <b78d9fe5-f9c9-4235-b748-78153ef28f20@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b78d9fe5-f9c9-4235-b748-78153ef28f20@gmx.com>

On Tue, Oct 29, 2024 at 04:33:52PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/29 16:26, Zorro Lang 写道:
> > On Tue, Oct 29, 2024 at 10:05:25AM +1030, Qu Wenruo wrote:
> [...]
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> >                              ^^
> >                              rw
> > 
> > I think we can keep the "rw" group as g/095 does.
> 
> If that's the only missing part, mind to add that rw group when merging?
> 
> The remaining two points may not need modification, explained inlined.
> 
> > > +	# Now read is triggered on that folio.
> > > +	# Btrfs will need to wait for any existing ordered extents in the folio range,
> > > +	# that wait will also trigger writeback if the folio is dirty.
> > > +	# That writeback will happen for range [48K, 64K), but since the whole folio
> > > +	# is locked for read, writeback will also try to lock the same folio, causing
> > > +	# a deadlock.
> > > +	$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
> > 
> > Looks like this test doesn't mix DIO and buffered IO, so this EIO ignoring might not be
> > needed.
> 
> I'm not sure about the EIO part, but at least job2 and job3 are all
> doing writes, one is buffered and the other is direct.
> So it's still mixing both.
> 
> > 
> > > +	# umount before checking dmesg in case umount triggers any WARNING or Oops
> > > +	_scratch_unmount
> > > +
> > > +	_check_dmesg _filter_aiodio_dmesg
> > 
> > This test removed mmap test part, so this dmesg filter might not be needed either ?
> > If so, don't need to import above "./common/filter" either.
> 
> Since it's still mixing buffered and direct IO, I can hit the aiodio
> error message just like this:
> 
> [91619.077752] BTRFS warning (device dm-2): read-write for sector size
> 4096 with page size 65536 is experimental
> [91619.086204] BTRFS info (device dm-2): checking UUID tree
> [91619.473510] Page cache invalidation failure on direct I/O.  Possible
> data corruption due to collision with buffered I/O!
> 
> So I'm afraid we need the filter too.

Oh, thanks for your confirming. I can merge this patch with that tiny change. If there's
not more review points from btrfs list, I'll merge it. It looks good to me now.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks,
> Qu
> 
> > 
> > Others looks good to me.
> > 
> > Thanks,
> > Zorro
> > 
> > > +
> > > +	echo "=== fio $i/$iterations ===" >> $seqres.full
> > > +	cat $fio_out >> $seqres.full
> > > +done
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/366.out b/tests/generic/366.out
> > > new file mode 100644
> > > index 00000000..1fe90e06
> > > --- /dev/null
> > > +++ b/tests/generic/366.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 366
> > > +Silence is golden
> > > --
> > > 2.46.0
> > > 
> > > 
> > 
> > 
> 


