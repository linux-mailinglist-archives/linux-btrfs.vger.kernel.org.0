Return-Path: <linux-btrfs+bounces-4672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C88B9B8B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BBA1C20B99
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0284A52;
	Thu,  2 May 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lzZAu/ui";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6tVm6g16";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RduHYn5A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xzy2TYMR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193356B8B
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656245; cv=none; b=PUQk+sY5V9leJoTSxOHZx7fxjUz7fQbqgE8koDDUnbCKm9dLA19fyRvc+O8Km9HRVzt+tlrpcvmkTjiNPd/rHg9V4e/HIu1ZusVnBGb3FKSFIGrns/Pu2MdrUg3BGub/TTipMuMTiQr/qVFS9w/c0+d/WJm3X4gydqkyzP2QHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656245; c=relaxed/simple;
	bh=r5l09imKh1rJWbDWfSiGTIqULQAUMN6u7Ll9dqVIDrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiF0kJHxwv1rNfyByC9f0ZXdd0ylub+b3ly+2V04ZOEGvymb+nH3RE860Rw6ivItnGDgkwOtnq+AYePEkw9Fqvlq9CskJIb4iJm+VLUnpAFTomwdPB4HHI7ToKRH2qkoYJfqA/Nv+9MjxnCe/+55Y/1a3DdmMoprppS1wkTzAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lzZAu/ui; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6tVm6g16; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RduHYn5A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xzy2TYMR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E67791FB53;
	Thu,  2 May 2024 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714656240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5CERooCE3DvUcROXhC6NEUPx7WOl4WsAjl011GOzb4=;
	b=lzZAu/uivbt6jkErdajSnAnZRZIStAfmmmV3fdp10Kldf5nxNAxrIJbWEaTQQpnYW/uAWZ
	4Ayhl8orEObPs247kCIeluXbQdZ8RzZg68GvlQ1BrmQvUsTLuLUY9DWOhscc+mVDjrFD8U
	CNoqNnVqgxzUUxDonM5EXWVbgRFLdmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714656240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5CERooCE3DvUcROXhC6NEUPx7WOl4WsAjl011GOzb4=;
	b=6tVm6g16G7hGzg5qooEvGkNrr+wUyHXmWqd4dyJMWzHbyBC6s/I6NWGcVlDD4s0zeY0Dm1
	+VflIz8UrLjWLVBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RduHYn5A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xzy2TYMR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714656239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5CERooCE3DvUcROXhC6NEUPx7WOl4WsAjl011GOzb4=;
	b=RduHYn5AdFhVg6xAU4Ug92Hqu0b3jZuI7cBAh3zQnD6ZrjuUhI/K7Wz5xkvG28oh4s48jO
	u1KtbpipsaM6C5jArkgtKDbgT1rDgg/hqH1oh1f3JCpJYyj0buCTJkHxYj+mojQR1ZH3u6
	fgn7mPON4GOEPPMGrHaFpxngOHJcx5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714656239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5CERooCE3DvUcROXhC6NEUPx7WOl4WsAjl011GOzb4=;
	b=xzy2TYMRlhIkqe37Tk1f9QikrP0sSdkDmmFLSWNvKNENtR8wGWo/K8iP4VRzDk8DDmUXm1
	RloUmNtwSAD+foDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE3F613957;
	Thu,  2 May 2024 13:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJQvMu+TM2ZlTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 13:23:59 +0000
Date: Thu, 2 May 2024 15:16:40 +0200
From: David Sterba <dsterba@suse.cz>
To: intelfx@intelfx.name
Cc: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: What's the difference between `btrfs sub del -c` and `btrfs fi
 sync`?
Message-ID: <20240502131640.GQ2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
 <71f2d380-9b11-4ed5-949c-0edc1ed56c60@gmx.com>
 <c8bac058c40b15a242d4598172d6a89c2f97608b.camel@intelfx.name>
 <e9a07ed8-facc-462f-9fe2-ede4d1e4a8bb@suse.com>
 <18c138d9f3e8fe3a040d8a3f284317267e417136.camel@intelfx.name>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c138d9f3e8fe3a040d8a3f284317267e417136.camel@intelfx.name>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.46
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E67791FB53
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.46 / 50.00];
	BAYES_HAM(-2.25)[96.44%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[suse.com,gmx.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]

On Sun, Apr 28, 2024 at 12:20:28PM +0200, intelfx@intelfx.name wrote:
> I see, thanks. That's what I suspected, but wanted to check if my
> (limited) understanding was correct.
> 
> It is unfortunate that ioctls that should be equivalent if judging by
> the names alone, in fact have subtle semantic differences that aren't
> documented anywhere.

Ioctls get documented incrementally, at least the FS SYNC is there,
https://btrfs.readthedocs.io/en/latest/btrfs-ioctl.html#btrfs-ioc-sync

> It's as if the ioctls were introduced specifically
> for the relevant userspace tools, encoding specific assumptions valid
> for their (only) consumers, without consideration of their wider
> applicability...

The start/wait ioctls can be used for cases when there's first phase
that generates some data or changes and second phase waits for the
commit. It was convenient to use that for the subvol sync, can be used
for other changes that eg. do only btrfs_end_transaction() in kernel
while some sort of sync semantics is wanted from user space (that would
be equivalent to btrfs_commit_transaction()).

You can read the discussions behind that in
https://www.spinics.net/lists/linux-btrfs/msg28354.html

The semantics of the start/wait ioctls were explained in the initial
patch https://git.kernel.org/linus/462045928bda777c86919a396a42991fcf235378
originally added for ceph.

