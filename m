Return-Path: <linux-btrfs+bounces-9661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7289C909E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C71B47D90
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272471714BF;
	Thu, 14 Nov 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewbgspq/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qgyl0Cj+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ewbgspq/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qgyl0Cj+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D32D05D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600777; cv=none; b=jz2lz8eBiB9KfY9v/JYxyd1XnWIi1+RFR7nYYW9dm/KQZ2P8xr2UcqvD7aH9l/Exz8huJWSFXlwJt6+Tcw1mWxtHqxCUJRfA63Mly1ISthHAf7G6V++0rSS9moM7Uccbc0uSzPsX6G/i3Q8AgSI2QkWtCwaxKqbxAs0yAxw1Ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600777; c=relaxed/simple;
	bh=oNIrYEdtjo+OhfvS4N2d75NQMNmYT7bONSsFmjeZdGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y65oPso/paNn8JCL8n5z6NOI/Bt9BNQWyeEoc7D2x7yNLxfxrqru7IGtDgzEYEEHq/eyRKqkArA0kU7zwFX+99I3uoyie2AfEGx+Ls2hfhEvzlB/0dsdNyMGL0lvl5vaC1xghJr1rKbr48j7LngZij1ngNXc9O08GHcTGUBW5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ewbgspq/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qgyl0Cj+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ewbgspq/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qgyl0Cj+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ABC521134;
	Thu, 14 Nov 2024 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731600773;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBKcW+2owToAnmAYJY7HdpozJDzKUuQPkFm/k9kiE0o=;
	b=ewbgspq/mi/hsOvHLlEGqRBs3g8vWb26efklmTdPrwvQMiyXpsIzYgo2ck6sZhrowuBlUY
	eKSHvceiYiH/t13b6aezZMKcZyWpn2uhXfT5FHOfjs9cXPa4FlFv5mtW89OVQsl9/hpolg
	VXBgM8f5Pp1+b1iIhi2PbLw5XQqczSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731600773;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBKcW+2owToAnmAYJY7HdpozJDzKUuQPkFm/k9kiE0o=;
	b=Qgyl0Cj+knaeuv7PkiPTAyPiyy0LNTBW965zfzQJ9jvcb9l2X4koDhySJuombL57SVAuCR
	PjNsHuS4iQ9QYxCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731600773;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBKcW+2owToAnmAYJY7HdpozJDzKUuQPkFm/k9kiE0o=;
	b=ewbgspq/mi/hsOvHLlEGqRBs3g8vWb26efklmTdPrwvQMiyXpsIzYgo2ck6sZhrowuBlUY
	eKSHvceiYiH/t13b6aezZMKcZyWpn2uhXfT5FHOfjs9cXPa4FlFv5mtW89OVQsl9/hpolg
	VXBgM8f5Pp1+b1iIhi2PbLw5XQqczSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731600773;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBKcW+2owToAnmAYJY7HdpozJDzKUuQPkFm/k9kiE0o=;
	b=Qgyl0Cj+knaeuv7PkiPTAyPiyy0LNTBW965zfzQJ9jvcb9l2X4koDhySJuombL57SVAuCR
	PjNsHuS4iQ9QYxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73D5713721;
	Thu, 14 Nov 2024 16:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AzrHG4UhNmfmGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 14 Nov 2024 16:12:53 +0000
Date: Thu, 14 Nov 2024 17:12:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused macros in ctree.h
Message-ID: <20241114161248.GV31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241114152312.2775224-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114152312.2775224-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Nov 14, 2024 at 03:22:53PM +0000, Mark Harmstone wrote:
> The Private2 #ifdefs in ctree.h for pages are no longer used, as of
> commit d71b53c3cb0a. Remove them, and update the comment to be about folios.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/ctree.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 317a3712270f..60c205ac5278 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -744,14 +744,11 @@ const char *btrfs_super_csum_driver(u16 csum_type);
>  size_t __attribute_const__ btrfs_get_num_csums(void);
>  
>  /*
> - * We use page status Private2 to indicate there is an ordered extent with
> + * We use folio status private_2 to indicate there is an ordered extent with
>   * unfinished IO.
>   *
> - * Rename the Private2 accessors to Ordered, to improve readability.
> + * Rename the private_2 accessors to ordered, to improve readability.
>   */
> -#define PageOrdered(page)		PagePrivate2(page)
> -#define SetPageOrdered(page)		SetPagePrivate2(page)
> -#define ClearPageOrdered(page)		ClearPagePrivate2(page)
>  #define folio_test_ordered(folio)	folio_test_private_2(folio)
>  #define folio_set_ordered(folio)	folio_set_private_2(folio)
>  #define folio_clear_ordered(folio)	folio_clear_private_2(folio)

While this is right, there's a patch (now in linux-next)
https://lore.kernel.org/all/20241002040111.1023018-5-willy@infradead.org/
that removes that (with some other updates).

