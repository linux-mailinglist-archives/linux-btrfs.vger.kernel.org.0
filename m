Return-Path: <linux-btrfs+bounces-10641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A49FB4A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 20:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A83C1654DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD41B395B;
	Mon, 23 Dec 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q0jTjEyE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHaBNoPx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q0jTjEyE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHaBNoPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307828DA1
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982019; cv=none; b=Aia6m1iSg0awRjhWxi/pTN66bLDTcIpONzWQFB0x4UQUXKoPaiPggn9F9OaBbwafToZWmAkINCotH1K6IcMmkRTQP6+n9qPjQzPXJqnZCKpW5HcdkPUUP2x2MFnEB/5VZmHEP1xmgwbsugT4G6Yg4RHITmLuuWvDtwV2B1BogA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982019; c=relaxed/simple;
	bh=pcrTHYb4LhDt/QEmwcyGFzIPWL5wgZjyv+d4/DgtQk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVNPDNT79fE/Y3yYhL1TEpmqlpU2o9YLXSmrKYhliP1VWGvE272tSkIOCo0TEctDaUsmLfQ6rOGJlR0goAqei4h4eAZRgBj4IDzh5Xly0/+8Ww0qxeAFpfu8ZxqXXkc63foRLavlHMgvC64FTdekHDOZ+RnwXZTSQM6wIVmpC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q0jTjEyE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHaBNoPx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q0jTjEyE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHaBNoPx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20BD922097;
	Mon, 23 Dec 2024 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734982015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT0/3kFBrETotlJCd/NVmnQL42QHDsl8A6OS16ntdAA=;
	b=q0jTjEyEPeHNQ65NGwZRk6a0n6+a+GO5CWvAsHjaA6YDN/zkvryMjbzUnILJi6ONXps9HO
	4EcELHHJy1+5AavpDfmmlZ8e7jWIs7vDattHldzA1l1KK0uHEJW8cTsmmitwmPBnrEzyUF
	NugQyjwsB3KeeYAaEKGcq8kgzSHHRqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734982015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT0/3kFBrETotlJCd/NVmnQL42QHDsl8A6OS16ntdAA=;
	b=rHaBNoPxEg27AmB/U668SC1PAj1XqCQU3qQ/C6p7c2Zr8FzhgWZKFxWd9RR9kEikCP3i9b
	JUxMHxFZi++QCWBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734982015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT0/3kFBrETotlJCd/NVmnQL42QHDsl8A6OS16ntdAA=;
	b=q0jTjEyEPeHNQ65NGwZRk6a0n6+a+GO5CWvAsHjaA6YDN/zkvryMjbzUnILJi6ONXps9HO
	4EcELHHJy1+5AavpDfmmlZ8e7jWIs7vDattHldzA1l1KK0uHEJW8cTsmmitwmPBnrEzyUF
	NugQyjwsB3KeeYAaEKGcq8kgzSHHRqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734982015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT0/3kFBrETotlJCd/NVmnQL42QHDsl8A6OS16ntdAA=;
	b=rHaBNoPxEg27AmB/U668SC1PAj1XqCQU3qQ/C6p7c2Zr8FzhgWZKFxWd9RR9kEikCP3i9b
	JUxMHxFZi++QCWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD4813485;
	Mon, 23 Dec 2024 19:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P99kAn+5aWe0bQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Dec 2024 19:26:55 +0000
Date: Mon, 23 Dec 2024 20:26:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into
 fs.c
Message-ID: <20241223192649.GK31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734368270.git.fdmanana@suse.com>
 <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
 <20241218202117.GG31418@twin.jikos.cz>
 <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Dec 18, 2024 at 08:45:33PM +0000, Filipe Manana wrote:
> On Wed, Dec 18, 2024 at 8:21 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Dec 16, 2024 at 05:17:17PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > The ctree module is about the implementation of the btree data structure
> > > and not a place holder for generic filesystem things like the csum
> > > algorithm details. Move the functions related to the csum algorithm
> > > details away from ctree.c and into fs.c, which is a far better place for
> > > them. Also fix missing punctuation in comments and change one multiline
> > > comment to a single line comment since everything fits in under 80
> > > characters.
> > >
> > > For some reason this also sligthly reduces the module's size.
> > >
> > > Before this change:
> > >
> > >   $ size fs/btrfs/btrfs.ko
> > >      text        data     bss     dec     hex filename
> > >   1782126      161045   16920 1960091  1de89b fs/btrfs/btrfs.ko
> > >
> > > After this change:
> > >
> > >   $ size fs/btrfs/btrfs.ko
> > >      text        data     bss     dec     hex filename
> > >   1782094      161045   16920 1960059  1de87b fs/btrfs/btrfs.ko
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/ctree.c | 51 ------------------------------------------------
> > >  fs/btrfs/ctree.h |  6 ------
> > >  fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/btrfs/fs.h    |  6 ++++++
> >
> > Can you please create a new file for checksums? Moving everything to
> > fs.c looks like we're going to have another ctree.c.
> 
> Is it really worth it? After this patchset fs.c is only 229 lines and
> the csum related functions are just a few and very short.
> My idea would be to do such a thing either when fs.c gets a lot larger
> or we get more csum functions (and/or they get larger).
> 
> But sure, why not, I can do that on top or send a new version of this patch.

Ok leave it as is, if we have more code we can move it. I have some WIP
with checksums so I can move it once it makes more sense.

