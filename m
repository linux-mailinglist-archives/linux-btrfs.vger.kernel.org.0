Return-Path: <linux-btrfs+bounces-10583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80779F6EBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF91694EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868E1FC7E3;
	Wed, 18 Dec 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc+EikQj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B21FC7C9;
	Wed, 18 Dec 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552568; cv=none; b=loawFhc7OfJMsgtqX2Mnw3VppfcvAdIg7L9UwW8ERXHPZo+FIHHA8wgu5SA8pfuaFuQxh4A6bEzMuP9Y0hIIbRstrdoCOn6pCXHc0UPDK+cHsYM/M8sHDpwGs78ZnLS/zXGP3B3dzkVKAank7S8dHfD2v75EpBp6EAzaECdUBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552568; c=relaxed/simple;
	bh=B/cOJhbra6lL7SgWOSgbpY/TIMkm2vRhiQG/WFbweJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTdCg7MuT2Q1Z2X+Epi/my1L945DrcPzhPh9i60mqJdEsw9l/ic+3F6qMkkXorKvfYCW+UW2YbUqCDAvy5/Qnhgh58hOEOIKLhKVxXIubdJVqQnJQfnuMdekBWCJCIJpLPRBuMTXqHr3fQkX1KCa9IMAGNRg51UTRPoAvhSRdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc+EikQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC77CC4CED7;
	Wed, 18 Dec 2024 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734552567;
	bh=B/cOJhbra6lL7SgWOSgbpY/TIMkm2vRhiQG/WFbweJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yc+EikQj0knYCTZA71OpUm7q8NPsHipDxELLHlbAD1tEbnTYmcLnXrFS7wqKAjR9/
	 g2RrTZab++RBubfMCariHS20hejO0p3v16Bn7HdJXCi+wezBWynbinOmOmprNYWRuh
	 q1bfsVVcTGlZnDOXPevon6/QKCwZ4UlUdy2Uch9LwKZYYyJbNTSYxzsJFIzVpa42Qu
	 gxwMjbKUVMyvMvQy3ZhLlUdPGdoGQmBYzYglChFzPSvYd9ntLfl4XafLh+/GQSxjuL
	 OG9s8ndhkb9TPL+lmd/9AfiYYJr9NPJ+/QCyMdkK8Y0jbDkTpA5QuX8T+nhE0kG+HH
	 mYehrcg3qFbkw==
Date: Wed, 18 Dec 2024 12:09:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
Message-ID: <20241218200927.GC6160@frogsfrogsfrogs>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
 <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs>
 <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>

On Wed, Dec 18, 2024 at 09:07:26AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/18 03:52, Darrick J. Wong 写道:
> > On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
> > > On Tue, Dec 17, 2024 at 8:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > 
> > > > On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> > > > > The test also fails sporadically on xfs and the bug was already reported
> > > > > to the xfs mailing list:
> > > > > 
> > > > >     https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> > > > > 
> > > > 
> > > > This version still doesn't seem to have the fs freeze/unfreeze that Darrick
> > > > asked for in that thread.
> > > 
> > > I don't get it, what's the freeze/unfreeze for? Where should they be placed?
> > > Is it some way to get around the bug on xfs?
> > 
> > freeze kicks the background inode gc thread so that the unlinked clones
> > actually get freed before the swapon call.  A less bighammer idea might
> > be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
> > collectors.
> 
> I'm wondering why this GC things can not be done inside XFS' swapon call?
> 
> So that we don't need some per-fs workaround in a generic test case.

I suppose one could call xfs_inodegc_flush from within swapon with the
swap file's i_rwsem held, but now we're blocking swapon while we wait
for some unbounded number of probably unrelated unlinked inodes to be
freed on the off chance that one of them shared blocks.

A better answer might be to run FALLOC_FL_UNSHARE on the file, but now
we're making swapon more complex and potentially issuing a lot of IO to
make that happen.  If you can convince the fsdevel/mm folks that swapon
is supposed to try to correct things it doesn't like in the file mapping
(instead of returning EINVAL or whatever it does now) then we could add
that to the syscall definition.

--D

> Thanks,
> Qu
> > 
> > --D
> > 
> 
> 

