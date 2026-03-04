Return-Path: <linux-btrfs+bounces-22206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFrBC4Wrp2lejAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22206-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:48:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0891FA827
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8884F3018E17
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 03:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4837DE94;
	Wed,  4 Mar 2026 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z21oF4Lx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WBQ8GV+a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tvt8vh9W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oLwnXPLJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA3237DE95
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772596093; cv=none; b=PzlOYPOmRiU17Yh503cPUjbh7WBUGpNRg955MPaoTZAeX6XLNsn2osP8j0iTELVvqAhe9cM1i7BKWVVIy1DUQZQ91fXwQ3GHXdqiuGIIP8HpZt+vGGRLSNFdKjMlRa2cjNzCOlowBT4MzT1hsbdXmrtb5SiS+5pnh+V16HHpbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772596093; c=relaxed/simple;
	bh=tBtxNjChvMAsYOfpRn403+3gMyLvLKnQHk/7RshvM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewh/e9X979w4xK07F7/WbuRqyJu7UVn5/DsSPDaFbxV+gyhoFeJuHdXNiDx0PXCXaamQ+/1WixvEExavfn4Gvg5oZOWLuKo5ZaiMTM7wfSRTvwacAHYiX4DPsfMSmc60z4F2mojuuGvpzzm/7RqZWdYllz1ze6KkzK2V8nRnSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z21oF4Lx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WBQ8GV+a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tvt8vh9W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oLwnXPLJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80EC65BE2A;
	Wed,  4 Mar 2026 03:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772596090;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc3WneafrsNY4Iph09KKz26U52hvWQVXC1ukZV1vyA=;
	b=z21oF4Lx5Q9NT70sLmV8TzpqL4m4p8jLwevPkvYDa1OzxCvQZgDJRh41OfD5dlZHB3plIx
	2HUpiOUGDPZ8KpSGJUGvw9UCmpKb+ih3qNk3MF9gfaC89yTzdBknvDakejOTZFZnc9+RRZ
	ixM2+Gyl+kkti1CD9dzBk01VHm8cVuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772596090;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc3WneafrsNY4Iph09KKz26U52hvWQVXC1ukZV1vyA=;
	b=WBQ8GV+atCy0GVBPLVKmXBDGCyrz0Nouw0PLxkKnJVOT8qZ3N3JdFhAkumnPMBlO9akx0Q
	XrLJ7xYBSjbvU7CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tvt8vh9W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oLwnXPLJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772596089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc3WneafrsNY4Iph09KKz26U52hvWQVXC1ukZV1vyA=;
	b=Tvt8vh9WAAPIdByPueT8x5JG0QjdPoFNGy6NmkM1ocTwX+yfgDmWmkqQl4rDWvz+flIr00
	agfGyJJCIF5196g0xk+YLzIqVJj/wJSIbwh2vQrVjbsYLxGTsOwXoCP6yPF+xJ6Sm1Nd4U
	aJMdIM5bSAuBFw5gEL8XVMJjBBHAg2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772596089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMc3WneafrsNY4Iph09KKz26U52hvWQVXC1ukZV1vyA=;
	b=oLwnXPLJkmVE2rkH/fnucV9aBUTekjelvDhAyuMr/7beRxcVoiV4JSRbi9yBB1GZGoqGmT
	i6OsqSTtFGOAFQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67EE33EA69;
	Wed,  4 Mar 2026 03:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EI0qGXmrp2m7bwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Mar 2026 03:48:09 +0000
Date: Wed, 4 Mar 2026 04:48:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] btrfs: drop 2K block size support
Message-ID: <20260304034808.GG8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1772162871.git.wqu@suse.com>
 <228a7e9b75212e33b93cd009b08d232b240e9e51.1772162871.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228a7e9b75212e33b93cd009b08d232b240e9e51.1772162871.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 2A0891FA827
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22206-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:03:43PM +1030, Qu Wenruo wrote:
> Commit 306a75e647fe ("btrfs: allow debug builds to accept 2K block
> size") added a new block size, 2K as the minimal block size if the
> kernel is built with CONFIG_BTRFS_DEBUG.
> 
> This is to allow testing subpage routines on x86_64 (page size is fixed
> at 4K).
> 
> But it turns out that the support is not that widely adopted, and there
> are extra limits inside btrfs-progs, e.g. 2K node size is not supported.
> 
> Finally with the larger data folio support already in experimental
> builds for a while, it's very easy to trigger a large folio and testing
> subpage routines by just doing a 64K block sized buffered write.
> 
> Let's just remove the seldom utilized 2K block size completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Can we keep it? It's under debug and not interfering with anything but
it can trigger different set of bugs than with the large folios.

