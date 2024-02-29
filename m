Return-Path: <linux-btrfs+bounces-2950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911486D43F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6E31F24092
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870F1428FE;
	Thu, 29 Feb 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJQMjD7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgqZhDds";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuH/PlBd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7X3F0t43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30810B656
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238632; cv=none; b=n9Hjpsj3TwIWz7mTmRiscqZOirmNirZ1sHstpzSVgxRN6XUGjzP24sGGq3yGH5NkYduZ0mOFCI4bR19ryszGe6tiClIU4hviJePE0SRTYg319yzkK7qq4jC4udRvLw42fS8RHZF1GLUhGihnNvUa3t/OYd5hqpBidAJWRgnsmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238632; c=relaxed/simple;
	bh=uTQa8B0cghK+k63WjUf8byV+UDIW2o/DKXlSFXG5s+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPvld69F2emSaKo2kvEffWGhxErQ1s0nIiSjhh55GC5/OR/TubzXeXKnoSA1wDCYHoUx/35DkjyRk8XQD39QsyS3B/wVNSPxUeYBSsQZBYWnpjewCdRThRI2+Fo2IRR6L2DQnuvAacqbgwM5RleB3Rdq6ejlr+4PNPqOFVng3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJQMjD7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgqZhDds; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuH/PlBd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7X3F0t43; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E40AF2236C;
	Thu, 29 Feb 2024 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709238626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkwkaGuzGxuE+3XllZAfrG3PxRDWSoZy0jrbDs4mMsw=;
	b=dJQMjD7GxD5IPjEDtTifdqndeflFTxWS1bVwkRsfQWBv4h/PjYF/o5e2fNRCR6C7F+9Uwd
	7B1OmWfdq/noGxNPIis+bp6gqH8UgviCcKYLezrNe4nBJQQYVdsFKaKlP7GdxVB8edONs2
	WwexJougipO9vANOgG1qPWk7tfuUUsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709238626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkwkaGuzGxuE+3XllZAfrG3PxRDWSoZy0jrbDs4mMsw=;
	b=VgqZhDdsbneG8BmIondyJvfDvW6r3XOgYzjTg4i3jsJyu093lbxIKD2Cvz/71uqjbA2E8N
	VTIwOcBPdHOMxVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709238625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkwkaGuzGxuE+3XllZAfrG3PxRDWSoZy0jrbDs4mMsw=;
	b=uuH/PlBday4Rb/LzDOlfexPOxkfh/PvLV3k1yQb5+XQHfAtpVWLkftFrAkdODK93eHDR7d
	mPkatn91/6OgW349LpgNnVy1Rr7MyLBI47jOAhVSQkVzNff/h9sLprJPb9ahT3lASI55kS
	QRLhxxoE7hZ5tPAPDwiKSbqaOqSusBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709238625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkwkaGuzGxuE+3XllZAfrG3PxRDWSoZy0jrbDs4mMsw=;
	b=7X3F0t43j2H4i5/4Rbd6yeHDJ5iEPUFzWALyNJCjuy1uH8or93HHUKfO9lpRqHGKFYA+5X
	twKgcjh4IgYJ+YBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C8FCD1329E;
	Thu, 29 Feb 2024 20:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NQ/mMGHp4GUrBgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 20:30:25 +0000
Date: Thu, 29 Feb 2024 21:23:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	WA AM <waautomata@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: use zone aware sb location for scrub
Message-ID: <20240229202322.GH2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uuH/PlBd";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7X3F0t43
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,wdc.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.35%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: E40AF2236C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Feb 29, 2024 at 12:43:56PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
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
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/scrub.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c4bd0e60db59..3c8fd9c9fa1d 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2812,7 +2812,10 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>  		gen = btrfs_get_last_trans_committed(fs_info);
>  
>  	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		bytenr = btrfs_sb_offset(i);
> +		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
> +		if (ret)
> +			goto out_free_page;

This is scrub and errors can be expected so this should iterate over all
super blocks.

> +
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>  		    scrub_dev->commit_total_bytes)
>  			break;
> @@ -2828,6 +2831,13 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>  	}
>  	__free_page(page);
>  	return 0;
> +
> +out_free_page:
> +	spin_lock(&sctx->stat_lock);
> +	sctx->stat.malloc_errors++;

And increase the super_errors instead of malloc_errors, I checked some
of the return values of btrfs_sb_log_location() and there's ENOENT,
EUCLEAN and some iherited errors can't say it ENOMEM.

> +	spin_unlock(&sctx->stat_lock);
> +	__free_page(page);
> +	return ret;
>  }
>  
>  static void scrub_workers_put(struct btrfs_fs_info *fs_info)
> -- 
> 2.35.3
> 

