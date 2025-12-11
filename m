Return-Path: <linux-btrfs+bounces-19664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416BCB6E20
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1401B3016CD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954F219E8;
	Thu, 11 Dec 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1WQweuF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xLqbzSbJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GNTYxhSz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WUACMtXJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FB31960B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476916; cv=none; b=fD9jEyZoPCrZZqYT/flrC9vWN5wJqgfL1JexSG5+/yQVCc0nhpIQ7+xrdnmTJkdruPD/xuvb4D0Fq1geFUAOYKMZ3qbkay+01ERSCPUgqQU/PHM7XM887NnQYTqQigDG3RDCyy4OAo0HtX0zB6I0BZjZ/8lZNzHXr6upcAISq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476916; c=relaxed/simple;
	bh=aHkKByXKkjCeDVob7h73dl32TZpzEEvk57g+msOJEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAhO1U9B8uigJtzUSbRDTjzLaS6cjeq+xBmyogy/5HVITZ+te8WQWmbAr+PK6szUKGEHJ4vxIYhbc8qO9KrSvZ0wc9FRRgne64yw1g/5h266sFuf/3HdV/6BvRmfdLf7cBYCQhoQ+KBRbAwPu5ah0hs1EsUlBM7qBofADF2Bjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1WQweuF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xLqbzSbJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GNTYxhSz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WUACMtXJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BC1C5BDD8;
	Thu, 11 Dec 2025 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765476910;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJ7421P1nvatOMM+ai/1StLe8hgmRGEiU7PzB3iaDQ=;
	b=F1WQweuFrtoQfuUAqBm0TUk7ckShdSqVahK1LhZUb8uGv08KcFnSLrAtDP2IFZlzgcLOIL
	G1T1nX3ydnomn7bmqIK7JplKewlqI/GyFfezpl3eM8+5BWuZJO+YQgeEo1gZcDWtHWQ9p0
	mZ0vM1O5rhM0tJwBrhZKD0HZ3EfAv5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765476910;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJ7421P1nvatOMM+ai/1StLe8hgmRGEiU7PzB3iaDQ=;
	b=xLqbzSbJNY6uxH2FqE+cVfqtLlt9RI1kwabJkeGLUI+gxymcy5lXIDQF2vF2TXBE13C0Wn
	W+BGyS/75UupqDCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GNTYxhSz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WUACMtXJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765476909;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJ7421P1nvatOMM+ai/1StLe8hgmRGEiU7PzB3iaDQ=;
	b=GNTYxhSzHk+PbH3joyeTur2Rm+T2gVXvPM8VVnHY6BE6jbsRmBQgvYeb7yNrJum9GrZOZF
	GcQ4DE1xhSJdxfz4DS3FYMNcIyTs1GF019j7ZfY7BMiapapS09CAggRC4O7tEyx7M7qd9v
	5xi0jQYBpsxGM6ihFoyuqJdMcgaYEF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765476909;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJ7421P1nvatOMM+ai/1StLe8hgmRGEiU7PzB3iaDQ=;
	b=WUACMtXJZ0bpVvJYfZhMONI83ruVUtEXxiJWOPrkbqRPkYmG3NLJHNLUKctHOp5hjUI8AJ
	rSst0+vOl2BMDaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 654A63EA63;
	Thu, 11 Dec 2025 18:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ruE/GC0KO2nlDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Dec 2025 18:15:09 +0000
Date: Thu, 11 Dec 2025 19:15:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/226: skip the test for bs > ps cases
Message-ID: <20251211181508.GI4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251209082504.107995-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209082504.107995-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 7BC1C5BDD8
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,btrfs-vm:email,suse.cz:dkim,suse.cz:replyto];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Tue, Dec 09, 2025 at 06:55:04PM +1030, Qu Wenruo wrote:
> [RANDOM FAILURE]
> Sometimes btrfs/226 can fail but sometimes it can also pass with 8K
> fs block size and 4K page size:
> 
> [adam@btrfs-vm xfstests]$ sudo ./check btrfs/226
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-custom+ #323 SMP PREEMPT_DYNAMIC Mon Dec  8 07:38:30 ACDT 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/226    2s ...  3s
> Ran: btrfs/226
> Passed all 1 tests
> 
> [adam@btrfs-vm xfstests]$ sudo ./check btrfs/226
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-custom+ #323 SMP PREEMPT_DYNAMIC Mon Dec  8 07:38:30 ACDT 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/226    3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/226.out.bad)
>     --- tests/btrfs/226.out	2024-04-12 14:04:03.080000035 +0930
>     +++ /home/adam/xfstests/results//btrfs/226.out.bad	2025-12-09 18:46:44.416878799 +1030
>     @@ -39,14 +39,11 @@
>      Testing write against prealloc extent at eof
>      wrote 65536/65536 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 65536/65536 bytes at offset 65536
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +pwrite: Resource temporarily unavailable
>      File after write:
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/226.out /home/adam/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
> Ran: btrfs/226
> Failures: btrfs/226
> Failed 1 of 1 tests
> 
> [CAUSE]
> For the failure case, the failure is from check_direct_IO(), which find
> out that the buffer provided is only aligned to PAGE_SIZE (4K), not to the
> fs block size (8K).
> 
> The user space can only ensure the allocated memory is contiguous in the
> user space, but the user space can not ensure the underlying physical
> memory layout, thus depending on the memory allocation situation, the
> user space can not always get physically contiguous memory, and fail the
> check_direct_IO() call.
> 
> After failed check_direct_IO(), we fall back to buffered IO, but since
> this particular test case is using RWF_NOWAIT, rejecting buffered IO
> fallback, the direct IO failed with -EAGAIN.
> 
> [FIX]
> Since we can not ensure the physical memory layout for direct IO, just
> skip this test case if the fs block size is larger than page size.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

