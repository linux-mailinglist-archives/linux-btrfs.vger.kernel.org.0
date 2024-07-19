Return-Path: <linux-btrfs+bounces-6600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBFF937866
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B841F22AAC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CC14290E;
	Fri, 19 Jul 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TmDvzfEa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aE90tDUh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TmDvzfEa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aE90tDUh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052A84A28;
	Fri, 19 Jul 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395500; cv=none; b=AQEK6AWabExcaq1WuS4ItCqAKHEagb/T5E4yelif8zSYsbUleWUhCDkx22ikxbMgv7eWsKcd316PdEwNc+cFv0+WIanoU14Z/QmhWmEy1q++LaBo+IEIsp8UK+W1lWZX4Qi/8N0tslepqEFYh4Tj/zct7nkw3KuSfMBq662DeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395500; c=relaxed/simple;
	bh=os56SYySxQsyTsYpwGfViqAk/s/Y090K2t740QaMzPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6PuZS6/iRhhDreZcaAe0L76/0zEBrAMd7tSWdcr50BN2bE2q+ievcOcxZzEndlLletKeriHRyAbz3S2ZGU8mhusIaRXbHc4dkMmZ3t2Du/eoei17eBDb6t9UPNll1CWs+kVaJWfdk7sc26i3o2LHwyNVED+4O0YNK0vkYKpcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TmDvzfEa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aE90tDUh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TmDvzfEa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aE90tDUh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBF721262;
	Fri, 19 Jul 2024 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721395496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOT1jU+rhG7HPwjPdL/URjQ6ObWA2vFSxfE6RPM1NkE=;
	b=TmDvzfEa++xcGMSYw4DoMtYLmJyZg4ti4whoYojWkknnmvO1GttOypUa15fnUbKXtm0fgW
	cjWtbIJPuXQ6b7NCkwCW8MAp3FYz57g+ujuCMhRTrorEDdhsIrSxidosEb18JUmaSnTigy
	8cutnKTMYVhk+AIPhWklgS/13Ww5Azw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721395496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOT1jU+rhG7HPwjPdL/URjQ6ObWA2vFSxfE6RPM1NkE=;
	b=aE90tDUhQDy/8hqeI6qVFHwBdtjYuWe6w/RDc9LeKP/EfnquQmvrS9v0C5w0S/eFSnPIXC
	GN7+3GzdKVo3zuBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TmDvzfEa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aE90tDUh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721395496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOT1jU+rhG7HPwjPdL/URjQ6ObWA2vFSxfE6RPM1NkE=;
	b=TmDvzfEa++xcGMSYw4DoMtYLmJyZg4ti4whoYojWkknnmvO1GttOypUa15fnUbKXtm0fgW
	cjWtbIJPuXQ6b7NCkwCW8MAp3FYz57g+ujuCMhRTrorEDdhsIrSxidosEb18JUmaSnTigy
	8cutnKTMYVhk+AIPhWklgS/13Ww5Azw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721395496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOT1jU+rhG7HPwjPdL/URjQ6ObWA2vFSxfE6RPM1NkE=;
	b=aE90tDUhQDy/8hqeI6qVFHwBdtjYuWe6w/RDc9LeKP/EfnquQmvrS9v0C5w0S/eFSnPIXC
	GN7+3GzdKVo3zuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0FB6136F7;
	Fri, 19 Jul 2024 13:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rGedOidpmmb2DwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Jul 2024 13:24:55 +0000
Date: Fri, 19 Jul 2024 15:24:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	Arnd Bergmann <arnd@arndb.de>, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: change mount_opt to u64
Message-ID: <20240719132454.GL8022@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240719103714.1217249-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719103714.1217249-1-arnd@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 1EBF721262

On Fri, Jul 19, 2024 at 12:37:06PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added BTRFS_MOUNT_IGNORESUPERFLAGS flag does not fit into a 32-bit
> flags word, as shown by this warning on 32-bit architectures:
> 
> fs/btrfs/super.c: In function 'btrfs_check_options':
> fs/btrfs/super.c:666:48: error: conversion from 'enum <anonymous>' to 'long unsigned int' changes value from '4294967296' to '0' [-Werror=overflow]
>   666 |              check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNORESUPERFLAGS, "ignoresuperflags")))
>       |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change all interfaces that deal with mount flags to use a 64-bit type
> on all architectures instead.
> 
> Fixes: 32e6216512b4 ("btrfs: introduce new "rescue=ignoresuperflags" mount option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> Please double-check that I got all the instances. I only looked at where the
> obvious users are, but did not actually try to run this on a 32-bit target

Thanks, the build issue is known and fix will be sent in 2nd pull
reuqest on Monday.

