Return-Path: <linux-btrfs+bounces-21867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKJ7DOeMnWn5QQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21867-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 12:35:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C911865C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 12:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9A803086DC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851BD37E30B;
	Tue, 24 Feb 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThiakTeI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZLOapEY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThiakTeI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZLOapEY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8B374171
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932555; cv=none; b=S6micsXrnC9S7pTFtW0WrtSoErrzw2VMCbY3ECLFkLFzIoo7hOydOaHRNR9+iaNDIH1aPdrcNdX5sqZb8MzSawm8fK2aWlNttGGUrmGdV5P2rjVr0+THaUmmxMuaNoe8AQa8KmMVLA2xPsAvJANGfJw94elCKQBmO1pxcqpi9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932555; c=relaxed/simple;
	bh=Jy3cU7gJWK6yQ9QFQAbTrxOOMZgUz2lfwWRgPLCGkQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndq+uE5llrEsI3drzMKuood9BMytycxVHjglIxeUsNEvQ/mbw3HnzNRDHrfqBa5qDI/tsXRZOuowQX4y5ElbRIEH+8n4vInLOtIUPeWiRvcExYzOSWD6OHxRV/TYvg5ey/c16bldoc9IyPiffxxfQ9Er5ogs1p6tjWCbiASjdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThiakTeI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZLOapEY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThiakTeI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZLOapEY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A8E15BCD6;
	Tue, 24 Feb 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771932551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUa6RxMXulz7XynmTz1vZjcCj/R2U32XdOKHeldaAhI=;
	b=ThiakTeIfWSVktFMwuRcKr5QKL/jbs7kWpVvpctP0ULndOHAChJD8Fq9VqoSZFnNzYgXGg
	tRTFTQJ1KFfzSvTKghKtfzCmK8BM9PmXHqZqxTDScaPbr24t4TL/3khGQ2UnCsAKDczhY4
	GVAjo4hevKcD4VOQUngFXFyh+q1Y8w8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771932551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUa6RxMXulz7XynmTz1vZjcCj/R2U32XdOKHeldaAhI=;
	b=fZLOapEYQjKfWQQkKiMh7HhZL12u1DPIoJWARXdIr4D+zUhHJsPA9Mrg5Bo3XnFRZQAqrv
	uv5FDwLG3IOd5nCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ThiakTeI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fZLOapEY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771932551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUa6RxMXulz7XynmTz1vZjcCj/R2U32XdOKHeldaAhI=;
	b=ThiakTeIfWSVktFMwuRcKr5QKL/jbs7kWpVvpctP0ULndOHAChJD8Fq9VqoSZFnNzYgXGg
	tRTFTQJ1KFfzSvTKghKtfzCmK8BM9PmXHqZqxTDScaPbr24t4TL/3khGQ2UnCsAKDczhY4
	GVAjo4hevKcD4VOQUngFXFyh+q1Y8w8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771932551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUa6RxMXulz7XynmTz1vZjcCj/R2U32XdOKHeldaAhI=;
	b=fZLOapEYQjKfWQQkKiMh7HhZL12u1DPIoJWARXdIr4D+zUhHJsPA9Mrg5Bo3XnFRZQAqrv
	uv5FDwLG3IOd5nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15D463EA68;
	Tue, 24 Feb 2026 11:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ttavBIeLnWn1CAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 11:29:11 +0000
Date: Tue, 24 Feb 2026 12:29:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: Kees Cook <kees@kernel.org>, dsterba@suse.com, clm@fb.com,
	naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Message-ID: <20260224112905.GQ26902@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260223234451.277369-1-mssola@mssola.com>
 <202602231603.4F93301E@keescook>
 <699d43e6.170a0220.3a6e96.a235SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <699d43e6.170a0220.3a6e96.a235SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-21867-lists,linux-btrfs=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3C911865C0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:23:25AM +0100, Miquel Sabaté Solà wrote:
> Kees Cook @ 2026-02-23 16:06 -08:
> 
> > On Tue, Feb 24, 2026 at 12:44:51AM +0100, Miquel Sabaté Solà wrote:
> >> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> >> index 02105d68accb..1ebfed8f0a0a 100644
> >> --- a/fs/btrfs/raid56.c
> >> +++ b/fs/btrfs/raid56.c
> >> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
> >>  	 * @unmap_array stores copy of pointers that does not get reordered
> >>  	 * during reconstruction so that kunmap_local works.
> >>  	 */
> >> -	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> >> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> >> +	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
> >> +	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);
> >>  	if (!pointers || !unmap_array) {
> >>  		ret = -ENOMEM;
> >>  		goto out;
> >
> > Just as a style option, I wanted to point out (for at least the above,
> > I didn't check the rest), you can do the definition and declaration at
> > once with "auto" and put the type in the alloc:
> >
> > 	auto pointers = kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
> >
> > But either way is fine. :) This patch looks good to me!
> 
> I personally don't mind either way, but I don't what's the policy around
> using "auto" in btrfs.

So far it hasn't been used and as with all the other syntax updates it's
up to debate and eventually start using it or not.  I'd need to see
examples where it's better than not using it, apart from macros.
In C the explicit types are everywhere and are I think always simple,
unlike in C++ where 'auto' can hide something very complex.

