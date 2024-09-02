Return-Path: <linux-btrfs+bounces-7742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96039968ED2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E923281DD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBF51C62AB;
	Mon,  2 Sep 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zRLJWoXl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIPDnzD3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zRLJWoXl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIPDnzD3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118821A4E71;
	Mon,  2 Sep 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308609; cv=none; b=DxH0fZ8w7dDjuem2ZMyxScF2+nWllNlQDguAnpIp9hwjy7W0myIT1Dplc1P4CBBI7NUE/L3Eta0QeyJrfdRcNVHGl2Q9Kjx6WMd4K+0nwwA9/sEqi//aoE9GYI5yC1hWe4stlWm0AIpF53KK+nfZZ9FxEn3v7vP9e9JagRMHGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308609; c=relaxed/simple;
	bh=++lgzoh37Vxo6Ba03kWmVHFHoQWmY0grJKo+XsWZHgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrH+k7dyXYiM4oB0tr3fcyRa0R+H6W45U0VwhxR0T/7l5jRUInJuB5UPoXMkfJGVsPCNczNbFtirUkrYnupyU2i3PnN1foo4SXUKLVXgqvPfnZbLTvHQQ0NBL+xfJ2lS3NJdZFFbZwL4sxl57v3KGStBBdXMBnEfY6rVdw5/Ctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zRLJWoXl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIPDnzD3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zRLJWoXl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIPDnzD3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2855F1FC81;
	Mon,  2 Sep 2024 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725308605;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSxYCS5BrLlCCdm+Sy0MfOucZsAL9LrffyT4xetn4Vg=;
	b=zRLJWoXltvyJDh9truzgCtp2hbWdf8YE35XsdF0VbO1c52PM0FhSqX5yBJphBXAejWk5gs
	a44NnjOLEJAa5271943fjXwBXoNp32hrlEF8XOwveWxGAavxC6I4DMZQwUZIIDE3oQMiuY
	6t8CjAMLaUqFJivWOkjB2keHmL7S49c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725308605;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSxYCS5BrLlCCdm+Sy0MfOucZsAL9LrffyT4xetn4Vg=;
	b=lIPDnzD3s8cKBkrqPAx+bEnkyNECXtprscoNh04iWFWE8ge3IV0k8zmk8KH3/+f0T2/LB4
	vjlMDue6xKTZvWAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725308605;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSxYCS5BrLlCCdm+Sy0MfOucZsAL9LrffyT4xetn4Vg=;
	b=zRLJWoXltvyJDh9truzgCtp2hbWdf8YE35XsdF0VbO1c52PM0FhSqX5yBJphBXAejWk5gs
	a44NnjOLEJAa5271943fjXwBXoNp32hrlEF8XOwveWxGAavxC6I4DMZQwUZIIDE3oQMiuY
	6t8CjAMLaUqFJivWOkjB2keHmL7S49c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725308605;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSxYCS5BrLlCCdm+Sy0MfOucZsAL9LrffyT4xetn4Vg=;
	b=lIPDnzD3s8cKBkrqPAx+bEnkyNECXtprscoNh04iWFWE8ge3IV0k8zmk8KH3/+f0T2/LB4
	vjlMDue6xKTZvWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 053CF13A21;
	Mon,  2 Sep 2024 20:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhPLAL0e1mbNGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 20:23:25 +0000
Date: Mon, 2 Sep 2024 22:23:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Split remaining space to discard in chunks
Message-ID: <20240902202323.GC26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240902114303.922472-1-luca.stefani.ge1@gmail.com>
 <20240902201150.GB26776@twin.jikos.cz>
 <4bef0c7b-df8b-41dc-9fe1-022cc4937def@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bef0c7b-df8b-41dc-9fe1-022cc4937def@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmx.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 02, 2024 at 10:17:37PM +0200, Luca Stefani wrote:
> > 		  sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
> >    {
> > 	  struct bio *bio;
> > 
> > 	  while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
> > 			  gfp_mask)))
> > 		  *biop = bio_chain_and_submit(*biop, bio);
> > 	  return 0;
> >    }
> > 
> > This is basically just a loop, chopping the input range as needed. The
> > btrfs code does effectively the same, there's only the superblock,
> > progress accounting and error handling done.
> > 
> > As the maximum size of a single discard request depends on a device we
> > don't need to artificially limit it because this would require more IO
> > requests and can be slower.
> 
> Thanks for taking a look, this change was prompted after I've been 
> seeing issues due to the discard kthread blocking an userspace process 
> causing device not to suspend.
> https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/ 
> is the proposed solution, but Qu mentioned that there is another place 
> where it could happen that I didn't cover, and I think what I change 
> here (unless it's the wrong place) allows me to add the similar 
> `btrfs_trim_interrupted` checks to stop.
> 
> Please let me know if that makes sense to you, if that's the case I 
> guess it would make sense to send the 2 patches together?

Yeah for inserting the cancellation points it would make sense to do the
chunking. I'd suggest to do the same logic like blk_alloc_discard_bio()
and use the block device discard request limit and not a fixed constant.

