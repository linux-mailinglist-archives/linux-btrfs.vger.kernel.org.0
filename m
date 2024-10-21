Return-Path: <linux-btrfs+bounces-9025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6D9A6B89
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AD11C21CA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23601FA257;
	Mon, 21 Oct 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I02H+GuB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gf4q4fsm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DGGCOrq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8mmxFI4U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B81D173A
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519528; cv=none; b=WltbENUNhcnUuocGsQJEVK4khdU0lRhotLOjYNK3QwYeUHGT0PhJ0fvwqyqRmKEXR0z/wpSFOzDWOvgMO1sFAg5Yw4zRbKZUjnRvYujvPaVc7l6K0x3XO3WGKO7hYVvxsd5XHm71Qll+Z5dnIhJQ9jQcAnGdl+XCwXzhK4/ghaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519528; c=relaxed/simple;
	bh=iBxpNrpTuMWZJLfiDp+D0sl2qfcc0qCk/mX2MFWvx6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCzY75e7+/XhyTFxy92NhYt6ehmc2SVrTdVuK8OF2uIw7+4duQ3eR0gusKjgYGDWgDkKmtsySRaNFw+FEzr552lXRy+BlA94L4h0mM4sNdWZfI0Q/tfEgMqvigMlPAndbz5Cpz1s+KCEl6UgikWop15G7BozQkSAJbwqjoZejMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I02H+GuB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gf4q4fsm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DGGCOrq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8mmxFI4U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFFEE1FE96;
	Mon, 21 Oct 2024 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729519524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iumdc9GzfBLSjxDxVgC4VAJ+pgUtRj6C8TrZBfjHr78=;
	b=I02H+GuB24tqTskS4l03YOcCqqepsPp4Kke62/P7mx10DvLmA6cuHFSz//XswDoPXprz/6
	0Wm3FUBzd0+geMW8dQiEWuNoh0kSBmbxtKCcR2ypz7GOKKso48GnoRcFJG3GveEBWDuuAw
	+uBtUc0SGNomc4qQE6FLnH2BkZpw+ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729519524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iumdc9GzfBLSjxDxVgC4VAJ+pgUtRj6C8TrZBfjHr78=;
	b=gf4q4fsmTD/ylfKbYSfIqcpRBIaIiW/cB906oVuD21+evZYku3v6741HDTOiFKUrRIKXi7
	pm1fNttvS/kD0pBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2DGGCOrq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8mmxFI4U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729519523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iumdc9GzfBLSjxDxVgC4VAJ+pgUtRj6C8TrZBfjHr78=;
	b=2DGGCOrqixC4MJHx+rSpnd5ATqGHtioOxTRr9aP5+RdxlNqtorsfL8x1/J0eMIsEEUwFvj
	VBkRQ5o8BcPKPLAKOK8xpwMNgs+U4x9guM8sF3rg3nvUc9nr1gS04gqSfNE9O+42Su/vM2
	ZEXLZLWl4dmnP2Vxtz8pGLOp/RYiQ/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729519523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iumdc9GzfBLSjxDxVgC4VAJ+pgUtRj6C8TrZBfjHr78=;
	b=8mmxFI4UNkKSRI7ghuo9S+NsldjttwmckOMQ+lBjU3B9VAPutM0Bf/aMjLunPMTtsTY6XR
	oRqZAk03mJVj/eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1FC9139E0;
	Mon, 21 Oct 2024 14:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFg2K6NfFmdxTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 14:05:23 +0000
Date: Mon, 21 Oct 2024 16:05:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
Message-ID: <20241021140518.GD17835@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728608421.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CFFEE1FE96
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Oct 11, 2024 at 10:49:15AM +0800, Anand Jain wrote:
> v2:
> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
> 2. Correct the typo from %est_wait to %best_wait.
> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
> 4. Implement rotation with a minimum contiguous read threshold before
>    switching to the next stripe. Configure this, using:
> 
>         echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
> 
>    The default value is the sector size, and the min_contiguous_read
>    value must be a multiple of the sector size.

I think it's safe to start with the round-round robin policy, but the
syntax is strange, why the [ ] are mandatory? Also please call it
round-robin, or 'rr' for short.

The default of sector size is IMHO a wrong value, switching devices so
often will drop the performance just because of the io request overhead.
From what I rememer values around 200k were reasonable, so either 192k
or 256k should be the default. We may also drop the configurable value
at all and provide a few hard coded sizes like rr-256k, rr-512k, rr-1m,
if not only to drop parsing of user strings.

> 5. Tested FIO random read/write and defrag compression workloads with
>    min_contiguous_read set to sector size, 192k, and 256k.
> 
>    RAID1 balancing method rotation is better for multi-process workloads
>    such as fio and also single-process workload such as defragmentation.
> 
>      $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
>         --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>         --time_based --group_reporting --name=iops-test-job --eta-newline=1
> 
> 
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> | rotation|            |            |        |        |
> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
> 
>    rotation RAID1 balancing technique performs more than 2x better for
>    single-process defrag.
> 
>       $ time -p btrfs filesystem defrag -r -f -c /btrfs
> 
> 
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 18.00s| 3800   | 0      |
> | rotation|       |        |        |
> |     4096|  8.95s| 1900   | 1901   |
> |   196608|  8.50s| 1881   | 1919   |
> |   262144|  8.80s| 1881   | 1919   |
> | latency | 17.18s| 3800   | 0      |
> | devid:2 | 17.48s| 0      | 3800   |
> 
> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method is preferable as default. More workload testing is
> needed while the code is EXPERIMENTAL.

Yeah round-robin will be a good defalt, we only need to verify the chunk
size and then do the switch in the next release.

> While Latency is better during the failing/unstable block layer transport.
> As of now these two techniques, are needed to be further independently
> tested with different worloads, and in the long term we should be merge
> these technique to a unified heuristic.

This sounds like he latency is good for a specific case and maybe a
fallback if the device becomes faulty, but once the layer below becomes
unstable we may need to skip reading from the device. This is also a
different mode of operation than balancing reads.

> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method should be the default. More workload testing is needed
> while the code is EXPERIMENTAL.
> 
> Latency is smarter with unstable block layer transport.
> 
> Both techniques need independent testing across workloads, with the goal of
> eventually merging them into a unified approach? for the long term.
> 
> Devid is a hands-on approach, provides manual or user-space script control.
> 
> These RAID1 balancing methods are tunable via the sysfs knob.
> The mount -o option and btrfs properties are under consideration.

To move forward with the feature I think the round robin and preferred
device id can be merged. I'm not sure about the latency but if it's
under experimental we can take it as is and tune later.

I'll check my notes from the last time Michal attempted to implement the
policies if we haven't missed something.

