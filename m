Return-Path: <linux-btrfs+bounces-11049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C9A1AC41
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 23:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98499188D216
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22A41CD1E4;
	Thu, 23 Jan 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1q7eXepS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eEIIOx71";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1q7eXepS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eEIIOx71"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396901CDFA7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669605; cv=none; b=X9PF49SD7GTXNv340eGiS3Nys+RNzKgbGhIx8cEz4RVtCCHsNSutsgKTYHVaUKgE6bi2VxUUYQTtpeSC1jJI0dLZL6T9kuEryTCDDdXXcM9bww7iKzlHBbiOJ5MiKTkhiewM3nryx3ELewd6/37f9sfOXzkMsKZi12cPx1Fu5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669605; c=relaxed/simple;
	bh=J+zWjMcblPOIy+1s5ydrJC+wFKD8yebH2qjGqWDEfJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r31JYG71xdzkS6t0NO7lVVgz09HUIHNxrWovPyBSHOvtSXxVzhRiRoiONCwd5OFMxVGGYhS4jDd1bICgZ+z0OMwTKJQWyS4yFAA+RJKiRY3fTYTH1HQNlpTud/vwE2MXXleRWAIz7D2tN2HeXmQYw0LnrfLBFLdRqzgRsLFRaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1q7eXepS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eEIIOx71; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1q7eXepS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eEIIOx71; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 194151F393;
	Thu, 23 Jan 2025 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737669601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naTwUFffOZLV2MrUTFRjFBPHdisV2P0G2p81Ckd/4/0=;
	b=1q7eXepS5GI1mexI14AKR0bm6dsVRXcbRwG+3vWEUmYdHd4BXAeSfm+P7Jy1JJoiQgFF/8
	CJtVMO+2sZrfqcnpCRkmRRMZmvXsdEm5J0sBMLmZqcKsc7hmP5RiydUZ5NjfGh4GcrfzDL
	oqU3NSsWQe+tfT5pGZr5v/7W1IacGn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737669601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naTwUFffOZLV2MrUTFRjFBPHdisV2P0G2p81Ckd/4/0=;
	b=eEIIOx71seVZse3SHc6NQM0C+bo9wsSYj+EcXWBYOo0aGW/q2xfLvxsNqMuqFaiovPmYyY
	VCFfyQ3FBGkahyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737669601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naTwUFffOZLV2MrUTFRjFBPHdisV2P0G2p81Ckd/4/0=;
	b=1q7eXepS5GI1mexI14AKR0bm6dsVRXcbRwG+3vWEUmYdHd4BXAeSfm+P7Jy1JJoiQgFF/8
	CJtVMO+2sZrfqcnpCRkmRRMZmvXsdEm5J0sBMLmZqcKsc7hmP5RiydUZ5NjfGh4GcrfzDL
	oqU3NSsWQe+tfT5pGZr5v/7W1IacGn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737669601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naTwUFffOZLV2MrUTFRjFBPHdisV2P0G2p81Ckd/4/0=;
	b=eEIIOx71seVZse3SHc6NQM0C+bo9wsSYj+EcXWBYOo0aGW/q2xfLvxsNqMuqFaiovPmYyY
	VCFfyQ3FBGkahyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E84DA1351A;
	Thu, 23 Jan 2025 22:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UC40OOC7kmc/GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 Jan 2025 22:00:00 +0000
Date: Thu, 23 Jan 2025 22:59:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250123215955.GN5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 22, 2025 at 02:51:10PM +0100, Daniel Vacek wrote:
> On Wed, 22 Jan 2025 at 13:40, Filipe Manana <fdmanana@kernel.org> wrote:
> > > -       if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
> > > +       if (unlikely(val >= BTRFS_LAST_FREE_OBJECTID)) {
> > >                 btrfs_warn(root->fs_info,
> > >                            "the objectid of root %llu reaches its highest value",
> > >                            btrfs_root_id(root));
> > > -               ret = -ENOSPC;
> > > -               goto out;
> > > +               return -ENOSPC;
> > >         }
> > >
> > > -       *objectid = root->free_objectid++;
> > > -       ret = 0;
> >
> > So this gives different semantics now.
> >
> > Before we increment free_objectid only if it's less than
> > BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't assign
> > more object IDs and must return -ENOSPC.
> >
> > But now we always increment and then do the check, so after some calls
> > to btrfs_get_free_objectid() we wrap around the counter due to
> > overflow and eventually allow reusing already assigned object IDs.
> >
> > I'm afraid the lock is still needed because of that. To make it more
> > lightweight maybe switch the mutex to a spinlock.
> 
> How about this?
> 
> ```
> retry:  val = atomic64_read(&root->free_objectid);
>         ....;
>         if (atomic64_cmpxchg(&root->free_objectid, val, val+1) != val)
>                 goto retry;
>         *objectid = val;
>         return 0;
> ```

Doesn't this waste some ids when there are many concurrent requests?

