Return-Path: <linux-btrfs+bounces-5477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECA8FD1D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BF31F27544
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8A14AEC3;
	Wed,  5 Jun 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGY7UUVS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSZ1w7pp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf+oKt8q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q9EUzPza"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADF19D891
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602033; cv=none; b=RGC46L0XSsj2B84ykHJDu5O+aJv22HpTtjFeZ+6/JBgILREGBnFtTi75meycIXTyuUxvSTCnCfzOf2+JJ/X8b3rZSxSoWe9/muo9HTrVTebBt6WXbrV+CjWKGU+DhXArkNcN2E1HvHqZBtMF1GFYnSk9gMihOoxoicXx0YAZSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602033; c=relaxed/simple;
	bh=6Hi9MS1MjNZbSdTghppKo2DKZpuCjvy2ZM3j2VZ+ih0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uQ/zX8YRU5SaES35HR1U6SmLujLPohOs7AqzJS/Mj/0yuy80AKVyPLOQrAlSvWwDkG3PSVC8FNPL3dLA7USj6Po4p2FU0eQ6fcuhBfRXPzhdCQKcITVN6+6E6i+7HVI/B8v27Bth3Bbm0MFkiePld80gPWLXOmNiIJErVIoVzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGY7UUVS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSZ1w7pp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf+oKt8q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q9EUzPza; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1731621991;
	Wed,  5 Jun 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GqjK1FilQEXDaNky3Kn78cOBU2YBWjz7uZBiOi6fOgA=;
	b=VGY7UUVSruvmWhirko3G19/HDm/6nPX53k+IFZ6/y+n4G6Zr/V961HWRrvZwMp1VsVXtRa
	Ysifz9ZgWFxOCiZbiNKZ5wGao61/8WKcy/71BGICVNSkmrkx+4cyDK7Rfxy3368eVxeUdW
	gKEjA/QhqMLnsRuCsORoMzEfe1r+QD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GqjK1FilQEXDaNky3Kn78cOBU2YBWjz7uZBiOi6fOgA=;
	b=fSZ1w7ppIEC0VYvIX+MAt/sxXK1/O2XFGlEIW168MMv/E57cdSy87H8mW+7/tV9YBcSLF7
	2WL1CvvvSdHbEzDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GqjK1FilQEXDaNky3Kn78cOBU2YBWjz7uZBiOi6fOgA=;
	b=Jf+oKt8q0bT29vUcYlTkSxXOSIXHn7+X/gH7gKN+309v9IKu6QPPjcJ1JWPwlxdBBQY0Jj
	oBQY/a93KsE4cG5VHaPUteTv5Fp33L6Xf71ybWcwP5usrdj86aI8+ia8VqjFqxC4T9mQtW
	KSY4ZxKO90iL8ae668q7InagFAc5XmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GqjK1FilQEXDaNky3Kn78cOBU2YBWjz7uZBiOi6fOgA=;
	b=Q9EUzPzaoArJy0lVxe8yBNKIV9sLw5J0nOmbPYZ5VRXZXDaIhCN2npmJwhmye5g9ec8wVC
	rBra1dK1TqUb63Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0947113A24;
	Wed,  5 Jun 2024 15:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kToXAuuGYGZiSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Jun 2024 15:40:27 +0000
Date: Wed, 5 Jun 2024 17:40:25 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Using likely/unlikely (Re: [PATCH 5/6] btrfs: mark ordered extent
 insertion failure checks) as unlikely
Message-ID: <20240605154025.GB18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Jun 04, 2024 at 12:08:51PM +0100, fdmanana@kernel.org wrote:
> In-Reply-To: <1d0c219fe64db06e3c8ffa7b28299fca959473e7.1717495660.git.fdmanana@suse.com>
> From: Filipe Manana <fdmanana@suse.com>
> 
> We never expect an ordered extent insertion to fail due to already having
> another ordered extent in the tree for the same file offset, since we
> always wait for existing ordered extents in a range to complete before
> writing into the range again. So mark the failure checks for the results
> of tree_insert() as unlikely, to make it clear it's never expected (save
> exceptional causes like bugs or memory corruptions) and to serve as a hint
> for the compiler to possibly generate better code.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ordered-data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 1d7707948833..c98c8fdc14a1 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -224,7 +224,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
>  	spin_lock_irq(&inode->ordered_tree_lock);
>  	node = tree_insert(&inode->ordered_tree, entry->file_offset,
>  			   &entry->rb_node);
> -	if (node)
> +	if (unlikely(node))
>  		btrfs_panic(fs_info, -EEXIST,
>  				"inconsistency in ordered tree at offset %llu",
>  				entry->file_offset);

A general comment or point for discussion: using unlikely() annotations
for such cases where it's clear from the code that it almost never
happens.

I'm not against it (and actually supportive) although I'm aware of the
possible controversies around validity of the likely/unlikely
annotations. If this is for

   if (condition) {
       <error message>;
       return -EIMPOSSIBLE;
   }

then OK. We do that heavily in tree-checker that is supposed to catch
all the corner cases but otherwise must be fast. The unlikely case leads
to reordering the assembly code so the message code is moved to the end
of the function thus leaving the fast path code dense.

I did some experiments with code that return -EUCLEAN and there are
differences in the assembly code, although the resulting .ko size may be
larger.

I'd only advise to add the annotations moderately and rather in groups
than individually.

