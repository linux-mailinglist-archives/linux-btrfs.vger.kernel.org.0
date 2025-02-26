Return-Path: <linux-btrfs+bounces-11879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5825A4646F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F4188C465
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA02253E8;
	Wed, 26 Feb 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PA7ANbA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FT/0M1Pe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="btdCGLCa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="elTkrsiY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62042222C6
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583230; cv=none; b=jwrPNO/eV1TjcNa1he68j9yLDxxcrQFGwngtS0sZ19oYFcREv7Gpa7q6pWd/fbaKzOWqeKb5sgjhROVBtJL4lJxBZ2UAWyj72+hg3Vj4YrwFl/R3bsTERlUFrJcATNtUhbJ3A08YLRoLKqywhC9rAVR0u6KpXLxY17Do3tBbRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583230; c=relaxed/simple;
	bh=Q86lEjphtQaGBuy6TaEFVjscKMHedHdqJO5v7MJsMgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9x8eRgASnxpGOptEbdqu9X2mfnivkf4lIekLLIpheJuteL59LQnwrZkgpRNODPTkZvTsixw6YrclDTCmQ3Ck95n81zjf+InpyNiyUtuSou55TcUKfV0mpnxa/8/T00uEGIIo/SbJnYH9tQRc0L/IY5xXMRv4E36glKUu/vobGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PA7ANbA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FT/0M1Pe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=btdCGLCa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=elTkrsiY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D99D92118D;
	Wed, 26 Feb 2025 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740583225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8c/SKMg3JtgwWLl1Ox9ycf1Bsh5pep7haPN2C6vU5o=;
	b=PA7ANbA8z4rpx5ilJ/eo6hltQbAZL9ESOr/kHThgyAADi4CgZFK7grtEaLs8GYMnuy5jMq
	otgHfTku92nc4xIksvZ3xflc3WuPE08MHTMhmlOhBu49S5J8H7PQU4d+E/4DTqF5Z5Duvs
	jVKxPha86ocI5BKn7/LGnU+x0xr99ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740583225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8c/SKMg3JtgwWLl1Ox9ycf1Bsh5pep7haPN2C6vU5o=;
	b=FT/0M1Pe2Bww9+cQwX4r4b/LX6bnRfnE0fzals52RImAWaOTp+2p3RVmHzunz8Si6CGo2p
	9J1QylVd0tZFHZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=btdCGLCa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=elTkrsiY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740583224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8c/SKMg3JtgwWLl1Ox9ycf1Bsh5pep7haPN2C6vU5o=;
	b=btdCGLCaK/Qn0u+x4poHcAEULnZ01sh3PWPbMmOjPL5IhNtQWcOebwu59egiHupHjMF4uF
	A4U/HY/6RPHV1dnbN2I9Uh2r2gVVDTLlEXw7NwOXUHeATB8Z0J0nBOcs8IjZI7AxpCg1y1
	4ngUY2OaoRrtM7uELWUEmKd5CfAOnOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740583224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8c/SKMg3JtgwWLl1Ox9ycf1Bsh5pep7haPN2C6vU5o=;
	b=elTkrsiYYLsdz2tnZ9YckIAZAH7eyXl3fKcAYP5VX184CneZvktd6bKhi6NFvmPx5Pw1s2
	H1pa5QuMihNJYHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC5BB1377F;
	Wed, 26 Feb 2025 15:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOzHLTgxv2d1VwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Feb 2025 15:20:24 +0000
Date: Wed, 26 Feb 2025 16:20:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: Remove some code duplication
Message-ID: <20250226152023.GX5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <74072f83285f96aba98add7d24c9f944d22a721b.1739974151.git.christophe.jaillet@wanadoo.fr>
 <D7X1HAEVN3TO.Z7JG9SRUODCE@wdc.com>
 <4cbdb517-2d4b-4f73-9822-a9c4ec794b54@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cbdb517-2d4b-4f73-9822-a9c4ec794b54@wanadoo.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D99D92118D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Feb 20, 2025 at 08:11:46AM +0100, Christophe JAILLET wrote:
> Le 20/02/2025 à 06:55, Naohiro Aota a écrit :
> > On Wed Feb 19, 2025 at 11:10 PM JST, Christophe JAILLET wrote:
> >> This code snippet is written twice in row, so remove one of them.
> >>
> >> This was apparently added by accident in commit efe28fcf2e47 ("btrfs:
> >> handle unexpected parent block offset in btrfs_alloc_tree_block()")
> >>
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >>   fs/btrfs/zoned.c | 9 ---------
> >>   1 file changed, 9 deletions(-)
> >>
> >> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> >> index b5b9d16664a8..6c4534316aad 100644
> >> --- a/fs/btrfs/zoned.c
> >> +++ b/fs/btrfs/zoned.c
> >> @@ -1663,15 +1663,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
> >>   	}
> >>   
> >>   out:
> >> -	/* Reject non SINGLE data profiles without RST */
> >> -	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
> >> -	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
> >> -	    !fs_info->stripe_root) {
> >> -		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
> >> -			  btrfs_bg_type_to_raid_name(map->type));
> >> -		return -EINVAL;
> >> -	}
> >> -
> >>   	/* Reject non SINGLE data profiles without RST. */
> >>   	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
> >>   	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
> > 
> > Thanks, but which repository/branch are you working with? I cannot
> > find the duplicated lines in btrfs/for-next, linus/master, nor
> > linux-stable. Also, the pointed commit seems wrong too.
> 
> Sorry for the lack of context.
> 
> This is based on linux-next. In my case -next-20250219
> 
> This can be seen at :
>   
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/btrfs/zoned.c?id=efe28fcf2e47aa5142bff2c284ea7337b40901e8#n1666
> 
> The commit Id is the one given at :
>   
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/btrfs/zoned.c?id=efe28fcf2e47aa5142bff2c284ea7337b40901e8

For the record, the patch has been removed from for-next, and it was
actually wrong, probably a result of some rebase conflict.

