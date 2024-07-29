Return-Path: <linux-btrfs+bounces-6851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01693FF90
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620991C222A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C63187857;
	Mon, 29 Jul 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OdoirnpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuDedjO3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OdoirnpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuDedjO3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0512E1CA
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285167; cv=none; b=AojixwAyBQWF0BonD7ZJ0I2dCqWi+XykY4gTJKtHRv+FEdn5uLQXMwL3BzdAxBSQBANgNLH7p4O0ehxdFHZT9CA1+TFR4z29EPTWYU/Gt9p0KH9IOkcp/O3edFXNtr+sxqa3yqKm9W0ku1rKGWplaMeId2TiAA6RI7p5fVgua50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285167; c=relaxed/simple;
	bh=j0YLnSB8lUGDsdlYu3CO/1n6WiKHuvLV3rz3tAQUUqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJawSYYbjp7+oi57ULaZI8q4miQpxWbIovWVnsN6lBM+oXEv9vYqd/Ieb3cIwy+LVGDIlMyS5XFdx7JziBagvMybIHO4Qk7tI32rgXUPABmqA6h5IESPXZ5P3LwryieseDkDpM3nih5Pn/WHpD01Mq9fjn8VkDk95GYEZtEATas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OdoirnpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuDedjO3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OdoirnpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuDedjO3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 644D71F897;
	Mon, 29 Jul 2024 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722285163;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4ILJSgaYbmwopfXpALmeZi6U+Bh7sCvr049Pnn5n3c=;
	b=OdoirnpLfgdvVac7UROP7wv9qod5ADO+yxCOMoah4H5D+9m9xBEKuozRPJsW4P20adogWI
	As0ZkwIpQGT/2//qACLV5WlGrUS8e/U1+O8Ge3UPxwh5nyNx9cy2RNMbWdH3Xt8k9gqFzr
	SX2Iy22upJ5VSYXsYoKviCR3s52PNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722285163;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4ILJSgaYbmwopfXpALmeZi6U+Bh7sCvr049Pnn5n3c=;
	b=uuDedjO3a1I4zJVGi9EZ49EyFdw1Ni1mriw6L4vdnxbDpnY6oJx0xYSlfsDRHVdFNyG5Ya
	ijbUatBTQ0wvq2Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OdoirnpL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uuDedjO3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722285163;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4ILJSgaYbmwopfXpALmeZi6U+Bh7sCvr049Pnn5n3c=;
	b=OdoirnpLfgdvVac7UROP7wv9qod5ADO+yxCOMoah4H5D+9m9xBEKuozRPJsW4P20adogWI
	As0ZkwIpQGT/2//qACLV5WlGrUS8e/U1+O8Ge3UPxwh5nyNx9cy2RNMbWdH3Xt8k9gqFzr
	SX2Iy22upJ5VSYXsYoKviCR3s52PNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722285163;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4ILJSgaYbmwopfXpALmeZi6U+Bh7sCvr049Pnn5n3c=;
	b=uuDedjO3a1I4zJVGi9EZ49EyFdw1Ni1mriw6L4vdnxbDpnY6oJx0xYSlfsDRHVdFNyG5Ya
	ijbUatBTQ0wvq2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44C3F1368A;
	Mon, 29 Jul 2024 20:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hKySEGv8p2YuTAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 20:32:43 +0000
Date: Mon, 29 Jul 2024 22:32:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/46] btrfs: convert most of the data path to use folios
Message-ID: <20240729203238.GS17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 644D71F897
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]

On Fri, Jul 26, 2024 at 03:35:47PM -0400, Josef Bacik wrote:
> Hello,
> 
> Willy indicated that he wants to get rid of page->index in the next merge
> window, so I went to look at what that would entail for btrfs, and I got a
> little carried away.
> 
> This patch series does in fact accomplish that, but it takes almost the entirety
> of the data write path and makes it work with only folios.  I was going to
> convert everything, but there's some weird gaps that need to be handled in their
> own chunk.
> 
> 1. Scrub.  We're still passing around page pointers.  Not a huge deal, it was
>    just another 10ish patches just for that work, so I decided against it.
> 
> 2. Buffered writes.  Again, I did most of this work and it wasn't bad, but then
>    I realized that the free space cache uses some of this code, and I really
>    don't want to convert that code, I want to delete it, so I'll do that first.
> 
> 3. Metadata.  Qu has been doing this consistently and I didn't want to get in
>    the way of his work so I just left most of that.
> 
> This has run through the CI and didn't cause any issues.  I've made everything
> as easy to review as possible and as small as possible.  My eyes started to
> glaze over a little bit with the changelogs, so let me know if there's anything
> you want changed.  Thanks,

I did two passes, most of the conversions are straightforward, the API
changes seem OK. There are some local variable referring to page, like
page_start but initialized from folios. Not a big problem for now, we'll
keep removing references to pages, this can be done later.

Reviewed-by: David Sterba <dsterba@suse.com>

