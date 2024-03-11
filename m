Return-Path: <linux-btrfs+bounces-3168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86519877AC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 06:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65971C21463
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 05:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E910A3D;
	Mon, 11 Mar 2024 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oERJMVAJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59962FC17
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710136156; cv=none; b=NgTJgxU81FxsGotgYF2s5emMkRO5aSXM8ZdP+bLwWFRr36KhMRyu4W3zLKFJBGASAKwWdGP0I5D42okXqoppzJrSAcVMSOcgW9FTJ9mQ9HbaSQVZVPSnD8lyfRqL+2VhUeDTwkkdf1i8TfFZb37vBMDGS3yy6KvFg/shSRTzEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710136156; c=relaxed/simple;
	bh=Z6cqolKDpJQd55JrfdXxt3JoNMl424ciH8Eaawonlck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXyHH8jM5xVaCi4NmJAo7lywrFLGJ332ilnwMB1jKiRlaZYChX5wmARNSIqjhdXZ32qTtutXLEOwkv8DjX2mueJ0+WZAmmDxEfI6mczqU+aXh8IhPSLkgF50rPBawvdA3IUB58BB59H/qy3cu9n8JfrEJkRkMLiw/upiPY+PRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oERJMVAJ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Mar 2024 01:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710136152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPF/wGUlrmECSHZ02Z5/7MM0dASCOcabKL9s7iF20VE=;
	b=oERJMVAJEYNR5cNfxivh4EkpcUHWVBNtOjyFQfNZglN71yqjIbZR+jJpG6vJhhlEJ+5/vu
	RTe7m2axVJZZ9bCkDsD16CLoyamv/pvr1hFUG3fwQlRS2q6HTo8gwXTJAr1DoDt/jyVQ83
	nqZ0IqyWkb/i76wINxKImvheGWU9IHI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dave Chinner <david@fromorbit.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Neal Gompa <neal@gompa.dev>, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <nsfwsznghuaeimuk2waym3ioghcviidlgt3ozdzpaozw4g3z3o@o5lttjrqcin4>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
 <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
 <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
 <2uk6u4w7dp4fnd3mrpoqybkiojgibjodgatrordacejlsxxmxz@wg5zymrst2td>
 <20240308165633.GO6184@frogsfrogsfrogs>
 <Ze5ppBOFpVm1jyb+@dread.disaster.area>
 <CAJfpeguu=DCvtU7dudXNncbxvy5joqS1Xp0Yf590UFPna6qZ2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguu=DCvtU7dudXNncbxvy5joqS1Xp0Yf590UFPna6qZ2A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 11, 2024 at 06:30:21AM +0100, Miklos Szeredi wrote:
> On Mon, 11 Mar 2024 at 03:17, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Mar 08, 2024 at 08:56:33AM -0800, Darrick J. Wong wrote:
> > > Should the XFS data and rt volumes be reported with different stx_vol
> > > values?
> >
> > No, because all the inodes are on the data volume and the same inode
> > can have data on the data volume or the rt volume. i.e. "data on rt,
> > truncate, clear rt, copy data back into data dev".  It's still the
> > same inode, and may have exactly the same data, so why should change
> > stx_vol and make it appear to userspace as being a different inode?
> 
> Because stx_vol must not be used by userspace to distinguish between
> unique inodes.  To determine if two inodes are distinct within a
> filesystem (which may have many volumes) it should query the file
> handle and compare that.
> 
> If we'll have a filesystem that has a different stx_vol but the same
> fh, all the better.

I agree that stx_vol should not be used for uniqueness testing, but
that's a non sequitar here; Dave's talking about the fact that volume
isn't a constatn for a given inode on XFS. And that's a good point;
volumes on XFS don't map to the filesystem path heirarchy in a nice
clean way like on btrfs and bcachefs (and presumably ZFS).

Subvolumes on btrfs and bcachefs form a tree, and that's something we
should document about stx_subvol - recursively enumerable things are
quite nice to work with.

