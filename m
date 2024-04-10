Return-Path: <linux-btrfs+bounces-4112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A689FCFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E549D287E3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9DE17BB1B;
	Wed, 10 Apr 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtnSz66G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYQmYYZg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtnSz66G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYQmYYZg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB617B4F3;
	Wed, 10 Apr 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766849; cv=none; b=K410kaSspZgeHgZKwD4GdkhsLnhmAOqRNyjTrjROz1ZYqWN3A+KSAoWceeNH6QzeAFDaCllapHsxD7wZqDRV4ge71ysoMeKF4MFw2m/IvE5VJa8lyyje2/CWsGnXB0wey9vToIx6H3uplRiKhu83lJsiNxbEzgaA/naOZZYwQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766849; c=relaxed/simple;
	bh=M4kgcsbWvOG6JukQgDy4eXSmlWkf4f//IsHAzNa3ggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAG0qVbw7q/4BPlOzcjGmaLIZH20Q1hzxhiySDZppjEGd+zoRthqoIRsSIUWfpFs2L7zPpjYKvOAdijlPKyxgrNGyYcQxiyDQ5mrS+PtGGAPGP5NrPlkx2wprfImR29xvYmsXmAFqzNk1muSRJ2XgheMh4FPGNkHbHn8v1sPEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtnSz66G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RYQmYYZg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtnSz66G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RYQmYYZg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A15D202E0;
	Wed, 10 Apr 2024 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712766845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXsEPu0dL+VYw7dsKf2XjoiVbIWRW1LG0dozOa11638=;
	b=AtnSz66GfT2i9NcR5gPpvGbljRwP8YcW6ORjfSUBsJkIvDjM2s0GnUE0XArHB5+G5Qhb91
	b/rxJ+e7k26ab37Awumn3/UsbQApRPXCcqiSeoYaHTZXI2lxkr9j71DQPqwDHwUyGDkC1G
	2dl3qnVRrCL7Jy7ijr09G+99BTp4Yu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712766845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXsEPu0dL+VYw7dsKf2XjoiVbIWRW1LG0dozOa11638=;
	b=RYQmYYZg7+PAafRqsJw/1QOYnntXNTXPBWg6QEo4QB0KEEllnzL+oHz/4K4u7J4LgaxaaA
	uYYa2jwVD5ONX9AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AtnSz66G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RYQmYYZg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712766845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXsEPu0dL+VYw7dsKf2XjoiVbIWRW1LG0dozOa11638=;
	b=AtnSz66GfT2i9NcR5gPpvGbljRwP8YcW6ORjfSUBsJkIvDjM2s0GnUE0XArHB5+G5Qhb91
	b/rxJ+e7k26ab37Awumn3/UsbQApRPXCcqiSeoYaHTZXI2lxkr9j71DQPqwDHwUyGDkC1G
	2dl3qnVRrCL7Jy7ijr09G+99BTp4Yu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712766845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXsEPu0dL+VYw7dsKf2XjoiVbIWRW1LG0dozOa11638=;
	b=RYQmYYZg7+PAafRqsJw/1QOYnntXNTXPBWg6QEo4QB0KEEllnzL+oHz/4K4u7J4LgaxaaA
	uYYa2jwVD5ONX9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B3BF13942;
	Wed, 10 Apr 2024 16:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HVlOAn2/Fma5RwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Apr 2024 16:34:05 +0000
Date: Wed, 10 Apr 2024 18:26:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
Message-ID: <20240410162635.GN3492@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
 <20240409111319.GA3492@twin.jikos.cz>
 <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
 <e9576dfb-c3ce-4adc-bb32-f7efa235907a@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9576dfb-c3ce-4adc-bb32-f7efa235907a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-2.07)[95.48%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1A15D202E0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.28

On Wed, Apr 10, 2024 at 03:18:49PM +0930, Qu Wenruo wrote:
> >> What past discussions favored does not seem to satisfy our needs and as
> >> btrfs-progs are evolving we're hitting random test breakage just because
> >> some message has changed. The testsuite should verify what matters, ie.
> >> return code, state of the filesystem etc, not exact command output.
> >> There's high correlation between output and correctness, yes, but this
> >> is too fragile.
> > 
> > Agreed. So, why don't we use `_run_btrfs_util_prog subvolume
> > snapshot`, which makes it consistent with the rest of the test cases,
> > and also remove the golden output for this command?
> 
> For `_run_btrfs_util_prog`, the only thing I do not like is the name itself.
> 
> I also do not like how fstests always go $BTRFS_UTIL_PROG neither, 
> however I understand it's there to make sure we do not got weird bash 
> function name like "btrfs()" overriding the real "btrfs".
> 
> If we can make the name shorter like `_btrfs` or something like it, I'm 
> totally fine with that, and would be happy to move to the new interface.
> 
> In fact, `_run_btrfs_util_prog` is pretty helpful to generate a debug 
> friendly seqres.full, which is another good point.

I did not realize the _run_btrfs_util_prog helper was there and actually
the run_check as well. I vaguely remember this from many years ago and
this somehow landed in btrfs-progs testsuite but fstests was against it.
Using such helpers sounds like a plan to me (with renames etc).

