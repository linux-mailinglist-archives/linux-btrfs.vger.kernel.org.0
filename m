Return-Path: <linux-btrfs+bounces-14454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB58ACDDD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894183A458F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88CA28E575;
	Wed,  4 Jun 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQYIBwIH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kgb5xc5k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQYIBwIH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kgb5xc5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6628D8ED
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039852; cv=none; b=VhoUwZQCPaHk1BqssuxxLBWelEIsLt301QpuC4S70jvztrrfwg4Q782WKkUcIjPk9I+nXrq6gOJDWoUtCdQ7Z1mzyDrgKrtj65eVXjlnVqq/fx28ssein757e4aG8WlKAVdYBVXEDcyW18r956/ku4VgZAgxc/ILxn2CMdwB0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039852; c=relaxed/simple;
	bh=Qkwx2PtMdY+GZWm2JOqQf/ukPSLmPiibxLqpLaOjYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agbvMEW4Wcx6GucHipy1bebkVt+gFxcKKhnebEYo6ymW7ahWC7eJ2zqN+kpPwYS2e/YKxpzC8Q49BYQmQopGQmmsrSmGME387FUHKOAo6Uqlu7U+1Lfx4TRjsS9hWzQm30x/4pZ4B2CEObW5b7aiaOuBMj2/VaOFRonxTYRaHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQYIBwIH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kgb5xc5k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQYIBwIH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kgb5xc5k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6123402E;
	Wed,  4 Jun 2025 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749039848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbqMC5BYvJtWKjIDqSzE3ICLmFGbUmgRu0MvuGf0dfU=;
	b=HQYIBwIH7f+kxUlqa4ZuEO9z7CY7c8NuW2IM6NaJaDTycKzK79EzComU+4+BjF8cPYJRfz
	LRXjaSH+iFe2GJOjDppgkPixM//8SGzSiNn2oGu5fhudSXFCK3RD/j8qR4X8T/7fgoXGdd
	V/LyT1NQzUCpr3lWVxSRwhGP/B4jOTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749039848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbqMC5BYvJtWKjIDqSzE3ICLmFGbUmgRu0MvuGf0dfU=;
	b=kgb5xc5kGO3nAd5/1hmYjzRicvHqoJCg0U9dPNgHqWaEeSxPaiylwFovGXLYPRWxGEQCa4
	E8dAHp0ST426CfAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749039848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbqMC5BYvJtWKjIDqSzE3ICLmFGbUmgRu0MvuGf0dfU=;
	b=HQYIBwIH7f+kxUlqa4ZuEO9z7CY7c8NuW2IM6NaJaDTycKzK79EzComU+4+BjF8cPYJRfz
	LRXjaSH+iFe2GJOjDppgkPixM//8SGzSiNn2oGu5fhudSXFCK3RD/j8qR4X8T/7fgoXGdd
	V/LyT1NQzUCpr3lWVxSRwhGP/B4jOTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749039848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbqMC5BYvJtWKjIDqSzE3ICLmFGbUmgRu0MvuGf0dfU=;
	b=kgb5xc5kGO3nAd5/1hmYjzRicvHqoJCg0U9dPNgHqWaEeSxPaiylwFovGXLYPRWxGEQCa4
	E8dAHp0ST426CfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4449E13A63;
	Wed,  4 Jun 2025 12:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZF7EOg6QGgkTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Jun 2025 12:24:08 +0000
Date: Wed, 4 Jun 2025 14:24:02 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: don't silently ignore unexpected extent
 type when replaying log
Message-ID: <20250604122402.GS4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748985387.git.fdmanana@suse.com>
 <7a4820f91854e3e0e52ec39a4dd89ce9878193d6.1748985387.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4820f91854e3e0e52ec39a4dd89ce9878193d6.1748985387.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jun 03, 2025 at 10:19:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If there's an unexpected (invalid) extent type, we just silently ignore
> it. This means a corruption or some bug somewhere, so instead return
> -EUCLEAN to the caller, making log replay fail, and print an error message
> with relevant information.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

