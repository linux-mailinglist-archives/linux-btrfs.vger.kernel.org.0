Return-Path: <linux-btrfs+bounces-6878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D65D9413B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A186A1C23137
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306EC1A08BC;
	Tue, 30 Jul 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fVfLAy/7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G3mFvTsB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fVfLAy/7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G3mFvTsB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE51A08A0
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347751; cv=none; b=noZCxxkuVo7fgAzc7MGepJOlhkLJvpokTiZcX0NDCqASDidrn73w4XMdary8W+pcG98Oc7VyzHSg/0UqYGVURYMgVhnel94ILGEZA5C1NkADCn+FX4cPADTL8YlzaAOk99jZrOK073Qcd9CHOKON4fudRU3sWK6ye2OJYzgMgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347751; c=relaxed/simple;
	bh=goVgA0KFMIu7BSWxpzJXvfEraWlIBYi2kG/lG1Ug45o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEhtXZnyR0JkZ/ZT1fW8AGBpfyOk8Ra3AKbmg0oScn7LPou/BATf0P5i1/gc3X13rwz5bO78oOI/HJV2wJV7psbLObxEtrlU8z8JCPSQasAw2YBwS55EMjKz/QySdN8t0ekXbwr83SNLgDR9ZvQsEHSV9I32RfTMB6RLnbOO0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fVfLAy/7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G3mFvTsB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fVfLAy/7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G3mFvTsB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D484A21B2B;
	Tue, 30 Jul 2024 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ColuOXnBP9sqOKmdQaLzvaNu0BDLfC4sANXv1jMC+yA=;
	b=fVfLAy/7VxsYMgsQ9A+PYvi76kXokNEtI+/Pzpu0SKbjzVYQgwhqIYT3c1hUwCunTkVbYv
	rHI3GJJ+ykLbgpjGEceAG6MiYLiFvRegL+ZMpEG9+msCZRVtVLF/lWjnqhRGxH23mBPweE
	u26APNlt+pWple1mdw0q6x2VJcjT+nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ColuOXnBP9sqOKmdQaLzvaNu0BDLfC4sANXv1jMC+yA=;
	b=G3mFvTsB4/l8fgKK178x7VGIZ7qF/isZJWfLS/KNlUICPGwbUzce8c5uEl/eyVbmMa8bC1
	dZ64sxuapPxknvCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ColuOXnBP9sqOKmdQaLzvaNu0BDLfC4sANXv1jMC+yA=;
	b=fVfLAy/7VxsYMgsQ9A+PYvi76kXokNEtI+/Pzpu0SKbjzVYQgwhqIYT3c1hUwCunTkVbYv
	rHI3GJJ+ykLbgpjGEceAG6MiYLiFvRegL+ZMpEG9+msCZRVtVLF/lWjnqhRGxH23mBPweE
	u26APNlt+pWple1mdw0q6x2VJcjT+nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ColuOXnBP9sqOKmdQaLzvaNu0BDLfC4sANXv1jMC+yA=;
	b=G3mFvTsB4/l8fgKK178x7VGIZ7qF/isZJWfLS/KNlUICPGwbUzce8c5uEl/eyVbmMa8bC1
	dZ64sxuapPxknvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD68813983;
	Tue, 30 Jul 2024 13:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ymH5LePwqGbLYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 13:55:47 +0000
Date: Tue, 30 Jul 2024 15:55:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
Message-ID: <20240730135538.GC17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1720159494.git.wqu@suse.com>
 <20240705145543.GB879955@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705145543.GB879955@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Fri, Jul 05, 2024 at 10:55:43AM -0400, Josef Bacik wrote:
> On Fri, Jul 05, 2024 at 03:45:37PM +0930, Qu Wenruo wrote:
> > This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
> > DEBUG builds.
> > 
> > There are 3 call sites utilizing __GFP_NOFAIL:
> > 
> > - __alloc_extent_buffer()
> >   It's for the extent_buffer structure allocation.
> >   All callers are already handling the errors.
> > 
> > - attach_eb_folio_to_filemap()
> >   It's for the filemap_add_folio() call, the flag is also passed to mem
> >   cgroup, which I suspect is not handling larger folio and __GFP_NOFAIL
> >   correctly, as I'm hitting soft lockups when testing larger folios
> > 
> >   New error handling is added.
> > 
> > - btrfs_alloc_folio_array()
> >   This is for page allocation for extent buffers.
> >   All callers are already handling the errors.
> > 
> > Furthermore, to enable more testing while not affecting end users, the
> > change is only implemented for DEBUG builds.
> > 
> > Qu Wenruo (3):
> >   btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
> >   btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
> >   btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()
> 
> The reason I want to leave NOFAIL is because in a cgroup memory constrained
> environment we could get an errant ENOMEM on some sort of metadata operation,
> which then gets turned into an aborted transaction.  I don't want a memory
> constrained cgroup flipping the whole file system read only because it got an
> ENOMEM in a place where we have no choice but to abort the transaction.
> 
> If we could eliminate that possibility then hooray, but that's not actually
> possible, because any COW for a multi-modification case (think finish ordered
> io) could result in an ENOMEM and thus a transaction abort.  We need to live
> with NOFAIL for these cases.  Thanks,

I agree with keeping NOFAIL.  Please add the above as a comment to
btrfs_alloc_folio_array().

