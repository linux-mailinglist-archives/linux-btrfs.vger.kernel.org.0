Return-Path: <linux-btrfs+bounces-1883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE183FF94
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378DEB21FF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89690524D4;
	Mon, 29 Jan 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agH4b6dO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVBpKkaN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="agH4b6dO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVBpKkaN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB004CB57
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515510; cv=none; b=CzPRbxfZdsW62/d6kiAGovxSTwMNlR96f52uM6wtmlD1yW9Y+LqWapOhWsUOGmtewUjqKiENZBmJGoOA8R19/aWH9J47g0pttffZEc/iMpH2etiuxpehRwljp0Tpg/oqN/A1VT5RQRtghk3g9LlZCD+10ouENYV6ouVJDTCPjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515510; c=relaxed/simple;
	bh=/uj1pbtW+ITmlsRZ54tcH5UL125/V16DbLh6Lq+YHwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py2ICWuRY+LwCk8G93rxxfLrUYfIeOUunFuiSow+b4CUfHAM7Vwgejkp2j1Kjd5+nMDLHrAGsajR3TqAM+05av3mWPy4QRI11HpEyO2wR1FtHYpvdqb4R1o3Pqn4J6kRpNP7zurBPWgd2d8qa0NuZmUW8gEhj+suQOsatYbKdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=agH4b6dO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVBpKkaN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=agH4b6dO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVBpKkaN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1E522222B;
	Mon, 29 Jan 2024 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706515506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzeLfrbEKAKuhVRYP53P/k73O7iJcoMb9gN/z/zFvA=;
	b=agH4b6dO7djShYJ008+VvLDHzhxeBLWoimNjLehTHpzp30qLf6hofz3TH1CKas9ABJj6MC
	r+Bmxglt97Ha/7sNQT2vdynLs+mjOmJ1iea5+ZAiCLwqXzriwT8EvOOyPxxV9oMk6um4EP
	Swqlg63Cs8/jb2Qq/ZcuW5MI5RaNOCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706515506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzeLfrbEKAKuhVRYP53P/k73O7iJcoMb9gN/z/zFvA=;
	b=ZVBpKkaN4xNfYmVriqkSe+ZgI9QMbp2Wc56BdceJ9saB0KHVpUURg/Rf3Xd5b1zL9Ln1hR
	B/u/iZnYjz5J1BCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706515506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzeLfrbEKAKuhVRYP53P/k73O7iJcoMb9gN/z/zFvA=;
	b=agH4b6dO7djShYJ008+VvLDHzhxeBLWoimNjLehTHpzp30qLf6hofz3TH1CKas9ABJj6MC
	r+Bmxglt97Ha/7sNQT2vdynLs+mjOmJ1iea5+ZAiCLwqXzriwT8EvOOyPxxV9oMk6um4EP
	Swqlg63Cs8/jb2Qq/ZcuW5MI5RaNOCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706515506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNzeLfrbEKAKuhVRYP53P/k73O7iJcoMb9gN/z/zFvA=;
	b=ZVBpKkaN4xNfYmVriqkSe+ZgI9QMbp2Wc56BdceJ9saB0KHVpUURg/Rf3Xd5b1zL9Ln1hR
	B/u/iZnYjz5J1BCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B2D9B132FA;
	Mon, 29 Jan 2024 08:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id v7IaKzJct2UEMAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jan 2024 08:05:06 +0000
Date: Mon, 29 Jan 2024 09:04:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 0/3] page to folio conversion
Message-ID: <20240129080442.GV31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706037337.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706037337.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.22%]
X-Spam-Flag: NO

On Tue, Jan 23, 2024 at 01:28:04PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> These patches transform some page usage to folio. All references and data
> of page/folio is within the scope of the function changed.
> 
> Changes since v1:
> Review comments - 
>   * Added WARN_ON(folio_order(folio)) to ensure future development knows
>     this code assumes folio_size(folio) == PAGE_SIZE
>   * namespace restoration: prefix variable names with folio_
>   * Line adjustments
> 
> Goldwyn Rodrigues (3):
>   btrfs: page to folio conversion: prealloc_file_extent_cluster()
>   btrfs: convert relocate_one_page() to relocate_one_folio()
>   btrfs: page to folio conversion in put_file_data()

The conversion looks straightforward like we've been doing elsewhere,
however the CI is still not in a shape to validate arm + subpage, I've
seen the hosts not pass with various sets of patches (removed potential
breakage and keeping potential fixes).

There are more folio conversions coming so I'd like to get them all in
so we can switch to the big folios eventually but without the CI
verification of subpage it's a bit risky.

