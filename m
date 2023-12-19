Return-Path: <linux-btrfs+bounces-1046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B824281802C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 04:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61251285F7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769AC8BE6;
	Tue, 19 Dec 2023 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hKqNKuSv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/uEOVFly";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vmf7gR/m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6q8ju2TY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690A881E;
	Tue, 19 Dec 2023 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA77B222FE;
	Tue, 19 Dec 2023 03:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702955856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8+oNfLBhl3OWah+ibTvNq4A4ca3ZHxXUXs7/jWq2/A=;
	b=hKqNKuSvX+r+KxkahlccHg4Pxj2lJpgMd2ZdJc13xk38tKZwayIEmYk8aWvVmDIqHcoQE5
	mb3hG+2kPkSLBbjo5MHBvfe2D+MVgizudhevFwCGEg5aG07kwu4caq4zfcXOTwBzpt1+KN
	1btYtdlViWHv0gwD1lhHD8HDScmtyqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702955856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8+oNfLBhl3OWah+ibTvNq4A4ca3ZHxXUXs7/jWq2/A=;
	b=/uEOVFly8Ty0wOwn/+WBR+ESAw97XfelFnuI228zj3FKYH3ggzYWPLbnUytEgV0xIzcVMl
	p5k2Fm56Y9niuDDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702955855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8+oNfLBhl3OWah+ibTvNq4A4ca3ZHxXUXs7/jWq2/A=;
	b=vmf7gR/mwMzCIqtDnoPXY+E256riayzA3jBPD6LB3wUugOtp8wAEs3CoUAWvRePpSsFV2v
	sJ2Uu11HSk4p5m2+3NptBowawYzH+CF/q/KdPRpb+bD+GMFXd+O3Rdnqf+CcO/gMeMWALv
	IbcRE/3E7zglqv/W8NA2kTZsCo2Mhtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702955855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8+oNfLBhl3OWah+ibTvNq4A4ca3ZHxXUXs7/jWq2/A=;
	b=6q8ju2TY8aW+0YloNmk9Kgsy/sRMTig+wvpP1LThDqYJUomBMUkRQJzyUD0q4SQyGvSonb
	s5/c5SIhq0eMmcCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D4C113BE8;
	Tue, 19 Dec 2023 03:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1I9/J0wLgWWeVwAAn2gu4w
	(envelope-from <ddiss@suse.de>); Tue, 19 Dec 2023 03:17:32 +0000
Date: Tue, 19 Dec 2023 14:17:26 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <20231219141726.5c1e01bd@echidna>
In-Reply-To: <3ca2a681-79c1-4478-b17f-3128a7018b2d@gmx.com>
References: <cover.1702628925.git.wqu@suse.com>
	<11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
	<20231218235946.32ab7a69@echidna>
	<3ca2a681-79c1-4478-b17f-3128a7018b2d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com,wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 19 Dec 2023 06:22:42 +1030, Qu Wenruo wrote:

> On 2023/12/18 23:29, David Disseldorp wrote:
> > Hi Qu,
> >
> > On Fri, 15 Dec 2023 19:09:23 +1030, Qu Wenruo wrote:
> >  
> [...]
> >> +/**
> >> + * kstrtoull_suffix - convert a string to ull with suffixes support
> >> + * @s: The start of the string. The string must be null-terminated, and may also
> >> + *  include a single newline before its terminating null.
> >> + * @base: The number base to use. The maximum supported base is 16. If base is
> >> + *  given as 0, then the base of the string is automatically detected with the
> >> + *  conventional semantics - If it begins with 0x the number will be parsed as a
> >> + *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
> >> + *  parsed as an octal number. Otherwise it will be parsed as a decimal.
> >> + * @res: Where to write the result of the conversion on success.
> >> + * @suffixes: A string of acceptable suffixes, must be provided. Or caller
> >> + *  should use kstrtoull() directly.  
> >
> > The suffixes parameter seems a bit cumbersome; callers need to provide
> > both upper and lower cases, and unsupported characters aren't checked
> > for. However, I can't think of any better suggestions at this stage.
> >  
> 
> Initially I went bitmap for the prefixes, but it's not any better.
> 
> Firstly where the bitmap should start. If we go bit 0 for "K", then the
> code would introduce some difference between the bit number and left
> shift (bit 0, left shift 10), which may be a little confusing.
> 
> If we go bit 1 for "K", the bit and left shift it much better, but bit 0
> behavior would be left untouched.
> 
> Finally the bitmap itself is not that straightforward.

One benefit from a bitmap would be that unsupported @suffixes are easier
to detect (instead of ignored), but I think if you rename the function
kstrtoull_unit_suffix() then it should be pretty clear what's supported.

> The limitation of providing both upper and lower case is due to the fact
> that we don't have a case insensitive version of strchr().
> But I think it's not that to fix, just convert them all to lower or
> upper case, then do the strchr().
> 
> Would accepting both cases for the suffixes be good enough?

I think so.

Cheers, David

