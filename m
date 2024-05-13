Return-Path: <linux-btrfs+bounces-4940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AD8C46CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A450A1C22564
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A083D994;
	Mon, 13 May 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMg7+jTP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kAVRcofZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMg7+jTP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kAVRcofZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3B3BBC9
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715624954; cv=none; b=dVt/7A5ovor+A7uxQj2uyMQx/Jb0aaQ6Ghs49CQ35RlB8deUQUfYE6KdhC3nlbwTn6jufIaK56fVXP6/jS+VAwOAiYrqdE0UDcMMC3R9PWzc89l3e2uYqNxhRKUjIb+aQwHboziQVntwfrndzIwC3vW6a34LryYC07jDT/buvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715624954; c=relaxed/simple;
	bh=uA/YfpiCfEVziSFGqRLqqJRuPYGN22gWV3l3U+R4FVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8TGtD6QeWG4arqVMZQdv0JYJMqkpGPHRRy3qPw3RReZEPPMWn+yl7CCGjMm+JtSvvkhWkS83uWEtdTfl1c9HpAbYv/ZnmjRzzJTpbcunrRQH1tcF2oB0npkf/T0czKU2+abW85ymBW32cpW9mkvuRLsp2+UVBsfCwjzIXpMxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMg7+jTP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kAVRcofZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMg7+jTP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kAVRcofZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09A755CACD;
	Mon, 13 May 2024 18:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715624951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfzrD8swqW/ergU+DFbmLAmcCyxjNdLINrWUuu95K5c=;
	b=iMg7+jTPTj0P+gMe0bM3ZOBPSAADB7esJ+hk7H40q9J0x0u+6hcmwYP8rhQaZdGh1Af0q0
	67y0o1DYKlPBdpaOp+EDYwXmGEOy1LWeZhfVCahy5AVmrt1rwwBr95meEkdYmhlU9jXLKu
	0fxBfwbekC5+CYeeETBsiNHaXBqRDGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715624951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfzrD8swqW/ergU+DFbmLAmcCyxjNdLINrWUuu95K5c=;
	b=kAVRcofZWXy9v83qf6umcPvQNQt03Ha+L47yQlC3Twe/h9vy3vQEnRUVtPF8LSBHLQlNNG
	z3UyPPrzfFT9D4DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715624951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfzrD8swqW/ergU+DFbmLAmcCyxjNdLINrWUuu95K5c=;
	b=iMg7+jTPTj0P+gMe0bM3ZOBPSAADB7esJ+hk7H40q9J0x0u+6hcmwYP8rhQaZdGh1Af0q0
	67y0o1DYKlPBdpaOp+EDYwXmGEOy1LWeZhfVCahy5AVmrt1rwwBr95meEkdYmhlU9jXLKu
	0fxBfwbekC5+CYeeETBsiNHaXBqRDGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715624951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfzrD8swqW/ergU+DFbmLAmcCyxjNdLINrWUuu95K5c=;
	b=kAVRcofZWXy9v83qf6umcPvQNQt03Ha+L47yQlC3Twe/h9vy3vQEnRUVtPF8LSBHLQlNNG
	z3UyPPrzfFT9D4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1E711372E;
	Mon, 13 May 2024 18:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xzTpOvZbQmbdBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 13 May 2024 18:29:10 +0000
Date: Mon, 13 May 2024 20:21:50 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix misspelled end IO compression callbacks
Message-ID: <20240513182150.GB4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4a9ef85f3ad20b4a423a695dc90c9fb028135faf.1715620538.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9ef85f3ad20b4a423a695dc90c9fb028135faf.1715620538.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Mon, May 13, 2024 at 06:16:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix typo in the end IO compression callbacks, from "comprssed" to
> "compression".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

