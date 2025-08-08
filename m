Return-Path: <linux-btrfs+bounces-15931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB7B1E709
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 13:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5573B18959BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E31255E20;
	Fri,  8 Aug 2025 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHdcWg1d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYGM475g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PHdcWg1d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KYGM475g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546F1D54E9
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651926; cv=none; b=AJvQ+sjx7U8IqahRL6qGbbaWSZaX+3WUyDiMPLl4/sa/eStaZW1YnPpVruXoFCIzXba1Jk8WefjEZgAtmnWNaOa9aIWWttEvbsn6313MHYrCsqCjbAr4od8QWRH902uRmxzTOLX0YyitFiIOtcZQPP5z9t5NG/HWFtH6osEeTj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651926; c=relaxed/simple;
	bh=FuP5ZUjYTnOKls/bOEJEEVkauPAXxHPMP2Z0e4hgeAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf53qR+MLOAxIODMVqMQ9S7tvYIITe9avjntmZYTV1vlaYuDe8ZytbMmlcWA6CuSAQeFo50QB2kdwdXvTKWtY3oov2FUyLtVatI/uej8WPDxHSxw8hm0VyOtIGrB1kIf71l7T6oLlxFc3G1PV+xEETNiCRd2A2iaO63SeJtdgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHdcWg1d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYGM475g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PHdcWg1d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KYGM475g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA23B33E26;
	Fri,  8 Aug 2025 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754651922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpZD52yWvDJym+lvdn+JpQ+JjH58+k9MCM88hrcpSBw=;
	b=PHdcWg1dTzouEvV6bRE5WMMZAM4L7kXpbRaM8/vUnOa2DgCbg8EEdatqIEPbOOcDmdkx/u
	uJfWuY4YJ7jY0Hom+R8ncQpmDHauaaP0iV77/YrvtU9mAi6/wnwvCMVkzufhkrRdy4pC0Y
	WjFW2676T+Af5isxVzH20NaOpJvkGto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754651922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpZD52yWvDJym+lvdn+JpQ+JjH58+k9MCM88hrcpSBw=;
	b=KYGM475gDVRPwHywNX7heXigUHTQudLnWt62OMzJXEVfffdVIdYELh0G2r8BS5UdzJb1BD
	f/zQASggqGmgIBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754651922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpZD52yWvDJym+lvdn+JpQ+JjH58+k9MCM88hrcpSBw=;
	b=PHdcWg1dTzouEvV6bRE5WMMZAM4L7kXpbRaM8/vUnOa2DgCbg8EEdatqIEPbOOcDmdkx/u
	uJfWuY4YJ7jY0Hom+R8ncQpmDHauaaP0iV77/YrvtU9mAi6/wnwvCMVkzufhkrRdy4pC0Y
	WjFW2676T+Af5isxVzH20NaOpJvkGto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754651922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpZD52yWvDJym+lvdn+JpQ+JjH58+k9MCM88hrcpSBw=;
	b=KYGM475gDVRPwHywNX7heXigUHTQudLnWt62OMzJXEVfffdVIdYELh0G2r8BS5UdzJb1BD
	f/zQASggqGmgIBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B227513A7E;
	Fri,  8 Aug 2025 11:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pdVUKxLdlWjleAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 11:18:42 +0000
Date: Fri, 8 Aug 2025 13:18:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify support block size check
Message-ID: <20250808111837.GR6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
 <20250807175757.GN6704@twin.jikos.cz>
 <85ed4a22-a87b-4b92-b636-9156b0271c76@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85ed4a22-a87b-4b92-b636-9156b0271c76@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Aug 08, 2025 at 07:34:31AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/8 03:27, David Sterba 写道:
> [...]
> >> +static inline bool btrfs_blocksize_supported(u32 blocksize)
> > 
> > This does not need to be inline, it's used once in sysfs handler.
> 
> There are only two call sites, one in btrfs_validate_super() and one in 
> sysfs.
> 
> Considering how small the function is (an if() with 3 conditions, and 
> one ASSERT()), the size should be good enough for inline.
> 
> Haven't yet compared the generated asm, but it shouldn't be that 
> different between a function call and inlined function.

Static inlines make sense for short functions defined in headers and in
justified cases in .c, eg. for optimization or better code. In this case
I don't see any reason for that. The inlining decision is left to the
compiler.

