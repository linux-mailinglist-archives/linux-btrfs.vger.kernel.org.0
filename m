Return-Path: <linux-btrfs+bounces-7475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6895DFD4
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BF61F2195D
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559B77DA8C;
	Sat, 24 Aug 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0zQdDHoc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7TlPAbU8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I0svpBRY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qtNs9NHY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC1AD2F;
	Sat, 24 Aug 2024 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724528322; cv=none; b=rEQSgtRYaqsM2hgR32LsVWUBMI8Z1tEVMww5VCqfgQyT1tLewk1yl7Ua4GwhiFtuqh3jvd9IMEKJVce59JM0attHtUIlQ4v/EL+HZd1lcCNZ6meBk7KylMhjy3TbPRXVIE0LqbVwgE7zbPoeXmL5RovauAnxOz/wGqE4deZWlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724528322; c=relaxed/simple;
	bh=qGu9Fxwa2fRM/5SEKZgAf9Alfc/Oj2nFzVIGapXFERA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiLA9ksN7/9eVxE8Pf7+QedeASkPii5MT9jRs3lLT333Q0g1UpENYoXN7LyEtOH8QmvjaLacce+PU6KCe0W4gLQHo+VdK8Yz08orDv0YTj11ejVjLnZfnYUx7KSmq5IwegEzTlNL5vobcDYIAyrVf7udOv/VL/40PtY23q2qOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0zQdDHoc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7TlPAbU8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I0svpBRY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qtNs9NHY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0AC4219D3;
	Sat, 24 Aug 2024 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724528318;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNExPYtYa7tchxVnplv7yYS46Nlfpr/VrPmEFZrymvU=;
	b=0zQdDHocPd/gg1yx/LhN7QjUAPnf7wgRAJ7xES/UuHFc3YWkHu6x/TXU5zI6XPjepeEWsA
	DxsJLpV11+1ybbj+ZhC5BgAKyc5Mb511P0l/HdET8cmuWfmboKwne1TTCuBvqnNcbIVEus
	vtglPhoC7fQemMD6+a67tvFolbmC3FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724528318;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNExPYtYa7tchxVnplv7yYS46Nlfpr/VrPmEFZrymvU=;
	b=7TlPAbU8iwIGkLBr5TqxQzVXdj8duI3dnjqI14DF/icNePeo5lO5wdKzFmV6iM9EH9Qi7f
	4VQ5OSxuD5T4k0DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724528316;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNExPYtYa7tchxVnplv7yYS46Nlfpr/VrPmEFZrymvU=;
	b=I0svpBRYMcj/273st4zNI747GYy11khXqhKy8Bm4nDQeUxe2gi/lw7QrXKC06dzEeG0eU5
	rnVR6c8wj9cxKnCjSPvjeKb53iEhbSQgFkuy+qcbEQeGVJ/7dYyquPrk8OA4VfTQohfUdk
	8LQs7OjGlR3vdCZelYJQaSQGGVwABEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724528316;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNExPYtYa7tchxVnplv7yYS46Nlfpr/VrPmEFZrymvU=;
	b=qtNs9NHYg51ggQ0plsAQVMGdLzcwC/1uOKiumtGcViTo5eY21GuqzQ1rtBUXJESfztPQEm
	SsUwFXFvoTAbF9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC36C139DE;
	Sat, 24 Aug 2024 19:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGqKKbw2ymY3NAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 24 Aug 2024 19:38:36 +0000
Date: Sat, 24 Aug 2024 21:38:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	syzkaller <syzkaller@googlegroups.com>,
	syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>,
	clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
Message-ID: <20240824193835.GN25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000008f55e4062036c827@google.com>
 <20240821201338.GA2109582@perftesting>
 <CACT4Y+aSV8ZptNaLqVg+QgOyDn+tJ1WUyBxQ-9hk7joqbmT6GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aSV8ZptNaLqVg+QgOyDn+tJ1WUyBxQ-9hk7joqbmT6GA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dfb6eff2a68b42d557d3];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,btrfs.readthedocs.io:url];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Aug 22, 2024 at 02:05:01PM +0200, Dmitry Vyukov wrote:
> > > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> >
> > Can we disable syzbot issues for this specific error?  Btrfs uses lockdep
> > annotations for our tree locks, so we _easily_ cross this threshold on the
> > default configuration.  Our CI config requires the following settings to get
> > lockdep to work longer than two or three tests
> >
> > CONFIG_LOCKDEP_BITS=20
> > CONFIG_LOCKDEP_CHAINS_BITS=20
> > CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> > CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> > CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> >
> > but there's no way to require that in our config (nor do I think we should
> > really be able to tbqh).  It makes more sense for syzbot to just ignore this
> > particular error as it's not actually a bug.  Thanks,
> 
> Hi Josef,
> 
> We could bump these values, the last 3 are already this or higher on syzbot.
> Do you know if increasing CONFIG_LOCKDEP_BITS and
> CONFIG_LOCKDEP_CHAINS_BITS significantly increases memory usage?
> 
> Ignoring random bugs on unknown heuristics is really not scalable.

This is not a random bug. The warning has been reported many times, it
does not point to a specific problem in code that uses lockdep but
rather some defficiency in the lockdep mechanism itself.

> Consider: there are hundreds of kernel subsystems, if each of them
> declares a random subset of bugs as not bugs.

"If each of them", no this won't happen. Or, if you add this one and
reject the others you'll still make people happy.

> What's the maintenance
> story here? And it's not syzbot specific, any automated and manual
> testing will have the same problem.

Yes this does not avoid reports but at least it won't be a syzbot report
that somebody thinks is worth time. Everybody else will be told "ignore"
or poitned to documentation or the report ignored completely
(https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#bug-max-lockdep-chain-hlocks-too-low).

> The only scalable way to mark false reports is to not produce them.

In an ideal case yes. So far we have only the workaround with increasing
the config value (which makes sense on a distro config), otherwise I
remembet locking guys to suggest some fix but I can't find it now in the
numerous reports.

