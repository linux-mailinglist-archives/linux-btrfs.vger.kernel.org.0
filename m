Return-Path: <linux-btrfs+bounces-8861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7499A951
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D612811DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E119F411;
	Fri, 11 Oct 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGE+Xy80";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IiLJ2bZU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGE+Xy80";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IiLJ2bZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67C19EEC4
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665978; cv=none; b=jAbAAr1xzJBVgq7tcEFihPSuMGGN6d0zFWS/mQTeuNggmK30uiODWsicc365N+reJTsLz4YE9thu3u/4pnEbQpQTRqdW9M9q8xbB41JbRq34ejN8fdudQI9oSX7M7cxEDQd9C2iiZHtF4T1bWUOalg2EjPpTwDzwIPxm3TY3jfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665978; c=relaxed/simple;
	bh=kM1CFjTySpVjqBMZdb71hexs+im1yq38z7MzPgnB0nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDPD2LY72KL2CGsWOA28GWgMFEAoVBgHheaBeZRROSZRIvEu+QrYnpElwV3PFi7bCQWAGju9fkrSIhrbcD0ahjrZBn0MLE/0nl/LhogVLO6abSDfTzqGqEsQSagRClUQUqWMUjBincEe9nhsNzEjbpBaJQUAfbri8hYwOD0zCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGE+Xy80; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IiLJ2bZU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGE+Xy80; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IiLJ2bZU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF41721EE2;
	Fri, 11 Oct 2024 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728665974;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4aor5O7wFRK/as+wO1zLBJgtlEB99f1CFfQQFUQVqnY=;
	b=iGE+Xy80OuhOoq6POe3uctz/7OtCd/W24wVi7rhU+C5MmvPO0j5wNvLxiAtcBND7Ns6w7I
	H6iR8jYL1KpvSYSKlCeEUmRW1MR8WVg3/euRCZf96lZHWCYAXhTxOcGNKP/PeFgI0D2Vo/
	yBG+iT6vCENmKMXuydGiaSAXSfxpMTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728665974;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4aor5O7wFRK/as+wO1zLBJgtlEB99f1CFfQQFUQVqnY=;
	b=IiLJ2bZUkQlEiu3Rh4EYa7JEy41vdBNxiN7cqMWlcV+dgGGDeXbpsNzrQ1oejlbEK28fiM
	QiDxzo1yUDcRdlBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iGE+Xy80;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IiLJ2bZU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728665974;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4aor5O7wFRK/as+wO1zLBJgtlEB99f1CFfQQFUQVqnY=;
	b=iGE+Xy80OuhOoq6POe3uctz/7OtCd/W24wVi7rhU+C5MmvPO0j5wNvLxiAtcBND7Ns6w7I
	H6iR8jYL1KpvSYSKlCeEUmRW1MR8WVg3/euRCZf96lZHWCYAXhTxOcGNKP/PeFgI0D2Vo/
	yBG+iT6vCENmKMXuydGiaSAXSfxpMTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728665974;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4aor5O7wFRK/as+wO1zLBJgtlEB99f1CFfQQFUQVqnY=;
	b=IiLJ2bZUkQlEiu3Rh4EYa7JEy41vdBNxiN7cqMWlcV+dgGGDeXbpsNzrQ1oejlbEK28fiM
	QiDxzo1yUDcRdlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92288136E0;
	Fri, 11 Oct 2024 16:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oD0gI3ZZCWerQwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Oct 2024 16:59:34 +0000
Date: Fri, 11 Oct 2024 18:59:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix zone unusable accounting for freed
 reserved extent
Message-ID: <20241011165933.GZ1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4d5f6524a0c84e98383ea52dcced34544ff4ae42.1728448186.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d5f6524a0c84e98383ea52dcced34544ff4ae42.1728448186.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: AF41721EE2
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Oct 09, 2024 at 01:30:18PM +0900, Naohiro Aota wrote:
> When btrfs reserves an extent and does not use it (e.g, by an error), it
> calls btrfs_free_reserved_extent() to free the reserved extent. In the
> process, it calls btrfs_add_free_space() and then it accounts the region
> bytes as block_group->zone_unusable.
> 
> However, it leaves the space_info->bytes_zone_unusable side not updated. As
> a result, ENOSPC can happen while a space_info reservation succeeded. The
> reservation is fine because the freed region is not added in
> space_info->bytes_zone_unusable, leaving that space as "free". OTOH,
> corresponding block group counts it as zone_unusable and its allocation
> pointer is not rewound, we cannot allocate an extent from that block group.
> That will also negate space_info's async/sync reclaim process, and cause an
> ENOSPC error from the extent allocation process.
> 
> Fix that by returning the space to space_info->bytes_zone_unusable.
> Ideally, since a bio is not submitted for this reserved region, we should
> return the space to free space and rewind the allocation pointer. But, it
> needs rework on extent allocation handling, so let it work in this way for
> now.
> 
> Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

