Return-Path: <linux-btrfs+bounces-9973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE09DEB42
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E02E1629C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDC154BE0;
	Fri, 29 Nov 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKN203KW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ulnVcy+h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKN203KW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ulnVcy+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D515AF6
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898741; cv=none; b=Z2OiSydF6Dwb0xKSI9Ns9YlavqXnSF0PU2hYHrK+OBQiT/mO4YzbRwxGVaXPSOUUxnGDPKdcEtP8HqNFTbr/m5gbaAT+GjVsynSbc0fn0yzHJEsqJFbrXJZlGgcRiHBjhdZorpig150Naiyyu5T9ay26sUJ6PY2G9zOyezsU9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898741; c=relaxed/simple;
	bh=qF5eSIp/eifIaKPufgYEpmThDCu2v07JU+mJkbyKEbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpqKFzl5UawmBa0j3e+BY1Y0UFWvIdK6iMzPBHdzdDReZYBoE3TKzU5874Ij5oH4gnHo3mTMGpgiI95ONmrEsSnVYC2QmvzqVuJzX52yeo6cisRsWu3vCg46vqfzoEERi7lwnQLF3T9wgclu8/YwJjohsjc1L44Xvq6rpGifttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKN203KW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ulnVcy+h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKN203KW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ulnVcy+h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 441B11F390;
	Fri, 29 Nov 2024 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732898738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hh1Jg47frSSuCArr5TMmsiQhoNqBmW8H/y3fWylCGg=;
	b=RKN203KWQw0RJ5hiZ3Zo6hdIsTeiP9ST42CzkTxYBjALQXqdB6LqUObmvG4PMmvLXJZXXU
	bbAmS3ZeEMnWC9DkCg67izD7dTb1Pz0QtmRkZGrsr6oPQMsxYuaDeaakiQjI9B3kG9UakD
	AYPvvF87nIuXoEZExuwjti/Eo93J8zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732898738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hh1Jg47frSSuCArr5TMmsiQhoNqBmW8H/y3fWylCGg=;
	b=ulnVcy+hUsQot9vyJGQUoikQTFzcwVcY7/jk4az1V3fzLDGLiSXBbWv5tScwgw1bU10Lu0
	W/alQ3n6EoZhLCDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732898738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hh1Jg47frSSuCArr5TMmsiQhoNqBmW8H/y3fWylCGg=;
	b=RKN203KWQw0RJ5hiZ3Zo6hdIsTeiP9ST42CzkTxYBjALQXqdB6LqUObmvG4PMmvLXJZXXU
	bbAmS3ZeEMnWC9DkCg67izD7dTb1Pz0QtmRkZGrsr6oPQMsxYuaDeaakiQjI9B3kG9UakD
	AYPvvF87nIuXoEZExuwjti/Eo93J8zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732898738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hh1Jg47frSSuCArr5TMmsiQhoNqBmW8H/y3fWylCGg=;
	b=ulnVcy+hUsQot9vyJGQUoikQTFzcwVcY7/jk4az1V3fzLDGLiSXBbWv5tScwgw1bU10Lu0
	W/alQ3n6EoZhLCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28942139AA;
	Fri, 29 Nov 2024 16:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +N5kCbLvSWfPXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Nov 2024 16:45:38 +0000
Date: Fri, 29 Nov 2024 17:45:32 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix missing snapshot drew unlock when root is
 dead during swap activation
Message-ID: <20241129164532.GZ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ef43063706a4ef1a4313ba03ca6225e7d7dbac.1732887615.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 29, 2024 at 01:41:37PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When activating a swap file we acquire the root's snapshot drew lock and
> then check if the root is dead, failing and returning with -EPERM if it's
> dead but without unlocking the root's snapshot lock. Fix this by adding
> the missing unlock.
> 
> Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being deleted")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

