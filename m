Return-Path: <linux-btrfs+bounces-11678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D6A3EBC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 05:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339D519C5603
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D81FA16B;
	Fri, 21 Feb 2025 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRY52cRf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A015A8;
	Fri, 21 Feb 2025 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111500; cv=none; b=CLvT+zivp6bpxKC3qGjtfU0mK05XagYni1QOViKU9hdrKXUtjOHZK7qYIQWsyZDGuazyeUKkFiyy3ARlVwlhHfKg4DZDF7FAR3ct4s9IwbILy3TpLwQ5H5pDhsOVT6T44DsUKE84TTvZZ97AQ6l/qEJ+FsPv5cVDAQzaNUFZYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111500; c=relaxed/simple;
	bh=Ko8ueRoNiyEQPhI3vjxGqaMpWlwMgA7AvxQ8vrBOoZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thX+6ZjgRnut3rjoEcUclnsm4Wid/4Slz46jISSxckK2HQY6GIPWS5IBgqLWAhBSguMo2/RNi3LBVJ0SgC/pVg+QdUD5biAxHIrv6KGVIk6QHwhiM/Es94wFX2QzlZjeCar7ohg8w56XRNHWYVMpqKmj15nySPq5cEbs5KTMCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRY52cRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E84C4CEE2;
	Fri, 21 Feb 2025 04:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740111499;
	bh=Ko8ueRoNiyEQPhI3vjxGqaMpWlwMgA7AvxQ8vrBOoZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRY52cRfp34E2wAC4ZAbFW1SLcmacw4mMCgVPkbVLQvSUUc2XrQxHinCGkXxd9HqR
	 rP1lw6xKDDNV5g7wDEVFHDpaI7UPy7nqLyCFae9LCPORqUogf4xePC46wcd6e4D76g
	 lMPZP1AiizAErwAAVvP0L0gNz9iaT/ZcOPljTTee5rR3I15d+m6JYxLfVvg5jPRxHD
	 zaAEgI+bwl+dzR25Vp3qT7dO7mveUiNJ0rmuBYMchYcLUlMGgIQXyQmuIMV55ApOtD
	 BlsG+9Xs7E/WGN/9fX3BeaLArMRoACRuNkdcnRv51jwiut9X1lWWRB8n+DtO1HbEo+
	 +tFimaejJKsEg==
Date: Thu, 20 Feb 2025 20:18:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
Message-ID: <20250221041819.GX21799@frogsfrogsfrogs>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>

On Thu, Feb 20, 2025 at 06:22:57PM +0000, Filipe Manana wrote:
> On Thu, Feb 20, 2025 at 5:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> > > On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > If the test fails or is interrupted after mounting $scratch_dev3 inside
> > > > the test filesystem and before unmounting at test_add_device(), we leave
> > > > without being unable to unmount the test filesystem since it has a mount
> > > > inside it. This results in the need to manually unmount $scratch_dev3,
> > > > otherwise a subsequent run of fstests fails since the unmount of the
> > > > test device fails with -EBUSY.
> > > >
> > > > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> > > > function.
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >   tests/btrfs/254 | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > > index d9c9eea9..6523389b 100755
> > > > --- a/tests/btrfs/254
> > > > +++ b/tests/btrfs/254
> > > > @@ -21,6 +21,7 @@ _cleanup()
> > > >   {
> > > >     cd /
> > > >     rm -f $tmp.*
> > > > +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
> >
> > This should use the _unmount helper that's in for-next.
> 
> Sure, it does the same, except that it redirects stdout and stderr to
> $seqres.full.
> 
> Some tests are still calling  $UMOUNT_PROG directly. And that's often
> what we want, so that if umount fails we get a mismatch with the
> golden output instead of ignoring the failure.
> But in this case it's fine.

<groan> You're right, I'd repressed that Chinner decided to introduce
_unmount so that he could improve logging of unmount failures but then
he only bothered converting tests/{generic,xfs} because he didn't give
a damn about anyone else.

Now fstests is stuck with a half finished conversion and no clarity
about whether the rest of the $UMOUNT_PROG invocations should be
converted to _umount or if those are somehow intentional.

Hey Zorro, do you have any opinion on this?  Should someone just finish
the $UMOUNT_PROG -> _unmount conversion next week?

--D

> Anand, since you've already merged this patch into your repo, can you
> please replace that line with the following?
> 
> _unmount $seq_mnt
> 
> Thanks.
> 
> >
> > --D
> >
> > > >     rm -rf $seq_mnt > /dev/null 2>&1
> > > >     cleanup_dmdev
> > > >   }
> > >
> > >
> > > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > >
> > >
> > >
> 

