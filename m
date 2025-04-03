Return-Path: <linux-btrfs+bounces-12776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF02A7AFBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E3D7A795F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EEC25A2C1;
	Thu,  3 Apr 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IztILBte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S84XzTkP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IztILBte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S84XzTkP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2997224FA
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710080; cv=none; b=c1CbX4dedyMkekr5rLKUCuY0Nvjr8g14qJL8+llgAs640LPx8dSJizfbTnCgeNFzqs99Hq4WbvL+nTfYVFAvWoGJuR/hYv+ZKhlzByJNwJy5Rm0venjgMt6RYh22xU6/OPhu06tr3xzE4/Ga7lrhGXpKpBHHh9rHy0u+DIy1q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710080; c=relaxed/simple;
	bh=+C+oFBBHxsGesx9JJeKLyLQ2+TEvyHNdBM+gr4mCfu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9t4QjJV05NCaYGvIyZFJGKNYgJDI8d2Bgy0yoBaOar5dIqnTsQFuhhSFGxfGKBRrCg8htrOfMj2yiHdHjIACn3bpfVKkrxeaD987Jp1WXVxb4X/9zIUWJE2Pv7hL/IC7HWdIb8EtlsamEBg7YB6xmlPqsWh9d/VP43SyY2rJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IztILBte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S84XzTkP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IztILBte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S84XzTkP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F410F1F387;
	Thu,  3 Apr 2025 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743710077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owhSm6530HgxTPuV2+pH23yqwhD2k8YPCNDUfN7aiuc=;
	b=IztILBteOXzt0ckwXaNgQLLtbSZILS8bnoGiL7MQXd0/vvRJgm5/tkURVLNun3GnJZchcp
	v1ECIxxtvRUj0OxrJ4P7fENr6OaXtFTMV5wQ11fO02OLs82tXrt4RHk+GHdlcP+d3QQFTs
	px6Yvf2PZmdr9FAaEv71u7K7FFqxGPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743710077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owhSm6530HgxTPuV2+pH23yqwhD2k8YPCNDUfN7aiuc=;
	b=S84XzTkPTO1vPW/g+coIcu4EBhFKR+CzSFPeoZJ0WEHXhMWseCV9kFIEuJDWivscC1MHIR
	0I5caLx9S9T9hZDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743710077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owhSm6530HgxTPuV2+pH23yqwhD2k8YPCNDUfN7aiuc=;
	b=IztILBteOXzt0ckwXaNgQLLtbSZILS8bnoGiL7MQXd0/vvRJgm5/tkURVLNun3GnJZchcp
	v1ECIxxtvRUj0OxrJ4P7fENr6OaXtFTMV5wQ11fO02OLs82tXrt4RHk+GHdlcP+d3QQFTs
	px6Yvf2PZmdr9FAaEv71u7K7FFqxGPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743710077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owhSm6530HgxTPuV2+pH23yqwhD2k8YPCNDUfN7aiuc=;
	b=S84XzTkPTO1vPW/g+coIcu4EBhFKR+CzSFPeoZJ0WEHXhMWseCV9kFIEuJDWivscC1MHIR
	0I5caLx9S9T9hZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D471613A2C;
	Thu,  3 Apr 2025 19:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9R2fM3zn7mfeNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Apr 2025 19:54:36 +0000
Date: Thu, 3 Apr 2025 21:54:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/9] btrfs: remove ASSERT()s for folio_order() and
 folio_test_large()
Message-ID: <20250403195427.GT32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742195085.git.wqu@suse.com>
 <20250317135502.GW32661@twin.jikos.cz>
 <20250317151312.GZ32661@twin.jikos.cz>
 <e9b76101-d14b-43ed-bd9c-97a5978f4d59@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9b76101-d14b-43ed-bd9c-97a5978f4d59@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 31, 2025 at 03:17:35PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/18 01:43, David Sterba 写道:
> > On Mon, Mar 17, 2025 at 02:55:02PM +0100, David Sterba wrote:
> >> On Mon, Mar 17, 2025 at 05:40:45PM +1030, Qu Wenruo wrote:
> >>> [CHANGELOG]
> >>> v3:
> >>> - Prepare btrfs_end_repair_bio() to support larger folios
> >>>    Unfortunately folio_iter structure is way too large compared to
> >>>    bvec_iter, thus it's not a good idea to convert bbio::saved_iter to
> >>>    folio_iter.
> >>>
> >>>    Thankfully it's not that complex to grab the folio from a bio_vec.
> >>>
> >>> - Add a new patch to prepare defrag for larger data folios
> >>
> >> I was not expecting v3 as the series was in for-next so I did some edits
> > [...]
> >
> > Scratch that, this is not the same series.
> >
> 
> BTW, any extra commends needs to be addressed? (E.g. should I merge them
> all into a single patch?)

I think the patch separation is good, please leave it as it is.

> I notice several small comment conflicts ("larger folio -> large
> folio"), but is very easy to resolve (local branch updated).
> 
> There is a newer series that is already mostly reviewed:
> 
> https://lore.kernel.org/linux-btrfs/cover.1743239672.git.wqu@suse.com/
> 
> That relies on this series, and I'm already doing some basic (fsstress
> runs) large folio tests now.
> 
> So I'm wondering can I push the series now, or should I continue waiting
> for extra reviews?

Please add it to for-next. I did only a light review, we'll find more
things during testing.

