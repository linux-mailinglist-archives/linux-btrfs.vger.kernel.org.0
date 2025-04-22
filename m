Return-Path: <linux-btrfs+bounces-13223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 697FCA9688B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 14:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973AF17C4BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751C27CB1F;
	Tue, 22 Apr 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCWM9YmN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pftYxwJu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCWM9YmN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pftYxwJu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D60151985
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323586; cv=none; b=C5CK1E34xRfr9r2z3iW83Qs6EjnLnQxUoDT94eioZ1o9epBITwmzq4+amxngxgkymH6lrmlNsWrs00z8fSiedV9WE0FaYbPjwks9SntyvlKLh2kD0my7dyEIGiO0WK31C/r6sc/l7XFVbJIh5PWYLH/X8HO3s+2J0yuRdTt2McA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323586; c=relaxed/simple;
	bh=3pI5jE4jsfdVhHTSNMGRbTKhEiFB6BV+nUZSrJNKoOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmN1wAVlFj+RyKQvpda6+j73Xq+/7Lj1XyKvVoTpXWqus0o5kYpcxGAdha72X6hCRyE2MLiK5k9DjcLnvET4T6mn4hvr4Q5fcc+lG7lD+ecpXnd1vsZZ0dsHNpSSZUOwSRyCJDXiSro9l38wWRDOFKbwqmZnsZSm81C8mLzL4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCWM9YmN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pftYxwJu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCWM9YmN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pftYxwJu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13491211B8;
	Tue, 22 Apr 2025 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745323583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLYOaXr8/2vpVvfCxK60moi1fm1oxB9FqcqMCssoWXo=;
	b=sCWM9YmNG12psWKvN38nxyEtk64ZRM0FaBQcRLA2B4A5cSZ8Isd49FqTmMfaSu3TFVfvDF
	Uqn7WEjuGhyv2pJZs3DcrK55NRCv4Ntc34HJv8TAkTD2YnY/vaHcISG47idR6toOo5uYwH
	auKSSfMtgOmrDm2u03H8hdAm461Kqwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745323583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLYOaXr8/2vpVvfCxK60moi1fm1oxB9FqcqMCssoWXo=;
	b=pftYxwJuGUrQwSVSMb5pGsMVO1s+MuascqJ5mjCpz2spaSKhLOYjMYw/sCerv2bfJVL61I
	AyYEHxMkEEc1bFDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sCWM9YmN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pftYxwJu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745323583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLYOaXr8/2vpVvfCxK60moi1fm1oxB9FqcqMCssoWXo=;
	b=sCWM9YmNG12psWKvN38nxyEtk64ZRM0FaBQcRLA2B4A5cSZ8Isd49FqTmMfaSu3TFVfvDF
	Uqn7WEjuGhyv2pJZs3DcrK55NRCv4Ntc34HJv8TAkTD2YnY/vaHcISG47idR6toOo5uYwH
	auKSSfMtgOmrDm2u03H8hdAm461Kqwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745323583;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLYOaXr8/2vpVvfCxK60moi1fm1oxB9FqcqMCssoWXo=;
	b=pftYxwJuGUrQwSVSMb5pGsMVO1s+MuascqJ5mjCpz2spaSKhLOYjMYw/sCerv2bfJVL61I
	AyYEHxMkEEc1bFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDF0F13A9E;
	Tue, 22 Apr 2025 12:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xg/gOT6GB2idGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Apr 2025 12:06:22 +0000
Date: Tue, 22 Apr 2025 14:06:21 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] btrfs: convert ASSERT(0) to DEBUG_WARN()
Message-ID: <20250422120621.GE3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744881159.git.dsterba@suse.com>
 <ff06b32f979859dbf499bd46d0c7a9464c9c86db.1744881160.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff06b32f979859dbf499bd46d0c7a9464c9c86db.1744881160.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 13491211B8
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Apr 17, 2025 at 11:17:03AM +0200, David Sterba wrote:
> The use of ASSERT(0) is maybe useful for some cases but more like a
> notice for developers. Assertions can be compiled in independently so
> convert it to a debugging helper.
> 
> The difference is that it's just a warning and will not end up in BUG().
> All the cases need a review and possibly be modified:
> 
> - delete it completely if the purpose is not clear
> - replace/update by proper error handling
> - replace by verbose error and BUG()/transaction abort if continuation
>   is not possible at all
> - use DEBUG_WARN()

I've kept only the cases that do ASSERT(0) and error handling, there are
remaining cases for the impossible conditions like unkonwn delayed ref
actions etc, this will need the conversion to the error handling first.

