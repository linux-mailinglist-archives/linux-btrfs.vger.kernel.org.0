Return-Path: <linux-btrfs+bounces-6463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78D931447
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863C5B2180F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109A18C18A;
	Mon, 15 Jul 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBfwpWma";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ej6IAQnc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WAlkXfom";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vd0Ipxlu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FF13BAC2
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046737; cv=none; b=U/zdhUJt0GeFtJldcaCY7L497/pRqJX6LVNpWskGaFoioGXaUlZ5MvI7C26hMBmWHQpHTDFVFVIVK8Z+O+AU/gaTz8XOOA/1cGPmmkw4LIHhbSMPBQW0kwDTG+9oPsZ3NLzSaLXtRon7DVbOvVBk1bkgCRAmjuOgG6qn9cJSrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046737; c=relaxed/simple;
	bh=m+BghZYVzN+hLAe8QY1TWsnk4p5JU6dYaRGOkK/IV9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAlExsUQyLLEjI73JEVBAEjAUKvGiCnl5mwPpwshAiGkISZJTLZQlcEsfwVrlsGwDPYs3BXFJpbHY2xnf01p9A150ugD9yMYjGZmhi0nj93fzm/kFH9EyIXpZEO9+OdkXOWyBH8323nqQUU+Ss5MlESxcAFGcRqXt4nPPQGl5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBfwpWma; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ej6IAQnc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WAlkXfom; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vd0Ipxlu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 228001F818;
	Mon, 15 Jul 2024 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721046733;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Spxdtp6Sx5C/dclRVy8mq/ZW4SB2P5sPNK0fXGmkeI=;
	b=FBfwpWmanf8XxQ767B3Lhsg+rlw9h1WjTyDaGltsN0xB7rKnoqoK4hbFtzCZz16Ek4SPCW
	pSDSahpi7j7zAszJ8twi05j7LOtHlGphLnV5RpnrVE7jk9y2gjy+X0he4U4rzzEfcdjkI4
	nyJelD3MT5bMu+td18Jse322ZLCNA2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721046733;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Spxdtp6Sx5C/dclRVy8mq/ZW4SB2P5sPNK0fXGmkeI=;
	b=ej6IAQncwx7+ERqPK1j08bT5sPk+SvSQ+sG/eA7Y2ISMjeDPyuCbNoo+2KCqctm3nTTlao
	yaPC5JbEMLOWv/Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WAlkXfom;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vd0Ipxlu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721046732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Spxdtp6Sx5C/dclRVy8mq/ZW4SB2P5sPNK0fXGmkeI=;
	b=WAlkXfomnksf9PH8oRapD1XezLsAtj4YIiyg1zcsNN4H1y/QG7T3TmUBk8wEC2rYaej3y+
	2ri3tV5fm9GSkmNJXbWN1FHvAbJG+c1gb7CfMNHUMAtuU8E+Ms7Bm9FG5IoQwbgG4PBb5T
	zy66nBs7BHamQZVGddoE0/o6Li6voDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721046732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Spxdtp6Sx5C/dclRVy8mq/ZW4SB2P5sPNK0fXGmkeI=;
	b=vd0Ipxlu+Icgm/AeWImLHR/z7pS3OjXegg7hBvtELE1pXMmJoob6VhrFccWyeNroWRMUrv
	iXk2cERkd0Ap0mCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0272A1395F;
	Mon, 15 Jul 2024 12:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j1dUAMwWlWbPRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Jul 2024 12:32:12 +0000
Date: Mon, 15 Jul 2024 14:31:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: change BTRFS_MOUNT_* flags to 64bits
Message-ID: <20240715123155.GD8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0955d2c5675a7fe3146292aaa766755f22bcd94b.1720865683.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0955d2c5675a7fe3146292aaa766755f22bcd94b.1720865683.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 228001F818

On Sat, Jul 13, 2024 at 07:45:08PM +0930, Qu Wenruo wrote:
> Currently the BTRFS_MOUNT_* flags is already reaching 32 bits, and with
> the incoming new rescue options, we're going beyond the width of 32
> bits.
> 
> This is going to cause problems as for quite some 32 bit systems,
> 1ULL << 32 would overflow the width of unsigned long.
> 
> Fix the problem by:
> 
> - Migrate all existing BTRFS_MOUNT_* flags to unsigned long long
> - Migrate all mount option related variables to unsigned long long
>   * btrfs_fs_info::mount_opt
>   * btrfs_fs_context::mount_opt
>   * mount_opt parameter of btrfs_check_options()
>   * old_opts parameter of btrfs_remount_begin()
>   * old_opts parameter of btrfs_remount_cleanup()
>   * mount_opt parameter of btrfs_check_mountopts_zoned()
>   * mount_opt and opt parameters of check_ro_option()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> The current patch is still based on the latest for-next branch.
> 
> But during merge time I will move this before the new rescue options.

You konw you can't do that right? The branch for 6.11 can't be changed
anymore and it was late last week already. I've forked the changes at
8e7860543a94784d744c7ce34b7 so far it's still subset of for-next if you
change anything below that then it'll cause merge conflicts or would
need manual resolution in another way. Until rc1 it's probably safest to
just append to our for-next.

