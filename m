Return-Path: <linux-btrfs+bounces-9971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B49DEAD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F828156B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8714B077;
	Fri, 29 Nov 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WmHWsFEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9LEa+V/x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WmHWsFEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9LEa+V/x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCF1B95B
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897287; cv=none; b=n+Vn8Lk1g1xdjdqBsITtpubxHUzNWActNhn0qMCpASVOMPFgMXJgVSr8bopwmdifEKnV5c/jWo+kfpdkB3vsjTYf2AlWb6IvRfM8t5mlD+sSaoOSfalO3Npgjl4eA6CSlMtKQuS6USwAPQl62G5I492TvreFCS/q/xgP9TBBE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897287; c=relaxed/simple;
	bh=3fU+9Pj3WhnkGMrQgGafD5IKfRk0LEQDTn+nHqIhqd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaYY1oLUn9mS4BLN4DQGjsPPDjBkIUliRL4MmH01B2N55HUYZeqCzXKce0B+xpCMumnpvXF4GaMHt6V+zGkIBPrdEZ2VG40Ltd9OC4TUg4f4dxBCAEBS7Nho2ClqxSGKSwENwES5qnAnrRrB9FHv4Hl1REwo6Azi5NYI6/xQ69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WmHWsFEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9LEa+V/x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WmHWsFEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9LEa+V/x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7E4621125;
	Fri, 29 Nov 2024 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732897282;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kachbt7op/AlznUCTSgNtwThieEEIjdBYx/++b+Lvw4=;
	b=WmHWsFEXebYGfyQ3OXm9/ohKxoPXA/XM3JKejNL01SbzN18DjRqLeczfL88uPcwFkL7vz+
	qUJ0MKg1ODk0h33JSUiXzQfL0/kKX/jPreK6s1iawWAMsHXKiGCUPuZ4G8QvmKQG94xXxr
	Hl3ho9ZP7NoJJXqyFH6usuf0ys522P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732897282;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kachbt7op/AlznUCTSgNtwThieEEIjdBYx/++b+Lvw4=;
	b=9LEa+V/xeEDkE/lyd+6rVMRkFBJcnZOuZwWGxusliNe5OcUArau5+QEFjoUYaI7gVMSAAj
	lb4suPanpKeHh/Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732897282;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kachbt7op/AlznUCTSgNtwThieEEIjdBYx/++b+Lvw4=;
	b=WmHWsFEXebYGfyQ3OXm9/ohKxoPXA/XM3JKejNL01SbzN18DjRqLeczfL88uPcwFkL7vz+
	qUJ0MKg1ODk0h33JSUiXzQfL0/kKX/jPreK6s1iawWAMsHXKiGCUPuZ4G8QvmKQG94xXxr
	Hl3ho9ZP7NoJJXqyFH6usuf0ys522P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732897282;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kachbt7op/AlznUCTSgNtwThieEEIjdBYx/++b+Lvw4=;
	b=9LEa+V/xeEDkE/lyd+6rVMRkFBJcnZOuZwWGxusliNe5OcUArau5+QEFjoUYaI7gVMSAAj
	lb4suPanpKeHh/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABB30133F3;
	Fri, 29 Nov 2024 16:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TImrKQLqSWdfWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Nov 2024 16:21:22 +0000
Date: Fri, 29 Nov 2024 17:21:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: zoned: implement ZONE_RESET space_info
 reclaiming
Message-ID: <20241129162121.GX31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731571240.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731571240.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Nov 14, 2024 at 05:04:26PM +0900, Naohiro Aota wrote:
> There is a longstanding early ENOSPC issue on the zoned mode. When there
> are heavy write operations on a nearly ENOSPC file system, freeing up
> the space and resetting the zones often cannot catch up the write speed.
> That results in an early ENOSPC. For example, running the following fio
> script, which repeatedly over-writes 15 GB files on 20 GB file system
> results in a ENOSPC shown below.
> 
> Fio script:
> 
>   [test]
>   filename=/mnt/scratch/test
>   readwrite=write
>   ioengine=libaio
>   direct=1
>   loops=10
>   filesize=15G
>   bs=128k
> 
> Result:
> 
>   BTRFS info (device nvme0n1): cannot satisfy tickets, dumping space info
>   BTRFS info (device nvme0n1): space_info DATA has 0 free, is full
>   BTRFS info (device nvme0n1): space_info total=20535312384, used=16106127360, pinned=0, reserved=0, may_use=0,
>   readonly=0 zone_unusable=4429185024
>   BTRFS info (device nvme0n1): failing ticket with 131072 bytes
>   BTRFS info (device nvme0n1): space_info DATA has 0 free, is full
>   BTRFS info (device nvme0n1): space_info total=20535312384, used=16106127360, pinned=0, reserved=0, may_use=0,
>   readonly=0 zone_unusable=4429185024
>   BTRFS info (device nvme0n1): global_block_rsv: size 25870336 reserved 25853952
>   BTRFS info (device nvme0n1): trans_block_rsv: size 0 reserved 0
>   BTRFS info (device nvme0n1): chunk_block_rsv: size 0 reserved 0
>   BTRFS info (device nvme0n1): delayed_block_rsv: size 0 reserved 0
>   BTRFS info (device nvme0n1): delayed_refs_rsv: size 0 reserved 0
>   fio: io_u error on file /mnt/scratch/test: No space left on device: write offset=13287555072, buflen=131072
>   fio: pid=869, err=28/file:io_u.c:1962, func=io_u error, error=No space left on device
>   ...
>   Run status group 0 (all jobs):
>     WRITE: bw=113MiB/s (118MB/s), 113MiB/s-113MiB/s (118MB/s-118MB/s), io=27.4GiB (29.4GB), run=248965-248965msec
> 
> As the result shows, fio fails only after 27GB. Instead, it should be
> able to write 150 GB by freeing over-written region. The space_info
> status shows that there is 4.1 GB zone_unusable in the DATA space. While
> this space will be eventually freed after a transaction commit and zone
> reset, the space_info dump means btrfs is too slow to reuse the zone_unusable.
> 
> There are some reasons to hit ENOSPC early and this series only
> addresses one of them: unusable block group is not reclaimed enough
> fast. This series introduces a new space_info reclaim method
> ZONE_RESET. That method will pick a block group in the unused list and
> send ZONE_RESET command to free up and reuse the zone_unusable space.
> 
> For the first implementation, the ZONE_RESET is only applied to a block
> group whose region is fully zone_unusable. Reclaiming partial
> zone_unusable block group could be implemented later.
> 
> Patches 1 and 2 do the preparation for the patch 3 and there are no
> functional change. Patch 3 introduces the new space_info reclaim method
> ZONE_RESET described above.
> 
> Following series will fully fix ENOSPC issue on the above fio script.
> One will separate space_info of regular data and relocation data. And,
> another will rework zone resetting of deleted block group to let it set
> the empty zone bit early.
> 
> Changes:
> - v2:
>   - Use the ordinal locking style.
>   - Rewrite btrfs_return_free_space() to reduce indent level.
>   - Add some extra comment.
> - v1: https://lore.kernel.org/linux-btrfs/gjr4vwt5qm7j36xnjijp5wqttpmh62trhsq5vqeotcqm6kx2pq@qovd36rh7hap/T/
> 
> Naohiro Aota (3):
>   btrfs: introduce btrfs_return_free_space()
>   btrfs: drop fs_info argument from btrfs_update_space_info_*
>   btrfs: zoned: reclaim unused zone by zone resetting

The logic sounds ok to me, I've added the patches to for-next, thanks.

