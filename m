Return-Path: <linux-btrfs+bounces-9179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E3C9B0DD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06B21F24C7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC841B0F1C;
	Fri, 25 Oct 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FO9YdLfL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rmG0m9iQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FO9YdLfL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rmG0m9iQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5920C324
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882946; cv=none; b=ncdq66LNvilzm8vf66eHMZP7O8OCpv9hIShJvld6349//eozrfGTl99D04GzvJs8Evac4E/0WS7L6Ui0s3prK2p9g3sER/roWuqT+saB8sGfcHQsygGxeQmiD7anQ+3t6eXqk899NvukjS+jSyZ3lMIB8+COfAInatszqibaNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882946; c=relaxed/simple;
	bh=ZORDWtPCGSS4Z5AmYpLqk56H5fnm1IxClriPZRoazgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPMJVaBLVm/0jSEpfJOf4Bp92Nr9Y5bOJcjMZUQcUGoeW0TNF7IAHSETYAFNx77WJqzy7tKfitdzaFWwDFDmaFFcR8eu5LC6WVHqx4t9iRNRboCiDwJFc5VpcENeHbQtHtlZMjiBdOSpopwr2tud7okNJjV099GOHbAU0uFRBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FO9YdLfL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rmG0m9iQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FO9YdLfL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rmG0m9iQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6D211FB8B;
	Fri, 25 Oct 2024 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729882942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjyF/Gkwu0ISk0ceOF+FvjcN8BqaBvOJHCNcPShB5Q=;
	b=FO9YdLfL3vPsO+E4ebUf55xmeqJZGAKffCZWirodUMUkt9dS7aUqW4uq260aJaxhuFPn/q
	f+1BtHkeQyqOtKenKlOzn4+RqRdXbtlWRIVkBlpFZc96djYWL5qN9AsFlzOYEZFDkufq+f
	bAMFi5Z6qIlCw8TRG2Xme0hIQQFTyfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729882942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjyF/Gkwu0ISk0ceOF+FvjcN8BqaBvOJHCNcPShB5Q=;
	b=rmG0m9iQpmKmrJsI7utHiw1yJoEiA4Xy4lus8CqM4s2AvZP4sEiMJVK3AkKNnXxhgfCaq4
	rYM0Ol8aCW+xVtDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FO9YdLfL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rmG0m9iQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729882942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjyF/Gkwu0ISk0ceOF+FvjcN8BqaBvOJHCNcPShB5Q=;
	b=FO9YdLfL3vPsO+E4ebUf55xmeqJZGAKffCZWirodUMUkt9dS7aUqW4uq260aJaxhuFPn/q
	f+1BtHkeQyqOtKenKlOzn4+RqRdXbtlWRIVkBlpFZc96djYWL5qN9AsFlzOYEZFDkufq+f
	bAMFi5Z6qIlCw8TRG2Xme0hIQQFTyfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729882942;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjyF/Gkwu0ISk0ceOF+FvjcN8BqaBvOJHCNcPShB5Q=;
	b=rmG0m9iQpmKmrJsI7utHiw1yJoEiA4Xy4lus8CqM4s2AvZP4sEiMJVK3AkKNnXxhgfCaq4
	rYM0Ol8aCW+xVtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DE83136E4;
	Fri, 25 Oct 2024 19:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WiNmIj7rG2fVLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 19:02:22 +0000
Date: Fri, 25 Oct 2024 21:02:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Enno Gotthold <egotthold@suse.com>, Fabian Vogt <fvogt@suse.com>
Subject: Re: [PATCH v2] btrfs: fix mount failure due to remount races
Message-ID: <20241025190221.GM31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a682e48c161eece38f8d803103068fed5959537d.1729665365.git.wqu@suse.com>
 <20241023163237.GD31418@twin.jikos.cz>
 <08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A6D211FB8B
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
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 24, 2024 at 07:23:20AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/24 03:02, David Sterba 写道:
> > On Wed, Oct 23, 2024 at 05:08:51PM +1030, Qu Wenruo wrote:
> >> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> >> +		ret = btrfs_reconfigure(fc);
> >
> > This gives me a warning (gcc 13.3.0):
> >
> > fs/btrfs/super.c: In function ‘btrfs_reconfigure_for_mount’:
> > fs/btrfs/super.c:2011:56: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
> >   2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> >        |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >
> >
> Weird, my local patch/branch shows no fc->oldapi usage, thus no warning.
> 
> The involved lines are:
> 
> -	ret = btrfs_reconfigure(fc);
> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> +		ret = btrfs_reconfigure(fc);
> 
> Thus no warning.

This was caused on my side. The patch does not apply cleanly on for-next
or my misc-next, I'm using wiggle to merge the changes and it for some
reason always adds the fc->oldapi to the conditions. Please refresh the
patch and resend, thanks.

