Return-Path: <linux-btrfs+bounces-2736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD7862B4D
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C71B20F42
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A971758E;
	Sun, 25 Feb 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEHHFyBd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B651643A
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876431; cv=none; b=HXvTEUSy1+cmRC/zXPxGp7wLVcg8UFGI6zjxBBRAllTblcbMcgnLWR4zWL+olp/7w+LFXbh15T9HMbSHj2WT2vUloQj9R/DI1qp7fWVHvKf82pvoCZ0jZhmLFB0cLJU4ZN3ZE8PEWeD480XjSQZlcOk0uMH06slBbfxWeNbW9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876431; c=relaxed/simple;
	bh=dGKfEgI4uQGIUphF5KwuvJ3kPWzHhT5gQJ6IXjaC79E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJq1hTEwgy46qgVfreU+ESYvcA2/HYA/DhdZSJ2yG5v7gksgHCZOYWrVfhN9stqNlC+1slQvO0lnZdwPgJYRoqCoKezoXzIl2TKT9grlfmezfOCkCIYLJLyG6NayKgvmKMGiRzBZuf9ouIFdzDneIrGcKp9RsPDhLT+yA/ETzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEHHFyBd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708876428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=99B0rowVwJJjMFnxcFeFBY1xvNAOcFSS03jBJSy/yZs=;
	b=aEHHFyBdyi7NGD1rwRrijYjLpyOZ2Wg5BDfBajrjvAvX7Y/hwqEtXtnznUGKLtAyEKaHaQ
	KpXd+114I6vbRoUOhFFEQ/RVX5j0R6Lu7YnImM2kv1xUKZClHqbSmXV6nLMS0B8gm2LwBW
	Z4GeoRe7YHNZ6BjdSPNzTkYayURRA6Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-ZC0gMYAvO2-OOfxcybHY_Q-1; Sun, 25 Feb 2024 10:53:45 -0500
X-MC-Unique: ZC0gMYAvO2-OOfxcybHY_Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29935047600so1976733a91.0
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 07:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708876424; x=1709481224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99B0rowVwJJjMFnxcFeFBY1xvNAOcFSS03jBJSy/yZs=;
        b=N1N02xxJWicBJ0qkp4KZEYwyMGFs3tVMlFX5s2DTSUfU099e0nupWch4URiU979/cG
         xlsTWHli4R2EwG0+4lrhZYkp3B4y05DDzb0O1wGZRCBDhvTZR3LewJZj3RZzsrtcu9gq
         zJEZ0rL8FSb3lRyTnZLNmDL2Fo8rbAPAmtcElI0/31UF5Wxi3V5vvbgGWuLF3FG9CX6R
         qGI1uRlFepq7OCV6LFFadHOTG/2WQG7bNIyWYhMb8jYou4bvc8rzsgkWwNc4+SM3PwTO
         PbwvKKLadEdRqXqIYiKeejo9Kh8rmDlcYtQSeCt9ghaIRMLvIM5rCGz0EayLOIrtAsfH
         xGvw==
X-Forwarded-Encrypted: i=1; AJvYcCXkTHpqB5lRjHwC/tKi6Bll5lCPEp5HSC8FeENKmVWLlsKAouVFy931V6MDDrLvxhAJ6zlem9Zy29xR8FXgZ5tz83XvVW55R+ziAxE=
X-Gm-Message-State: AOJu0YytG3hTV8KDxEGdMqKrD0qwnlzzfoyBoViSk5wFkEytVb8m0eRu
	1CsNNlBG6ATcjk/cToqDu0cfjIOcSidlwmBGdDiCN+1dQykXvwy1DeOymxb/UurQt6NgXFZBtwG
	6sl6Kf7heof4tcjc0h+INzaFrnFNVNR5XtCDiKNRTSKnIzu4+9Wa8qIJVtNrO
X-Received: by 2002:a17:90a:6d88:b0:299:2b9a:88bc with SMTP id a8-20020a17090a6d8800b002992b9a88bcmr3698095pjk.37.1708876424423;
        Sun, 25 Feb 2024 07:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCL5Ei6/rDqcXb5NrE2CkDWn8q2M/2b/TGwBFAH68RPjEEl9aNqkQYwMX9SaxrIepu6P5cjQ==
X-Received: by 2002:a17:90a:6d88:b0:299:2b9a:88bc with SMTP id a8-20020a17090a6d8800b002992b9a88bcmr3698082pjk.37.1708876424068;
        Sun, 25 Feb 2024 07:53:44 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090a9b1500b0029a45b28d43sm2810432pjp.14.2024.02.25.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:53:43 -0800 (PST)
Date: Sun, 25 Feb 2024 23:53:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] fstests: btrfs: add a test case to make sure
 inconsitent qgroup won't leak reserved data space
Message-ID: <20240225155339.dg3vrmvkvowirmiw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240223093547.150915-1-wqu@suse.com>
 <12c20a26-5632-4c53-a011-7e74a781724b@oracle.com>
 <ded4aab0-1bf7-43d2-8a19-12197fe19f88@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ded4aab0-1bf7-43d2-8a19-12197fe19f88@suse.com>

On Sat, Feb 24, 2024 at 06:21:44AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/2/24 03:37, Anand Jain 写道:
> > On 2/23/24 15:05, Qu Wenruo wrote:
> > > There is a kernel regression caused by commit e15e9f43c7ca ("btrfs:
> > > introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup
> > > accounting"), where if qgroup is inconsistent (not that hard to trigger)
> > > btrfs would leak its qgroup data reserved space, and cause a warning at
> > > unmount time.
> > > 
> > > The test case would verify the behavior by:
> > > 
> > > - Enable qgroup first
> > > 
> > > - Intentionally mark qgroup inconsistent
> > >    This is done by taking a snapshot and assign it to a higher level
> > >    qgroup, meanwhile the source has no higher level qgroup.
> > > 
> > > - Trigger a large enough write to cause qgroup data space leak
> > > 
> > > - Unmount and check the dmesg for the qgroup rsv leak warning
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > 
> > looks good.
> > 
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Thanks for the review.
> 
> > 
> > 
> > Queued for the upcoming pull request.
> 
> So for the btrfs fstests part, you'll do the pull request to upstream
> fstests, right?

Anand helps to merge some complicated btrfs patches, he'll help to give
it more reviewing and testing on btrfs side. Thanks for his help. Some
small changes for btrfs might be merged by me directly for quick
response/fix.

> 
> In that case, if we have some conflicting test case number, how do we
> resolve it?
> 
> It would be resolved by you or the author would be notified and need a
> resend?

Don't worry, that would be resolved by maintainer, to avoid you always need
to resend a patch only for changing a case number :)

> 
> And do we have a branch to base our new test cases upon? (Mostly to avoid
> the number conflicting)

Sometimes it's hard to make sure the final case number before release.

If you need, I can provide a branch for "patches wating for pushing", but
that branch might be unstable, and might be removed & recreated sometimes.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > Thanks, Anand
> > 
> > > ---
> > >   tests/btrfs/303     | 59 +++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/303.out |  2 ++
> > >   2 files changed, 61 insertions(+)
> > >   create mode 100755 tests/btrfs/303
> > >   create mode 100644 tests/btrfs/303.out
> > > ---
> > > Changelog:
> > > v2:
> > > - Fix various spelling errors
> > > 
> > > - Remove a copied _fixed_by_kernel_commit line
> > >    Which was used to align the number of 'x', but forgot to remove
> > > 
> > > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > > new file mode 100755
> > > index 00000000..9f7605ab
> > > --- /dev/null
> > > +++ b/tests/btrfs/303
> > > @@ -0,0 +1,59 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 303
> > > +#
> > > +# Make sure btrfs qgroup won't leak its reserved data space if qgroup is
> > > +# marked inconsistent.
> > > +#
> > > +# This exercises a regression introduced in v6.1 kernel by the
> > > following commit:
> > > +#
> > > +# e15e9f43c7ca ("btrfs: introduce
> > > BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick qgroup
> > > +
> > > +_supported_fs btrfs
> > > +_require_scratch
> > > +
> > > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +    "btrfs: qgroup: always free reserved space for extent records"
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount
> > > +
> > > +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> > > +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> > > +
> > > +$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
> > > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
> > > +
> > > +# This would mark qgroup inconsistent, as the snapshot belongs to a
> > > different
> > > +# higher level qgroup, we have to do full rescan on both source and
> > > snapshot.
> > > +# This can be very slow for large subvolumes, so btrfs only marks qgroup
> > > +# inconsistent and let users to determine when to do a full rescan
> > > +$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/subv1
> > > $SCRATCH_MNT/snap1 >> $seqres.full
> > > +
> > > +# This write would lead to a qgroup extent record holding the
> > > reserved 128K.
> > > +# And for unpatched kernels, the reserved space would not be freed
> > > properly
> > > +# due to qgroup is inconsistent.
> > > +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/foobar >> $seqres.full
> > > +
> > > +# The qgroup leak detection is only triggered at unmount time.
> > > +_scratch_unmount
> > > +
> > > +# Check the dmesg warning for data rsv leak.
> > > +#
> > > +# If CONFIG_BTRFS_DEBUG is enabled, we would have a kernel warning with
> > > +# backtrace, but for release builds, it's just a warning line.
> > > +# So here we manually check the warning message.
> > > +if _dmesg_since_test_start | grep -q "leak"; then
> > > +    _fail "qgroup data reserved space leaked"
> > > +fi
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> > > new file mode 100644
> > > index 00000000..d48808e6
> > > --- /dev/null
> > > +++ b/tests/btrfs/303.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 303
> > > +Silence is golden
> > 
> 


