Return-Path: <linux-btrfs+bounces-7663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12B2964C7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFEF1C238D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371CA1B86FA;
	Thu, 29 Aug 2024 17:00:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD31B6528
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950801; cv=none; b=LMK41OLkEZEWmCwYd5kAfd24lZERbTbcAu7u4r0byI2A3o0qSuMip5H9KGL1oCTeEOUVcIblpGFIhwS5qBnds6b9Ruo/41Ziq8KgvUlUthkJNrAWD6ntZuWaZdyBSWrdoOCNl8HxfTbd2x9CMaRaNwzf5D91QPkn2BYkRTURDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950801; c=relaxed/simple;
	bh=1ewRQxwtETUvXusaJoq2xH4Ja2rQ8jiN7OUcYILEsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0V8kzF2nwWBISD5ElHZ1oF8CqurSYXz5ddX21LkTTQh+XPMz5x5TazNpTYrAsuzCaAr/+RqSsNgojIXjQWxHrW4qWyzQpj7hQF8q7KsLKCDF56PMSKgG16bNkjZlHGVg8L70/iNOMDO4Zzl6yPqG9QBR7b5901erx+xdmLNF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CA8B219AF;
	Thu, 29 Aug 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0347F139B0;
	Thu, 29 Aug 2024 16:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMhFAA6p0GaQBAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 16:59:57 +0000
Date: Thu, 29 Aug 2024 18:59:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Rolf Wentland <R.Wentland@gmx.de>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] btrfs: interrupt long running operations if the
 current process is freezing
Message-ID: <20240829165948.GM25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1CA8B219AF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Thu, Aug 29, 2024 at 09:26:17AM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that running fstrim will prevent the system from
> hibernation, result the following dmesg:
>  PM: suspend entry (deep)
>  Filesystems sync: 0.060 seconds
>  Freezing user space processes
>  Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
>  task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1      flags:0x00004006
>  Call Trace:
>   <TASK>
>   __schedule+0x381/0x1540
>   schedule+0x24/0xb0
>   schedule_timeout+0x1ea/0x2a0
>   io_schedule_timeout+0x19/0x50
>   wait_for_completion_io+0x78/0x140
>   submit_bio_wait+0xaa/0xc0
>   blkdev_issue_discard+0x65/0xb0
>   btrfs_issue_discard+0xcf/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_discard_extent+0x120/0x2a0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_trim_block_group+0xcb/0x130 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_trim_fs+0x119/0x460 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_ioctl+0x11cc/0x29f0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   __x64_sys_ioctl+0x92/0xd0
>   do_syscall_64+0x5b/0x80
>   entry_SYSCALL_64_after_hwframe+0x7c/0xe6
>  RIP: 0033:0x7f5f3b529f9b
>  RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
>  RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
>  RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>  R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
>   </TASK>
>  OOM killer enabled.
>  Restarting tasks ... done.
>  random: crng reseeded on system resumption
>  PM: suspend exit
>  PM: suspend entry (s2idle)
>  Filesystems sync: 0.047 seconds
> 
> [CAUSE]
> PM code is freezing all user space processes before entering
> hibernation/suspension, but if a user space process is trapping into the
> kernel for a long running operation, it will not be frozen since it's
> still inside kernel.
> 
> Normally those long running operations check for fatal signals and exit
> early, but freezing user space processes is not done by signals but a
> different infrastructure.
> 
> Unfortunately btrfs only checks fatal signals but not if the current
> task is being frozen.
> 
> [FIX]
> Introduce a helper, btrfs_task_interrupted(), to check both fatal signals
> and freezing status, and apply to all long running operations, with
> dedicated error code:
> 
> - reflink (-EINTR)
> - fstrim (-ERESTARTSYS)
> - relocation (-ECANCELD)
> - llseek (-EINTR)
> - defrag (-EAGAIN)
> - fiemap (-EINTR)

Is it correct to interrupt the operations? If there's a reflink in
progress and system gets hibernated what's the reason to cancel it? It
should be possible to just freeze the state and continue after thaw, no?

Imagine a case when a long running file copy (reflink) is going on and
the system gets frozen. This is wrong from user perspective.

