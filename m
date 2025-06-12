Return-Path: <linux-btrfs+bounces-14629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93549AD75FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B950E7B357F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA12D543A;
	Thu, 12 Jun 2025 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeeCKjZQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nam/V4ck";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WCOOz/8G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ihi8Z1kM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926B29A327
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741545; cv=none; b=B+7EVqazPT6Azy4cNZnO7Ot0MqMROVBOt64FKQkamKZPj5IKl017cOtInm2JIA8PDKVb6WbyfTzSBUjSV577ZklYLo6vfytgG+qbZXdBmm2ED5GK5KaRFT7ckCQgzb6ZwYWMvYrlC1KnDugBUBQkYDTzzywn2fxC1EuKJ4Bvxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741545; c=relaxed/simple;
	bh=hredmp1gq53XGfzfOOANLN3abqlJ6ooEsfxytDqfW8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6f0agknYw6X26O5GJ6z2qhVW7Ul8Dtou/jiBC835dxhRiaVnZOk3QZqOa+Ukpp3L4LdHm3hKDXKHD8YVrd0SCpPKLlR/VICLFhV9YWLkgZ4TMl9YNJLePdRNe1L/ljlJi/zYYAP8lxHpmV2387Imea1UBAlpj/FYNcpAc8xfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeeCKjZQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nam/V4ck; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WCOOz/8G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ihi8Z1kM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B213D219CD;
	Thu, 12 Jun 2025 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749741542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnsifuXamSpD0/0oot88ELgCsTj5itLPtPGx9RDn5Z4=;
	b=UeeCKjZQqL2YRSazl8jzuS9C4uFgFc3BwtbKE2ih1lMhsdba2/HB55Q34/7reLwiFimnWJ
	TSIqjZYnIakxvcq1pcr1WP0AjOpIzd9JuXdoNmMWoYQ3ftC5A6R8OOUPMbgQM+AEUzCUy2
	E3dajvTHoDUvAjYONe2Un14jbencC3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749741542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnsifuXamSpD0/0oot88ELgCsTj5itLPtPGx9RDn5Z4=;
	b=nam/V4ckxM32n5hkeK85TM1X2dm1dApzphSbGDk1g190nDt9pH1WhSEAcbmbiH/A3OKrP8
	ZnYGtNF3LDu+kFCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="WCOOz/8G";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ihi8Z1kM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749741540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnsifuXamSpD0/0oot88ELgCsTj5itLPtPGx9RDn5Z4=;
	b=WCOOz/8G38jQagO20pe/FT14Y2Rodsm0r+BIca+/CbKCI5uOzTIumQm+fmJteaY5Ln+9d3
	UUpKVD6o6z6N9sbbT/cwkRs0W/BRnvHCkHH6AHMZjWOg2mpQ0IRmrRTOZQwvlW5kylUqRF
	h8JOOdLjOqeH3m6mr/rUJDh9c37/rjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749741540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnsifuXamSpD0/0oot88ELgCsTj5itLPtPGx9RDn5Z4=;
	b=ihi8Z1kMH9isFJyOOKIRMTzlc2yvAfO7lOsmj5guPZBzk6fBgQ0NxG4rP3mEFyo/y1BYKg
	jrOt+pKuC1zHEfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E715139E2;
	Thu, 12 Jun 2025 15:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +wOHIuTvSmiJKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 12 Jun 2025 15:19:00 +0000
Date: Thu, 12 Jun 2025 17:18:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: harden parsing of compress mount options
Message-ID: <20250612151851.GD4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250602155320.1854888-1-neelx@suse.com>
 <20250602155320.1854888-3-neelx@suse.com>
 <20250602172904.GE4037@twin.jikos.cz>
 <CAPjX3FdyMGKGFch-k=CmOD7wP_as_iaB9hmnbbui5=off+m+iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdyMGKGFch-k=CmOD7wP_as_iaB9hmnbbui5=off+m+iQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B213D219CD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Thu, Jun 12, 2025 at 03:29:21PM +0200, Daniel Vacek wrote:
> On Mon, 2 Jun 2025 at 19:29, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Jun 02, 2025 at 05:53:19PM +0200, Daniel Vacek wrote:
> > > Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
> > > options with any random suffix.
> > >
> > > Fix that by explicitly checking the end of the strings.
> > >
> > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > ---
> > > v3 changes: Split into two patches to ease backporting,
> > >             no functional changes.
> > >
> > >  fs/btrfs/super.c | 26 +++++++++++++++++++-------
> > >  1 file changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > index 6291ab45ab2a5..4510c5f7a785e 100644
> > > --- a/fs/btrfs/super.c
> > > +++ b/fs/btrfs/super.c
> > > @@ -270,9 +270,20 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
> > >       return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
> > >  }
> > >
> > > +static bool btrfs_match_compress_type(char *string, char *type, bool may_have_level)
> >
> > const also here, string, type
> >
> > > +{
> > > +     int len = strlen(type);
> > > +
> > > +     return strncmp(string, type, len) == 0 &&
> > > +             ((may_have_level && string[len] == ':') ||
> > > +                                 string[len] == '\0');
> > > +}
> > > +
> > >  static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
> > >                               struct fs_parameter *param, int opt)
> > >  {
> > > +     char *string = param->string;
> >
> > and here
> 
> Can be done at merge time. Or do you want a re-send?

No resend needed, I updated the patch in for-next. This was to let you
know so that I don't need to fix it in future patches.

