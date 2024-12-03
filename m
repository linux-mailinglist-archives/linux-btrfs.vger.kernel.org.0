Return-Path: <linux-btrfs+bounces-10038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EBF9E274C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C448166114
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E161F9EAB;
	Tue,  3 Dec 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LjAQFJEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zso3rvvK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LjAQFJEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zso3rvvK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B31F8EF8
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242948; cv=none; b=WCVPoIDRH9lfoapbTI23lg+xtGtgMp2sqJ5HrEUXfe1OT4EEtc/rARcAUXhd2ytdiutuSyu5y5a6ew/Xyf1Px87f1Fb/wckOEEJ5Nf4XWbZyZG0jgqdm3p2jtdGfnc+KsVrtYqgeiOo8BjHn6Crz4Jdx2jNVcDN4ktrrD8FCFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242948; c=relaxed/simple;
	bh=ZoSsvCsPHFNQS7w0ZakSsvlQqGJCXfbPhfBwDJuxE3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhVZtw/a3XWRgg2Q711athAQrEdNVUl533fEf7Sb8qSRBQdrNT2bI6tRF8mT7Un5JLCvXrFvfPe7CmhQ5gbgSLdVo0B+j2yFgz6byQzo6BrMjSE0smzfH43fGm71xAyISsZhsGEhi3qHk9+J+Iw0gUx5myrk9RSW0wL9jVulH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LjAQFJEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zso3rvvK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LjAQFJEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zso3rvvK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A1B22111F;
	Tue,  3 Dec 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733242944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
	b=LjAQFJELwBc4At8UHc+cKSRonjJLGh617Iw0wki32EGM23ubMjNEBEyNnABRwTRkqmjBys
	5N7op2VJKbsgS+Y9GbGmOagREn1KQafmAm3qVGQyKFd7ceqks5M5o5JxqTgxi3ZkU32T6i
	8P/rxF1lPBj9f06yLGnkWAoo23VNRDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733242944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
	b=Zso3rvvKrpbrXSuEEfKbxr2gdua7W6hsG9nUQAKKXZoJTS2Dumt2dp36i57NewWPK78jIg
	RJ+lsdhnKiXYguCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LjAQFJEL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zso3rvvK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733242944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
	b=LjAQFJELwBc4At8UHc+cKSRonjJLGh617Iw0wki32EGM23ubMjNEBEyNnABRwTRkqmjBys
	5N7op2VJKbsgS+Y9GbGmOagREn1KQafmAm3qVGQyKFd7ceqks5M5o5JxqTgxi3ZkU32T6i
	8P/rxF1lPBj9f06yLGnkWAoo23VNRDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733242944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
	b=Zso3rvvKrpbrXSuEEfKbxr2gdua7W6hsG9nUQAKKXZoJTS2Dumt2dp36i57NewWPK78jIg
	RJ+lsdhnKiXYguCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2850813A15;
	Tue,  3 Dec 2024 16:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UM+jCUAwT2fCWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Dec 2024 16:22:24 +0000
Date: Tue, 3 Dec 2024 17:22:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Zorro Lang <zlang@kernel.org>, ltp@lists.linux.it,
	linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH 0/3] LTP random fixes for xfs and btrfs
Message-ID: <20241203162222.GD31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241201093606.68993-1-zlang@kernel.org>
 <d1682e7d-9b1d-44cc-963a-1b1c5394fb2d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1682e7d-9b1d-44cc-963a-1b1c5394fb2d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4A1B22111F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Dec 01, 2024 at 08:25:19PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/1 20:06, Zorro Lang 写道:
> > [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
> >
> >    It doesn't skip filesystems as its plan, fix it.
> >
> > [PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option for xfs
> >
> >    mkfs.xfs doesn't support "-b 1024", needs "-b size=1024"
> >
> > [PATCH 3/3] stat04+lstat03: skip test on btrfs
> >
> >    The "-b" option of mkfs.btrfs isn't a blocksize option, there's not blocksize
> >    option in mkfs.btrfs. So I'd like to skip this test for btrfs. But I'm not
> >    sure if there's better way, so CC *btrfs list* to get more review points for
> >    that.
> >    (BTW, better to have a common helper to deal with different filesystems'
> >     blocksize options in the future)
> >
> 
> Well, I'd say Wilcox is kinda correct here.
> 
> Btrfs uses the name "sector size" to indicate the minimal unit, aka, the
> blocksize of all the other fses.
> 
> Not sure if we will even rename the whole sector size to block size in
> the future, it looks like a huge work to do.

Well, I think we can at least add an alias blocksize to sectorsize to
mkfs.  We don't have a time machine to change the initial confusing
naming, but can slightly improve the user convenience.  Internally in
the code we can keep sectorsize or incrementally rename it to blocksize.
What matters more here is the user intrface, i.e. the mkfs options.

