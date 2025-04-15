Return-Path: <linux-btrfs+bounces-13044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D68A8A62B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5428189CEFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E8224224;
	Tue, 15 Apr 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WxCBuKky";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZSy6xsL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WxCBuKky";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZSy6xsL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA7221D82
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739867; cv=none; b=HwHHO4KuKy6uTOUx+jdXEV8qCqSt9QJCfzz5qde3sFAOAhyHtUGVvNxRwlnkPwM4Ectn0xdSQT/epBlURsAMfCMqpHiQyquD4arPtnts8tUw3VDvlZXqVoYeIYHz82tnVVihhoJMdcExNHfGxG4MUB1SdFnIIOb/xvM+2+nTIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739867; c=relaxed/simple;
	bh=8k5nnCyjBOPXgC1yMZROWiz9WN77XzffTzHWi+0+CTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTNzOKvQY+iESJDF6KoJCWgv2rS8aZOiJixbDLS099NgMI5qkw/qVHc3+wfmJt+5YbP93F0bQI/gboWVQHQWhlcSqTaXo6BNutRzrR8V1XPikGAYXOpfD0EomfKIiQOQJrRqSgVMvdYvPPGMrZk+gFXY6P9lRkIBa2vsNvv45Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WxCBuKky; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nZSy6xsL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WxCBuKky; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nZSy6xsL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BF01210F2;
	Tue, 15 Apr 2025 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744739863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJiZc4e+Qu9WUTWSFOJjDc5ZlZEIcijcedgOYaR2cqA=;
	b=WxCBuKkyk95SBqEv4oMwfi3XcWopIhvSTiy3gasDL5/bhq/ma2VlA9eMjVrKjbJtrsQIhL
	QRrqf6TN+v4YIVS1D/EpEYgMbcgmZgWdJsI/jY7NjO8eEwloi28fllhOTrQJ8G/Ven//GK
	2NDuS8yttAKLNntQAB7fRhiSOABBMio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744739863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJiZc4e+Qu9WUTWSFOJjDc5ZlZEIcijcedgOYaR2cqA=;
	b=nZSy6xsL1UYAaf2NscULGqF0gKJnPehHamo+B5mExRxdbXRYL7gc/NQ0xm76l7Lp1NrC7M
	+ZtZGWnQygTiG+DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WxCBuKky;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nZSy6xsL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744739863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJiZc4e+Qu9WUTWSFOJjDc5ZlZEIcijcedgOYaR2cqA=;
	b=WxCBuKkyk95SBqEv4oMwfi3XcWopIhvSTiy3gasDL5/bhq/ma2VlA9eMjVrKjbJtrsQIhL
	QRrqf6TN+v4YIVS1D/EpEYgMbcgmZgWdJsI/jY7NjO8eEwloi28fllhOTrQJ8G/Ven//GK
	2NDuS8yttAKLNntQAB7fRhiSOABBMio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744739863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJiZc4e+Qu9WUTWSFOJjDc5ZlZEIcijcedgOYaR2cqA=;
	b=nZSy6xsL1UYAaf2NscULGqF0gKJnPehHamo+B5mExRxdbXRYL7gc/NQ0xm76l7Lp1NrC7M
	+ZtZGWnQygTiG+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663F6137A5;
	Tue, 15 Apr 2025 17:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r2fHGBee/meMewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 17:57:43 +0000
Date: Tue, 15 Apr 2025 19:57:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify return logic from
 btrfs_delayed_ref_init()
Message-ID: <20250415175734.GL16750@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250414125231.740999-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414125231.740999-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7BF01210F2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Apr 14, 2025 at 06:52:31AM -0600, Yangtao Li wrote:
> Make this simpler by returning directly.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Added to for-next, thanks.

