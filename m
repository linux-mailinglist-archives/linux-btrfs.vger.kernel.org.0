Return-Path: <linux-btrfs+bounces-2992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4D86F946
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 05:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124491F216A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA46138;
	Mon,  4 Mar 2024 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJx95N8t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CD17C8;
	Mon,  4 Mar 2024 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527285; cv=none; b=XYH0MkTuX220qPZcMspip7iy8x0Pysbv6ITEBTR3LVe5R6BYbgsEnYwkQ7Dod/ScXJazRPi/hcuq1A0iQwYfSUj1FuoqajzxvVBqYLZR4TtIBd1w2OqoGy/PJ7cyygxnq15zhe93+GCa2yteAE9Y+qq9cqRyAnHrImiRBYupXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527285; c=relaxed/simple;
	bh=D5UrnjkSVi1B31YirTTPQjJwrThMIxeGFHPF9BbjHKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwmGCUq1/tJQEy0i7WviZzTL1uACvhDspNdmDabA33RWaBOTCyO6Zk52yz2uKgmEUek0PCpIaq565W/q2QySO6coqSNBU0RGRmEt/z5kdQ9IVcuvv6Y+I9YadZ/tdjpdnGu43mJ7PWzqoxuN4qwj6wZ1uCSpJPXe3/r2PF4XXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJx95N8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E68C433C7;
	Mon,  4 Mar 2024 04:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709527285;
	bh=D5UrnjkSVi1B31YirTTPQjJwrThMIxeGFHPF9BbjHKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJx95N8tqkOpYlrv78wdeXTaFI4Mc6UZ8F9IpIy4t6x6MPXIBCNxF1LYGwUwITSBH
	 aHV2Q5dyx7iWyAxXi1J3fI29vL/qbP1S9tEmue2q4P60iznGV6LGZNwapw+NkelJWO
	 oh2EcHaaCWMx6JsbPT32dKCY7yTH6X+TF0EB3uOUP6Xn0F1iaUkxLT53gj29hSQgVQ
	 MIQjo2rERVQS/rKjpOSEnvLVqTPaPogbqjeR3CsQKwxrVTB9WINiUofsHRPWajfGxM
	 Of2Vo2Ay1hrso7T0ZREV9nGa6g5h8r2GlJ9sup6ocu0A5qbXaGypKyir4Ur47bNk/X
	 sjStMf6mfoMnQ==
Date: Mon, 4 Mar 2024 12:41:19 +0800
From: Zorro Lang <zlang@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/121: allow snapshot with invalid qgroup
 to return error
Message-ID: <20240304044119.oqndhpriif5lfvju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240303065251.111868-1-wqu@suse.com>
 <20240304041840.rfn6mhkk5a6mlxnf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <25153f23-a1b0-41b1-9cb7-4f18f08d659b@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25153f23-a1b0-41b1-9cb7-4f18f08d659b@suse.com>

On Mon, Mar 04, 2024 at 02:57:45PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/4 14:48, Zorro Lang 写道:
> > On Sun, Mar 03, 2024 at 05:22:51PM +1030, Qu Wenruo wrote:
> > > [BUG]
> > > After incoming kernel commit "btrfs: qgroup: verify btrfs_qgroup_inherit
> > > parameter", test case btrfs/121 would fail like this:
> > > 
> > > btrfs/121 1s ... [failed, exit status 1]- output mismatch (see /xfstests/results//btrfs/121.out.bad)
> > >      --- tests/btrfs/121.out	2022-05-11 09:55:30.739999997 +0800
> > >      +++ /xfstests/results//btrfs/121.out.bad	2024-03-03 13:33:38.076666665 +0800
> > >      @@ -1,2 +1,3 @@
> > >       QA output created by 121
> > >      -Silence is golden
> > >      +failed: '/usr/bin/btrfs subvolume snapshot -i 1/10 /mnt/scratch /mnt/scratch/snap1'
> > >      +(see /xfstests/results//btrfs/121.full for details)
> > >      ...
> > >      (Run 'diff -u /xfstests/tests/btrfs/121.out /xfstests/results//btrfs/121.out.bad'  to see the entire diff)
> > > 
> > > [CAUSE]
> > > The incoming kernel commit would do early qgroups validation before
> > > subvolume/snapshot creation, and reject invalid qgroups immediately.
> > > 
> > > Meanwhile that test case itself still assume the ioctl would go on
> > > without any error, thus the new behavior would break the test case.
> > > 
> > > [FIX]
> > > Instead of relying on the snapshot creation ioctl return value, we just
> > > completely ignore the output of that snapshot creation.
> > > Then manually check if the fs is still read-write.
> > > 
> > > For different kernels (3 cases), they would lead to the following
> > > results:
> > > 
> > > - Older unpatched kernel
> > >    The filesystem would trigger a transaction abort (would be caught by
> > >    dmesg filter), and also fail the "touch" command.
> > > 
> > > - Older but patched kernel
> > >    The filesystem continues to create the snapshot, while still keeps the
> > >    fs read-write.
> > > 
> > > - Latest kernel with qgroup validation
> > >    The filesystem refuses to create the snapshot, while still keeps the
> > >    fs read-write.
> > > 
> > > Both "older but patched" and "latest" kernels would still pass the test
> > > case, even with different behaviors.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/121 | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/btrfs/121 b/tests/btrfs/121
> > > index f4d54962..15a54274 100755
> > > --- a/tests/btrfs/121
> > > +++ b/tests/btrfs/121
> > > @@ -24,8 +24,14 @@ _require_scratch
> > >   _scratch_mkfs >/dev/null
> > >   _scratch_mount
> > >   _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -# The qgroup '1/10' does not exist and should be silently ignored
> > > -_run_btrfs_util_prog subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1
> > > +# The qgroup '1/10' does not exist. The kernel should either gives an error
> > > +# (newer kernel with invalid qgroup detection) or ignore it (older kernel with
> > > +# above fix).
> > > +# Either way, we just ignore the output completely, and we will check if the fs
> > > +# is still RW later.
> > 
> > The explanation makes sense to me, just ask if you might want to output to .full
> > file, to save some information for debug if the test fails? I can help to change
> > the "&> /dev/null" to "&> $seqres.full" if you only need to change.
> 
> Oh, that's very kind of you.
> 
> Although in that case "&>" would overwrite the .full file,
> ">> $seqres.full 2>&1" would be better IHMO.

Oh, you're right, thanks for point out that! It's in "patches-in-queue" branch now,
and will be in next release if no more review points from others.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > Thanks,
> > Zorro
> > 
> > > +$BTRFS_UTIL_PROG subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1 &> /dev/null
> > > +
> > > +touch $SCRATCH_MNT/foobar
> > >   echo "Silence is golden"
> > > -- 
> > > 2.42.0
> > > 
> > > 
> > 
> 

