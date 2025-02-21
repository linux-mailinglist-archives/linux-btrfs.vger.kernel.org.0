Return-Path: <linux-btrfs+bounces-11706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE87A400B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 21:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ADE3B724A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC9253346;
	Fri, 21 Feb 2025 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al0gD3Ku"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F91FBC86;
	Fri, 21 Feb 2025 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169366; cv=none; b=cF+7WNLkXH6BfuAdZfhwLvEAnLCfok7WxGH6fJcgOHUn7FYD/kJb5GjEW6jxSzamnK61YuEsB/+4Dy/zD1Sw85Dhltkg63/EF2n34lIICWAafHQnA8GsJFjwfZYHEaZ5yol8WHBApKZba68rXKv3yPVZlTLyBAZg360ZM0SSotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169366; c=relaxed/simple;
	bh=OyfFSNFOZhz2ZZXwktr473MPDHGeSiTuMaLR3HxJdUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMzNB/3Sg6BlQ78xpuwkT36Ku2/tsTXxjmW9CStlcrvMW+GBc9yBv3QMZcaPY6PazHMu9R/HuHWFqSKwQopWlWNhcqQubO6ZnIWBmtKnQa3QsT6w/AXFVYXwVh5RpvZwAmZ8EGuhojfWh1K2puuRgJP+H+wHRLr/IMXdKsqvBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al0gD3Ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDC8C4CED6;
	Fri, 21 Feb 2025 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740169365;
	bh=OyfFSNFOZhz2ZZXwktr473MPDHGeSiTuMaLR3HxJdUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Al0gD3Ku/WETML+UeraPDLo91a1LS4jYIr+bBwQ7lJa7UVskuufKPyzI+fKGvWbEW
	 6K7A5WmVrM6sLPZXWMELEFBX1GewVSyJDAy+zQmfjylO4sNg8bDHub7KIL9ne473JW
	 MuLEs18iUNWlqNIske/J2xJ3Rk9HAxq5e/X0OYnkmg3wpt9u1k7J7DuE+3K2+zUvbk
	 54tt7jbmb+SsPVR5vkPkZw1H7pw/gOAbJPlaEQaWYJbLGk39tBJNz40RxfgaXmiZOn
	 RiUDNbpHLG5YRx4DFWnHBXSMywWWWvddv0mWJcOTwetJsGAuYnQgoaCnKdAoOr3vIo
	 FfxiEe7DhxT9g==
Date: Fri, 21 Feb 2025 12:22:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs/254: don't leave mount on test fs in case of
 failure/interruption
Message-ID: <20250221202244.GZ21799@frogsfrogsfrogs>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
 <20250221041819.GX21799@frogsfrogsfrogs>
 <20250221060243.4wgr4s64mz7qaxlf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221060243.4wgr4s64mz7qaxlf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Feb 21, 2025 at 02:02:43PM +0800, Zorro Lang wrote:
> On Thu, Feb 20, 2025 at 08:18:19PM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 20, 2025 at 06:22:57PM +0000, Filipe Manana wrote:
> > > On Thu, Feb 20, 2025 at 5:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 01:27:32PM +0800, Anand Jain wrote:
> > > > > On 20/2/25 02:19, fdmanana@kernel.org wrote:
> > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > If the test fails or is interrupted after mounting $scratch_dev3 inside
> > > > > > the test filesystem and before unmounting at test_add_device(), we leave
> > > > > > without being unable to unmount the test filesystem since it has a mount
> > > > > > inside it. This results in the need to manually unmount $scratch_dev3,
> > > > > > otherwise a subsequent run of fstests fails since the unmount of the
> > > > > > test device fails with -EBUSY.
> > > > > >
> > > > > > Fix this by unmounting $scratch_dev3 ($seq_mnt) in the _cleanup()
> > > > > > function.
> > > > > >
> > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > > ---
> > > > > >   tests/btrfs/254 | 1 +
> > > > > >   1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > > > > index d9c9eea9..6523389b 100755
> > > > > > --- a/tests/btrfs/254
> > > > > > +++ b/tests/btrfs/254
> > > > > > @@ -21,6 +21,7 @@ _cleanup()
> > > > > >   {
> > > > > >     cd /
> > > > > >     rm -f $tmp.*
> > > > > > +   $UMOUNT_PROG $seq_mnt > /dev/null 2>&1
> > > >
> > > > This should use the _unmount helper that's in for-next.
> > > 
> > > Sure, it does the same, except that it redirects stdout and stderr to
> > > $seqres.full.
> > > 
> > > Some tests are still calling  $UMOUNT_PROG directly. And that's often
> > > what we want, so that if umount fails we get a mismatch with the
> > > golden output instead of ignoring the failure.
> > > But in this case it's fine.
> > 
> > <groan> You're right, I'd repressed that Chinner decided to introduce
> > _unmount so that he could improve logging of unmount failures but then
> > he only bothered converting tests/{generic,xfs} because he didn't give
> > a damn about anyone else.
> > 
> > Now fstests is stuck with a half finished conversion and no clarity
> > about whether the rest of the $UMOUNT_PROG invocations should be
> > converted to _umount or if those are somehow intentional.
> > 
> > Hey Zorro, do you have any opinion on this?  Should someone just finish
> > the $UMOUNT_PROG -> _unmount conversion next week?
> 
> The release of this week will have your big randome-fixes. Next release will
> deal with your 10 PRs mainly :) So I'll deal with the "$UMOUNT_PROG ->
> _unmount conversion" after that. Anyway, we still can review the "conversion"
> patch at first.

Ok.  Let's do that next week.

--D

> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > > Anand, since you've already merged this patch into your repo, can you
> > > please replace that line with the following?
> > > 
> > > _unmount $seq_mnt
> > > 
> > > Thanks.
> > > 
> > > >
> > > > --D
> > > >
> > > > > >     rm -rf $seq_mnt > /dev/null 2>&1
> > > > > >     cleanup_dmdev
> > > > > >   }
> > > > >
> > > > >
> > > > > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > > > >
> > > > >
> > > > >
> > > 
> > 
> 
> 

