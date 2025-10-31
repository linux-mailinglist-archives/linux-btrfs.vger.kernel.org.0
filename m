Return-Path: <linux-btrfs+bounces-18473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1794C26A9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49BA188E365
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030BB2FC865;
	Fri, 31 Oct 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mquQfEy/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kYUGwhsi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mquQfEy/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kYUGwhsi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD4277013
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937317; cv=none; b=BJNWuRDrVXiseKdnb3H4g5XWPXrkfuLWWtXfcfOIV3Yfiio/lmgdlWfhCn4MWKCBBplLpvFHiqrivKdaAcfKewTgVoG7rQtrSj7upk1aM9zf1X2OlBc9vvRfdu06gV3msBB0YBq1gA7ZU+LAy0sqnkZM7bijE+FThxxmLZH731c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937317; c=relaxed/simple;
	bh=Rc6Q9xWMMggPEwaOpNGLrHi9Fik8q5zYFRrNjwpc0/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUpJrD1jxWcZZOpt9Ea3yl3Zk2Hlmwc1fmdx1xtCD/4XxtMAdzvPGsuFUxXAVwymRqA1Aqrrh91x+Ffp9C4Xz3SyKD1OPivvhdi6RUR2OJ7nJseFBUN6tNAljPD7mbU/qf/LhcKDaJgrMOA978kEsuT7/6i5VNyYV8IEFMLGhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mquQfEy/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kYUGwhsi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mquQfEy/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kYUGwhsi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CB9D1F388;
	Fri, 31 Oct 2025 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761937312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9u2ib0p1crU+V4c12Wzt2tPwDYX53KhojBLRjOI3oNU=;
	b=mquQfEy/Gr7umKzu9IujQbUMiVgdErMIu8C4J38FnezWX2dPsaCO+drUV2k2pvOySEqCjk
	+r1zjxWzmT2uEdGpOIL5DpGSRH2oeklnfaxAtA8EWh1TSooKvlZvUJM3fQ1wZsoquHbgUb
	fa+d9a3ylp+TKfHK7faBe5t+Scc43ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761937312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9u2ib0p1crU+V4c12Wzt2tPwDYX53KhojBLRjOI3oNU=;
	b=kYUGwhsinUCwJhrkk01oTYblkBx+ovLhG8BoJQOBwqR/HSRkxiQFj9zKHcF+XPOsASWVgL
	E6ml/jAt/NW0QmCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mquQfEy/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kYUGwhsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761937312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9u2ib0p1crU+V4c12Wzt2tPwDYX53KhojBLRjOI3oNU=;
	b=mquQfEy/Gr7umKzu9IujQbUMiVgdErMIu8C4J38FnezWX2dPsaCO+drUV2k2pvOySEqCjk
	+r1zjxWzmT2uEdGpOIL5DpGSRH2oeklnfaxAtA8EWh1TSooKvlZvUJM3fQ1wZsoquHbgUb
	fa+d9a3ylp+TKfHK7faBe5t+Scc43ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761937312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9u2ib0p1crU+V4c12Wzt2tPwDYX53KhojBLRjOI3oNU=;
	b=kYUGwhsinUCwJhrkk01oTYblkBx+ovLhG8BoJQOBwqR/HSRkxiQFj9zKHcF+XPOsASWVgL
	E6ml/jAt/NW0QmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B7C913393;
	Fri, 31 Oct 2025 19:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JECeAqAHBWmZFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 19:01:52 +0000
Date: Fri, 31 Oct 2025 20:01:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 12/13] btrfs: use blkdev_report_zones_cached()
Message-ID: <20251031190150.GJ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-13-dlemoal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2CB9D1F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Oct 31, 2025 at 03:13:06PM +0900, Damien Le Moal wrote:
> Modify btrfs_get_dev_zones() and btrfs_sb_log_location_bdev() to replace
> the call to blkdev_report_zones() with blkdev_report_zones_cached() to
> speed-up mount operations. btrfs_get_dev_zone_info() is also modified to
> take into account the BLK_ZONE_COND_ACTIVE condition, which is
> equivalent to either BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN or
> BLK_ZONE_COND_CLOSED.
> 
> With this change, mounting a freshly formatted large capacity (30 TB)
> SMR HDD completes under 100ms compared to over 1.8s before.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Acked-by: David Sterba <dsterba@suse.com>

