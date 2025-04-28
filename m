Return-Path: <linux-btrfs+bounces-13469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB61A9F42A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919B217C283
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620512798F0;
	Mon, 28 Apr 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cTtKMtNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kjpxUBpw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2Jqod5v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uooFdl5t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F152797AA
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853189; cv=none; b=HgNBG+yxdQ+FEmneR9B81RbJaJty+HjFKVA28VTFd+PaBjyM3SQzpj7SHi6v9XZhpeQYkzQQsnMH/qJ2a3wRNNE6d+t/w9Q4r5/0KFaANMLRFROle/Ih8V6pKj5E1XaIW70e9ntdnAMHjYE7sw99d0Ve7drVT2xuH3qDlIeUeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853189; c=relaxed/simple;
	bh=lPpm7tPcpb9I00CkrQ2nZV/mmlVTvgI7crPlimXA7KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar+xT51lhvH5XlkNCknKDtWepd2zxRcz01ReU7JzrDNvQ1pBvfneSc9VSUrXHzpETU9E2Mbp63/ZBXiNbKYzAVkgyz8BVcLbXd9XHGK/juyRnh7FytYuew2710XTc5xY4/epOC6sDETc3v72GheT0o7KuChZwJNR4pamM0apMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cTtKMtNg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kjpxUBpw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2Jqod5v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uooFdl5t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF9D91F38F;
	Mon, 28 Apr 2025 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745853185;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YsdQ6c0+TMp5rElKuRxF2xHkblO4+iiXB1aPOq7wlU=;
	b=cTtKMtNgTFpNw5iVBGP98UQhkcP8VRQPRUagfmrx5Dp9RTX/mS12a17lzU4guXFjwQ3/CJ
	G0IoTamKc+2z/V36sRxZECib+hwVMdMpCSiBF8aKnmWcVe8BeRA81m35g2MnskN2X8/AZP
	+VN+lY4atny416QK7id+7RCTeE0M9gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745853185;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YsdQ6c0+TMp5rElKuRxF2xHkblO4+iiXB1aPOq7wlU=;
	b=kjpxUBpway8H6r8ukiT9K6JOdzyQ1VzdFKOLbUGPhuvt3JyMcBHg45eGeo8G2kK2dw6DdU
	DIm/y1tJSYu7moAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745853184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YsdQ6c0+TMp5rElKuRxF2xHkblO4+iiXB1aPOq7wlU=;
	b=G2Jqod5vuAvtqqBlDQl51hyPv5mdb6kyLxJLxYJBAj8F26ltOzVvarhS+2Xx7J88AxYSYu
	gfyB2pw4mrhAzDrdEaGKDkjVludyqu7SM48d4nEiznEg0+efXi6VYvgQgIquM2rYMpRXaQ
	8NlMzSmE+SQSEKK7fuXDZqNhqP5m8lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745853184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YsdQ6c0+TMp5rElKuRxF2xHkblO4+iiXB1aPOq7wlU=;
	b=uooFdl5tkte8slvjFuNnBZtdSQyu9wvbxAeuAvj3mxBAh+itV9ePBOlWbiqLa3QuBZomWK
	z4gqCvIDl46KikAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F18613A25;
	Mon, 28 Apr 2025 15:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yWUrIgCbD2gEBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 28 Apr 2025 15:13:04 +0000
Date: Mon, 28 Apr 2025 17:12:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Implement warning for commit values exceeding 300
Message-ID: <20250428151259.GE7139@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250428044626.2371987-1-sawara04.o@gmail.com>
 <a95364ca-7903-4cbf-9f75-417fc0d26bbc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a95364ca-7903-4cbf-9f75-417fc0d26bbc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,btrfs.readthedocs.io:url,twin.jikos.cz:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Mon, Apr 28, 2025 at 03:06:14PM +0930, Qu Wenruo wrote:
> 在 2025/4/28 14:16, sawara04.o@gmail.com 写道:
> > From: Kyoji Ogasawara <sawara04.o@gmail.com>
> > 
> > The Btrfs documentation states that if the commit value is greater than 300
> > a warning should be issued. This commit implements that functionality.
> > For more details, visit:
> > https://btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-mount-options
> > 
> > Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> > ---
> >   fs/btrfs/fs.h    | 1 +
> >   fs/btrfs/super.c | 6 ++++++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index b572d6b9730b..f46fba127caa 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -285,6 +285,7 @@ enum {
> >   #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
> >   
> >   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> > +#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
> >   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> >   
> >   struct btrfs_dev_replace {
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index dc4fee519ca6..c6911e9f17f2 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -569,6 +569,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >   		break;
> >   	case Opt_commit_interval:
> >   		ctx->commit_interval = result.uint_32;
> > +		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
> > +			btrfs_warn(NULL,
> > +"commit=%u is considerably high (> %u). Large amount of data can be lost when the system crashes.",
> 
> I'd say the large commit value is not really going to cause a lot of 
> data on crash.
> It's really depending on the workload, e.g. if there no fs activity at 
> all for over 300s, there will be no data loss at all.
> 
> Furthermore, we do not really to scare users to use a super low value, 
> which will cause tons of unnecessary transactions and fragments the 
> filesystem with too many small extents (if data cow is enabled).
> 
> Another thing is, we do not even warn about more dangerous mount 
> options, like nobarrier, thus I'm not sure if we really want such a warning.
> 
> 
> At least I'd prefer a less scary warning, maybe just "Use with care"?

We used to have the warning there before the 6.8 mount option parser
rewrite and it got removed in 6941823cc87812 ("btrfs: remove old mount
API code") without being properly implemented in the new API.

The wording of the message was not alarming or scarying,
"excessive commit interval %u". The consequences of the large interval
could be data loss but this may not be suitable for the error message as
this is a corner case. I agree that 'use with care' (and read
documentation) would be reasonable.

Regarding nobarrier, there's a message "turning off barriers" printed in
btrfs_emit_options(), we can possibly enhance that too.

