Return-Path: <linux-btrfs+bounces-18941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ACEC56DF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C65F3AEAF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A821333733;
	Thu, 13 Nov 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OiT4ApBm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kA6xW0NW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VsPrGzYo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4zQoWY7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6E331A4A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029951; cv=none; b=KsW0pFHhyaUI87xH3/WEVemQvvbasHi8BPsPUtd5XD+Uxn0WvRBtG3tPF63FXyPAzXzvbtBE1mL6gDgtcbL/7Yfxu5I8YNbE4LBxVAHfzoZSVPJkm3T4GNA2ofhbp7LdT94qXrcHOHYh2O3PDB9C9odIRx4inc7U35lHcVfBLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029951; c=relaxed/simple;
	bh=XXg7zvEVCUA6WJIKEoR9ndUaZhbRnnfzYM+eJk4mMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaiVvOfcMhhxH+t95qCaV2+aM4DXtkDhKNZgC1Pp4maRacjytTzzu6ciVOvHsqbpURrKnannMjCWQNmMf0dVf9APSoO+FoPeo9TDyZ2H0E3B/GauzeYLn+iP+03U3boEkf9hO9leuzJ+E55fdQFvKU8uv6Dr9/zTzIxP4VgW794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OiT4ApBm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kA6xW0NW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VsPrGzYo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4zQoWY7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6388421901;
	Thu, 13 Nov 2025 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763029948;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df1OGZgnkcQCa7seuH+FqZ/psVxc1q+UY+3VhONCvIs=;
	b=OiT4ApBmLDm7hE82v2EfQVPD3IDbxN9+KfBFNofKo+nmx+8eJYsW0dLLnLfFsJQTWGMick
	m4V8UQys+NBSa2ztfL4g4fj9VXLj8ng9T6aFVt9OwDzjswml2lFPNO9p/GZW9yKgGeT40w
	mNIlA4Y9+xG4BSabxv+baZJmLfbY8GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763029948;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df1OGZgnkcQCa7seuH+FqZ/psVxc1q+UY+3VhONCvIs=;
	b=kA6xW0NWKLwcYhT2NX6VyfBIhRztJnwxAKXoVHcsoRrtwEk4X8ZlZ1Jw8UPQ57m4f0BHuG
	j+nZ0wbobmMnjoCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763029947;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df1OGZgnkcQCa7seuH+FqZ/psVxc1q+UY+3VhONCvIs=;
	b=VsPrGzYocW8IZp8r7GsDqnFjN9TTiR4XQEIZMOEmu727v5KITk0evkorPxlEWRAQ8VatY8
	Qm18pt0q1tlMu4UkHtLBw68DhwVb1Oyr3+9RTPO5EtVWFd3+4/uoiXl7FgkiFbXN3AfPka
	yV8E4d42e+uqKWN/4LkhdZMRZYw8Lx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763029947;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=df1OGZgnkcQCa7seuH+FqZ/psVxc1q+UY+3VhONCvIs=;
	b=B4zQoWY7lVg5rOBZGfw0B4vBDhbspzfqB9NmZS0mYIFPHB2SvFM92LWiKeoJMsd7G5oZDu
	2RVKIcAFN/Yta5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BAF03EA62;
	Thu, 13 Nov 2025 10:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vd5XEruzFWnnMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 10:32:27 +0000
Date: Thu, 13 Nov 2025 11:32:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] btrfs: set the appropriate free space settings in
 reconfigure
Message-ID: <20251113103222.GL13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-9-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112193611.2536093-9-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Nov 12, 2025 at 08:36:08PM +0100, Daniel Vacek wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> btrfs/330 uncovered a problem where we were accidentally turning off the
> free space tree when we do the transition from ro->rw.  This happens
> because we don't update

Missing text.

