Return-Path: <linux-btrfs+bounces-16512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E55B3AE6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C273D1B241F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A52D8DD4;
	Thu, 28 Aug 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0i/Vu8C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S43Q05el";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0i/Vu8C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S43Q05el"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E82DCBF8
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423817; cv=none; b=mYAhzAzAwkE/kYdWpuBRsR+cPRnHMSzTuSc1v7QZZcZxJynaFo3wudgE5P5qsJbFhw8b5RZ9rAcL+YgoY9zjt8WqP44pqlrfIsJ3PqFSRlgx3mecTN+JRR2xVVds8LUYj5KDR1v8pcym5SIdj+FsDgYqOBssteRa4ViHtnQPnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423817; c=relaxed/simple;
	bh=dUVUApAo2P2ad5noY9N0TGQKDczSFr4EsX5R+Q7QhkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcJ8F8Kt4fopzgYsbszmprAyiKS1kcXQV9hVIEoDYrLE4B8cI++T9Dulnwx8Oa3gtEUwgRpGFWciYkiHcZhr2+rEX0VM5lj5bq9qj2td51/5yP9qHuo087K0HB2mpc1C+8FzgxXtNWmPNHofkjh8QQtnQq6bL+YokJkQ90alP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0i/Vu8C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S43Q05el; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0i/Vu8C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S43Q05el; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8A4D20FA3;
	Thu, 28 Aug 2025 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756423812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnklqjDPyWrFxl+RTEEx3wl9QXo7wEyO8fv7x+gneG8=;
	b=r0i/Vu8C70GXdPJlt+Ixiow7Ut2EOqctIPV7Kv4mKLXIlhWcHX7o6EzHLqxnYP2kblCfu7
	EfWW881IyzMaUzp0WMxhhIrgnYT7J6/JkXxWtIV2iVmNlNYh1oS4kt7xLlme19nH1+49pY
	91zxBvtyDfEjqFcEolm/wmYukxnbHN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756423812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnklqjDPyWrFxl+RTEEx3wl9QXo7wEyO8fv7x+gneG8=;
	b=S43Q05elkoXsri/pnnHVeWYlvHm8KsTMCalehL3Kpx82mXX0KVpn1SKNo80WrA+8ZNOXK0
	spHMe/KPH0rmfLCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="r0i/Vu8C";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S43Q05el
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756423812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnklqjDPyWrFxl+RTEEx3wl9QXo7wEyO8fv7x+gneG8=;
	b=r0i/Vu8C70GXdPJlt+Ixiow7Ut2EOqctIPV7Kv4mKLXIlhWcHX7o6EzHLqxnYP2kblCfu7
	EfWW881IyzMaUzp0WMxhhIrgnYT7J6/JkXxWtIV2iVmNlNYh1oS4kt7xLlme19nH1+49pY
	91zxBvtyDfEjqFcEolm/wmYukxnbHN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756423812;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnklqjDPyWrFxl+RTEEx3wl9QXo7wEyO8fv7x+gneG8=;
	b=S43Q05elkoXsri/pnnHVeWYlvHm8KsTMCalehL3Kpx82mXX0KVpn1SKNo80WrA+8ZNOXK0
	spHMe/KPH0rmfLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ECBE13326;
	Thu, 28 Aug 2025 23:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zBs5IoTmsGicRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Aug 2025 23:30:12 +0000
Date: Fri, 29 Aug 2025 01:30:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
Message-ID: <20250828233011.GE29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A8A4D20FA3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Fri, Aug 29, 2025 at 07:56:31AM +0930, Qu Wenruo wrote:
> 在 2025/8/29 07:23, David Sterba 写道:
> > This is preparatory work to use cache folio address in the extent buffer
> > to avoid reading folio_address() all the time (this is hidden in the
> > accessors).
> > 
> > However this is not as straightforward as just adding the array, the
> > extent buffers are of variable size depending on the node size and
> > adding 16*8=128 bytes would bloat the whole structure too much.
> > 
> > We already waste 3/4 of the folios array on x86_64 and default node size
> > 16K so we need to make the arrays variable size. This is allowed only
> > for one such array and it must be at the end of the structure. And we
> > need two.
> > 
> > With one indirection this is possible. For N folios in a node the
> > variable sized array will be 2N:
> 
> I'm OK with the variable folio pointer array, but why faddrs?

It's explained in the 2nd patch, it saves the lookups and translation of
page/folio -> address

> It looks like a little overkilled just to get rid of folio_address().

The folio_address does not show up in profiles becaues it's completely
inlined but it's in each and every accessor.

> And to be honest, if we really want to reduce the complexity of 
> folio_address(), we should go direct to large folios, which is much 
> easier and less risky.

In terms of code perhaps it is but it's still a major step compared to
the individual pages or folios so I'd rather make a few more steps in
between.

> > 	faddr     ----+
> > 	folios[]      |
> > 	[0]           |
> > 	[1]           |
> > 	...           |
> > 	[N]       <---+
> > 	[N+1]
> > 	...
> > 
> > There are 5 node sizes supported in total, but not all of them are used.
> > Create slabs only for 2 sizes where 16K is for the default size on
> > x86_64 and 64K. The one that contains the node size will be used,
> > possibly with some slack space.
> 
> I'm not a fan of two magic numbers.

It's not magic rather than optimizing for the most common case which is
default of 16k and a fallback. It does not make sense to create a slab
for each supported node size while only 16k would be in use.

> Can we just make folios[] variable size first without bothering the 
> cached folio address?

Yes the first patch can be taken separately.

