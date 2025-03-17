Return-Path: <linux-btrfs+bounces-12336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA465A6549B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CAD3B8F2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408F24BBE2;
	Mon, 17 Mar 2025 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bodCAUTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PEjRglb7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bodCAUTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PEjRglb7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852924A07E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223412; cv=none; b=m7jnIaNw/7HDG8l8Gb5c7sKBerd68xj/iI+2vRRXLjpc/O2rX4stwVdUQZqgTBz1tULTjh7FdHHq10mSSv4OZTDrTHSSG0jY5NjgQh7ctBy6E8BqtLOOFd/NTJNrIm2Yym9f0097hw4v2uRwuDJ0WQbSBPUEPoAeKFHM3muo1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223412; c=relaxed/simple;
	bh=HYednG73dHDPuoCRfn8bObCa0e4EOoCfNgILHyAZEws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0QSKtFHtdUaFqKKZCD0G1bAq1oPAT3tGeN24U/iQRP68r7nh8FaIRnEW3oUbZVWDS9jdMAh3892taJUEaVd8YOq6w+60Csz3qVOy0h05oLm4cfVIvRgw0ZX0eV+wm9NhYiEz4TqYj3Xn6n3H3YUZUTtiXbutOGR+iEI1ZzBxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bodCAUTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PEjRglb7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bodCAUTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PEjRglb7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D32521D61;
	Mon, 17 Mar 2025 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742223408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpFxtepf88L8eVHXNp6aoBN9MY97VlNA/euyl1tIDUs=;
	b=bodCAUTfrOa/JwxYXSqLjbFjJ9lkRpCuyUc8Jas5isRfkGE83zMFOnFadQtNEf+cZSLcdX
	3Pb8jOjGWaZlY/vVozNM5QYG/HejXVDM4o3NUU+h5Ax3GJq/i7UvpkUnF/8QCEWtgfVINw
	M8EKQseFEp0lDcq/EzwxAUpvXDIW0ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742223408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpFxtepf88L8eVHXNp6aoBN9MY97VlNA/euyl1tIDUs=;
	b=PEjRglb78AAkKQztbEA0BfrWxoh0zeFr316w+zs+btZhARevoeJr9K6fpg3lquVFY+SqSi
	ww9Y7/euTiM9/+BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742223408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpFxtepf88L8eVHXNp6aoBN9MY97VlNA/euyl1tIDUs=;
	b=bodCAUTfrOa/JwxYXSqLjbFjJ9lkRpCuyUc8Jas5isRfkGE83zMFOnFadQtNEf+cZSLcdX
	3Pb8jOjGWaZlY/vVozNM5QYG/HejXVDM4o3NUU+h5Ax3GJq/i7UvpkUnF/8QCEWtgfVINw
	M8EKQseFEp0lDcq/EzwxAUpvXDIW0ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742223408;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpFxtepf88L8eVHXNp6aoBN9MY97VlNA/euyl1tIDUs=;
	b=PEjRglb78AAkKQztbEA0BfrWxoh0zeFr316w+zs+btZhARevoeJr9K6fpg3lquVFY+SqSi
	ww9Y7/euTiM9/+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EFBE139D2;
	Mon, 17 Mar 2025 14:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0msnDzA42GeieAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Mar 2025 14:56:48 +0000
Date: Mon, 17 Mar 2025 15:56:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
	linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	wqu@suse.com
Subject: Re: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
Message-ID: <20250317145647.GX32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741631234.git.rgoldwyn@suse.com>
 <9ebfbb2024c3c4bfb334a37cde0ecb0c4e26ee5c.1741631234.git.rgoldwyn@suse.com>
 <20250312140807.GO32661@twin.jikos.cz>
 <9c4856d2-50db-4c39-ade7-7afed2eea502@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c4856d2-50db-4c39-ade7-7afed2eea502@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 13, 2025 at 10:24:32AM +1030, Qu Wenruo wrote:
> 在 2025/3/13 00:38, David Sterba 写道:
> > On Mon, Mar 10, 2025 at 03:29:07PM -0400, Goldwyn Rodrigues wrote:
> >> @@ -1731,30 +1711,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
> >>   	 */
> >>   	bio_ctrl->submit_bitmap = (unsigned long)-1;
> >>
> >> -	/*
> >> -	 * If the page is dirty but without private set, it's marked dirty
> >> -	 * without informing the fs.
> >> -	 * Nowadays that is a bug, since the introduction of
> >> -	 * pin_user_pages*().
> >> -	 *
> >> -	 * So here we check if the page has private set to rule out such
> >> -	 * case.
> >> -	 * But we also have a long history of relying on the COW fixup,
> >> -	 * so here we only enable this check for experimental builds until
> >> -	 * we're sure it's safe.
> >> -	 */
> >> -	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
> >> -	    unlikely(!folio_test_private(folio))) {
> >> -		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >> -		btrfs_err_rl(fs_info,
> >> -	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
> >> -			     inode->root->root_key.objectid,
> >> -			     btrfs_ino(inode), folio_pos(folio));
> >> -		ret = -EUCLEAN;
> >> -		goto done;
> >> -	}
> >> -
> >> -	ret = set_folio_extent_mapped(folio);
> >> +	ret = btrfs_set_folio_subpage(folio);
> >
> > The removed part is from a recent patch "btrfs: reject out-of-band dirty
> > folios during writeback" to make sure we don't really need the fixup
> > worker. So with the rework to remove EXTENT_FOLIO_PRIVATE it's changing
> > the logic a again. I'm not sure we should do both in one release, merely
> > from the point of caution and making 2 changes at once.
> >
> > I can keep the 2 patches in misc-next and move them to for-next once the
> > 6.15 pull request is out so you don't have to track them yourself.
> >
> > Also question to Qu, if you think the risk is minimal we can take both
> > changes now.
> >
> 
> I'm hiding the new change behind EXPERIMENTAL is to get more testing
> before we're 100% sure.
> 
> Although personally speaking I'm confident the cow fixup is useless and
> are just hiding other bugs (e.g. the one I fixed for various error
> paths), but the most common objection I can remember is some hardware
> specific behaviors, that I can not verify.
> 
> So just to be extra safe, I prefer to get it tested on all architectures
> for at least 2 releases, before moving it out of experimental flag.
> 
> I totally understand Goldwyn's push for iomap integration, but I believe
> this one can be pushed a little later, as we have more low-hanging fruits:
> 
> - Fully remove the usage of folio ordered and checked
>    That's depending on the removal of cow fixup
> 
> - Remove the async extent behavior
>    So that the compression happens after the blocks are submitted as
>    bbios.
>    This allows us to handle compressed write just like any regular
>    writes, and allows us to align the writeback path to iomap.
> 
> So I still tend to delay this change.

Thanks, so I'll keep the patch in misc-next and move it to for-next
eventually.

