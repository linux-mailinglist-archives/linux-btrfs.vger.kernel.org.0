Return-Path: <linux-btrfs+bounces-3017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25F8723D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E054B25866
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C22E12839C;
	Tue,  5 Mar 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLGLWuxW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3fmOcC21";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLGLWuxW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3fmOcC21"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC751272D8
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655060; cv=none; b=HHmu0O5hYJMP72nW01arGGXkVPJtwV3607AB0UEvUOrZ+ePzF2dFwgK9gY85dvijAYhrSp9xeR5zxxfv5LWMmQJZ/U0DfZR7z2jm2QgTOo2X8OeCNW/40/pNcACYy/lhqmub8Cs2YpDYVK2Xyh54CwNYAkE+z7Z3dRV8FgZmSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655060; c=relaxed/simple;
	bh=zuQar1wneCziQx6I/DaZ5yYZHLOLA2YvQ6utxuVsNJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHad77Is9fojLhr5etWq9pZcaStWWQnP2n3y47c/fLJpzCbR+ledGxeUdiovMdH6b0rxX6rvMFap9ogFQq6+Ejd42dM5pylhNuBAzfduU+skuKm65X+q2aCjOwerGSAOhtpO9ObGG8vtr+bItM5bjsFvSe4aQHvkprhcGpY2tLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLGLWuxW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3fmOcC21; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLGLWuxW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3fmOcC21; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 403156B82D;
	Tue,  5 Mar 2024 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709655056;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BBIW7845wqWGWZrZwYs8nfMSaWSa0QRaPMwYFpHa7c=;
	b=aLGLWuxWWizK+mTjlZQGirwniqOuN2AGpTilmWxZZf3IYWkFxLeyRXvSAsuNK9WejnT+I/
	M0QgQaPAg5MIaqKdN8v6Y6TmoPN8XUOA25dVUdGw5JFlABpVGKO/i3jHneq0BdNKjcYz1g
	297sieBk0hqLw0XHOFbhAPFBhOo+Sq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709655056;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BBIW7845wqWGWZrZwYs8nfMSaWSa0QRaPMwYFpHa7c=;
	b=3fmOcC21bymtl2uuFM3sGbqHluycTkOjkUHAMwn3g7eIAIoAR1e5FVIA7AXpzhuDTVdK4X
	ImhbMj+4VW+eZWBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709655056;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BBIW7845wqWGWZrZwYs8nfMSaWSa0QRaPMwYFpHa7c=;
	b=aLGLWuxWWizK+mTjlZQGirwniqOuN2AGpTilmWxZZf3IYWkFxLeyRXvSAsuNK9WejnT+I/
	M0QgQaPAg5MIaqKdN8v6Y6TmoPN8XUOA25dVUdGw5JFlABpVGKO/i3jHneq0BdNKjcYz1g
	297sieBk0hqLw0XHOFbhAPFBhOo+Sq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709655056;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BBIW7845wqWGWZrZwYs8nfMSaWSa0QRaPMwYFpHa7c=;
	b=3fmOcC21bymtl2uuFM3sGbqHluycTkOjkUHAMwn3g7eIAIoAR1e5FVIA7AXpzhuDTVdK4X
	ImhbMj+4VW+eZWBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2744713A5D;
	Tue,  5 Mar 2024 16:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HzVvCRBE52WOYAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Mar 2024 16:10:56 +0000
Date: Tue, 5 Mar 2024 17:03:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, WA AM <waautomata@gmail.com>
Subject: Re: [PATCH v2] btrfs: zoned: use zone aware sb location for scrub
Message-ID: <20240305160350.GP2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <75f3da872a8c1094ef0f6ed93aac9bf774ef895b.1709554485.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f3da872a8c1094ef0f6ed93aac9bf774ef895b.1709554485.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aLGLWuxW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3fmOcC21
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[25.58%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 403156B82D
X-Spam-Flag: NO

On Mon, Mar 04, 2024 at 01:15:24PM +0100, Johannes Thumshirn wrote:
> At the moment scrub_supers() doesn't grab the super block's location via
> the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().
> 
> This leads to checksum errors on 'scrub' as we're not accessing the
> correct location of the super block.
> 
> So use btrfs_sb_log_location() for getting the super blocks location on
> scrub.
> 
> Reported-by: WA AM <waautomata@gmail.com>
> Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---
> Changes to v1:
> - Increase super_errors
> - Don't break out after 1st error
> Link to v1:
> - https://lore.kernel.org/linux-btrfs/933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com
> ---
>  fs/btrfs/scrub.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c4bd0e60db59..ee04bd8f5a46 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2812,7 +2812,13 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>  		gen = btrfs_get_last_trans_committed(fs_info);
>  
>  	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		bytenr = btrfs_sb_offset(i);

In Qu's version of fix
https://lore.kernel.org/linux-btrfs/cf93c10bb94755f1bee7e70b333db72ba9f0896b.1709629215.git.wqu@suse.com/

> +		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
> +		if (ret) {
> +			spin_lock(&sctx->stat_lock);
> +			sctx->stat.super_errors++;
> +			spin_unlock(&sctx->stat_lock);

there's ENOENT handled and not accounted as error, which sounds correct.

> +			continue;
> +		}
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>  		    scrub_dev->commit_total_bytes)
>  			break;
> -- 
> 2.35.3
> 

