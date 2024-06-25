Return-Path: <linux-btrfs+bounces-5962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E8916D65
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE121C21AFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B516F915;
	Tue, 25 Jun 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdY2WeOx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3gt0DhI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdY2WeOx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3gt0DhI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB116EBF4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330457; cv=none; b=Ds/NN+fQbXWfItAyUGIAXe/a8VmLAZreuf4TUkGWuV/BsLHpH13eOu5cgqZ9qDSbVnDdhy8Q2Z/VDhbZOM8TsNff942+TX7Fu31W25T9IbHNyhED4ATheSLdSt1V/IUZDWIlymyJ6AFKYfPkBt2bp9Qar0N9Nh3RFhfAnzouDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330457; c=relaxed/simple;
	bh=k1NCoQ8b5pA4UJ3Z186yckDTdp3ny3LBuMGT+gNC1MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oet/QDKkkvaQQDVMx8NkGAWZGRoieNJIVY6vGv6WFHpn9wkk4LDCC1daSnhtkcBnXDMGitAjPr10Vc+fb2sEcTPOF59d9ARpKw27LkEDNcZHziOAnxTSZZFdxzW9msMOXyd1mQ4XZkspDcts18SjLrzxPrfJxbERTSLXpyMg+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdY2WeOx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3gt0DhI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdY2WeOx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3gt0DhI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51A181F893;
	Tue, 25 Jun 2024 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719330454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OH92qrrfR4Kr6kW+Qo4LXIC4lAx0OtRZLClNcU9fG04=;
	b=wdY2WeOxiij0g3XSHWIeMgjofT2tRs2y+Nc9fA+qfT4gjbo8EK4zgbN1at6x/PcXoYMstf
	bSdkkXIv/a2XuhOlv7WpChC8iwD3v5FYfR7/gtDcqj053EXqiBxDgIGif68rqSFgyvfvIn
	aAiv8VJdL5AJ08dBCREE0uCdK2riMVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719330454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OH92qrrfR4Kr6kW+Qo4LXIC4lAx0OtRZLClNcU9fG04=;
	b=x3gt0DhIX9P1nXH6lePJkrgTdHqVoy5ZutKIjke1gcHqlDdinHgT9VKyzI7/clZ6zF0PRA
	yUPoLw8Al8psL8BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719330454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OH92qrrfR4Kr6kW+Qo4LXIC4lAx0OtRZLClNcU9fG04=;
	b=wdY2WeOxiij0g3XSHWIeMgjofT2tRs2y+Nc9fA+qfT4gjbo8EK4zgbN1at6x/PcXoYMstf
	bSdkkXIv/a2XuhOlv7WpChC8iwD3v5FYfR7/gtDcqj053EXqiBxDgIGif68rqSFgyvfvIn
	aAiv8VJdL5AJ08dBCREE0uCdK2riMVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719330454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OH92qrrfR4Kr6kW+Qo4LXIC4lAx0OtRZLClNcU9fG04=;
	b=x3gt0DhIX9P1nXH6lePJkrgTdHqVoy5ZutKIjke1gcHqlDdinHgT9VKyzI7/clZ6zF0PRA
	yUPoLw8Al8psL8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B11513A9A;
	Tue, 25 Jun 2024 15:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z9zvDZbmemZcRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Jun 2024 15:47:34 +0000
Date: Tue, 25 Jun 2024 17:47:33 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.9.1 (do not use)
Message-ID: <20240625154733.GX25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240624222951.2807-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624222951.2807-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]

There's a report that subvolume names in the 'subvolume list' output are
trimmed (missing last character). This is serious enough to make a fixup
release. ETA tomorrow in case something else pops up.

On Tue, Jun 25, 2024 at 12:29:47AM +0200, David Sterba wrote:
> Hi,
> 
> btrfs-progs version 6.9.1 have been released. This is a bugfix release.
> 
> Note: raid-stripe-tree has recently got a on-disk format update which is not
> backward compatible, until the patches are in kernel (ETA release 6.11) use v6.9
> or lower, both need either DEBUG or experimental build
> 
> Changelog:
> 
>    * fix detection of intermediate super block flags (e.g. csum change and
>      other conversions)
>    * raid-stripe-tree support (still experimental):
>       * moved under experimental build flags (mkfs, convert)
>       * format change, removed encoding type; backward incompatible
>    * receive dump: escape special chars in xattr names and values, and clone
>      source path
>    * tune change csum: fix reservation size when starting a transaction
>    * other:
>       * new and updated tests
>       * updated CI images, new reference build targets
>       * cleanups and refactoring
> 
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.9.1

