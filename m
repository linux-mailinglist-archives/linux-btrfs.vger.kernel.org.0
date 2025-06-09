Return-Path: <linux-btrfs+bounces-14574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C651AD261F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EEB7A7C8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDB321D3E1;
	Mon,  9 Jun 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WgXziGkC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFA1Fsfy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WgXziGkC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dFA1Fsfy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043C21C18C
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495109; cv=none; b=niYFzkiIFOtS/XhZS6AaUBPF0sEV3gSZz5XIOthuXKaGw1oY0GDzoNu+QZBC2GVliqvDkXX5fR9KdsfV/+YHOi59JEFJRjyG8NQfrIi+co1xVR2w4eVqjVIQ5h1fqgHPoM8eoiEWr9eJoU9iGIbOFx+LvD9LDK7jzoMG9Sph4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495109; c=relaxed/simple;
	bh=wMomh/rSMj/XVkLgXZ01mfMHWwTdw3vt5q23EXMkq7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mri67O67jQNzyPLsRcAUxNb2QQLSlJ7xQ4SueDhpk8q5UaxWQef8Ic71aFJNlfMVaVW3Zi1tBcUUJcwNFtDE6KqHGRW/IaPRhfw+VQjAuCdCYLUYtZIM7cti6ytnS3tqQB4Fri9MzAXoWCr/kdJvSsuowAv1dMTwhXXyobChH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WgXziGkC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFA1Fsfy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WgXziGkC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dFA1Fsfy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D88A521190;
	Mon,  9 Jun 2025 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749495105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoJfMxDUKzQNmfH3lmNeCbL7NAVs/d78jVH3iYZ+xeI=;
	b=WgXziGkC2pSpDUveWYr3Ovv5lLrNwBCAe9LBqGMpejPoyG2Lpx+bE1aUkaD91y8hm2PE7I
	a6UOuoetBSxtudIJO19R99+74TNr7/Rqyf6+wPs73xk2KFFEtNvR+qRVquLdg7+DC38e3h
	pi17IDPpEU1dgfpaxb3bq8ZNBSI2rsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749495105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoJfMxDUKzQNmfH3lmNeCbL7NAVs/d78jVH3iYZ+xeI=;
	b=dFA1FsfyEalqHl2QDQMa3KxCTF/hsTewxHJdCktYxaYxdXWHtJpD6L7gdjg7TLDMFZ0SBl
	4BzSwWQHw5DpqMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749495105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoJfMxDUKzQNmfH3lmNeCbL7NAVs/d78jVH3iYZ+xeI=;
	b=WgXziGkC2pSpDUveWYr3Ovv5lLrNwBCAe9LBqGMpejPoyG2Lpx+bE1aUkaD91y8hm2PE7I
	a6UOuoetBSxtudIJO19R99+74TNr7/Rqyf6+wPs73xk2KFFEtNvR+qRVquLdg7+DC38e3h
	pi17IDPpEU1dgfpaxb3bq8ZNBSI2rsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749495105;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoJfMxDUKzQNmfH3lmNeCbL7NAVs/d78jVH3iYZ+xeI=;
	b=dFA1FsfyEalqHl2QDQMa3KxCTF/hsTewxHJdCktYxaYxdXWHtJpD6L7gdjg7TLDMFZ0SBl
	4BzSwWQHw5DpqMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC33137FE;
	Mon,  9 Jun 2025 18:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NSobLkEtR2hnOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 09 Jun 2025 18:51:45 +0000
Date: Mon, 9 Jun 2025 20:51:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: remap tree
Message-ID: <20250609185144.GZ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250605162345.2561026-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Thu, Jun 05, 2025 at 05:23:30PM +0100, Mark Harmstone wrote:
> * The remap tree doesn't have metadata items in the extent tree (thanks to Josef
>   for the suggestion). This was to work around some corruption that delayed refs
>   were causing, but it also fits it with our future plans of removing all
>   metadata items for COW-only trees, reducing write amplification.

>   A knock-on effect of this is that I've had to disable balancing of the remap
>   chunk itself.

Not relocatable at all? How will the shrink or device deletion work,
this uses relocation to move the chunks.

>   This is because we can no longer walk the extent tree, and will
>   have to walk the remap tree instead. When we remove the COW-only metadata
>   items, we will also have to do this for the chunk and root trees, as
>   bootstrapping means they can't be remapped.

