Return-Path: <linux-btrfs+bounces-2544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7185ACFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 21:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08DBB25D20
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D0535D0;
	Mon, 19 Feb 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="235wwiap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EaDPUl7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nxo036ya";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+PnHmjo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDFE535A4;
	Mon, 19 Feb 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373945; cv=none; b=F6HwzTiNEuUU3seT4lEOSrhmpdmagZuzNUpoFIWpkjfmTYcv8EKkhfxrdtlPI11aQLnROWjGHTKSK4KmwI8e1DCltAmTg1LV22x/ICBJxPThtebjjRh+HjN35Y23vFtAfqMxbVnE8JTDkh/cLMJ8N4m03TNrtsj2fhmb+15grcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373945; c=relaxed/simple;
	bh=iGX9cdeVIG/Ztjd5mQgNxssxqzc3sAxG96dgQzy/YS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTJKNBJqE51n4l+Q9rgjrWSui/tzAGM6YbIsUddU1UsfOk3nzxic0laE6NUqUCDVM+PU/P5uGI4x3ftJUlt4PgVsDckPWlEWDeIrZKOttzbDkhDO3RF49UOhdVXWURzU/VFgm9QGt1IADSNP90O3NOCIXAOLx6D7W1squUNjQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=235wwiap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EaDPUl7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nxo036ya; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+PnHmjo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A024220F3;
	Mon, 19 Feb 2024 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708373942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCE8EaVxyZoWlyZBAsJkeD3EuUy/CWpepR2maKVU6M=;
	b=235wwiapNRduYgHbIs528Aq5VjH/56tDgtfSlvsBzQ36h6uERgW3piw1tGiMPaAkyD2WDq
	FL1rNtgTb/c3UJJowukjhe2KiaBCaPVRpSc8ceDnDQsTId4ZH+FIJQJxQsXNevlKp01a2s
	c7eQZl3hwCg/R6VPLErdbkUGyRGCOUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708373942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCE8EaVxyZoWlyZBAsJkeD3EuUy/CWpepR2maKVU6M=;
	b=1EaDPUl7ZXhHnR0wnm1ZbFbZI4vtksRYwjFFpAK0VW8X5L2mS+BLwv2rSYK2p20z52WDgM
	pCTlWWoP1n6/naCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708373940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCE8EaVxyZoWlyZBAsJkeD3EuUy/CWpepR2maKVU6M=;
	b=Nxo036ya6g717+/g4J0n5XpbRClMwUCuU7l8Mqe3gX1RcqaREWkYySGBjd0Sd0BnzxvQOz
	VOIblsxM3fVpz9V17DfHQMl63b9sFo38HsiyrB7zfbPMVWVV1JU3HOzeUXMWi4twikeA4T
	0RQRP2G4ivYrIwLwujHi+EkWDayUbEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708373940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCE8EaVxyZoWlyZBAsJkeD3EuUy/CWpepR2maKVU6M=;
	b=f+PnHmjoVTyDsc5ajOZz+ugjulMcWKauf9q4+cvjRuhUCQ94XXuqS5mXhToyUpbtpf3V7x
	EdTZtnq+NADEsMBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5681E13585;
	Mon, 19 Feb 2024 20:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id M3+cFLS302WUXAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 19 Feb 2024 20:19:00 +0000
Date: Mon, 19 Feb 2024 21:18:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: open block devices after superblock creation
Message-ID: <20240219201824.GA355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
 <20240214-hch-device-open-v1-4-b153428b4f72@wdc.com>
 <20240214185809.GC377066@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214185809.GC377066@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.77%]
X-Spam-Flag: NO

On Wed, Feb 14, 2024 at 10:58:09AM -0800, Boris Burkov wrote:
> On Wed, Feb 14, 2024 at 08:42:15AM -0800, Johannes Thumshirn wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Currently btrfs_mount_root opens the block devices before committing to
> > allocating a super block. That creates problems for restricting the
> > number of writers to a device, and also leads to a unusual and not very
> > helpful holder (the fs_type).
> > 
> > Reorganize the code to first check whether the superblock for a
> > particular fsid does already exist and open the block devices only if it
> > doesn't, mirroring the recent changes to the VFS mount helpers.  To do
> > this the increment of the in_use counter moves out of btrfs_open_devices
> > and into the only caller in btrfs_mount_root so that it happens before
> > dropping uuid_mutex around the call to sget.
> 
> I believe this commit message is now out of date as of
> 'btrfs: remove old mount API code'
> which got rid of btrfs_mount_root.

It's not just that, this patchset was sent before the conversion to new
mount API that changed how devices are scanned (and potentially race
with mount). The changelog should be updated at minimum.

I haven't found any problems so far, the locking around device opening
should serialize any races so the one thread winning will open the super
block and the other will inherit the fs_devices.

