Return-Path: <linux-btrfs+bounces-3964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7389A2D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A849286088
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03B17166A;
	Fri,  5 Apr 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VICq3Rk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E3171658;
	Fri,  5 Apr 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335604; cv=none; b=uCtaZd7sQxegKhFrP3kXsnTlg+wzChUS9zzPD7BMX3HN6/rxAbl+GUYcZxY/LmBhR9g+sccEiB88c7dcDtR86o7QC7B4WaUIewkm26Lgut5YwsJ9CE9l6vbyLRfgDPi2apJhg1H301xHy/34ZC4SL5axEiPXAmo4rIGP+NQuuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335604; c=relaxed/simple;
	bh=9xN+QFnJfEH0uo3iEiBotij/j5TUI4NkAqYKS+lENfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThHo5bPXsDGj1FAapkKc7Rn5TDDszbtnmZjSJmRavmrSjnovUsDfm0CmpdOk5UVHtiG++EvWCRKEXNDtMZaemRfxdKykgP6MaMvpoyWclTl+++jo5usvfrVMog1oGVQ1btTtsQHgRRRvrcC91Nzesc/8KHwIWtCQ1jN61s1btPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VICq3Rk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787C9C433F1;
	Fri,  5 Apr 2024 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712335604;
	bh=9xN+QFnJfEH0uo3iEiBotij/j5TUI4NkAqYKS+lENfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VICq3Rk3TjzwgE1GXOERM315gIHnZUh6x6IxuG/j3TM81X2fc0zi/CPdXuUz+o7t8
	 gIlwlXUpcJ8+uWMjzlPih/SAt/28fiY5Ey2dzNRXhYTJNkPTocO6kk4W4iyvdkY+I8
	 hE2jOFt7iakWURsSJ0DIUScr/DH39HAzpIAW5VLtfbZVLxO8tEbJr4oUwNaocsodQV
	 ojUe2zTEL2iTGpvdOAJK/fI006o7HTcQgaxKKA43TUJRvQVcsh/0F5p5ZKUzM3FiK3
	 c8FpK732crC7cHww+EMXbVAvi3gqJxt7B9wb6Z4dxVxjfFHFnkxJuKo3qExj1Yg5Qa
	 b7ZqAGfIkYDjg==
Date: Fri, 5 Apr 2024 09:46:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH 1/2] common/filter.btrfs: add a new _filter_snapshot
Message-ID: <20240405164643.GA634366@frogsfrogsfrogs>
References: <cover.1712306454.git.anand.jain@oracle.com>
 <3d035b4355abc0cf9e95da134d89e3fbb58939d0.1712306454.git.anand.jain@oracle.com>
 <a62dbef2-0371-49e7-b5eb-9bb5fed32a17@gmx.com>
 <37e0ae3f-54b0-45a4-b62a-7caca994c38a@oracle.com>
 <eb9530e1-7626-41fb-978e-b830b46a04f4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9530e1-7626-41fb-978e-b830b46a04f4@gmx.com>

On Fri, Apr 05, 2024 at 08:20:59PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/4/5 19:55, Anand Jain 写道:
> > 
> > 
> > On 4/5/24 16:52, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2024/4/5 19:15, Anand Jain 写道:
> > > > As the newer btrfs-progs have changed the output of the command
> > > > "btrfs subvolume snapshot," which is part of the golden output,
> > > > create a helper filter to ensure the test cases pass on older
> > > > btrfs-progs.
> > > > 
> > > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > 
> > > Can we stop the golden output filter game?
> > > 
> > >  From day one I'm not a big fan of the golden output idea.
> > > For snapshot/subvolume creation, we don't really care about what the
> > > output is, we only care if there is any error (which would come from
> > > stderr).
> > > 
> > > In that case, why not just redirect the stdout to null?
> > > 
> > > To me, if we really care something from the stdout, we can still save it
> > > and let bash/awk/grep to process it, like what we did for various test
> > > cases, and then save the result to seqres.full.

That sums up what output filters do; I don't understand the objection
here...

> > > 
> > 
> > This is a bug-fix patch; it's not a good idea to change the concept of
> > fstests' golden output. Perhaps an RFC patch about your idea can help
> > to discuss and achieve consensus.
> 
> Even as bug-fix, a simple redirect to seqres.full and remove the
> corresponding line from golden output is very valid to me.
> 
> In fact, introducing a filter looks very over-engineered in this
> particular case.

...but having said that , I also dislike overfixation on golden output.
Patches welcome. ;)

--D

> 
> > 
> > Thanks, Anand
> > 
> > 
> > > Thanks,
> > > Qu
> > > > ---
> > > >   common/filter.btrfs | 9 +++++++++
> > > >   tests/btrfs/001     | 3 ++-
> > > >   tests/btrfs/152     | 6 +++---
> > > >   tests/btrfs/168     | 6 +++---
> > > >   tests/btrfs/202     | 4 ++--
> > > >   tests/btrfs/302     | 4 ++--
> > > >   6 files changed, 21 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/common/filter.btrfs b/common/filter.btrfs
> > > > index 9ef9676175c9..415ed6dfd088 100644
> > > > --- a/common/filter.btrfs
> > > > +++ b/common/filter.btrfs
> > > > @@ -156,5 +156,14 @@ _filter_device_add()
> > > > 
> > > >   }
> > > > 
> > > > +_filter_snapshot()
> > > > +{
> > > > +    # btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: subvolume:
> > > > output the
> > > > +    # prompt line only when the ioctl succeeded") changed the output
> > > > for
> > > > +    # btrfs subvolume snapshot, ensure that the latest fstests
> > > > continue to
> > > > +    # work on older btrfs-progs without the above commit.
> > > > +    _filter_scratch | sed -e "s/Create a/Create/g"
> > > > +}
> > > > +
> > > >   # make sure this script returns success
> > > >   /bin/true
> > > > diff --git a/tests/btrfs/001 b/tests/btrfs/001
> > > > index 6c2639990373..cfcf2ade4590 100755
> > > > --- a/tests/btrfs/001
> > > > +++ b/tests/btrfs/001
> > > > @@ -26,7 +26,8 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1
> > > > &> /dev/null
> > > >   echo "List root dir"
> > > >   ls $SCRATCH_MNT
> > > >   echo "Creating snapshot of root dir"
> > > > -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
> > > > _filter_scratch
> > > > +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | \
> > > > +                            _filter_snapshot
> > > >   echo "List root dir after snapshot"
> > > >   ls $SCRATCH_MNT
> > > >   echo "List snapshot dir"
> > > > diff --git a/tests/btrfs/152 b/tests/btrfs/152
> > > > index 75f576c3cfca..b89fe361e84e 100755
> > > > --- a/tests/btrfs/152
> > > > +++ b/tests/btrfs/152
> > > > @@ -11,7 +11,7 @@
> > > >   _begin_fstest auto quick metadata qgroup send
> > > > 
> > > >   # Import common functions.
> > > > -. ./common/filter
> > > > +. ./common/filter.btrfs
> > > > 
> > > >   # real QA test starts here
> > > >   _supported_fs btrfs
> > > > @@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
> > > > 
> > > >   # Create base snapshots and send them
> > > >   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
> > > > -    $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
> > > > +    $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapshot
> > > >   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
> > > > -    $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
> > > > +    $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapshot
> > > >   for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
> > > >       $BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2>
> > > > /dev/null | \
> > > >           $BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} |
> > > > _filter_scratch
> > > > diff --git a/tests/btrfs/168 b/tests/btrfs/168
> > > > index acc58b51ee39..78bc9b8f81bb 100755
> > > > --- a/tests/btrfs/168
> > > > +++ b/tests/btrfs/168
> > > > @@ -20,7 +20,7 @@ _cleanup()
> > > >   }
> > > > 
> > > >   # Import common functions.
> > > > -. ./common/filter
> > > > +. ./common/filter.btrfs
> > > > 
> > > >   # real QA test starts here
> > > >   _supported_fs btrfs
> > > > @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro
> > > > false
> > > >   # Create a snapshot of the subvolume, to be used later as the
> > > > parent snapshot
> > > >   # for an incremental send operation.
> > > >   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
> > > > $SCRATCH_MNT/snap1 \
> > > > -    | _filter_scratch
> > > > +                            | _filter_snapshot
> > > > 
> > > >   # First do a full send of this snapshot.
> > > >   $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
> > > > @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K"
> > > > $SCRATCH_MNT/sv1/baz >>$seqres.full
> > > >   # Create a second snapshot of the subvolume, to be used later as
> > > > the send
> > > >   # snapshot of an incremental send operation.
> > > >   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
> > > > $SCRATCH_MNT/snap2 \
> > > > -    | _filter_scratch
> > > > +                            | _filter_snapshot
> > > > 
> > > >   # Temporarily turn the second snapshot to read-write mode and then
> > > > open a file
> > > >   # descriptor on its foo file.
> > > > diff --git a/tests/btrfs/202 b/tests/btrfs/202
> > > > index 5f0429f18bf9..57ecbe47c0bb 100755
> > > > --- a/tests/btrfs/202
> > > > +++ b/tests/btrfs/202
> > > > @@ -8,7 +8,7 @@
> > > >   . ./common/preamble
> > > >   _begin_fstest auto quick subvol snapshot
> > > > 
> > > > -. ./common/filter
> > > > +. ./common/filter.btrfs
> > > > 
> > > >   _supported_fs btrfs
> > > >   _require_scratch
> > > > @@ -28,7 +28,7 @@ _scratch_mount
> > > >   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
> > > >   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
> > > >   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
> > > > -    | _filter_scratch
> > > > +                            | _filter_snapshot
> > > > 
> > > >   # Need the dummy entry created so that we get the invalid removal
> > > > when we rmdir
> > > >   ls $SCRATCH_MNT/c/b
> > > > diff --git a/tests/btrfs/302 b/tests/btrfs/302
> > > > index f3e6044b5251..52d712ac50de 100755
> > > > --- a/tests/btrfs/302
> > > > +++ b/tests/btrfs/302
> > > > @@ -15,7 +15,7 @@
> > > >   . ./common/preamble
> > > >   _begin_fstest auto quick snapshot subvol
> > > > 
> > > > -. ./common/filter
> > > > +. ./common/filter.btrfs
> > > > 
> > > >   _supported_fs btrfs
> > > >   _require_scratch
> > > > @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
> > > >   # Now create a snapshot of the subvolume and make it accessible
> > > > from within the
> > > >   # subvolume.
> > > >   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
> > > > -         $SCRATCH_MNT/subvol/snap | _filter_scratch
> > > > +                 $SCRATCH_MNT/subvol/snap | _filter_snapshot
> > > > 
> > > >   # Now unmount and mount again the fs. We want to verify we are able
> > > > to read all
> > > >   # metadata for the snapshot from disk (no IO failures, etc).
> > 
> 

