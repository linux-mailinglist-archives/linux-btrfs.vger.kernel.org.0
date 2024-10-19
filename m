Return-Path: <linux-btrfs+bounces-9010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5BB9A4F94
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61521F230B0
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767818660F;
	Sat, 19 Oct 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bllue.org header.i=@bllue.org header.b="Q+8TRPQj";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="AwWtLXeE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from ivory.cherry.relay.mailchannels.net (ivory.cherry.relay.mailchannels.net [23.83.223.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE72F3E
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.94
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729354116; cv=pass; b=TZp1CY1Ri6flYktzjpcS+4XPd7srkkx4kMWFZqvP7XSJK8aWQNdVwnpTcCat3xKXnLEyhpSS//lls6hDJXXLPQIgH2mwTUHlRL51jyIeEojlfMn/s1WVnymI1baNm7NqpZdMicesVNxbz/NEvYBS7XgoEydLx6rQhBw6fAXmu7k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729354116; c=relaxed/simple;
	bh=o6x/t5ejE8TbmYfUOdpBYJU7/wBHM1IGe5QGMSbc09M=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=rySaf5ep4Ic2NxoyO0Euiht9cxLPpAxOiT9VP6mP084GVVVFjfq/fpDA8l+anGKALwvvGpbJaBvn3Is6OM9KVgl7uxoSMB8foGAm/GG0YqZUQ6Vs9nW04iN+s59VcxYbeWVEYnnPx0XUpMiJGo8Cl5hYROjeaj40Yj3HOoBs2YM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bllue.org; spf=pass smtp.mailfrom=bllue.org; dkim=pass (1024-bit key) header.d=bllue.org header.i=@bllue.org header.b=Q+8TRPQj; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=AwWtLXeE; arc=pass smtp.client-ip=23.83.223.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bllue.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bllue.org
X-Sender-Id: _forwarded-from|66.108.6.151
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2EDBE1A464A
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2024 13:45:56 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (trex-8.trex.outbound.svc.cluster.local [100.103.32.33])
	(Authenticated sender: duocircle)
	by relay.mailchannels.net (Postfix) with ESMTPA id 459581A62D2
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2024 13:45:55 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1729345555; a=rsa-sha256;
	cv=pass;
	b=KJopz4xqcIpkwnGoRyW6wTNa2nWie/jV+A3y6seesKF7puT8KabFQZMjhySNJ29q4hcnym
	OiW6GNKoO8vIqFhxIWFEmQVGFCf9th/bq33ro4r8uYzmSaAR6SNGZt9VBUOkDjsmJZCurV
	tYCEU+we7ifGtbI3aXdVYRRCuimjLUEqIdsnhcFl8R+IiO4Eyj/iwkcG9EMvkPeBDnwUzH
	NyD9WSPSP94PxbnX9sdh+4q6qSvskjqJUpPIdqdWpFm8CGuVt54LxelJwpDNjvDIYtOtEw
	jE56yWFvBWpivbnwB2DJOoNnlpw/jlNAiVbMUR1rUEvewY+39J/9ib+OcdLezQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729345555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=25Pbzf4pYDY9AQdGWp1rw/6+i9eyiR+4RF/Tn984S4I=;
	b=D9lMsCP5yGR3e4Bi/4+O2288uH9kprKa0QDfSwxpyH4tLyQiT+nqEMbP9jWr3tLMgzAHcQ
	tlD+QwdhGkluNBAjn7RgK+vhq9ZhYTUYAPmrhd8wMMaikfHcaPjEW8k1clv/8aPX8yBlKQ
	4PvDmzHWRiOm0Be3AjwiInMdo2TZflMtvngC50o9YjawPEfTSdIH/3AHhRIgFM3ayxA0U4
	CK3QxyE/E9DUD7iu+ptYy1NkJX9JRcVxHM05tS9/atKoD+yZiwhM2VdGDnDTc791FbLcna
	XPPHaG0Qer/l7+5BxKASi60ya/8yh1clzKhXnW2D75Z5z6EjJmWJst5aFULkEA==
ARC-Authentication-Results: i=2;
	rspamd-6bcbdd57f8-s8sqq;
	arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
	auth=pass smtp.auth=duocircle smtp.mailfrom=ken@bllue.org
X-Sender-Id: _forwarded-from|66.108.6.151
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|66.108.6.151
X-MailChannels-Auth-Id: duocircle
X-Stupid-Towering: 38ba4991189972f2_1729345555961_655222127
X-MC-Loop-Signature: 1729345555961:642849640
X-MC-Ingress-Time: 1729345555961
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.32.33 (trex/7.0.2);
	Sat, 19 Oct 2024 13:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1729345554; cv=none;
	d=outbound.mailhop.org; s=arc-outbound20181012;
	b=YXu/NUXTc+xfOlR4LlG3DJ9ifkYVw5HucRPdQLyg5z7hN3mcQ9yxvrC0HJrjGI0npKr7b1vcl2qX5
	 WWoQYiINFLqLd8AKi0xZx14mMjvxEbTx38k6XHHqF+ruTY18VCmbn2/WhjyFo3qxO5FnupFDx5+eA1
	 ETS5wGcg4xtHVX8s4HdIItil39WaLjpZdxv3dOxsmOqARS5IB6AzKhPKQKX3qd3XVxhLwVcw9Ms4Wy
	 yAtO5NOZKYgjLA2eNZffCXlpG3I1pF+mT/rmh4aQHyQsF3/3wDGkJZG4iGORb2X8LXCB4y98KRStK+
	 /h82sm0k7NerW4wU64xxppYSzLEuhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=arc-outbound20181012;
	h=content-transfer-encoding:content-type:message-id:subject:to:from:date:
	 mime-version:dkim-signature:dkim-signature:from;
	bh=25Pbzf4pYDY9AQdGWp1rw/6+i9eyiR+4RF/Tn984S4I=;
	b=ff72Sd/c3LqytGmN6yGhkuUrkk2g75/0tENR+zz3rRQ072aTFE3TGQxEJpxPfOMAm0rNLxOGwcRhv
	 HivHv45FFnyyYY2v0h7f5VIuF91HvIh9As8b0fnjBPnY0O2fD2mHV6JEyHnnEv9marz3EQb63JbdXm
	 hVs/bQn7dAkwVs9eNzLMWAvJrQNWFOqh9AeOlNGwdmmSBUKM0VcPydcdoEud9YInybMEy8nV0RNz2v
	 i6IvSiC5eZLP9mf2igV3ZIN4+jjMONGgeRplr8/mOngVxX+55p/RXLcb3TgefNmELAVRC57aHR8rnY
	 e+Thp+B7qj7bSVzlB9n/Gzir4ptkBNw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
	spf=softfail smtp.mailfrom=bllue.org smtp.remote-ip=66.108.6.151;
	dmarc=none header.from=bllue.org;
	arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bllue.org; s=duo-1694650998788-390f10b9;
	h=content-transfer-encoding:content-type:message-id:subject:to:from:date:
	 mime-version:from;
	bh=25Pbzf4pYDY9AQdGWp1rw/6+i9eyiR+4RF/Tn984S4I=;
	b=Q+8TRPQjcuOkxjhxT6Tvk3RIzTmmzHuFWp/ltJy8qxja9socKSFLgtUExSXF/TXl8KeYDLxaIREG4
	 icdt26dcFnZV2Db+/ma/IagC52Ppo7cCYFRSQw4RL1qEuDwFE7vRc+H3Ye91pNhTCTJRDuCJ4x7Qz5
	 iPH8Z/elazbQ4bmY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:content-type:message-id:subject:to:from:date:
	 mime-version:from;
	bh=25Pbzf4pYDY9AQdGWp1rw/6+i9eyiR+4RF/Tn984S4I=;
	b=AwWtLXeE+xDcKaYNJkcdDTktvKMdPWVmmXuKrtaAlb9tcy/eEIXahRGOOmEiGra68f4ugmEjLmC2w
	 Dk4xMOjr5pas1f/X51Eh+S2TtUEF3d1VVf/copXP0iFIPUjFEUC+mmfn1hIqtkoapj7Mpcm8Gr4xje
	 L23NJeqWC0uFoXQ7D7APETfhnWQ6+S1iHl1B8YoTWLaShnZY2V4oUSXP+WhI3UqBoXxPrpIXjPHwfy
	 96nFhqmD5e6//OmxVYaG5caipTxjAO83Mu3z9DQEGCZ9ln81Hlul43WtlwV0UYRVKuEtVpzBY3+hUP
	 8MnQxmE2bQI2W96rTv7wNycaqnTyVoQ==
X-MHO-RoutePath: YmxsdWVfb3JnX2VtYWls
X-MHO-User: 74563a6a-8e20-11ef-ac89-25ccbfd3c7c9
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from static.bllue.org (syn-066-108-006-151.res.spectrum.com [66.108.6.151])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id 74563a6a-8e20-11ef-ac89-25ccbfd3c7c9;
	Sat, 19 Oct 2024 13:45:52 +0000 (UTC)
Received: from bllue.org (localhost.localdomain [127.0.0.1])
	by static.bllue.org (Postfix) with ESMTP id 16530400073
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2024 09:45:50 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 09:45:50 -0400
From: Kenneth Topp <ken@bllue.org>
To: linux-btrfs@vger.kernel.org
Subject: btrfs filesystem so full I cannot mount it.
Message-ID: <a4570db8398a9ff148bd2b9c89b24b90@bllue.org>
X-Sender: ken@bllue.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a filesystem that (I think) is so full I cannot mount it.  when I 
do, it seems stuck in btrfs_start_pre_rw_mount->btrfs_orphan_cleanup 
forever.  I have let it run for a few hours, and it seems to be 
incrementally reading/writing the filesystem, but I'm not sure if that's 
a good thing or a bad thing.   Below is a kernel stack of mount when 
this is happening.  I'm running btrfs check right now, and it's still on 
step 4/7 but I'm committed to letting it finish this time, so I can be 
sure that there's no underlying issues.

I've tried to mount clear_cache which seemed to run, but it didn't hange 
that i'm stuck in orphan_cleanup.  There are no btrfs error messages in 
journald.

I'd like to get back to normal, my backups a bit old, so even a 
read-only mount would be nice (I haven't yet tried) but I'm hopefully 
for a resolution where I can just mount the thing, and free up a bunch 
of space.  My next great idea is just adding another disk to the 
filesystem, but i thought it's time to ask for guidance from the list.  
this filesystem is -d single -m raid1 and uses space group v2, which was 
great because it use to take 5 minutes to mount the filesystem.


any guidance would be most appreciated, I've tried to include a cursory 
detail of what's happening below.  please let me know if there's 
anything more I can provide or steps I should take.




Oct 19 01:07:43 myhost kernel: task:mount           state:D stack:0     
pid:13675 tgid:13675 ppid:12146  flags:0x00004002
Oct 19 01:07:43 myhost kernel: Call Trace:
Oct 19 01:07:43 myhost kernel:  <TASK>
Oct 19 01:07:43 myhost kernel:  __schedule+0x400/0x1720
Oct 19 01:07:43 myhost kernel:  schedule+0x27/0xf0
Oct 19 01:07:43 myhost kernel:  io_schedule+0x46/0x70
Oct 19 01:07:43 myhost kernel:  bit_wait_io+0x11/0x70
Oct 19 01:07:43 myhost kernel:  __wait_on_bit+0x45/0x160
Oct 19 01:07:43 myhost kernel:  ? __pfx_bit_wait_io+0x10/0x10
Oct 19 01:07:43 myhost kernel:  out_of_line_wait_on_bit+0x94/0xc0
Oct 19 01:07:43 myhost kernel:  ? __pfx_wake_bit_function+0x10/0x10
Oct 19 01:07:43 myhost kernel:  read_extent_buffer_pages+0x1de/0x220
Oct 19 01:07:43 myhost kernel:  btrfs_read_extent_buffer+0x94/0x1c0
Oct 19 01:07:43 myhost kernel:  read_tree_block+0x32/0x90
Oct 19 01:07:43 myhost kernel:  read_block_for_search+0x247/0x360
Oct 19 01:07:43 myhost kernel:  btrfs_search_slot+0x375/0x1060
Oct 19 01:07:43 myhost kernel:  ? btrfs_extent_root+0x85/0xb0
Oct 19 01:07:43 myhost kernel:  lookup_inline_extent_backref+0x174/0x810
Oct 19 01:07:43 myhost kernel:  ? __slab_free+0xdf/0x2e0
Oct 19 01:07:43 myhost kernel:  lookup_extent_backref+0x41/0xd0
Oct 19 01:07:43 myhost kernel:  __btrfs_free_extent.isra.0+0x110/0xa10
Oct 19 01:07:43 myhost kernel:  __btrfs_run_delayed_refs+0x592/0xfc0
Oct 19 01:07:43 myhost kernel:  ? release_extent_buffer+0xb1/0xd0
Oct 19 01:07:43 myhost kernel:  ? __write_extent_buffer+0x14b/0x1a0
Oct 19 01:07:43 myhost kernel:  ? btrfs_release_path+0x2b/0x190
Oct 19 01:07:43 myhost kernel:  ? update_block_group_item+0x16d/0x1b0
Oct 19 01:07:43 myhost kernel:  btrfs_run_delayed_refs+0x3b/0xd0
Oct 19 01:07:43 myhost kernel:  
btrfs_start_dirty_block_groups+0x303/0x530
Oct 19 01:07:43 myhost kernel:  btrfs_commit_transaction+0xb5/0xc90
Oct 19 01:07:43 myhost kernel:  ? start_transaction+0x22c/0x830
Oct 19 01:07:43 myhost kernel:  flush_space+0xfa/0x5b0
Oct 19 01:07:43 myhost kernel:  ? btrfs_reduce_alloc_profile+0x9e/0x1d0
Oct 19 01:07:43 myhost kernel:  
priority_reclaim_metadata_space+0x94/0x150
Oct 19 01:07:43 myhost kernel:  __reserve_bytes+0x2a7/0x6e0
Oct 19 01:07:43 myhost kernel:  ? __slab_free+0xdf/0x2e0
Oct 19 01:07:43 myhost kernel:  btrfs_reserve_metadata_bytes+0x1d/0xc0
Oct 19 01:07:43 myhost kernel:  btrfs_block_rsv_refill+0x6b/0xa0
Oct 19 01:07:43 myhost kernel:  evict_refill_and_join+0x4b/0xc0
Oct 19 01:07:43 myhost kernel:  btrfs_evict_inode+0x30a/0x3c0
Oct 19 01:07:43 myhost kernel:  evict+0x10e/0x2c0
Oct 19 01:07:43 myhost kernel:  ? unlock_new_inode+0x4c/0x60
Oct 19 01:07:43 myhost kernel:  ? _atomic_dec_and_lock+0x39/0x50
Oct 19 01:07:43 myhost kernel:  btrfs_orphan_cleanup+0x209/0x2e0
Oct 19 01:07:43 myhost kernel:  btrfs_start_pre_rw_mount+0x1ab/0x480
Oct 19 01:07:43 myhost kernel:  open_ctree+0x1063/0x1426
Oct 19 01:07:43 myhost kernel:  btrfs_get_tree.cold+0x6b/0x10e
Oct 19 01:07:43 myhost kernel:  ? vfs_dup_fs_context+0x2d/0x1e0
Oct 19 01:07:43 myhost kernel:  vfs_get_tree+0x29/0xd0
Oct 19 01:07:43 myhost kernel:  fc_mount+0x12/0x40
Oct 19 01:07:43 myhost kernel:  btrfs_get_tree+0x30e/0x700
Oct 19 01:07:43 myhost kernel:  vfs_get_tree+0x29/0xd0
Oct 19 01:07:43 myhost kernel:  vfs_cmd_create+0x65/0xf0
Oct 19 01:07:43 myhost kernel:  __do_sys_fsconfig+0x43c/0x670
Oct 19 01:07:43 myhost kernel:  do_syscall_64+0x82/0x160
Oct 19 01:07:43 myhost kernel:  ? do_faccessat+0x1e4/0x2e0
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? exc_page_fault+0x7e/0x180
Oct 19 01:07:43 myhost kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct 19 01:07:43 myhost kernel: RIP: 0033:0x7fee827a383e
Oct 19 01:07:43 myhost kernel: RSP: 002b:00007ffde9f8d058 EFLAGS: 
00000246 ORIG_RAX: 00000000000001af
Oct 19 01:07:43 myhost kernel: RAX: ffffffffffffffda RBX: 
000055927b56fa90 RCX: 00007fee827a383e
Oct 19 01:07:43 myhost kernel: RDX: 0000000000000000 RSI: 
0000000000000006 RDI: 0000000000000003
Oct 19 01:07:43 myhost kernel: RBP: 00007ffde9f8d1a0 R08: 
0000000000000000 R09: 00007fee82896b20
Oct 19 01:07:43 myhost kernel: R10: 0000000000000000 R11: 
0000000000000246 R12: 00007fee8291cb00
Oct 19 01:07:43 myhost kernel: R13: 0000000000000000 R14: 
000055927b570bd0 R15: 00007fee82911561
Oct 19 01:07:43 myhost kernel:  </TASK>


# btrfs check -p /dev/mapper/cprt-50
Opening filesystem to check...
Checking filesystem on /dev/mapper/cprt-50
UUID: b8b8786b-77ad-41aa-bd17-4607d4a7c428
[1/8] checking log skipped (none written)
[1/7] checking root items                      (0:35:12 elapsed, 
60022243 items checked)
[2/7] checking extents                         (0:40:49 elapsed, 6069209 
items checked)
[3/7] checking free space tree                 (0:36:47 elapsed, 63245 
items checked)
[4/7] checking fs roots                        (6:20:51 elapsed, 453264 
items checked)


# btrfs filesystem show /dev/mapper/cprt-50
Label: 'dtm'  uuid: b8b8786b-77ad-41aa-bd17-4607d4a7c428
         Total devices 4 FS bytes used 61.75TiB
         devid    1 size 16.37TiB used 16.37TiB path /dev/mapper/cprt-62
         devid    2 size 16.37TiB used 16.37TiB path /dev/mapper/cprt-63
         devid    3 size 14.55TiB used 14.55TiB path /dev/mapper/cprt-50
         devid    4 size 14.55TiB used 14.55TiB path /dev/mapper/cprt-53


# messages, this filesystem is label dtm/ 
b8b8786b-77ad-41aa-bd17-4607d4a7c428
Oct 18 18:06:48 static.bllue.org kernel: Btrfs loaded, zoned=yes, 
fsverity=yes
Oct 18 18:06:57 static.bllue.org kernel: BTRFS: device label dtm devid 4 
transid 790228 /dev/dm-0 (253:0) scanned by (udev-worker) (722)
Oct 18 18:06:58 static.bllue.org kernel: BTRFS: device label ex:home2 
devid 1 transid 290610 /dev/dm-2 (253:2) scanned by (udev-worker) (722)
Oct 18 18:07:02 static.bllue.org kernel: BTRFS: device label dtm devid 1 
transid 790228 /dev/dm-5 (253:5) scanned by (udev-worker) (719)
Oct 18 18:07:03 static.bllue.org kernel: BTRFS: device label ex:home2 
devid 2 transid 290610 /dev/dm-6 (253:6) scanned by (udev-worker) (722)
Oct 18 18:07:11 static.bllue.org kernel: BTRFS: device label ex:home2b 
devid 2 transid 847454 /dev/dm-12 (253:12) scanned by (udev-worker) 
(722)
Oct 18 18:07:15 static.bllue.org kernel: BTRFS: device label dtm devid 3 
transid 790228 /dev/dm-17 (253:17) scanned by (udev-worker) (722)
Oct 18 18:07:19 static.bllue.org kernel: BTRFS: device label dtm devid 2 
transid 790228 /dev/dm-22 (253:22) scanned by (udev-worker) (719)
Oct 18 18:07:20 static.bllue.org kernel: BTRFS: device label ex:home2b 
devid 1 transid 847454 /dev/dm-23 (253:23) scanned by (udev-worker) 
(719)
Oct 18 18:07:21 static.bllue.org kernel: BTRFS info (device dm-23): 
first mount of filesystem 60eb6265-d748-406b-9301-2c4e5b3e71c0
Oct 18 18:07:21 static.bllue.org kernel: BTRFS info (device dm-23): 
using crc32c (crc32c-intel) checksum algorithm
Oct 18 18:07:21 static.bllue.org kernel: BTRFS info (device dm-23): 
using free-space-tree
Oct 18 23:47:18 static.bllue.org kernel: BTRFS info (device dm-5): first 
mount of filesystem b8b8786b-77ad-41aa-bd17-4607d4a7c428
Oct 18 23:47:18 static.bllue.org kernel: BTRFS info (device dm-5): using 
crc32c (crc32c-intel) checksum algorithm
Oct 18 23:47:18 static.bllue.org kernel: BTRFS info (device dm-5): using 
free-space-tree






# for i in cprt-62 cprt-63 cprt-50 cprt-53; do echo == $i ==; btrfs 
inspect-internal dump-super /dev/mapper/$i;done
== cprt-62 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-62
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xb3f048e8 [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID |
                           BLOCK_GROUP_TREE )
incompat_flags          0x361
                         ( MIXED_BACKREF |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           c066323f-76b6-47d8-8c6c-bcd5fa0ec116
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    18000189063168
dev_item.bytes_used     18000188014592
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

== cprt-63 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-63
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x385ea4fd [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID |
                           BLOCK_GROUP_TREE )
incompat_flags          0x361
                         ( MIXED_BACKREF |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           fe160407-2ae0-4d04-9df5-fc7ed52b827a
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    18000189063168
dev_item.bytes_used     18000188014592
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          2
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

== cprt-50 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-50
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xe7c8676d [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID |
                           BLOCK_GROUP_TREE )
incompat_flags          0x361
                         ( MIXED_BACKREF |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           072a8618-1b73-400a-8fee-1a3a07998748
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    16000881786880
dev_item.bytes_used     16000880738304
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          3
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

== cprt-53 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-53
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x8f5d73e9 [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID |
                           BLOCK_GROUP_TREE )
incompat_flags          0x361
                         ( MIXED_BACKREF |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           7651b9c3-0b25-4aa5-b3c8-d28602e1779f
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    16000881786880
dev_item.bytes_used     16000880738304
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          4
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0


Ken

