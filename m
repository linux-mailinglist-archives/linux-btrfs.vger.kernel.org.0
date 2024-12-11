Return-Path: <linux-btrfs+bounces-10261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3E9ED4DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96E81887843
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A4205AB6;
	Wed, 11 Dec 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="khqU0ohw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1G3fdmVF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="khqU0ohw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1G3fdmVF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF61C3F27
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942838; cv=none; b=IGKtifjQs7MqiGMiB9w9i7LeiEYGbXv1o8YpvwOjl46nokD4Mtxh3mRnSAEr0bWMcBx9s47RKZYU6twFCR33MnrTJN6fkZGyn4fcDNtEP+n/ioUzHt9gPhyl+8WUXC20fC3CK8hSfH8QRnOlXouRtUuGvO8WTtCW3F9hgeF2ztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942838; c=relaxed/simple;
	bh=I1qw1qmLVOHyHJFCGNAjsX75Y/+qV72LWdp9AbGMFco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+bihbXDXNz63BxnTpTjwgcJKoTpmIrZcYWtR14zr/b1V36z2ln6VYY5I1M5ER/NcUoHFu7d7KUROiT9ooyYg2Hx8aGqfY3xmIKs1YbbWGPjQGOsOH7ykTS65ajL+mIKrcJK1attVcoxMXo9FWvNowAM+yJb6wvT/WDKuKYSw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=khqU0ohw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1G3fdmVF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=khqU0ohw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1G3fdmVF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB2EF210ED;
	Wed, 11 Dec 2024 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuS9dfz0fguRETBahPV/e2yC+woNXJg0DccQ+cH8QoE=;
	b=khqU0ohwFbh4/3V97UA1tyMctH4ini1FHdRtHixpzazWfeYSu87AKdclz/LRQDwpbyzzXA
	n+IfXySu1uTKRag/v/zzk3E8rQag62rbfwXDrsbHQR+t7peVMCzWvEA03OKy9GC3KUELzi
	+UsW4G3A9ULwEdFvU+sXL2TPUN1Nubg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuS9dfz0fguRETBahPV/e2yC+woNXJg0DccQ+cH8QoE=;
	b=1G3fdmVFvIQ3UwVid/fv19lxkv8yGdQTEEOXAMxyFpPEiTz+d1dFss+QftBSBDDToNdnJq
	r7d6HqMecLrgqrAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuS9dfz0fguRETBahPV/e2yC+woNXJg0DccQ+cH8QoE=;
	b=khqU0ohwFbh4/3V97UA1tyMctH4ini1FHdRtHixpzazWfeYSu87AKdclz/LRQDwpbyzzXA
	n+IfXySu1uTKRag/v/zzk3E8rQag62rbfwXDrsbHQR+t7peVMCzWvEA03OKy9GC3KUELzi
	+UsW4G3A9ULwEdFvU+sXL2TPUN1Nubg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuS9dfz0fguRETBahPV/e2yC+woNXJg0DccQ+cH8QoE=;
	b=1G3fdmVFvIQ3UwVid/fv19lxkv8yGdQTEEOXAMxyFpPEiTz+d1dFss+QftBSBDDToNdnJq
	r7d6HqMecLrgqrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C20A613927;
	Wed, 11 Dec 2024 18:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XeokLzLeWWe6AgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 11 Dec 2024 18:47:14 +0000
Date: Wed, 11 Dec 2024 19:47:13 +0100
From: David Sterba <dsterba@suse.cz>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: edit prelim_ref_insert() to use rb helpers
Message-ID: <20241211184713.GT31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <f283c3c32d5c69339c04eafa8d996112f9f6f638.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f283c3c32d5c69339c04eafa8d996112f9f6f638.1733850317.git.beckerlee3@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Dec 10, 2024 at 01:06:09PM -0600, Roger L. Beckermeyer III wrote:
> This commit edits prelim_ref_insert() in fs/btrfs/backref.c to use
> rb_find_add_cached(). It also adds a comparison function for use with
> rb_find_add_cached().
> 
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>  fs/btrfs/backref.c | 71 +++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 6d9f39c1d89c..fcbcfce0f93a 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -250,6 +250,17 @@ static int prelim_ref_compare(const struct prelim_ref *ref1,
>  	return 0;
>  }
>  
> +static int prelim_ref_cmp(struct rb_node *node, const struct rb_node *exist)
> +{
> +	int result;
> +	struct prelim_ref *ref1 = rb_entry(node, struct prelim_ref, rbnode);
> +	struct prelim_ref *ref2 = rb_entry(exist, struct prelim_ref, rbnode);

Same type mismatch, missing const.
> +
> +	result = prelim_ref_compare(ref1, ref2);

You don't need the temporary variable 'result'.

> +
> +	return result;
> +}
> +

