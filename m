Return-Path: <linux-btrfs+bounces-13978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCBAB5AD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A73E1887E07
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B82BE7C8;
	Tue, 13 May 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPMFUWNe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OvlwvQtv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPMFUWNe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OvlwvQtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933C2AF10
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156252; cv=none; b=axVTlpSGmgaJIHmToge5ypktRFtPkQ73jEPZqCXzlgMKoR8+mqjObmXkhBf7i9YSw5N68+NUm8OiabvFauyLnKuPNGWjNyFnalSCmnjHIb3WEUN9GVOiJKis5iYHnsNQmckrqWyf5p+oM4y0TZpYObOtdI1rg5BtCfJBiWcRfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156252; c=relaxed/simple;
	bh=auzrw7btsGbb4oHyCUhrSWyuXkh9OVjhSw0jbbiKHDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM+5shV5l6U0xxKtJYOEawdnfhATB2oKal0u7YX4/pbBgwdNydbTyYblFD3AV52eQlPClLpfOBcJ4EayJ5NUcJ9pN9FxbQT55ClPHb5R7BXtBeHdMIavmzY/23jc1R2DB1KATVcvWWOExllY5juvPzTx0y+rJWFoABxYpv4Ng/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPMFUWNe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OvlwvQtv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPMFUWNe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OvlwvQtv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5EEDA21162;
	Tue, 13 May 2025 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747156249;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZqy7qHoDCwKi09OxV7kK7dYve7LrRIWXRRkOIeDbbA=;
	b=vPMFUWNeGXgk7AoftaF0uo3xwcIVKLvzGaxQs8PZCNIDDN4HuVyJlxOaBaDInumSdEokwN
	UdlbLVrNdffd6w7cIVphsdN3fC6xCSubOQ6suAFCrjrY3Gw1KWVAExxoFRQJW7XCI/R4NA
	kT/ViuW6z9HoaqhFTWT5X0hn4D6A5Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747156249;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZqy7qHoDCwKi09OxV7kK7dYve7LrRIWXRRkOIeDbbA=;
	b=OvlwvQtvIJ4oHzII/27ZavxILlVzuRCDmS9Dae4r7FeNsDOPSHTX2DTLlACt5RdVI9UxiY
	dcweFp+K8I5siqCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747156249;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZqy7qHoDCwKi09OxV7kK7dYve7LrRIWXRRkOIeDbbA=;
	b=vPMFUWNeGXgk7AoftaF0uo3xwcIVKLvzGaxQs8PZCNIDDN4HuVyJlxOaBaDInumSdEokwN
	UdlbLVrNdffd6w7cIVphsdN3fC6xCSubOQ6suAFCrjrY3Gw1KWVAExxoFRQJW7XCI/R4NA
	kT/ViuW6z9HoaqhFTWT5X0hn4D6A5Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747156249;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZqy7qHoDCwKi09OxV7kK7dYve7LrRIWXRRkOIeDbbA=;
	b=OvlwvQtvIJ4oHzII/27ZavxILlVzuRCDmS9Dae4r7FeNsDOPSHTX2DTLlACt5RdVI9UxiY
	dcweFp+K8I5siqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 393B7137E8;
	Tue, 13 May 2025 17:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lDDADRl9I2jtJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 May 2025 17:10:49 +0000
Date: Tue, 13 May 2025 19:10:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
Message-ID: <20250513171039.GC9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250512172321.3004779-1-neelx@suse.com>
 <20250512202054.GX9140@twin.jikos.cz>
 <CAPjX3Fe1izCGUJhTWk1mB=9uK7kNHeCOj51_TZQG7DOe_aooig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Fe1izCGUJhTWk1mB=9uK7kNHeCOj51_TZQG7DOe_aooig@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Tue, May 13, 2025 at 09:56:19AM +0200, Daniel Vacek wrote:
> On Mon, 12 May 2025 at 22:20, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, May 12, 2025 at 07:23:20PM +0200, Daniel Vacek wrote:
> > > So far we are deriving the buffer tree index using the sector size. But each
> > > extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> > >
> > > For example the typical and quite common configuration uses sector size of 4KiB
> > > and node size of 16KiB. In this case it means the buffer tree is using up to
> > > the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> > > slots are wasted as never used.
> > >
> > > We can score significant memory savings on the required tree nodes by indexing
> > > the tree using the node size instead. As a result far less slots are wasted
> > > and the tree can now use up to all 100% of it's slots this way.
> >
> > This looks interesting. Is there a way to get xarray stats? I don't see
> > anything in the public API, e.g. depth, fanout, slack per level. For
> > debugging purposes we can put it to sysfs or as syslog message,
> > eventually as non-debugging output to commit_stats.
> 
> I'm using a python script in crash (even live on my laptop). I believe
> you could do the same in dragon. Though that's not the runtime stats
> you described. And I don't really think it's worth it.

How come you don't think it's worth it? You claim some numbers and we
don't have a way to verify that or gather on various setups or
workloads. I'd be interested in the numbers also to better understand
how xarray performs with the extent buffers but I don't now how to write
the analysis scripts in any of the tools, nor have time for that.

