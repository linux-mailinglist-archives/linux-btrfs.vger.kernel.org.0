Return-Path: <linux-btrfs+bounces-7692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0AA966665
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 18:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A29286FE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09E1B9B34;
	Fri, 30 Aug 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yK/V0ejK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8pf+f7fl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jlUoTIys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TaEYzW0E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E81B8EAC;
	Fri, 30 Aug 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033667; cv=none; b=nxm24yrOEcKcDJHYVEQNtAJx/PExXLM1qR5PdcOBD5DYGHnQoi+RHMQu95OfPSEWGpBD556bs8QSfm9FeAnupRvhxr8JmY0tYqEWmv8Y13G2Lfbs9Xa0vjhGN13owJswnmAH8Gix4I5V2Ph+Nb3ghKnDM+PSMLDRCJ5sliMY224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033667; c=relaxed/simple;
	bh=uFqyLaE4NatfX8kmKu9K3ygU2sPwGOrH8wgq2yV8q0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTquZziq9MVWMXerKrM8oWa6UcZtxuhDP+leQnbu3X7zPowBaan6JcaQpnpCO0w4Urocvi1bOJI/JAao0C30Uk/Z/tnuh+ns3JjrgPWBn9WI1k/ywhGVMlnW6XiDclfBwCY+SCYInNkRW+NDu9aiBo2HzSAqOxXHpZwLA2KoNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yK/V0ejK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8pf+f7fl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jlUoTIys; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TaEYzW0E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 424F621A42;
	Fri, 30 Aug 2024 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725033657;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzO9GShbTK3uvm96Kc6nRShRJAXkilJCo0OS6nYBQU=;
	b=yK/V0ejK2LmZ1E92HEmHw504ZuEsBp796BcjVfRa1TKSmddU6+7tsm+1VHoYrSlXTwYcw2
	/dcS9CeOWmC2sIN8QHkOQsXaOzCbGAfmlTYtfUs0SMja2z3jDgmk2MbHggioSu7GFoDwkd
	AZyHJKcgOromNmEbpVYDchW0VUCs3EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725033657;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzO9GShbTK3uvm96Kc6nRShRJAXkilJCo0OS6nYBQU=;
	b=8pf+f7fl5qZxVsZUTHwjJeTYcMlK4b/QvPVhVib/UbXPJwxr/PQ7wbq18n7qAk2F44+7Wr
	JCmASNT0N1JM0FDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jlUoTIys;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TaEYzW0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725033656;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzO9GShbTK3uvm96Kc6nRShRJAXkilJCo0OS6nYBQU=;
	b=jlUoTIysmn6BlNeVurQSUx5OIDXp4oVMuKPQeOhJHXfS6bctk8sskYYnwvVKFbTTDx0f+o
	zeOU/RDJPvCNrpeL+cgPt2ygPL6TXzJYN8kDsvzRSAk1472T0ZEH8jkhXgHrGw1+Jdx+ph
	g6nLo07JowOO2fZuLL4We7WS46pHa/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725033656;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzO9GShbTK3uvm96Kc6nRShRJAXkilJCo0OS6nYBQU=;
	b=TaEYzW0EfiLhR26bw11PzXCFZOoklPk0zEg0IN8oaXgAalGlNpXMt8OXDNSr7kSBLx5Tkn
	9ABB2tO3/kMHzyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170C213A44;
	Fri, 30 Aug 2024 16:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VLBnBbjs0WZgBwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 Aug 2024 16:00:56 +0000
Date: Fri, 30 Aug 2024 18:00:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	syzkaller <syzkaller@googlegroups.com>,
	syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>,
	clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
Message-ID: <20240830160054.GU25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000008f55e4062036c827@google.com>
 <20240821201338.GA2109582@perftesting>
 <CACT4Y+aSV8ZptNaLqVg+QgOyDn+tJ1WUyBxQ-9hk7joqbmT6GA@mail.gmail.com>
 <20240824193835.GN25962@suse.cz>
 <CACT4Y+bsEPHkzofGZPHkhpj1jnGRwFmqR-scJGX0EXAZLe-Zng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bsEPHkzofGZPHkhpj1jnGRwFmqR-scJGX0EXAZLe-Zng@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 424F621A42
X-Spam-Score: -2.71
X-Rspamd-Action: no action
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,btrfs.readthedocs.io:url];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dfb6eff2a68b42d557d3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 30, 2024 at 05:02:09PM +0200, Dmitry Vyukov wrote:
> On Sat, 24 Aug 2024 at 21:38, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Aug 22, 2024 at 02:05:01PM +0200, Dmitry Vyukov wrote:
> > > > > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > > >
> > > > Can we disable syzbot issues for this specific error?  Btrfs uses lockdep
> > > > annotations for our tree locks, so we _easily_ cross this threshold on the
> > > > default configuration.  Our CI config requires the following settings to get
> > > > lockdep to work longer than two or three tests
> > > >
> > > > CONFIG_LOCKDEP_BITS=20
> > > > CONFIG_LOCKDEP_CHAINS_BITS=20
> > > > CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> > > > CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> > > > CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> > > >
> > > > but there's no way to require that in our config (nor do I think we should
> > > > really be able to tbqh).  It makes more sense for syzbot to just ignore this
> > > > particular error as it's not actually a bug.  Thanks,
> > >
> > > Hi Josef,
> > >
> > > We could bump these values, the last 3 are already this or higher on syzbot.
> > > Do you know if increasing CONFIG_LOCKDEP_BITS and
> > > CONFIG_LOCKDEP_CHAINS_BITS significantly increases memory usage?
> > >
> > > Ignoring random bugs on unknown heuristics is really not scalable.
> >
> > This is not a random bug. The warning has been reported many times, it
> > does not point to a specific problem in code that uses lockdep but
> > rather some defficiency in the lockdep mechanism itself.
> 
> By "random" I meant that the predicate is some custom English
> sentence, rather than something that can be expressed in the code. So
> on the global kernel scale it's hard/impossible to filter out such
> reports.
> 
> Additional complication here is that the predicate involves knowing
> that exactly system calls triggered this warning, since the warning is
> generic. We don't generally know what exact syscall sequence triggered
> a report. So it would only be possible to ignore "BUG:
> MAX_LOCKDEP_CHAIN_HLOCKS too low" globally, which is not good.
> 
> > > Consider: there are hundreds of kernel subsystems, if each of them
> > > declares a random subset of bugs as not bugs.
> >
> > "If each of them", no this won't happen. Or, if you add this one and
> > reject the others you'll still make people happy.
> >
> > > What's the maintenance
> > > story here? And it's not syzbot specific, any automated and manual
> > > testing will have the same problem.
> >
> > Yes this does not avoid reports but at least it won't be a syzbot report
> > that somebody thinks is worth time. Everybody else will be told "ignore"
> > or poitned to documentation or the report ignored completely
> > (https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#bug-max-lockdep-chain-hlocks-too-low).
> >
> > > The only scalable way to mark false reports is to not produce them.
> >
> > In an ideal case yes. So far we have only the workaround with increasing
> > the config value (which makes sense on a distro config), otherwise I
> > remembet locking guys to suggest some fix but I can't find it now in the
> > numerous reports.
> 
> I've bumped LOCKDEP parameters in syzbot configs:
> https://github.com/google/syzkaller/commit/f4865e39dd0bcae7e5f3f5d59807d6ac9a8a99ba

LOCKDEP_CHAINS_BITS=20 will improve the situation, thanks.

