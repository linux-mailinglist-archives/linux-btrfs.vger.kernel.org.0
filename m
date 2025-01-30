Return-Path: <linux-btrfs+bounces-11171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03016A2294B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 08:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA14165FFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 07:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EC1AB52F;
	Thu, 30 Jan 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RhdTSUhO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9981A8F8E
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738223106; cv=none; b=U1QTn3VgJYfDgMPlYgchfx6ivvcnke4ATavHeq5brSuwtYcymcR8LqIEdtFTa83uFAlSKd7cfO6H9xsAvu5vjwwxoNp+f2guoI4Ax4hNwjCjxoJNiQKtpk9qK2vLywvjnxy/6nasurVgTfSqDmmSAcT/yA1CGsu6ArdUVaqyjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738223106; c=relaxed/simple;
	bh=yahcI1cZVIr+wGBToeHh4rY1m06wSOEw3dKeRGcA5pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2yBXbkdfRH9SBEdpxWn8wUCWm4upT53ctW5br4j4Ex5P9RCKcnrbBFCEmEHuic3bHVY/SKQ8iqbZ7gPfcw/SPYyycQj+0HwFNEBuMOAry3c/AHyXloVHR47eh8PplOuQpUBQQYkdzHAt4Rz1WaIMa75BIYpZaLJdkPdG1KRuao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RhdTSUhO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Jan 2025 02:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738223095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaKLHwNhsjUdETKJlclOrek2pAJdP8Hih2tCTW/XzEk=;
	b=RhdTSUhOLvHJXyw+PMqkd/DaeKqxxgq2u9Z/G8ompw25Xv4+af5iD28rGVXzkYKVTkQpUa
	6+CRCG4V1ho6r2RT2n5XSaf7c+M66V9cZTbwftQKqQw7vb/3E42lQA6aUo14NDt3i3ZVmv
	T4xVB44o5NElEfXPI0gn0sjwOttUddQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, miklos@szeredi.hu, 
	linux-bcachefs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
Message-ID: <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 29, 2025 at 10:17:49AM -0800, Dave Hansen wrote:
> tl;dr: The VFS and several filesystems have some suspect prefaulting
> code. It is unnecessarily slow for the common case where a write's
> source buffer is resident and does not need to be faulted in.
> 
> Move these "prefaulting" operations to slow paths where they ensure
> forward progress but they do not slow down the fast paths. This
> optimizes the fast path to touch userspace once instead of twice.
> 
> Also update somewhat dubious comments about the need for prefaulting.
> 
> This has been very lightly tested. I have not tested any of the fs/
> code explicitly.

Q: what is preventing us from posting code to the list that's been
properly tested?

I just got another bcachefs patch series that blew up immediately when I
threw it at my CI.

This is getting _utterly ridiculous_.

I built multiuser test infrastructure with a nice dashboard that anyone
can use, and the only response I've gotten from the old guard is Ted
jumping in every time I talk about it to say "no, we just don't want to
rewrite our stuff on _your_ stuff!". Real helpful, that.

>  1. Deadlock avoidance if the source and target are the same
>     folios.
>  2. To check the user address that copy_folio_from_iter_atomic()
>     will touch because atomic user copies do not check the address.
>  3. "Optimization"
> 
> I'm not sure any of these are actually valid reasons.
> 
> The "atomic" user copy functions disable page fault handling because
> page faults are not very atomic. This makes them naturally resistant
> to deadlocking in page fault handling. They take the page fault
> itself but short-circuit any handling.

#1 is emphatically valid: the deadlock avoidance is in _both_ using
_atomic when we have locks held, and doing the actual faulting with
locks dropped... either alone would be a buggy incomplete solution.

This needs to be reflected and fully described in the comments, since
it's subtle and a lot of people don't fully grok what's going on.

I'm fairly certain we have ioctl code where this is mishandled and thus
buggy, because it takes some fairly particular testing for lockdep to
spot it.

> copy_folio_from_iter_atomic() also *does* have user address checking.
> I get a little lost in the iov_iter code, but it does know when it's
> dealing with userspace versus kernel addresses and does seem to know
> when to do things like copy_from_user_iter() (which does access_ok())
> versus memcpy_from_iter().[1]
> 
> The "optimization" is for the case where 'source' is not faulted in.
> It can avoid the cost of a "failed" page fault (it will fail to be
> handled because of the atomic copy) and then needing to drop locks and
> repeat the fault.

I do agree on moving it to the slowpath - I think we can expect the case
where the process's immediate workingset is faulted out while it's
running to be vanishingly small.

