Return-Path: <linux-btrfs+bounces-18432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3BC230ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 03:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AD43A5C10
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 02:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0907B30BBBC;
	Fri, 31 Oct 2025 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e85s43rW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nrYTBjH3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e85s43rW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nrYTBjH3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2765270EC3
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878882; cv=none; b=oyN2GNzKBnxbqvqg2LLll0i0HJJ7wWzg4ZcCGwB1FRtJieSqCFRa0fQxDxW7AGK7Wwe0+D8GpCrE4T/LeXia9USUbSFJMnFuXm0t2FX8MXMXCi0NuYUoi8JEXdGeLTKCT+nnWO5oZbejiUfaQDBkYWq+mZ1xQJ+szNGfNxoiJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878882; c=relaxed/simple;
	bh=bLBpxdgUCbsLUsaMqM45LAHkJwWVl9C7rd1V9/efFCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjmrjtKWpJnSV3+Ex/gj74DWUAMW0rOy0BxV2eL10BLTzSjOkXONE+OUFWG5cu/PWEhd0Jk+mCVYjRDnPBk/HRh+MqgzG9FVlZQS4d60pIRqcdqE2cS7tgtBrM4DRuXMV0M8M48v+6+YKo6VIuI9MBQ9lsjX5Dvq5UNaaGxbUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e85s43rW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nrYTBjH3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e85s43rW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nrYTBjH3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAC7A1F76B;
	Fri, 31 Oct 2025 02:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761878878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8nM4SsjwoWjmmxRMahEd1ZTGObKzPcI4PONYjrYYW7I=;
	b=e85s43rWTxZ63rONy8eAAu2n46LTG1dvmFB0c2IwrWKw0WeXge3+ojbFop4tvx4VMI9k2Y
	mcNXQlOmOIdZ7unl2GztZiKYRi+VYqEhI2VUJeU7b/hm1v9GlcoO0Dy/NcXicDuELu5DBG
	tRE4Tbmb4wAwJzah9FLBjJ8eivWk+S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761878878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8nM4SsjwoWjmmxRMahEd1ZTGObKzPcI4PONYjrYYW7I=;
	b=nrYTBjH3z4mkjmmT9EbLnka1VJCvGmPwtbsVzPwsMQyj8Td6cmTc9dxYOqLdWNjZmYEOCC
	FAtUgsq21T3C12Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e85s43rW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nrYTBjH3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761878878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8nM4SsjwoWjmmxRMahEd1ZTGObKzPcI4PONYjrYYW7I=;
	b=e85s43rWTxZ63rONy8eAAu2n46LTG1dvmFB0c2IwrWKw0WeXge3+ojbFop4tvx4VMI9k2Y
	mcNXQlOmOIdZ7unl2GztZiKYRi+VYqEhI2VUJeU7b/hm1v9GlcoO0Dy/NcXicDuELu5DBG
	tRE4Tbmb4wAwJzah9FLBjJ8eivWk+S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761878878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8nM4SsjwoWjmmxRMahEd1ZTGObKzPcI4PONYjrYYW7I=;
	b=nrYTBjH3z4mkjmmT9EbLnka1VJCvGmPwtbsVzPwsMQyj8Td6cmTc9dxYOqLdWNjZmYEOCC
	FAtUgsq21T3C12Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A49013393;
	Fri, 31 Oct 2025 02:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Ed9JV4jBGlnYQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 02:47:58 +0000
Date: Fri, 31 Oct 2025 03:47:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert: prevent data chunks to go beyond
 device size
Message-ID: <20251031024753.GH13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: BAC7A1F76B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Sat, Oct 25, 2025 at 10:00:41AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that kernel is rejecting a converted btrfs that
> has dev extents beyond device boundary.
> 
> The invovled device extent is at 999627694980, length is 30924800,
> meanwhile the device is 999658557440.
> 
> The device is size not aligned to 64K, meanwhile the dev extent is
> aligned to 64K.
> 
> [CAUSE]
> For converted btrfs, the source fs has all its freedom to choose its
> size, as long as it's aligned to the fs block size.
> 
> So when adding new converted data block groups we need to do extra
> alignment, but in make_convert_data_block_groups() we are rounding up
> the end, which can exceed the device size.
> 
> [FIX]
> Instead of rounding up to stripe boundary, rounding it down to prevent
> going beyond the device boundary.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

