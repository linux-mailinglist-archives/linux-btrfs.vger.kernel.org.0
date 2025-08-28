Return-Path: <linux-btrfs+bounces-16514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86891B3AE79
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC45984FFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC72D6406;
	Thu, 28 Aug 2025 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bpnb1Gg0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gYf3KxpN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bpnb1Gg0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gYf3KxpN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A61A4E70
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424150; cv=none; b=lPiLbWgLaK274aI+z05AG3JLLEQ+BpSkPfqW3afgRSQFXtQ6tamCkbqtjpGrxz26e084F3e7SQG0qsTjD2/Nkx7a64I6EXj/Lm18qruJ+SbJuR3zvJax4wvbOFzmM/RmpJBUKt49DAT3e2DtMUzSgElXjknrx64pR2SwnHFKyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424150; c=relaxed/simple;
	bh=m1A15g8VXjmcpdpCd9vB1QEHqOOzcHd25XmIhMr/bYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txZ5TdeNuix6wKrDEqhqijRAG92xgJt6t8inWjJqjJBpKDeJhx+TPiKqKRKRmifOIhAJ95cedNRYIv/SyjUmVz9uRf69jsZH93YfrIYU/hz5K6au8FdDdhiUyfMUrMGZnPJHFwlfBzltyeH9FAeb0wyhkuNVImEGnk9j5y5PuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bpnb1Gg0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gYf3KxpN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bpnb1Gg0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gYf3KxpN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 042CE20FA6;
	Thu, 28 Aug 2025 23:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756424147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1A15g8VXjmcpdpCd9vB1QEHqOOzcHd25XmIhMr/bYg=;
	b=Bpnb1Gg0KJbFVQxAjXIsKWjRKNyUvLVG3b/0sx8mHG1nD2yJQ7xPX6waeGGxpjn91540C5
	r7Ejyeqj3t27BfTD1plfwgsVs4mkmDHcL5onrtb0wgtJf4wPPY9VcRjHYvnrMV7bIPJZbD
	WQp88/W7zn74lWqBHjcyVU+1o0KYqQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756424147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1A15g8VXjmcpdpCd9vB1QEHqOOzcHd25XmIhMr/bYg=;
	b=gYf3KxpNNyODEoeXlan1Ov2purnOoM8VAIcdwWS9gZAQ6D4GyjhPdfTA+v6tJ4AouXZzlX
	TeJGgVURH3oL8pDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bpnb1Gg0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gYf3KxpN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756424147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1A15g8VXjmcpdpCd9vB1QEHqOOzcHd25XmIhMr/bYg=;
	b=Bpnb1Gg0KJbFVQxAjXIsKWjRKNyUvLVG3b/0sx8mHG1nD2yJQ7xPX6waeGGxpjn91540C5
	r7Ejyeqj3t27BfTD1plfwgsVs4mkmDHcL5onrtb0wgtJf4wPPY9VcRjHYvnrMV7bIPJZbD
	WQp88/W7zn74lWqBHjcyVU+1o0KYqQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756424147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1A15g8VXjmcpdpCd9vB1QEHqOOzcHd25XmIhMr/bYg=;
	b=gYf3KxpNNyODEoeXlan1Ov2purnOoM8VAIcdwWS9gZAQ6D4GyjhPdfTA+v6tJ4AouXZzlX
	TeJGgVURH3oL8pDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E339913326;
	Thu, 28 Aug 2025 23:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAVLN9LnsGgASQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Aug 2025 23:35:46 +0000
Date: Fri, 29 Aug 2025 01:35:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix typos in comments and strings
Message-ID: <20250828233545.GF29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250821225742.1151914-1-dsterba@suse.com>
 <12730365.O9o76ZdvQC@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12730365.O9o76ZdvQC@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 042CE20FA6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Thu, Aug 28, 2025 at 09:43:51PM +0800, Sun YangKai wrote:
> I also found this when reading code ;)

Thanks, I can add it to the patch unless you have more fixes. This is
not a spelling fix so the tools I've been using cannot catch that.

