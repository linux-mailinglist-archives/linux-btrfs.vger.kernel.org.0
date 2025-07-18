Return-Path: <linux-btrfs+bounces-15553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F4B0AA13
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4951E1C80D12
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417F428850F;
	Fri, 18 Jul 2025 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kQPwUYQP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="60tLBPs3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zh8FXgCO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xnEU7zWU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1117A2F5
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862865; cv=none; b=iYzC0f7vEFji7Xm2PrmfZg8BikIYslv5ZO0a9JuTy2M3ouW21At1TYyOrRy7FfHLqMancLr3Y/P6gYN5vG/O+jgxqH3TuTQ8IANOYbg04j/pcYCM00idOq669vNHTemFL6DxhTcId7SMBxd9MmWXYXfSWeJ+0+Nqtc7QGXjIn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862865; c=relaxed/simple;
	bh=nV17hdiHQgzHE1WucK+TV5+GnNM0yHOuusgqq5R1xmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjLFoJ2N3QlZO4p4hQ6NeYXPVK3BDc3UMxkIGCHqzPrV2bxd8aD9xNlSv52oXbFXWeW4LNEb3FGznKuoaBcVyQxPyfDKuf+4pVwg4Y44tr9OdWmQmGWuYCM+/+BIjAyRStMs/fyF1h9ap4Nbnsfjp579AVhdMw1aNHE81eKTRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kQPwUYQP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=60tLBPs3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zh8FXgCO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xnEU7zWU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A9B62123D;
	Fri, 18 Jul 2025 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752862861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8KgyVRYF8OkndTK2ou/fO7vs2sFnhd15aIyJ1p9Quk=;
	b=kQPwUYQP4FRGkdmXxrsNCHbgQ4MRi6ASStREbqfPMeHfY8l0E3tv5uGmR7GLGDjjmvcu9B
	6yx58Z6BlqVG3ki7sNLUxqKtXtNpfojEdP9CzT4sgsrJEptD4YRutGO+AoJD3IZMLFqLzP
	8MaK9m5fIbKxqxcTYRfmtdoWNksrIgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752862861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8KgyVRYF8OkndTK2ou/fO7vs2sFnhd15aIyJ1p9Quk=;
	b=60tLBPs3mIgf+GtyPI6Kc5eDv3trQcpMcfZHuWRcULHVE7o3vUCRZbtOp6NXSAglH2i6HG
	76bwsS1IsKiOm7Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zh8FXgCO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xnEU7zWU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752862860;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8KgyVRYF8OkndTK2ou/fO7vs2sFnhd15aIyJ1p9Quk=;
	b=Zh8FXgCOgTZelGd1sTDKPpHUwbWaHU8C1FVj7Ytb4/kAlMM6T30OKr8OI1zAP5OiuABGgA
	J5sbJRYcmEgw6WKDUADrP9Bw8qlDWw+wD+H5wK5Ks9NZ0lDjefseqx6EFEkF07ZOIOBEi6
	MCu44UaOG3wsGaTIyWGMjflo5yR0pG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752862860;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8KgyVRYF8OkndTK2ou/fO7vs2sFnhd15aIyJ1p9Quk=;
	b=xnEU7zWU/5el96ttpcoaRbf97L4BuLnGh1V113bLFDqnH12a+6L2JsZeB65YRo6B551vcp
	jwmecdzI6gHjhPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04BE213A52;
	Fri, 18 Jul 2025 18:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRP+AIyQemjMbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 18 Jul 2025 18:21:00 +0000
Date: Fri, 18 Jul 2025 20:20:58 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction aborts when writing dirty
 block groups
Message-ID: <20250718182058.GB6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2289bf86333cbe87cd607891d8021abff43187a5.1752859064.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2289bf86333cbe87cd607891d8021abff43187a5.1752859064.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1A9B62123D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Jul 18, 2025 at 06:20:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a single transaction abort call that can be due to an error from
> one of two calls to update_block_group_item(). Unfold the transaction
> abort calls so that if they happen we know which update_block_group_item()
> call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

