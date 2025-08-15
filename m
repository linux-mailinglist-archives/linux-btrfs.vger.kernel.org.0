Return-Path: <linux-btrfs+bounces-16089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F5B28898
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3395C1C8050B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97A2882AF;
	Fri, 15 Aug 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7S7msM/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YfHs/ORY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNy/IlSE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vj3LeouP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBB285CB3
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298666; cv=none; b=pwV7AKMSY1FdksVz/wpGMIY93n/eTXWpu27lRniHgWggr5pIjaCVWYavwZrMXM4tjLfalVosuBhck3mWm0S7g8KR+/aerabza6IYR0iDmtjQSJSb5P/LmKhoi9CAQ7xn8YJ2Cfh4uMLo/OVFkC+YKltNi6kAqwx8C+LqrXbNAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298666; c=relaxed/simple;
	bh=mbFnDdA/Z2L6uc0J3mdksgrDnBqpHqHIzqXq9CMwJG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWSwz8DZi4FUyPRzWXbLm0yBK/gR3u0m83k78q71B6z4ua7arGHOmP+0vuC1A8F/ADb6rQPXGYZ2TfkQw2ALJ4w5M3BRLQj7oMYYEE/ElVlFlmhryH0DFSzda4b6FD6nT08ciZeuNPfwSdo0KG6K8D0ulU2PdEM2AF661VGfO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7S7msM/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YfHs/ORY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNy/IlSE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vj3LeouP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9ED3E218F3;
	Fri, 15 Aug 2025 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755298663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XagQaGlcbv27Kn6zWBIjkNXk5O3/Z4qId7XDKC+g6Kg=;
	b=O7S7msM/6AvoMDvEdQjGuMufiwFdeLblVMOUxS3KPONkRhZLK3YVQrkwgMk4N23uyoNcJY
	zvyLDRROainh/bjI9SebpoDU4xh9/IXbVhUreMC0AdQdhFUTLwY1pmbmf2LFeutNspXYxx
	0WuJA1blwEtOdgJVXE9SC04Crpyh8oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755298663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XagQaGlcbv27Kn6zWBIjkNXk5O3/Z4qId7XDKC+g6Kg=;
	b=YfHs/ORYkVpLFA3z2+YzLCpk/7t+UjAu28Bhhk7gpn4GCXUOME5tZYMixkTGXxQ0S113Gz
	ki65u9ridczOHYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755298662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XagQaGlcbv27Kn6zWBIjkNXk5O3/Z4qId7XDKC+g6Kg=;
	b=QNy/IlSEqU6lD18hvcWjWEuSz/EHzLYlEZ8PFRhYWPyYGVlyhBGf4IFJXjP8J/057RYO2P
	jgmtb2PjIoifTgIT9ABTBQ5vZK95ONH5DgoGBcbwYgQabtopxPZ/IWU67ZH6EQzgI4GYWU
	Wcg8WVq/gOLqVNB1WoqALCsmbsa0CU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755298662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XagQaGlcbv27Kn6zWBIjkNXk5O3/Z4qId7XDKC+g6Kg=;
	b=vj3LeouPFxVeJMCaeH3jJ17Jht9LtHLL6IpQefzfcdNflyldEqeEzQRYWcWYJil5XEUET8
	QnDP5SPiyS+GvyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 868141368C;
	Fri, 15 Aug 2025 22:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9nipIGa7n2imAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 Aug 2025 22:57:42 +0000
Date: Sat, 16 Aug 2025 00:57:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v4 1/3] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <20250815225733.GF22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250813125052.GC22430@twin.jikos.cz>
 <20250813174146.1159027-1-loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813174146.1159027-1-loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.50

On Wed, Aug 13, 2025 at 10:41:15AM -0700, Leo Martins wrote:
> On Wed, 13 Aug 2025 14:50:52 +0200 David Sterba <dsterba@suse.cz> wrote:
> > On Tue, Aug 12, 2025 at 04:04:39PM -0700, Leo Martins wrote:

> > >  config BTRFS_DEBUG
> > >  	bool "Btrfs debugging support"
> > > -	depends on BTRFS_FS
> > > +	depends on BTRFS_FS && STACKTRACE_SUPPORT
> > 
> > How does this work? If STACKTRACE_SUPPORT is not enabled then we can't
> > enable BTRFS_DEBUG?
> 
> That's correct, my understanding is that STACKTRACE_SUPPORT is something
> configured by different architectures based on whether or not they
> support stacktraces. Maybe it would be better to do something like
> 
> select REF_TRACKER if STACKTRACE_SUPPORT
> 
> so we can still use DEBUG on architectures that don't support stacktraces,
> though I can't imagine they would be very relevant.

I think we should not tie debug config option to some arch-specific
option, so the conditional seems right.

