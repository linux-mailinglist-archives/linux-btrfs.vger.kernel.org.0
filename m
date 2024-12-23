Return-Path: <linux-btrfs+bounces-10642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49D9FB4BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C1C165DFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8861C3BF1;
	Mon, 23 Dec 2024 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfRTp4be";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s68/ZcIp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfRTp4be";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s68/ZcIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602E1B4141
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982577; cv=none; b=GqxdDCk/Vg1Js9ifHhD5lM5AEtKGKq5x00W9RVCGicBhcvUmcQ8U4J/URNEZxqkGGOfxTx0V/2af3AoEv3MMbzCoZBPzllTINekiac+bfEWZ80J1Fmlu8Hf51Ue863DnKJ7kRBtvx0SObNFHIvtABxo9FF1Wr597ROy52IfLZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982577; c=relaxed/simple;
	bh=NfvaZJjlwI0LeCTYzoiMk0yVwvEWQamlrcyAYKFTB70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPa9Nf7c9DxWkn9JbG3SyCVUoALgFU7of/6ZHgSHLacqc+3ENmoz+bMr5KYK6Zl0+Oc7bF9ZSyK6xJV3PKsF7ztIPoOoAqtLxGtpipLDVbGkq/gr+3EAecLuE+bEq38EAeVyfKwiOHQBJgs7z6LbxSM+UxfBA7Z9EJwA6gbHlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfRTp4be; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s68/ZcIp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfRTp4be; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s68/ZcIp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 724E72216E;
	Mon, 23 Dec 2024 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734982573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BstU4xKGeZvaUeu4V8fl5RYzw9E74QE7jXzjVPsC8oM=;
	b=sfRTp4be0ai9JrfpTj/sQtumjeKf3njn8WuHdty398H5R0DdkUubN5iGjK2r6qvU8QEflh
	PBqbUlWxZBsQwVQz3qFsnr5hoOfQx6ModRIEqpp5cm8AobNPmo5DFc3NNGp2qhRsjzKl9A
	UHQDJX/NoWQgHg+EwYps/Ow+7h92nqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734982573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BstU4xKGeZvaUeu4V8fl5RYzw9E74QE7jXzjVPsC8oM=;
	b=s68/ZcIpUmh+NnG4SxySwj54B3mYeyEXIXZiOy3i8rDDi6CWlds3hsZOVVeTXIsFexa5Ul
	BCwIMYWnBRh+ryAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734982573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BstU4xKGeZvaUeu4V8fl5RYzw9E74QE7jXzjVPsC8oM=;
	b=sfRTp4be0ai9JrfpTj/sQtumjeKf3njn8WuHdty398H5R0DdkUubN5iGjK2r6qvU8QEflh
	PBqbUlWxZBsQwVQz3qFsnr5hoOfQx6ModRIEqpp5cm8AobNPmo5DFc3NNGp2qhRsjzKl9A
	UHQDJX/NoWQgHg+EwYps/Ow+7h92nqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734982573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BstU4xKGeZvaUeu4V8fl5RYzw9E74QE7jXzjVPsC8oM=;
	b=s68/ZcIpUmh+NnG4SxySwj54B3mYeyEXIXZiOy3i8rDDi6CWlds3hsZOVVeTXIsFexa5Ul
	BCwIMYWnBRh+ryAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 516D013485;
	Mon, 23 Dec 2024 19:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H9mlE627aWfobwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Dec 2024 19:36:13 +0000
Date: Mon, 23 Dec 2024 20:36:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into
 fs.c
Message-ID: <20241223193604.GL31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734368270.git.fdmanana@suse.com>
 <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
 <20241218202117.GG31418@twin.jikos.cz>
 <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
 <c4daaaf6-110e-426f-aa8d-edbc375663ae@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4daaaf6-110e-426f-aa8d-edbc375663ae@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Dec 19, 2024 at 07:58:16AM +1030, Qu Wenruo wrote:
> >>>       text        data     bss     dec     hex filename
> >>>    1782094      161045   16920 1960059  1de87b fs/btrfs/btrfs.ko
> >>>
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>> ---
> >>>   fs/btrfs/ctree.c | 51 ------------------------------------------------
> >>>   fs/btrfs/ctree.h |  6 ------
> >>>   fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
> >>>   fs/btrfs/fs.h    |  6 ++++++
> >>
> >> Can you please create a new file for checksums? Moving everything to
> >> fs.c looks like we're going to have another ctree.c.
> > 
> > Is it really worth it? After this patchset fs.c is only 229 lines and
> > the csum related functions are just a few and very short.
> > My idea would be to do such a thing either when fs.c gets a lot larger
> > or we get more csum functions (and/or they get larger).
> > 
> > But sure, why not, I can do that on top or send a new version of this patch.
> 
> Personally speaking, I'm not a huge fan of a lot of small files/headers.

Agreed if the files are too small, there's some percieved limit where it
makes sense to split the functionality. I've suggested that because
there are more changes for that so we could avoid moving the code twice.
For now I'm ok keeping it in fs.c.

> It makes the include path less clear, and make the path completion 
> easier to hit conflicts.
> (That's also why I hate the "mode-" prefix in btrfs-progs check/ directory)

Well that's a matter of taste and style. The path completion is not the
criteria I'd put first, file name namespacing may help to navigate by
the common functionality or a subsystem. But we've never agreed on that.

