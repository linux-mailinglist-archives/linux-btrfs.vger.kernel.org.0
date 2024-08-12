Return-Path: <linux-btrfs+bounces-7126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CF94EF3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4CD1C2199F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E317DE36;
	Mon, 12 Aug 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHh5TYH5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5heTamI0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHh5TYH5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5heTamI0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38017D35C
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471969; cv=none; b=aHLb9GfKq1HIYv5cwGY0hBuWA03i0Mbrn88go8KIPOHtXlHKcC06MIAQJKb0c2Qjr/GwXPVNzRa7FcnFjqtbRR2MZ+8YcwQC72QQzjrYHdYbBupRDq3fbs2wNSDhJ6XbbrajKcPtYK56zswbSrenpjMHFpNF3YOHG1JvSGOYnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471969; c=relaxed/simple;
	bh=2ofsS/dphLaPkroLFiSFUWH84sHytKtq0YVX+NoHlcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd358xW/WmxpRUb9Jk2X3UbQHRFycvctgDuBX8CVVxwTqzkrtgDfsAlM+kqJOIkd26SmTslnZCbh990LT4Pildl4v3mKmqyXxvhFMxJgKogjdcXzHv8afibGH2z1bY1wUy7MgZhyrKk/2lA5WcCym9c8qQbB/03MjbZXkDx20ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHh5TYH5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5heTamI0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHh5TYH5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5heTamI0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19AFB22562;
	Mon, 12 Aug 2024 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723471965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ugLfl/RMENXHxvcpKxW8BPEiTijK2bSfjgzIlQZeD0=;
	b=fHh5TYH5n1s5ZxUltl8ln33s9m79eJolWjH5sLqGYUAI4ISH64zWykoXwhxNR2vMSNrm8W
	Nc7CxD2VAyB8wz5i24QvE+a0cJDZwDl2X/8BUEYbG8n+37obE5BkftU2iFvrTSvFHTiCyr
	qZot3Ms77A49rpx7DLxzz4m4kvSn5JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723471965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ugLfl/RMENXHxvcpKxW8BPEiTijK2bSfjgzIlQZeD0=;
	b=5heTamI0HzKNO3Ctc1ps0uIUsRw+MEATLCouO2vnmK1zu+BGUrgTDt78SK/06I3/zzyL1o
	wWSDb05ehZCwwaAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fHh5TYH5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5heTamI0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723471965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ugLfl/RMENXHxvcpKxW8BPEiTijK2bSfjgzIlQZeD0=;
	b=fHh5TYH5n1s5ZxUltl8ln33s9m79eJolWjH5sLqGYUAI4ISH64zWykoXwhxNR2vMSNrm8W
	Nc7CxD2VAyB8wz5i24QvE+a0cJDZwDl2X/8BUEYbG8n+37obE5BkftU2iFvrTSvFHTiCyr
	qZot3Ms77A49rpx7DLxzz4m4kvSn5JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723471965;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ugLfl/RMENXHxvcpKxW8BPEiTijK2bSfjgzIlQZeD0=;
	b=5heTamI0HzKNO3Ctc1ps0uIUsRw+MEATLCouO2vnmK1zu+BGUrgTDt78SK/06I3/zzyL1o
	wWSDb05ehZCwwaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F150713A23;
	Mon, 12 Aug 2024 14:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDavOlwYumbVCwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 14:12:44 +0000
Date: Mon, 12 Aug 2024 16:12:39 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: only run the extent map shrinker from kswapd tasks
Message-ID: <20240812141239.GH25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d85d72b968a1f7b8538c581eeb8f5baa973dfc95.1723377230.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85d72b968a1f7b8538c581eeb8f5baa973dfc95.1723377230.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 19AFB22562
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Aug 11, 2024 at 04:31:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the extent map shrinker can be run by any task when attempting
> to allocate memory and there's enough memory pressure to trigger it.
> 
> To avoid too much latency we stop iterating over extent maps and removing
> them once the task needs to reschudle. This logic was introduced in commit
> b3ebb9b7e92a ("btrfs: stop extent map shrinker if reschedule is needed").
> 
> While that solved high latency problems for some use cases, it's still
> not enough because with a too high number of tasks entering the extent map
> shrinker code, either due to memory allocations or because they are a
> kswapd task, we end up having a very high level of contention on some
> spin locks, namely:
> 
> 1) The fs_info->fs_roots_radix_lock spin lock, which we need to find
>    roots to iterate over their inodes;
> 
> 2) The spin lock of the xarray used to track open inodes for a root
>    (struct btrfs_root::inodes) - on 6.10 kernels and below, it used to
>    be a red black tree and the spin lock was root->inode_lock;
> 
> 3) The fs_info->delayed_iput_lock spin lock since the shrinker adds
>    delayed iputs (calls btrfs_add_delayed_iput()).
> 
> Instead of allowing the extent map shrinker to be run by any task, make
> it run only by kswapd tasks. This still solves the problem of running
> into OOM situations due to an unbounded extent map creation, which is
> simple to trigger by direct IO writes, as described in the changelog
> of commit 956a17d9d050 ("btrfs: add a shrinker for extent maps"), and
> by a similar case when doing buffered IO on files with a very large
> number of holes (keeping the file open and creating many holes, whose
> extent maps are only released when the file is closed).
> 
> Reported-by: kzd <kzd@56709.net>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219121
> Reported-by: Octavia Togami <octavia.togami@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAHPNGSSt-a4ZZWrtJdVyYnJFscFjP9S7rMcvEMaNSpR556DdLA@mail.gmail.com/
> Fixes: 956a17d9d050 ("btrfs: add a shrinker for extent maps")
> CC: stable@vger.kernel.org # 6.10+
> Tested-by: kzd <kzd@56709.net>
> Tested-by: Octavia Togami <octavia.togami@gmail.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

