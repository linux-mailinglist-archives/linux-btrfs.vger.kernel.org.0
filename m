Return-Path: <linux-btrfs+bounces-1415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF282C2DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 16:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AF61F22949
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5076EB71;
	Fri, 12 Jan 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yf1uPjPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfCeot4J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yf1uPjPx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfCeot4J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95132C7F
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7777F1FCDC;
	Fri, 12 Jan 2024 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705073778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj+GGoNWA2ifNR3cRQmJPgffBOH4NuiofaxR/2Po18M=;
	b=Yf1uPjPxaTbwP3hc4rA25zhOOUQo0ollL4v7dRho2XdNIZtxZhDhFcD5zGLSbFA81ZWXw8
	datrjZU7xMxUi/aSmZDxpCh6/ILee8ade39ed1tlQUnsoj1czm7eiwjB0gzY5qCHjEcfIj
	U5+tenLWZdCUID4MsMIE21ewgns4ilw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705073778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj+GGoNWA2ifNR3cRQmJPgffBOH4NuiofaxR/2Po18M=;
	b=vfCeot4Jy/q13hm+hiGhfAAqw0IHnb3R0hC9Wb12ZhMnioBsj1e3TC7v+eeZR/Xk3cgy1i
	1eJmoS3q2HBiyKAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705073778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj+GGoNWA2ifNR3cRQmJPgffBOH4NuiofaxR/2Po18M=;
	b=Yf1uPjPxaTbwP3hc4rA25zhOOUQo0ollL4v7dRho2XdNIZtxZhDhFcD5zGLSbFA81ZWXw8
	datrjZU7xMxUi/aSmZDxpCh6/ILee8ade39ed1tlQUnsoj1czm7eiwjB0gzY5qCHjEcfIj
	U5+tenLWZdCUID4MsMIE21ewgns4ilw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705073778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj+GGoNWA2ifNR3cRQmJPgffBOH4NuiofaxR/2Po18M=;
	b=vfCeot4Jy/q13hm+hiGhfAAqw0IHnb3R0hC9Wb12ZhMnioBsj1e3TC7v+eeZR/Xk3cgy1i
	1eJmoS3q2HBiyKAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD31139D7;
	Fri, 12 Jan 2024 15:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HJnfFnJcoWUKHwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 12 Jan 2024 15:36:18 +0000
Date: Fri, 12 Jan 2024 16:36:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tree-checker: dump the tree block when
 hitting an error
Message-ID: <20240112153602.GP31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yf1uPjPx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vfCeot4J
X-Spamd-Result: default: False [-2.53 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.52)[97.83%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7777F1FCDC
X-Spam-Level: 
X-Spam-Score: -2.53
X-Spam-Flag: NO

On Fri, Jan 12, 2024 at 01:16:20PM +1030, Qu Wenruo wrote:
> Unlike kernel where tree-checker would provide enough info so later we
> can use "btrfs inspect dump-tree" to catch the offending tree block, in
> progs we may not even have a btrfs to start "btrfs inspect dump-tree".
> E.g during btrfs-convert.
> 
> To make later debug easier, let's call btrfs_print_tree() for every
> error we hit inside tree-checker.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

> ---
>  kernel-shared/tree-checker.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
> index 003156795a43..a98553985402 100644
> --- a/kernel-shared/tree-checker.c
> +++ b/kernel-shared/tree-checker.c
> @@ -33,6 +33,7 @@
>  #include "kernel-shared/accessors.h"
>  #include "kernel-shared/file-item.h"
>  #include "kernel-shared/extent_io.h"
> +#include "kernel-shared/print-tree.h"
>  #include "kernel-shared/uapi/btrfs.h"
>  #include "kernel-shared/uapi/btrfs_tree.h"
>  #include "common/internal.h"
> @@ -95,6 +96,8 @@ static void generic_err(const struct extent_buffer *eb, int slot,
>  		btrfs_header_level(eb) == 0 ? "leaf" : "node",
>  		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot, &vaf);
>  	va_end(args);
> +
> +	btrfs_print_tree((struct extent_buffer *)eb, 0);

Printing the eb should not require writable eb, but there are many
functions that would need to be converted to 'const' so the cas is OK
for now but cleaning that up would be welcome.

