Return-Path: <linux-btrfs+bounces-5422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95ED8D8AA0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 21:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFB21C23B49
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8113B28D;
	Mon,  3 Jun 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJDhSNwi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyBsbkA0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJDhSNwi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyBsbkA0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2E20ED
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444628; cv=none; b=Y5MTY2MtGcIpyA9Po0ybuRPjzzx8pqjtt+kOeg4ERHIGHBur1Yt4KgOwQlaOxo3URtmoD5q5ZhDjhVW3Io9X6Y6M8azTZHGI2a9SXRnfDJWe3gu8lvP3dblrEmtO+LppB6DHPsfq9Lm10oNW2P5+DlyohK7i8+BIEOYzj10oscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444628; c=relaxed/simple;
	bh=5wVf4lYSkFfJD5lqJLcXkGwpRqW8+LmeFlTieh8Sh1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPpzgxH11zkftPgNMi/WItz+lQqzEmyoYiqpx3lYJnh75qcnZxlyeE+ncsKCQdiq7DoqHYgt56PvE5tLoT23vzIBhFKbrxAp9II1+YLKPrrQ64JKj9zX87dp5ElZxGr0I7h9vWf+xtmWCqWf05gvORwapXjfWtLe4+y/KxN3Z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJDhSNwi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyBsbkA0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJDhSNwi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyBsbkA0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 181A51F441;
	Mon,  3 Jun 2024 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717444625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtG48t3ZBnX4vtma9YNrOPSxBySt7fPaV3TxnW77uHU=;
	b=PJDhSNwim0e3NGjZc0ake9lK9bZ+T7D1KXEf77CvC/8pTfux1V4MTpsUN4jwP2DassHwyY
	r6gjBzqNc6bf2KtFdQCWGD1dhlluP9XRcHu28TZar9cnHi+oejUIE+f539O/Big1upp3zk
	zzmazSRTf0+nImdl/7Zt1QQ7PEwwRoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717444625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtG48t3ZBnX4vtma9YNrOPSxBySt7fPaV3TxnW77uHU=;
	b=CyBsbkA03ojAsy3vKWiGpTo3+FKa+C7V0fPFO9hljZwbfIhNo9iawdwXFUdw6m3bYExsPW
	X2WLWIzEyA4OMgCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PJDhSNwi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CyBsbkA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717444625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtG48t3ZBnX4vtma9YNrOPSxBySt7fPaV3TxnW77uHU=;
	b=PJDhSNwim0e3NGjZc0ake9lK9bZ+T7D1KXEf77CvC/8pTfux1V4MTpsUN4jwP2DassHwyY
	r6gjBzqNc6bf2KtFdQCWGD1dhlluP9XRcHu28TZar9cnHi+oejUIE+f539O/Big1upp3zk
	zzmazSRTf0+nImdl/7Zt1QQ7PEwwRoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717444625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtG48t3ZBnX4vtma9YNrOPSxBySt7fPaV3TxnW77uHU=;
	b=CyBsbkA03ojAsy3vKWiGpTo3+FKa+C7V0fPFO9hljZwbfIhNo9iawdwXFUdw6m3bYExsPW
	X2WLWIzEyA4OMgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E86F5139CB;
	Mon,  3 Jun 2024 19:57:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNc/OBAgXmZJSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Jun 2024 19:57:04 +0000
Date: Mon, 3 Jun 2024 21:57:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: btrfstune: fix false alerts on
 dev-replace when changing csum
Message-ID: <20240603195703.GC12376@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1717299366.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717299366.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 181A51F441
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Sun, Jun 02, 2024 at 01:15:31PM +0930, Qu Wenruo wrote:
> There is a bug report that if a btrfs has experienced any dev-replace,
> "btrfstune --csum" would always report a running dev-replace and refuse
> to continue.
> 
> It turns out that, DEV_REPLACE item is not a transient one (but not
> created properly as mkfs time either), after a dev-replace the
> DEV_REPLACE item would exist forever, recording the last dev-replace
> timestamp.

I don't think we want to create the item at mkfs time, this would be
confusing and not related to any previous dev-replace operation.

> Although I really hate such behavior (especially when balance item would
> be gone after a balance is finished/canceled), at least fix the problem
> first.

It's handled differently yeah, though the two operations are bit
different, one would run balance more often that dev-replace. But it's
still only for internal tracking, other than that it's not handled the
same way I don't se any problem.

> The first patch enhances the print-tree to properly output the
> contents of the dev-replace item, then the second patch fixes the
> problem.
> 
> I'd like to add test cases for it, but it turns out there is no csum
> change test cases.

I have tests locally from the time I developed it but yeah they should
be in the testsuite.

> My guess is we do not have proper way to skip the test if it's
> experiemental feature?

Currently there's no way to detect it. For some things we can use the
help text, like is done for some features in fstests.

> Maybe it's time to move csum change out of experiemental features?

This depends on creating the separate command group 'tune', this is in
the phase of interface review.

> Qu Wenruo (2):
>   btrfs-progs: print-tree: add support for dev-replace item
>   btrfs-progs: change-csum: handle finished dev-replace correctly

Added to devel, thanks.

