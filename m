Return-Path: <linux-btrfs+bounces-10498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A89F5320
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7DD188E045
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624C1F76A9;
	Tue, 17 Dec 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSLy7o/6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99ED14A4E7;
	Tue, 17 Dec 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456144; cv=none; b=mHljrhMQ4Xa+7WiybmgRu65YaZm99S4WZ81cEaxRWV67AHZh5MQ9T0KZ+fWx62ibo5W2r73j0vYWVwyrgq+sOfsKx66XoyvXV8O/pNYDLS9l9eiJvyy8tBLyZnN8Qa9+/nRU9Dg2vAuXUM9/Di/ij93IdE0hBaMDLQqjbuEbE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456144; c=relaxed/simple;
	bh=ZeaSJitOrxJAVSgZ4QpwxxQD+1/fBzOzJBF86aEIk/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1Fck5+uOLfJ+AeTb25GNvF/IcDA6T8Pit0Q4nBHy1N3Y7AnU5I6XMIq5yP+qv8JQTLTiV/L3keetlLVUl52bHvDUOFbUt3nRGPMUGNiHsRCaQh0whNE46yVUJ7rLCVUaX1zStdBBZIygfYvhm3GJ9DmFJQBFCkkSZSjfNPYro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSLy7o/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73041C4CED3;
	Tue, 17 Dec 2024 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456144;
	bh=ZeaSJitOrxJAVSgZ4QpwxxQD+1/fBzOzJBF86aEIk/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSLy7o/6iI4ecchlCCGmu7HjonPTrujaWiP1Y+HOMXkrvR5J7tXsBoitQD4LI+dZS
	 7Zd+C+FoVGLIumr0aBGLQQyVA57sRmua2gBPG6oujMeej3CKKDsK0et8cNGzv3B6ke
	 xNHtbAlSeBmmfDoe0nYHxt+YOkYJQxrSGp4nmv9+gyeMtcqCpgCCMO3+ZstqTacGOw
	 m4D9uKfUe9Y1v+WUiGCdiDGR5dYE8HYQRSbAU8MR+5Sa4FiglnP/mjSYFQzk0ZyA0i
	 G/ztd4x/tFUkCnQoMheGKkNzB8mBMwbOyr1H4Dc43VLSUPwrYbhI4dG62y2Tp7ccEn
	 8VQmjFlqAMdsg==
Date: Tue, 17 Dec 2024 09:22:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
Message-ID: <20241217172223.GA6160@frogsfrogsfrogs>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
 <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>

On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
> On Tue, Dec 17, 2024 at 8:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> > > The test also fails sporadically on xfs and the bug was already reported
> > > to the xfs mailing list:
> > >
> > >    https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> > >
> >
> > This version still doesn't seem to have the fs freeze/unfreeze that Darrick
> > asked for in that thread.
> 
> I don't get it, what's the freeze/unfreeze for? Where should they be placed?
> Is it some way to get around the bug on xfs?

freeze kicks the background inode gc thread so that the unlinked clones
actually get freed before the swapon call.  A less bighammer idea might
be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
collectors.

--D

