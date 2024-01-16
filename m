Return-Path: <linux-btrfs+bounces-1473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFA82F1DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FDA1F215B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A341C69F;
	Tue, 16 Jan 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUIUeFhl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fpiGqUh+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSG0p7Co";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XoSiFsqU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA091CA8F;
	Tue, 16 Jan 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CCF01FBAC;
	Tue, 16 Jan 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705420242;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I6WjaywApmiHShfQHSCr8iYg9z7vrVvRPjhnwVbcE0=;
	b=nUIUeFhlm4KVMKH7j+2p6P2m+cdP0H2pUs77iXzPy85usHQbf2smYaGfEV7kFG1qF572Gj
	B9ZpPYEaoyIHk7WrVQ+2VYEEIOmJDxoCBCGNqSSMR+hPbXcKUalU70qCaLpgJ3WQQBNlT4
	TMWsF1/fc9V38E68bIyshen+i1HfWhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705420242;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I6WjaywApmiHShfQHSCr8iYg9z7vrVvRPjhnwVbcE0=;
	b=fpiGqUh+Xv3LHq9heB3M4P/YKZ/9bIctP5/l9kRUTqHBjdPTGG3QJBW/XF+iqnte2OqF2J
	PpmCrNwizQA0OYBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705420240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I6WjaywApmiHShfQHSCr8iYg9z7vrVvRPjhnwVbcE0=;
	b=zSG0p7Co1+LJ+f1LFjVIGulCLzvwc1ZTcNG5uTupauUaT4qobFTGbeYQuaDMux74Ywvvpp
	O+8AQv3yLA5vB+tdu8CYomASsdKDCoPeUckPEUux3W0E+BKRCEqywaUY81lLhhcvaNXPWR
	2MxFeP6c2sC9wphhmtv+eObB4Qttjmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705420240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I6WjaywApmiHShfQHSCr8iYg9z7vrVvRPjhnwVbcE0=;
	b=XoSiFsqUZGm4icp0J8kG0Vmw8CMNy73Vs5glyPyWPEZ3SdHT5v5Dar5DAaVu5k8Uukj4L/
	K3xb89PIWirPT/Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CBAC133CE;
	Tue, 16 Jan 2024 15:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FwzqFdClpmWbJwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 15:50:40 +0000
Date: Tue, 16 Jan 2024 16:50:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: don't warn if discard range is not aligned to
 sector
Message-ID: <20240116155018.GX31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240115193859.1521-1-dsterba@suse.com>
 <4cc5ba4d-299a-46eb-b452-21eac629ace8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc5ba4d-299a-46eb-b452-21eac629ace8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.50
X-Spamd-Result: default: False [0.50 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[4a4f1eba14eb5c3417d1];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.00)[36.98%];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,appspotmail.com:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue, Jan 16, 2024 at 07:42:39PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/16 06:08, David Sterba wrote:
> > There's a warning in btrfs_issue_discard() when the range is not aligned
> > to 512 bytes, originally added in 4d89d377bbb0 ("btrfs:
> > btrfs_issue_discard ensure offset/length are aligned to sector
> > boundaries"). We can't do sub-sector writes anyway so the adjustment is
> > the only thing that we can do and the warning is unnecessary.
> >
> > CC: stable@vger.kernel.org # 4.19+
> > Reported-by: syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/extent-tree.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 6d680031211a..8e8cc1111277 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -1260,7 +1260,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
> >   	u64 bytes_left, end;
> >   	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
> >
> > -	if (WARN_ON(start != aligned_start)) {
> > +	/* Adjust the range to be aligned to 512B sectors if necessary. */
> > +	if (start != aligned_start) {
> >   		len -= aligned_start - start;
> >   		len = round_down(len, 1 << SECTOR_SHIFT);
> >   		start = aligned_start;
> Can we do one step further in mkfs and device add, by rounding down the
> device size to btrfs sector boundary?

This is not device size but the range that gets passed to discard. The
start and size get converted to the 512B units anyway when calling
blkdev_issue_discard(), so nothing else needs to be done.

