Return-Path: <linux-btrfs+bounces-14253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43192AC4D05
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01892166F34
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09D257430;
	Tue, 27 May 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yL3bDy2s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZerhCA8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QUOjGdju";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IO1nwO+8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86E3C30
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748344656; cv=none; b=QzMxw+ybC4tR2LlndCSILfs3CBT5/ippXF98c63/gWTX+gSEFDCn/KLYK2Joppw+IjUMU4IAzm8W9M4hzTwu0+NKn3nIXY8FhuhHMrMS//SIZ5ZnazPG1FuTg98Ev2ZQYCmWGSkINAhDOmXNaR+tl933lW2fDWoKItFzJSLr+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748344656; c=relaxed/simple;
	bh=xJBfwGWVgpykkN08VrOCRjltZH0b2/J7yZx3V2nnygY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwRg7tWTETvTa5UlwgfOtOdw6QGh5O2mUbQf8oGYXKX3B+uSwWbJpDsFfdULYR7PgJQ0JCd+AyorbSnyQ7reyZsgoVhsrzdEWILI8B1geR65lPhTfrU+KJOfqsuWAmn1dQnmCQkllVKQYQZJ7KYp375cWVcigCksn2/lVPVj1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yL3bDy2s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZerhCA8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QUOjGdju; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IO1nwO+8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCC6B21AB0;
	Tue, 27 May 2025 11:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748344653;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llOK0+EQWMJcRgIRVagCd7c8PfRh1RoDrgo/opoXDOI=;
	b=yL3bDy2s8Z/gZmpFTkkFIcZ7rYXfwiMbsQqyIOxtplntrVI/KTFlEpbsIr7FZkpw5Pm2WC
	L/F0uEjnkYcMTl6HEmw6X+KerPlQI9I4TnSbQroBHbKeemQQhPqUKmdsNR3js6ghD38YvK
	IhM84iWHn830ShDv0MekXXrDrS9fl+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748344653;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llOK0+EQWMJcRgIRVagCd7c8PfRh1RoDrgo/opoXDOI=;
	b=HZerhCA8gbrKeqFyAhhCCIlVAMjM4/pBCapgiZlODtRAUpSHhrtfmyn4ucfN4+HDDJsorP
	5C3SjygdXgy8T0Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QUOjGdju;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IO1nwO+8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748344652;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llOK0+EQWMJcRgIRVagCd7c8PfRh1RoDrgo/opoXDOI=;
	b=QUOjGdjubbnv+gbzyZhknSv+4jdgX+ojuI5SnkteNCYc3G9vl8MHGJK8caiRC5S8AmiFzf
	PMVaEe7Iz05Rtlq+dhskRpknr6dfF4uhHRX53oHhXA1PNSj/GmirEZjzHIj9KND0bskdl+
	aMy2s5Usuasx7tROLhjAjR5r4rms3hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748344652;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llOK0+EQWMJcRgIRVagCd7c8PfRh1RoDrgo/opoXDOI=;
	b=IO1nwO+8tGdHXAPqVUuxKlhRg2C9gq2DWUAhKE48/rj7sC7pezpGiVW6eJydLtwJRB1RUy
	dpBcTlCgOZ6SplDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B431E1388B;
	Tue, 27 May 2025 11:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lGzGK0yfNWiqfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 May 2025 11:17:32 +0000
Date: Tue, 27 May 2025 13:17:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
	"Collet, Yann" <cyan@meta.com>,
	"Will, Brian" <brian.will@intel.com>,
	"Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20250527111731.GC4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
 <aBrEOXWy8ldv93Ym@gondor.apana.org.au>
 <20250507121754.GE9140@suse.cz>
 <20250508041914.GA669573@sol>
 <baafb2ad-e2a2-4d40-9759-109c2cad559c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baafb2ad-e2a2-4d40-9759-109c2cad559c@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: DCC6B21AB0
X-Spam-Flag: NO
X-Spam-Score: -3.21
X-Spam-Level: 

On Tue, May 27, 2025 at 10:32:00AM +0800, Gao Xiang wrote:
> 
> 
> On 2025/5/8 12:19, Eric Biggers wrote:
> 
> ...
> 
> > 
> > BTW, I also have to wonder why this patchset is proposing accelerating zlib
> > instead of Zstandard.  Zstandard is a much more modern algorithm.
> 
> I think simply because QAT doesn't support the Zstandard native offload.
> At least, for Intel Xeon Sapphire Rapids processors (it seems to have
> built-in QAT 4xxx), only LZ4 and deflate-family are natively supported.
> 
> I've confirmed that SPR QAT deflate hardware decompresion already surpasses
> LZ4 software decompression on our cloud server setup, which is useful since
> it greatly improves decompression performance (even compared to software LZ4)
> and saves CPU overhead completely.

Does this measure the overall time of decompression (including the setup
steps, like the scatter/gather or similar, allocating requests, waiting
etc)?. Comparing that to the library calls plus the input page iteration.
I haven't found any public benchmarks with the QAT enabled compression.
I'm interested how it's benchmarked because we'v had people pointing out
that LZ4 itself is very fast, but when the overhead is taken into
account it's reducing the overall performance. Thanks.

