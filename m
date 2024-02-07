Return-Path: <linux-btrfs+bounces-2206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57CE84C755
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 10:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B47285276
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B6210EC;
	Wed,  7 Feb 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIB7aK/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvRvqsKw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIB7aK/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvRvqsKw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A820DCC;
	Wed,  7 Feb 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298155; cv=none; b=mWJQNuN00s6Lcbr66uNRRWcj+cK7xrdIk32y8XMdu9E1kveQ05cEPgPJv9qPBk4h67X8YIha616NV3hemxC5oMXTzLIQedVtN8SsODo4u0c0m2zWDdo8VAstDMX36Gpeh2ztvqR2vcv6Ag7P63gTGRDOmDAJG/zCK1XW+ceGSFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298155; c=relaxed/simple;
	bh=BSpbDEGla8yFVzZ/7Tb68EsfG0vMuchD8yhMhM6JZCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnCwVByHoOt8lPUl6yrtq3FS0lxcPYMVfxLIy5KdiLl5Ff0Qqg3mvM803tOh5Ve+hg+cbIh+N4VVZ7edA0j1y65yfVZjHmBRtoQWHQIHPypgO1bEtu59t9p7AB5p4OARUj2pHYfe+Z2jWZEPO7STSEfkH58dUuaIW78PAWZuo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIB7aK/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvRvqsKw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIB7aK/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvRvqsKw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 895941FBDB;
	Wed,  7 Feb 2024 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPGWWRLTg4wY6ueoJqpuqj+n7m2fW14x2QoQAgP/LrM=;
	b=GIB7aK/s40bBHMeg0niYb/GGICjLRNOVUycCy0NtxYsMteXggojQ0J876cAxSDGr9SU/VA
	hIdyBU1qS6lojoHmjhrYda2q6yyY2y6bYt11weVQKbq+/utj7TGOW3iDPrSMGKpfLdQWW6
	ajRx2kpqRBMM7wN7Bkmh2ARuZdmOj98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPGWWRLTg4wY6ueoJqpuqj+n7m2fW14x2QoQAgP/LrM=;
	b=cvRvqsKwSgTmPUXvPMIk1T51PzFuOUUpU+bRus7snThpGHufhycErAAnGZfOoxKU+ZMdbo
	tKmdVINVUhyBNrDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPGWWRLTg4wY6ueoJqpuqj+n7m2fW14x2QoQAgP/LrM=;
	b=GIB7aK/s40bBHMeg0niYb/GGICjLRNOVUycCy0NtxYsMteXggojQ0J876cAxSDGr9SU/VA
	hIdyBU1qS6lojoHmjhrYda2q6yyY2y6bYt11weVQKbq+/utj7TGOW3iDPrSMGKpfLdQWW6
	ajRx2kpqRBMM7wN7Bkmh2ARuZdmOj98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPGWWRLTg4wY6ueoJqpuqj+n7m2fW14x2QoQAgP/LrM=;
	b=cvRvqsKwSgTmPUXvPMIk1T51PzFuOUUpU+bRus7snThpGHufhycErAAnGZfOoxKU+ZMdbo
	tKmdVINVUhyBNrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6504F13A41;
	Wed,  7 Feb 2024 09:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AIlVF2dNw2UWUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Feb 2024 09:29:11 +0000
Date: Wed, 7 Feb 2024 10:28:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: always scan a single device when mounted
Message-ID: <20240207092837.GT355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240205174340.30327-1-dsterba@suse.com>
 <ZcLM+2mtKFaVUFsF@devvm12410.ftw0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcLM+2mtKFaVUFsF@devvm12410.ftw0.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="GIB7aK/s";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cvRvqsKw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[28.99%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 895941FBDB
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 04:21:15PM -0800, Boris Burkov wrote:
> On Mon, Feb 05, 2024 at 06:43:39PM +0100, David Sterba wrote:
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -738,6 +738,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >  	bool same_fsid_diff_dev = false;
> >  	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
> >  		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> > +	bool can_create_new = *new_device_added;
> 
> It took me quite a while to figure out all the intended logic with the
> now in/out parameter. I think it's probably too cute? Why not just add
> another parameter "can_create_new_device"? I think it feels kind of
> weird on the caller side too, to set "new_device_added" to true, but
> then still rely on it to actually get set to true.
> 
> Once I got past this, the logic made sense, so definitely don't block
> yourself on this nit.

I had the separate parameter for the debugging version and removed for
the final but I agree that it makes things less clear. Also there's
something wrong with the device matching so the meaning of the parameter
will be unchanged.

