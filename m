Return-Path: <linux-btrfs+bounces-3932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44613898EA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF818B28A76
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543C0133419;
	Thu,  4 Apr 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZXB4aDUL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Jvbkbv2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KIJqwcbZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+jQgU1Bi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D24132C15;
	Thu,  4 Apr 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257540; cv=none; b=eMwiywb6i7mG+rBb6lcIzefLBNnmg0swvA8Dm/sewONjXow577/2NjofB2d3HOb30WazELIN4aLdMgucZzDUjHUHBSwqH1rO3GOyiXt0hQjU4UFwGb6vXvszMQcrNKnSXqAhN9Pq43C/T0hI7XPs+3rCQNR8+TD3evVSE280IH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257540; c=relaxed/simple;
	bh=AF5GLsGnUq7DBEzjfswvqPbyx8RwK9rl8FXLvx9bNfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxmehJlbfB/iDxafoq6wQxsIib/QO4bmTiBC8/el87Ah/KTu11IbLof80B8JtwoMzSBd7gSdojmtCoUbH2apBAJEae2ecrgHNU12+/vxk8EKrBwrHVWuEk/+bsqfU7VSQGteoW0iQYY/SGY0/s2DkIAdt1kwsi6LLollplzCH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZXB4aDUL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Jvbkbv2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KIJqwcbZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+jQgU1Bi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F4EC1F444;
	Thu,  4 Apr 2024 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712257536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vPEYvevqdIYmLIkzMR0eI0uKxDxhqYbaekAWsmOKMU=;
	b=ZXB4aDULaRL3SCktX0W+djqpyk9ArokEsbo/83ksaNOyhoHHbZWzUyHFfhF+11ttmY1tZZ
	63d8N/ofljSl+bIi1xIagIi9/M1bqdmojyL4HuspvNKNba6/7cmpSEupoze2PO+zRIBNSv
	SiHFB/BSDc2kaCQvR7WwQoIuP+vthZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712257536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vPEYvevqdIYmLIkzMR0eI0uKxDxhqYbaekAWsmOKMU=;
	b=8Jvbkbv2jMkBBUEdgBe1yOLq0EUAzlmVx4zLdjFFQFF2oAggbkAw64zu2NM4PP+RI0jrPM
	nUwcfk+CwC+4DTBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712257535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vPEYvevqdIYmLIkzMR0eI0uKxDxhqYbaekAWsmOKMU=;
	b=KIJqwcbZmt31ALXtZIDHjeFAF7LbwztT9aEZaeSk1CAvjMC5ToIcj3oqAXTXv1gj0NYInT
	I/WCoM4VaThBK4rqB0A0mUlvHdP5swVmroGh/cFsIhnltBBNf8aav8i8+znLf4L8kMJdY9
	oMi3ObmSCFuPGNShIdg09ooiCaXtw4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712257535;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vPEYvevqdIYmLIkzMR0eI0uKxDxhqYbaekAWsmOKMU=;
	b=+jQgU1BiybE+kJWS1YdOF/zbtozb1YljnSRFZaA0xBSM7wZPumUoEQ5NCZky5JCClFOKIF
	SJkoNDmpz6uWBWBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEB8139E8;
	Thu,  4 Apr 2024 19:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IBBqAv/5DmaUXgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 04 Apr 2024 19:05:35 +0000
Date: Thu, 4 Apr 2024 20:58:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 59/68] btrfs: preallocate temporary extent
 buffer for inode logging when needed
Message-ID: <20240404185812.GI14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240329122652.3082296-1-sashal@kernel.org>
 <20240329122652.3082296-59-sashal@kernel.org>
 <20240402133518.GD14596@suse.cz>
 <Zgyj800yVkeKmbmq@sashalap>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgyj800yVkeKmbmq@sashalap>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,toxicpanda.com:email,suse.com:email,suse.cz:replyto,test.sh:url]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Apr 02, 2024 at 08:33:55PM -0400, Sasha Levin wrote:
> On Tue, Apr 02, 2024 at 03:35:18PM +0200, David Sterba wrote:
> >On Fri, Mar 29, 2024 at 08:25:55AM -0400, Sasha Levin wrote:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> [ Upstream commit e383e158ed1b6abc2d2d3e6736d77a46393f80fa ]
> >>
> >> When logging an inode and we require to copy items from subvolume leaves
> >> to the log tree, we clone each subvolume leaf and than use that clone to
> >> copy items to the log tree. This is required to avoid possible deadlocks
> >> as stated in commit 796787c978ef ("btrfs: do not modify log tree while
> >> holding a leaf from fs tree locked").
> >>
> >> The cloning requires allocating an extent buffer (struct extent_buffer)
> >> and then allocating pages (folios) to attach to the extent buffer. This
> >> may be slow in case we are under memory pressure, and since we are doing
> >> the cloning while holding a read lock on a subvolume leaf, it means we
> >> can be blocking other operations on that leaf for significant periods of
> >> time, which can increase latency on operations like creating other files,
> >> renaming files, etc. Similarly because we're under a log transaction, we
> >> may also cause extra delay on other tasks doing an fsync, because syncing
> >> the log requires waiting for tasks that joined a log transaction to exit
> >> the transaction.
> >>
> >> So to improve this, for any inode logging operation that needs to copy
> >> items from a subvolume leaf ("full sync" or "copy everything" bit set
> >> in the inode), preallocate a dummy extent buffer before locking any
> >> extent buffer from the subvolume tree, and even before joining a log
> >> transaction, add it to the log context and then use it when we need to
> >> copy items from a subvolume leaf to the log tree. This avoids making
> >> other operations get extra latency when waiting to lock a subvolume
> >> leaf that is used during inode logging and we are under heavy memory
> >> pressure.
> >>
> >> The following test script with bonnie++ was used to test this:
> >>
> >>   $ cat test.sh
> >>   #!/bin/bash
> >>
> >>   DEV=/dev/sdh
> >>   MNT=/mnt/sdh
> >>   MOUNT_OPTIONS="-o ssd"
> >>
> >>   MEMTOTAL_BYTES=`free -b | grep Mem: | awk '{ print $2 }'`
> >>   NR_DIRECTORIES=20
> >>   NR_FILES=20480
> >>   DATASET_SIZE=$((MEMTOTAL_BYTES * 2 / 1048576))
> >>   DIRECTORY_SIZE=$((MEMTOTAL_BYTES * 2 / NR_FILES))
> >>   NR_FILES=$((NR_FILES / 1024))
> >>
> >>   echo "performance" | \
> >>       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> >>
> >>   umount $DEV &> /dev/null
> >>   mkfs.btrfs -f $MKFS_OPTIONS $DEV
> >>   mount $MOUNT_OPTIONS $DEV $MNT
> >>
> >>   bonnie++ -u root -d $MNT \
> >>       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
> >>       -r 0 -s $DATASET_SIZE -b
> >>
> >>   umount $MNT
> >>
> >> The results of this test on a 8G VM running a non-debug kernel (Debian's
> >> default kernel config), were the following.
> >>
> >> Before this change:
> >>
> >>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
> >>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> >>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> >>   debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95 +++++ +++
> >>   Latency             35068us   24976us    2944ms   30725us   71770us   26152us
> >>   Version 2.00a       ------Sequential Create------ --------Random Create--------
> >>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
> >>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> >>   20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56 20480  61
> >>   Latency               411ms   11914us     119ms     617ms   10296us     110ms
> >>
> >> After this change:
> >>
> >>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
> >>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> >>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> >>   debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98 +++++ +++
> >>   Latency             35975us  20945us    2144ms   10297us    2217us    6004us
> >>   Version 2.00a       ------Sequential Create------ --------Random Create--------
> >>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
> >>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> >>   20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57 20480  59
> >>   Latency               320ms   11237us   77779us     518ms    6470us   86389us
> >>
> >> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >> Reviewed-by: David Sterba <dsterba@suse.com>
> >> Signed-off-by: David Sterba <dsterba@suse.com>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >This is a performance improvement, how does this qualify for stable? I
> >read only about notable perfromance fixes but this is not one.
> 
> No objection to dropping it. Description of the commit states that it
> fixes blocking for "significant amount of time".

I see, that would make sense as keyword for stable backport, though it
applies under heavy memory pressure so not a regular workload where I'd
consider it for stable right away. A system under load will block on
many allocations, from that perspective the patch may not make any
difference.

