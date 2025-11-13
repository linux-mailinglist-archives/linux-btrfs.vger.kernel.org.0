Return-Path: <linux-btrfs+bounces-18933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF87EC566FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5144E6041
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A1334C0E;
	Thu, 13 Nov 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v72VfjZt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zs7YBCho";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aycgSZmR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5m8FMme3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120F332EA5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024048; cv=none; b=BSoBb1ftvytUhqHGRwZC39/IU90+ngl8Rctc2q8vi9HMYRm/Sx9foon+Uu4YLlrPquUmWFm+3TfWUoQipHDaU88fjVfHvBp6Fm3VXsdXP5MS2ylNR1apHoIc5gmy6KTZ/syz2+icWhEm/FqVWbFzbSMuy2KP4yAZphjnEwf88dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024048; c=relaxed/simple;
	bh=oBFJjhQExC7Lot+lhBVebdzHKd27FtrGdeJsJP/zMBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLBu1Y1aEObBb2jqD6PeaCi9kykd/9qTv+WLOQ4JmnScezeWdLWlx314TRiWPHIUwYw7vdPLTaA1bMT0ta4IH1xCxZ7iZnOkg52F7c7XEHMQFxOnbLRjMNiIBu3w/p8Oz5XR9S5KdnC0mmLmheGuholFl8x0GwVSmrMV5MjS+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v72VfjZt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zs7YBCho; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aycgSZmR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5m8FMme3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC35A21859;
	Thu, 13 Nov 2025 08:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763024045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNIf1lPc8/TD6/mToEKnuaSYbjjzCVt1shfxacSHvd0=;
	b=v72VfjZtZO/UGkgb9UeuGDRQaH5RZJCk+fvfSddb0VzYN3rzOkBe5XHrnu+Gd2IG3dVv9+
	A208Nx8F1q2t4i6J6ks7AkAGzMM8ex5PfFh2XbSuQrLqN2HeBaLyGJtUI1xef5B9c1IyMT
	rZYQCh4CQAQzx6FKz4BwfcYaSBkEer0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763024045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNIf1lPc8/TD6/mToEKnuaSYbjjzCVt1shfxacSHvd0=;
	b=zs7YBChoO4B2o9bW8PQIW1sxo1hxUbVzScz1MbWPEnH/g0YbAhslI6wAIpgEk+935rVucf
	xdhZN09TvHgiKFCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aycgSZmR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5m8FMme3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763024044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNIf1lPc8/TD6/mToEKnuaSYbjjzCVt1shfxacSHvd0=;
	b=aycgSZmRESwaOuaOIHQ7514yYBGSiQ/bU723Cfj1WgyakXok97OHIsjzU6phHC/a8KnTUv
	/MlpCH2tLbFbLEhFqUp9PRh506ljz99gcz1f9kJCNw/T38US/ukBqtBmX+W1KPn1iwOyj0
	m5PfdvPd9VqAmqABtswQw6IJsXXb5I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763024044;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNIf1lPc8/TD6/mToEKnuaSYbjjzCVt1shfxacSHvd0=;
	b=5m8FMme3/gKkcSvMwal03ZPrstULbeieafpqWnKVXUiUsU+T9GbIkCcwQEDve0e0LhNfOG
	oUIKPz1HIxtXZbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0A063EA61;
	Thu, 13 Nov 2025 08:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G/XDMqycFWkbUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 08:54:04 +0000
Date: Thu, 13 Nov 2025 09:54:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Gladyshev Ilya <foxido@foxido.dev>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/8] btrfs: simplify return path via cleanup.h
Message-ID: <20251113085403.GI13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1762972845.git.foxido@foxido.dev>
 <5bfb05436ed8f80bc060a745805d54309cdba59c.1762972845.git.foxido@foxido.dev>
 <0a31cf84-ccfe-4da4-b922-85da570c6e3b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a31cf84-ccfe-4da4-b922-85da570c6e3b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: EC35A21859
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Nov 13, 2025 at 07:20:01AM +1030, Qu Wenruo wrote:
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -1878,16 +1878,14 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
> >   	 * and then re-check to make sure nobody got added.
> >   	 */
> >   	spin_unlock(&head->lock);
> > -	spin_lock(&delayed_refs->lock);
> > -	spin_lock(&head->lock);
> > -	if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op) {
> > -		spin_unlock(&head->lock);
> > -		spin_unlock(&delayed_refs->lock);
> > -		return 1;
> > +	{
> 
> There are some internal discussion about such anonymous code block usage.
> 
> Although I support such usage, especially when it can reduce the 
> lifespan of local variables, it's not a commonly accepted pattern yet.

And the discussion is going great, I think we wont't find a consensus
without somebody either missing a coding pattern (you) or suffering to
look at such code each time (me). Others have similar mixed feelings
about the guards use.

