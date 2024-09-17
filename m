Return-Path: <linux-btrfs+bounces-8087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D729F97B30B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0844A1C2207E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407D17AE11;
	Tue, 17 Sep 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oicYn0pY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KtKT+gf3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cy1a8Gl+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kLcTyR8p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF817107F
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591094; cv=none; b=a5Vbdz7CLCBZRNwdURSu3xqHdfZolq3iQMjyD/WdK5OV+LY5fznJGME0a4tzzdEjXRcMvSZJIiTDyH1LyV/ILgO6+R0+4YNbX6nZVh8X2f3KzALX4cTMAkieqbB8AQYndWhmi0/0UlnLGLSc78CuOLahbh3eZtkik6zHSvIyI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591094; c=relaxed/simple;
	bh=NpupltsBoFVkbBWtT1EAr/5GYkYiuHBVS7o48hNAqzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Yzjm3OtVx0MDB70mBu+w/3cYpSXC+EvVVrRqHm2v41e2OaCxiyF3BnpKJa0Qs9Uo/f16vtKbdhqo76z5laTrzV0r38Drm+vw2w2CpMm2ffNViMwChZ6rVM71l10h9eJI7KwjN3BUa4FzNZ93UHGdY48YQRNJgV8tbQOHJYTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oicYn0pY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KtKT+gf3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cy1a8Gl+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kLcTyR8p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10F7220115;
	Tue, 17 Sep 2024 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726591090;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9KIjLJh24H+6v1/W2grSAuM5x0j48vs+hEljwjLInk=;
	b=oicYn0pYmLnzoorVxm88gL0tBl9woJmqWck+UT1wzL2/9CNFlKhRGm6qXUaSD0+Xk8F4IC
	AcBAHQ6eM/HcXSICWtB7NVJPt1g6tMlIbUWIyAP6zSIGHix/x3x1gfLCfEnEUd6W/gsSRN
	dXhPCpIajXAJVrj+hyA8skEjOT6COCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726591090;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9KIjLJh24H+6v1/W2grSAuM5x0j48vs+hEljwjLInk=;
	b=KtKT+gf3tTkSPX4Md24XCSONM8tsZPkiASykss91qqVjixfotKxROkoqhWCr5pcl8UDbFR
	qSoS3Er4Jy9YJeBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cy1a8Gl+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kLcTyR8p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726591088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9KIjLJh24H+6v1/W2grSAuM5x0j48vs+hEljwjLInk=;
	b=Cy1a8Gl+Fyj5uUWf24Meq6HTSk+W/Rdn0IsI2WqzgTSThAcqRgQkt5fNvJJWofaEWYsMLZ
	2TaS+sh+NigmbgenXqTBK8b24dQv7jb3TcavqRxdKM2P1xL6GVF8Uj1AuOLYQD0JoJ+2Ai
	3HbQ4gPW6KMB2QTBTVQfMorsO/5Blyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726591088;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9KIjLJh24H+6v1/W2grSAuM5x0j48vs+hEljwjLInk=;
	b=kLcTyR8pAzKf3E7h/gUoZ7sOUgTQwouiwk3XHoDob8FqxP1HGKFrtV+2+7B20scHhFmYAg
	SbUuxl/PWckaOvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF73513AB6;
	Tue, 17 Sep 2024 16:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NhJZNm+w6WZVaQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 16:38:07 +0000
Date: Tue, 17 Sep 2024 18:38:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"xuefer@gmail.com" <xuefer@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: clear SB magic on conventional zone
Message-ID: <20240917163806.GF2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
 <aecafe2f-a3e8-45dd-8c06-27e5925896a6@wdc.com>
 <7eqi7tf2xv43r2pwqpgzcia6vtobnp5jrwnb64nyj7a54m5rmu@kkhsqy3msgc3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eqi7tf2xv43r2pwqpgzcia6vtobnp5jrwnb64nyj7a54m5rmu@kkhsqy3msgc3>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 10F7220115
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[wdc.com,vger.kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Sep 13, 2024 at 07:46:14AM +0000, Naohiro Aota wrote:
> On Fri, Sep 13, 2024 at 06:36:47AM GMT, Johannes Thumshirn wrote:
> > On 13.09.24 04:16, Naohiro Aota wrote:
> > > +	zone = &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
> > > +	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
> > > +		/*
> > > +		 * If the first zone is conventional, the SB is placed at the
> > > +		 * first zone.
> > > +		 */
> > > +
> > > +		u64 bytenr = zone->start << SECTOR_SHIFT;
> > > +		u64 bytenr_orig = btrfs_sb_offset(mirror);
> > > +		struct btrfs_super_block *disk_super;
> > > +		const size_t len = sizeof(disk_super->magic);
> > > +
> > > +		disk_super = btrfs_read_disk_super(device->bdev, bytenr, bytenr_orig);
> > > +		if (IS_ERR(disk_super))
> > > +			return PTR_ERR(disk_super);
> > > +
> > > +		memset(&disk_super->magic, 0, len);
> > > +		folio_mark_dirty(virt_to_folio(disk_super));
> > > +		btrfs_release_disk_super(disk_super);
> > > +
> > > +		ret = sync_blockdev_range(device->bdev, bytenr, bytenr + len - 1);
> > > +	} else {
> > > +		unsigned int nofs_flags;
> > > +
> > > +		/*
> > > +		 * For the other case, all zones must be a sequential required
> > > +		 * zone.
> > > +		 */
> > > +#ifdef CONFIG_BTRFS_ASSERT
> > > +		for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> > > +			ASSERT(zone->type != BLK_ZONE_TYPE_CONVENTIONAL);
> > > +			zone++;
> > > +		}
> > > +		zone = &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
> > > +#endif
> > > +
> > > +		nofs_flags = memalloc_nofs_save();
> > > +		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET, zone->start,
> > > +				       zone->len * BTRFS_NR_SB_LOG_ZONES);
> > > +		memalloc_nofs_restore(nofs_flags);
> > > +
> > > +		if (!ret) {
> > > +			for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> > > +				zone->cond = BLK_ZONE_COND_EMPTY;
> > > +				zone->wp = zone->start;
> > > +				zone++;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	if (ret)
> > > +		btrfs_warn(device->fs_info, "error clearing superblock number %d (%d)", mirror,
> > > +			   ret);
> > > +
> > 
> > Is there a reason we can't go through the discard code for this? In the 
> > sequential zone case we end up with REQ_OP_ZONE_RESET in both code 
> > paths, in the conventional code case, we can do a REQ_OP_DISCARD or 
> > REQ_OP_WRITE_ZEROES for the whole 4k of the superblock.
> > 
> 
> Yeah, we can do so. I agree that is simple.
> 
> But, I tried to make the behavior compatible with the regular
> mode. btrfs_scratch_superblock(), which handle the case for the regular
> mode, just overwrites the SB magic (4 bytes?) and leaves other field
> intact. I guess it is for a rescue option?

I'd prefer to follow the same logic as btrfs_scratch_superblock() here,
deleting only the signature. Leaving metadata behind for rescue purposes
sometimes helps.

