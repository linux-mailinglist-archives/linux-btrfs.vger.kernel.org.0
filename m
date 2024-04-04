Return-Path: <linux-btrfs+bounces-3936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E0898F6B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74C91F219AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC979134CCC;
	Thu,  4 Apr 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PSs7eU2I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+K0KbzBk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQbIpLfA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nGR5pFS+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458D134721
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261340; cv=none; b=UfRvXgWKirVyydNvHY1iBtVg03WjDypKZfw7lPjPRp69ywur2BmJst/WT4J8ykStkE1U8D1u7lDZuOZ209ABxhaGox9lwOYN2AT5DcdHruJhdEb2LvjRIppeBogcvSih6HZtcM3nzs+RsODBKKB4KM+b1oNgLRLIlSs+V+y3wEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261340; c=relaxed/simple;
	bh=DuNTnRUD2xfufE8C4/Du+vzfmjEwTXhHM3meLE9BnSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ9dULOCWsvU0E6wJ5MwfhrD0tSgOHeZP3Ia3boFIb0pTgbWyeLMiqeVQVd/HW6Kmh4n5J1w+DwcviLF8Nb2T/3qH47lfNBJjyIcHkfPGOcACRMpMEVc98jCQHanlYU6nC+lUxKf4nFEzzbg15cYHYuUXfOQCdHu4yiSKBgZLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PSs7eU2I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+K0KbzBk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQbIpLfA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nGR5pFS+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAF521F441;
	Thu,  4 Apr 2024 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712261335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcMZmBuJ0SQYLtBKy6NJ8LjuP4K742XHaLSgg9PZPQ=;
	b=PSs7eU2IMkxTabuBvvMMLXFYIib0wSE9aNdkAEfRhYUQV2C9uPCJpiHmxytQt2wl2/8zE8
	dRG+tcLmiTzDjVes4kR9R288+XDOTxd35F0THMXvEPuDJmDZEMvSs4yizv31z4HMJoiDpI
	1vpqVX2WAwEH7z9C6hLHlBNbaQYkgRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712261335;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcMZmBuJ0SQYLtBKy6NJ8LjuP4K742XHaLSgg9PZPQ=;
	b=+K0KbzBkzCnGNRZypPDB94qVDAfGwPDVoBGGd4hJSuNCAQRG7GarORLj5FCzJ/Sw9/wdmt
	s6fAJyd6CyesU8Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DQbIpLfA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nGR5pFS+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712261334;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcMZmBuJ0SQYLtBKy6NJ8LjuP4K742XHaLSgg9PZPQ=;
	b=DQbIpLfAS6WXlEFvc5UV7oJyxt71pSaJwsbhov6W+mFQMJgd2THe5N715jXMVTvhpxnnf4
	I5xdJ3h5nYSrd2wVrPBOfXTgKuVjVlNsjJ2Sy+xkDPfICuXNnaxDTGlTtdBO4i9uXcdOxa
	YBN8bvT0gJ/SYk0QME/4P4wLXUWqRG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712261334;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcMZmBuJ0SQYLtBKy6NJ8LjuP4K742XHaLSgg9PZPQ=;
	b=nGR5pFS+VPMSreP5MkcjFyeyTybZHPO7q6Y9OnbCf6tqFlU09kg4q7jyjEH9lXAJ6Xd2jS
	LH0DfffGeZALJrDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C739F13298;
	Thu,  4 Apr 2024 20:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bPF0MNYID2aecAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 04 Apr 2024 20:08:54 +0000
Date: Thu, 4 Apr 2024 22:01:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: scrub: fix incorrectly reported
 logical/physical address
Message-ID: <20240404200128.GM14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710409033.git.wqu@suse.com>
 <ad7fa3eaa14b93b96cd09dae3657eb825d96d696.1710409033.git.wqu@suse.com>
 <1b78f6ea-04e5-41a9-9699-57ce70116870@oracle.com>
 <822eeff3-3ba6-4d51-98a2-636036ca90b2@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <822eeff3-3ba6-4d51-98a2-636036ca90b2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EAF521F441
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto]

On Fri, Mar 15, 2024 at 06:45:04AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/14 22:54, Anand Jain 写道:
> > On 3/14/24 15:20, Qu Wenruo wrote:
> >> [BUG]
> >> Scrub is not reporting the correct logical/physical address, it can be
> >> verified by the following script:
> >>
> >>   # mkfs.btrfs -f $dev1
> >>   # mount $dev1 $mnt
> >>   # xfs_io -f -c "pwrite -S 0xaa 0 128k" $mnt/file1
> >>   # umount $mnt
> >>   # xfs_io -f -c "pwrite -S 0xff 13647872 4k" $dev1
> >>   # mount $dev1 $mnt
> >>   # btrfs scrub start -fB $mnt
> >>   # umount $mnt
> >>
> >> Note above 13647872 is the physical address for logical 13631488 + 4K.
> >>
> >> Scrub would report the following error:
> >>
> >>   BTRFS error (device dm-2): unable to fixup (regular) error at 
> >> logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
> >>   BTRFS warning (device dm-2): checksum error at logical 13631488 on 
> >> dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, 
> >> offset 0, length 4096, links 1 (path: file1)
> >>
> >> On the other hand, "btrfs check --check-data-csum" is reporting the
> >> correct logical/physical address:
> >>
> >>   Checking filesystem on /dev/test/scratch1
> >>   UUID: db2eb621-b09d-4f24-8199-da17dc7b3201
> >>   [5/7] checking csums against data
> >>   mirror 1 bytenr 13647872 csum 0x13fec125 expected csum 0x656bd64e
> >>   ERROR: errors found in csum tree
> >>
> >> [CAUSE]
> >> In the function scrub_stripe_report_errors(), we always use the
> >> stripe->logical and its physical address to print the error message, not
> >> taking the sector number into consideration at all.
> >>
> >> [FIX]
> >> Fix the error reporting function by calculating logical/physical with
> >> the sector number.
> >>
> >> Now the scrub report is correct:
> >>
> >>   BTRFS error (device dm-2): unable to fixup (regular) error at 
> >> logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
> >>   BTRFS warning (device dm-2): checksum error at logical 13647872 on 
> >> dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, 
> >> offset 16384, length 4096, links 1 (path: file1)
> >>
> >> Fixes: 0096580713ff ("btrfs: scrub: introduce error reporting 
> >> functionality for scrub_stripe")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > 
> > To help accurate debug on stable kernel, we could also add
> > CC: stable@vger.kernel.org #6.4+
> 
> IIRC Fixes: tag is more accurate than just CC stable, as stable has the 
> correct bots catching the fixes line.

Fixes: + CC: is the most reliable way to get patches to stable, CC: is
next but just Fixes: is not guaranteed as it depends on manual
processing.

