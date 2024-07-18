Return-Path: <linux-btrfs+bounces-6543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95B934E4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA8B1C219D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738BC13E3F6;
	Thu, 18 Jul 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxiM+Fv7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a4xTJAAq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxiM+Fv7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a4xTJAAq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4713D2A9;
	Thu, 18 Jul 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309827; cv=none; b=nXn1NIHMKuWwl7fJ8E/Py11WGwZyoPBEz/RIErG+7MJN+OZ8m+nc6JUt5u5ytP3vIH2avghpP2dSfpnoI0pJqv1KEhJWp5/QTYooNO1ndzbnF3anFZVvVC1ytOgiPzfRwLOfHRMKVgNfDBa0K21DqQ3SAc8mRxpf8LMa3jaDbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309827; c=relaxed/simple;
	bh=IxzQVedj8HjeYrtYiiT/ZIo17tYJbx0z7fBH4Ca/L80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFg06USVpKTEdWEIrnAlIx5tutPSFMsD77NPLZITLQ3Rm6jwr8+K9o7fSTbVumywHmmQte4ptBojys/78eUJCvsgPlWZ16ob0U4KTtlX61gn42rfMq9VYtIFIdzQrI8msk/uxoNrM0WWWo2kEmU5LWoGKWyhXkLab4A1P1SwLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxiM+Fv7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a4xTJAAq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxiM+Fv7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a4xTJAAq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1181F395;
	Thu, 18 Jul 2024 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721309823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnHHRnpfO9jAdEpLbj2fGiz87wmhvdQ209v3Jxvxsp0=;
	b=wxiM+Fv70jqRiow+TYRbVDQzEofhHiYABjpcxKcf8VftMH5lmOfKV1l20di+82Em04z3pb
	1eZ1hGHLGiSoNeWoDmqa0L0mIY/GlYGicH5EUcuwfSFcV03dKXi/AzAwqSYNt1KwaNn42J
	y3dTMbd0uPRbrvsyvBa7r4i5TjfxXfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721309823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnHHRnpfO9jAdEpLbj2fGiz87wmhvdQ209v3Jxvxsp0=;
	b=a4xTJAAq+onypgGhYwrypBrJymHqkZv1G0CpcYfriS2pnO7++wxFka5GwFGXUdhjzX0fDg
	TmDU8mklRYZ1s9Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wxiM+Fv7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a4xTJAAq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721309823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnHHRnpfO9jAdEpLbj2fGiz87wmhvdQ209v3Jxvxsp0=;
	b=wxiM+Fv70jqRiow+TYRbVDQzEofhHiYABjpcxKcf8VftMH5lmOfKV1l20di+82Em04z3pb
	1eZ1hGHLGiSoNeWoDmqa0L0mIY/GlYGicH5EUcuwfSFcV03dKXi/AzAwqSYNt1KwaNn42J
	y3dTMbd0uPRbrvsyvBa7r4i5TjfxXfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721309823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bnHHRnpfO9jAdEpLbj2fGiz87wmhvdQ209v3Jxvxsp0=;
	b=a4xTJAAq+onypgGhYwrypBrJymHqkZv1G0CpcYfriS2pnO7++wxFka5GwFGXUdhjzX0fDg
	TmDU8mklRYZ1s9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60F921379D;
	Thu, 18 Jul 2024 13:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dUxxF38amWbhCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Jul 2024 13:37:03 +0000
Date: Thu, 18 Jul 2024 15:37:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.11
Message-ID: <20240718133701.GG8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1721066206.git.dsterba@suse.com>
 <CAHk-=wgw9uyrpi+qL28Ee650p7jaXEMjUoRzXBymraoENDMt6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgw9uyrpi+qL28Ee650p7jaXEMjUoRzXBymraoENDMt6w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 7B1181F395

On Wed, Jul 17, 2024 at 01:21:17PM -0700, Linus Torvalds wrote:
> On Mon, 15 Jul 2024 at 11:12, David Sterba <dsterba@suse.com> wrote:
> >
> > There's a merge conflict caused by the latency fixes from last week in
> > extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
> > and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
> > been in linux-next for a few days.
> 
> Oh, and I notice that my resolution is slightly different, but looks
> like the actual code is equivalent.
> 
> I kept the "q" logic that had been introduced by commit 4e660ca3a98d
> ("btrfs: use a regular rb_root instead of cached rb_root for
> extent_map_tree").
> 
> I don't know how you prefer the code, but it kept the two "while
> (node)" loops in that file looking similar.

That is fine, keeping the same style makes sense.

> Of course, they were very different in other respects (ie
> drop_all_extent_maps_fast() does all extents unconditionally with that
> retry logic, while btrfs_scan_inode() has that whole "bail out on any
> contention" model, so whatever.
> 
> Anyway, it all *looks* ok to me, but please go and double-check that I
> didn't mess something up.

Looks correct to me as well.

