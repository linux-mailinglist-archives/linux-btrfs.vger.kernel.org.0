Return-Path: <linux-btrfs+bounces-1311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CC827744
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 19:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D427CB218AD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373454F80;
	Mon,  8 Jan 2024 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvBWQGHP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbP3asw3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvBWQGHP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbP3asw3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBD54BF2
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B8EE21D2C;
	Mon,  8 Jan 2024 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704737917;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s62iahv+7bzsSI5xTm7RH7VpvIIkxnJBC0hXPj8c8DM=;
	b=vvBWQGHPFL2NJ07OideCP0IHya+hpeXMxGs6TMDQbMJnInNtPgnZK4FOT5KQ4hgiCJDKkG
	D2lA52YbrPgopFtbu068TGNt3WPVOaS8pIZixaGqCn6ntKfhvR+G7tm9e/eOQTVHAgEwQa
	KIXR0mirwHycw8tX8Q5/Odkog86QqBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704737917;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s62iahv+7bzsSI5xTm7RH7VpvIIkxnJBC0hXPj8c8DM=;
	b=RbP3asw3fOoAGdyR9foiCFY64L8zneJcwcEpR/kZheD3vpM0OuRwwtnFBMp30ZWbeUXNyi
	S1HucGqfwm8thSDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704737917;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s62iahv+7bzsSI5xTm7RH7VpvIIkxnJBC0hXPj8c8DM=;
	b=vvBWQGHPFL2NJ07OideCP0IHya+hpeXMxGs6TMDQbMJnInNtPgnZK4FOT5KQ4hgiCJDKkG
	D2lA52YbrPgopFtbu068TGNt3WPVOaS8pIZixaGqCn6ntKfhvR+G7tm9e/eOQTVHAgEwQa
	KIXR0mirwHycw8tX8Q5/Odkog86QqBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704737917;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s62iahv+7bzsSI5xTm7RH7VpvIIkxnJBC0hXPj8c8DM=;
	b=RbP3asw3fOoAGdyR9foiCFY64L8zneJcwcEpR/kZheD3vpM0OuRwwtnFBMp30ZWbeUXNyi
	S1HucGqfwm8thSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47DAE13686;
	Mon,  8 Jan 2024 18:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UUU1D308nGU6XwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 18:18:37 +0000
Date: Mon, 8 Jan 2024 19:18:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused variable bio_offset from
 end_bbio_data_read()
Message-ID: <20240108181823.GE28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <69c652507c19ec6bff940dc1da1fe2b847cf9d24.1704679242.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c652507c19ec6bff940dc1da1fe2b847cf9d24.1704679242.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vvBWQGHP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RbP3asw3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.67%]
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: 8B8EE21D2C
X-Spam-Flag: NO

On Mon, Jan 08, 2024 at 12:30:44PM +1030, Qu Wenruo wrote:
> The variable @bio_offset is introduced in commit 7ffd27e378d2 ("btrfs:
> pass bio_offset to check_data_csum() directly"), when we are still using
> the same endio function for both data and metadata.
> 
> Later we have several changes to data and metadata endio functions:
> 
> - Data verification is handled by btrfs bio layer
> 
> - Split data and metadata endio paths
> 
> Now for data path we no longer do any verification in
> end_bbio_data_read(), as the verification is handled by btrfs bio layer
> already.
> 
> Thus there is no need for such bio_offset variable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

