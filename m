Return-Path: <linux-btrfs+bounces-5672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43B905C48
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E720287374
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1884A2B;
	Wed, 12 Jun 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aEWAoHno";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9iSVxvA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aEWAoHno";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9iSVxvA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0D84A32
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221693; cv=none; b=I/EnCzhpnaXj5tw2Mhr5QCioRtDsn3q7a5gdXEtZQrsi6T48z5WjkGDhUvYnl2NqtYgxTveGMhEybr+S/6LmpcMBh4MR0xYxqbJNYv/3klGkyg1U4AiC8VaVOlQ6RwIH8gO/f7ft6xyoTYc1PWQMYgAUcEvMXYHPki3WKVZDe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221693; c=relaxed/simple;
	bh=yCmgvrCY+JEzGHJw+K6N142V/H2gEIX1OLUAyyY8vZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm9tGYeA5CBMQoIshJV5aAme2ZMccMNk8CZMun0+G4fTZ8hdzczJfMb+Ui2Acc68yp9VqV4yKTGblVgG43WzN2GaN3avae2mB4rUur0sGzCCBSYaHg8kTDezYB9+CcjfLWtGyLYZ5XUyK8uGp8O7exfzYAw+rcnT6mWpiPRHls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aEWAoHno; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9iSVxvA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aEWAoHno; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9iSVxvA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 531EF34843;
	Wed, 12 Jun 2024 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUkd/++YmDMDozy5Sa21rqby6/p/g2i0qUqFXuTbrBA=;
	b=aEWAoHno5FlDqH56etM3eYJmETnDd8x4OWodvr/g9ba1uJwwfASXYk75dAjGsEHwk8bXg5
	5EctYVVZTawoHXx8L6x3GWz/TizD8L50s4xSS51qZD+CkLubK9CyslBl5g4MSIW6cczTzK
	r7jPW+c+7xlEEwzywWhhMtoO7d/ZmSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUkd/++YmDMDozy5Sa21rqby6/p/g2i0qUqFXuTbrBA=;
	b=i9iSVxvABYPHTAISiWfSHFHGEuGAyxCiui3L4LdRvEnjcWYdRTkgHvEy4nFE5XpSzta6TZ
	gEnpPn2HzOqtpPAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aEWAoHno;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i9iSVxvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUkd/++YmDMDozy5Sa21rqby6/p/g2i0qUqFXuTbrBA=;
	b=aEWAoHno5FlDqH56etM3eYJmETnDd8x4OWodvr/g9ba1uJwwfASXYk75dAjGsEHwk8bXg5
	5EctYVVZTawoHXx8L6x3GWz/TizD8L50s4xSS51qZD+CkLubK9CyslBl5g4MSIW6cczTzK
	r7jPW+c+7xlEEwzywWhhMtoO7d/ZmSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUkd/++YmDMDozy5Sa21rqby6/p/g2i0qUqFXuTbrBA=;
	b=i9iSVxvABYPHTAISiWfSHFHGEuGAyxCiui3L4LdRvEnjcWYdRTkgHvEy4nFE5XpSzta6TZ
	gEnpPn2HzOqtpPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E5FB132FF;
	Wed, 12 Jun 2024 19:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OXOiCnn7aWbEIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:48:09 +0000
Date: Wed, 12 Jun 2024 21:48:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RESEND] Revert "btrfs-progs: convert: add
 raid-stripe-tree to allowed features"
Message-ID: <20240612194803.GM18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <62b84fee8124d455689f8c2ab151eafb136a04d9.1718008470.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b84fee8124d455689f8c2ab151eafb136a04d9.1718008470.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 531EF34843
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jun 10, 2024 at 06:05:10PM +0930, Qu Wenruo wrote:
> This reverts commit 346a3819237b319985ad6042d6302f67b040a803.
> 
> The RST feature (at least for now) is mostly for zoned devices to
> support extra data profiles.
> 
> Thus btrfs-convert is never designed to handle RST, because there is no
> way an ext4/reiserfs can even be created on a zoned device, or it would
> create the correct RST tree root at all
> 
> Revert this unsupported feature to prevent false alerts.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This was included in the btrfs-convert unwritten extent patchset/pull
> request but is not merged.

For the record, RST first use is for zoned device but will allso fix the
raid56 problems once implemented. It can be used independently, I don't
see a reason to remove it's support from convert. Any related test
failures will be fixed separately.

