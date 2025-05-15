Return-Path: <linux-btrfs+bounces-14039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA201AB89CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BC03A17D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2A1F8F09;
	Thu, 15 May 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVDvK/YZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WzvYZd68";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVDvK/YZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WzvYZd68"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D21586C8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320467; cv=none; b=nag5/mn25/d8JOQ43va5BJyZpymK0/TQo+fIWYVW6EqmRHw96xe9PIaD5v0QNi3m7CfMUKzJiSLjKtX6PyU/ReX8iIcCThlinYFq2IagPpPBwM/9g2d8a7xG+SWuc3l8xI0pl6RMVCtCaUH4x/CUdIw+dMD+jG9p8cUfoDV4EEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320467; c=relaxed/simple;
	bh=AvwUHYD5Fq/xQFEh8ap3xvw+zJioAhbtQpwDB2R8wKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1GKfR7VZ46Mhu4sa/dtZtdgPUPG0+RGB5mLLwLnF5Z/0IxL9dyYyHl3kSNePfRWdyprkkdNZWdyLJAgUEzcgcsQ4IGGA/vyOXPGhUhxEaaziv2pLM+3nRJsdOgRHKS1l+OaUTcQBOOqC27uu49uUg1UIIDtYemt1M+k1U+o1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVDvK/YZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WzvYZd68; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVDvK/YZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WzvYZd68; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 336E01F443;
	Thu, 15 May 2025 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747320464;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnYHtBKASPLAOtuGt4YsnZvc9ic2L7xSRfx99ZJ5p/w=;
	b=RVDvK/YZP1EEiZxvHk+93x3yX7RsZekLXYm7ukeSEzkaKm2ivTyiVGaId69YsyR6pS94Ul
	lLntYc/mgK7xpwy72p9SeuCJ8Di1IkLskZUFYXz4M7GG8+L8TsfDcSHdHEyLFpAema1ujf
	iHWjoIjAVL+BQVbBo0rEAGf5s9nH4RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747320464;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnYHtBKASPLAOtuGt4YsnZvc9ic2L7xSRfx99ZJ5p/w=;
	b=WzvYZd68lc8mlnj1RfCEmSdDxaCPJpenEGx3Qfau24xp2sdYAIxhPTTKC+Vn0XQkgOI2Zn
	WcmEvZYMR2jvYmDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="RVDvK/YZ";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WzvYZd68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747320464;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnYHtBKASPLAOtuGt4YsnZvc9ic2L7xSRfx99ZJ5p/w=;
	b=RVDvK/YZP1EEiZxvHk+93x3yX7RsZekLXYm7ukeSEzkaKm2ivTyiVGaId69YsyR6pS94Ul
	lLntYc/mgK7xpwy72p9SeuCJ8Di1IkLskZUFYXz4M7GG8+L8TsfDcSHdHEyLFpAema1ujf
	iHWjoIjAVL+BQVbBo0rEAGf5s9nH4RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747320464;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnYHtBKASPLAOtuGt4YsnZvc9ic2L7xSRfx99ZJ5p/w=;
	b=WzvYZd68lc8mlnj1RfCEmSdDxaCPJpenEGx3Qfau24xp2sdYAIxhPTTKC+Vn0XQkgOI2Zn
	WcmEvZYMR2jvYmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1508C137E8;
	Thu, 15 May 2025 14:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AtLlBJD+JWiTOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 15 May 2025 14:47:44 +0000
Date: Thu, 15 May 2025 16:47:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
Message-ID: <20250515144742.GH9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250514131240.3343747-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514131240.3343747-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 336E01F443
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.21

Please write more descriptive subject lines, related to what is being
cleaned up, and not just a generic "function() cleanup".

On Wed, May 14, 2025 at 03:12:39PM +0200, Daniel Vacek wrote:
> This function is always called with the LINK_LOWER argument. Thus we can
> simplify it and remove the LINK_LOWER and LINK_UPPER macros.
> 
> The last call with LINK_UPPER was removed with commit
> 0097422c0dfe0a ("btrfs: remove clone_backref_node() from relocation")

While removing the code is ok, looking to the git history I think
there's probably more, related to the node linking. Here it's removing
one half (LINK_UPPER).

