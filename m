Return-Path: <linux-btrfs+bounces-8952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69A99FD13
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 02:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538592845F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 00:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8067494;
	Wed, 16 Oct 2024 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rr3llLDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="madFG0LA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rr3llLDU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="madFG0LA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE821E3CD
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038334; cv=none; b=rg27DctzZB9vdh3j4xruZviyz57CRr2ehpwo7h5v4dGjO8E4Nx5+Lfys5NbIlZDF3S0bEfK4DIdbRiRtcZZ6+TC41fwx2sIe0iTLvzHaYW8KcWWV0Grak3T4kx5+0h3TWkwLAfcPTGcRvAjnoEslEZ0tAdgCknU6twtT1xS0Z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038334; c=relaxed/simple;
	bh=c7lhTgvGiHb/2HwVwNVsfIuHDrwwDIct7ltqv8UaHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcl9+i9po+N9cOPWM1zDpPcmSs47TICvgfbq11qmSrabSrdVfraoZB8Qeql+u2VRm78QEllh9vSiO5lABHothp84Dv90vn2Y+5uS9Nnagih5c+ktBO/E2/vbgxPLs8YvascIZgFzvw9HSbFR6SxKG6tgM0Vr4FrO/qxczfa35Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rr3llLDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=madFG0LA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rr3llLDU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=madFG0LA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F4CB21B68;
	Wed, 16 Oct 2024 00:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729038330;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jYDe9UqIC2fMkVI8et8OpK753RTIgwmcBiYIqlgbRE=;
	b=Rr3llLDUOSgnau11n//Q9yFFni+YYA0lHa2asgV9siACvgooQEbe4LaI0jFncB/J4acmOP
	OVukZn70n6M8KhOsmDX0UVg4qh2n0QeWnIN3f98gY4GkJmDkmtMgj7wqpMHNhyC8le4eaa
	4a55faPsZGu/0Nht9EcdjEOSY9Zr0Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729038330;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jYDe9UqIC2fMkVI8et8OpK753RTIgwmcBiYIqlgbRE=;
	b=madFG0LACfIngmTxdtvUECmxOew7lK1TesPBYG/86RI3qDLGnxpXIzY+CmUJFZElCedj0K
	txDMV21C4FdUDNAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729038330;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jYDe9UqIC2fMkVI8et8OpK753RTIgwmcBiYIqlgbRE=;
	b=Rr3llLDUOSgnau11n//Q9yFFni+YYA0lHa2asgV9siACvgooQEbe4LaI0jFncB/J4acmOP
	OVukZn70n6M8KhOsmDX0UVg4qh2n0QeWnIN3f98gY4GkJmDkmtMgj7wqpMHNhyC8le4eaa
	4a55faPsZGu/0Nht9EcdjEOSY9Zr0Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729038330;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/jYDe9UqIC2fMkVI8et8OpK753RTIgwmcBiYIqlgbRE=;
	b=madFG0LACfIngmTxdtvUECmxOew7lK1TesPBYG/86RI3qDLGnxpXIzY+CmUJFZElCedj0K
	txDMV21C4FdUDNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68D2C13433;
	Wed, 16 Oct 2024 00:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lsJXGfoHD2dhJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 00:25:30 +0000
Date: Wed, 16 Oct 2024 02:25:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: try to search for data csums in commit root
Message-ID: <20241016002525.GM1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <01721e6680b4a05c06cea8afc98b1726102ba5f5.1728947030.git.boris@bur.io>
 <20241015154320.GI1609@twin.jikos.cz>
 <20241015180144.GA1731591@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015180144.GA1731591@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.927];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -3.99
X-Spam-Flag: NO

On Tue, Oct 15, 2024 at 11:01:44AM -0700, Boris Burkov wrote:
> > > +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	1U << (BIO_FLAG_LAST + 1)
> > 
> > All expressions in macros should be in ( ), namelly when there's a
> > potential for operator precedence change like with "<<" after the macro
> > is expanded in some code.
> > 
> > > +#define BTRFS_BIO_PRIVATE_FLAG_MASK	(BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT)
> > 
> > Do you plan to add more such flags to private? This looks line one level
> > more of abstraction than we need for this optimization. This could be
> > simply used as BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT. And for that
> > reason the helpers do not need to sound generic that it manipulates
> > 'private', the names can be btrfs_bio_set_csum_search_commit_root(),
> > which is IMHO expressing the same semantics.
> 
> I don't plan to add any more btrfs private bio flags. I made the
> judgment that doing it generically with checking (particularly for the
> important and explicit clear before submit) was better than the one off,
> because it made what was being done as clear as possible. It's still not
> perfectly clear, because of the whole "private flags" name not being
> perfect.
> 
> Since there is only one user, I totally see the argument for just doing
> it as a one-off. Would you like me to rewrite it to
> btrfs_bio_set_csum_search_commit_root?

Yes please, make it specific for the csum search root. Making it generic
works when we have at least two, in use or soon to be used, but as you
say no plans for more so it's best to keep it suitable what we need now.
If it is for any reason needaed in the future we know how to extend the
interface, so no big deal.

