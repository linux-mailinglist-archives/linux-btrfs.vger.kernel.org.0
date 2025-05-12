Return-Path: <linux-btrfs+bounces-13897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D39AB3EF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C0986443B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC743296D1E;
	Mon, 12 May 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFFb3wwv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5a0sZsrM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFFb3wwv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5a0sZsrM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68C248F49
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070726; cv=none; b=h0iKKJOoOcvCpMeZZb/K+CAkhifi9k2nf1QMd3rWtgMKuOlsxW6Zj7YbPgSngiwN7Uk62Fpvp/goSLhiy3Ld2keManYkzJ0Hl6jPp1RyVNUdWxHQQw4vOaISZMOpV89d6EmDNtOwl3LTtRgWz5FgvOpNpQXUT2cqhXRFIKeh3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070726; c=relaxed/simple;
	bh=DVMUH3b2lDEVvr2TrhZfEj1GoJIwWbD8FkxYeeI3mhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urubnENjpZxmiQJgf1bCX+JaAjkzBa53dAUEsweb6J6zCZYpRmthcbiLHhMO5mxPzWX9oVswY0B47DKNu22u8O8t3upB2VAYvVSxwv5Eh1Z/wRmwOa7KR5jyRdTgCcVViyEBLDm+8PtDHoU9GFvxlx8I02rklmtHzDJ94V9/ARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFFb3wwv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5a0sZsrM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFFb3wwv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5a0sZsrM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BA711F387;
	Mon, 12 May 2025 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1yha5UTm3u/DxPPKoi9V3lqe4tMZTkm32EUVx6Hk+A=;
	b=VFFb3wwvf85IquPSrPDJ9Y4LZ44Mu3BEB6iXIbF9maYznHvxzDQ8uYeDk7GVziqDo2DYgI
	GbNbM2zzxj7Ip5vrozk8tCiL2uKFLqpEKBsTMg8cZxhqe6NslrGIbaMbo18H2Urboy82Ok
	xjOoWixFXLRAmKJnK3LZ0SH79Xj7WY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1yha5UTm3u/DxPPKoi9V3lqe4tMZTkm32EUVx6Hk+A=;
	b=5a0sZsrMds90GeujlErhqD3PHqbFw+k62B2xaBbpeIO5A1VfoP2re9jsPagr9BQFCooJy2
	uLrjZp71nYpyPeBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VFFb3wwv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5a0sZsrM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1yha5UTm3u/DxPPKoi9V3lqe4tMZTkm32EUVx6Hk+A=;
	b=VFFb3wwvf85IquPSrPDJ9Y4LZ44Mu3BEB6iXIbF9maYznHvxzDQ8uYeDk7GVziqDo2DYgI
	GbNbM2zzxj7Ip5vrozk8tCiL2uKFLqpEKBsTMg8cZxhqe6NslrGIbaMbo18H2Urboy82Ok
	xjOoWixFXLRAmKJnK3LZ0SH79Xj7WY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1yha5UTm3u/DxPPKoi9V3lqe4tMZTkm32EUVx6Hk+A=;
	b=5a0sZsrMds90GeujlErhqD3PHqbFw+k62B2xaBbpeIO5A1VfoP2re9jsPagr9BQFCooJy2
	uLrjZp71nYpyPeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D927137D2;
	Mon, 12 May 2025 17:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jZeHGgIvImhocwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:25:22 +0000
Date: Mon, 12 May 2025 19:25:21 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: return real error from __filemap_get_folio() calls
Message-ID: <20250512172521.GR9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bd0068a988e80be345b7a513df5448ee9da4a0d7.1747035899.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0068a988e80be345b7a513df5448ee9da4a0d7.1747035899.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7BA711F387
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On Mon, May 12, 2025 at 08:47:26AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a few places that always assume a -ENOMEM error happened in case a
> call to __filemap_get_folio() returns an error, which is just too much of
> an assumption and even if it would be the case at some point in time, it's
> not future proof and there's nothing in the documentation that guarantees
> that only ERR_PTR(-ENOMEM) can be returned with the flags we are passing
> to it.
> 
> So use the exact error returned by __filemap_get_folio() instead.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

