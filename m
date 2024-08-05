Return-Path: <linux-btrfs+bounces-6986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3C947F03
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3401F236C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD415B54B;
	Mon,  5 Aug 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UbHOS9/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdZFduka";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UbHOS9/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdZFduka"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE51514E1;
	Mon,  5 Aug 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874292; cv=none; b=PHbWTOaYvR4ULDohQAePS5an+LTNNWl9cEPa+qwOtYcwz/Brr96jwR0I/pmBSiqC3no2Lci/GFYqJjGDBMlXGW+IoI7nzzZhr4rw3Po+IqraCNBtrh6iTSNkD/bF8g/CuUl3yrqVjkGsHhTaJdcOvkiNoKiCR05Kkm4kVx/RL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874292; c=relaxed/simple;
	bh=PNgqpr2XH86KXWxMDKutv5iOLwQ1tJ3IILRmsbXrZbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0vczoJAor21nDh3rQZ/OhLurORDyaulHyILH0UUKLTxLgwc5g5doGd4pZYXcG2sLTdoYGu7tGq7fitxDhop1fhec4SznkWpc/K3mnxAm7WutlQK73D6KTkAUtpgGxDnvbT5J5cDrBkikhnmeYundVcQy03pfTO9voOdtlz+QVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UbHOS9/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdZFduka; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UbHOS9/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdZFduka; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DFDA21B95;
	Mon,  5 Aug 2024 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722874288;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSkOYSEyFQg1bRiaTVU2cpxUVKG9D5EQe4Kd5GO92U=;
	b=3UbHOS9/BJqydrqBIqigQf2tk3KjI3ABswOQZF6+8socjKG+km8fj3pJfjSLaGX3KVh/KT
	6tR5XFqfPEnHh3A8t3A6g9FGDdyUUeS/N6vltJdkt3BlDPNUC1pKrgIwed8B41K4H8B1VO
	yJxGW0diESM6BCez+iaY7FBe4NiEyXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722874288;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSkOYSEyFQg1bRiaTVU2cpxUVKG9D5EQe4Kd5GO92U=;
	b=JdZFdukaA5vJj6eFNnnnHt4QmxXtkHAz/OZnlleo5UJTPBn1nre2hPaa2TiOSBqwEgvAix
	vUvdSRztGfdsDPDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3UbHOS9/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JdZFduka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722874288;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSkOYSEyFQg1bRiaTVU2cpxUVKG9D5EQe4Kd5GO92U=;
	b=3UbHOS9/BJqydrqBIqigQf2tk3KjI3ABswOQZF6+8socjKG+km8fj3pJfjSLaGX3KVh/KT
	6tR5XFqfPEnHh3A8t3A6g9FGDdyUUeS/N6vltJdkt3BlDPNUC1pKrgIwed8B41K4H8B1VO
	yJxGW0diESM6BCez+iaY7FBe4NiEyXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722874288;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSkOYSEyFQg1bRiaTVU2cpxUVKG9D5EQe4Kd5GO92U=;
	b=JdZFdukaA5vJj6eFNnnnHt4QmxXtkHAz/OZnlleo5UJTPBn1nre2hPaa2TiOSBqwEgvAix
	vUvdSRztGfdsDPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C51E13254;
	Mon,  5 Aug 2024 16:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CUU2BrD5sGaGbAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Aug 2024 16:11:28 +0000
Date: Mon, 5 Aug 2024 18:11:10 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/312: add git commit ID
Message-ID: <20240805161110.GW17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <215d39fcaad6f058b0678191df89d0836aa54a90.1722870144.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215d39fcaad6f058b0678191df89d0836aa54a90.1722870144.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2DFDA21B95
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, Aug 05, 2024 at 04:03:47PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The corresponding kernel fix was merged into Linus' tree, so specify its
> ID in the test.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

