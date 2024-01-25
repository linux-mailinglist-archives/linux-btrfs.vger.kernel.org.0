Return-Path: <linux-btrfs+bounces-1797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7683C7C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F91B2216C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAB21292F3;
	Thu, 25 Jan 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLxCXm3C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Npgf8CJD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLxCXm3C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Npgf8CJD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697766EB64
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199604; cv=none; b=ETns7Qokem5lndWHxrBuDrb966EYeyPzh34dAk/amfAGp6kpnOVu9XJRGcCFjbcFYzoIZ3ujT4LlcTHENX6lCAA55Kd59V/mvjkQfb+tS1vSFoweaum8iRphZD5moei9G4fxs4rvL7G/NDT8sd/sAbPYcxlMzTHUHwSBdgfT3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199604; c=relaxed/simple;
	bh=0JIXDu6+Abo1vhGNVq4XxQ3uRL4DRF3/xhjyyEHPWtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTv3Lhq99bVNTsORs1fkn3RSaFtXr0MTrYuCHs4yTpIlk4YcVWUwiozhIY9F9ceULiNsAOWgwQxiUECh0d+pXKv/uRYadzpgcgQtoSShEWSFlOIVhl0xdkTetNrdpgJ17Z9sLUjWlBqxFphUqf+CC4fW/TsTB+CNPb5hEfRXtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLxCXm3C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Npgf8CJD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLxCXm3C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Npgf8CJD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95B0F1F894;
	Thu, 25 Jan 2024 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706199600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JldJCu8Lrue1XbNcxBBMFWpCE2hrWD5Tdf0LoLyKwws=;
	b=wLxCXm3CCO+RVEWr9MkuAOPMqpnR+EGQxR7jolW29y32v7bypfsiZlDBQv92NCid/SRqIF
	i7+vhMsIthzREGPGw9xWnofgs1hpeKjjaauforKzeEntuiI706d/GPMoIfYxNEByYeZ/q6
	W1wqdyXBaREJKAG9OfQVgNEDmkU9QIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706199600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JldJCu8Lrue1XbNcxBBMFWpCE2hrWD5Tdf0LoLyKwws=;
	b=Npgf8CJDjPavawq5p2177yVMtNiv/8pOJbZTpt8H7axD0W1DgVYCLHbyTBZTjftTvd9pbf
	6UNDTpg5bwlbiuAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706199600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JldJCu8Lrue1XbNcxBBMFWpCE2hrWD5Tdf0LoLyKwws=;
	b=wLxCXm3CCO+RVEWr9MkuAOPMqpnR+EGQxR7jolW29y32v7bypfsiZlDBQv92NCid/SRqIF
	i7+vhMsIthzREGPGw9xWnofgs1hpeKjjaauforKzeEntuiI706d/GPMoIfYxNEByYeZ/q6
	W1wqdyXBaREJKAG9OfQVgNEDmkU9QIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706199600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JldJCu8Lrue1XbNcxBBMFWpCE2hrWD5Tdf0LoLyKwws=;
	b=Npgf8CJDjPavawq5p2177yVMtNiv/8pOJbZTpt8H7axD0W1DgVYCLHbyTBZTjftTvd9pbf
	6UNDTpg5bwlbiuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78F9713649;
	Thu, 25 Jan 2024 16:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SrRLHTCKsmUneAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 16:20:00 +0000
Date: Thu, 25 Jan 2024 17:19:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/20] btrfs: handle root deletion lookup error in
 btrfs_del_root()
Message-ID: <20240125161937.GO31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <a3879c9484eb245085f08fc90f94dbf027dbe22a.1706130791.git.dsterba@suse.com>
 <9da349b5-b058-44de-b8a7-97ec7df21fec@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da349b5-b058-44de-b8a7-97ec7df21fec@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wLxCXm3C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Npgf8CJD
X-Spamd-Result: default: False [-3.01 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 95B0F1F894
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, Jan 25, 2024 at 02:31:01PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/25 07:48, David Sterba wrote:
> > We're deleting a root and looking it up by key does not succeed, this
> > is an inconsistent state and we can't do anything. All callers handle
> > errors and abort a transaction.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/root-tree.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index 603ad1459368..ba7e2181ff4e 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
> > @@ -323,8 +323,11 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
> >   	ret = btrfs_search_slot(trans, root, key, path, -1, 1);
> >   	if (ret < 0)
> >   		goto out;
> > -
> > -	BUG_ON(ret != 0);
> > +	if (ret != 0) {
> > +		/* The root must exist but we did not find it by the key. */
> > +		ret = -EUCLEAN;
> 
> IIRC every EUCLEAN needs a message (at least that's the rule inside
> tree-checker).

In tree-checker yes, there are many reasons why reading/writing a block
may fail. There the data are read for the first time and we could expect
failures, so it's the first line of defence.

Many other EUCLEAN errors are returned without any messages from deep
call chains and are practically never to be seen, this is the last
resort defence.

> And the only two callers are also aborting the transaction, thus I
> believe we can just abort here.

As said in the other reply, it's up to the caller.

