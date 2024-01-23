Return-Path: <linux-btrfs+bounces-1649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B338397CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A0C28A6DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1381ACC;
	Tue, 23 Jan 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3ED7TlE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZyvYkxpO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3ED7TlE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZyvYkxpO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43B3D3A7;
	Tue, 23 Jan 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034963; cv=none; b=j0qGT0fmsTpE1hypEm/pgLxo18Yp3xSCK0cEJncVNIW9xcC2LCNrlNLmN/D3C7hWDMsc45+IUDR5RnL4WiQOuKlUNaC7aGB0pS0GFnxlHWVk4HoC7DYyL7Z4Nd1TmaET2gT18z6HNCYskICQK6OTlOlgip+qXTyK0o+qASUsBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034963; c=relaxed/simple;
	bh=t1pzSPXGOsOeKApuKD4PdRlt/9pcnIsQsfFyQqYr8LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4gV0JUqD1dJ5UQmfXayboKFkC53fvW5OYXYq0CdDdlC2jT+POvKObwSvwqrT7rZxU/GdDnGJVpBf/+kz0MoyhCi4WsJ+bZLVWGp+5InIqiul0VR6jdr+lGnKwF3razMH8WaGjFUz3ClPE3SQnMj1aOka/51pjwyQrFn9/zbfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3ED7TlE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZyvYkxpO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3ED7TlE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZyvYkxpO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24ABD21F6E;
	Tue, 23 Jan 2024 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706034959;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZRULxGLXy9hvggXyq6ZTd7Xgbc+PvTyWIeHZ+8GHI4=;
	b=d3ED7TlEbKVPY11uywbn0STxTPHOmptbA23Kp96qErUcnZ7C8eFheGMLXtdPI+8zl2N1Wt
	djYisy3x096eIENgZlhyZ7A+fdlgCGHy2Oqgcr9SVFQDm/n8oxrbHtAgB+LYZ7Cqvg17BB
	Kqk1xjIDbgFDRgGDk8faXt3OLrbAu/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706034959;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZRULxGLXy9hvggXyq6ZTd7Xgbc+PvTyWIeHZ+8GHI4=;
	b=ZyvYkxpOG0yXXaGxOtumdwI8QdVAbA9NBCkcTdTAuWLL2W4Z+3I7hsxXYcTAof4ND7ZChc
	Y7e166FgID+iq6DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706034959;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZRULxGLXy9hvggXyq6ZTd7Xgbc+PvTyWIeHZ+8GHI4=;
	b=d3ED7TlEbKVPY11uywbn0STxTPHOmptbA23Kp96qErUcnZ7C8eFheGMLXtdPI+8zl2N1Wt
	djYisy3x096eIENgZlhyZ7A+fdlgCGHy2Oqgcr9SVFQDm/n8oxrbHtAgB+LYZ7Cqvg17BB
	Kqk1xjIDbgFDRgGDk8faXt3OLrbAu/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706034959;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZRULxGLXy9hvggXyq6ZTd7Xgbc+PvTyWIeHZ+8GHI4=;
	b=ZyvYkxpOG0yXXaGxOtumdwI8QdVAbA9NBCkcTdTAuWLL2W4Z+3I7hsxXYcTAof4ND7ZChc
	Y7e166FgID+iq6DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E6ED81329F;
	Tue, 23 Jan 2024 18:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hE12Nw4HsGXEDAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 23 Jan 2024 18:35:58 +0000
Date: Tue, 23 Jan 2024 19:35:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Message-ID: <20240123183537.GJ31555@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
 <20240122213428.GE31555@twin.jikos.cz>
 <9ab48353-2033-4ab6-8334-28859d5e9e0f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab48353-2033-4ab6-8334-28859d5e9e0f@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d3ED7TlE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZyvYkxpO
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 24ABD21F6E
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Tue, Jan 23, 2024 at 07:49:22AM +0000, Johannes Thumshirn wrote:
> On 22.01.24 22:35, David Sterba wrote:
> > On Mon, Jan 22, 2024 at 02:51:03AM -0800, Johannes Thumshirn wrote:
> >> As btrfs_zoned_should_reclaim only has to iterate the device list in order
> >> to collect stats on the device's total and used bytes, we don't need to
> >> take the full blown mutex, but can iterate the device list in a rcu_read
> >> context.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/zoned.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> >> index 168af9d000d1..b7e7b5a5a6fa 100644
> >> --- a/fs/btrfs/zoned.c
> >> +++ b/fs/btrfs/zoned.c
> >> @@ -2423,15 +2423,15 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> >>   	if (fs_info->bg_reclaim_threshold == 0)
> >>   		return false;
> >>   
> >> -	mutex_lock(&fs_devices->device_list_mutex);
> >> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> >> +	rcu_read_lock();
> >> +	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
> >>   		if (!device->bdev)
> >>   			continue;
> >>   
> >>   		total += device->disk_total_bytes;
> >>   		used += device->bytes_used;
> >>   	}
> >> -	mutex_unlock(&fs_devices->device_list_mutex);
> >> +	rcu_read_unlock();
> > 
> > This is basically only a hint and inaccuracies in the total or used
> > values would be transient, right? The sum is calculated each time the
> > funciton is called, not stored anywhere so in the unlikely case of
> > device removal it may skip reclaim once, but then pick it up later.
> > Any actual removal of the block groups in verified again and properly
> > locked in btrfs_reclaim_bgs_work().
> > 
> 
> Yes.

So please add it to the changelog as an explanation why the mutex -> rcu
switch is safe, thanks.

