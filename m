Return-Path: <linux-btrfs+bounces-12286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33551A6195D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FA93ACCF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E1204C13;
	Fri, 14 Mar 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YG8eFoxy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kB5rfWBt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YG8eFoxy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kB5rfWBt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919314A0A3
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976813; cv=none; b=XBScDbLD5ai4pVQ5vszsZpaZdc75QJ7YkpDiPEfO25fTbx57yjRFVmbv4oY8IdSqUKPQcm1SxdAfQrxLzJmEw1c2l+HlQt/UZ5TJfh1Rz7YsjXqMRhAZsHV9D40Qz9V8qxTDW1EznZkOOi/XQDyaxVQPZ7BfRBsb3Da01vxHVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976813; c=relaxed/simple;
	bh=Y0s0kIEgoHS+bOw2NWZKeZwxebux/z4frAefK+1HO8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNJzhdjjpFH69yt1lDC92dgDv5gSUuLVZNUiueonQZgYsqlFT6XQfgT0SIRCoB8Txg/R1TMqypgiPohDfTP8051sDtKmJJjf4PKeBWnRefCBgL5IVPQaGx3rg/JvDZuZlVshKr1RzEB3RgH6XRQlSKfJxcG4Q5375kJUUW1Bzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YG8eFoxy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kB5rfWBt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YG8eFoxy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kB5rfWBt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 269441F388;
	Fri, 14 Mar 2025 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741976809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3qFA4AMLTJG3S4N4+Wu32jcWfXHhRIgBT+w9ABEwcg=;
	b=YG8eFoxyO96nznGxaNDg/HRc74p+7uLVDhYTudUCly4ELk2AiHew2zP1REZ/yJQ9rnGYrc
	R5pyQiWzPPi9G6xV6jmvcVDbMfYyQY3jWMi10gJi5pIzSzO3QZKOJrTZ17BVipv46r2yDz
	19wD8f7pM5hU91BFbhtciZdaOAAL2AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741976809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3qFA4AMLTJG3S4N4+Wu32jcWfXHhRIgBT+w9ABEwcg=;
	b=kB5rfWBtyEUXOJBLwmTqBlnnByczxeH8KaQG0b+Xzjf6CAZlH8TPU1k/IrpH7QLDuc79+H
	ocx2+3vw5EVGzJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741976809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3qFA4AMLTJG3S4N4+Wu32jcWfXHhRIgBT+w9ABEwcg=;
	b=YG8eFoxyO96nznGxaNDg/HRc74p+7uLVDhYTudUCly4ELk2AiHew2zP1REZ/yJQ9rnGYrc
	R5pyQiWzPPi9G6xV6jmvcVDbMfYyQY3jWMi10gJi5pIzSzO3QZKOJrTZ17BVipv46r2yDz
	19wD8f7pM5hU91BFbhtciZdaOAAL2AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741976809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3qFA4AMLTJG3S4N4+Wu32jcWfXHhRIgBT+w9ABEwcg=;
	b=kB5rfWBtyEUXOJBLwmTqBlnnByczxeH8KaQG0b+Xzjf6CAZlH8TPU1k/IrpH7QLDuc79+H
	ocx2+3vw5EVGzJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00ABF13A31;
	Fri, 14 Mar 2025 18:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3S1AO+h01GdMfAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 14 Mar 2025 18:26:48 +0000
Date: Fri, 14 Mar 2025 19:26:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>, Li Zetao <lizetao1@huawei.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix signedness issue in min()
Message-ID: <20250314182643.GS32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250314155447.124842-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314155447.124842-1-arnd@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Mar 14, 2025 at 04:54:41PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Comparing a u64 to an loff_t causes a warning in min()
> 
> fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_588' declared with attribute error: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
> fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
>  2472 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
>       |                           ^~~
> 
> Use min_t() instead.
> 
> Fixes: f286b1c72175 ("btrfs: prepare extent_io.c for future larger folio support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, there was another report and the upcoming for-next will have it
fixed.

