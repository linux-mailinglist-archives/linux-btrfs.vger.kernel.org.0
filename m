Return-Path: <linux-btrfs+bounces-12894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E768A8191C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 01:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050704A59C8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188692566E3;
	Tue,  8 Apr 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="no0B6VPN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJhGDO5g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="no0B6VPN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hJhGDO5g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370264A21
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153464; cv=none; b=DbGhIWLPf37Nztl6epDemwflz8flBj6IlFAeYHXElr4G2IkzmOraFf2OQC0ZxCwTPUJInnfp1TZk9lIVd4/YvzEWrixiS1o7/cpaMSunKxzuG9D9rENNysfuJsSnIoU/Gq9Ip4BSSDxVQ65vAhABUcUoUv0um6dv94+wCRgWNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153464; c=relaxed/simple;
	bh=8M1iiJZQRDrcVnqVkPeB9/eTKvjAsIunlPP0Y9HcMUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBhwLAltz7qmNgBo1r+yqe3nQo4GDeg1AwqjhpgY1G4x4S3vYgudxqXfRFUTCHSywLwux/pn2TxjzlunDbnWV1uCcy512fyWARGluZ0Zm7LSnkOLUduAgajc2cEFcYKM32sCQHcbq03+LKh7y1pHbSC7QI1OjUwjEsQXzA+gRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=no0B6VPN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJhGDO5g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=no0B6VPN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hJhGDO5g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 167231F388;
	Tue,  8 Apr 2025 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744153459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddDhDPHtf83+cV6fc6aRjZlYyArVwbGtUWtBxQhaKUg=;
	b=no0B6VPNtWdCVeLFR9nC/MABpHThr7qRSB7fjldP0XhKZw6zg8rsH4p/j5Wp7GiBRA6Uhi
	Nd5qA13XHnrguURo85+KxY+43DKXOuUxWm93aeo3Wj+966hIDNWtkVQrkdT5oeXnawEt69
	WIHH8lU1+0YSlk8dg/S0Av0mK6hiDXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744153459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddDhDPHtf83+cV6fc6aRjZlYyArVwbGtUWtBxQhaKUg=;
	b=hJhGDO5g++UigA5dGImSofGRbK8xI0t+W8TFZsy5fYpuyDRZZkTeo7AcXJH2vMhvIAmZTh
	xXWYACLb8A0CVdCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=no0B6VPN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hJhGDO5g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744153459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddDhDPHtf83+cV6fc6aRjZlYyArVwbGtUWtBxQhaKUg=;
	b=no0B6VPNtWdCVeLFR9nC/MABpHThr7qRSB7fjldP0XhKZw6zg8rsH4p/j5Wp7GiBRA6Uhi
	Nd5qA13XHnrguURo85+KxY+43DKXOuUxWm93aeo3Wj+966hIDNWtkVQrkdT5oeXnawEt69
	WIHH8lU1+0YSlk8dg/S0Av0mK6hiDXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744153459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddDhDPHtf83+cV6fc6aRjZlYyArVwbGtUWtBxQhaKUg=;
	b=hJhGDO5g++UigA5dGImSofGRbK8xI0t+W8TFZsy5fYpuyDRZZkTeo7AcXJH2vMhvIAmZTh
	xXWYACLb8A0CVdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE3C913691;
	Tue,  8 Apr 2025 23:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qAi3NXKr9Wc5UwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Apr 2025 23:04:18 +0000
Date: Wed, 9 Apr 2025 01:04:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: Fix transaction abort during failure in
 del_balance_item()
Message-ID: <20250408230413.GE13292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250408122933.121056-1-frank.li@vivo.com>
 <20250408122933.121056-4-frank.li@vivo.com>
 <CAL3q7H7BS6juCS0eRdo6sqM4jzeMMi1o=huG38wgKYumD7qmmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7BS6juCS0eRdo6sqM4jzeMMi1o=huG38wgKYumD7qmmw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 167231F388
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 08, 2025 at 03:53:04PM +0100, Filipe Manana wrote:
> On Tue, Apr 8, 2025 at 1:19 PM Yangtao Li <frank.li@vivo.com> wrote:
> >
> > Handle errors by adding explicit btrfs_abort_transaction
> > and btrfs_end_transaction calls.
> 
> Again, like in the previous patch, why?
> This provides no reason at all why we should abort.
> And the same comment below.
> 
> >
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/btrfs/volumes.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 347c475028e0..23739d18d833 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3777,7 +3777,7 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
> >         struct btrfs_trans_handle *trans;
> >         BTRFS_PATH_AUTO_FREE(path);
> >         struct btrfs_key key;
> > -       int ret, err;
> > +       int ret;
> >
> >         path = btrfs_alloc_path();
> >         if (!path)
> > @@ -3800,10 +3800,13 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
> >         }
> >
> >         ret = btrfs_del_item(trans, root, path);
> > +       if (ret)
> > +               goto out;
> > +
> > +       return btrfs_commit_transaction(trans);
> >  out:
> > -       err = btrfs_commit_transaction(trans);
> > -       if (err && !ret)
> > -               ret = err;
> > +       btrfs_abort_transaction(trans, ret);
> > +       btrfs_end_transaction(trans);
> 
> A transaction abort will turn the fs into RO mode, and it's meant to
> be used when we can't proceed with changes to the fs after we did
> partial changes, to avoid leaving things in an inconsistent state.
> Here we don't abort because we haven't done any changes before using
> the transaction handle, so an abort is pointless and will turn the fs
> into RO mode unnecessarily.

The del_balance_item() case seems to be unique, there's only one caller
reset_balance_state() that calls btrfs_handle_fs_error() in case of an
error. This is almost the same as a transaction abort, but
del_balance_item() may be called from various contexts.

The error handling may be improved here, e.g. some callers may care
about the actual error of del_balance_item/reset_balance_state, but
rather a hard transaction abort it could be better to handle it more
gracefully for operations that are restartable, like return an EAGAIN.

