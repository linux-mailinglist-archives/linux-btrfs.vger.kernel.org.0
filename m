Return-Path: <linux-btrfs+bounces-10644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2859FB4DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 21:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670521884E53
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340871C3BE4;
	Mon, 23 Dec 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a46Ui/yC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dm2KJuxL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a46Ui/yC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dm2KJuxL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDC80038
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984552; cv=none; b=hKz9t6BP58uRg/ujKVMWy4jzyzMJkrveGo+cPNVCHrC6rFgEZFw5aiOuDOUxosJyfbaMZfudhr7L0YpGbWiEIPjrLFXzYGps+uao978fzgJPIqs/I5OgxVRGaqExhrY2uHi2pUq09I79lyknAubYLb7O5HRSM76uZmdsPqPk6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984552; c=relaxed/simple;
	bh=Ywfj5/6D011KTUc6h42KQUBsERcok9OmQoSemRfNl6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwUTLy6SASWvu1VHF32oY9gFE8AYZsHA0nRGrmIGP0aX06+1OQ9bhcO/Ck/WyTSgTEXgMjH9l+2A1LGmsSLAJXFsSmjQMF8dSDnfMSbHSOJ64bKY8+ZzV5KFMEjJ59k801UtJNm3TgL0Sb37IKxThAu5/0JAOURBiKUmly5n3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a46Ui/yC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dm2KJuxL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a46Ui/yC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dm2KJuxL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78C871F38C;
	Mon, 23 Dec 2024 20:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734984548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UI2psMuA8cP3Q8+aYPzqyjo9wQIyPJEN3sJQx/d0x8g=;
	b=a46Ui/yCgt7uNMIP4iQ6waeHwve+GiX5+lKqe+QwM3ikKwthKFaOjikyuHgqPeh0F6H1Fj
	8csdHTB5n04SffQC6td9rilJGa33clCLO3jMgy6o5VKHBuL7wt+RSp3sS9Y64q/wgS/1Ka
	anwp1C9aMOIw9Z8KYr/zykdS1PaFLuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734984548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UI2psMuA8cP3Q8+aYPzqyjo9wQIyPJEN3sJQx/d0x8g=;
	b=Dm2KJuxL29gad/jMb4C3e66EyYGGKsejw4ik5CyUgWz9Dqehf5wwDL/RYffVwOtGEZjPGF
	kKd+hNuduSw/+CBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="a46Ui/yC";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dm2KJuxL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734984548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UI2psMuA8cP3Q8+aYPzqyjo9wQIyPJEN3sJQx/d0x8g=;
	b=a46Ui/yCgt7uNMIP4iQ6waeHwve+GiX5+lKqe+QwM3ikKwthKFaOjikyuHgqPeh0F6H1Fj
	8csdHTB5n04SffQC6td9rilJGa33clCLO3jMgy6o5VKHBuL7wt+RSp3sS9Y64q/wgS/1Ka
	anwp1C9aMOIw9Z8KYr/zykdS1PaFLuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734984548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UI2psMuA8cP3Q8+aYPzqyjo9wQIyPJEN3sJQx/d0x8g=;
	b=Dm2KJuxL29gad/jMb4C3e66EyYGGKsejw4ik5CyUgWz9Dqehf5wwDL/RYffVwOtGEZjPGF
	kKd+hNuduSw/+CBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C66F137DA;
	Mon, 23 Dec 2024 20:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ts/XFWTDaWewdwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Dec 2024 20:09:08 +0000
Date: Mon, 23 Dec 2024 21:08:59 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/20] btrfs: remove plenty of redundant
 btrfs_mark_buffer_dirty() calls
Message-ID: <20241223200859.GN31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 78C871F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Dec 18, 2024 at 05:06:27PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's quite a lot of places calling btrfs_mark_buffer_dirty() when it
> is not necessary because we already have a path setup for writing, due
> to calls to btrfs_search_slot() with a 'cow' argument having a value of 1
> or anything that calls btrfs_search_slot() that way (and it's obvious
> from the context). These make the code more verbose, add some overhead
> and increase the module's text size unnecessarily. This patchset removes
> such unnecessary calls. Often people keep adding them because they copy
> the approach done from such places.

I've read the explict calls to btrfs_mark_buffer_dirty() as source-level
marker of the section pairing btrfs_search_slot(). There are also some
assertions and eb state checks that were done in set_extent_buffer_dirty(),
now we're losing them.

While the code gets reduced and the calls may be redundant for some
reasons I think we should keep something at least to do the assertions,
or eventually optimize btrfs_mark_buffer_dirty() to be faster if the
path is set up by the search slot with cow=1.

