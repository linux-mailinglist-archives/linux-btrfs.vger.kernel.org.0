Return-Path: <linux-btrfs+bounces-7220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D120953E1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 02:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AFA28353C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 00:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC6C7F9;
	Fri, 16 Aug 2024 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jJvjUQbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qrq3SxNm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UBMKlIxB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HllHwf0T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09B1803A;
	Fri, 16 Aug 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723766556; cv=none; b=qleO9TMJO3ewg2dJdgZcyJYazBOc7rlzsNrXOd7fx7k1UO8CX26UCZrc4BNZq+Nh6JiO+PPyKehuVVRTWikv6dG/djPOf/Kbp71EdbVXAw7VkGR4h3OENPrGgEXgatffsBAd59AjxevRocwgXUhw4A9XaUfT8ZTi96KI4MHLjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723766556; c=relaxed/simple;
	bh=QW8magj+iBg7jdZR2M7hkUQddbsFq/HnOPIuTzwhki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu7mSrg6NnlFTlqcDgr/cBScNaZzA6C/U0hgpROuLMshaB1TaSufxX6Pu4k+cSA3ITE/73rhmwSOXFzBCjNFgzd5GVlyzVrtDmW3rSfshyk61jFJmnIZANjxS6nh8xEqlMiGiPG/xK4o2H7YK4imyo/JO3geDn+AIxb/xTGp+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jJvjUQbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qrq3SxNm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UBMKlIxB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HllHwf0T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8D371FD75;
	Fri, 16 Aug 2024 00:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723766553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoUvm5dLsjWCREcQtqouQfhCgMrPk2DtMelMDP51pes=;
	b=jJvjUQbOdauoRVn396ehIbAO0R7ByfWjmvuT0MSBaSN7L2QC95qahHfh8N+Vs1Wr5bc+WC
	CP7rMaRnmwv/S6ap9IGR5/ppZcXCVJYtvXCYFGOV6WBVCdRH0PYLtmMkPo2CPWN3Fbltnf
	M3P2je+GjE5LmKgR8D7Z5PX/SD571CA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723766553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoUvm5dLsjWCREcQtqouQfhCgMrPk2DtMelMDP51pes=;
	b=qrq3SxNmlM5ETpnchqMpbpOmkepJhAS68Rb1jO4J/OCUYqteLjEbKZhv2pBwP06FMl35Aq
	6w/qMQ5EH3XsYjDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UBMKlIxB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HllHwf0T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723766552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoUvm5dLsjWCREcQtqouQfhCgMrPk2DtMelMDP51pes=;
	b=UBMKlIxBun7T3SYxJV0JpPdw5i8kRd92cdhk0KjN3PRSzVvE9CoNwcAt/sRG4wRlj+en1Z
	/P1yHV3zzuhZ3UExUiem6X0JeC9dTlLElh/cqG9LJJEQOuf2suRKJq1hm7DEjVDUYEilRd
	FKsIp2rv1Xe47kPdG1wblgXcE2s0bM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723766552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoUvm5dLsjWCREcQtqouQfhCgMrPk2DtMelMDP51pes=;
	b=HllHwf0TdyfIU/WcRw/7WsT3ENwRlXK+PWiv/cWbWpLQZLUd8rrA2eVsKDQmW1kOB27M9o
	uvvwYIOso5wS8zCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F8D613894;
	Fri, 16 Aug 2024 00:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pexxJhiXvma9FgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 16 Aug 2024 00:02:32 +0000
Date: Fri, 16 Aug 2024 02:02:31 +0200
From: David Sterba <dsterba@suse.cz>
To: intelfx@intelfx.name
Cc: Filipe Manana <fdmanana@kernel.org>,
	Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>,
	andrea.gelmini@gmail.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	mikhail.v.gavrilov@gmail.com, regressions@lists.linux.dev
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted
 increased execution time of the kswapd0 process and symptoms as if there is
 not enough memory
Message-ID: <20240816000231.GG25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com>
 <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name>
 <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.com,toxicpanda.com,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: C8D371FD75
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Score: -2.71

On Fri, Aug 16, 2024 at 01:17:25AM +0200, intelfx@intelfx.name wrote:
> On 2024-08-16 at 00:21 +0200, intelfx@intelfx.name wrote:
> > On 2024-08-11 at 16:33 +0100, Filipe Manana wrote:
> > > <...>
> > > This came to my attention a couple days ago in a bugzilla report here:
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=219121
> > > 
> > > There's also 2 other recent threads in the mailing about it.
> > > 
> > > There's a fix there in the bugzilla, and I've just sent it to the mailing list.
> > > In case you want to try it:
> > > 
> > > https://lore.kernel.org/linux-btrfs/d85d72b968a1f7b8538c581eeb8f5baa973dfc95.1723377230.git.fdmanana@suse.com/
> > > 
> > > Thanks.
> > 
> > Hello,
> > 
> > I confirm that excessive "system" CPU usage by kswapd and btrfs-cleaner
> > kernel threads is still happening on the latest 6.10 stable with all
> > quoted patches applied, making the system close to unusable (not to
> > mention excessive power usage which crosses the line well *into*
> > "unusable" for low-power systems such as laptops).
> > 
> > With just 5 minutes of uptime on a freshly booted 6.10.5 system, the
> > cumulative CPU time of kswapd is already at 2 minutes.
> 
> As a follow-up, after 1 hour of uptime of this system the total CPU
> time of kswapd0 is exactly 30 minutes. So whatever is the theoretical
> OOM issue that the extent map shrinker is trying to solve, the solution
> in its current form is clearly unacceptable.
> 
> Can we please have it reverted on the basis of this severe regression,
> until a better solution is found?

It's not just one patch so a clean revert may not be possible, I'll see
if there's another possibility to either avoid depending on shrinker to
free the data or do a different workaround.

