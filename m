Return-Path: <linux-btrfs+bounces-18507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FCDC27ACB
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960064E6B77
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C82C08D9;
	Sat,  1 Nov 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+ulZNDf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLTzj8ZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22E12C544
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761989264; cv=none; b=BGVn1Uwrr5vV80Rt4J4pL1kuRNvLWWBIIotqs8qNkOHlPtq0Vxvb/yvcV3/ltbk0p/qib8hae9GzGzvMUYSuUqBYpLTw3gBGtRso/7/T5tcZ9kwH9VGewfI1Y4vgY9LRDZhHzGMM+VgiJtRjXyBcmU+FriiChVB7KtcSTnZg1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761989264; c=relaxed/simple;
	bh=5UGM2acK4U+UYS//dJ4YbqwnQW/uNu85pIF1mdy4LM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdBzhqhjJu8tD/HgZgbeyjimSlbub+HVrsCLC5bEBegmglYmnG/rtuIdqJevawgVcHbZLVWRDFUGsc/9CF5q1j2p/yZxJlSIP9wpELYQhJp4BpaMhkZVowmkJnkeH6ZxYXt//aXMGOaeQNJKI+uF6qXgtMAOPr4bVfl04Irst2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+ulZNDf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLTzj8ZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761989261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbQmNSy9P0NTgIS1jo9Ela3U7G3myp7cj0Hkt1v3so8=;
	b=U+ulZNDfAFMHv6az43c08lFuCBFhsuVtDQOoDAR+QYwEPPO0EtHNzfscnyiOj7z5n1v4Tw
	gj/a55/bOYsgY3pLBWCdYEw4H1Md5XBPWwQ1MLjHL3RVw98523bv1StlMj2rsSFcTLY0Pw
	gpFlsaFMFIfCyU3W1y00laOcWHJJSlU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-q1Vqz3pYOPOOfpsxbCN58w-1; Sat, 01 Nov 2025 05:27:39 -0400
X-MC-Unique: q1Vqz3pYOPOOfpsxbCN58w-1
X-Mimecast-MFC-AGG-ID: q1Vqz3pYOPOOfpsxbCN58w_1761989259
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2952cb6f51bso33377135ad.2
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Nov 2025 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761989259; x=1762594059; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RbQmNSy9P0NTgIS1jo9Ela3U7G3myp7cj0Hkt1v3so8=;
        b=hLTzj8ZULgq/Dueu7xz5/djcS5AiAXOTKmikBouLZumhDO2TQ23rgq82YwYHGaHSMt
         X5MlRsk84xAZ8MGrDzFLY9PPstMm/Ips4FDq5Owrk2VZbR5laKFJmI9iVagamW42B4ma
         Jdw94uhlFbzqAsSjJ0DBSt4SqeLTifgeSS3CQi/nhjbCOqqsP446QFA+w3C3aVf1prhN
         JlD3I9pu7mqVjhhU1bFCeqDppmCrhfOag/fDyYmdk1ws0Gq3awZBGWDzbciRnoemQ28p
         PMmHOiUTduX2R2CSgLhd8ezzYIwamziJyERXtb3x/i9N5rnt6w6olrZxJ9TD/99+B7gJ
         JC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761989259; x=1762594059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbQmNSy9P0NTgIS1jo9Ela3U7G3myp7cj0Hkt1v3so8=;
        b=SFp25LBcip+8EEF+hNljauEQXXltyWFfZ3KJx+LCAXFkfisJmeApj/slqgVrccZio1
         AZ2TaBF7NTsJxTkiZOnCrqyzqNl7B/kM6taFZsf/yRFg/7ZcyLZBafotYwe6mTRUDP6t
         GVk+YaH5MXJF20vG4vUYNBYVbkC8dJihjGksz1IR/m1W+3KblxTvJCi+4UII6sbKW3d5
         5opif8tjyDY8y8zcceCdljGCU37O1WYXIeDWCoLp6beFbYU3kPcBWLqKg/1sms8RwqFH
         YxELmUPxSSZsYOU2umf5wiUv4gsJpL8P6d1EXKrUcsG9n5NrXuMbO60dcyzBPkIPpN5a
         541Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHmrK9jwJCHPKRq1pTAPJKdkrStgx96Re1WD/lfmPnghrpDv3//xOrc9Ep851j7bgkWa9wzzk6IZm2wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zck3UT/z7jCRtfyH41F2F/ABEMqV4B7YK3MqonepIInDmJYL
	BYpTgrFIj3WLEw66ufsvFZtSMm6CpynOsBJaytr8UMVzzQSDVmlnzkakXIYAcZQhY3K42fqkMp2
	5pwKUFRKFHdUKnrYWyM3Bl99wanpRJRonK5ji0OydnMrqADOolA2JEieEpNzjoGTQ
X-Gm-Gg: ASbGncuz7PwMnoA7YOdbAlsg2YqThKOxg4seHZ0q+BOdz9ATzEsKAVsMvc3Tulz4fCL
	64gFWrw6AMXc06P9aMBADfMURw8n65ZwVoHuGwUzsLEKgBnVgovE4JbDJV1YC69qxgmic3DyUo8
	UtxVbgqnfTbOn5TgtHrSQd1tXUmHXExIloPCOfczUvw108eJHyk+FVpF0EhbeI7bn05ElkMCErl
	HNPmGK4HUgnQyGoYRT+kGf2t03nyw/IJ5zBMSVK1Heb0bTyprUULtF/XcOlSMhprkBn5GpVVNs5
	x5JM5ZALUAel1YX+W64ODelhR8rchI/JEpbE/j9bEkLGLtSePY9iPx6JZvFfKpksZ66LBaypfRj
	mos93GNzQZ4o+Q72BArXiE9rviX8od1HJIgbimPw=
X-Received: by 2002:a17:903:2f8c:b0:295:5b68:996a with SMTP id d9443c01a7336-2955b6899d8mr9378995ad.12.1761989258720;
        Sat, 01 Nov 2025 02:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNQ7oH/ftv3ZeKsXzq6fngr+BkDkGPtK3d2e7A3QVpLpTaT3o3n0L0swl5GRcNH+f3VgG1dw==
X-Received: by 2002:a17:903:2f8c:b0:295:5b68:996a with SMTP id d9443c01a7336-2955b6899d8mr9378705ad.12.1761989258084;
        Sat, 01 Nov 2025 02:27:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295688c68f0sm6092415ad.41.2025.11.01.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:27:37 -0700 (PDT)
Date: Sat, 1 Nov 2025 17:27:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of directory after renaming new
 symlink
Message-ID: <20251101092732.56fb7d3gzarabudd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
 <bb46518c-9836-4bd2-8142-fbb8c859fd3f@suse.com>
 <CAL3q7H4bcqMZEu_QSQVETQWPzkBCSpi2cKEAbfcpHPcPG=Wc0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4bcqMZEu_QSQVETQWPzkBCSpi2cKEAbfcpHPcPG=Wc0A@mail.gmail.com>

On Sat, Oct 25, 2025 at 08:39:56PM +0100, Filipe Manana wrote:
> On Sat, Oct 25, 2025 at 11:13 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > 在 2025/10/24 22:23, fdmanana@kernel.org 写道:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that if we fsync a directory that has a new symlink, then rename the
> > > symlink and fsync again the directory, after a power failure the symlink
> > > exists with the new name and not the old one.
> > >
> > > This is to exercise a bug in btrfs where we ended up not persisting the
> > > new name of the symlink. That is fixed by a kernel patch that has the
> > > following subject:
> > >
> > >   "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >   tests/generic/779     | 60 +++++++++++++++++++++++++++++++++++++++++++
> > >   tests/generic/779.out |  2 ++
> > >   2 files changed, 62 insertions(+)
> > >   create mode 100755 tests/generic/779
> > >   create mode 100644 tests/generic/779.out
> > >
> > > diff --git a/tests/generic/779 b/tests/generic/779
> > > new file mode 100755
> > > index 00000000..40d1a86c
> > > --- /dev/null
> > > +++ b/tests/generic/779
> > > @@ -0,0 +1,60 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 779
> > > +#
> > > +# Test that if we fsync a directory that has a new symlink, then rename the
> > > +# symlink and fsync again the directory, after a power failure the symlink
> > > +# exists with the new name and not the old one.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick log
> > > +
> > > +_cleanup()
> > > +{
> > > +     _cleanup_flakey
> > > +     cd /
> > > +     rm -r -f $tmp.*
> > > +}
> > > +
> > > +. ./common/dmflakey
> > > +
> > > +_require_scratch
> > > +_require_symlinks
> > > +_require_dm_target flakey
> > > +
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +     "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> > > +
> > > +rm -f $seqres.full
> >
> > Looks like a rouge command?
> 
> It was copied from some other test.
> A few tests have this, but it doesn't seem to be needed (anymore at least).
> 
> I'll let Zerro remove the line when he picks this.

Sure, just removed and merged, this patch is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> >
> >
> > Otherwise looks good to me.
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> > Thanks,
> > Qu
> >
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > > +_require_metadata_journaling $SCRATCH_DEV
> > > +_init_flakey
> > > +_mount_flakey
> > > +
> > > +# Create our test dir and add a symlink inside it.
> > > +mkdir $SCRATCH_MNT/dir
> > > +ln -s foobar $SCRATCH_MNT/dir/old-slink
> > > +
> > > +# Fsync the test dir, should persist the symlink.
> > > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> > > +
> > > +# Rename the symlink and fsync the directory. It should persist the new symlink
> > > +# name.
> > > +mv $SCRATCH_MNT/dir/old-slink $SCRATCH_MNT/dir/new-slink
> > > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> > > +
> > > +# Simulate a power failure and then mount again the filesystem to replay the
> > > +# journal/log.
> > > +_flakey_drop_and_remount
> > > +
> > > +# Check that the symlink exists with the new name and has the correct content.
> > > +[ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not found"
> > > +echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
> > > +
> > > +_unmount_flakey
> > > +
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/generic/779.out b/tests/generic/779.out
> > > new file mode 100644
> > > index 00000000..c595cd01
> > > --- /dev/null
> > > +++ b/tests/generic/779.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 779
> > > +symlink content: foobar
> >
> 


