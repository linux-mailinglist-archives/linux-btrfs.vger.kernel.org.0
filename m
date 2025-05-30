Return-Path: <linux-btrfs+bounces-14314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7CAC9074
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 15:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52003B592F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B76A21FF30;
	Fri, 30 May 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLXIaJ7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hNl3nKhC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLXIaJ7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hNl3nKhC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800917A2F5
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612610; cv=none; b=pjSVlIY06aBNfZz/NQE+lyQw1Ke6e1w8aMdP3xp439p/UShzWggAdDa5TVxihEgO8A6sudzaVL91s73/EJpbehaEMQBpKXQNr3JZmFw7aM2aAo7t295MG4HNfMzqHNGzSEhDONmUyBrznelK817cpOD1f0DXQWhldSrNToL6F3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612610; c=relaxed/simple;
	bh=Fsk1VnQCBYDNHfPBLd+9CY/JA/dC9EosG66p+33V61I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWoB1x9XFPb9ZB5cNNQ7SXM9WElBkbDtx6uEDBn/GI8jWzCG7bHX7nygupPlNKDzEhQ060hksn49h339YglQmeL5ALWwnI56M2xF+cHJqjCQq/LwHM+HioMeN7kFFqVMWxjulKoEeLXXPM8uIG596sn3Kc6+k2isEf/AZ8ZX0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RLXIaJ7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hNl3nKhC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RLXIaJ7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hNl3nKhC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31F9621ADC;
	Fri, 30 May 2025 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748612601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deNjwLjuJuDDZsqHbXvGlx2OgQgeNNfMUGUlPn8tjS4=;
	b=RLXIaJ7CDZEiPfImWZSofTbSLR9O19Kloj48pZruk5A5Irm2FM/6Fb+r77sJhKCbpdOHsG
	ldvaN8GeNDY5/Ot8peCnj/pVt15NbrssJr0CZQ8LLQ8vgit24xjhY51vkFre5kFWP5+Bk1
	hlDzSxvW+OUAkHYU11kKWHtF3hfLuGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748612601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deNjwLjuJuDDZsqHbXvGlx2OgQgeNNfMUGUlPn8tjS4=;
	b=hNl3nKhCl2tgY8IWdmhG/ibv/+r4G5A0LRBKoB0KYM+wlaXSYtSEyJtqz9Jbd40yrxAgkw
	Mgy4GG3UYkv83BCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RLXIaJ7C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hNl3nKhC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748612601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deNjwLjuJuDDZsqHbXvGlx2OgQgeNNfMUGUlPn8tjS4=;
	b=RLXIaJ7CDZEiPfImWZSofTbSLR9O19Kloj48pZruk5A5Irm2FM/6Fb+r77sJhKCbpdOHsG
	ldvaN8GeNDY5/Ot8peCnj/pVt15NbrssJr0CZQ8LLQ8vgit24xjhY51vkFre5kFWP5+Bk1
	hlDzSxvW+OUAkHYU11kKWHtF3hfLuGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748612601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deNjwLjuJuDDZsqHbXvGlx2OgQgeNNfMUGUlPn8tjS4=;
	b=hNl3nKhCl2tgY8IWdmhG/ibv/+r4G5A0LRBKoB0KYM+wlaXSYtSEyJtqz9Jbd40yrxAgkw
	Mgy4GG3UYkv83BCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 245CB13889;
	Fri, 30 May 2025 13:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ajCiCPm1OWitOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 13:43:21 +0000
Date: Fri, 30 May 2025 15:43:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: minor cleanups related to extent buffer
Message-ID: <20250530134311.GY4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748232037.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748232037.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 31F9621ADC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Mon, May 26, 2025 at 01:32:34PM +0930, Qu Wenruo wrote:
> The first patch is a cleanup to remove the unused @fs_info parameter
> from btrfs_csum_data().
> 
> The second patch uses btrfs_csum_data() directly to calculate super
> block checksum and avoid use extent buffer helpers.
> 
> The final patch enhance btrfs_print_leaf() to be called with temporary
> extent buffers in mkfs/convert, which have no eb->leaf populated.
> 
> Qu Wenruo (3):
>   btrfs-progs: remove the unused fs_info parameter for btrfs_csum_data()
>   btrfs: mkfs: do not use extent buffer to writeback super block
>   btrfs-progs: enhance btrfs_print_leaf() to handle NULL fs_info

Added to devel, thanks.

