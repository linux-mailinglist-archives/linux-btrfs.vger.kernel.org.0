Return-Path: <linux-btrfs+bounces-7119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41EE94EBD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36D0282171
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739C175D3E;
	Mon, 12 Aug 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyMVcG+L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7kP6X5rJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyMVcG+L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7kP6X5rJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D83C0B;
	Mon, 12 Aug 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462275; cv=none; b=BuFnXHfrf29g6GqFqAkU1RhNNLi0V5PvrQhdVmAOS8zgC4OgzLjOyuZlGNWOqbu1w2Lp2C+d2IakzcMS58w6jFmc+ImMDk6nbgLOLIVHKfkiSC2y4ugS+4DUTNXrBGAy1TvTgS3lHLVZWQkdIoA2kc6t4IL/12mzzgzkHR6i83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462275; c=relaxed/simple;
	bh=3+CJyFJLjoj48HvzCItu+Gv0H77IGYQqfEAS0cyyUuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxObA11sfI143E5MdYo8m3beKueJCprjnYV2fJntilOXtsCOCZJFSexYWrGw8zqviBh0bUuAnFV89T0dFTmqWqvADECg2YJ8D5JSJQrgOJb7ZhMlSrgVc8sMBSPnIgKlcE9LKPFgFifnGeddosdUzfZe52sF2iaAIV22isYMMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyMVcG+L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7kP6X5rJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyMVcG+L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7kP6X5rJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1165920268;
	Mon, 12 Aug 2024 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723462272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96EUmExynSb2mVUwXqoNk5b4rhcR95sKR8ipS/TtSM4=;
	b=dyMVcG+Lmr2O2jHkLermQPV7/4oOxALt18XgN4JNkvp+4B6Ho1nWU5p3C4v0gtNgl98G9j
	Ujj9j/FQcuMemw4frEA+FECc6KrJPkm36J5sqwprL0fA7XCv+bsSQ6B69yTBz6FSVj0CTe
	20dsURmjEnkaDt5bV96s9XvSrozGI2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723462272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96EUmExynSb2mVUwXqoNk5b4rhcR95sKR8ipS/TtSM4=;
	b=7kP6X5rJ8NnFfLBeNABY0HHRv7JxhuA8dYva58mIB4mCHHfWpOR8IBEif1U559MXvVwuby
	cyYHD8VwzTe6JJCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dyMVcG+L;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7kP6X5rJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723462272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96EUmExynSb2mVUwXqoNk5b4rhcR95sKR8ipS/TtSM4=;
	b=dyMVcG+Lmr2O2jHkLermQPV7/4oOxALt18XgN4JNkvp+4B6Ho1nWU5p3C4v0gtNgl98G9j
	Ujj9j/FQcuMemw4frEA+FECc6KrJPkm36J5sqwprL0fA7XCv+bsSQ6B69yTBz6FSVj0CTe
	20dsURmjEnkaDt5bV96s9XvSrozGI2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723462272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96EUmExynSb2mVUwXqoNk5b4rhcR95sKR8ipS/TtSM4=;
	b=7kP6X5rJ8NnFfLBeNABY0HHRv7JxhuA8dYva58mIB4mCHHfWpOR8IBEif1U559MXvVwuby
	cyYHD8VwzTe6JJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3853137BA;
	Mon, 12 Aug 2024 11:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id clhSN3/yuWZJVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 11:31:11 +0000
Date: Mon, 12 Aug 2024 13:31:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, kees@kernel.org,
	gustavoars@kernel.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
Message-ID: <20240812113102.GG25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812103619.2720-2-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1165920268
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 12:36:20PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: David Sterba <dsterba@suse.com>

