Return-Path: <linux-btrfs+bounces-15206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC3AF5D84
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AF53A74DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A62459D7;
	Wed,  2 Jul 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSRoSC+v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iq6On60h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSRoSC+v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iq6On60h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D90267B01
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470989; cv=none; b=fgNSaxEtDCtgiZxyLm5vbNjq1h7BnEoh26anFsge+amJFlRtV/R9k2K9BcYY+XDb7kjToOGm5LPxBwlzMAHIfxdVa8OeT0M+Tt2jQixGzyN4V7+9LFO7EbnUlLh1k/dl0Rqiyf4BxJBt8RMtO89Y7ejTfRyssqwlNv32OheaYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470989; c=relaxed/simple;
	bh=wQVFVe7IVkkEvRkHubgTxA4DRWP5Bv3vuwTeBH/lcgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3AotLulK79HkpWB6wWja2G5dnTppHDGBeCSbZI4nxEkb/4HGxLgUKryOhOuSDDrnWRSfUafiOgdMfKMArgjWpP2gP2VeD56QmwRNXKS/YaRDAGdg8sDnrDGY2Ia9f0NR0Is9zu2GExWXKy6K6e2TJk5wjtE5zqGDUliXGDNYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSRoSC+v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iq6On60h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSRoSC+v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iq6On60h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56FFE2118C;
	Wed,  2 Jul 2025 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751470985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQVFVe7IVkkEvRkHubgTxA4DRWP5Bv3vuwTeBH/lcgQ=;
	b=hSRoSC+v9fIxaZUCQvAfQJodM8p1mi+diByLTNUQV4Ai21pmgG5IOg+TnmJLhCtGAEpIMb
	25LHtpwKCHV8V6ozbrNmM0mFv+WxVKUo3Za/Twk/cTIK4z8KrZO2rVfJ7StUQxvf+XVEWe
	tdbHn1U70cr49Wc8Ug3c/9r2/lBj8C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751470985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQVFVe7IVkkEvRkHubgTxA4DRWP5Bv3vuwTeBH/lcgQ=;
	b=iq6On60hZhW9jFxrvk5ryGftucZPcgF0yYoRFW09wZ1fj7by0ixqOPPrnOfpeOmr/IfN4s
	dfrL5qhwHC4DMJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hSRoSC+v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iq6On60h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751470985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQVFVe7IVkkEvRkHubgTxA4DRWP5Bv3vuwTeBH/lcgQ=;
	b=hSRoSC+v9fIxaZUCQvAfQJodM8p1mi+diByLTNUQV4Ai21pmgG5IOg+TnmJLhCtGAEpIMb
	25LHtpwKCHV8V6ozbrNmM0mFv+WxVKUo3Za/Twk/cTIK4z8KrZO2rVfJ7StUQxvf+XVEWe
	tdbHn1U70cr49Wc8Ug3c/9r2/lBj8C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751470985;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQVFVe7IVkkEvRkHubgTxA4DRWP5Bv3vuwTeBH/lcgQ=;
	b=iq6On60hZhW9jFxrvk5ryGftucZPcgF0yYoRFW09wZ1fj7by0ixqOPPrnOfpeOmr/IfN4s
	dfrL5qhwHC4DMJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46C1213A24;
	Wed,  2 Jul 2025 15:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDIMEYlTZWjGXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 02 Jul 2025 15:43:05 +0000
Date: Wed, 2 Jul 2025 17:43:04 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: convert several int parameters to bool
Message-ID: <20250702154304.GV31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250702143403.931542-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702143403.931542-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 56FFE2118C
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Jul 02, 2025 at 04:34:03PM +0200, David Sterba wrote:
> We're almost done cleaning the misused int/bool parameters. Convert a
> few of them, found by manual grepping as we don't have a tool for that.
> Note that btrfs_sync_fs() needs an int as it' mandated by the struct
> super_operations prototype.

And with a bit more refined seach I found way more:

17 files changed, 56 insertions(+), 63 deletions(-)

I'll probably do another pass once we'll code freeze for 6.17 so there
are no conflicts with any pending patches.

