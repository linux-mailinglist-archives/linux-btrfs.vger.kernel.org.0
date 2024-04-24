Return-Path: <linux-btrfs+bounces-4527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082418B10D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5B01F2514E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B716D335;
	Wed, 24 Apr 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HlTY58BF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TeAiDM3L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vDbFyv6U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SJyoG0Us"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9015E7E9
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979294; cv=none; b=PZmhUaunUlYH9PjIzGyPZRJ+9r/lpuoog4fmsQJS8xRpIMvXojqBdLxcifT3DpofDlgFbuWLykg3GRXi+pXoKx/Ed6n4aoCPohdz0y7YbdzuRRjDuf0WvBSZ8D7rOH7dvSaEAa6KIYcjzmmgeioy3/dYMtKO+V9d+CoXtv+jisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979294; c=relaxed/simple;
	bh=JgcUAXNrimRdK/MHi4Iu4pCuP8b3gcZYUFPpGzMSFtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPsZuytn5HnoZ7kKiPZGt2VYsRNDFBSxDXAwg/+OKn2xSH3dwbNGogV9ZHAvXGp4wWYHlWKxaT4jIGY1IY1/EgoZOdH/zpbNrJxQN310asdq64WCq9qmMFkC+rIUQMq4wFrkHqiSLAelYiwIpR+vH5zIZ+XqvGQuTWfMh9WDgvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HlTY58BF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TeAiDM3L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vDbFyv6U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SJyoG0Us; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E3DA1F7FD;
	Wed, 24 Apr 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713979289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumZEOXMy7t0FipfmEQhfP7X9u+B/mP1ixurSXzbpFc=;
	b=HlTY58BFtv9HfMDX/Ky1YrVPeZjj9U2WS+FJ/wDJlby4EZDXURwCBOgx14/4PDDpCM4ZJr
	UcdS+UFgayH6YE7iO2azW6beS2EWtBVukq/EQylRhkL7Q8Kl6GOcQMReBBCuzs39PQ/Dd1
	FtfPoP50UyqRxGSE2kKOFdviNYwKCXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713979289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumZEOXMy7t0FipfmEQhfP7X9u+B/mP1ixurSXzbpFc=;
	b=TeAiDM3LrzUoNMrvZN1AbHbiAnkRCTe3KBRW56ru04f1jIUTs2tH6SMkWRosXDwoGCapsJ
	GGylwvG6/mgC5RCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vDbFyv6U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SJyoG0Us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713979288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumZEOXMy7t0FipfmEQhfP7X9u+B/mP1ixurSXzbpFc=;
	b=vDbFyv6ULlHH4TkxcL/o2d1lR3m+4KXnYpWBXVZt/NtaptY15i2gfHmdEuvmZDV0bA3qBU
	eSXjrKzyr2zE+lqD8JYz3z6KS7l2VFsg2q/vblmTNcG8x4k8woVjYc8dnNgEfpXxECl8Mi
	aiLxFh8kl8RJpD5I+p278p2q+rD4lCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713979288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HumZEOXMy7t0FipfmEQhfP7X9u+B/mP1ixurSXzbpFc=;
	b=SJyoG0Us2L13nKjONVIwUpx7dLlcKiPrNhXa1gkWYiYPeqjotqfGP9Z4qImDgoYLtbNwTQ
	5O8Y3zgqDaXr9cBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 694711393C;
	Wed, 24 Apr 2024 17:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Xg+GZg/KWZcRwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:21:28 +0000
Date: Wed, 24 Apr 2024 12:21:23 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 17/17] btrfs: add a cached state to
 extent_clear_unlock_delalloc
Message-ID: <soy27ti6urv5yxtptzqzm4gnf4w3emyfdfvsv7rmvtcz67ts53@hp5jmu4tau5k>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <62f3c0fa890b9bebc7f2d1871ec4c885c5287ed5.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f3c0fa890b9bebc7f2d1871ec4c885c5287ed5.1713363472.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.35 / 50.00];
	BAYES_HAM(-2.34)[96.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7E3DA1F7FD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.35

On 10:36 17/04, Josef Bacik wrote:
> Now that we have the lock_extent tightly coupled with
> extent_clear_unlock_delalloc we can add a cached state to
> extent_clear_unlock_delalloc and benefit from skipping the extra lookup
> when we're doing cow.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

