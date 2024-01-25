Return-Path: <linux-btrfs+bounces-1795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299583C788
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E892923DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85686144;
	Thu, 25 Jan 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m63vCA2j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGoXG4V6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m63vCA2j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGoXG4V6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E5823DE
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198881; cv=none; b=M6DSvw26qSgofRpAnevTX56rZIQjiDCJvKeBmXqxnAPcnjTcJs5BWinINLfzs2zF3qAWLFYni8jwaqXyDsMjxAzWihT5qwXdF14IMh5W5Y+6YLAVIla/UJBxs3nwPPRIABrxnXR74PiXgVg+Zv7rhErK4+48gM7bJmmpsEMmTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198881; c=relaxed/simple;
	bh=pmP7AKaOZYgXq1TXxHdmT5dyIKTaqVZS2jl0IIVS2sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReZkaKpgfwcsn8QyaopI+h3yxcL8Ivwo5Fijf5F95+i2iGZepK9MWGrb6VqKSSnRskKG/Lkf8UyUl+3epPF7e8y5J0b5Hc2Y0/SFiW/3aLJk89bNb+uKgLdGkWn3qhXOiq2Rdd2gkl4K0cknp+TZeitizALBJfq+5FlMHY98xrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m63vCA2j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGoXG4V6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m63vCA2j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGoXG4V6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F89C1F894;
	Thu, 25 Jan 2024 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706198874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lrv86EAcw7mt98FZSt2ZHFrfA9A8HXyNwmDswrAf8Q=;
	b=m63vCA2jjcWyG3Gk8E6ftX/dCqcplbxKb6WgZk3kdi6YmNpn+39wK9MqeJcHTjFHgEfU3C
	ij5P8FzUnB5Z9VYxU2PbBsr2yF7v6Tys3JA+K0nVJLFmgY2nCq2s9IDVVGn1J76IFzvZyX
	vNi+suIhkVwmWNWUq93xQCAmH6Tp3Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706198874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lrv86EAcw7mt98FZSt2ZHFrfA9A8HXyNwmDswrAf8Q=;
	b=yGoXG4V6gShXhe9sAV5Fh/IcIUzAsVndqaFaXBACfpupG1X6QGNtQcDcoAF9KEmAibB+A6
	rimLhcZfHu5ag4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706198874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lrv86EAcw7mt98FZSt2ZHFrfA9A8HXyNwmDswrAf8Q=;
	b=m63vCA2jjcWyG3Gk8E6ftX/dCqcplbxKb6WgZk3kdi6YmNpn+39wK9MqeJcHTjFHgEfU3C
	ij5P8FzUnB5Z9VYxU2PbBsr2yF7v6Tys3JA+K0nVJLFmgY2nCq2s9IDVVGn1J76IFzvZyX
	vNi+suIhkVwmWNWUq93xQCAmH6Tp3Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706198874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Lrv86EAcw7mt98FZSt2ZHFrfA9A8HXyNwmDswrAf8Q=;
	b=yGoXG4V6gShXhe9sAV5Fh/IcIUzAsVndqaFaXBACfpupG1X6QGNtQcDcoAF9KEmAibB+A6
	rimLhcZfHu5ag4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EAA8139E7;
	Thu, 25 Jan 2024 16:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rXXfClqHsmVndAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 16:07:54 +0000
Date: Thu, 25 Jan 2024 17:07:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/20] btrfs: handle invalid range and start in
 merge_extent_mapping()
Message-ID: <20240125160730.GM31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <6cd106844e522bbdd21f15572d81d4c9186725cc.1706130791.git.dsterba@suse.com>
 <7f04e4d0-8695-4d2c-90f8-ea2befb598c8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f04e4d0-8695-4d2c-90f8-ea2befb598c8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m63vCA2j;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yGoXG4V6
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[29.04%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 4F89C1F894
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Jan 25, 2024 at 02:23:03PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/25 07:47, David Sterba wrote:
> > Turn a BUG_ON to a properly handled error and update the error message
> > in the caller.  It is expected that @em_in and @start passed to
> > btrfs_add_extent_mapping() overlap. Besides tests, the only caller
> > btrfs_get_extent() makes sure this is true.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/extent_map.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index f170e7122e74..ac5e366d57b2 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -539,7 +539,8 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
> >   	u64 end;
> >   	u64 start_diff;
> >
> > -	BUG_ON(map_start < em->start || map_start >= extent_map_end(em));
> > +	if (map_start < em->start || map_start >= extent_map_end(em))
> > +		return -EINVAL;
> 
> Shouldn't we go -EUCLEAN?
> 
> This is not something we really expect to hit, as it normally means
> something wrong with the extent map.

The logic I used here is that it's a simple helper and it verifies the
arguments. If they're invalid then it's EINVAL. EUCLEAN needs some
interpretation like in the other patches unexpectedly finding an item,
it's up to the caller.

