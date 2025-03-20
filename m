Return-Path: <linux-btrfs+bounces-12444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1886A69D75
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 02:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EE3461AFE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78670156861;
	Thu, 20 Mar 2025 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xg6gJgSw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KoD7w7Th";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xg6gJgSw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KoD7w7Th"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5CBA34
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742433487; cv=none; b=SCO1HswtA4+9/NXtlittfhzF2P7xM3X0PDBQd1pFb0JJKX2i9ULoBRzOZDyHy1xyTx/jg4nH+AIWX7ekuGHHf9jeoxdA5KUfUDB56YHVnEsRMQ0k2XicyrBeGo9Sg6F/AQgDQKvcEbbutrll8o4wI7bIM+RqaOsqUTmHRmOzskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742433487; c=relaxed/simple;
	bh=17MOWjGS2TJO+36QTJ7LkqQRrHIHJyiE4yQoMdue2VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn1kbwiLLanBTf+Ocg9aLY15TD8760Iz+C5B8+IB55/+MWXts7uzlrSqb3ujRYnR2wcs979YBr8S6o/Ec/0+NLAdJSceITmFPfXm8FjURzdygWNyu9wgUR1cC/G8R6ulKzfVtSLNJAT0R8DIW9w6VOyAmo2rNftL3kOVhhXqQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xg6gJgSw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KoD7w7Th; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xg6gJgSw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KoD7w7Th; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F10A2120E;
	Thu, 20 Mar 2025 01:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742433484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rst+jcCipD5nQl1ARmnYIY+jgBHdh5wZ42wy+WWQ/eA=;
	b=xg6gJgSwCKf1RbBEFGJ11LzgvDS+iEb4JQC6Bis3fOflOYGi3gFhOBAK1kw+pk9RIy2/nx
	CrmoSGSucqXSg0jfxS0ArCByWnioa2ovql4av95xS4/8/KsCPAsupava0LEckeCNzqx79A
	iEo4VkdcGLFk0Xo9gG6NWKYGm/2Yry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742433484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rst+jcCipD5nQl1ARmnYIY+jgBHdh5wZ42wy+WWQ/eA=;
	b=KoD7w7Th86eiY2WzBZILrXikIEdsAz8/iv+rf5KJkZOQAb/BLIaeEBRMWxMuz+kMhj8mh1
	tSDIruqhYPwYttDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742433484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rst+jcCipD5nQl1ARmnYIY+jgBHdh5wZ42wy+WWQ/eA=;
	b=xg6gJgSwCKf1RbBEFGJ11LzgvDS+iEb4JQC6Bis3fOflOYGi3gFhOBAK1kw+pk9RIy2/nx
	CrmoSGSucqXSg0jfxS0ArCByWnioa2ovql4av95xS4/8/KsCPAsupava0LEckeCNzqx79A
	iEo4VkdcGLFk0Xo9gG6NWKYGm/2Yry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742433484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rst+jcCipD5nQl1ARmnYIY+jgBHdh5wZ42wy+WWQ/eA=;
	b=KoD7w7Th86eiY2WzBZILrXikIEdsAz8/iv+rf5KJkZOQAb/BLIaeEBRMWxMuz+kMhj8mh1
	tSDIruqhYPwYttDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E530E139D2;
	Thu, 20 Mar 2025 01:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rc28N8ts22dBcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Mar 2025 01:18:03 +0000
Date: Thu, 20 Mar 2025 02:18:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs-progs: -q/--quiet not accepted for "btrfs subvolume"
 subcommands
Message-ID: <20250320011802.GT32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241217195649.143d2c94@nvm>
 <20250319221256.GQ32661@twin.jikos.cz>
 <20250320034613.47d65814@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320034613.47d65814@nvm>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Mar 20, 2025 at 03:46:13AM +0500, Roman Mamedov wrote:
> On Wed, 19 Mar 2025 23:12:56 +0100
> David Sterba <dsterba@suse.cz> wrote:
> 
> > On Tue, Dec 17, 2024 at 07:56:49PM +0500, Roman Mamedov wrote:
> > > Hello,
> > > 
> > > # btrfs --version
> > > btrfs-progs v6.6.3
> > > 
> > > # btrfs sub create --help
> > > usage: btrfs subvolume create [options] [<dest>/]<name> [[<dest2>/]<name2> ...]
> 
> ^ This line appears to instruct that there's one place to put all the options;
> so if you're looking into a documentation fix, I would suggest modifying that.

That is certainly one option to improve it. The pattern I'm following is
from git that thas the multi level subcommand structure, global and
command-specific options. If you check 'man git' there are options that
are affect e.g. pager or editor, but none of these options is mentioned
in 'git-log' manual page and the help text also omits the global
options. "git log [<options>] [<revision-range>] [[--] <path>...]"

> Like,
> 
> > > usage: btrfs [global-options] subvolume create [local-options] [<dest>/]<name> [[<dest2>/]<name2> ...]
> 
> But this looks messy. So IMO the ideal would be to just not require the
> separation and accept global options also after the subcommand name.

I see the rationale here and the goal of the command line interface is
to provide convenices, while currently forcing the global options to be
only after the 'btrfs' term is still a bit uncommon.

As long as the option names don't clash with the command options it
would be possible to extend the semantics of the current "global" to
global in the sense of "anywhere the options can appear".

The original motivation was to unify the options to one place but based
on the feedback and my own experience I think the current split is not a
good pattern. Implementing the new semantics will need a review of all
the commands if there are potential clashes but overall I agree it would
be a usability improvement in the end.

