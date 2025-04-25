Return-Path: <linux-btrfs+bounces-13415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632EA9C7AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA54E2B5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEA2459E1;
	Fri, 25 Apr 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0J0XfZg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gw9RJdFm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0J0XfZg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gw9RJdFm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD62459D0
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580734; cv=none; b=KSzjt4s1Io+NDL+3P+pCGUYC91fUhFgKpILjB2B7fau6ygCkR/AiSVfh8m00FH1G44lr9Ggp43631YrKieTHIYp3KB4UuuOl9FTCurBdSTpnDGgSIEdcp50f4tYm5BgxOxdfkKSK1vZN1ny5GdV4j8pPVECT/16bPBJGlm8O+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580734; c=relaxed/simple;
	bh=us6Evwbs+8LqvHBjLYrrD8FPiXEWWZYBBxm0/YwYW44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDOPSvjPgiFH4bnpx8rTtuMwvFb3Ng7sYooKpn3603sz5024qh9NU3zMLvh0fvHMGY0Udh0U8kZobfxW5McrRCYs/uoYa5b9aVsg2+3Q6A9ID9p4tMUo0cNkw8BkJgw+c2WQcmJE+v/OWwAB0AYHjIBgJgiSn/H8Yf0HJngMt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0J0XfZg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gw9RJdFm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0J0XfZg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gw9RJdFm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70B721F451;
	Fri, 25 Apr 2025 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745580723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bolSs+KRp4xMJTHKFY5qD9jZpp5iow2XjAnvLaX6q0U=;
	b=j0J0XfZgrmcQiBOLIj94c2mmKer//fwLSmslU/7fPxK7CZXlCS2EEKM/uuOZIpzb60yowp
	tb7+Q0xGqYU5VLH02JZc6NZMWf0MlPt+r3d2UDeUlgtHH7Y0FnOHlrXd56RJ8Ei3A0mkAJ
	sEyzp8QObB2uD/2Sq4LlQ8sQ4S0FYi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745580723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bolSs+KRp4xMJTHKFY5qD9jZpp5iow2XjAnvLaX6q0U=;
	b=Gw9RJdFmCPeYWOHGh1hYXrQ2y0LNZR9H503pqPUMs3BXQy1nrkz9v+QfTSMN/FMaX6sEY+
	cMpEMXnJ364N7pCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745580723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bolSs+KRp4xMJTHKFY5qD9jZpp5iow2XjAnvLaX6q0U=;
	b=j0J0XfZgrmcQiBOLIj94c2mmKer//fwLSmslU/7fPxK7CZXlCS2EEKM/uuOZIpzb60yowp
	tb7+Q0xGqYU5VLH02JZc6NZMWf0MlPt+r3d2UDeUlgtHH7Y0FnOHlrXd56RJ8Ei3A0mkAJ
	sEyzp8QObB2uD/2Sq4LlQ8sQ4S0FYi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745580723;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bolSs+KRp4xMJTHKFY5qD9jZpp5iow2XjAnvLaX6q0U=;
	b=Gw9RJdFmCPeYWOHGh1hYXrQ2y0LNZR9H503pqPUMs3BXQy1nrkz9v+QfTSMN/FMaX6sEY+
	cMpEMXnJ364N7pCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51B2C1388F;
	Fri, 25 Apr 2025 11:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lei3E7NyC2giNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Apr 2025 11:32:03 +0000
Date: Fri, 25 Apr 2025 13:31:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: reformat comments in acls_after_inode_item()
Message-ID: <20250425113158.GB31681@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745426584.git.dsterba@suse.com>
 <8f6470c838cb98fd83136e3285af6afd8b8f293b.1745426584.git.dsterba@suse.com>
 <D9EHQPSBBS4G.2B8ALJ1KNJMET@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9EHQPSBBS4G.2B8ALJ1KNJMET@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 24, 2025 at 01:52:20AM +0000, Naohiro Aota wrote:
> On Thu Apr 24, 2025 at 1:53 AM JST, David Sterba wrote:
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/inode.c | 37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index e3bbe348ac91e2..e18967a14d6419 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3721,10 +3721,14 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
> >  }
> >  
> >  /*
> > - * very simple check to peek ahead in the leaf looking for xattrs.  If we
> > - * don't find any xattrs, we know there can't be any acls.
> > + * Look ahead in the leaf for xattrs. If we don't find any then we know there
> > + * can be any ACLs.
> 
> can't be ?

Fixed, thanks.

> >   *
> > - * slot is the slot the inode is in, objectid is the objectid of the inode
> > + * @leaf:       the eb leaf where to search
> > + * @slot:       the slot the inode is in
> > + * @objectid:   the objectid of the inode
> > + *
> > + * Retrun true if there is a xattr, false otherwise.
> 
> nit: typo: Return
> Also, should it be "an xattr" ?

I don't know, I've changed it to 'xattr/ACL' without a/an, the reason is
to make it clear that the xattr implies potential ACL.

