Return-Path: <linux-btrfs+bounces-4624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A548B5E20
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18591C21C91
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988D782D7C;
	Mon, 29 Apr 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfoMJyhT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hpe+rqvu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="chZ6qOh7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bu4Impv3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CF8288C;
	Mon, 29 Apr 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405917; cv=none; b=Whv2U4aYnfZvn3UuAuqm1Bbcz4Hb/Y49uD0ukbPgIXKBZXjDZimtfBAbVzx/aE3s9Q2ld4eMHj7acoO8nPMPbEe6bPnBEO2MWHkmz6ivV3mjvOC0UmbSafNKkBqnnPpkKFsZl5wXbIcjVehnu1E1Bc53AFpvlZNfiHHc+TGkLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405917; c=relaxed/simple;
	bh=0dtLruAYZV6KTgK6oCHxihGqmk5kyrk3JepLK3jVrLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGkWRTAnR19MnSz9XS2I6OSmNbzvb9/VmzUb7r+dtXWFWEjD0wcIxAB6+cryrm0uWeDGO4g+hwkeyrrNL7wKudiTjaP3CfmEV7WWp8k5fY5MfsSIGn20FYL7pAwEJpdk4dCWryBKvRnk4TrV0POvCxqSSAaCUsscUxVToD9f2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfoMJyhT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hpe+rqvu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=chZ6qOh7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bu4Impv3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 173A8338E1;
	Mon, 29 Apr 2024 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714405914;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs8n39B636aCGnBLs2tpk9R7CDrfnoZ6vsvZXN9shG0=;
	b=yfoMJyhTnST81OIP/8TXJBbiiwEnUXVdimLLBtK9/xmheDwAsDoh1dXducmxbrbus/7vCQ
	86/IH7RrzMw9X89iDwkdI7BpoWnhTZVrhDrsXPVvR0dFJNxf1G/hIgzuJn+Kz0FVej3F8q
	EHO9xdMUwGSp6MWOnW9JtaYBvTLR/P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714405914;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs8n39B636aCGnBLs2tpk9R7CDrfnoZ6vsvZXN9shG0=;
	b=Hpe+rqvugK9hIfJC1Y3KgtEt30xrUBDziP1WAs5YKd2H2UKRJyg9xPIpE1ZfVOrLYbie5G
	rYRWTN9olBX9TaAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714405913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs8n39B636aCGnBLs2tpk9R7CDrfnoZ6vsvZXN9shG0=;
	b=chZ6qOh7fflVgwlDeVwBQ1ZC29JCCpl8MKe5AG1SQZuMAo1SmqEXvINAkca1JlDbJRfx7Q
	xY8sJAgl6u/b3w0i8KHRP/BjN51iB4q1TK1HzIyI5MX1Zu4Sz3UeDnMe4ShAW+ANlgdo73
	R87tLHma6gKQP9MQfmQ+oQGPUUTJeD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714405913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs8n39B636aCGnBLs2tpk9R7CDrfnoZ6vsvZXN9shG0=;
	b=Bu4Impv3QOAJuABD6QhWtfvp6vATiT3WuemOiQYS28a/0K/cYjhnKXbFFmdKcx6N+vhUTe
	o5m444j+zABJ4XBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E81B713A1D;
	Mon, 29 Apr 2024 15:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pjN+OBjCL2bkJgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 15:51:52 +0000
Date: Mon, 29 Apr 2024 17:44:35 +0200
From: David Sterba <dsterba@suse.cz>
To: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>, herbert@gondor.apana.org.au,
	clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org, qat-linux@intel.com, embg@meta.com,
	cyan@meta.com, brian.will@intel.com, weigang.li@intel.com
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20240429154435.GE2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <Zi+7CnWeF9+DUXpK@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi+7CnWeF9+DUXpK@gcabiddu-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Apr 29, 2024 at 04:21:46PM +0100, Cabiddu, Giovanni wrote:
> On Mon, Apr 29, 2024 at 09:56:45AM -0400, Josef Bacik wrote:
> > On Fri, Apr 26, 2024 at 11:54:29AM +0100, Giovanni Cabiddu wrote:
> > > From: Weigang Li <weigang.li@intel.com>
> > > 
> > > Add support for zlib compression and decompression through the acomp
> > > APIs.
> > > Input pages are added to an sg-list and sent to acomp in one request.
> > > Since acomp is asynchronous, the thread is put to sleep and then the CPU
> > > is freed up. Once compression is done, the acomp callback is triggered
> > > and the thread is woke up.
> > > 
> > > This patch doesn't change the BTRFS disk format, this means that files
> > > compressed by hardware engines can be de-compressed by the zlib software
> > > library, and vice versa.
> > > 
> > > Limitations:
> > >   * The implementation tries always to use an acomp even if only
> > >     zlib-deflate-scomp is present
> > >   * Acomp does not provide a way to support compression levels
> > 
> > That's a non-starter.  We can't just lie to the user about the compression level
> > that is being used.  If the user just does "-o compress=zlib" then you need to
> > update btrfs_compress_set_level() to figure out the compression level that acomp
> > is going to use and set that appropriately, so we can report to the user what is
> > actually being used.
> > 
> > Additionally if a user specifies a compression level you need to make sure we
> > don't do acomp if it doesn't match what acomp is going to do.
> Thanks for the feedback. We should then extend the acomp API to take the
> compression level.
> @Herbert, do you have any objection if we add the compression level to
> the acomp tfm and we add an API to set it? Example:
> 
>     tfm = crypto_alloc_acomp("deflate", 0, 0);
>     acomp_set_level(tfm, compression_level);
> 
> > Finally, for the normal code review, there's a bunch of things that need to be
> > fixed up before I take a closer look
> > 
> > - We don't use pr_(), we have btrfs specific printk helpers, please use those.
> > - We do 1 variable per line, fix up the variable declarations in your functions.
> I see that the code in fs/btrfs/zlib.c uses both pr_() and more than one
> variable per line. If we change it, will mixed style be a concern?

I have a work in progress to rework the messages in compression. The
messages with pr_() helpers are there for historical reasons and using
proper btrfs_info/... need extracting structures like fs_info from
various data. Josef's comment is valid but you can skip that for the QAT
series.

