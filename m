Return-Path: <linux-btrfs+bounces-17078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92347B90536
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6333A1897859
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B61303A22;
	Mon, 22 Sep 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuRvxzx0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mUa+XsKH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuRvxzx0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mUa+XsKH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782C2FC01B
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539760; cv=none; b=mC6Yf/fyVGJ4sMerIyP3j/LWarUMbSh2pWwMzvx2k4HPL5JGtoJcrllNr8pv97npS9b4u+tJ6SWCEom0odDwkuVvU5ejS6R403iwfrOJuyh5kcogctuMY1PZPSss37wyT1g6mTmJMpoNl0H5fnYBX1B+uXEtK8+qU7EbcgZRIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539760; c=relaxed/simple;
	bh=G3q2LTy/TKxBrpjNYpTTUjZRukOUmv6JY8aWdjwUOR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYkR/fQHwoSvipdXKRCEVcO6Gg/UKDhZXSHuLKjNWurrA0TnXu6bC4d/Zo8XLq/gagvkBGEQIDPMPC1chOjfirf2mtznCNuSwjNOBhowaJ++suYXGpVq0bshpra5Oi/Fxyys6z1D8jgZTwWF/j1ZbQhxcevRdjjhTCrktA5Uknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuRvxzx0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mUa+XsKH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuRvxzx0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mUa+XsKH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5931206C5;
	Mon, 22 Sep 2025 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758539755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RIrYxj0JhECFNoE7h9szi/OxJOtKA5wZ2iWLDCQk6A=;
	b=WuRvxzx0QMOTg00XbUhsb6wcAL6EXq+uJX2I3ph4FvW12l6DS4WOiNn4e2j7Xe5C+bwXeu
	PzB/YfBIWhVfCTRtXEvcqTeDb+N4aw1QdU+i1q8hu4hUS5qbDqmGAD7FzreQ5/HIKw/35a
	/vP8jAnXNaP9Ae9MTxqvEWDaak0cJSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758539755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RIrYxj0JhECFNoE7h9szi/OxJOtKA5wZ2iWLDCQk6A=;
	b=mUa+XsKHvm6qunozOXGLQUjrE5H4HHPXFE/NQJcAJQ002j5v13v4nikyV8pwS9bukbO6D7
	0f7OGTHHno6RfxAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758539755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RIrYxj0JhECFNoE7h9szi/OxJOtKA5wZ2iWLDCQk6A=;
	b=WuRvxzx0QMOTg00XbUhsb6wcAL6EXq+uJX2I3ph4FvW12l6DS4WOiNn4e2j7Xe5C+bwXeu
	PzB/YfBIWhVfCTRtXEvcqTeDb+N4aw1QdU+i1q8hu4hUS5qbDqmGAD7FzreQ5/HIKw/35a
	/vP8jAnXNaP9Ae9MTxqvEWDaak0cJSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758539755;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RIrYxj0JhECFNoE7h9szi/OxJOtKA5wZ2iWLDCQk6A=;
	b=mUa+XsKHvm6qunozOXGLQUjrE5H4HHPXFE/NQJcAJQ002j5v13v4nikyV8pwS9bukbO6D7
	0f7OGTHHno6RfxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF2631388C;
	Mon, 22 Sep 2025 11:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3A5cMusv0Wh9TQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 11:15:55 +0000
Date: Mon, 22 Sep 2025 13:15:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] Unlikely annotations for EIO/EUCLEAN/abort
 branches
Message-ID: <20250922111546.GO5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1758130856.git.dsterba@suse.com>
 <CAL3q7H6iGyeCzY4GZ62d3p7MPhKoW95K-Cu+H4fmaoX9EH6VnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6iGyeCzY4GZ62d3p7MPhKoW95K-Cu+H4fmaoX9EH6VnA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Sep 18, 2025 at 04:03:49PM +0100, Filipe Manana wrote:
> On Wed, Sep 17, 2025 at 6:54 PM David Sterba <dsterba@suse.com> wrote:
> >
> > Hi,
> >
> > manually add unlikely annotations to the branches that lead to critical
> > but rare errors. This is RFC as this has a big conflict surface.
> > However this would be a one-time action, possibly done now before 6.18
> > freeze.
> >
> > The base is current for-next (without series [1]):
> >
> >    text    data     bss     dec     hex filename
> > 1650172  136289   15560 1802021  1b7f25 pre/btrfs.ko
> > 1650934  136289   15560 1802783  1b821f post/btrfs.ko
> > DELTA: +762
> >
> > There are differences in the generated assembly so the compiler does not
> > detect the error branches as unlikely by itself (sometimes it does due
> > to __cold function annotations).
> >
> > I've used my prototype branch from some time ago so some of the
> > annotations could be still missing, this is more about getting the idea
> > of the scope.
> 
> Just glancing and it seems good to me.
> It would be nice to add a changelog to the patches, despite being trivial.

Thanks, yes I'll add changelogs, for future reference where the
unlikely() is OK.

