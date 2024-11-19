Return-Path: <linux-btrfs+bounces-9752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53D9D1C8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66463B23035
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 00:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7D20328;
	Tue, 19 Nov 2024 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PagHbR+u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A031804E;
	Tue, 19 Nov 2024 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976292; cv=none; b=KjJVmRtdXa01VaRnImLjSxYzNKZAfzyBB3aCsFF6BK1GUOwju1ICBtJtN4jGRrutVNJKuzKsAYNDl3PB1oxdFlP+mo61rnqbsWk1Ez0uzfjjUfNcOSbMoaJH91hjfhRvS0s4seBpQmIwh8gG4RnbfgjpKvEI/eh6+Vnf/SNE+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976292; c=relaxed/simple;
	bh=Q45ZIPQ9YbB5QnPTR8wHNgDAlut8pVq8PhNLlE0fgnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9H4UJJgAH+I3tA2wOK/3MLd0plHmlnpWZNBbGNHZDiVPbU7GCAlHUQcvPMbtmigxJ6FWhKK3UPZUfJtF0ydlCBRU73MlBIes0px9IMNsycyfHEIUMAIAMoK7qFSo9dBYSmrsvQfCKnsGsKwncasHHCnphAMKbNNGle0AVU8mLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PagHbR+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB4EC4CECC;
	Tue, 19 Nov 2024 00:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731976291;
	bh=Q45ZIPQ9YbB5QnPTR8wHNgDAlut8pVq8PhNLlE0fgnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PagHbR+uSpSSIl/IspyahK+zXswl5oW6XM5P+PTmGoWttRzoF5hvteJlnVh5tmKC8
	 8z9kNp9nlO9HfrY/CfNaQo+SgXbnaB8KdUsiZi50dOgMAuiHKBcaokBKX6wo/JK1SA
	 mwyMdFPGbFrtG8HCIqka8x0WdQe3YSnyLeqAS9OkrVm/hmlmtu85vNsznEoLIJTzHD
	 tUK2ZKkF9fHUAeahAVYwSkrHKR0dIZ1AzOcOkyj7nB5IsQNcglohPVLTgfbUbsgx0t
	 qn6x8hjlTWJ3c++HjdMCrLClfF9lg5J9E+WkoL4ZjUfGvZehZLOuxDM3l5ptAx6e7Y
	 iwSjCcwfSDGpw==
Date: Mon, 18 Nov 2024 16:31:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: zlang@redhat.com, linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/12] generic/562: handle ENOSPC while cloning gracefully
Message-ID: <20241119003131.GT9438@frogsfrogsfrogs>
References: <173197064408.904310.6784273927814845381.stgit@frogsfrogsfrogs>
 <173197064501.904310.1505759730439532159.stgit@frogsfrogsfrogs>
 <CAL3q7H5KjvXsXzt4n0XP1FTUt=A5cKom7p+dGD6GG-iL7CyDXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5KjvXsXzt4n0XP1FTUt=A5cKom7p+dGD6GG-iL7CyDXQ@mail.gmail.com>

On Tue, Nov 19, 2024 at 12:17:56AM +0000, Filipe Manana wrote:
> On Mon, Nov 18, 2024 at 11:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > This test creates a couple of patterned files on a tiny filesystem,
> > fragments the free space, clones one patterned file to the other, and
> > checks that the entire file was cloned.
> >
> > However, this test doesn't work on a 64k fsblock filesystem because
> > we've used up all the free space reservation for the rmapbt, and that
> > causes the FICLONE to error out with ENOSPC partway through.  Hence we
> > need to detect the ENOSPC and _notrun the test.
> >
> > That said, it turns out that XFS has been silently dropping error codes
> > if we managed to make some progress cloning extents.  That's ok if the
> > operation has REMAP_FILE_CAN_SHORTEN like copy_file_range does, but
> > FICLONE/FICLONERANGE do not permit partial results, so the dropped error
> > codes is actually an error.
> >
> > Therefore, this testcase now becomes a regression test for the patch to
> > fix that.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  tests/generic/562 |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >
> > diff --git a/tests/generic/562 b/tests/generic/562
> > index 91360c4154a6a2..62899945003513 100755
> > --- a/tests/generic/562
> > +++ b/tests/generic/562
> > @@ -15,6 +15,9 @@ _begin_fstest auto clone punch
> >  . ./common/filter
> >  . ./common/reflink
> >
> > +test "$FSTYP" = "xfs" && \
> > +       _fixed_by_kernel_commit XXXXXXXXXX "xfs: don't drop errno values when we fail to ficlone the entire range"
> > +
> >  _require_scratch_reflink
> >  _require_test_program "punch-alternating"
> >  _require_xfs_io_command "fpunch"
> > @@ -48,8 +51,11 @@ while true; do
> >  done
> >
> >  # Now clone file bar into file foo. This is supposed to succeed and not fail
> > -# with ENOSPC for example.
> > -_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full
> > +# with ENOSPC for example.  However, XFS will sometimes run out of space.
> > +_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full 2> $tmp.err
> > +cat $tmp.err
> > +grep -q 'No space left on device' $tmp.err && \
> > +       _notrun "ran out of space while cloning"
> 
> This defeats the original purpose of the test, which was to verify
> btrfs didn't fail with -ENOSPC (or any other error).
> 
> If XFS has an ENOSPC issue in some cases, and it's not fixable, why
> not make it _notrun only if it's XFS that is being tested?

Ok, will do.  In the case of xfs, we don't let you share data if the
allocation group it's in is more than about 90% full.

--D

> Thanks.
> 
> 
> >
> >  # Unmount and mount the filesystem again to verify the operation was durably
> >  # persisted.
> >
> >
> 

