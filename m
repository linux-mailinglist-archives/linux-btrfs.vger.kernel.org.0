Return-Path: <linux-btrfs+bounces-11346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EE3A2CD04
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7548B3AC17B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46716194C8B;
	Fri,  7 Feb 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXJ8RwuQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bVMrWIya";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hy+xicQK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rKZ+9JxX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9F23C8CB
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957558; cv=none; b=KSjLPaWH16RK2oCQAp9dguJwErprJ2y2bIiBk0H0t/BcE88+t8BbQf50LsOJihGwHW3dua/lKD8VUk82vJgNjnWIv5beagF+55/4Xw5qP0TrXk0FfFKU+YzTU5eZaGCtwnJ2+IFBsfBnloFp6auN38vCchf7FmvRjsXeY0+G7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957558; c=relaxed/simple;
	bh=NAOgwB30ezZyWtBGkitjsLxYfL9E0pLWY29HIIMWLHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyJn61dLaCD8XMkngtkdV3pd0KkjhNyZcaA/Znjjt6WMnZIJ/SQc4zOwdfOvhn7Ny6oMoQatSeO22t4svReE3nrioWV4HgJC6hoRVkpMxyeghe7GI8kkqQgXDCUQBYSs6+1N2Jic+G6zUxsY0Tnbf+dtQfOzdSMWnxTVleI12nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eXJ8RwuQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bVMrWIya; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hy+xicQK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rKZ+9JxX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA5C82116E;
	Fri,  7 Feb 2025 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738957554;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxI7VlnnerRgqXueLehA2Fmvd0x+0cicmrPt/afbtbE=;
	b=eXJ8RwuQtPCsuxtg96hwrA46ZSK3gpNQd54P+jLimN9fW4PCAzohvENIyEthoE38esVrRU
	IW+OgJB2QpBzM6lV9285nEclBzxg7VjOMyv3okkP9Y5D8ZtlrOM8kkllFZcemHIN6c/gqN
	Z6eZ9/PWx8WMUAh4/VMgL9lv6IaF4pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738957554;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxI7VlnnerRgqXueLehA2Fmvd0x+0cicmrPt/afbtbE=;
	b=bVMrWIyaXmKCPQI+9C41zjcI2o94RXGcFVj7KQcr47ZnXMteu+c06JVjAZenuOx5u+lCZE
	o7f7Cm9fExbf6MCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hy+xicQK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rKZ+9JxX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738957553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxI7VlnnerRgqXueLehA2Fmvd0x+0cicmrPt/afbtbE=;
	b=Hy+xicQKnsdOtKWw2/5m0OHEtgItjO1kLmjohu0J9CXxZEcObfPXjuPR9/LLTelDjBDu0K
	TfxhpjHRnj3wx/KK/TIAsCI96NRhcSbuh+1B5HlJT8mrm5DuuYxy3rFdADeGG2JmoQGJBK
	mUUgm+xovfhDvts9eXvL43ZdmZntLT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738957553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxI7VlnnerRgqXueLehA2Fmvd0x+0cicmrPt/afbtbE=;
	b=rKZ+9JxXXJ82bUx5cDko3LTFBKsSY35MnUdteHJGMy6tbqR4js3fyO5/H5FRWQofdQB1Dg
	BcuhcS/ARGEsFCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3EFB13694;
	Fri,  7 Feb 2025 19:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id onEsM/Fipmd5FwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 07 Feb 2025 19:45:53 +0000
Date: Fri, 7 Feb 2025 20:45:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: scrub: add the new --limit option to set
 the throughput limit at runtime
Message-ID: <20250207194548.GO5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5fd8e0787ea103687fe1a04e96ff8f127fb538f4.1738816581.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd8e0787ea103687fe1a04e96ff8f127fb538f4.1738816581.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: EA5C82116E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Feb 06, 2025 at 03:06:59PM +1030, Qu Wenruo wrote:
> Add a new option `--limit <throughput_limit>` to `btrfs scrub start`.
> 
> This has some extra behavior differences compared to `btrfs scrub limit`:
> 
> - Only set the value for the involved scrub device(s)
>   If it's a full fs scrub, it will be the same as
>   `btrfs scrub limit -a -l <value>`.
>   If it's a single device, it will bt the same as
>   `btrfs scrub limit -d <devid> -l <value>`.
> 
> - Automatically revert to the old limit after scrub is finished
> 
> - It only needs one single command line to set the limit
> 
> Issue: #943
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> RFC->v1:
> - Use longer option '--limit' instead
> - Update the docs and helper strings
> - Save and revert to the older limit values after scrub is finished

Acked in the github pull request, thanks.

