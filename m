Return-Path: <linux-btrfs+bounces-7128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6A94EF73
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AB61C211B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF7180032;
	Mon, 12 Aug 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCVnryyI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIpc++BN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vCVnryyI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIpc++BN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40C16C440
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472702; cv=none; b=az/+XHiaiTpwUoQbKgalTMR1rA0nk2dCTjvVZZTu3hNrnUmOaYPjW/MR65DAZ5XkIFV6qR4AQyJad4TJXiQGQd819qU/rWaAP+JtAp8RThbjyjJkc1C1PZ1tf4OuXdnqxqWEFFO72L0CCxBgK6K95fvjdXryzethA5Mb1kaP2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472702; c=relaxed/simple;
	bh=Sxm25Jo23SBZpzlyb/m314tqSSQs1z+jdEBFt5EFF3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ1IZOydBH7el9lmIG6D1Pn1rTWNXahhwNEa98sSI9IBLX90Y7tUbdLiYvP0UO8h5u/xr22PaENaaFHsr6n9ZuYw6/Q+mC+KqaAaj1K9VcReuhFEN9CAM0lxRwa3w8+A+p3uBJvFO6t6+58ymmXkE1qzkUT7tjtlzBvjQ6cQYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCVnryyI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIpc++BN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vCVnryyI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIpc++BN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 728762256A;
	Mon, 12 Aug 2024 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723472698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gA3MHUOJ8JfQoYjMC7iNPTY2vklQWWNe8xGbDG+1kGo=;
	b=vCVnryyIwJf5p4Kr+sWKb7OD7PLQt9neqLT0jMKjozq5AlmjeozwMzabHCWCtQBGMiQS1r
	J+UzsxMibiqbaSqcAnhSPPVfrDBQuVCAXU1u024lLvK1l7gWBBiNd+5ErsaKr4SdQ1fBMm
	iIFjT0kdq+qJCnEm3hJsM4HDYF+/0Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723472698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gA3MHUOJ8JfQoYjMC7iNPTY2vklQWWNe8xGbDG+1kGo=;
	b=uIpc++BNeNF4vkByK7nq35A5yKMdPiE3SQl34RBbxqgjAupm3drB3o7LS5fPrAL/HRDScF
	uYoZSPzMb+nWZQCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vCVnryyI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uIpc++BN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723472698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gA3MHUOJ8JfQoYjMC7iNPTY2vklQWWNe8xGbDG+1kGo=;
	b=vCVnryyIwJf5p4Kr+sWKb7OD7PLQt9neqLT0jMKjozq5AlmjeozwMzabHCWCtQBGMiQS1r
	J+UzsxMibiqbaSqcAnhSPPVfrDBQuVCAXU1u024lLvK1l7gWBBiNd+5ErsaKr4SdQ1fBMm
	iIFjT0kdq+qJCnEm3hJsM4HDYF+/0Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723472698;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gA3MHUOJ8JfQoYjMC7iNPTY2vklQWWNe8xGbDG+1kGo=;
	b=uIpc++BNeNF4vkByK7nq35A5yKMdPiE3SQl34RBbxqgjAupm3drB3o7LS5fPrAL/HRDScF
	uYoZSPzMb+nWZQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EEC813A23;
	Mon, 12 Aug 2024 14:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g18IEzobumbEDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 14:24:58 +0000
Date: Mon, 12 Aug 2024 16:24:53 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: allow cloning non-aligned extent if it ends
 at i_size
Message-ID: <20240812142453.GI25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e764923c5a0bca3cdf90199da34747b38094a390.1723469840.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e764923c5a0bca3cdf90199da34747b38094a390.1723469840.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 728762256A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 02:50:34PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we a find that an extent is shared but its end offset is not sector
> size aligned, then we don't clone it and issue write operations instead.
> This is because the reflink (remap_file_range) operation does not allow
> to clone unaligned ranges, except if the end offset of the range matches
> the i_size of the source and destination files (and the start offset is
> sector size aligned).
> 
> While this is not incorrect because send can only guarantee that a file
> has the same data in the source and destination snapshots, it's not
> optimal and generates confusion and surprising behaviour for users.
> 
> For example, running this test:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdi
>   MNT=/mnt/sdi
> 
>   mkfs.btrfs -f $DEV
>   mount $DEV $MNT
> 
>   # Use a file size not aligned to any possible sector size.
>   file_size=$((1 * 1024 * 1024 + 5)) # 1MB + 5 bytes
>   dd if=/dev/random of=$MNT/foo bs=$file_size count=1
>   cp --reflink=always $MNT/foo $MNT/bar
> 
>   btrfs subvolume snapshot -r $MNT/ $MNT/snap
>   rm -f /tmp/send-test
>   btrfs send -f /tmp/send-test $MNT/snap
> 
>   umount $MNT
>   mkfs.btrfs -f $DEV
>   mount $DEV $MNT
> 
>   btrfs receive -vv -f /tmp/send-test $MNT
> 
>   xfs_io -r -c "fiemap -v" $MNT/snap/bar
> 
>   umount $MNT
> 
> Gives the following result:
> 
>   (...)
>   mkfile o258-7-0
>   rename o258-7-0 -> bar
>   write bar - offset=0 length=49152
>   write bar - offset=49152 length=49152
>   write bar - offset=98304 length=49152
>   write bar - offset=147456 length=49152
>   write bar - offset=196608 length=49152
>   write bar - offset=245760 length=49152
>   write bar - offset=294912 length=49152
>   write bar - offset=344064 length=49152
>   write bar - offset=393216 length=49152
>   write bar - offset=442368 length=49152
>   write bar - offset=491520 length=49152
>   write bar - offset=540672 length=49152
>   write bar - offset=589824 length=49152
>   write bar - offset=638976 length=49152
>   write bar - offset=688128 length=49152
>   write bar - offset=737280 length=49152
>   write bar - offset=786432 length=49152
>   write bar - offset=835584 length=49152
>   write bar - offset=884736 length=49152
>   write bar - offset=933888 length=49152
>   write bar - offset=983040 length=49152
>   write bar - offset=1032192 length=16389
>   chown bar - uid=0, gid=0
>   chmod bar - mode=0644
>   utimes bar
>   utimes
>   BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=06d640da-9ca1-604c-b87c-3375175a8eb3, stransid=7
>   /mnt/sdi/snap/bar:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..2055]:       26624..28679      2056   0x1
> 
> There's no clone operation to clone extents from the file foo into file
> bar and fiemap confirms there's no shared flag (0x2000).
> 
> So update send_write_or_clone() so that it proceeds with cloning if the
> source and destination ranges end at the i_size of the respective files.
> 
> After this changes the result of the test is:
> 
>   (...)
>   mkfile o258-7-0
>   rename o258-7-0 -> bar
>   clone bar - source=foo source offset=0 offset=0 length=1048581
>   chown bar - uid=0, gid=0
>   chmod bar - mode=0644
>   utimes bar
>   utimes
>   BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=582420f3-ea7d-564e-bbe5-ce440d622190, stransid=7
>   /mnt/sdi/snap/bar:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..2055]:       26624..28679      2056 0x2001
> 
> A test case for fstests will also follow up soon.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/572#issuecomment-2282841416
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

