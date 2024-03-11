Return-Path: <linux-btrfs+bounces-3202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868C8789E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FD5281BA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1756B77;
	Mon, 11 Mar 2024 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Cb/nP0I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jz0KQVjA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Cb/nP0I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jz0KQVjA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05A54744;
	Mon, 11 Mar 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191578; cv=none; b=CpA5vq6u1DxtGyR27VpqijtPd0J7JdSH/YWr2IefC3vBbtWcYXystag81inBeRKEG0R2T9Mz32XHQDoDeK/jN7TqzFPr/4Gts6UPdfxzwGNAgqDzuyi29BPj1kNcAh+sxYNx7OJdxd8ns4i12ge/FtWqaiJDZCty5Hm2XxRq0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191578; c=relaxed/simple;
	bh=ymIRjKPF05PZewLisrG0ZcCdHvSirNn8nsBXFGQq2CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alv2/rEqCV6GqhUrXhdA2hU3muyntKqXwUXIB5i1/uoGdHcLmoEXre4P+kKDgRy1sj6+4DeOtwvAKRMXm0X3wORlH2QZZ2I1nKcfBfXQF94vaWBActRvR4FH3BJHNYky8NDF1uAlUq10VGiBuG/cB/uXwTgQZad258G0gssm4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Cb/nP0I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jz0KQVjA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Cb/nP0I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jz0KQVjA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F788350BF;
	Mon, 11 Mar 2024 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710191573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+AGE7RjnnQunZRwxXkho+EGWQnOSV7m+Iu1aFkXwxE=;
	b=3Cb/nP0IEkTnr0afkVI5Enhiu8hgbHcFi5z8IStfPcQyv9elELnmJ3c9snDiUGnY23dCbo
	IFQUa38PU+U7mYxQmZP0hY4LK4F+B925BQAZH4JFj1NeOg0NcqCRZT8avLgGi8AXczcJgb
	YFbLbVbDT0Pdl77guTfbjuW+L2qaVFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710191573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+AGE7RjnnQunZRwxXkho+EGWQnOSV7m+Iu1aFkXwxE=;
	b=Jz0KQVjArop3YO9Khzq8lnCE673MM56QPUgQeR2Ao6a3cKdQqF6mvnbPa5L70SvcBnFFLh
	vqZSy2OxtXtAuvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710191573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+AGE7RjnnQunZRwxXkho+EGWQnOSV7m+Iu1aFkXwxE=;
	b=3Cb/nP0IEkTnr0afkVI5Enhiu8hgbHcFi5z8IStfPcQyv9elELnmJ3c9snDiUGnY23dCbo
	IFQUa38PU+U7mYxQmZP0hY4LK4F+B925BQAZH4JFj1NeOg0NcqCRZT8avLgGi8AXczcJgb
	YFbLbVbDT0Pdl77guTfbjuW+L2qaVFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710191573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+AGE7RjnnQunZRwxXkho+EGWQnOSV7m+Iu1aFkXwxE=;
	b=Jz0KQVjArop3YO9Khzq8lnCE673MM56QPUgQeR2Ao6a3cKdQqF6mvnbPa5L70SvcBnFFLh
	vqZSy2OxtXtAuvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AD5513695;
	Mon, 11 Mar 2024 21:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9BVvHdVz72VSagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Mar 2024 21:12:53 +0000
Date: Mon, 11 Mar 2024 22:05:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>, clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 1/7] btrfs: add and use helper to check if
 block group is used
Message-ID: <20240311210540.GU2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240229155112.2851155-1-sashal@kernel.org>
 <Ze9w+3cUTI0mSDlL@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze9w+3cUTI0mSDlL@duo.ucw.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3Cb/nP0I";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jz0KQVjA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.03 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.82)[85.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.03
X-Rspamd-Queue-Id: 9F788350BF
X-Spam-Flag: NO

On Mon, Mar 11, 2024 at 10:00:43PM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
> > 
> > Add a helper function to determine if a block group is being used and make
> > use of it at btrfs_delete_unused_bgs(). This helper will also be used in
> > future code changes.
> 
> Does not fix a bug and does not seem to be preparation for anything,
> so probably should not be here.

Agreed, this patch does not belong to stable and I objected in
https://lore.kernel.org/all/20240229155207.GA2604@suse.cz/

for version 6.7 and all other stable versions.

