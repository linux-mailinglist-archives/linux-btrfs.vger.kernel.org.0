Return-Path: <linux-btrfs+bounces-16912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E8B82B2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 05:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01556264F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CFD217F3D;
	Thu, 18 Sep 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AwpyVRME";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEUsWWZo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0H2P3Nkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4LGMlN+F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9F3D984
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164498; cv=none; b=TryWg4lxRKvq4lWufHF4bFhkENFN6E8qF2exz81rBljTjH4zXH97O01ps83PMftPflUD3Ze5rzinOCYO+/A6kOp7GXRyIE8Y2TFDYTCe0putCTF8SqeK7x9GO7duqZbrp+byk+aAe4mK9mNKHqGxZIZKZ3rlnmbkKhuJs0loMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164498; c=relaxed/simple;
	bh=tojGWuw5WpZEoIaAym/jqtFsweVmoCnfIuKLxEO99VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrh9oaJWkwvnF5JBVv6N+pSD7aKusVtm+M24/Di5fU3T4G9RxHebbHM6tajiATkzwE5Xibvvwmy7nmCmZQJlNBYOUrL5UpVxfXRJscl5GENfD1d8v0Vnmm9AYRq3UdOHhpSPHW9/QKwDI3uFPCofEUpN3+gijNhxVv0tsJMEW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AwpyVRME; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEUsWWZo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0H2P3Nkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4LGMlN+F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 160F81F452;
	Thu, 18 Sep 2025 03:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758164494;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XfCfW7CHtEvq5WrXqNXlCs/jvHCIVv4rHpYeY3suEdA=;
	b=AwpyVRMEvjZGVt/KUU/yc/qMo9talCbfQdCqRq9JSJ/Efn37K9WTe8HQraV3ACEdLxOMx/
	/FBFfdD/6sMQbRfM+ytv0TlTW2EBW1J2lyLwj1V1vvs8CHHvbYnSnjtw2TxZaQjeBUJkS3
	rj1hNuW3x04NcuwPLElMilgViQAkCDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758164494;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XfCfW7CHtEvq5WrXqNXlCs/jvHCIVv4rHpYeY3suEdA=;
	b=MEUsWWZokvEu8psaLxga7cmKJRRVEwvv0kTgwmM1vqXWci+/hGXOqD+V/nQEtUXNVFkw+W
	Cd+T4f3p1VeEFtBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758164493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XfCfW7CHtEvq5WrXqNXlCs/jvHCIVv4rHpYeY3suEdA=;
	b=0H2P3Nkhki8MSz1j8vQHPNVpcrTpVBFL+iDsFaNp6tz9Lo9mU3eq0/yz20knMGaTd+j+t/
	4eHIbu7n+tr5JsQxw4S378wm3Gk0+6SCODPBb47OfDKIV9dlCVtSWXwr8rWP/1G6sCjHTh
	tGbH4skXxaEOXnmY+nt3PF3JjqD+T3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758164493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XfCfW7CHtEvq5WrXqNXlCs/jvHCIVv4rHpYeY3suEdA=;
	b=4LGMlN+F8Ky+marqa/Rd/BUSJjX8NpAH/8HjFNKgQu7qwusXjIrlX4Eclv3/qxAO0Ngngn
	NnacThGIJ4tkEQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B46613A39;
	Thu, 18 Sep 2025 03:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wq2SAg12y2gPZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Sep 2025 03:01:33 +0000
Date: Thu, 18 Sep 2025 05:01:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject invalid compression level
Message-ID: <20250918030131.GI5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3aa4ab3069efeb71fa0197430e91df74139ebfa3.1756117561.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa4ab3069efeb71fa0197430e91df74139ebfa3.1756117561.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Mon, Aug 25, 2025 at 07:56:26PM +0930, Qu Wenruo wrote:
> Inspired by recent changes to compression level parsing by Calvin Owens,
> it turns out that we do not do any extra validation for compression
> level, thus allowing things like "compress=lzo:invalid" to be accepted
> without extra warning or whatever.
> 
> Although we accept levels that are beyond the supported algorithm
> ranges, accepting completely invalid levels are beyond sanity.
> 
> Fix the too loose checks for compression level, by doing proper error
> handling of kstrtoint(), so that we will reject not only too large
> values (beyond int range) but also completely insane levels like
> "lzo:invalid".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> +	btrfs_err(NULL, "failed to parse compression option '%s': %d", string, ret);

I don't see how printing the %d/ret improves the error message, there
will be probably ERANGE or EINVAL.

