Return-Path: <linux-btrfs+bounces-6190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0B926CBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 02:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14221C21C27
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 00:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451AB4C70;
	Thu,  4 Jul 2024 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwM58/I5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NScBxf6B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwM58/I5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NScBxf6B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1F23BB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052582; cv=none; b=CrnhT1uuI0lOtAkgEOBb3gO2T0Oce4EbB82juq0djnwyB1Ykz4ODhYR6tjqFo+zIC4eyxHFmh287sOTeSwq9LO5szfy+t1gSFE+lcYyMZgGKWeDclTxUdtjzD0JWE93Ms49SNWDBL2fxfQKFcWgfe3mh6IBm6UBmEq0jhnsm498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052582; c=relaxed/simple;
	bh=YmjXHHLa+rovXvHLIKiVwj+aigu9g5jKSIDRom9cjQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpSscoBzV1xeZA8XtAGiPe6WM4dh3remXnefFmk7WLG5NjHRTNlIunnelgJjeYN/ILJKPPpMzQ3Xavg4JqIFBgm/yKGVHc7784PSvi66Qe1Cy/TVTPSJG4nBWs9jDA+TwnOLSoDRGAPebfxWiXJIkWM+QwWmx7jXz9NCU+V7b+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwM58/I5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NScBxf6B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwM58/I5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NScBxf6B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B344D1F790;
	Thu,  4 Jul 2024 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720052578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7hy7u9lbaNbBldUV/7z86QZBQzV7oAskzMt2h34QSM=;
	b=wwM58/I5mLsK4zW7BGfDr33bNVGeYqeAwWMobWLSM/kahqy/sY3xhJfUeGypSr11hd1/q7
	JqFjBdjMN0PHxPTHekN7lsjvNXRGwUzxPwPqTxsQDfDCDe/cuBXr4UVJGYktv+V/luEmkA
	iV9XOQWMFxff+X2z1VrWs2hFFrC9zeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720052578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7hy7u9lbaNbBldUV/7z86QZBQzV7oAskzMt2h34QSM=;
	b=NScBxf6BjArP3j5AfdRp2xIxY+XnH3QDDnuy7AkoVZc6ilxybNyGpVQpiknlnGIzWldOW6
	VOAjhtMwNsKZWFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720052578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7hy7u9lbaNbBldUV/7z86QZBQzV7oAskzMt2h34QSM=;
	b=wwM58/I5mLsK4zW7BGfDr33bNVGeYqeAwWMobWLSM/kahqy/sY3xhJfUeGypSr11hd1/q7
	JqFjBdjMN0PHxPTHekN7lsjvNXRGwUzxPwPqTxsQDfDCDe/cuBXr4UVJGYktv+V/luEmkA
	iV9XOQWMFxff+X2z1VrWs2hFFrC9zeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720052578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7hy7u9lbaNbBldUV/7z86QZBQzV7oAskzMt2h34QSM=;
	b=NScBxf6BjArP3j5AfdRp2xIxY+XnH3QDDnuy7AkoVZc6ilxybNyGpVQpiknlnGIzWldOW6
	VOAjhtMwNsKZWFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96A1513889;
	Thu,  4 Jul 2024 00:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /aeGJGLrhWatVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jul 2024 00:22:58 +0000
Date: Thu, 4 Jul 2024 02:22:53 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Li Zhang <zhanglikernel@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-prog: scrub: print message when scrubbing a
 read-only filesystem without r option
Message-ID: <20240704002253.GW21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
 <af92c238-a5d0-4023-8001-042f17085198@gmx.com>
 <20240704001309.GV21023@twin.jikos.cz>
 <d7e06214-0166-4db2-836c-36b2abde054b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e06214-0166-4db2-836c-36b2abde054b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jul 04, 2024 at 09:49:52AM +0930, Qu Wenruo wrote:
> E.g, setmntent() and getmntent() used inside check_mounted_where()?
> 
> Since mntent structure provides mnt_opts, it should not be that hard to
> find if the destination mount point is mounted ro?

Oh right, it's in getmntent. I was looking there but expected a bit
mask, the options are strings and the convenience helper for checking if
they're set is hasmntopt().

