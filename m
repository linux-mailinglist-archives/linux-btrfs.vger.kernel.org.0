Return-Path: <linux-btrfs+bounces-1972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5438447A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836451F22E85
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3533CF4;
	Wed, 31 Jan 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxPg4M45";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NA7P1N4K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxPg4M45";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NA7P1N4K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DF37143
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727553; cv=none; b=D3SlUvdHaf8g3UTcJ5rLn1foRNE82Lq90yUyqAKz3K1LiwvZg1h+nYfswUAXOqGRhsyrYRAZZ41RyKLRyhkiecOi/ayfvSp3Y6y+qxY5BLrDc4g4nQAUhX/BOmWCZ5rBZUZmaBzrfwNaLurFFM1dejJW/vxfHVNFNtILwekiJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727553; c=relaxed/simple;
	bh=r/FZzyxebe1Qq/k9pWixJf67kDYcoVeA26mSkdwyzrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb+7oxKmTpomgVvjPYKBgr3uABwBGSgXhJn0g4Fa4oYES3udMDJT2S9AzLsd+T7YB3KzaAxhPihCHJHKXZyCLZHFtgLObo77thOm0sj7Y4PzHLc/QPKruifMWzTsDQRbBo+8R0F3Gfz10L8MbC12sevf+y+IQSqaLjpYmgMT2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxPg4M45; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NA7P1N4K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxPg4M45; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NA7P1N4K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29A5F1FB95;
	Wed, 31 Jan 2024 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706727549;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DS1yhtX3wXH7W4AH0HGGOyJyxyIEZRTGbsrHULL0eo=;
	b=kxPg4M45tDy6nzQ92uvQUVelYA69tnKRzZy3IDZ5I6xZpTVA5WkNXpQ25q5nxWHth+KSOA
	YH6ELbAXmBAzzKGkiR5XtED/R2BDIT9wiBAcAJIVKbwn65UgzAwnedW+MPnaG4Vll4Han0
	Xgn+67NidEnoDanQ7NHnRAjXheKGy1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706727549;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DS1yhtX3wXH7W4AH0HGGOyJyxyIEZRTGbsrHULL0eo=;
	b=NA7P1N4Kylx4bmE/h+LUzHgqvSYSJBwzkJgRoOHAJm/4I7nYEcLKN/IU3u5JZBvg2aAS9X
	AyYY34k/jJkwINDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706727549;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DS1yhtX3wXH7W4AH0HGGOyJyxyIEZRTGbsrHULL0eo=;
	b=kxPg4M45tDy6nzQ92uvQUVelYA69tnKRzZy3IDZ5I6xZpTVA5WkNXpQ25q5nxWHth+KSOA
	YH6ELbAXmBAzzKGkiR5XtED/R2BDIT9wiBAcAJIVKbwn65UgzAwnedW+MPnaG4Vll4Han0
	Xgn+67NidEnoDanQ7NHnRAjXheKGy1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706727549;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DS1yhtX3wXH7W4AH0HGGOyJyxyIEZRTGbsrHULL0eo=;
	b=NA7P1N4Kylx4bmE/h+LUzHgqvSYSJBwzkJgRoOHAJm/4I7nYEcLKN/IU3u5JZBvg2aAS9X
	AyYY34k/jJkwINDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 097CD132FA;
	Wed, 31 Jan 2024 18:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gQvTAX2YumUPLQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 18:59:09 +0000
Date: Wed, 31 Jan 2024 19:58:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>,
	"clm@meta.com" <clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Message-ID: <20240131185843.GR31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
 <9624d589-43ff-40c6-81af-2c7b577edb22@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9624d589-43ff-40c6-81af-2c7b577edb22@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kxPg4M45;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NA7P1N4K
X-Spamd-Result: default: False [-1.59 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.25%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 29A5F1FB95
X-Spam-Level: 
X-Spam-Score: -1.59
X-Spam-Flag: NO

On Wed, Jan 31, 2024 at 02:15:32PM +0000, Johannes Thumshirn wrote:
> On 31.01.24 08:15, Naohiro Aota wrote:
> > We disable offloading checksum to workqueues and do it synchronously when
> > the checksum algorithm is fast. However, as reported in the link below,
> > RAID0 with multiple devices may suffer from the sync checksum, because
> > "fast checksum" is still not fast enough to catch up RAID0 writing.
> > 
> > To measure the effectiveness of sync checksum for developers, it would be
> > better to have a switch for the sync checksum under CONFIG_BTRFS_DEBUG
> > hood.
> > 
> > This commit introduces fs_devices->sync_csum_mode for CONFIG_BTRFS_DEBUG,
> > so that a btrfs developer can change the behavior by writing to
> > /sys/fs/btrfs/<uuid>/sync_csum. The default is "auto" which is the same as
> > the previous behavior. Or, you can set "on" or "off" to always/never use
> > sync checksum.
> > 
> > More benchmark should be collected with this knob to implement a proper
> > criteria to enable/disable sync checksum.
> > 
> > Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> > Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> As access to sysfs and fs_info can happen concurrently, should the 
> read/write of fs_devices->sync_csum_mode be guarded by a 
> READ_ONCE()/WRITE_ONCE()?

Yes we use the *_ONCE helpers for values set from sysfs in cases where
it's without bad effects to race and change the value in the middle.
Here it would only skip one checksum offload/sync. It's not really a
guard but a note that there's something special about the value.

