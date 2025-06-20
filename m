Return-Path: <linux-btrfs+bounces-14832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B6AE2092
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEA916D43A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC572E7F13;
	Fri, 20 Jun 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZwP+7S1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhraLVyi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZwP+7S1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhraLVyi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90672630
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439419; cv=none; b=rxh/hwK1/ncs2IKTGk0LW0mdDypm5ru5Z6erkHAsKzLRXNRgKYyLeFB+eO3JGqudD5paDqSDiN0s++G/xWUKAN62AWz45kJiXaKOFyZTZ4ltsbYFtRAxL1v7nr6HOeb2ZCXVaF0dGbt/d1kG1G5CDNtIp6V4K+XEjX+gC1GQhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439419; c=relaxed/simple;
	bh=APUZa1UB900xi3XA1LRW2DExZmTXWMznhO9xXu0Ktgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAy5C6o3l8ksC9gUithcmuffHJhBkQUvTd+b59KRuFQKhl4CQUCoAckXI6+qciZPf1bP3J6oKhWhPcj2vxjGyYA1zlfjpbLN66YqFs+UHmG/zNra+PQ2MKywQQBzWjbPY+ouEFBTRpati9PZPWR7WDumEMQcGd91HP/h+IF6/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZwP+7S1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhraLVyi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZwP+7S1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhraLVyi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FAD72124E;
	Fri, 20 Jun 2025 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750439416;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKff/qF6SLsdZxDeI3hVVUsCKFt6asxMwngD800D4MI=;
	b=ZwP+7S1ILfZnMRsIYa/WpP5nQL7cd+5gXlXtw5EXbXerPReLJ+6gUkZht6nmK/Z9HV+A5g
	KihjqcM0RmMCB+qoqfnTuti6ly035DCBwXboUk6kloAUUfM20VhfQVxABcaJ32ezPuDk8z
	KCyji+eqOT+Konbb+yz7L+VigsooqXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750439416;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKff/qF6SLsdZxDeI3hVVUsCKFt6asxMwngD800D4MI=;
	b=XhraLVyiuxKyWVW4xum9jEj/ziYxYUwCjcb3oSLzlTL/YYmM5wCx81HE8xsVeGzGrhuOtc
	mBy54m178C+H3GBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZwP+7S1I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XhraLVyi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750439416;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKff/qF6SLsdZxDeI3hVVUsCKFt6asxMwngD800D4MI=;
	b=ZwP+7S1ILfZnMRsIYa/WpP5nQL7cd+5gXlXtw5EXbXerPReLJ+6gUkZht6nmK/Z9HV+A5g
	KihjqcM0RmMCB+qoqfnTuti6ly035DCBwXboUk6kloAUUfM20VhfQVxABcaJ32ezPuDk8z
	KCyji+eqOT+Konbb+yz7L+VigsooqXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750439416;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKff/qF6SLsdZxDeI3hVVUsCKFt6asxMwngD800D4MI=;
	b=XhraLVyiuxKyWVW4xum9jEj/ziYxYUwCjcb3oSLzlTL/YYmM5wCx81HE8xsVeGzGrhuOtc
	mBy54m178C+H3GBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C294136BA;
	Fri, 20 Jun 2025 17:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KuY1CviVVWiVfAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 17:10:16 +0000
Date: Fri, 20 Jun 2025 19:10:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: tune: bgt resume related fix and
 enhancement
Message-ID: <20250620171014.GD4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750223785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750223785.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3FAD72124E
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Jun 18, 2025 at 02:53:38PM +0930, Qu Wenruo wrote:
> There is a bug report from the mailing list (1) that btrfstune failed to
> resume an interrupted conversion.
> 
> Although I hacked a small patch to skip the part of code that I believe
> is the cause, it doesn't properly explain why the bug happened, as the
> code looks good to me.
> 
> But with some time to tinker, I finally created a half-converted image
> and can reproduce the bug somewhat reliably.
> 
> It turns out to be an uninitialized structure, and this also exposed an
> inefficient behavior when reading block groups from the old extent tree.
> 
> Fix the bug first with the first patch.
> Then enhance the extent tree block group items loading from the old
> tree.

Thanks for tracking it down, I did not expect such cause. Compilers used
in distros may turn on options that zero local variables automatically
so that's probably why haven't seen it more often.

