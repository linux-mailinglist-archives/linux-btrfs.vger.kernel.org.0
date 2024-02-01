Return-Path: <linux-btrfs+bounces-2039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB18460A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DBC1C22ED7
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77185266;
	Thu,  1 Feb 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtnrYGjh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kma1vS9p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtnrYGjh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kma1vS9p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DF8405B
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814463; cv=none; b=HPDD+sQ5E7MetYWOY6dTqPv8LRQ9i05UZOVzz845vhki81xeSrchXahGGF734K+kJjL77nZmhdl//jIZRW3SjQfs8Wh9J0yv0+ukaqbaREhgISWug2zVXinRRPKD7/k88OxQEjTTXN8rdhWhuASqlEvAkKRUb44gHeHPHsDAGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814463; c=relaxed/simple;
	bh=2tU9NzVj9+OCKZO8ptvHheOVWiLV3p/EsK332lG6JPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skvO5/UUJjmyxz1iZ+WppEwMHTOthYLIrPeFI+45IuEmlWl/ExqlR26uBzz5nbakBXsVXhKTNVW8HDLyJklcKUy9yeGV48bZrCdn/Xq17y/CUf4WUNpnP1/lSwyP/NtHKWTPsWILAntkGosUfh8k91PyprXy6AQuSszs6NVnwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtnrYGjh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kma1vS9p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtnrYGjh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kma1vS9p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CBBE22104;
	Thu,  1 Feb 2024 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706814459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ga9QnSU8+oc4uQOTki7QCzZGKjtDHy2OLhEAdpV2FkQ=;
	b=rtnrYGjhZtW/OJbbuFaYdaqzAzsD2OhFcMpgKwfk5aYNawFM2uhMBFEv4dlU+sXcRS0VMh
	gz/MGMhII92qixMuu0/bDijQwynyduhdJR0oMtWaHxkRTby2sGObyxfPLDgE3ThfcjFuDJ
	yaDCxAoYPCRv6Kzzh1fYTldWAea7opI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706814459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ga9QnSU8+oc4uQOTki7QCzZGKjtDHy2OLhEAdpV2FkQ=;
	b=kma1vS9p50+syxApo3V6TvzO+PNwGw3macmYTpzNNnl3bkkSc/pizENQeqc3fvM8QYF2pK
	yH/twwtd69g4waCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706814459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ga9QnSU8+oc4uQOTki7QCzZGKjtDHy2OLhEAdpV2FkQ=;
	b=rtnrYGjhZtW/OJbbuFaYdaqzAzsD2OhFcMpgKwfk5aYNawFM2uhMBFEv4dlU+sXcRS0VMh
	gz/MGMhII92qixMuu0/bDijQwynyduhdJR0oMtWaHxkRTby2sGObyxfPLDgE3ThfcjFuDJ
	yaDCxAoYPCRv6Kzzh1fYTldWAea7opI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706814459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ga9QnSU8+oc4uQOTki7QCzZGKjtDHy2OLhEAdpV2FkQ=;
	b=kma1vS9p50+syxApo3V6TvzO+PNwGw3macmYTpzNNnl3bkkSc/pizENQeqc3fvM8QYF2pK
	yH/twwtd69g4waCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86E1B1329F;
	Thu,  1 Feb 2024 19:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8nFyIPvru2XgWgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 01 Feb 2024 19:07:39 +0000
Date: Thu, 1 Feb 2024 20:07:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
 mkfs.btrfs
Message-ID: <20240201190712.GW31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
 <20240131204800.GB3203388@perftesting>
 <04a9a9cf-0c77-4f1e-b9f3-12cceeb7ef57@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a9a9cf-0c77-4f1e-b9f3-12cceeb7ef57@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rtnrYGjh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kma1vS9p
X-Spamd-Result: default: False [-1.51 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CBBE22104
X-Spam-Level: 
X-Spam-Score: -1.51
X-Spam-Flag: NO

On Thu, Feb 01, 2024 at 07:19:15PM +1030, Qu Wenruo wrote:
> The problem is, even if we change the sequence, it doesn't make much
> difference.
> 
> There are several things involved, and most of them are out of our control:
> 
> - The udev scan is triggered on writable fd close().
> - The udev scan is always executed on the parent block device
>    Not the partition device.
> - The udev scan the whole disk, not just the partition
> 
> With those involved, changing the nested behavior would not change anything.
> 
> The write in another partition of the same parent block device can still
> triggered a scan meanwhile we're making fs on our partition.

So this means that creating ext4 on /dev/sda1 and btrfs on /dev/sda2 can
trigger the udev events? And when both mkfs utilities would lock the
device then running them concurrently will fail, right? This could
happen in installation tools that can create different filesystems at
the same time.

I wonder if we should add options to assert, skip locking or wait until
it's free.

