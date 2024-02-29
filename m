Return-Path: <linux-btrfs+bounces-2943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3386D3A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7521F20CE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032EF134411;
	Thu, 29 Feb 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPrjhSDI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhI1mksz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPrjhSDI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhI1mksz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D01350C9
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236018; cv=none; b=VktUyMwWj0RJZnqVt1Y1bP0u4ICbU7WabiaLnhnip95iWV6tuYQjFOkHjhBjSs0nl5jZLDkmXq5QkVJxM6Ao2UxMLa9UFZYiglnrqn5a/YwJoye77PO19N560GJT4+ueSZvShpfKpu8lldedaAAyQfLBdPD6lWCstZEOHf7KIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236018; c=relaxed/simple;
	bh=bVoNK9XO3G/GD7r1XnahbkDkCC1hggO4m1TjFdFjIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwL5V9lDBUbopWFfVx74uExlzBgrs+XL+kUunUrnUMYWj6CntZgLAM+Krt0k0epcBpz5l0u1InOIPY7DR3TnyOLUGkp6/k/XYLwdXufcgr5Jhy7u+sWyhO7vA7xgFI3Mr28jqJsI8OcQn+WvKsesd5L5UzYL9eZsFQRb5dFEr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPrjhSDI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhI1mksz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPrjhSDI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhI1mksz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A2AC21C7E;
	Thu, 29 Feb 2024 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709236014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jqJg2W6kXOUnjg3ctQelfs4kon3EN4Ragme3YVg6M5E=;
	b=tPrjhSDIlkNevC9R08OMKfDITeZ/qUJdzrUFPWLnFjVcrvt3ppE1aTjNO1DkF9V45uefvV
	4fvFSxUH0MgvNDQaHqPlOs3AXQ5cVnMhZWw6ODsxq8AtdtjoAfdkmkoxWxNFVKEUfUWt8c
	zFC2ZY0fcOEuOSdMBqh/N2T8dAt9HTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709236014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jqJg2W6kXOUnjg3ctQelfs4kon3EN4Ragme3YVg6M5E=;
	b=qhI1mksz8MR196h/9mqYk6rRfuv5lwV7bGGip5D4r1T3SNGmP/c3Si2Lh+f9+24vrXb2jb
	LfqEisaelSlg9aDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709236014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jqJg2W6kXOUnjg3ctQelfs4kon3EN4Ragme3YVg6M5E=;
	b=tPrjhSDIlkNevC9R08OMKfDITeZ/qUJdzrUFPWLnFjVcrvt3ppE1aTjNO1DkF9V45uefvV
	4fvFSxUH0MgvNDQaHqPlOs3AXQ5cVnMhZWw6ODsxq8AtdtjoAfdkmkoxWxNFVKEUfUWt8c
	zFC2ZY0fcOEuOSdMBqh/N2T8dAt9HTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709236014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jqJg2W6kXOUnjg3ctQelfs4kon3EN4Ragme3YVg6M5E=;
	b=qhI1mksz8MR196h/9mqYk6rRfuv5lwV7bGGip5D4r1T3SNGmP/c3Si2Lh+f9+24vrXb2jb
	LfqEisaelSlg9aDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE2F213451;
	Thu, 29 Feb 2024 19:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Pmj2OS3f4GXRfAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 19:46:53 +0000
Date: Thu, 29 Feb 2024 20:39:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix use-after-free in do_zone_finish
Message-ID: <20240229193950.GD2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4b26736862c49050ef907e6f326ab34c0e82c6b8.1709208898.git.jth@kernel.org>
 <94b4286e-7c64-4573-a680-0360305d2db4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b4286e-7c64-4573-a680-0360305d2db4@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu, Feb 29, 2024 at 09:19:21AM -0800, Damien Le Moal wrote:
> On 2024/02/29 4:16, Johannes Thumshirn wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Shinichiro reported the following use-after-free triggered by the device
> > replace operation in fstests btrfs/070.
> > 
> >  BTRFS info (device nullb1): scrub: finished on devid 1 with status: 0
> >  ==================================================================
> >  BUG: KASAN: slab-use-after-free in do_zone_finish+0x91a/0xb90 [btrfs]
> >  Read of size 8 at addr ffff8881543c8060 by task btrfs-cleaner/3494007
> > 
> >  CPU: 0 PID: 3494007 Comm: btrfs-cleaner Tainted: G        W          6.8.0-rc5-kts #1
> >  Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0x5b/0x90
> >   print_report+0xcf/0x670
> >   ? __virt_addr_valid+0x200/0x3e0
> >   kasan_report+0xd8/0x110
> >   ? do_zone_finish+0x91a/0xb90 [btrfs]
> >   ? do_zone_finish+0x91a/0xb90 [btrfs]
> >   do_zone_finish+0x91a/0xb90 [btrfs]
> >   btrfs_delete_unused_bgs+0x5e1/0x1750 [btrfs]
> >   ? __pfx_btrfs_delete_unused_bgs+0x10/0x10 [btrfs]
> >   ? btrfs_put_root+0x2d/0x220 [btrfs]
> >   ? btrfs_clean_one_deleted_snapshot+0x299/0x430 [btrfs]
> >   cleaner_kthread+0x21e/0x380 [btrfs]
> >   ? __pfx_cleaner_kthread+0x10/0x10 [btrfs]
> >   kthread+0x2e3/0x3c0
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x31/0x70
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork_asm+0x1b/0x30
> >   </TASK>
> > 
> >  Allocated by task 3493983:
> >   kasan_save_stack+0x33/0x60
> >   kasan_save_track+0x14/0x30
> >   __kasan_kmalloc+0xaa/0xb0
> >   btrfs_alloc_device+0xb3/0x4e0 [btrfs]
> >   device_list_add.constprop.0+0x993/0x1630 [btrfs]
> >   btrfs_scan_one_device+0x219/0x3d0 [btrfs]
> >   btrfs_control_ioctl+0x26e/0x310 [btrfs]
> >   __x64_sys_ioctl+0x134/0x1b0
> >   do_syscall_64+0x99/0x190
> >   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > 
> >  Freed by task 3494056:
> >   kasan_save_stack+0x33/0x60
> >   kasan_save_track+0x14/0x30
> >   kasan_save_free_info+0x3f/0x60
> >   poison_slab_object+0x102/0x170
> >   __kasan_slab_free+0x32/0x70
> >   kfree+0x11b/0x320
> >   btrfs_rm_dev_replace_free_srcdev+0xca/0x280 [btrfs]
> >   btrfs_dev_replace_finishing+0xd7e/0x14f0 [btrfs]
> >   btrfs_dev_replace_by_ioctl+0x1286/0x25a0 [btrfs]
> >   btrfs_ioctl+0xb27/0x57d0 [btrfs]
> >   __x64_sys_ioctl+0x134/0x1b0
> >   do_syscall_64+0x99/0x190
> >   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > 
> >  The buggy address belongs to the object at ffff8881543c8000
> >   which belongs to the cache kmalloc-1k of size 1024
> >  The buggy address is located 96 bytes inside of
> >   freed 1024-byte region [ffff8881543c8000, ffff8881543c8400)
> > 
> >  The buggy address belongs to the physical page:
> >  page:00000000fe2c1285 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1543c8
> >  head:00000000fe2c1285 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> >  flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> >  page_type: 0xffffffff()
> >  raw: 0017ffffc0000840 ffff888100042dc0 ffffea0019e8f200 dead000000000002
> >  raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> >  page dumped because: kasan: bad access detected
> > 
> >  Memory state around the buggy address:
> >   ffff8881543c7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >   ffff8881543c7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  >ffff8881543c8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                                         ^
> >   ffff8881543c8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >   ffff8881543c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > 
> > This UAF happens because we're accessing stale zone information of a
> > already removed btrfs_device in do_zone_finish().
> > 
> > The sequence of events is as follows:
> > 
> > btrfs_dev_replace_start
> >   btrfs_scrub_dev
> >    btrfs_dev_replace_finishing
> >     btrfs_dev_replace_update_device_in_mapping_tree <-- devices replaced
> >     btrfs_rm_dev_replace_free_srcdev
> >      btrfs_free_device                              <-- device freed
> > 
> > cleaner_kthread
> >  btrfs_delete_unused_bgs
> >   btrfs_zone_finish
> >    do_zone_finish              <-- refers the freed device
> > 
> > The reason for this is that we're using a cached pointer to the chunk_map
> > from the block group, but on device replace this cached pointer can
> > contain stale device entries.
> > 
> > So grab a fresh reference to the chunk map and don't rely on the cached
> > version.
> > 
> > Many thanks to Shinichiro for analyzing the bug.
> > 
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Same here... Fixes and Cc:stable tags ?

We don't require stable tags when posted it's not always clear where and
if it applies, I do an evaluation later.

