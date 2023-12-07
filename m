Return-Path: <linux-btrfs+bounces-750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080788089C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 15:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10EC1F214AB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591441236;
	Thu,  7 Dec 2023 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7QC3avY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1g6YHom";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7QC3avY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1g6YHom"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BB10EB
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 06:02:19 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B75F11FB69;
	Thu,  7 Dec 2023 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701957737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=owoTjkKWWqElMa9z3Y6ylP+UOIHQezvcRUGlJxY1WuA=;
	b=s7QC3avYVUUStCJQRtBjULUYrSkJs3XBoXjRyZ6DRVLZJfhJiHTt+OVC2VcelK2PMVFu7v
	y6nY/NkqNuMZ2NhJj4V6BIIgZsLpzh3y/IgxjZSKwRUO5rMWWHTEASsLTJFfC3X5XgCOYq
	NIa1neCzNtaq1OcnncU4lVCPjoEHFnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701957737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=owoTjkKWWqElMa9z3Y6ylP+UOIHQezvcRUGlJxY1WuA=;
	b=a1g6YHomuLaBokdCu06zvdoNoFoNAYlY7+KpBAFezO6VLo42+mu35NSHw9FcKEHK1ie2e3
	FW+hCdDApXRTVlAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701957737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=owoTjkKWWqElMa9z3Y6ylP+UOIHQezvcRUGlJxY1WuA=;
	b=s7QC3avYVUUStCJQRtBjULUYrSkJs3XBoXjRyZ6DRVLZJfhJiHTt+OVC2VcelK2PMVFu7v
	y6nY/NkqNuMZ2NhJj4V6BIIgZsLpzh3y/IgxjZSKwRUO5rMWWHTEASsLTJFfC3X5XgCOYq
	NIa1neCzNtaq1OcnncU4lVCPjoEHFnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701957737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=owoTjkKWWqElMa9z3Y6ylP+UOIHQezvcRUGlJxY1WuA=;
	b=a1g6YHomuLaBokdCu06zvdoNoFoNAYlY7+KpBAFezO6VLo42+mu35NSHw9FcKEHK1ie2e3
	FW+hCdDApXRTVlAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A9C3139E3;
	Thu,  7 Dec 2023 14:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hkSDJWnQcWWVHgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 07 Dec 2023 14:02:17 +0000
Date: Thu, 7 Dec 2023 14:55:22 +0100
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231207135522.GX2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231205111329.6652-1-ddiss@suse.de>
 <20231205142253.GD2751@twin.jikos.cz>
 <20231206112143.7d1df045@echidna>
 <20231206185330.GS2751@twin.jikos.cz>
 <20231207105255.5cbd892a@echidna>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207105255.5cbd892a@echidna>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -6.80
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.99%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu, Dec 07, 2023 at 10:52:55AM +1100, David Disseldorp wrote:
> On Wed, 6 Dec 2023 19:53:31 +0100, David Sterba wrote:
> 
> > On Wed, Dec 06, 2023 at 11:21:43AM +1100, David Disseldorp wrote:
> > > On Tue, 5 Dec 2023 15:22:53 +0100, David Sterba wrote:
> > >   
> > > > On Tue, Dec 05, 2023 at 10:13:29PM +1100, David Disseldorp wrote:  
> > > > > The @retptr parameter for memparse() is optional.
> > > > > btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
> > > > > validation, so the parameter can be dropped.    
> > > > 
> > > > Or should it be used for validation? memparse is also used in
> > > > btrfs_chunk_size_store() that accepts whitespace as trailing characters
> > > > (namely '\n' if the value is from echo).  
> > > 
> > > It probably should have been used for validation when originally added,
> > > but the current behaviour is now part of the sysfs scrub_speed_max API.
> > > Failing on invalid input would break scripts which do things like
> > >   echo clear > /sys/fs/btrfs/UUID/devinfo/1/scrub_speed_max  
> > 
> > I'm not sure the 'part of the API' is a valid agrument here. It's
> > documented that the value is in bytes and that suffixes can be passed
> > for convenience. How come anybody would use 'clear' in the first place
> > and expect it to work with undefined meaning?
> 
> Most people don't read documentation :).

Unfortunatelly true. Here the expected practice is that size values on
input can have a suffix so it should be consistent and understandable
even without reading documentation.

> If there's a willingness to
> accept any fallout from adding the validation then I'm happy to do that.
> Will send a v2.

Yes, I think the simple fix is to add the handling as
btrfs_chunk_size_store() does and this will be the pattern for any
future memparsed values in sysfs.

There's one outlier discard/kbps_limit that takes KiB directly so that's
a plain integer. Eventually discard/max_discard_size can also use memparse.

