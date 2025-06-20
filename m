Return-Path: <linux-btrfs+bounces-14822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A5AE1BE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CBF165A1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7928B7EC;
	Fri, 20 Jun 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrIUFu+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aF9PCbHP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PrIUFu+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aF9PCbHP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238D7494
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425414; cv=none; b=JV+MurdQaNPFn3nkY5gXPvu3B2gIAaZAkwXl7d1wGTy5IPMCCsjZ8/pjiw1rAtmiKlFpiFEnTqN7iImIxNHPKH6AnZly7agXNrX9IFUdgPi1JR0kstvHSsBV83Xov8dsOg1Tm5QqTedmzmiv50Y0UFBN+AM4aFt0seMVV5+DA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425414; c=relaxed/simple;
	bh=QXvKSTJVsujp1fgnDXrmCqG3IIieQCr1r2bJH4zgVyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSTBbKqlxHTZdih2FMA0a9Or+oCFNSuMJmx4B3kR4oGJr6vBfeLmLgqqKjFXHGFNFEH3l0Y169XVZbGnw2BuZgwWmMQ9GAz+hctoz9xwl3LpUVtwa4wn9t5vJ3vUaGNBFkoJLPyJBKuHB87Q9d5MI1m7KZ4KHc3P17vQW2rYr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrIUFu+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aF9PCbHP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PrIUFu+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aF9PCbHP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF87C21174;
	Fri, 20 Jun 2025 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750425410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTWKwgHggj/k6+j+DOM+rvwRUGMPVPZLTleNMuJSR8g=;
	b=PrIUFu+gM1NKYzlW99cT29bPerrfOZ1bViewIfx5F8Rqq+TX6gOxFLc+lh1WmsE1s0z/O7
	zVXYbrdR/Wk7MDzC7br6RNO2wWeggWDbTw+tgui4yxfth8l6eW+igG1mZrprQFRPugB0Fd
	hfV3hRkwF4TgCvvbPeIXq2Yme8YaAVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750425410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTWKwgHggj/k6+j+DOM+rvwRUGMPVPZLTleNMuJSR8g=;
	b=aF9PCbHPngTY++uTx4KRe1NJrmmCT0nWp/qsRelYvj3RRym5xpAP2XjshAV+PkX8y6mrzD
	btOnMn7BzNJAmEAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750425410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTWKwgHggj/k6+j+DOM+rvwRUGMPVPZLTleNMuJSR8g=;
	b=PrIUFu+gM1NKYzlW99cT29bPerrfOZ1bViewIfx5F8Rqq+TX6gOxFLc+lh1WmsE1s0z/O7
	zVXYbrdR/Wk7MDzC7br6RNO2wWeggWDbTw+tgui4yxfth8l6eW+igG1mZrprQFRPugB0Fd
	hfV3hRkwF4TgCvvbPeIXq2Yme8YaAVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750425410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTWKwgHggj/k6+j+DOM+rvwRUGMPVPZLTleNMuJSR8g=;
	b=aF9PCbHPngTY++uTx4KRe1NJrmmCT0nWp/qsRelYvj3RRym5xpAP2XjshAV+PkX8y6mrzD
	btOnMn7BzNJAmEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5EEF13736;
	Fri, 20 Jun 2025 13:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l0H4J0JfVWhGNgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 13:16:50 +0000
Date: Fri, 20 Jun 2025 15:16:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] btrfs: increase usage of folio_next_index() helper
Message-ID: <20250620131642.GX4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250619101501.139837-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619101501.139837-1-rongqianfeng@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 19, 2025 at 06:15:01PM +0800, Qianfeng Rong wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index().
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Added to for-next, thanks.

