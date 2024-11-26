Return-Path: <linux-btrfs+bounces-9921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B39D9D0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC162855CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB711DC184;
	Tue, 26 Nov 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0EnaJ/Bg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vsvx5TLK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ftX/oI5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gx5CpAap"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E131DDA36
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644053; cv=none; b=jVu4AOzGV/ER4xBYdBB5OLouPnDwlj0Debd3jjZIsFGnUVkz1bUioKs9x2WYYS9+XWKuUFpxS6Ww/sWtTqfiMK/rQQpshw1nLgr4yjPYKBtAgm2dQjuStu4GG50i9BT+CwfsrtcLFICGYwzE6p7UVUnXYB/i72qEPjjqqdykzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644053; c=relaxed/simple;
	bh=5DOd3fz+ItUnWo4UL9M3pDzTO4yjHJ9URWN3IH1LZDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNXpqVb6el84rgSGcphxQ+wVcFdrip33ceFg+ZTMeSJ47o2QonT46JWZbgHgZE0kL30bIEFHdHNpg5M2m0jn4zi4euFcPYyyg+YLzdmUBJUe5Ks0sHsxyBgVTh5Q+a7E32ggLx28bGDOaOtB7JN2gt+WN0E/akglpnxGoPYDqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0EnaJ/Bg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vsvx5TLK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ftX/oI5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gx5CpAap; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC9E32117E;
	Tue, 26 Nov 2024 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732644048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruXQ2Na7A/oOXHI5y0cpOcwK98C7iM2gKujsI1amRRw=;
	b=0EnaJ/BglQPO0Bj17pNGcgP90+AFUPHl+24WI6+5J42khLTWc88jJlJZfLCu0ZSdL/TiXu
	qfl7af5J8ie0I3ZIy4S9PYYes8xXhfuYcMaRPb9nIufhSbrFNWVK1z6oDaKCGOrVCipzT6
	d6f36uyI4/EjVPKBxiBuAhZ15QkchPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732644048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruXQ2Na7A/oOXHI5y0cpOcwK98C7iM2gKujsI1amRRw=;
	b=Vsvx5TLKz45EnZFUkng7wklBD8hBnV6yH7krVC7u6aobGQWt2SaFP1/fm0ZPTlnGK0vG3s
	/sTIQyqRRDP5RdBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ftX/oI5T";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gx5CpAap
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732644047;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruXQ2Na7A/oOXHI5y0cpOcwK98C7iM2gKujsI1amRRw=;
	b=ftX/oI5TertVglrs0NHaJnOz12JI4+9k396p19PrZLAmZGBb64MCN2xif8hTBCa9xJEb6n
	wuZkrZqALTl8lgMsECDo+le/0L+7TE4kkguOIIOzkWT0U7rkBiOyqD9aGd5xezjx76Yd5L
	59on30Lv4MuoTAsTw7GvApTWjfGDn2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732644047;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruXQ2Na7A/oOXHI5y0cpOcwK98C7iM2gKujsI1amRRw=;
	b=gx5CpAapsn95yEz7nREq1cQ9ZwR5bNxpaGzVRqSwt8g5MjjJFkqMtJjXEBsMFvQn3Icedz
	RJMFumuv8mvrAzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2680139AA;
	Tue, 26 Nov 2024 18:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tc5FK88MRmcTQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 18:00:47 +0000
Date: Tue, 26 Nov 2024 19:00:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: fix lockdep warnings on io_uring encoded reads
Message-ID: <20241126180046.GM31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241115154925.1175086-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115154925.1175086-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CC9E32117E
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
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 15, 2024 at 03:49:17PM +0000, Mark Harmstone wrote:
> Lockdep doesn't like the fact that btrfs_uring_read_extent() returns to
> userspace still holding the inode lock, even though we release it once
> the I/O finishes. Add calls to rwsem_release() and rwsem_acquire_read() to
> work round this.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to for-next, thanks.

