Return-Path: <linux-btrfs+bounces-13057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D4A8B3CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AB43A84A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC222F155;
	Wed, 16 Apr 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ifx4SRJI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rwIa/3/P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7RuNZ1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uGxW/h45"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315122D787
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792122; cv=none; b=UkrMF0s/yNBwVTdxhltl2fAm/SrnxAy9ee5CftOamNyC2nuMa3SrXVFVZ3n94GYdv0v0814EXYaX6+TKigZPv4uJp6VQTxv0XPEpM9pVYJP1Exj9OrHYqd2H2QK6DIkkA1YfHqB5IStG6EN2cmChJ4sKjn+0+ClwH9iHzNkBmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792122; c=relaxed/simple;
	bh=389oqVU09k6/+vNeLjbwQAT/38yRQL+8QVKDK+IgkUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnKIgiAx0makPra4cSrl1LschOgUjFUvDh8AJ9YrhrvEMB3F8Q/0a5ME+wyD2Y1L58P8fqOKKsFpNGIeR2FGtPxp2L9cA5Ikhp2jJjw0ASz9xiWRVFnIfm9GHk1uJkWuJYuCtSLJkqJ/DX9LE0aKpINgM2H9W5lMyQvTlDyJLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ifx4SRJI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rwIa/3/P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b7RuNZ1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uGxW/h45; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D98EC2118F;
	Wed, 16 Apr 2025 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744792113;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MuZw90YNkNYbnkouBAS90gtgKDps4LiIp8MEB2R8aM=;
	b=Ifx4SRJIWLerNIueEKfuGBMKOBKOM1AYS/h/ZXZa27CYoe980e/xL2uaOirOKo+siXDWau
	EmYHn1HKaxgustSYm3DCvTyDfuKqymtMT0+YMj7F+F1KA8KavuD4hldGtwrj3fQabXw4fY
	wim6ftWUmmZ+XIH/u/otOU7dhdF4mbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744792113;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MuZw90YNkNYbnkouBAS90gtgKDps4LiIp8MEB2R8aM=;
	b=rwIa/3/PQQCL+uZ/PrQijWI181xbSonFHnXLKzwX3VgHLssFcI2afWM9wjyMuu/FjnxP5u
	4Y6nRDuwdS8mJQBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=b7RuNZ1I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="uGxW/h45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744792112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MuZw90YNkNYbnkouBAS90gtgKDps4LiIp8MEB2R8aM=;
	b=b7RuNZ1Iphr38e6WAGd0RhKryzZHKhha04amU4ZCYNk+pFvTkaew6ePjQHU/daUZiw0rfx
	wtWcXhhvfwc4ET7PYnVvFwF7qIxWCqUbWCBhblnB+kFJSB5wwdFkchtappiEP3HCTRttXF
	m4j12rmeepaIVCKrbPBeEurBar2atTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744792112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MuZw90YNkNYbnkouBAS90gtgKDps4LiIp8MEB2R8aM=;
	b=uGxW/h451t1qZ6PyLeujiLH2n3VjXoauFf1u8gsMg4ukgMCcas/wl6AYk0iYAu5fLEbYzY
	JU8Jm1m9KPr4+7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8219139A1;
	Wed, 16 Apr 2025 08:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pzHELDBq/2dvXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 08:28:32 +0000
Date: Wed, 16 Apr 2025 10:28:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
Message-ID: <20250416082831.GA13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744344865.git.wqu@suse.com>
 <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain>
 <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
 <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com>
 <20250415181841.GN16750@twin.jikos.cz>
 <CAHp75Vf3Z=qQPKkALhCbSSCd9VYiYYZ4xVJ9aT=sYKW7tbPd2A@mail.gmail.com>
 <408fff7f-00a9-41ec-91e6-168dcffb2de6@gmx.com>
 <CAHp75VdJoPKoYu=fOZYPV6Cd+rgcWVM9_NDJ-Gyu3O33tS447w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdJoPKoYu=fOZYPV6Cd+rgcWVM9_NDJ-Gyu3O33tS447w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D98EC2118F
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Wed, Apr 16, 2025 at 08:57:40AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 16, 2025 at 2:57 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > 在 2025/4/16 03:51, Andy Shevchenko 写道:
> > > On Tue, Apr 15, 2025 at 9:18 PM David Sterba <dsterba@suse.cz> wrote:
> > >> On Mon, Apr 14, 2025 at 01:40:11PM +0300, Andy Shevchenko wrote:
> > >>> On Mon, Apr 14, 2025 at 4:20 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >>>> 在 2025/4/13 04:05, Andy Shevchenko 写道:
> > >>>>> Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:
> 
> [...]
> 
> > >>>>>> +    block_start = round_down(clamp_start, block_size);
> > >>>>>> +    block_end = round_up(clamp_end + 1, block_size) - 1;
> > >>>>>
> > >>>>> LKP rightfully complains, I believe you want to use ALIGN*() macros instead.
> > >>>>
> > >>>> Personally speaking I really want to explicitly show whether it's
> > >>>> rounding up or down.
> > >>>>
> > >>>> And unfortunately the ALIGN() itself doesn't show that (meanwhile the
> > >>>> ALIGN_DOWN() is pretty fine).
> > >>>>
> > >>>> Can I just do a forced conversion on the @blocksize to fix the warning?
> > >>>
> > >>> ALIGN*() are for pointers, the round_*() are for integers. So, please
> > >>> use ALIGN*().
> > >>
> > >> clamp_start and blocksize are integers and there's a lot of use of ALIGN
> > >> with integers too. There's no documentation saying it should be used for
> > >> pointers, I can see PTR_ALIGN that does the explicit cast to unsigned
> > >> logn and then passes it to ALIGN (as integer).
> > >
> > > Yes, because the unsigned long is natural holder for the addresses and
> > > due to some APIs use it instead of pointers (for whatever reasons) the
> > > PTR_ALIGN() does that. But you see the difference? round_*() expect
> > > _the same_ types of the arguments, while ALIGN*() do not. That is what
> > > makes it so.
> > >
> > >> Historically in the btrfs code the use of ALIGN and round_* is basically
> > >> 50/50 so we don't have a consistent style, although we'd like to. As the
> > >> round_up and round_down are clear I'd rather keep using them in new
> > >> code.
> > >
> > > And how do you suggest avoiding the warning, please?
> >
> > By fixing the typo, @block_size -> @blocksize.
> 
> Ah, if it's that simple, of course, round_*() is okay to go.
> My only worries are about explicit castings to "fix" such a warning.

Both ALIGN and round_* seem to be fine with different types, there are
the tricks with masking lower bits and the alignment is explicitly cast
to the target type. Most offten we have u64 as target type and u32 as
the alignment.

