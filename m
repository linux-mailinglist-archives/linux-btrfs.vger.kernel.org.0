Return-Path: <linux-btrfs+bounces-15123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0106AEE56A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 19:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5EE189DC5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1A292B35;
	Mon, 30 Jun 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DTYWWgSE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Qz03taL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGbURAl8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQ1Z8hXL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C32571C7
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303540; cv=none; b=EQJBK3beJSc/hJMg3qOSu4Y1LU9rrNDqbcceLIP3WjinKPtCdoang2T4818IZWsZoUxwIuQ5McsZ3M33Uhms/bSKXCHTEK7qLiORy3tcAddloj1eB2GjfRbxUfQhGJst5+Dx02GLRfCMSNQicPdkuKr2VlAWggmngwUqojA/JH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303540; c=relaxed/simple;
	bh=V/yrc3Ovse+doHj8Nnk4f5pSfrsLWoPuHioUhJesyas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRAriqRqNNujleFcANA4fJ0tmB53qM+aZ2RReqgnM+SU8R4wod6FA+InBar+R1dcDG8hkCcxSiIGXqLF4+x6QJ3mXax/qmcCWg7VLIYxoxXA/yp8JHlEiDSoBBteBgkvuE1KRsxtirjBr+cF1gBA/TWVfMGEgkcAF3Nmze0Vb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DTYWWgSE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Qz03taL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGbURAl8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQ1Z8hXL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D67361F397;
	Mon, 30 Jun 2025 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751303536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXwAyLjSvQj6q9kLMPp0LwIhonBXEZ8CZ5aH/4hQn7I=;
	b=DTYWWgSEh7hTk8bWH+2T2fetKOtaGTuM5EZiOTWab1buNOWv2BOkNtGUjPDVmeqkIjb120
	jSqkohMVLqYnp01hn2J0Qjyda7F6VI4MPNAt0zSlzkjZA9O8d3b5sLAlXmXE001HNB1Pz0
	yIjVA/OgRcnWBA4gIKMG2HF/hrIcJpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751303536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXwAyLjSvQj6q9kLMPp0LwIhonBXEZ8CZ5aH/4hQn7I=;
	b=2Qz03taLRyP5hHggFlsn8915qV/GY8iM1lvjfi0/YY1yI0UoCX1yB2lPiaA8c2Q8QOD0tJ
	nOX717KiZz+hMyDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aGbURAl8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KQ1Z8hXL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751303535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXwAyLjSvQj6q9kLMPp0LwIhonBXEZ8CZ5aH/4hQn7I=;
	b=aGbURAl8xDgl6CBZJvabQZGjfqLGqR3XBNsqtSVy/u+pAkJRfpvQQ0iUpBpUgZxov1/+hB
	ek4ilcjM94PunF+EBdaWrMXtFhpRJLdYPvVw63SOxFkjeVrvTgtmUZ4eRquPpi2oLVNpnO
	VVupRhLzfhwkiZ7Dt8cdrAxE8TtJWEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751303535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXwAyLjSvQj6q9kLMPp0LwIhonBXEZ8CZ5aH/4hQn7I=;
	b=KQ1Z8hXLAwhvvK5QV+LQ1Y0ggL15UdSe3XDaKW/ZaEaPjExdaMp1Ie5qjeOUaQGTdl1Y7B
	IbxzSFh45E9+wZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA19113983;
	Mon, 30 Jun 2025 17:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zIDiLG/FYmgrJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 17:12:15 +0000
Date: Mon, 30 Jun 2025 19:12:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC 8/9] btrfs: lower log level of relocation messages
Message-ID: <20250630171214.GO31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-9-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627091914.100715-9-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D67361F397
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Jun 27, 2025 at 11:19:13AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When running a system with automatic reclaim/balancing enabled, there are
> lots of info level messages like the following in the kernel log:
> 
>  BTRFS info (device nvme2n1): relocating block group 629212708864 flags data
>  BTRFS info (device nvme2n1): found 510 extents, stage: move data extents
> 
> Lower the log level to debug for these messages.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I kind of like that the message is in the system log on the info level,
it's a high level operation and tracks the progress. Also it's been
there forever and I don't think I'm the only one used to seeing it
there. We have many info messages and vague guidelines when to use it,
but I think "once per block group" is still within the intentions.

