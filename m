Return-Path: <linux-btrfs+bounces-7677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D3D96530F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20651F2323E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 22:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5211BDA90;
	Thu, 29 Aug 2024 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sTsdx4n2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DbS1JJQ2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oAGCLE6j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LjBcbR0U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356F1BCA04
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970914; cv=none; b=WG6nHvuv0JpT0Rt4qAoibt55WDv7wj+1CRdg0oSBygkrcuH3q0G8LfAjrWEn4D3NeaOzUhZuEK8PsUlkWrAK4BkVakegpcpUNoHYzdjDpWb5mDjhSwNo7xkcq8NOmwFr3sD5KghapVwy1p7FxX4nYyfJt6jjsA3uUKHhKzM8cqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970914; c=relaxed/simple;
	bh=UN61y3awP1+1bm02ph0eHKMSf2dTaS7aLOgHBaYN6Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIBvrI+iWoIaRUh80fwhfkOADs9kfaVD0muIoAX8nagZdp6ryfx6mbSeCHz/8rpnAliOakj1W3H1kjtSPdRx4QC/49i+wcdoXT2MOJBXQT4qPq3YQlV6/OyhoSLDYxCo+YA4oyK83Iez59VccoUDUaqAuyad4tf+NK9zWx+v94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sTsdx4n2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DbS1JJQ2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oAGCLE6j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LjBcbR0U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF741219C6;
	Thu, 29 Aug 2024 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724970911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IIt5FAbN0NwLvMJB0WPReQjKAPA7i3uqbLG/Gc67DY=;
	b=sTsdx4n2xsLG/7pL5ipI5n+OOhKF7hcuUFWozrPaV052rr+5hOodGikgYVg2/jhtw4OlLV
	a5JWNQe0nyoG3Ab/0WQlcubQoPXkP45vSzaT3y34oxtvJvYytPPJIpwvAzMCpAaGGZayKc
	Sh4bWztdRTO2q+Vp4ueSMtxxFpESx58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724970911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IIt5FAbN0NwLvMJB0WPReQjKAPA7i3uqbLG/Gc67DY=;
	b=DbS1JJQ2pgf+ULGJ8BgRv4+anQoi6h9RoLQImQZjF7SJUmGoLIS2toI+rUSqCFaMJeb/e7
	x+Ia9p0wRnz19RDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oAGCLE6j;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LjBcbR0U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724970910;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IIt5FAbN0NwLvMJB0WPReQjKAPA7i3uqbLG/Gc67DY=;
	b=oAGCLE6jHhCJqr7DmJUMcRFMtnGD55dA13T6G/I0Nh1s1GCD/l6/QLJ583odpn2tdylBLz
	POlUdlI9CIgmKPWF/4I9kl6TPtz8wHU9sgdLI1jbAXF2NweEO7ghOXULrlHMC6maobe0bi
	qfOSOdL+hbntFKbbA/zuMjgU/uADD8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724970910;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IIt5FAbN0NwLvMJB0WPReQjKAPA7i3uqbLG/Gc67DY=;
	b=LjBcbR0U8Dgx+MGm/irsj4JjdZTT3mDIPh7AP9NCdCMzk3VL1ZQH3GMjKUqWN/XYex4MJl
	8IqsGUUS67aPBwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7CE913408;
	Thu, 29 Aug 2024 22:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H6xgLJ730Gb8WQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 22:35:10 +0000
Date: Fri, 30 Aug 2024 00:35:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Rolf Wentland <R.Wentland@gmx.de>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] btrfs: interrupt long running operations if the
 current process is freezing
Message-ID: <20240829223509.GR25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
 <20240829165948.GM25962@twin.jikos.cz>
 <a7aaf78c-4417-4f3e-b551-04b4898f1ba5@gmx.com>
 <20240829222343.GQ25962@twin.jikos.cz>
 <72fd0c93-a455-464a-9925-1ed8dc8eb6f8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72fd0c93-a455-464a-9925-1ed8dc8eb6f8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CF741219C6
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com,gmx.de];
	FREEMAIL_CC(0.00)[suse.cz,suse.com,vger.kernel.org,gmx.de,toxicpanda.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Aug 30, 2024 at 07:58:07AM +0930, Qu Wenruo wrote:
> >> And it's really user-space programs' job to determine if they can resume
> >> the work.
> >
> > Yes, but in this case this seems that it's suddenly changing behaviour
> > depending on freeze. And with this patch you change 6 operations while
> > the report was to fix fstrim.
> 
> If that's the concern I'm totally happy to only do it for fstrim.

Thanks. We can revisit adding more cancellation points to the other
operations later. I think scrub also does not work well with freezing
but at least scrub can be safely paused like we do in transaction
commit.

