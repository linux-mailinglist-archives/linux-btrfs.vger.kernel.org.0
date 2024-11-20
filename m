Return-Path: <linux-btrfs+bounces-9795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C019D42D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B752827C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1631714CA;
	Wed, 20 Nov 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4nlS5qa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RuY2pOi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4nlS5qa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RuY2pOi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E116F8E9
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133112; cv=none; b=Vw1tna4rFg/BE//b0ZfnLPcAgNCMTMy5J9nLWn0eq52WsXwDF9qeCj2E6XmWV6pCj8SyX5ulRNfFHkZq7GzHVOuKSVOLsHtgEYN3nrhJk7tqYiguwcl9Ou9mzm19jWWh+fT4eaHNih5CMszzilt5r+XpB/MyICHACnhhddP5jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133112; c=relaxed/simple;
	bh=LDUt9atQ8gNBIz2ZDx3s1fJne4fAiXZUkHejRPSYklg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK+9Rieex0NAT/D9g9KIINtLBNeHqD/rn9p8UDGu2O2y9SIxIPuMSce/LPQVkSUDaslMrsAcB/Z1Gmlrfa8NUPdrXmD5oqLyO0msx53/4lxrURVR8itIzvqGNQiqOp0FGELxe1XB9QzhKAoi9Kmrqexf8FPUmtgn+XkuegLqo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4nlS5qa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RuY2pOi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4nlS5qa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RuY2pOi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4647E211CF;
	Wed, 20 Nov 2024 20:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732133107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p52Gox+5WzN9As7amvW2ErtMwheHbvzyDFi8nJfkBpY=;
	b=I4nlS5qa+HUOTC7bkwJ0KFWXyWr4RJ4WvBwTKMtaOh/PutlrEPJ9i9CtI/VhLjhUdRJzpO
	3CUpYrNQNZn7bxwuKNCAFrz5at0UbNcXp1GtaCTwfgI5x/dlkYg8Eg6J1h+VN3TQccHz4g
	B5K2hAwlw9daezn2rO0pUV+57fo6iwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732133107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p52Gox+5WzN9As7amvW2ErtMwheHbvzyDFi8nJfkBpY=;
	b=2RuY2pOi8qcTkbTpKXePOTI99EUs1HBJvexn0zKlIcXw5hkggk9puJzkm6/Vybk2BSvdW2
	Zxg+MeqNvKY3ubAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=I4nlS5qa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2RuY2pOi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732133107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p52Gox+5WzN9As7amvW2ErtMwheHbvzyDFi8nJfkBpY=;
	b=I4nlS5qa+HUOTC7bkwJ0KFWXyWr4RJ4WvBwTKMtaOh/PutlrEPJ9i9CtI/VhLjhUdRJzpO
	3CUpYrNQNZn7bxwuKNCAFrz5at0UbNcXp1GtaCTwfgI5x/dlkYg8Eg6J1h+VN3TQccHz4g
	B5K2hAwlw9daezn2rO0pUV+57fo6iwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732133107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p52Gox+5WzN9As7amvW2ErtMwheHbvzyDFi8nJfkBpY=;
	b=2RuY2pOi8qcTkbTpKXePOTI99EUs1HBJvexn0zKlIcXw5hkggk9puJzkm6/Vybk2BSvdW2
	Zxg+MeqNvKY3ubAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 302F3137CF;
	Wed, 20 Nov 2024 20:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8QuRC/NAPmenEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 20 Nov 2024 20:05:07 +0000
Date: Wed, 20 Nov 2024 21:05:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs-progs: device-utils: include libgen.h for musl
Message-ID: <20241120200505.GX31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241119014326.3639742-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119014326.3639742-1-dominique.martinet@atmark-techno.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4647E211CF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Nov 19, 2024 at 10:43:26AM +0900, Dominique Martinet wrote:
> musl 1.2.5 no longer defines basename in strings.h and requires including
> libgen.h as specified by POSIX, and builds now fail with this without it:
> common/device-utils.c: In function 'device_get_partition_size_sysfs':
> common/device-utils.c:345:16: warning: implicit declaration of function 'basename' [-Wimplicit-function-declaration]
>   345 |         name = basename(path);
>       |                ^~~~~~~~
> common/device-utils.c:345:14: warning: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   345 |         name = basename(path);
>       |              ^
> 
> Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/16106
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> 
> This was fixed in alpine for a while but the patch never seems to have
> been sent (at least a quick search didn't turn it up)
> 
> It doesn't break anything for other libcs so probably harmless as is.
> 
>  common/device-utils.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index c39e6d6166ad..56924acd7901 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -22,6 +22,7 @@
>  #include <linux/blkzoned.h>
>  #endif
>  #include <linux/fs.h>
> +#include <libgen.h>

Please don't add libgen.h anywhere, this causes problems so the solution
we ended up was a one place with correct includes, which is
path-utils.c. Then path_basename() needs to be used instead of plain
basename() calls.

For reference:

- issue 778
- commit 884a609a77a6ddb7f0e0ba8789e0f0fc0e899dab
- commit d95a14949d80c7c7d6bb081d812ddcd39ba4b24d

