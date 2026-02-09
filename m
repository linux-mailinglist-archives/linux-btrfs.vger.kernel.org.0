Return-Path: <linux-btrfs+bounces-21547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPuqNXTgiWnGCwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21547-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 14:26:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DA10FA71
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0550430305CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845E378815;
	Mon,  9 Feb 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dchvTjq6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="78avsXgo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dchvTjq6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="78avsXgo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FED274B48
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643380; cv=none; b=IfAgMIUClgVC7rdDZa0p6WKFAoLKZz/VI3NMuldBylG3T8+YmFbzrdJoJuwp3zMINuD0eAKszL58GkdNvXHRUd1uq5GJiBloRCq4yHvRo9N5CYeScTnTkvXayHYNzzsbM/kpSaqtsC9c3IK96oo3/ggk+Q/PXOyUdUFE78hNCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643380; c=relaxed/simple;
	bh=qRwNyNQ8ntnZIt7r/zei4Jf/r/8i91smyFsOYSlgWxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaU1MQxQycoW4W3zkXuB9QMXwFjfeLxR0a/qsTgkR+WGN0ueh00s5XLOF09xIs9pzxVO5MRJsPaB44/n75rsLy4N7luht4xeUI9FNBAgKSAHASv2YgDrh4Bh6baablXXr6mCgzksFC66NBlWqB2A+qXT2Km+0DPyt/IsJ/OT3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dchvTjq6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=78avsXgo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dchvTjq6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=78avsXgo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE24B3E6FE;
	Mon,  9 Feb 2026 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770643378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTAgc03/6oW2lfJa7WS175FZK1/SbDKpVtIksEsMUu8=;
	b=dchvTjq6g/jiGGF0RksL3VT2e628mgz+ArR4fRC8zAAxYiBwQmvse32DAy+j7JHoEwOICp
	lqVV98SyPCxKUdJNOZOuE77aIZ3zNh1XWxfsJZo3uwDMHOZ+qKiXHz0lnnQx2GiIuLsOcc
	dDgTsyU8cCRYjPDX0qUQSfsQBy9NHPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770643378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTAgc03/6oW2lfJa7WS175FZK1/SbDKpVtIksEsMUu8=;
	b=78avsXgoDLA56H1Td1J1t+O13aWewWD4k0j3NTKSZ7UM5C9wZSAfVWA7nD0mP6lZoeNsC3
	+/DfQco9BvoHZUBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770643378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTAgc03/6oW2lfJa7WS175FZK1/SbDKpVtIksEsMUu8=;
	b=dchvTjq6g/jiGGF0RksL3VT2e628mgz+ArR4fRC8zAAxYiBwQmvse32DAy+j7JHoEwOICp
	lqVV98SyPCxKUdJNOZOuE77aIZ3zNh1XWxfsJZo3uwDMHOZ+qKiXHz0lnnQx2GiIuLsOcc
	dDgTsyU8cCRYjPDX0qUQSfsQBy9NHPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770643378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTAgc03/6oW2lfJa7WS175FZK1/SbDKpVtIksEsMUu8=;
	b=78avsXgoDLA56H1Td1J1t+O13aWewWD4k0j3NTKSZ7UM5C9wZSAfVWA7nD0mP6lZoeNsC3
	+/DfQco9BvoHZUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A38863EA63;
	Mon,  9 Feb 2026 13:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjPCJ7LfiWlDBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 09 Feb 2026 13:22:58 +0000
Date: Mon, 9 Feb 2026 14:22:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sink RCU protection to _btrfs_printk()
Message-ID: <20260209132253.GA26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260205114546.210418-1-dsterba@suse.com>
 <CAL3q7H4pLHd6oKKShm_3OvTHN1jJ8g8HHxQwKYkDZ1ShQqeMbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4pLHd6oKKShm_3OvTHN1jJ8g8HHxQwKYkDZ1ShQqeMbQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21547-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: 693DA10FA71
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:39:07AM +0000, Filipe Manana wrote:
> > --- a/fs/btrfs/messages.h
> > +++ b/fs/btrfs/messages.h
> > @@ -85,9 +85,7 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, cons
> >
> >  #define btrfs_printk_in_rcu(fs_info, level, fmt, args...)      \
> >  do {                                                           \
> > -       rcu_read_lock();                                        \
> >         _btrfs_printk(fs_info, level, fmt, ##args);             \
> > -       rcu_read_unlock();                                      \
> >  } while (0)
> 
> There's no longer any need for the do while, so it could now be simply:
> 
>  #define btrfs_printk_in_rcu(fs_info, level, fmt, args...)
> _btrfs_printk(fs_info, level, fmt, ##args)

Right, fixed in for-next, thanks.

