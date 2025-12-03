Return-Path: <linux-btrfs+bounces-19483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB7C9EDC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 12:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96A5C4E4829
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9E2F5A17;
	Wed,  3 Dec 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5BZBgKr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C342F5467
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761934; cv=none; b=q1f4qDTH/GzjIb8S8/yo2wNeWFwmD8XsF7FbUs+12aKkGOwq5vvBERFLe5MGNnPRCcSU9IA1g+h8B+nREU2glWEauaIESINXDcTnHaEA5RM7fqigS3YmxQSWOR8hyWsE9xodQ5/dyYVoKxItqOPtyKpOBVmufIIlCfSj/w8/Ax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761934; c=relaxed/simple;
	bh=oYgJLnMLBTLjMU2XPSAErfmSJrddd+Z+KaQotAzmTng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTK2MktAODzGUX7beJ8ihGeJXff2Bp8DMDmyJq8tVT2LOjezOmMFYrvMpYoLvnaUJ6N8hviRd930hsEXGlg6ys4nVKIGxqyrnqwpq5sIjPQluhRiygND9QmXYNv5OfmSHLN9iKMQcCPksZuO/sR5eXT9yqTWGlx/DlJf0RhjkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5BZBgKr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2984dfae0acso102290195ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764761932; x=1765366732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RF5rVsgNS9MNETZb6wlNSOTYWmEo8PvEP85K6wzRNk8=;
        b=M5BZBgKroJJT0RODDDy3FDgPxXejy8harLjyP0qPfvoaSJz5ZI3LCp8QLhN91P5yZ2
         /zzSrGDPR/0V8HM9H/6WdzczFzfT5sPdbnt0qiUvMb1usALAogVSUeHojX4fteXz8XbY
         6ZgK9pjVlUlLbxTRGekqEnnWOi45Gba+/arQWK7GhJAtmHhmk47tvLEz+IO6eO7j+V6J
         zcN4LoL6ixk1ziE9md6UP7oMWqw65x8v9Ca9WWlmBsFRlo3ujLz5sBt/u86DVIMiCEdv
         sR0PNSMWTJze/Yx+M38LuFlM7cjkbtFtulIORD6yChfSosnYZUZYYltzWYW1xA+g2JTP
         cmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761932; x=1765366732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF5rVsgNS9MNETZb6wlNSOTYWmEo8PvEP85K6wzRNk8=;
        b=iznN1LjiTsL7bJROYb7ma/J9vw10XOCtvmHLkHQNBlC//gf+z5qBSA+p0k0OCxqIE3
         PUWraVVxGRLkMp3aW5BZngt75p8IdWJ+8wvjv3+R1T3pD7UJeYNEPDiCqT9xIlEEjy/V
         aq7iphF/ANlusF14GvSDWUDi/y7tMRxo2Qdjl1nu07tSUYouDtR8JSXh/wruE5cGn4P5
         nfoJe4QVJfzCE0MbE6lERlyhAl7wvuL9IOnXSjdBlja4jPQ1PEAV9N3lgsGcx00mjEYr
         RyX43OAql6QwamhQ4HCNlFJ1Yaz+6awJ2ndDDEGyPQvK8AdzH9cm2e7LgVQFa6YS+oDG
         TCBA==
X-Forwarded-Encrypted: i=1; AJvYcCXUwvs22S1AV/ZRmU6c1qdvMmEpyihawQLuEQFR84km6beDNAKm4UjLjr3wbNATScd8Pfbh+57eoywlLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybFtsTGTadQBakUfo6g5xh7YSjJVsuoXe5fB0mvpmgRQpVx+tp
	swwV2a4RofJq/ybF784sIUYOUTUqvLxAd/rg512lKFllRoeDk8vjeYcVIhuCFA==
X-Gm-Gg: ASbGnctaQjETYtQ6Mc2HKIFXayK2QtWuC6xmO24Swd/lVqioMx+Ij7PbXPPLjds68nd
	hsJH2mHaeN8bOO+npHXyjBnfarC2PGTj2kgDkbVRb3xKELD/K6n8VkFy+3pnHUDhSyYVPeKMpeR
	pRIz80IUo14RUNz+q7ivSSzHmnh2alC3eo2yicjFx1UERbsErys3uK9lfLzTO1YkWIS+iZIhD1S
	vITitibXDXel6uvP0AmqDOJb6tu3IM1BSyXNa18U02wSrWJg2jPhfXFtNPtm+eZgF0IkRE4Gz/2
	KkgHnQX2KMVaYqAge9jZG8P0pRrlfQ873PZdP2bWJKTscel6R3Y0VzT4I5R3sM9L7Z6r/CU1an2
	dJAJzCW09NlDrNbMAW1gFw+5cGsnNRlh2xsDhDAgEHJbOKT4+QzPXQLDvPWUCONXlvwocrxds90
	/gKT87
X-Google-Smtp-Source: AGHT+IFaMTfp0skkgVYWKG0nvbNnv8ZAsz9tMg880fsRMe99DRmLdMJnhMtQLPhDTTF9QjU3xAsUgA==
X-Received: by 2002:a17:903:3c28:b0:297:d6c0:90b3 with SMTP id d9443c01a7336-29d68362ebemr24976895ad.23.1764761931606;
        Wed, 03 Dec 2025 03:38:51 -0800 (PST)
Received: from sidong ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7d4f4sm182835265ad.101.2025.12.03.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:51 -0800 (PST)
Date: Wed, 3 Dec 2025 11:38:29 +0000
From: Sidong Yang <realwakka@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] btrfs/339: test receive dump stream for different
 user
Message-ID: <aTAhNRFMJMYWkhtO@sidong>
References: <20251119052843.35108-1-realwakka@gmail.com>
 <CAL3q7H5e6R5XzFQTfx9hpxsiaVoQoiXgsqSTRO9GQAhmv+-rng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5e6R5XzFQTfx9hpxsiaVoQoiXgsqSTRO9GQAhmv+-rng@mail.gmail.com>

On Tue, Dec 02, 2025 at 02:57:19PM +0000, Filipe Manana wrote:
> On Wed, Nov 19, 2025 at 5:30 AM Sidong Yang <realwakka@gmail.com> wrote:
> >
> > Test receive to dump stream file from different user.
> >
> > This is a regression test for the btrfs-progs commit cd933616d485
> > ("btrfs-progs: receive: don't use O_NOATIME to open stream for
> > dumping").
> >
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2:
> > - forward to $seqres.full rather than -q
> > - use $tmp for stream file
> > ---
> >  tests/btrfs/339     | 40 ++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/339.out |  2 ++
> >  2 files changed, 42 insertions(+)
> >  create mode 100755 tests/btrfs/339
> >  create mode 100644 tests/btrfs/339.out
> >
> > diff --git a/tests/btrfs/339 b/tests/btrfs/339
> > new file mode 100755
> > index 00000000..0df24577
> > --- /dev/null
> > +++ b/tests/btrfs/339
> > @@ -0,0 +1,40 @@
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
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +       cd /
> > +       rm -r -f $tmp.*
> > +}
> 
> This does the same as the default _cleanup function, so there's no
> need to have it, just remove it.

I see, Thanks

> 
> > +
> > +. ./common/filter
> > +. ./common/quota
> 
> Why include the quota file? It's not needed, the test doesn't use
> anything from it, just remove it.

I don't need it. Removed.
> 
> > +
> > +_require_scratch
> > +_require_user
> > +
> > +_fixed_by_git_commit btrfs-progs cd933616d485 \
> > +       "btrfs-progs: receive: don't use O_NOATIME to open stream for dumping"
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +stream=$tmp.fsv.ss
> > +
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full
> 
> Nowadays we use _btrfs, it's shorter and does the same (including the
> stdout redirection):
> 
> _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
> 
> > +$BTRFS_UTIL_PROG send -f $stream $SCRATCH_MNT/snap >> $seqres.full 2>&1 || _fail "send failed"
> 
> And here:
> 
> _btrfs send -f $stream $SCRATCH_MNT/snap
> 
> There's no need to:  || _fail "send failed"
> That is generally discouraged in fstests. A failure will just cause a
> mismatch with the golden output and make the test fail.
> 
> But _btrfs already calls _fail and redirects to the .full file anyway.
> 
> Otherwise it looks good, thanks.

Thanks, I'll send a new version right away.

Thanks,
Sidong
> 
> 
> 
> > +chmod a+r $stream
> > +_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f $stream" >> $seqres.full
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
> > --
> > 2.43.0
> >
> >

