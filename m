Return-Path: <linux-btrfs+bounces-12700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B63A7710A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 00:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92743188CE88
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD42153CE;
	Mon, 31 Mar 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6GTDNb8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YNpf4kvK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6GTDNb8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YNpf4kvK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909B3232
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743461312; cv=none; b=tKrlRKA/qBBdkRBLEaqewemMgSK/NO1UiuT+gZ+v8O3T6uanFDADbOZGNnFp2aeZq6OLu91smJFnQMXWPVweBSqkKO0+yf3XlsRl/v0xKeb0ed/Rc5Xbfz6I1//R0d4KAqFC8SlGbJRBzWixW4aBJeo/jZk/buVT5x+A5rVXyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743461312; c=relaxed/simple;
	bh=QUOwI7ShHpwhtaV4uw8kpn6LEHIzcrguoaebg7RmAxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqkUtqTy83LTjw5KMb769NkreXeq89XqLC5JQyAmbS/7EXOg77IFD57PLkRra8kJotK3dgjLVOkNMS5HD5KIJ9Q+S8U758/CEwIGy1j1Z9nsrkxhHS2ypshKQFq9/p2sTQnRriTgRWfcv9XJH1ySzxB5NZ5cR7t0VIErdBE5tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6GTDNb8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YNpf4kvK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6GTDNb8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YNpf4kvK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C63652119E;
	Mon, 31 Mar 2025 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743461308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0iySxqLFwWyMaVQqcrDt+BzmZbZuXWd8NRs8NDiHhw=;
	b=O6GTDNb8z90cuJjWATTE9v2wjoumyp2VjjxtnM9ufPAJy8BLNBIVZxGkfNEll8/vazIxzS
	K8YtARFJ4h6nV3sxUb2v2tHc5MYuQFQDsgxeQR+aohtEEZQe+dFugozcmyMRjR8Ol/0Oca
	0CD9Qsr2DqSOzv7AiTdRBBmUQCCpU+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743461308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0iySxqLFwWyMaVQqcrDt+BzmZbZuXWd8NRs8NDiHhw=;
	b=YNpf4kvK0PJlvwh3vs5IyJTVz4aglphimfuwJyGwvFb0qAyakYvrLBVxJUMCrg3dvhx3gz
	+5SVgpnrMYGMl5CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743461308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0iySxqLFwWyMaVQqcrDt+BzmZbZuXWd8NRs8NDiHhw=;
	b=O6GTDNb8z90cuJjWATTE9v2wjoumyp2VjjxtnM9ufPAJy8BLNBIVZxGkfNEll8/vazIxzS
	K8YtARFJ4h6nV3sxUb2v2tHc5MYuQFQDsgxeQR+aohtEEZQe+dFugozcmyMRjR8Ol/0Oca
	0CD9Qsr2DqSOzv7AiTdRBBmUQCCpU+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743461308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0iySxqLFwWyMaVQqcrDt+BzmZbZuXWd8NRs8NDiHhw=;
	b=YNpf4kvK0PJlvwh3vs5IyJTVz4aglphimfuwJyGwvFb0qAyakYvrLBVxJUMCrg3dvhx3gz
	+5SVgpnrMYGMl5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B290D139A1;
	Mon, 31 Mar 2025 22:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nt0RK7wb62eUSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 31 Mar 2025 22:48:28 +0000
Date: Tue, 1 Apr 2025 00:48:27 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: improvements to the release_folio callback
Message-ID: <20250331224827.GM32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743004734.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743004734.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,twin.jikos.cz:mid];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Mar 27, 2025 at 04:13:49PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple improvements to the release_folio callback and an update to a
> related function comment that's still referring to pages when the callback
> is now folio aware. Details in the change logs.
> 
> Filipe Manana (3):
>   btrfs: update comment for try_release_extent_state()
>   btrfs: allow folios to be released while ordered extent is finishing
>   btrfs: pass a pointer to get_range_bits() to cache first search result

Reviewed-by: David Sterba <dsterba@suse.com>

