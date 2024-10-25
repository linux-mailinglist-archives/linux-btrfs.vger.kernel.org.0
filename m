Return-Path: <linux-btrfs+bounces-9184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658179B1286
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 00:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2741C21A1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 22:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349320F3D3;
	Fri, 25 Oct 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LTrzwYzR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m/9sM1/W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LTrzwYzR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m/9sM1/W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37D1C174E;
	Fri, 25 Oct 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894930; cv=none; b=rkAAQ1NlK409NwE5Q7PbpkkVfgzwuwuepXLMjtywuN6FiAWUP5m07IJvtHS6HuMH1mP/k7KlynfmsaLh+gXL2NBBz+MyPSoeeT7uJR4olKHOYNq76F7ZvidTVoNWiAN5CxBQUC8/voyKQRxEzbRJxbw+mg500COGTMW1d2k2or4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894930; c=relaxed/simple;
	bh=fV4xDVjyhMrSEMmGfx7eBIg3rSFhxr205p7s4hbzZZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxatvDwc6Vih+Zntgkw0SoQyHqhJmxpKoog4IGZc4+7SE077EgmklmVjfqJ66vaQuR1ojb9Kez8aft66bwspmbgB+yi+Rby+R1i+/jCTsxK51dMwh8TZ/ZlpKgB+txJd1NDMyGWfYpXD08FwmN61h1Zduxfbl8Hbgb0TSVXW+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LTrzwYzR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m/9sM1/W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LTrzwYzR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m/9sM1/W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7A9121B86;
	Fri, 25 Oct 2024 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729894926;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhxniRESINQJl/okCoIXAaBuXZ1HfdaC5KzvVuQSMCI=;
	b=LTrzwYzR59NF5iqNQj6cfqtLpDaveZQ8gdWXkXa4uK9ijrmMNUfgVU0MAR8q1UnVFC2f5/
	0OgmhlQb8XLlw6eaCaE2/1MAx29g1f/MJo+9MkSkPgqP/6JCFax9aV8eVYcY82tP23yaOs
	hYTVoo1llEWoXTzxnGs4+/HCIRU9heg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729894926;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhxniRESINQJl/okCoIXAaBuXZ1HfdaC5KzvVuQSMCI=;
	b=m/9sM1/W/EdgfNsyNkuXFYeHn+bOqrEDEvdcChUn1t2AdSKmXomdsU19sbhORpMBRLEiH8
	xyXENJny4iPT+CBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729894926;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhxniRESINQJl/okCoIXAaBuXZ1HfdaC5KzvVuQSMCI=;
	b=LTrzwYzR59NF5iqNQj6cfqtLpDaveZQ8gdWXkXa4uK9ijrmMNUfgVU0MAR8q1UnVFC2f5/
	0OgmhlQb8XLlw6eaCaE2/1MAx29g1f/MJo+9MkSkPgqP/6JCFax9aV8eVYcY82tP23yaOs
	hYTVoo1llEWoXTzxnGs4+/HCIRU9heg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729894926;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhxniRESINQJl/okCoIXAaBuXZ1HfdaC5KzvVuQSMCI=;
	b=m/9sM1/W/EdgfNsyNkuXFYeHn+bOqrEDEvdcChUn1t2AdSKmXomdsU19sbhORpMBRLEiH8
	xyXENJny4iPT+CBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C769132D3;
	Fri, 25 Oct 2024 22:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V/sWHg4aHGcKYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 22:22:06 +0000
Date: Sat, 26 Oct 2024 00:22:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com, clm@fb.com,
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root
Message-ID: <20241025222205.GN31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
 <20241025045553.2012160-1-lizhi.xu@windriver.com>
 <03bcaafe-4a15-487a-af2b-b23970162bbb@gmx.com>
 <20241025180315.GI31418@twin.jikos.cz>
 <e5bc8c4e-771f-4cc7-91e7-291018b9468c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5bc8c4e-771f-4cc7-91e7-291018b9468c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[3030e17bd57a73d39bd7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Sat, Oct 26, 2024 at 07:33:59AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/26 04:33, David Sterba 写道:
> > On Fri, Oct 25, 2024 at 08:23:07PM +1030, Qu Wenruo wrote:
> >>
> >>
> >> 在 2024/10/25 15:25, Lizhi Xu 写道:
> >>> Syzbot report a null-ptr-deref in btrfs_search_slot.
> >>> It use the input logical can't find the extent root in extent_from_logical,
> >>> and triger the null-ptr-deref in btrfs_search_slot.
> >>> Add sanity check for btrfs root before using it in btrfs_search_slot.
> >>
> >> Although I'd prefer to explain a little more about why the NULL root
> >> pointer can happen (caused by the rescue=all mount option), which can
> >> cause NULL root pointer for non-critical tree roots, like
> >> uuid/csum/extent or even device trees.
> >>
> >> You don't need to bother sending an update.
> >> I can add such info when pushing to the maintainer's tree.
> >>
> >>>
> >>> Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
> >>> Closes: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
> >>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> >>> @@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >>>    	int min_write_lock_level;
> >>>    	int prev_cmp;
> >>>
> >>> +	if (!root)
> >>> +		return -EINVAL;
> >
> > The function returns errors indirectly so it's not clear which could be
> > ultimately returned. I did a quick search over the calls starting in
> > btrfs_search_slot() and it seems that EINVAL is not used so we'd know if
> > it ends up in some error report. The ones I found: EAGAIN, EIO, EUCLEAN,
> > ENOMEM.
> 
> If you want, I can add extra (ratelimited though) error/warning message
> for such cases.
> 
> Considering this is only possible for rescue=all cases, extra error
> messages should be fine.
> 
> Or do you prefer some more rare return values?

I haven't thought about printing a message, even with rate limiting it
could be noisy and I don't see what information would it bring to the
user, namely in combination with the rescue=all.

The error from search slot can bubble up from various functions, though
with the missing csum tree it's probably not that many. The only other
error code that's remotely relevant is ENOENT (no such entry), but this
is more suitable for entries in structures, not whole structures.

Even if we'd use some random error, the string for the error code would
be misleading. So let's keep EINVAL for now.

