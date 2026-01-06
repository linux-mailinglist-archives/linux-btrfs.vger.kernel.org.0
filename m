Return-Path: <linux-btrfs+bounces-20149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF6CF8289
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 12:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71C4730124E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBF219A8E;
	Tue,  6 Jan 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e45fRE7E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7DFt+dT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC517DA66
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700408; cv=none; b=gq5goH2/9mlNlUbbOQ97aZ779OyEvgcaXBmS+nBEvGGvAbJIRu5reKDeLiMX1PEDc0xDN3ENvcPXhkO83f3V68lDPmlQo8ZyFb83UTsuh98fDXFdS4QwBFkLxrPslsW6AUBZXtgpblbiRo2sZMWxYM/D+tQqG5T9wQqwQ+Bi/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700408; c=relaxed/simple;
	bh=MWG0Zglvd29bx6a4AZGV6SqQpZdhADDXtzQ0c4Ds978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrgniczmQNMfvI4FAcgef2gpdYX0F4T9akxoQJLTny7iEyaK2B1/y4ZP2+irtgvW6LKFJdmLjLuq7mBT2gIATlB5y1APoTQOxGWaz3/0eTPXPFaYVwsiaauCx1ZwMz1RH+gc88+q8WjvxRcrYGy8nm9wbuqwW/yWH7cNC2SAKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e45fRE7E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7DFt+dT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767700405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEgid8z1Mi7abwQ5T3UH1jzdW67mQ6CtP9yV7wpbSb0=;
	b=e45fRE7EYHLsReJChlg0UDx7GLDGrEvaIx4usB/o1kqvR4T8pObpDPxzB4dkfo7MSWBm/A
	ewYdqmPPyABdBBG/c+Ac67Dex1qAQXCmM3Gg9GgFDahqSEDNcyNKXOK9rj/fnZGuFY+cLu
	AJD2Quyi2lNwcrBbHpbMbK+JXUscvLI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-UMAlKQCIOVqRYUjWNFVYfA-1; Tue, 06 Jan 2026 06:53:24 -0500
X-MC-Unique: UMAlKQCIOVqRYUjWNFVYfA-1
X-Mimecast-MFC-AGG-ID: UMAlKQCIOVqRYUjWNFVYfA_1767700403
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c0c7e0a8ac1so1344002a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 03:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767700403; x=1768305203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aEgid8z1Mi7abwQ5T3UH1jzdW67mQ6CtP9yV7wpbSb0=;
        b=V7DFt+dTI5JvJyMjqoVFqIa7NeSp3dXiOpQdHeYBVpxJqodeZ5qkvNFb7HNxCxE8E2
         ViojD/BalqashQTvteaBb1qWCIvFIQXp2Ja+8J4I2uDhSgBo6JsesGiM9zQZrPihFqq2
         3UC2B7cOoN3yvHeQCmg7HLGVpYifrSR1L9VZkDJ4jbrHtbtzluVF+40/SqMpZNGtnSV8
         H+WDqxu3BaA52EI8MUl9Gp4eCoD1S+0S+r0NOw0Yllad6MheVF7LHi8IwlqRACeEERG/
         CThqEsgrUUuR0oh57/it9Fbnps+HxDvJw8HzjR5N+iafHevn53nMvSn/bcURPo6ybAvx
         GGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767700403; x=1768305203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEgid8z1Mi7abwQ5T3UH1jzdW67mQ6CtP9yV7wpbSb0=;
        b=nGwkFNI3EL9wMPQerVIAbtT012Hhbzsb2Q3PKMpwCWDCYMf6iS+Qya1guXHAQ9WlL6
         MvTGw2f+AFEV/zAAEqjHkJlGe8HPxLY3dMZaBqvBdMnHDhwoPr8sG8rxZtG4p4jFLU8z
         R4PKUub478lAgP0oq54ISRbGrz4Bitf9eYcvQwy0Qdt3tH/TJIFMK2K22CZCLKuX/Uzh
         yXCokGU+qED2R6btkIZMv+nHICH3O/KuVblsoR2461oyT4gMyTgW9u7xZd57HWVdwhDW
         Zo8+4Olb7Tc76x0AT7BJbLF3f/4Q+E03ouOtunE1d+UKF+p6dE88GsjF2jl6BhLIFlQo
         KmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaV8FKxOl+ml9/aUzRvUM1JYCYKjmSN/H5jkIjJbW+bPq0xmZa/KRpOpW/fYUkHOjL1HXe1UY1xvg9wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNf64DwFTM4Mv+iMOY3B4QiMj/lTtEenB2yLmyAX6vMGjU6wuF
	cpjfROWhSDMjiJF38lbUAZl5h7e5GrlD1hydqqO96U6RNKRnwkn26xkqCdAi/oT43RInfR0p1pP
	4CIONimFKel1CI6RSrUlAzN+7+u05NduB5k+lkscmuftfUaLzQIkyANklVEI+nzMw
X-Gm-Gg: AY/fxX52WDp9ycYBV/MyNg6OoRU2d+IGiHyL2/aqjRai5f/7rgFzN/+0eb7IfwB559c
	CG80YpfJzVi8SOUeBSCjtzwYAQrmo4WBVdLxwVHPmGTVsXwAlTGHIll6ohlLIERUPxs6pot/LsQ
	GzY2FuR2JCbQPVIQw+SnPufGnfJRJek+3h/VJNHP1NixxVW7M3fKjqyXXCcfduEmhA8C8f+s+ya
	+CeERdJhwpop4VUQyiNNvPEZQxOU6r9x1jo1+i0ZSyBeZKgUNMRluz5qQI7bOtHC9COrya6JaSZ
	e+zyAT4grL9O8giJ16XOgTUyi2Whde3tCcBh6yZXfTlnVXyDps0SlflIrwpxd/j8eNjIe52xavN
	Bv61AUkiVQurL7wVnW8gX+C2jas1Xxolv1VKkJFGR5x5Hzj6GUw==
X-Received: by 2002:a05:6a20:72a6:b0:366:19fd:dbe4 with SMTP id adf61e73a8af0-389822c1e44mr2526897637.4.1767700403246;
        Tue, 06 Jan 2026 03:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGahWa5NKO+aagTbF1nIRt2Qo0M7Wk2kJAm/td/1+Dzw3K5r3/sDFz13B0KHyMpnopi/tM4VQ==
X-Received: by 2002:a05:6a20:72a6:b0:366:19fd:dbe4 with SMTP id adf61e73a8af0-389822c1e44mr2526876637.4.1767700402691;
        Tue, 06 Jan 2026 03:53:22 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d2932bsm2324272a12.21.2026.01.06.03.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:53:20 -0800 (PST)
Date: Tue, 6 Jan 2026 19:53:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH] btrfs: test power failure after fsync and rename
 exchanging directories
Message-ID: <20260106115316.jzdtch6zmdo7w5hb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3cb8fdeec6e3bf977682d1074bf3e7ba1719b98c.1765466812.git.fdmanana@suse.com>
 <CAL3q7H7AY2iC+Z8LEv8+TawbuXJdwoXei_0d+NEccVYE5Wu3PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7AY2iC+Z8LEv8+TawbuXJdwoXei_0d+NEccVYE5Wu3PA@mail.gmail.com>

On Mon, Jan 05, 2026 at 04:22:28PM +0000, Filipe Manana wrote:
> On Thu, Dec 11, 2025 at 3:42 PM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test renaming one directory over another one that has a subvolume inside
> > it and fsync a file in the other directory that was previously renamed.
> > We want to verify that after a power failure we are able to mount the
> > filesystem and it has the correct content (all renames visible).
> >
> > This exercises a bug fixed by the following kernel patch:
> >
> >   "btrfs: always detect conflicting inodes when logging inode refs"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Ping.
> 
> Zorro, this missed the last update.

Hi Filipe, Happey new year :) I just backed from holiday, so hurried to
merge some patches with enough RVB. This patch hasn't been reviewed,
especially it conflicted with another patchset (refer to below review points),
so I decided to deal with it in next release. Sorry for the delaying ...

> 
> 
> > ---
> >  tests/btrfs/340     | 75 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/340.out | 15 +++++++++
> >  2 files changed, 90 insertions(+)
> >  create mode 100755 tests/btrfs/340
> >  create mode 100644 tests/btrfs/340.out
> >
> > diff --git a/tests/btrfs/340 b/tests/btrfs/340
> > new file mode 100755
> > index 00000000..d52893ae
> > --- /dev/null
> > +++ b/tests/btrfs/340
> > @@ -0,0 +1,75 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> > +#
> > +# FS QA Test 340
> > +#
> > +# Test renaming one directory over another one that has a subvolume inside it
> > +# and fsync a file in the other directory that was previously renamed. We want
> > +# to verify that after a power failure we are able to mount the filesystem and
> > +# it has the correct content (all renames visible).
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick subvol rename log
> > +
> > +_cleanup()
> > +{
> > +       _cleanup_flakey
> > +       cd /
> > +       rm -r -f $tmp.*
> > +}
> > +
> > +. ./common/filter
> > +. ./common/dmflakey
> > +. ./common/renameat2
> > +
> > +_require_scratch
> > +_require_dm_target flakey
> > +_require_renameat2 exchange
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +       "btrfs: always detect conflicting inodes when logging inode refs"
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > +_require_metadata_journaling $SCRATCH_DEV
> > +_init_flakey
> > +_mount_flakey

The _mount_flakey and _unmount_flakey have been removed by:

  commit eb2ad950ea90d8d8d861f8beac138d6a19f0f819
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Thu Dec 18 08:29:59 2025 +0100

      dmflakey: override SCRATCH_DEV in _init_flakey

> > +
> > +# Create our test directories, one with a file inside, another with a subvolume
> > +# that is not empty (has one file).
> > +mkdir $SCRATCH_MNT/dir1
> > +echo -n > $SCRATCH_MNT/dir1/foo
> > +
> > +mkdir $SCRATCH_MNT/dir2
> > +_btrfs subvolume create $SCRATCH_MNT/dir2/subvol
> > +echo -n > $SCRATCH_MNT/dir2/subvol/subvol_file
> > +
> > +_scratch_sync
> > +
> > +# Rename file foo so that its inode's last_unlink_trans is updated to the
> > +# current transaction.
> > +mv $SCRATCH_MNT/dir1/foo $SCRATCH_MNT/dir1/bar
> > +
> > +# Rename exchange dir1 with dir2.
> > +$here/src/renameat2 -x $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
> > +
> > +# Fsync file bar, we just renamed from foo.
> > +# Until the kernel fix mentioned above, it would result in logging dir2 without
> > +# logging dir1, causing log replay to attempt to remove the inode for dir1 since
> > +# the inode for dir2 has the same name in the same parent directory. Not only
> > +# this was not correct, since we did not delete the directory, but it would also
> > +# result in a log replay failure (and therefore mount failure) because we would
> > +# be attempting to delete a directory with a non-empty subvolume inside it.
> > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/bar
> > +
> > +# Simulate a power failure and then mount again the filesystem to replay the
> > +# journal/log. We should be able to replay the log tree and mount successfully.
> > +_flakey_drop_and_remount
> > +
> > +echo -e "Filesystem contents after power failure:\n"
> > +ls -1R $SCRATCH_MNT | _filter_scratch
> > +
> > +_unmount_flakey

The _cleanup_flakey in your _cleanup contains the _unmount $SCRATCH_MNT, so if
you don't need "double umount", I think we can remove this line directly.

Others looks good to me, please rebase to v2026.01.05 in v2, then I'll review
and merge your v2 into patches-in-queue, then push it in next release :)

Thanks,
Zorro

> > +
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/btrfs/340.out b/tests/btrfs/340.out
> > new file mode 100644
> > index 00000000..7745c639
> > --- /dev/null
> > +++ b/tests/btrfs/340.out
> > @@ -0,0 +1,15 @@
> > +QA output created by 340
> > +Filesystem contents after power failure:
> > +
> > +SCRATCH_MNT:
> > +dir1
> > +dir2
> > +
> > +SCRATCH_MNT/dir1:
> > +subvol
> > +
> > +SCRATCH_MNT/dir1/subvol:
> > +subvol_file
> > +
> > +SCRATCH_MNT/dir2:
> > +bar
> > --
> > 2.47.2
> >
> >
> 


