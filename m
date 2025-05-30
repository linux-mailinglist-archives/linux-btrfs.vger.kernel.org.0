Return-Path: <linux-btrfs+bounces-14313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EFFAC903C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09BA175896
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3A16132F;
	Fri, 30 May 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmmraJgw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6gHar/V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmmraJgw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6gHar/V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085C20326
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611980; cv=none; b=ovNYDL4VJ5B2vwmZ/s+OyQhHgccqUo4P0vh2yeRM9yepK+MqSp58NQelIOrWQv4fPmP1MmOffK89Hz7Nf1jyqDg7CVyfXLhYO5PU7jcnVdaZLff9DNsY1Zbf4qJEBxEbTjJZRXc5QHvha8PiPVQg+pcCfzAoBO9Z10gpWnFsFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611980; c=relaxed/simple;
	bh=nrRSpI3znhXDAEMyqSonaMCwKe44E0Z4SNjZgelr468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2IzThaVRLZWQR/zARxue5tRHdEIVzKLenymaCQ7/pT43h49VQRMr+Ge0k5d/sEBQnStlR8Ceqz18lYMJn2OoqiR8WyHLXz9GwNa8Tw4FW2UddEYtuDhCHIdjdYkELCld2CdS9FNSkh/oWhv1QO9LPzoocXs1ggU2SQgcOhfEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mmmraJgw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6gHar/V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mmmraJgw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6gHar/V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49CFE1F822;
	Fri, 30 May 2025 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748611970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPWi/l0SGv8PPp8c7F+gSe8ZwWbQLl9rCk0KUjTsTKY=;
	b=mmmraJgw8EL/6gYpiHnEYY6Kh84Ria7HDTUtlIKV8BEWFlurBJtLF/PdRoKqoCbodHZ2Lp
	Cwe9nTAoTqkS7P24iR7KsWaYAOwXcyer2CmjiRrn8w5H3goOtB1cufz2dapD/L75YyajVg
	ENgmkpzq8MG7rSmYmGItct8hXd8Nm3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748611970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPWi/l0SGv8PPp8c7F+gSe8ZwWbQLl9rCk0KUjTsTKY=;
	b=D6gHar/V6MeWxPD47D0lKVsNMN6/QlCyyao6h0MeaVtYhvT9Z4xqUmZy9By8Us5k2Wgeaa
	h7c7zFF28hgvYiCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mmmraJgw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="D6gHar/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748611970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPWi/l0SGv8PPp8c7F+gSe8ZwWbQLl9rCk0KUjTsTKY=;
	b=mmmraJgw8EL/6gYpiHnEYY6Kh84Ria7HDTUtlIKV8BEWFlurBJtLF/PdRoKqoCbodHZ2Lp
	Cwe9nTAoTqkS7P24iR7KsWaYAOwXcyer2CmjiRrn8w5H3goOtB1cufz2dapD/L75YyajVg
	ENgmkpzq8MG7rSmYmGItct8hXd8Nm3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748611970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPWi/l0SGv8PPp8c7F+gSe8ZwWbQLl9rCk0KUjTsTKY=;
	b=D6gHar/V6MeWxPD47D0lKVsNMN6/QlCyyao6h0MeaVtYhvT9Z4xqUmZy9By8Us5k2Wgeaa
	h7c7zFF28hgvYiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BEFA13889;
	Fri, 30 May 2025 13:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wahtDoKzOWjmOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 13:32:50 +0000
Date: Fri, 30 May 2025 15:32:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: remove the unused fs_info parameter for
 btrfs_csum_data()
Message-ID: <20250530133248.GX4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748232037.git.wqu@suse.com>
 <c40ac545ab7da66339e9943dbad83409521d2347.1748232037.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40ac545ab7da66339e9943dbad83409521d2347.1748232037.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 49CFE1F822
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, May 26, 2025 at 01:32:35PM +0930, Qu Wenruo wrote:
> The parameter @fs_info is not utilized at all, and there are already
> several call sites passing NULL as @fs_info.
> 
> And there is no counter-part in kernel (we use crypto_shash_* interface
> instead), there is no need to keep the parameter list the same.
> 
> So just remove the unused parameter.

This is a bit unfortunate, I need to fs_info parameter for checksumming
functions for the authenticated hashes, I have a prototype and work on
it in spare time.

I'll probably apply this cleanup as I don't have ETA for the other
patchset and some things are still not finalized. It may be feasible to
pass the key context from the global config and not as parameter.

