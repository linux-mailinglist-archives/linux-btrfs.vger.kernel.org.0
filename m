Return-Path: <linux-btrfs+bounces-1474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6373D82F1EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704A01C236D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377A1C697;
	Tue, 16 Jan 2024 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uatOopp+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xh32mHin";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zv3Jcnsu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="13/iYjYR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944B1CA84;
	Tue, 16 Jan 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD761220C5;
	Tue, 16 Jan 2024 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705420480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5g1BD4f9KXzYkUefDTdUQBfOmOUC5+YAZ+CwXSS0QRo=;
	b=uatOopp+ByuE+K8Oj9LSvWXVk70wZ8YPYoec6OAj/Rds/ZGlp9s8o3HDyDZ6VJRNcE+MYm
	iIwwzY0p0pSQi3hVW6N6RF8qZWI3vE3hAOEQvV4OKx+Uj82N6Uyu/dWYfEHI2UcK6cDLJO
	oce2S43mmK9cy3NuQ7CjHDqYXrkfChk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705420480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5g1BD4f9KXzYkUefDTdUQBfOmOUC5+YAZ+CwXSS0QRo=;
	b=xh32mHinVYGrtqM7b6gcqtlbU+FMThCMlULVCDqEg5+alVaCA1Z9jhLPPVElK4nLeEP/GB
	A9zY7aHa1dKhScAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705420479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5g1BD4f9KXzYkUefDTdUQBfOmOUC5+YAZ+CwXSS0QRo=;
	b=Zv3JcnsuKZAUyS4syarJCMGrW0vFtdc6QYaNR2wqjcRXMXuOKlendPVl1hJJ4WE8icPuQJ
	rITsGhZHx+N+jNEJwD790vk5f+pxvNpLEH3SvIbPXXPdf0/8bJYB6obnEADz8NnB9m6VPc
	xnZTbYufeSNAZX+tEoOOQTZeOh0/EMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705420479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5g1BD4f9KXzYkUefDTdUQBfOmOUC5+YAZ+CwXSS0QRo=;
	b=13/iYjYRsMldsSjsFypxgov8KDbdfmGLCBOP7CLm5SaRzFmVhw75yFSUBdfG7kbeIs0/nE
	4dyZqzNysGwuyVDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B9415133CF;
	Tue, 16 Jan 2024 15:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9nmdLL+mpmUUKAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 15:54:39 +0000
Date: Tue, 16 Jan 2024 16:54:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com" <syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: don't warn if discard range is not aligned to
 sector
Message-ID: <20240116155421.GY31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240115193859.1521-1-dsterba@suse.com>
 <71c8f951-e033-4e1c-9048-13e3d857f519@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c8f951-e033-4e1c-9048-13e3d857f519@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zv3Jcnsu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="13/iYjYR"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.29 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[16.27%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[4a4f1eba14eb5c3417d1];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,appspotmail.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.29
X-Rspamd-Queue-Id: DD761220C5
X-Spam-Flag: NO

On Tue, Jan 16, 2024 at 08:40:23AM +0000, Johannes Thumshirn wrote:
> On 15.01.24 20:39, David Sterba wrote:
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
> 
> Maybe leave a
> btrfs_warn(fs_info, "adjusting discard range to 512b boundary");
> in there?
> 
> Or is info a more appropriate level?

I don't know if we should warn here at all, the warning is there since
2015 and only now we see it triggered, I guess everybody sane using the
discard interface uses proper values. Warning level means that it needs
user attention that something is wrong and take some action or examine
the system.

The discard range could be verified at the beginning of the ioctl, but
printing it here is a bit late. I've checked xfs and it silently rounds
down the start and offset the same way, I find this sufficient thing to
do.

