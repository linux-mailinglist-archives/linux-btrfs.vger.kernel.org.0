Return-Path: <linux-btrfs+bounces-4080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2289E5A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 00:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAF5B22C53
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB3158D8A;
	Tue,  9 Apr 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQ64hffc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O4zbrzSx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KQ64hffc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O4zbrzSx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3C12BE9C
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701544; cv=none; b=cbbs4Ip6o5+DhsXR7SYuYiPZ8ljU/r8btQj737g7wiNf/DIX/kYueo+LvETZaDDAZa85yWWEeYMyreBAx38/av4LY7zat9ynvjVLXjulYrf0oFFhDNgOiQv5P2K0ODZIOTYyoMJjwIMVA9uueeTe660vHwJJh64b7uJSe/4CD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701544; c=relaxed/simple;
	bh=HRqTGHOb/JGg6ioTw8vDYCjU1b1TSn5tifux+aMNT7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM++WFLUQ+6xfo7lxpswZXoAZ/rdjYNMdcg4XIkUnVnm4n4ISSJSIKo8YOxqUJhae8pxoKCl3LVorZT3GK+9B/2RlxxSnQCuScB3ZRWI+shaZGewRd8b/FsDbimagwY9Opdc5XHaiMpDOlLQz+TrQ1a+2J/QdOl0wqsRf+PIWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQ64hffc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O4zbrzSx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KQ64hffc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O4zbrzSx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A64521095;
	Tue,  9 Apr 2024 22:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712701539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpKJdLL2r/Vp6ECPJVgWdtMa122kSqAC9y3Ws/Gw8co=;
	b=KQ64hffcBOt8Vmy91y322peYrx3479KNL3R7n+ZBd+Clah7VqtP8o+6goCwt0RCWVZN67c
	vUGZUsEDwibz5swG0uF5dcU11w8CWDYJ3m3jssEfr91T5vczQnIyRZqH1xFQKA6Ig0hdu5
	/jhjTKB6GuqCiF3An++IhvJ1Iw+Fw2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712701539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpKJdLL2r/Vp6ECPJVgWdtMa122kSqAC9y3Ws/Gw8co=;
	b=O4zbrzSxUkpV8ncGrkrg2uhC0eyBZ9YXcTJadyxnJwpeLJlZm03Vr2QLlUx9RkiQ/zEcWK
	7MNJlHGbgEKOkhBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712701539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpKJdLL2r/Vp6ECPJVgWdtMa122kSqAC9y3Ws/Gw8co=;
	b=KQ64hffcBOt8Vmy91y322peYrx3479KNL3R7n+ZBd+Clah7VqtP8o+6goCwt0RCWVZN67c
	vUGZUsEDwibz5swG0uF5dcU11w8CWDYJ3m3jssEfr91T5vczQnIyRZqH1xFQKA6Ig0hdu5
	/jhjTKB6GuqCiF3An++IhvJ1Iw+Fw2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712701539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpKJdLL2r/Vp6ECPJVgWdtMa122kSqAC9y3Ws/Gw8co=;
	b=O4zbrzSxUkpV8ncGrkrg2uhC0eyBZ9YXcTJadyxnJwpeLJlZm03Vr2QLlUx9RkiQ/zEcWK
	7MNJlHGbgEKOkhBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 15CD013253;
	Tue,  9 Apr 2024 22:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vy/kBGPAFWaPZQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 22:25:39 +0000
Date: Wed, 10 Apr 2024 00:18:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: extent-map: use disk_bytenr/offset to replace
 block_start/block_len/orig_start
Message-ID: <20240409221813.GL3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712614770.git.wqu@suse.com>
 <20240409145720.GG3492@twin.jikos.cz>
 <68c73ba9-067e-4542-9a26-a70cc9bde858@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c73ba9-067e-4542-9a26-a70cc9bde858@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]

On Wed, Apr 10, 2024 at 07:10:08AM +0930, Qu Wenruo wrote:
> 在 2024/4/10 00:27, David Sterba 写道:
> >>
> >> The extra sanity checks already exposed one bug (thankfully harmless)
> >> causing em::block_start to be incorrect.
> >>
> >> There is another bug related to bad btrfs_file_extent_item::ram_bytes,
> >> which can be larger than disk_num_bytes for non-compressed file extents.
> >> (Generated by generic/311 test case, but it seems to be created on-disk
> >>   first)
> >>
> >> But so far, the patchset is fine for default fstests run.
> >
> > I've only paged through the patches, besides the renames there are so
> > many changes where it's hard to spot a subtle bug, but overall it looks
> > ok.
> 
> That's why this time I go sanity/cross checks immediately after adding
> new members, to make sure the behavior is not changed.
> 
> So that even it's pretty hard to review, if something obviously wrong
> happened, I'll hit a crash.
> 
> You will be surprised by how many crashes it triggered during the
> development.

Yeah, I can imagine. If you make it work in the end then it's good.  The
self tests can verify the boundary conditions without having to create a
complete filesystem and just focused on some API so here it's easier.

The review I'd like to see is by somebody familiar with the extent maps
if it all makes sense or there are no missing test cases.

This series depends on another one that looks almost finished except
some comments in patch that adds just code comments (so no functional
changes). This kind of changes would be good to get enough testing in
for-next so please go ahead and add it in case there's not something
really serious outstanding. We can do some minor tweaks later.

