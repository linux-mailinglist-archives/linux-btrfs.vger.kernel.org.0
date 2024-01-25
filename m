Return-Path: <linux-btrfs+bounces-1799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D715983C812
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089971C20D35
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549112FF90;
	Thu, 25 Jan 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTtCI47o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bbXgBFxJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTtCI47o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bbXgBFxJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10319472
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200321; cv=none; b=jEkOAMvRxCiuyQlRR6mJwdR4ljI0UgQHhAvbtuH/Ab0XpaE8MUUBX75XBz05UpYyQItIAu6TKvu+TmY+5qEithK2Dav2BhOSqgSQVd6ewqW+33WpRw7UYgBEWZhL8j0Zs8J2CZZZttjM4s7a63X5Y0OawSQ1rp3I9mW79APbnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200321; c=relaxed/simple;
	bh=bXTnD0wwwhC00Ksd7enM/YbRqs4AIXbyFvogTT1J/sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i//sXXqCAsV2XHaYtBKZ3LNFuWgqpEUVxBvAuddOT5QtdF3j2Sg9Gs/DTWImAyr1vCE/HQMl+E6lCJybuPwVG7mX8SiklJT7sA5sn7OUJ7o+/1mM2xPMRX0qZNLodieL2j2a26fNglzbMBdq9iOofONv/kqfTrgHfVQcKzPDuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTtCI47o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bbXgBFxJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTtCI47o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bbXgBFxJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3198E21EFC;
	Thu, 25 Jan 2024 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706200318;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpiVAnVTTjJl+t0aL4oByvyi8lh4zn0lqE4COpmLcp8=;
	b=qTtCI47ooaWmWokYDKHqeEYko4CNLvgkgWcC/+4qql7kyd3reImnfp9xPukagRDj2GRqVL
	8bJwjQoS/ubkCTPGTZqrXAKFWAmgNDJib7EmfUo6tJdFznuZXgOPsERN3OUZT61HAvqUHi
	YjDA/tetLl+ttIVd1sE+Tsb8oM5CRSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706200318;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpiVAnVTTjJl+t0aL4oByvyi8lh4zn0lqE4COpmLcp8=;
	b=bbXgBFxJ/cXRra5gvteV8KzeHFEUEDKSO78ZDTfRwtklfAHPjtk00RDdwRydt/eH9wXdLS
	VQdtf0l1I/hAYEDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706200318;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpiVAnVTTjJl+t0aL4oByvyi8lh4zn0lqE4COpmLcp8=;
	b=qTtCI47ooaWmWokYDKHqeEYko4CNLvgkgWcC/+4qql7kyd3reImnfp9xPukagRDj2GRqVL
	8bJwjQoS/ubkCTPGTZqrXAKFWAmgNDJib7EmfUo6tJdFznuZXgOPsERN3OUZT61HAvqUHi
	YjDA/tetLl+ttIVd1sE+Tsb8oM5CRSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706200318;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpiVAnVTTjJl+t0aL4oByvyi8lh4zn0lqE4COpmLcp8=;
	b=bbXgBFxJ/cXRra5gvteV8KzeHFEUEDKSO78ZDTfRwtklfAHPjtk00RDdwRydt/eH9wXdLS
	VQdtf0l1I/hAYEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16442134C3;
	Thu, 25 Jan 2024 16:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AZ5EBf6MsmXpewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 16:31:58 +0000
Date: Thu, 25 Jan 2024 17:31:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/20] btrfs: handle invalid extent item reference found
 in check_committed_ref()
Message-ID: <20240125163135.GQ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <139f98f6906bcd774f867e1ef4020fa948ebef93.1706130791.git.dsterba@suse.com>
 <c917ba6b-142d-4ed3-b968-b850ae9079a5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c917ba6b-142d-4ed3-b968-b850ae9079a5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qTtCI47o;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bbXgBFxJ
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 3198E21EFC
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Jan 25, 2024 at 02:40:12PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/25 07:48, David Sterba wrote:
> > The check_committed_ref() helper looks up an extent item by a key,
> > allowing to do an inexact search when key->offset is -1.  It's never
> > expected to find such item, as it would break the allowed range of a
> > extent item offset.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/extent-tree.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 4283e3025ab0..ba47f5996c84 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2399,7 +2399,14 @@ static noinline int check_committed_ref(struct btrfs_root *root,
> >   	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
> >   	if (ret < 0)
> >   		goto out;
> > -	BUG_ON(ret == 0); /* Corruption */
> > +	if (ret == 0) {
> > +		/*
> > +		 * Key with offset -1 found, there would have to exist an extent
> > +		 * item with such offset, but this is out of the valid range.
> > +		 */
> > +		ret = -EUCLEAN;
> > +		goto out;
> > +	}
> 
> It looks like we also need an key offset check for extent item.

We already have it (though I did not remeber that first),
check_extent_item() checks alignment or exact values. Why I don't want
that to be an assert is in my previous reply.

