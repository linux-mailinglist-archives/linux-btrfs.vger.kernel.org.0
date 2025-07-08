Return-Path: <linux-btrfs+bounces-15335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A88AFCF8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478B93AF80C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1152E1749;
	Tue,  8 Jul 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ivSZf9i4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWmkZO1v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0qyPJpwF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQdRBxrq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A7231824
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989300; cv=none; b=Fmm6Yt6IScfmBFd2AXUvPVYkFrXnrTzLZbFoPDdwBJSzIBgsYX+Qkdoa71BEly95BNBji7sap5RIHqGPmCyrq5d3GrPrPYb0b7h6TlpAE1NCS8bDQgqkh2E1NaBm+il/noEYFZzDGDuLkSRW588FLgILjewY6ntMk6XwEypUD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989300; c=relaxed/simple;
	bh=q0J1PY/2tLRLP9cAt4s1wBNhrzgZSK5OO4eoSUpnJBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHY0ssCBNmh9a/nyQR7rdBAvgion7SJwdh+uvlT2WaTYiKaYvVwNu48HXgDL+SKoBM2LQMlQBKXeIUFqdAGpP5y17/npEGcyK/8SFSosuer4DTTDUOccvm7KvsyTQBSyRUxwAOudU3+2+/6qgpaU2P1kUcMyWYTijNF0AhrpkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ivSZf9i4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWmkZO1v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0qyPJpwF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQdRBxrq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9AFA1F38D;
	Tue,  8 Jul 2025 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751989296;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z47lh4U0ZsRaYgPUDRGOaqf0hFwAE5iGkwm6ZvL+za0=;
	b=ivSZf9i4WhWsRyCb1fNaOzhnnw6dULUtWny2R9S4fyq+pU23ldd1f44hm5Pw+uNWM/huy6
	xbSHTAp5WrmMwjS6G7KvjDJZDOAKaPhLITohHXxHXDlFyIeKiKTFEKV2sIrBhIoD5UVNob
	aKkidot/m82uT9VYDBiK5FmWXLeVOQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751989296;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z47lh4U0ZsRaYgPUDRGOaqf0hFwAE5iGkwm6ZvL+za0=;
	b=hWmkZO1vdfpoPk+ZAB1jftNe7hY7PklkfU5TZjgflODbf7IDEvR9VpWaO8YhVI51wrZ1MU
	L1s0GirjhjYE+tCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0qyPJpwF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LQdRBxrq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751989295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z47lh4U0ZsRaYgPUDRGOaqf0hFwAE5iGkwm6ZvL+za0=;
	b=0qyPJpwF1LyrM+Y+Ohv+NXw5eoQbrSgAdnL+acTXwUbOuI7uRqqysExL6IWelCrVADXIMg
	BbQ7vUQe8ME4c9TLxLWAAdHpOKe3lSWPThdDw8W8lK+TL0hGelIlPpTqYyZYpZmV7aAZsC
	7VtLGo0grX/heJ6rX8g2sO9tDA2u+VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751989295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z47lh4U0ZsRaYgPUDRGOaqf0hFwAE5iGkwm6ZvL+za0=;
	b=LQdRBxrqbuGlOjD+SPZMXJ3mWELhaUZFoob/Ib8Cg/pc1EotoropjPLZea9pub0SyJmAAc
	+9yn3JcAXvt4hLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C594413A54;
	Tue,  8 Jul 2025 15:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ul66Ly88bWjpYAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Jul 2025 15:41:35 +0000
Date: Tue, 8 Jul 2025 17:41:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6] btrfs: try to search for data csums in commit root
Message-ID: <20250708154134.GQ4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8142f4eb91ae32eed53c5ae7121296b44b52d627.1751574142.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E9AFA1F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,lpc.events:url,bur.io:email]
X-Spam-Score: -4.21

On Thu, Jul 03, 2025 at 01:23:24PM -0700, Boris Burkov wrote:
> If you run a workload like:
> - a cgroup that does tons of data reading, with a harsh memory limit
> - a second cgroup that tries to write new files
> 
> then what quickly occurs is:
> - a high degree of contention on the csum root node eb rwsem
> - memory starved cgroup doing tons of reclaim on CPU.
> - many reader threads in the memory starved cgroup "holding" the sem
>   as readers, but not scheduling promptly. i.e., task __state == 0, but
>   not running on a cpu.
> - btrfs_commit_transaction stuck trying to acquire the sem as a writer.
> 
> This results in arbitrarily long transactions. This then results in
> seriously degraded performance for any cgroup using the filesystem (the
> victim cgroup in the script).
> 
> It isn't an academic problem, as we see this exact problem in production
> at Meta with one cgroup over its memory limit ruining btrfs performance
> for the whole system, stalling critical system services that depend on
> btrfs syncs.
> 
> The underlying scheduling "problem" with global rwsems is sort of thorny
> and apparently well known and was discussed at LPC 2024, for example.
> 
> As a result, our main lever in the short term is just trying to reduce
> contention on our various rwsems. In the case of the csum tree, we can
> either redesign btree locking (hard...) or try to use the commit root
> when we can. Luckily, it seems likely that many reads are for old extents
> written many transactions ago, and that for those we *can* in fact
> search the commit root!
> 
> This change detects when we are trying to read an old extent (according
> to extent map generation) and then wires that through bio_ctrl to the
> btrfs_bio, which unfortunately isn't allocated yet when we have this
> information. Luckily, we don't need this flag in the bio after
> submitting, so we can save space by setting it on bbio->bio.bi_flags
> and clear before submitting, so the block layer is unaffected.
> 
> When we go to lookup the csums in lookup_bio_sums we can check this
> condition on the btrfs_bio and do the commit root lookup accordingly.
> 
> Note that a single bio_ctrl might collect a few extent_maps into a single
> bio, so it is important to track a maximum generation across all the
> extent_maps used for each bio to make an accurate decision on whether it
> is valid to look in the commit root. If any extent_map is updated in the
> current generation, we can't use the commit root.
> 
> To test and reproduce this issue, I wrote a script that does the
> following:
> - creates 512 20MiB files (10GiB) each in it's own subvolume (important
>   to avoid any contention on the fs-tree root lock)
> - spawns 512 processes that loop using dd to read 1GiB at a random GiB
>   aligned offset of each file. These "villains" run in a cgroup with
>   memory.high set to 1GiB. Obviously this will generate a lot of memory
>   pressure on this cgroup.
> - spawns 32 processes that loop creating new small files, to trigger a
>   decent amount of csum writes to create the csum root lock contention.
>   These run in a cgroup restricted to just one cpu with cpuset, but no
>   memory restriction. This cpu overlaps with the cpus available to the
>   bad neighbor villain cgroup.
> - attempts to sync every 10 seconds
> - after 60s, it waits for the final sync and kills all the processes via
>   their cg cgroup.kill file.
> 
> Without this patch, that reproducer:
> hung indefinitely, I killed manually via the cgroup.kill file. At this
> time, it had racked up 200s and counting in a btrfs commit critical
> section and had 200+ threads stuck in D state on the csum reader lock:
> 
> elapsed: 914
> commits 3
> cur_commit_ms 0
> last_commit_ms 233784
> max_commit_ms 233784
> total_commit_ms 235056
> 214 hits state D, R comms dd
>                  btrfs_tree_read_lock_nested
>                  btrfs_read_lock_root_node
>                  btrfs_search_slot
>                  btrfs_lookup_csum
>                  btrfs_lookup_bio_sums
>                  btrfs_submit_bbio
> 
> With the patch, the reproducer exits naturally, in 75s, completing a
> pretty decent 5 commits, depsite heavy memory pressure:
> 
> elapsed: 76
> commits 5
> cur_commit_ms 0
> last_commit_ms 1801
> max_commit_ms 3901
> total_commit_ms 8727
> pressure
> some avg10=99.49 avg60=69.22 avg300=21.64 total=72068757
> full avg10=44.81 avg60=24.18 avg300=6.97 total=23015022
> 
> some random rwalker samples showed the most common stack in reclaim,
> rather than the csum tree:
> 145 hits state R comms bash, sleep, dd, shuf
>                  shrink_folio_list
>                  shrink_lruvec
>                  shrink_node
>                  do_try_to_free_pages
>                  try_to_free_mem_cgroup_pages
>                  reclaim_high
> 
> Link: https://lpc.events/event/18/contributions/1883/
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v6:
> - properly handle bio_ctrl submitting a bbio spanning multiple
>   extent_maps with different generations. This was causing csum errors
>   on the previous versions.

We're close to code freeze, such change looks scary but it's v6 and we
still have some time for testing so I think you can add it to for-next.

