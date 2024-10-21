Return-Path: <linux-btrfs+bounces-9043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D046B9A9155
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 22:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379C8B21691
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346A1FDFAD;
	Mon, 21 Oct 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JxuKQQL8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="03P2aYyV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JxuKQQL8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="03P2aYyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF31CF7BF
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542962; cv=none; b=qZoyrh2YzPw0ByE5hHQsMHCPIhI7IFFbEL1gARjRDOb3hKGAYHU1+ShejjCi7un2hEQquyeLHhfVp/xSbQ8DaF1IRFX7yjtzlvga1BndrTBqJ3hS7W8U7G8BiTtmwEp9/1X5xXBlFiW7wJeQWKa7mrdaY4JGdfIiAi3ctl2/aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542962; c=relaxed/simple;
	bh=YAGQBGTV4ij8LhQkDkMAADT0aO4nMBfe0nuf44Gevi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJV8mDtPKVjqMlhN3/hWiJuNzUUsXIL8xlEyeGASV9VUcNJ70M7k3MnfIW+1wKRwv07OPxWNMLW04YuwrV0Dw1IUgu6uAlkrw1LcftI48ZqquNRLlSGArYQI5+c479F+8PqJUJycKKpPF7DVc+DTO2WlcydDh247LqA0S+pA19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JxuKQQL8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=03P2aYyV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JxuKQQL8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=03P2aYyV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A67CD21C8D;
	Mon, 21 Oct 2024 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729542958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkDVan/P7NdxeRcDvjmrn1BTSiUAL8bQV2lJp9abzNc=;
	b=JxuKQQL8AXyU4wbqoa9Yq+C53ThSD/NZUq0XjxGBh1wntir39aDQjjh366bp9kffAAqRR0
	LhueOLSHPnV2z+lk95xlfG06+QEA2H2zNxXw8kL07o7+fpTZXcXmEgyvC9r4iiGSjEwoUe
	I/7rAEpFw5OQDtK8/Uh5kr0IQjGvJKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729542958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkDVan/P7NdxeRcDvjmrn1BTSiUAL8bQV2lJp9abzNc=;
	b=03P2aYyVRoLp0S5sgb4vtK1qgN9WvjVUiFO+YKIiqqgDjgRFXwcMLWoHEoByC7/izHKimJ
	er01Rr3cHug6zEAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JxuKQQL8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=03P2aYyV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729542958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkDVan/P7NdxeRcDvjmrn1BTSiUAL8bQV2lJp9abzNc=;
	b=JxuKQQL8AXyU4wbqoa9Yq+C53ThSD/NZUq0XjxGBh1wntir39aDQjjh366bp9kffAAqRR0
	LhueOLSHPnV2z+lk95xlfG06+QEA2H2zNxXw8kL07o7+fpTZXcXmEgyvC9r4iiGSjEwoUe
	I/7rAEpFw5OQDtK8/Uh5kr0IQjGvJKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729542958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkDVan/P7NdxeRcDvjmrn1BTSiUAL8bQV2lJp9abzNc=;
	b=03P2aYyVRoLp0S5sgb4vtK1qgN9WvjVUiFO+YKIiqqgDjgRFXwcMLWoHEoByC7/izHKimJ
	er01Rr3cHug6zEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F377139E0;
	Mon, 21 Oct 2024 20:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P/qJHi67FmcqRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 20:35:58 +0000
Date: Mon, 21 Oct 2024 22:35:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v5] btrfs: try to search for data csums in commit root
Message-ID: <20241021203557.GF24631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8e334e4412410a46d3928950c796c9914cebdf92.1729537203.git.boris@bur.io>
 <20241021191035.GE24631@twin.jikos.cz>
 <20241021195223.GA2880675@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021195223.GA2880675@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A67CD21C8D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 21, 2024 at 12:52:23PM -0700, Boris Burkov wrote:
> On Mon, Oct 21, 2024 at 09:10:35PM +0200, David Sterba wrote:
> > On Mon, Oct 21, 2024 at 12:01:53PM -0700, Boris Burkov wrote:
> > > +	 * pretty heavy write load, unlike the commit_root_csum.
> >                                                ^^^^^^^^^^^^^^^^
> > 
> > commit_root_sem?
> > 
> > > +	 *
> > > +	 * Due to how rwsem is implemented, there is a possible
> > > +	 * priority inversion where the readers holding the lock don't
> > > +	 * get scheduled (say they're in a cgroup stuck in heavy reclaim)
> > > +	 * which then blocks writers, including transaction commit. By
> > > +	 * using a semaphore with fewer writers (only a commit switching
> > > +	 * the roots), we make this issue less likely.
> > > +	 *
> > > +	 * Note that we don't rely on btrfs_search_slot to lock the
> > > +	 * commit root csum. We call search_slot multiple times, which would
> >                        sem
> > 
> > > +	 * create a potential race where a commit comes in between searches
> > > +	 * while we are not holding the commit_root_csum, and we get csums
> >                                                     sem
> > 
> > Only typos so you can fix it once you add it to for-next, also please
> > reflow the comments so they fit 80 columns per line.
> 
> Oops, my bad on the typos. I could not find any comment over 80 columns,
> so I pushed it as-is. Let me know what I missed and I am happy to do the
> fixup...

Not over 80 but too much under 80, I'll fix it in for-next.

