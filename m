Return-Path: <linux-btrfs+bounces-1903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E45C840AA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B212822C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59C154C07;
	Mon, 29 Jan 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewP0roTF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Cvv9wtY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewP0roTF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Cvv9wtY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06515155304
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543844; cv=none; b=XhOeEVgZ1vX1B9ZYny+PlwVdhLkEJm4QrZMIu7p99PqXXmD64LqJlYyNS1cHbuWML3zcwozNMlZAolKa9po5c9zqRkVi6CWdYMManlj+lujy4dePF/d1zUa64wqq1Z9LUfIXaEbIMINZgiZg2lHuFAScVuA0AcCnB+CQCT6QMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543844; c=relaxed/simple;
	bh=4HHx8jCoOLo1sAbVTYF71l1KX0GaY/X5z+kU8qZdpJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDMuSrLljZAFvS+01iNJLa3NBusYm7F5Bho1k5ROYdEPh0/OuQ6+T6/MzXP50NOIVkP0j9MqN2CukMbKXNr9s8Yn0VzhqJb9N3GL4M8tEnUqoGKetyP1ACYrm19lWXCuNZCtNzw4EMfiqWPNcUHQDU4fbi14gNpvTfhVYWKCCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ewP0roTF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Cvv9wtY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ewP0roTF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Cvv9wtY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45BA11F7EF;
	Mon, 29 Jan 2024 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706543841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fvxgvpOG99s0pdEwdVXxPaeOKtJNg/5vEdkEDhstNU=;
	b=ewP0roTF50n4gYJzy/69QDmg3yDOBuRA15LhnUqxQBECnbkKyTnkMcqxoXcjCOaAUQX94n
	YTJudDMEYURwHdU5GsrxJBOW+VKfi9yLHUQpFFtgoSZ6DSy4tbQ6DxkzBq7E1qETcIy8zn
	O1gIOhiAaLVcnipT1RibTrGurA/77lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706543841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fvxgvpOG99s0pdEwdVXxPaeOKtJNg/5vEdkEDhstNU=;
	b=/Cvv9wtYTsCwUDNUyZn31+RO4UITKX/ChYH13w5vL+OkUroH3QpqocFB3eRauJKNASGcoz
	ff9sUYCFhV9rCpAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706543841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fvxgvpOG99s0pdEwdVXxPaeOKtJNg/5vEdkEDhstNU=;
	b=ewP0roTF50n4gYJzy/69QDmg3yDOBuRA15LhnUqxQBECnbkKyTnkMcqxoXcjCOaAUQX94n
	YTJudDMEYURwHdU5GsrxJBOW+VKfi9yLHUQpFFtgoSZ6DSy4tbQ6DxkzBq7E1qETcIy8zn
	O1gIOhiAaLVcnipT1RibTrGurA/77lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706543841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fvxgvpOG99s0pdEwdVXxPaeOKtJNg/5vEdkEDhstNU=;
	b=/Cvv9wtYTsCwUDNUyZn31+RO4UITKX/ChYH13w5vL+OkUroH3QpqocFB3eRauJKNASGcoz
	ff9sUYCFhV9rCpAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 33D49132FA;
	Mon, 29 Jan 2024 15:57:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BGZ2DOHKt2WPIQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jan 2024 15:57:21 +0000
Date: Mon, 29 Jan 2024 16:56:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Message-ID: <20240129155656.GZ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
 <9ee6b3bd-a409-4eda-bcd9-b0527b1b1b33@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee6b3bd-a409-4eda-bcd9-b0527b1b1b33@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.99
X-Spamd-Result: default: False [-3.99 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.958];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, Jan 26, 2024 at 08:06:06PM +0800, Anand Jain wrote:
> On 1/25/24 05:18, David Sterba wrote:
> > The btrfs_find_root() looks up a root by a key, allowing to do an
> > inexact search when key->offset is -1.  It's never expected to find such
> > item, as it would break allowed the range of a root id.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/root-tree.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index ba7e2181ff4e..326cd0d03287 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
> > @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
> >   		if (ret > 0)
> >   			goto out;
> >   	} else {
> > -		BUG_ON(ret == 0);		/* Logical error */
> > +		/*
> > +		 * Key with offset -1 found, there would have to exist a root
> > +		 * with such id, but this is out of the valid range.
> > +		 */
> > +		if (ret == 0) {
> > +			ret = -EUCLEAN;
> > +			goto out;
> > +		}
> >   		if (path->slots[0] == 0)
> >   			goto out;
> >   		path->slots[0]--;
> 
> 
> While here, why not also add an error message, especially for calls
> from btrfs_read_roots() when the IGNOREBADROOTS is set, we ignore
> the error and continue without the abort(). Including an error
> message will provide more information about the bad root.

Yeah, after some thoughs i agree that the messages would be good, self
documenting instead of the comments. I'll do that in another series as
we first need some common way of handling it and wrappers.

