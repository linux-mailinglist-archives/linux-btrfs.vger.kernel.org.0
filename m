Return-Path: <linux-btrfs+bounces-13103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED79A90C5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606233A973D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C1221DA5;
	Wed, 16 Apr 2025 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ws8Aqrox";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MrOH1SoM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ws8Aqrox";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MrOH1SoM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC8218AC4
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831841; cv=none; b=QBaXwnDdIr/O2zWpBCQHPeEGrIjSLjqMnflBopnjtIojCSXaFEWdbdgLbIrzKQ2QMaLbOEQ6c5vkeUNOQ9OOR32oy3lOeoVs7MZDXVpq+Myr617TXD7/DNqCvisYfRlzbLlVCB/Zjvkm5sMnYUfFsSAXC80ig9M0mcc3+ie1F+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831841; c=relaxed/simple;
	bh=YeJVYezN2N9tBy/ivZPIlCB+bCLgiTBLRr7R+ADMN9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQnT/cNqsGf1HXGSgMSIGtUFVfPoGNVOYYb0iAmbyNlsvFeNwjRgpCPtcSh5SdX7iL9+duUS34zj71gDFFuTd0mU1VyjQs5rl7PX/64X5zX1AStVw0qlIpSRBi0QxrXmOvo3etltsayg4n4eOlNZ/xZnJihbqujw2pyFRfVbk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ws8Aqrox; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MrOH1SoM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ws8Aqrox; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MrOH1SoM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21874210EF;
	Wed, 16 Apr 2025 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744831838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNeJsYpPNvdO7AT8tVOQ90ztjOp/Qz5P0x7vfsGyK48=;
	b=Ws8Aqroxh+9bHcMv3AclkeEp9E7IfdgZQm7qgeGSZ95ZBn2ECCqZg+8kezuDX7vWBcfa1w
	+gL9oPbAR+9rTNizaoeckDHHr9n0m+hNoBy41AUoxsaZXzI7nHZFRJqISakPapZCqJ/l2V
	Z2Ko3Ln3wwivENJjo3mhNKyqR5+/KcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744831838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNeJsYpPNvdO7AT8tVOQ90ztjOp/Qz5P0x7vfsGyK48=;
	b=MrOH1SoMrnAE5wpAudn8U90ToUPyck5+m667ax225fMMF7PMQYEHR5+VgeLoMcokr/UpxH
	2F3tyQMD4G0sJMAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744831838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNeJsYpPNvdO7AT8tVOQ90ztjOp/Qz5P0x7vfsGyK48=;
	b=Ws8Aqroxh+9bHcMv3AclkeEp9E7IfdgZQm7qgeGSZ95ZBn2ECCqZg+8kezuDX7vWBcfa1w
	+gL9oPbAR+9rTNizaoeckDHHr9n0m+hNoBy41AUoxsaZXzI7nHZFRJqISakPapZCqJ/l2V
	Z2Ko3Ln3wwivENJjo3mhNKyqR5+/KcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744831838;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNeJsYpPNvdO7AT8tVOQ90ztjOp/Qz5P0x7vfsGyK48=;
	b=MrOH1SoMrnAE5wpAudn8U90ToUPyck5+m667ax225fMMF7PMQYEHR5+VgeLoMcokr/UpxH
	2F3tyQMD4G0sJMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E1A13976;
	Wed, 16 Apr 2025 19:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uxPlA14FAGgbIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 19:30:38 +0000
Date: Wed, 16 Apr 2025 21:30:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: add verbose version of ASSERT
Message-ID: <20250416193032.GF13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744794336.git.dsterba@suse.com>
 <093bba8a2b23f5bb678aaa9e6824e2bed3b4d2a5.1744794336.git.dsterba@suse.com>
 <6a1ad2ef-67d0-4aa2-83af-2a31856c1440@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1ad2ef-67d0-4aa2-83af-2a31856c1440@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 16, 2025 at 03:03:18PM +0000, Johannes Thumshirn wrote:
> On 16.04.25 11:09, David Sterba wrote:
> > +
> > +/* Verbose assert, use to print any relevant values of the condition. */
> > +#define VASSERT(expr, fmt, ...)					\
> > +	(likely(expr) ? (void)0 : btrfs_assertfail_verbose(#expr, __FILE__, __LINE__, \
> > +							   fmt, __VA_ARGS__))
> >   #else
> >   #define ASSERT(expr)	(void)(expr)
> > +#define VASSERT(expr, fmt, ...)		(void)(expr)
> >   #endif
> 
> Ahm stupid question (applies for ASSERT() as well), doesn't that 
> generate code as well when CONFIG_BTRFS_ASSERT=n? So we're doing a lot 
> of potentially unneeded tests?

It should not generate any code. It's parsed, syntax-checked and as the
result is cast to void it's thrown out and optimized out (-O2).

