Return-Path: <linux-btrfs+bounces-8953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD499FD1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 02:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40F528463B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2EEC2FB;
	Wed, 16 Oct 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HASqhC7Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExVHI6//";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F91g0TbW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RL0/5TMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316FC8D7
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038478; cv=none; b=rbiNwoJynBJ2rx4GNtolWb8HEWz5Fq0St/OgWcZmS9yah7O2FN40o6IDThrqEOgc8Nocf+v7BtSuxYdTBhc88vMBwEv9ff5Da8TYNMH5KsCaznykudtSNp9eY/7R5R6QTNDf4p9K8/6aKpRCb/zYcg56IeMbLoV+QR4QN1QcOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038478; c=relaxed/simple;
	bh=Vo8N4RIQ3lBUmp4gRgtCbVH97qcBp3a5IvcmO70AUEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbnX6ZpK7xkC+iGMfxc2KcKxeveBRT1/ynT+hgRkM4EHk37oE+Yu/To0RTKrVSGATNr09nkNA04lgZft3SScU/7taj9bySifMH35+UmAng1XbCOOV2Z9oUXvOa9cU1ve25Gp4XK2X4qDI1JJYOkLkNIZxl1rQvqU+kFfoNv70JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HASqhC7Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExVHI6//; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F91g0TbW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RL0/5TMF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED10E1F80D;
	Wed, 16 Oct 2024 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729038474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo8N4RIQ3lBUmp4gRgtCbVH97qcBp3a5IvcmO70AUEw=;
	b=HASqhC7QXDxCd1+hWUngep1Ch7oKP139brGlV0uNCMaC3UHpgV/DpQN91idKoBhZvLa9Wy
	7S5C9rqZiJro3hTUHz+yyL6jUeATttmwIUpsXzvnQTlX2iR6ZS7nTtNGgqKARCKPHaiCha
	uvFyzQavfWjg784xY12bNxUX9M6IrxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729038474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo8N4RIQ3lBUmp4gRgtCbVH97qcBp3a5IvcmO70AUEw=;
	b=ExVHI6//JTYnCh00EK5dDsFomYbdbIcy/LaiPgvV9AAnWI6klxIdvoppQByEtApYRczDwz
	EO7keT3ieMIDl2Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F91g0TbW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="RL0/5TMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729038473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo8N4RIQ3lBUmp4gRgtCbVH97qcBp3a5IvcmO70AUEw=;
	b=F91g0TbWaZO1oubX+CYjRIV4WCQYbBwTPEMarXI+ZjRuftvIFqyf5Vlgn8oN+0atcMjpsx
	5VGxlZnGOfdhjN/fTFNxCmu5mZnmHbTL34GeS6ahmxYesYnF6+N1yLM37rxmj8bnTQ286u
	VIsbsT+y6aZi4jgnshec5nIzwi0qcH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729038473;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo8N4RIQ3lBUmp4gRgtCbVH97qcBp3a5IvcmO70AUEw=;
	b=RL0/5TMFTdZrLT/Gqse706DCVT3vC1d1b2Vke/+ALX/J+J82L3CJEJRFRP56qlrnSlvNOZ
	oFcvS8OZRcKKL8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDF3613433;
	Wed, 16 Oct 2024 00:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ssn2NYkID2f6JwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 00:27:53 +0000
Date: Wed, 16 Oct 2024 02:27:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix wrong sizeof in btrfs_do_encoded_write
Message-ID: <20241016002752.GN1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241015113736.1006573-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015113736.1006573-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: ED10E1F80D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 15, 2024 at 12:37:29PM +0100, Mark Harmstone wrote:
> btrfs_do_encoded_write was converted to use folios in 400b172b8cdc, but
> we're still allocating based on sizeof(struct page *) rather than
> sizeof(struct folio *).

It's wrong that we should use folio, but both are a sizeof of a pointer,
so it's not wrong in the functionality sense.

> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: David Sterba <dsterba@suse.com>

