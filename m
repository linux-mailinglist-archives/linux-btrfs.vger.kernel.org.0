Return-Path: <linux-btrfs+bounces-20250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABED04E32
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 18:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D93DE3095245
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3917555;
	Thu,  8 Jan 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NlryMuYV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pa6xmgLh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nwZKSISY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FImHPehG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789D23EA81
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891613; cv=none; b=egEF/DbAKbvU0F3CRAG4Y8zADwzvbfuTVxFY4ZGo7NpjwvnK7/r83OxbEnkA8ijtobKDvbQgXLWF0mlPeo/tQAFJZ3vl8DBp2nvR48sPh5HBbYN32rhZTWuCkU1YZrJgOgZhwmrk8aShKCGV0emSC1WJuNLXvMhw+wOLhgg/SkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891613; c=relaxed/simple;
	bh=O/DnqI4Snq3mbV2dK2wEJzD7VacazdRTZS6YqkwyHQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4FXTtv3gipCP/J5HykRo1/i5RAWYdCpjtFIywSKo//3NFxkm8Tso9LSql2qZMzDSb4iXZH0K2edeaJ/+3SWi3mJKYI6f4qB9hVQ9qvmnxZrDXX04c6xzi5XEUaOIQUZ7+MU5Z/8tuzROEVUCly+iHUxR4GP22BJ7THF/clR4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NlryMuYV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pa6xmgLh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nwZKSISY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FImHPehG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E9A234629;
	Thu,  8 Jan 2026 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767891609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWezgdliCsdr6VfXDrjRziLkOtpC/GHYf+CQ6ZhRz1Q=;
	b=NlryMuYVcR/2W09rqT88Rg8RXpcQ6lhlbm0Mz4j4SWTuEHIOXpMS56hOfbzWFCpxTWrc2q
	zDeQlbh7xFmIBnzYWffMPDqx623HAxrE6EwUpGMCUk3MA1GzVCccD8QydwWKR5tccAMStH
	JTdAyyuzrthY87u4z131hxi1hn3iAp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767891609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWezgdliCsdr6VfXDrjRziLkOtpC/GHYf+CQ6ZhRz1Q=;
	b=Pa6xmgLhf4TmLFmnervLR55HGA9yEYfUYwPmIokvFs0ZHH/pJUF4QcBzPIGhVbVqL+kYmu
	rk0HDJm8yat4JlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767891608;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWezgdliCsdr6VfXDrjRziLkOtpC/GHYf+CQ6ZhRz1Q=;
	b=nwZKSISYm6Gp+12cC3+BLa4UjsNOdTp0U81zkSrPc3mBSZwWbmTrEH+J0TdVQD2kts87jj
	kepxhIM+Hj+GdepZKoiqtt9Sc393oehGDZUUh3c74K0KC5peYd44vQKhVlkb0Q4oKw/1+z
	1AEfMJjufzRe1KaLHMdo4Sf4KT8Hc4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767891608;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWezgdliCsdr6VfXDrjRziLkOtpC/GHYf+CQ6ZhRz1Q=;
	b=FImHPehGCfOet90tjEmobwp1+YkQe/Zm0Oknmg76XMmyCUkt6p8zmf9XVzmKlLbp6W9zra
	MVQsGABVxBoCBkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 378C53EA63;
	Thu,  8 Jan 2026 17:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mN9mDZjiX2n/WwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 17:00:08 +0000
Date: Thu, 8 Jan 2026 18:00:07 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: simplify async csum synchronization
Message-ID: <20260108170007.GG21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251113101731.2624000-1-neelx@suse.com>
 <20251118120716.GT13846@twin.jikos.cz>
 <20251124180904.GR13846@twin.jikos.cz>
 <CAPjX3FftzNN1PZd+UbJU7WVCCX+J8hqktP20fwOFJ=OYx1-eMA@mail.gmail.com>
 <20260108143529.GF21071@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108143529.GF21071@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Spam-Level: 

On Thu, Jan 08, 2026 at 03:35:29PM +0100, David Sterba wrote:
> On Wed, Jan 07, 2026 at 06:00:37PM +0100, Daniel Vacek wrote:
> > On Mon, 24 Nov 2025 at 19:09, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Tue, Nov 18, 2025 at 01:07:16PM +0100, David Sterba wrote:
> > > > On Thu, Nov 13, 2025 at 11:17:30AM +0100, Daniel Vacek wrote:
> > > > > We don't need the redundant completion csum_done which marks the
> > > > > csum work has been executed. We can simply flush_work() instead.
> > > > >
> > > > > This way we can slim down the btrfs_bio structure by 32 bytes matching
> > > > > it's size to what it used to be before introducing the async csums.
> > > > > Hence not making any change with respect to the structure size.
> > > > > ---
> > > > > This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> > > > > for-next and can be squashed into it.
> > > > >
> > > > > v2: metadata is not checksummed here so use the endio_workers workqueue
> > > > >     unconditionally. Thanks to Qu Wenruo.
> > > >
> > > > This looks quite useful regarding the size reduction of btrfs_bio,
> > > > please fold it to the patch. Thanks.
> > >
> > > The 6.19 branch is now frozen so this patch will be applied separately
> > > later.
> > 
> > Gentle ping. It seems this one has not been picked yet.
> 
> Now added to for-next, thanks.

Oh I remember now why it was not in for next, it causes a hang in
btrfs/292:

btrfs/292           [02:41:30][23561.047371] run fstests btrfs/292 at 2026-01-08 02:41:30
[23566.923172] BTRFS: device fsid 31dcd19d-04b6-405d-bb2b-65a61130b933 devid 1 transid 8 /dev/vdb (254:16) scanned by mkfs.btrfs (20472)
[23566.926055] BTRFS: device fsid 31dcd19d-04b6-405d-bb2b-65a61130b933 devid 2 transid 8 /dev/vdc (254:32) scanned by mkfs.btrfs (20472)
[23566.929018] BTRFS: device fsid 31dcd19d-04b6-405d-bb2b-65a61130b933 devid 3 transid 8 /dev/vdd (254:48) scanned by mkfs.btrfs (20472)
[23566.932433] BTRFS: device fsid 31dcd19d-04b6-405d-bb2b-65a61130b933 devid 4 transid 8 /dev/vde (254:64) scanned by mkfs.btrfs (20472)
[23566.935356] BTRFS: device fsid 31dcd19d-04b6-405d-bb2b-65a61130b933 devid 5 transid 8 /dev/vdf (254:80) scanned by mkfs.btrfs (20472)
[23566.949556] BTRFS: device fsid 31dcd19d-04b6-405d-bb2b-65a61130b933 devid 6 transid 8 /dev/vdg (254:96) scanned by mkfs.btrfs (20472)
[23567.006925] BTRFS info (device vdb): first mount of filesystem 31dcd19d-04b6-405d-bb2b-65a61130b933
[23567.008778] BTRFS info (device vdb): using crc32c checksum algorithm
[23567.084280] BTRFS info (device vdb): checking UUID tree
[23567.087799] BTRFS info (device vdb): enabling free space tree
[24581.533869] INFO: task kworker/u16:5:19550 blocked for more than 491 seconds.
[24581.536951]       Not tainted 6.19.0-rc4-default+ #2633
[24581.539079] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[24581.542294] task:kworker/u16:5   state:D stack:22528 pid:19550 tgid:19550 ppid:2      task_flags:0x4208060 flags:0x00080000
[24581.546803] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[24581.549747] Call Trace:
[24581.550884]  <TASK>
[24581.551928]  __schedule+0x726/0xe50
[24581.553498]  ? io_schedule_timeout+0xb0/0xb0
[24581.555332]  ? crc32c+0x130/0x180
[24581.556802]  ? rcu_is_watching+0x1c/0x40
[24581.558507]  ? lock_acquire+0x8a/0x110
[24581.560034]  ? schedule+0x91/0x130
[24581.561236]  ? __wait_for_common+0x228/0x330
[24581.562710]  schedule+0x60/0x130
[24581.563872]  schedule_timeout+0x18f/0x210
[24581.565217]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.566868]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[24581.569384]  ? lock_acquire+0x8a/0x110
[24581.570693]  ? __wait_for_common+0x99/0x330
[24581.572100]  ? rcu_is_watching+0x1c/0x40
[24581.573395]  __wait_for_common+0x260/0x330
[24581.574786]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.576378]  ? bit_wait_timeout+0xc0/0xc0
[24581.577735]  ? start_flush_work+0x3f9/0x6e0
[24581.579132]  ? start_flush_work+0x403/0x6e0
[24581.580468]  __flush_work+0x122/0x190
[24581.581623]  ? start_flush_work+0x6e0/0x6e0
[24581.582921]  ? csum_one_bio+0x309/0x390 [btrfs]
[24581.584736]  ? flush_workqueue_prep_pwqs+0x280/0x280
[24581.586122]  ? __might_resched+0x16a/0x250
[24581.587284]  ? rcu_read_unlock+0x80/0x80
[24581.588403]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[24581.590083]  process_one_work+0x4e6/0xa00
[24581.591142]  ? pwq_dec_nr_in_flight+0x260/0x260
[24581.592305]  ? __list_add_valid_or_report+0x3b/0xb0
[24581.593481]  worker_thread+0x3b7/0x6b0
[24581.594448]  ? __kthread_parkme+0x108/0x130
[24581.595491]  ? process_one_work+0xa00/0xa00
[24581.596495]  kthread+0x221/0x3c0
[24581.597278]  ? kthread+0x128/0x3c0
[24581.598131]  ? trace_hardirqs_on+0x12/0xf0
[24581.599087]  ? kthread_is_per_cpu+0x60/0x60
[24581.600078]  ? lock_acquire+0x8a/0x110
[24581.600921]  ? calculate_sigpending+0x2a/0x60
[24581.601888]  ? kthread_is_per_cpu+0x60/0x60
[24581.602803]  ret_from_fork+0x280/0x2f0
[24581.603646]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[24581.604819]  ? __switch_to+0x298/0x6f0
[24581.605631]  ? kthread_is_per_cpu+0x60/0x60
[24581.606530]  ret_from_fork_asm+0x11/0x20
[24581.607369]  </TASK>
[24581.607946] INFO: task kworker/u16:16:3517 blocked for more than 491 seconds.
[24581.609276]       Not tainted 6.19.0-rc4-default+ #2633
[24581.610322] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[24581.611832] task:kworker/u16:16  state:D stack:21432 pid:3517  tgid:3517  ppid:2      task_flags:0x4208060 flags:0x00080000
[24581.613813] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[24581.615165] Call Trace:
[24581.615706]  <TASK>
[24581.616200]  __schedule+0x726/0xe50
[24581.616913]  ? io_schedule_timeout+0xb0/0xb0
[24581.617745]  ? stack_depot_save_flags+0x3b/0x670
[24581.618615]  ? rcu_is_watching+0x1c/0x40
[24581.619390]  ? lock_acquire+0x8a/0x110
[24581.620121]  ? schedule+0x91/0x130
[24581.620807]  ? __wait_for_common+0x228/0x330
[24581.621627]  schedule+0x60/0x130
[24581.622283]  schedule_timeout+0x18f/0x210
[24581.623061]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.623988]  ? lock_acquire+0x8a/0x110
[24581.624707]  ? __wait_for_common+0x99/0x330
[24581.625498]  ? rcu_is_watching+0x1c/0x40
[24581.626273]  __wait_for_common+0x260/0x330
[24581.627063]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.627989]  ? bit_wait_timeout+0xc0/0xc0
[24581.628774]  ? start_flush_work+0x3f9/0x6e0
[24581.629591]  ? start_flush_work+0x403/0x6e0
[24581.630408]  __flush_work+0x122/0x190
[24581.631129]  ? start_flush_work+0x6e0/0x6e0
[24581.631934]  ? __call_rcu_common.constprop.0+0x269/0x450
[24581.632902]  ? flush_workqueue_prep_pwqs+0x280/0x280
[24581.633836]  ? __might_resched+0x16a/0x250
[24581.634628]  ? rcu_read_unlock+0x80/0x80
[24581.635368]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[24581.636565]  process_one_work+0x4e6/0xa00
[24581.637355]  ? pwq_dec_nr_in_flight+0x260/0x260
[24581.638208]  ? __list_add_valid_or_report+0x3b/0xb0
[24581.639102]  worker_thread+0x3b7/0x6b0
[24581.639847]  ? __kthread_parkme+0x108/0x130
[24581.640628]  ? process_one_work+0xa00/0xa00
[24581.641405]  kthread+0x221/0x3c0
[24581.642052]  ? kthread+0x128/0x3c0
[24581.642731]  ? trace_hardirqs_on+0x12/0xf0
[24581.643521]  ? kthread_is_per_cpu+0x60/0x60
[24581.644304]  ? lock_acquire+0x8a/0x110
[24581.645020]  ? calculate_sigpending+0x2a/0x60
[24581.645856]  ? kthread_is_per_cpu+0x60/0x60
[24581.646637]  ret_from_fork+0x280/0x2f0
[24581.647354]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[24581.648396]  ? __switch_to+0x298/0x6f0
[24581.649122]  ? kthread_is_per_cpu+0x60/0x60
[24581.649941]  ret_from_fork_asm+0x11/0x20
[24581.650686]  </TASK>
[24581.651178] INFO: task kworker/u16:20:18839 blocked for more than 491 seconds.
[24581.652485]       Not tainted 6.19.0-rc4-default+ #2633
[24581.653435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[24581.654863] task:kworker/u16:20  state:D stack:23112 pid:18839 tgid:18839 ppid:2      task_flags:0x4208060 flags:0x00080000
[24581.656770] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[24581.658127] Call Trace:
[24581.658653]  <TASK>
[24581.659126]  __schedule+0x726/0xe50
[24581.659833]  ? io_schedule_timeout+0xb0/0xb0
[24581.660637]  ? stack_depot_save_flags+0x3b/0x670
[24581.661473]  ? rcu_is_watching+0x1c/0x40
[24581.662217]  ? lock_acquire+0x8a/0x110
[24581.662924]  ? schedule+0x91/0x130
[24581.663603]  ? __wait_for_common+0x228/0x330
[24581.664406]  schedule+0x60/0x130
[24581.665050]  schedule_timeout+0x18f/0x210
[24581.665820]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.666713]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[24581.668090]  ? lock_acquire+0x8a/0x110
[24581.671807]  ? __wait_for_common+0x99/0x330
[24581.672590]  ? rcu_is_watching+0x1c/0x40
[24581.673321]  __wait_for_common+0x260/0x330
[24581.674096]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.674977]  ? bit_wait_timeout+0xc0/0xc0
[24581.675757]  ? start_flush_work+0x3f9/0x6e0
[24581.676512]  ? start_flush_work+0x403/0x6e0
[24581.677293]  __flush_work+0x122/0x190
[24581.678010]  ? start_flush_work+0x6e0/0x6e0
[24581.678788]  ? csum_one_bio+0x309/0x390 [btrfs]
[24581.679937]  ? flush_workqueue_prep_pwqs+0x280/0x280
[24581.680828]  ? __might_resched+0x16a/0x250
[24581.681591]  ? rcu_read_unlock+0x80/0x80
[24581.682344]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[24581.683497]  process_one_work+0x4e6/0xa00
[24581.684244]  ? pwq_dec_nr_in_flight+0x260/0x260
[24581.685061]  ? __list_add_valid_or_report+0x3b/0xb0
[24581.685949]  worker_thread+0x3b7/0x6b0
[24581.686647]  ? __kthread_parkme+0x108/0x130
[24581.687406]  ? process_one_work+0xa00/0xa00
[24581.688192]  kthread+0x221/0x3c0
[24581.688832]  ? kthread+0x128/0x3c0
[24581.689484]  ? trace_hardirqs_on+0x12/0xf0
[24581.690247]  ? kthread_is_per_cpu+0x60/0x60
[24581.691018]  ? lock_acquire+0x8a/0x110
[24581.691727]  ? calculate_sigpending+0x2a/0x60
[24581.692530]  ? kthread_is_per_cpu+0x60/0x60
[24581.693311]  ret_from_fork+0x280/0x2f0
[24581.694040]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[24581.695059]  ? __switch_to+0x298/0x6f0
[24581.695786]  ? kthread_is_per_cpu+0x60/0x60
[24581.696551]  ret_from_fork_asm+0x11/0x20
[24581.697284]  </TASK>
[24581.697766] INFO: task kworker/u16:17:27479 blocked for more than 491 seconds.
[24581.699051]       Not tainted 6.19.0-rc4-default+ #2633
[24581.699967] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[24581.701311] task:kworker/u16:17  state:D stack:23112 pid:27479 tgid:27479 ppid:2      task_flags:0x4208060 flags:0x00080000
[24581.703208] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[24581.704519] Call Trace:
[24581.705029]  <TASK>
[24581.705495]  __schedule+0x726/0xe50
[24581.706188]  ? io_schedule_timeout+0xb0/0xb0
[24581.706967]  ? rcu_is_watching+0x1c/0x40
[24581.707699]  ? lock_acquire+0x8a/0x110
[24581.708414]  ? schedule+0x91/0x130
[24581.709062]  ? __wait_for_common+0x228/0x330
[24581.709871]  schedule+0x60/0x130
[24581.710506]  schedule_timeout+0x18f/0x210
[24581.711258]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.712164]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[24581.713525]  ? lock_acquire+0x8a/0x110
[24581.714249]  ? __wait_for_common+0x99/0x330
[24581.715022]  ? rcu_is_watching+0x1c/0x40
[24581.715771]  __wait_for_common+0x260/0x330
[24581.716519]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.717400]  ? bit_wait_timeout+0xc0/0xc0
[24581.718163]  ? start_flush_work+0x3f9/0x6e0
[24581.718947]  ? start_flush_work+0x403/0x6e0
[24581.719742]  __flush_work+0x122/0x190
[24581.720448]  ? start_flush_work+0x6e0/0x6e0
[24581.721212]  ? csum_one_bio+0x309/0x390 [btrfs]
[24581.722332]  ? flush_workqueue_prep_pwqs+0x280/0x280
[24581.723223]  ? __might_resched+0x16a/0x250
[24581.723994]  ? rcu_read_unlock+0x80/0x80
[24581.724727]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[24581.725892]  process_one_work+0x4e6/0xa00
[24581.726648]  ? pwq_dec_nr_in_flight+0x260/0x260
[24581.727486]  ? __list_add_valid_or_report+0x3b/0xb0
[24581.728372]  worker_thread+0x3b7/0x6b0
[24581.729078]  ? __kthread_parkme+0x108/0x130
[24581.729873]  ? process_one_work+0xa00/0xa00
[24581.730640]  kthread+0x221/0x3c0
[24581.731275]  ? kthread+0x128/0x3c0
[24581.731947]  ? trace_hardirqs_on+0x12/0xf0
[24581.732703]  ? kthread_is_per_cpu+0x60/0x60
[24581.733477]  ? lock_acquire+0x8a/0x110
[24581.734192]  ? calculate_sigpending+0x2a/0x60
[24581.735002]  ? kthread_is_per_cpu+0x60/0x60
[24581.735800]  ret_from_fork+0x280/0x2f0
[24581.736502]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[24581.737505]  ? __switch_to+0x298/0x6f0
[24581.738225]  ? kthread_is_per_cpu+0x60/0x60
[24581.739011]  ret_from_fork_asm+0x11/0x20
[24581.739762]  </TASK>
[24581.740233] INFO: task kworker/u16:7:15420 blocked for more than 491 seconds.
[24581.741436]       Not tainted 6.19.0-rc4-default+ #2633
[24581.742377] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[24581.743750] task:kworker/u16:7   state:D stack:23976 pid:15420 tgid:15420 ppid:2      task_flags:0x4208060 flags:0x00080000
[24581.745622] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[24581.746955] Call Trace:
[24581.747485]  <TASK>
[24581.747959]  __schedule+0x726/0xe50
[24581.748641]  ? io_schedule_timeout+0xb0/0xb0
[24581.749422]  ? stack_depot_save_flags+0x3b/0x670
[24581.750267]  ? rcu_is_watching+0x1c/0x40
[24581.751002]  ? lock_acquire+0x8a/0x110
[24581.751743]  ? schedule+0x91/0x130
[24581.752411]  ? __wait_for_common+0x228/0x330
[24581.753194]  schedule+0x60/0x130
[24581.753850]  schedule_timeout+0x18f/0x210
[24581.754604]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.755491]  ? lock_acquire+0x8a/0x110
[24581.756191]  ? __wait_for_common+0x99/0x330
[24581.756969]  ? rcu_is_watching+0x1c/0x40
[24581.757710]  __wait_for_common+0x260/0x330
[24581.758494]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.759384]  ? bit_wait_timeout+0xc0/0xc0
[24581.760136]  ? start_flush_work+0x3f9/0x6e0
[24581.760900]  ? start_flush_work+0x403/0x6e0
[24581.761659]  __flush_work+0x122/0x190
[24581.762382]  ? start_flush_work+0x6e0/0x6e0
[24581.763152]  ? __call_rcu_common.constprop.0+0x269/0x450
[24581.764084]  ? flush_workqueue_prep_pwqs+0x280/0x280
[24581.764976]  ? __might_resched+0x16a/0x250
[24581.765749]  ? rcu_read_unlock+0x80/0x80
[24581.766486]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[24581.767640]  process_one_work+0x4e6/0xa00
[24581.768389]  ? pwq_dec_nr_in_flight+0x260/0x260
[24581.769214]  ? do_raw_spin_lock+0x10b/0x1a0
[24581.770007]  ? __list_add_valid_or_report+0x3b/0xb0
[24581.770881]  worker_thread+0x3b7/0x6b0
[24581.771601]  ? __kthread_parkme+0x108/0x130
[24581.772379]  ? process_one_work+0xa00/0xa00
[24581.773139]  kthread+0x221/0x3c0
[24581.773789]  ? kthread+0x128/0x3c0
[24581.774455]  ? trace_hardirqs_on+0x12/0xf0
[24581.775208]  ? kthread_is_per_cpu+0x60/0x60
[24581.775985]  ? lock_acquire+0x8a/0x110
[24581.776691]  ? calculate_sigpending+0x2a/0x60
[24581.777492]  ? kthread_is_per_cpu+0x60/0x60
[24581.778278]  ret_from_fork+0x280/0x2f0
[24581.778981]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[24581.780002]  ? __switch_to+0x298/0x6f0
[24581.780708]  ? kthread_is_per_cpu+0x60/0x60
[24581.781482]  ret_from_fork_asm+0x11/0x20
[24581.782243]  </TASK>
[24581.782730] INFO: task kworker/u16:14:15426 blocked for more than 491 seconds.
[24581.784032]       Not tainted 6.19.0-rc4-default+ #2633
[24581.784949] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[24581.786327] task:kworker/u16:14  state:D stack:24120 pid:15426 tgid:15426 ppid:2      task_flags:0x4208060 flags:0x00080000
[24581.788188] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[24581.789492] Call Trace:
[24581.790025]  <TASK>
[24581.790491]  __schedule+0x726/0xe50
[24581.791164]  ? io_schedule_timeout+0xb0/0xb0
[24581.791976]  ? btrfs_work_helper+0x137/0x3e0 [btrfs]
[24581.793159]  ? worker_thread+0x3b7/0x6b0
[24581.793899]  ? kthread+0x221/0x3c0
[24581.794567]  ? ret_from_fork+0x280/0x2f0
[24581.795297]  ? rcu_is_watching+0x1c/0x40
[24581.796040]  ? lock_acquire+0x8a/0x110
[24581.796735]  ? schedule+0x91/0x130
[24581.797389]  ? __wait_for_common+0x228/0x330
[24581.798185]  schedule+0x60/0x130
[24581.798826]  schedule_timeout+0x18f/0x210
[24581.799586]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.800477]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[24581.801867]  ? lock_acquire+0x8a/0x110
[24581.802575]  ? __wait_for_common+0x99/0x330
[24581.803344]  ? rcu_is_watching+0x1c/0x40
[24581.804153]  __wait_for_common+0x260/0x330
[24581.804922]  ? hrtimer_nanosleep_restart+0x240/0x240
[24581.805831]  ? bit_wait_timeout+0xc0/0xc0
[24581.806595]  ? start_flush_work+0x3f9/0x6e0
[24581.807374]  ? start_flush_work+0x403/0x6e0
[24581.808153]  __flush_work+0x122/0x190
[24581.808849]  ? start_flush_work+0x6e0/0x6e0
[24581.809620]  ? csum_one_bio+0x309/0x390 [btrfs]
[24581.810754]  ? flush_workqueue_prep_pwqs+0x280/0x280
[24581.811660]  ? __might_resched+0x16a/0x250
[24581.812422]  ? rcu_read_unlock+0x80/0x80
[24581.813161]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[24581.817285]  process_one_work+0x4e6/0xa00
[24581.818067]  ? pwq_dec_nr_in_flight+0x260/0x260
[24581.818897]  ? __list_add_valid_or_report+0x3b/0xb0
[24581.819791]  worker_thread+0x3b7/0x6b0
[24581.820508]  ? __kthread_parkme+0x108/0x130
[24581.821278]  ? process_one_work+0xa00/0xa00
[24581.822074]  kthread+0x221/0x3c0
[24581.822723]  ? kthread+0x128/0x3c0
[24581.823382]  ? trace_hardirqs_on+0x12/0xf0
[24581.824150]  ? kthread_is_per_cpu+0x60/0x60
[24581.824929]  ? lock_acquire+0x8a/0x110
[24581.825647]  ? calculate_sigpending+0x2a/0x60
[24581.826466]  ? kthread_is_per_cpu+0x60/0x60
[24581.827247]  ret_from_fork+0x280/0x2f0
[24581.827970]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[24581.828987]  ? __switch_to+0x298/0x6f0
[24581.829704]  ? kthread_is_per_cpu+0x60/0x60
[24581.830483]  ret_from_fork_asm+0x11/0x20
[24581.831234]  </TASK>
[24581.831732] INFO: lockdep is turned off.
[25073.053815] INFO: task kworker/u16:5:19550 blocked for more than 983 seconds.
[25073.056167]       Not tainted 6.19.0-rc4-default+ #2633
[25073.057930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[25073.060416] task:kworker/u16:5   state:D stack:22528 pid:19550 tgid:19550 ppid:2      task_flags:0x4208060 flags:0x00080000
[25073.063901] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[25073.066324] Call Trace:
[25073.067271]  <TASK>
[25073.068097]  __schedule+0x726/0xe50
[25073.069340]  ? io_schedule_timeout+0xb0/0xb0
[25073.070794]  ? crc32c+0x130/0x180
[25073.071962]  ? rcu_is_watching+0x1c/0x40
[25073.073296]  ? lock_acquire+0x8a/0x110
[25073.074597]  ? schedule+0x91/0x130
[25073.075782]  ? __wait_for_common+0x228/0x330
[25073.077226]  schedule+0x60/0x130
[25073.078427]  schedule_timeout+0x18f/0x210
[25073.079791]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.081412]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[25073.083915]  ? lock_acquire+0x8a/0x110
[25073.085212]  ? __wait_for_common+0x99/0x330
[25073.086636]  ? rcu_is_watching+0x1c/0x40
[25073.087987]  __wait_for_common+0x260/0x330
[25073.089367]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.091031]  ? bit_wait_timeout+0xc0/0xc0
[25073.092386]  ? start_flush_work+0x3f9/0x6e0
[25073.093804]  ? start_flush_work+0x403/0x6e0
[25073.095219]  __flush_work+0x122/0x190
[25073.096510]  ? start_flush_work+0x6e0/0x6e0
[25073.097867]  ? csum_one_bio+0x309/0x390 [btrfs]
[25073.099708]  ? flush_workqueue_prep_pwqs+0x280/0x280
[25073.101193]  ? __might_resched+0x16a/0x250
[25073.102398]  ? rcu_read_unlock+0x80/0x80
[25073.103530]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[25073.105281]  process_one_work+0x4e6/0xa00
[25073.106394]  ? pwq_dec_nr_in_flight+0x260/0x260
[25073.107617]  ? __list_add_valid_or_report+0x3b/0xb0
[25073.108876]  worker_thread+0x3b7/0x6b0
[25073.109854]  ? __kthread_parkme+0x108/0x130
[25073.110902]  ? process_one_work+0xa00/0xa00
[25073.111931]  kthread+0x221/0x3c0
[25073.112780]  ? kthread+0x128/0x3c0
[25073.113623]  ? trace_hardirqs_on+0x12/0xf0
[25073.114602]  ? kthread_is_per_cpu+0x60/0x60
[25073.115569]  ? lock_acquire+0x8a/0x110
[25073.116461]  ? calculate_sigpending+0x2a/0x60
[25073.117485]  ? kthread_is_per_cpu+0x60/0x60
[25073.118420]  ret_from_fork+0x280/0x2f0
[25073.119256]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[25073.120481]  ? __switch_to+0x298/0x6f0
[25073.121311]  ? kthread_is_per_cpu+0x60/0x60
[25073.122212]  ret_from_fork_asm+0x11/0x20
[25073.123056]  </TASK>
[25073.123597] INFO: task kworker/u16:16:3517 blocked for more than 983 seconds.
[25073.124997]       Not tainted 6.19.0-rc4-default+ #2633
[25073.126044] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[25073.127585] task:kworker/u16:16  state:D stack:21432 pid:3517  tgid:3517  ppid:2      task_flags:0x4208060 flags:0x00080000
[25073.129626] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[25073.131008] Call Trace:
[25073.131546]  <TASK>
[25073.132041]  __schedule+0x726/0xe50
[25073.132775]  ? io_schedule_timeout+0xb0/0xb0
[25073.133590]  ? stack_depot_save_flags+0x3b/0x670
[25073.134478]  ? rcu_is_watching+0x1c/0x40
[25073.135261]  ? lock_acquire+0x8a/0x110
[25073.136009]  ? schedule+0x91/0x130
[25073.136709]  ? __wait_for_common+0x228/0x330
[25073.137559]  schedule+0x60/0x130
[25073.138236]  schedule_timeout+0x18f/0x210
[25073.139015]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.139921]  ? lock_acquire+0x8a/0x110
[25073.140658]  ? __wait_for_common+0x99/0x330
[25073.141467]  ? rcu_is_watching+0x1c/0x40
[25073.142242]  __wait_for_common+0x260/0x330
[25073.143034]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.143965]  ? bit_wait_timeout+0xc0/0xc0
[25073.144759]  ? start_flush_work+0x3f9/0x6e0
[25073.145564]  ? start_flush_work+0x403/0x6e0
[25073.146381]  __flush_work+0x122/0x190
[25073.147120]  ? start_flush_work+0x6e0/0x6e0
[25073.147926]  ? __call_rcu_common.constprop.0+0x269/0x450
[25073.148895]  ? flush_workqueue_prep_pwqs+0x280/0x280
[25073.149823]  ? __might_resched+0x16a/0x250
[25073.150632]  ? rcu_read_unlock+0x80/0x80
[25073.151404]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[25073.152599]  process_one_work+0x4e6/0xa00
[25073.153368]  ? pwq_dec_nr_in_flight+0x260/0x260
[25073.154239]  ? __list_add_valid_or_report+0x3b/0xb0
[25073.155142]  worker_thread+0x3b7/0x6b0
[25073.155876]  ? __kthread_parkme+0x108/0x130
[25073.156667]  ? process_one_work+0xa00/0xa00
[25073.157467]  kthread+0x221/0x3c0
[25073.158163]  ? kthread+0x128/0x3c0
[25073.158839]  ? trace_hardirqs_on+0x12/0xf0
[25073.159622]  ? kthread_is_per_cpu+0x60/0x60
[25073.160403]  ? lock_acquire+0x8a/0x110
[25073.161129]  ? calculate_sigpending+0x2a/0x60
[25073.161960]  ? kthread_is_per_cpu+0x60/0x60
[25073.162769]  ret_from_fork+0x280/0x2f0
[25073.163490]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[25073.164535]  ? __switch_to+0x298/0x6f0
[25073.165252]  ? kthread_is_per_cpu+0x60/0x60
[25073.166054]  ret_from_fork_asm+0x11/0x20
[25073.166801]  </TASK>
[25073.167308] INFO: task kworker/u16:20:18839 blocked for more than 983 seconds.
[25073.168608]       Not tainted 6.19.0-rc4-default+ #2633
[25073.169548] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[25073.170949] task:kworker/u16:20  state:D stack:23112 pid:18839 tgid:18839 ppid:2      task_flags:0x4208060 flags:0x00080000
[25073.172880] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[25073.174213] Call Trace:
[25073.174735]  <TASK>
[25073.175215]  __schedule+0x726/0xe50
[25073.175900]  ? io_schedule_timeout+0xb0/0xb0
[25073.176710]  ? stack_depot_save_flags+0x3b/0x670
[25073.177577]  ? rcu_is_watching+0x1c/0x40
[25073.178334]  ? lock_acquire+0x8a/0x110
[25073.179041]  ? schedule+0x91/0x130
[25073.179703]  ? __wait_for_common+0x228/0x330
[25073.180508]  schedule+0x60/0x130
[25073.181159]  schedule_timeout+0x18f/0x210
[25073.181931]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.182839]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[25073.184209]  ? lock_acquire+0x8a/0x110
[25073.184928]  ? __wait_for_common+0x99/0x330
[25073.185713]  ? rcu_is_watching+0x1c/0x40
[25073.186460]  __wait_for_common+0x260/0x330
[25073.187223]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.188143]  ? bit_wait_timeout+0xc0/0xc0
[25073.188900]  ? start_flush_work+0x3f9/0x6e0
[25073.189715]  ? start_flush_work+0x403/0x6e0
[25073.190494]  __flush_work+0x122/0x190
[25073.191212]  ? start_flush_work+0x6e0/0x6e0
[25073.192006]  ? csum_one_bio+0x309/0x390 [btrfs]
[25073.193134]  ? flush_workqueue_prep_pwqs+0x280/0x280
[25073.194052]  ? __might_resched+0x16a/0x250
[25073.194806]  ? rcu_read_unlock+0x80/0x80
[25073.195537]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[25073.196698]  process_one_work+0x4e6/0xa00
[25073.197449]  ? pwq_dec_nr_in_flight+0x260/0x260
[25073.198283]  ? __list_add_valid_or_report+0x3b/0xb0
[25073.199194]  worker_thread+0x3b7/0x6b0
[25073.199918]  ? __kthread_parkme+0x108/0x130
[25073.200694]  ? process_one_work+0xa00/0xa00
[25073.201463]  kthread+0x221/0x3c0
[25073.202111]  ? kthread+0x128/0x3c0
[25073.202784]  ? trace_hardirqs_on+0x12/0xf0
[25073.203541]  ? kthread_is_per_cpu+0x60/0x60
[25073.204308]  ? lock_acquire+0x8a/0x110
[25073.205025]  ? calculate_sigpending+0x2a/0x60
[25073.205834]  ? kthread_is_per_cpu+0x60/0x60
[25073.206607]  ret_from_fork+0x280/0x2f0
[25073.207330]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[25073.208342]  ? __switch_to+0x298/0x6f0
[25073.209067]  ? kthread_is_per_cpu+0x60/0x60
[25073.212777]  ret_from_fork_asm+0x11/0x20
[25073.213526]  </TASK>
[25073.214018] INFO: task kworker/u16:17:27479 blocked for more than 983 seconds.
[25073.215308]       Not tainted 6.19.0-rc4-default+ #2633
[25073.216226] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[25073.217595] task:kworker/u16:17  state:D stack:23112 pid:27479 tgid:27479 ppid:2      task_flags:0x4208060 flags:0x00080000
[25073.219481] Workqueue: btrfs-endio simple_end_io_work [btrfs]
[25073.220790] Call Trace:
[25073.221303]  <TASK>
[25073.221790]  __schedule+0x726/0xe50
[25073.222465]  ? io_schedule_timeout+0xb0/0xb0
[25073.223253]  ? rcu_is_watching+0x1c/0x40
[25073.223981]  ? lock_acquire+0x8a/0x110
[25073.224700]  ? schedule+0x91/0x130
[25073.225351]  ? __wait_for_common+0x228/0x330
[25073.226167]  schedule+0x60/0x130
[25073.226804]  schedule_timeout+0x18f/0x210
[25073.227543]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.228420]  ? btrfs_calculate_block_csum_pages+0x17a/0x1d0 [btrfs]
[25073.229806]  ? lock_acquire+0x8a/0x110
[25073.230516]  ? __wait_for_common+0x99/0x330
[25073.231281]  ? rcu_is_watching+0x1c/0x40
[25073.232023]  __wait_for_common+0x260/0x330
[25073.232786]  ? hrtimer_nanosleep_restart+0x240/0x240
[25073.233699]  ? bit_wait_timeout+0xc0/0xc0
[25073.234452]  ? start_flush_work+0x3f9/0x6e0
[25073.235213]  ? start_flush_work+0x403/0x6e0
[25073.235982]  __flush_work+0x122/0x190
[25073.236694]  ? start_flush_work+0x6e0/0x6e0
[25073.237468]  ? csum_one_bio+0x309/0x390 [btrfs]
[25073.238591]  ? flush_workqueue_prep_pwqs+0x280/0x280
[25073.239497]  ? __might_resched+0x16a/0x250
[25073.240261]  ? rcu_read_unlock+0x80/0x80
[25073.241016]  btrfs_bio_end_io+0x139/0x1a0 [btrfs]
[25073.242202]  process_one_work+0x4e6/0xa00
[25073.242958]  ? pwq_dec_nr_in_flight+0x260/0x260
[25073.243802]  ? __list_add_valid_or_report+0x3b/0xb0
[25073.244690]  worker_thread+0x3b7/0x6b0
[25073.245396]  ? __kthread_parkme+0x108/0x130
[25073.246222]  ? process_one_work+0xa00/0xa00
[25073.247019]  kthread+0x221/0x3c0
[25073.247651]  ? kthread+0x128/0x3c0
[25073.248316]  ? trace_hardirqs_on+0x12/0xf0
[25073.249085]  ? kthread_is_per_cpu+0x60/0x60
[25073.249871]  ? lock_acquire+0x8a/0x110
[25073.250595]  ? calculate_sigpending+0x2a/0x60
[25073.251406]  ? kthread_is_per_cpu+0x60/0x60
[25073.252188]  ret_from_fork+0x280/0x2f0
[25073.252897]  ? arch_exit_to_user_mode_prepare.isra.0+0xb0/0xb0
[25073.253913]  ? __switch_to+0x298/0x6f0
[25073.254621]  ? kthread_is_per_cpu+0x60/0x60
[25073.255392]  ret_from_fork_asm+0x11/0x20
[25073.256124]  </TASK>
[25073.256602] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[25073.258051] INFO: lockdep is turned off.

