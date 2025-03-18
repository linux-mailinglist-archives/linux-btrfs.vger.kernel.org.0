Return-Path: <linux-btrfs+bounces-12387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15512A678AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D7A17CF01
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154020FAB1;
	Tue, 18 Mar 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="urdIo3+0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9M3T7Lay";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="urdIo3+0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9M3T7Lay"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9420E6F0
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313900; cv=none; b=OLJPi1xhbYNZVXrIHwwtkViJlgr5ycxh+P6PUC4yBY9krkiqhP6raNKcHUe50awQvfseK778On6+PnVAcIyt4SXRmqrAZ/qHxGqVW7E+60UG+CU69XESlGm2WGZzmB1Lym6gGhQRdqs/wZcqb8oevW9kBQ50ZTWhorK0z6nRlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313900; c=relaxed/simple;
	bh=F2T1fYu7qkIjMSUOVQ0oCYiUNPGqVeBrlJai7mg9Nr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnEw4S0iqCGgERfh5JUaHb4azTwhQavfUk5td7/uO2/muQLZP98aiumdzLsKO8kPPSixNWzWd1oj3A9CjqGctJQM3BIVPa1qMvD2tog5v+JW/7d91ox9x7uXa2uUf+vpqmGlNxS2+VUHVYdVk2w/YkDCymUklr97NNmylvvg7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=urdIo3+0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9M3T7Lay; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=urdIo3+0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9M3T7Lay; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02EF31F7D3;
	Tue, 18 Mar 2025 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742313897;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivZRbXogdneU/37rIa+v4JLD2Fg6+YrfL6/CDccjnGQ=;
	b=urdIo3+00U8lXL/vSRFyi3OQXJ7AngMrqGWL+rT60VuXq1pp5wIqKdG+OF/mHmtksqdrmO
	h6tgCuA6Ug4ctGOamWQ6rRwmBNTWderAV+iMrn0n0B1Uhinem9OE3g2LRydmM92pBLpYBJ
	1RY0KVMY9QvOHHuGEfcnDTejqmbtK0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742313897;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivZRbXogdneU/37rIa+v4JLD2Fg6+YrfL6/CDccjnGQ=;
	b=9M3T7LayicqbqNuTItvA7pO4WarWoDwcZJ+iL8IJs+1sWKWz6nKQ4BjMhpNq87Q/c8dsRN
	k6H8YH0VV1cEXzBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=urdIo3+0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9M3T7Lay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742313897;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivZRbXogdneU/37rIa+v4JLD2Fg6+YrfL6/CDccjnGQ=;
	b=urdIo3+00U8lXL/vSRFyi3OQXJ7AngMrqGWL+rT60VuXq1pp5wIqKdG+OF/mHmtksqdrmO
	h6tgCuA6Ug4ctGOamWQ6rRwmBNTWderAV+iMrn0n0B1Uhinem9OE3g2LRydmM92pBLpYBJ
	1RY0KVMY9QvOHHuGEfcnDTejqmbtK0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742313897;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivZRbXogdneU/37rIa+v4JLD2Fg6+YrfL6/CDccjnGQ=;
	b=9M3T7LayicqbqNuTItvA7pO4WarWoDwcZJ+iL8IJs+1sWKWz6nKQ4BjMhpNq87Q/c8dsRN
	k6H8YH0VV1cEXzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D021379A;
	Tue, 18 Mar 2025 16:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OKmnNqiZ2WcrLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 16:04:56 +0000
Date: Tue, 18 Mar 2025 17:04:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
Message-ID: <20250318160455.GG32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250318095440.436685-1-neelx@suse.com>
 <20250318160017.GF32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318160017.GF32661@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 02EF31F7D3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 05:00:17PM +0100, David Sterba wrote:
> On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> > This flag is set after inserting the eb to the buffer tree and cleared on
> > it's removal. But it does not bring any added value. Just kill it for good.
> 
> I na similar way the flag EXTENT_BUFFER_READ_ERR is unused (was removed
> in eb/io rework in 046b562b20a5cf ("btrfs: use a separate end_io handler
> for read_extent_buffer").

And EXTENT_BUFFER_READAHEAD, removed by f26c9238602856 ("btrfs: remove
reada infrastructure").

