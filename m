Return-Path: <linux-btrfs+bounces-4878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8AC8C1467
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17DF2839BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15E770FA;
	Thu,  9 May 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AUL8W/KI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/VDmwck";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AUL8W/KI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/VDmwck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4B71738
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277507; cv=none; b=Lvnjr7yQvhSmXKRoatcVBrcJQdujz0K4vfq4nMIgHAfdVTdhB+7Y5jVvhWLbhxz14P0HXexPxN84JPBAhfgWA3po0DCewXVou8ZRcuqZ4Xr4IUDuDj4JyzruzLwYQRY5QkJTkauk6u8ZM8AsSlnHke5qTFHcv28J+XdpShYkM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277507; c=relaxed/simple;
	bh=0PF91QPBepceqM1p5NAsM5c6DXMYPU09ylyGLsgylZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA9wSnK2UDtO+M6chQSj1mPI8FFwNz7qjNlx50WL6d9uur021ChKtQIvGljl24EFIPGTH/LxQDQ3VmyjQ0IT0dbKzEcX1I9uNRS8UyBOZHImY/noHIkMycb4bZW5Et7KBiXrk0+IxfizcQS6Mui1/us/tOBGg+uErdMzO2h7K/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AUL8W/KI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/VDmwck; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AUL8W/KI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/VDmwck; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8052D347E1;
	Thu,  9 May 2024 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715277503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wI1ig7p+6KuFN+kjC/TZtRUrlB1JrAsbJS9fY6l7Vug=;
	b=AUL8W/KI5RuZeIblX9zDgc0D53ovrWx+OckHVI+TKIOWJMXVWnosHAImkVmE7+VcT4CQq/
	VYelZEE2/xYGD4HIDiAn9PweTGYn5+mZx9rh6fXsxC2wYf7uoxD/DKPQd1Z4d+/ABBDro/
	kHAHFoa+EE2vqkfRVcvhfy7pgggLtww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715277503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wI1ig7p+6KuFN+kjC/TZtRUrlB1JrAsbJS9fY6l7Vug=;
	b=n/VDmwckrFzo4tW2ZmKgWGXOjrinWSKr87PYogsxZcVqymIk8o2UdZ+3kGbeQMPvckIsa8
	3+ir7Dmg1u2u7GCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715277503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wI1ig7p+6KuFN+kjC/TZtRUrlB1JrAsbJS9fY6l7Vug=;
	b=AUL8W/KI5RuZeIblX9zDgc0D53ovrWx+OckHVI+TKIOWJMXVWnosHAImkVmE7+VcT4CQq/
	VYelZEE2/xYGD4HIDiAn9PweTGYn5+mZx9rh6fXsxC2wYf7uoxD/DKPQd1Z4d+/ABBDro/
	kHAHFoa+EE2vqkfRVcvhfy7pgggLtww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715277503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wI1ig7p+6KuFN+kjC/TZtRUrlB1JrAsbJS9fY6l7Vug=;
	b=n/VDmwckrFzo4tW2ZmKgWGXOjrinWSKr87PYogsxZcVqymIk8o2UdZ+3kGbeQMPvckIsa8
	3+ir7Dmg1u2u7GCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63DCC13941;
	Thu,  9 May 2024 17:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FL0vGL8OPWY8PQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 17:58:23 +0000
Date: Thu, 9 May 2024 19:58:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: enhance compression error messages
Message-ID: <20240509175816.GP13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240503114230.9871-1-dsterba@suse.com>
 <CAL3q7H4UGXk8Oi7nA+SY585-K=HCT7MV-KrG0x46s020-5_pag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4UGXk8Oi7nA+SY585-K=HCT7MV-KrG0x46s020-5_pag@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 08, 2024 at 05:17:27PM +0100, Filipe Manana wrote:
> On Fri, May 3, 2024 at 12:50 PM David Sterba <dsterba@suse.com> wrote:
> >
> > Add more verbose and specific messages to all main error points in
> > compression code for all algorithms. Currently there's no way to know
> > which inode is affected or where in the data errors happened.
> >
> > The messages follow a common format:
> >
> > - what happened
> > - error code if relevant
> > - root and inode
> > - additional data like offsets or lengths
> >
> > There's no helper for the messages as they differ in some details and
> > that would be cumbersome to generalize to a single function. As all the
> > errors are "almost never happens" there are the unlikely annotations
> > done as compression is hot path.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/lzo.c  | 43 ++++++++++++++++++++---------
> >  fs/btrfs/zlib.c | 60 ++++++++++++++++++++++++++++++----------
> >  fs/btrfs/zstd.c | 73 +++++++++++++++++++++++++++++++++++++------------
> >  3 files changed, 131 insertions(+), 45 deletions(-)
> >
> > diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> > index 1c396ac167aa..d2e8a9117d22 100644
> > --- a/fs/btrfs/lzo.c
> > +++ b/fs/btrfs/lzo.c
> > @@ -258,8 +258,8 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
> >                                        workspace->cbuf, &out_len,
> >                                        workspace->mem);
> >                 kunmap_local(data_in);
> > -               if (ret < 0) {
> > -                       pr_debug("BTRFS: lzo in loop returned %d\n", ret);
> > +               if (unlikely(ret < 0)) {
> > +                       /* lzo1x_1_compress never fails. */
> >                         ret = -EIO;
> >                         goto out;
> >                 }
> > @@ -354,11 +354,14 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
> >          * and all sectors should be used.
> >          * If this happens, it means the compressed extent is corrupted.
> >          */
> > -       if (len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
> > -           round_up(len_in, sectorsize) < cb->compressed_len) {
> > +       if (unlikely(len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
> > +                    round_up(len_in, sectorsize) < cb->compressed_len)) {
> > +               struct btrfs_inode *inode = cb->bbio.inode;
> > +
> >                 btrfs_err(fs_info,
> > -                       "invalid lzo header, lzo len %u compressed len %u",
> > -                       len_in, cb->compressed_len);
> > +"lzo header invalid, root %llu inode %llu offset %llu lzo len %u compressed len %u",
> > +                         inode->root->root_key.objectid, btrfs_ino(inode),
> 
> Now that we are using btrfs_root_id() everywhere after Josef's recent
> patch, please use btrfs_root_id(inode->root) everywhere in the patch
> for consistency (it's also shorter to type and the name is very
> clear).

I'll do that in v2 (as there's the problem with zlib that returns EIO),
thanks.

