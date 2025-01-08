Return-Path: <linux-btrfs+bounces-10796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FFA064B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9143A11FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E29203718;
	Wed,  8 Jan 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YnoZgB+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rcoZpywd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YnoZgB+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rcoZpywd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED980202C47;
	Wed,  8 Jan 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361355; cv=none; b=TelXSCsymfwgjrxLecXtLYYaFe/TVI2z9moBXizKijiR9BUNY6Og6lvJX3T2liBEwRvgvtRshBrb7sCNOFgUrOE/of+Z58/Ecy6ArlNvPFJyYyL0u31oiS+f9QgOExFrPQ74/Ic36MUP1UGRmsW4SiAJCAP1akDLuZsU1UCbylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361355; c=relaxed/simple;
	bh=h6gdF6WdgCQXqWBHBUPYIDFxucfii5n8fwIZeq4iJi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JneQep9Rynt++l7EyVr7/BC9K0Uzw/LmofHYS/y13vglCUZs1/UZKj+Kpit7vSqorukuvxbaSpoG/w+6S5dZnubuI/TLOqClt3d2zoC/aSyyfe5fKLartgGP+xtnsUOsqrcZT7EhrHfi9UgwmyTb7li7kZObji7jObBTjDTmCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YnoZgB+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rcoZpywd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YnoZgB+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rcoZpywd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C21C210F4;
	Wed,  8 Jan 2025 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736361352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plvjekgwDTnraVzrJKGc1cObxp3DavlxjwUs3bB9I3k=;
	b=YnoZgB+n2ti8QeJPtB2ts3ljYrD4731sJ1rXfAx1ZHlHPE4oCwCXtNwQ2hgekF15lQoYXQ
	iGsY1ndEXjXN3DA3jDBCXrrA/KBvLW3L47q7aOQir7o/BNTRT4UkM2Fz91RxepFHmFNekk
	84TpHbWy1U+DcuxvzFtVn/wFFSRr17Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736361352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plvjekgwDTnraVzrJKGc1cObxp3DavlxjwUs3bB9I3k=;
	b=rcoZpywdJrDS+A4ZSpB2sotr93+fpxHRSmeogxIrZlLdNnNVh5wcL0SYw/QjCqV6ZVR5lI
	B9WRUAIdeN1PA7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736361352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plvjekgwDTnraVzrJKGc1cObxp3DavlxjwUs3bB9I3k=;
	b=YnoZgB+n2ti8QeJPtB2ts3ljYrD4731sJ1rXfAx1ZHlHPE4oCwCXtNwQ2hgekF15lQoYXQ
	iGsY1ndEXjXN3DA3jDBCXrrA/KBvLW3L47q7aOQir7o/BNTRT4UkM2Fz91RxepFHmFNekk
	84TpHbWy1U+DcuxvzFtVn/wFFSRr17Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736361352;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plvjekgwDTnraVzrJKGc1cObxp3DavlxjwUs3bB9I3k=;
	b=rcoZpywdJrDS+A4ZSpB2sotr93+fpxHRSmeogxIrZlLdNnNVh5wcL0SYw/QjCqV6ZVR5lI
	B9WRUAIdeN1PA7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED06F1351A;
	Wed,  8 Jan 2025 18:35:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DAqoOYfFfmeHGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 08 Jan 2025 18:35:51 +0000
Date: Wed, 8 Jan 2025 19:35:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Message-ID: <20250108183550.GA2097@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250108114326.1729250-1-neelx@suse.com>
 <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
 <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com>
 <c51c6cc1-4bc5-48d0-adce-a8d8d63227ce@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51c6cc1-4bc5-48d0-adce-a8d8d63227ce@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,wdc.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 08, 2025 at 06:29:24PM +0000, Johannes Thumshirn wrote:
> On 08.01.25 16:25, Daniel Vacek wrote:
> > On Wed, 8 Jan 2025 at 13:42, Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 08.01.25 12:44, Daniel Vacek wrote:
> >>> Only allocate the `priv` struct from slab for asynchronous mode.
> >>>
> >>> There's no need to allocate an object from slab in the synchronous mode. In
> >>> such a case stack can be happily used as it used to be before 68d3b27e05c7
> >>> ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> >>> which was a preparation for the async mode.
> >>>
> >>> While at it, fix the comment to reflect the atomic => refcount change in
> >>> d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
> >>
> >>
> >> Generally I'm not a huge fan of conditional allocation/freeing. It just
> >> complicates matters. I get it in case of the bio's bi_inline_vecs where
> >> it's a optimization, but I fail to see why it would make a difference in
> >> this case.
> >>
> >> If we're really going down that route, there should at least be a
> >> justification other than "no need" to.
> > 
> > Well the main motivation was not to needlessly exercise the slab
> > allocator when IO uring is not used. It is a bit of an overhead,
> > though the object is not really big so I guess it's not a big deal
> > after all (the slab should manage just fine even under low memory
> > conditions).
> > 
> > 68d3b27e05c7 added the allocation for the async mode but also changed
> > the original behavior of the sync mode which was using stack before.
> > The async mode indeed requires the allocation as the object's lifetime
> > extends over the function's one. The sync mode is perfectly contained
> > within as it always was.
> > 
> > Simply, I tend not to do any allocations which are not strictly
> > needed. If you prefer to simply allocate the object unconditionally,
> > we can just drop this patch.
> 
> At the end of the day it's David's call, he's the maintainer. I'm just 
> not sure if skipping the allocator for a small short lived object is 
> worth the special casing. Especially as I got bitten by this in the past 
> when hunting down kmemleak reports. Conditional allocation is like 
> conditional locking, sometimes OK but it raises suspicion.

Yeah, in this case it's the uring that makes the allocation/freeing
times different. The "normal" ioctl case does not need it so I think
it's keeping the scope clear while the uring has it's own specialities
like returing to user space with inode lock held
(22d2e48e318564f8c9b09faf03ecb4f03fb44dd5).

