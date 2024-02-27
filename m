Return-Path: <linux-btrfs+bounces-2847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBDA86A376
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 00:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364CBB2710A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 23:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC255E6F;
	Tue, 27 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="VQpS1Vrv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592855E64
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075680; cv=none; b=KmXxvUOSA+sbZTB7pEMsRLuAlLEiNaIvGNUlz4aIcfFMtGrfVP3XHRFuuAKAnrkXpDcSAEwsKigiXQYb76+y627ZcNU7N+ByTslJz3BQvx5UW1GuGX9ToPFVP7RW1aBazTadMaBeDzKcOtYY4HbB4yTaJOdkK3MX2GOhx91nWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075680; c=relaxed/simple;
	bh=i00ob728qJBG+1MthI4Ya7LyUr27lGq+ry3ZABxsE0k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKz8asXhga902ab0Jc/s74SZpr/Ut70EqcTweZ4uasuF2YRmC34ccpLOuO4C2xfzUxsGUZDA19gCuqiZaIUpo23GsseodkKtBgQYz6rxwiWtWcnVgRz2e+mUYXqqNVNVjk7QF6NKeyKbCO6XQ1A1yd5g4bErqT2tZCOxZOPfr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=VQpS1Vrv reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Izaf0QkJi9EjfFs0X3kEO9uK4JAdQ65RVeGev0TxyUU=; b=VQpS1VrvoAHsitrLDRODxLC0oi
	dmbkyJ2tTkt6qllp15BSpgtXvFCJoZ3VY2lCy5vowiN5ZIAl/Mp1NLL0k3ARydElv1FrKU0ShQwPo
	OYM618I8lyAdGo8+GcfMnRw5YSPdRIL/d6QR/aG99S2h0R9aULQX6drlPVDNuEnFWEwfYousMq4X9
	dM+OIU2D2OpoqM4WD8nHGRMgwB6jbmFoiaWyvBOcNDNWtxeHiLcvWWf8Dw9V9eZqYqbnj78QTXkcq
	Oc0P20WK+7vc33lL8LfxuB/jBL+DZUudvDHTK89s+Jo8F52jeQduHM3llM7eQevOIpyj0/i8Sl4cY
	xz4L825Q==;
Received: from [172.58.109.235] (port=7048 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rf6eg-0004ux-OE by authid <merlins.org> with srv_auth_plain; Tue, 27 Feb 2024 15:14:34 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rf6ec-004iUs-34;
	Tue, 27 Feb 2024 15:14:30 -0800
Date: Tue, 27 Feb 2024 15:14:30 -0800
From: Marc MERLIN <marc@merlins.org>
To: linux-btrfs@vger.kernel.org
Subject: Re: 6.4 and 6.9 btrfs blocked and btrfs_work_helper workqueue
 lockup, is it an IO bug/hang though?
Message-ID: <Zd5s1k8bFguE2NVl@merlins.org>
References: <ZdL0BJjuyhtS8vn1@merlins.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdL0BJjuyhtS8vn1@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.109.235
X-SA-Exim-Mail-From: marc@merlins.org

Could anyone who can raad those things better than me, give me a clue
whether those hangs are hardware related like I'm guessing they may be,
or if they are potentially bugs worth looking into?

Thanks,
Marc

On Sun, Feb 18, 2024 at 10:24:04PM -0800, Marc MERLIN wrote:
> I've seen this with both 6.4.9 and 6.6.9 and had to sysrq reboot both
> times to recover.
> I'm trying to see if it's a hang of my raid card.
> 
> That's the more recent hang with 6.6.9:
> 
> The one with 6.4.9 is longer, so I put it here: https://pastebin.com/xz11JXWM
> 
> Here's the 6.6.9 one here. Can someone help me confirm that at least
> this one is likely not btrfs' fault but just underlying I/O hang?
> 
> If so, idoes the 6.4.9 match the same symptom, or is it a different issue?
> 
> Thanks,
> Marc
> 
> 135577.600958] INFO: task md12_raid1:1276 blocked for more than 120 seconds.
> [135577.621963]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
> [135577.641401] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [135577.665522] task:md12_raid1      state:D stack:0     pid:1276  ppid:2      flags:0x00004000
> [135577.691381] Call Trace:
> [135577.699494]  <TASK>
> [135577.706627]  __schedule+0x6af/0x702
> [135577.717853]  schedule+0x8b/0xbd
> [135577.727933]  md_super_wait+0x5d/0x9c
> [135577.739287]  ? __pfx_autoremove_wake_function+0x40/0x40
> [135577.755602]  write_sb_page+0x242/0x25d
> [135577.767482]  md_update_sb+0x4c1/0x679
> [135577.779072]  md_check_recovery+0x276/0x484
> [135577.791965]  raid1d+0x46/0x10db
> [135577.802178]  ? raw_spin_rq_unlock_irq+0x5/0x10
> [135577.816122]  ? finish_task_switch.isra.0+0x129/0x202
> [135577.831629]  ? __schedule+0x6b7/0x702
> [135577.843292]  ? lock_timer_base+0x38/0x5f
> [135577.855662]  ? schedule+0x8b/0xbd
> [135577.866222]  ? __list_add+0x12/0x2f
> [135577.877341]  ? _raw_spin_unlock_irqrestore+0xe/0x2e
> [135577.892618]  md_thread+0x113/0x140
> [135577.903553]  ? __pfx_autoremove_wake_function+0x40/0x40
> [135577.920016]  ? __pfx_md_thread+0x40/0x40
> [135577.932413]  kthread+0xe8/0xf0
> [135577.942221]  ? __pfx_kthread+0x40/0x40
> [135577.954084]  ret_from_fork+0x24/0x36
> [135577.965583]  ? __pfx_kthread+0x40/0x40
> [135577.977475]  ret_from_fork_asm+0x1b/0x80
> [135577.989877]  </TASK>
> [135577.997078] INFO: task md13_raid1:1278 blocked for more than 121 seconds.
> [135578.018044]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
> [135578.037405] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [135578.061454] task:md13_raid1      state:D stack:0     pid:1278  ppid:2      flags:0x00004000
> [135578.087065] Call Trace:
> [135578.094972]  <TASK>
> [135578.102074]  __schedule+0x6af/0x702
> [135578.113302]  schedule+0x8b/0xbd
> [135578.123297]  md_super_wait+0x5d/0x9c
> [135578.134757]  ? __pfx_autoremove_wake_function+0x40/0x40
> [135578.151023]  write_sb_page+0x242/0x25d
> [135578.162869]  md_update_sb+0x4c1/0x679
> [135578.174470]  md_check_recovery+0x276/0x484
> [135578.187342]  raid1d+0x46/0x10db
> [135578.197352]  ? raw_spin_rq_unlock_irq+0x5/0x10
> [135578.211262]  ? finish_task_switch.isra.0+0x129/0x202
> [135578.226731]  ? __schedule+0x6b7/0x702
> [135578.238278]  ? lock_timer_base+0x38/0x5f
> [135578.250688]  ? _raw_spin_unlock_irqrestore+0xe/0x2e
> [135578.265933]  ? __try_to_del_timer_sync+0x64/0x8b
> [135578.280350]  ? __timer_delete_sync+0x2e/0x3d
> [135578.293706]  ? __list_add+0x12/0x2f
> [135578.304886]  ? _raw_spin_unlock_irqrestore+0xe/0x2e
> [135578.320238]  md_thread+0x113/0x140
> [135578.331038]  ? __pfx_autoremove_wake_function+0x40/0x40
> [135578.347265]  ? __pfx_md_thread+0x40/0x40
> [135578.359599]  kthread+0xe8/0xf0
> [135578.369323]  ? __pfx_kthread+0x40/0x40
> [135578.381272]  ret_from_fork+0x24/0x36
> [135578.392702]  ? __pfx_kthread+0x40/0x40
> [135578.404534]  ret_from_fork_asm+0x1b/0x80
> [135578.416877]  </TASK>
> [135578.424012] INFO: task dmcrypt_write/2:2017 blocked for more than 121 seconds.
> [135578.446256]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
> [135578.465619] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [135578.489691] task:dmcrypt_write/2 state:D stack:0     pid:2017  ppid:2      flags:0x00004000
> [135578.515301] Call Trace:
> [135578.523384]  <TASK>
> [135578.530433]  __schedule+0x6af/0x702
> [135578.541490]  schedule+0x8b/0xbd
> [135578.551650]  md_write_start+0x160/0x1a7
> [135578.563748]  ? __pfx_autoremove_wake_function+0x40/0x40
> [135578.579993]  raid1_make_request+0x89/0x880
> [135578.592962]  ? sugov_update_single_freq+0x20/0x106
> [135578.607926]  ? update_load_avg+0x372/0x39b
> [135578.620814]  ? get_sd_balance_interval+0xf/0x3d
> [135578.635156]  md_handle_request+0x126/0x16d
> [135578.648040]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135578.674973]  ? _raw_spin_unlock+0xa/0x1d
> [135578.687325]  ? raw_spin_rq_unlock_irq+0x5/0x10
> [135578.701386]  ? finish_task_switch.isra.0+0x129/0x202
> [135578.716851]  __submit_bio+0x63/0x89
> [135578.728043]  submit_bio_noacct_nocheck+0x181/0x258
> [135578.743026]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135578.769994]  dmcrypt_write+0xd1/0xfd [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135578.794848]  kthread+0xe8/0xf0
> [135578.804612]  ? __pfx_kthread+0x40/0x40
> [135578.816438]  ret_from_fork+0x24/0x36
> [135578.827741]  ? __pfx_kthread+0x40/0x40
> [135578.839744]  ret_from_fork_asm+0x1b/0x80
> [135578.852280]  </TASK>
> [135578.859445] INFO: task btrfs-transacti:2415 blocked for more than 122 seconds.
> [135578.881710]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
> [135578.901270] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [135578.925345] task:btrfs-transacti state:D stack:0     pid:2415  ppid:2      flags:0x00004000
> [135578.950996] Call Trace:
> [135578.958960]  <TASK>
> [135578.965902]  __schedule+0x6af/0x702
> [135578.976995]  schedule+0x8b/0xbd
> [135578.987195]  io_schedule+0x12/0x38
> [135578.998015]  folio_wait_bit_common+0x157/0x202
> [135579.011950]  ? __pfx_wake_page_function+0x40/0x40
> [135579.026658]  folio_wait_writeback+0x30/0x38
> [135579.039897]  __filemap_fdatawait_range+0x74/0xbf
> [135579.054353]  ? __update_freelist_fast+0x17/0x1e
> [135579.068568]  ? __clear_extent_bit+0x323/0x338
> [135579.082257]  filemap_fdatawait_range+0xf/0x19
> [135579.096112]  __btrfs_wait_marked_extents.isra.0+0x98/0xf3
> [135579.113089]  btrfs_write_and_wait_transaction+0x5d/0xbf
> [135579.129372]  btrfs_commit_transaction+0x67c/0xa62
> [135579.144094]  ? start_transaction+0x3f7/0x463
> [135579.157540]  transaction_kthread+0x105/0x17a
> [135579.170970]  ? __pfx_transaction_kthread+0x40/0x40
> [135579.185951]  kthread+0xe8/0xf0
> [135579.195732]  ? __pfx_kthread+0x40/0x40
> [135579.207593]  ret_from_fork+0x24/0x36
> [135579.218942]  ? __pfx_kthread+0x40/0x40
> [135579.230778]  ret_from_fork_asm+0x1b/0x80
> [135579.243146]  </TASK>
> [135579.250316] INFO: task dmcrypt_write/2:5016 blocked for more than 122 seconds.
> [135579.272593]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
> [135579.291991] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [135579.316244] task:dmcrypt_write/2 state:D stack:0     pid:5016  ppid:2      flags:0x00004000
> [135579.341930] Call Trace:
> [135579.349929]  <TASK>
> [135579.356826]  __schedule+0x6af/0x702
> [135579.367910]  schedule+0x8b/0xbd
> [135579.377939]  md_write_start+0x160/0x1a7
> [135579.390216]  ? __pfx_autoremove_wake_function+0x40/0x40
> [135579.406491]  raid1_make_request+0x89/0x880
> [135579.419401]  ? update_cfs_rq_load_avg+0x176/0x189
> [135579.434131]  ? update_load_avg+0x46/0x39b
> [135579.446738]  ? get_sd_balance_interval+0xf/0x3d
> [135579.461129]  md_handle_request+0x126/0x16d
> [135579.474037]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135579.500975]  ? _raw_spin_unlock+0xa/0x1d
> [135579.513370]  ? raw_spin_rq_unlock_irq+0x5/0x10
> [135579.527308]  ? finish_task_switch.isra.0+0x129/0x202
> [135579.542831]  __submit_bio+0x63/0x89
> [135579.553918]  submit_bio_noacct_nocheck+0x181/0x258
> [135579.568943]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135579.595885]  dmcrypt_write+0xd1/0xfd [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135579.620760]  kthread+0xe8/0xf0
> [135579.630682]  ? __pfx_kthread+0x40/0x40
> [135579.642699]  ret_from_fork+0x24/0x36
> [135579.654188]  ? __pfx_kthread+0x40/0x40
> [135579.666045]  ret_from_fork_asm+0x1b/0x80
> [135579.678418]  </TASK>
> [135579.685606] INFO: task dmcrypt_write/2:5286 blocked for more than 122 seconds.
> [135579.707870]       Not tainted 6.6.9-amd64-volpre-sysrq-20240101 #19
> [135579.727445] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [135579.751591] task:dmcrypt_write/2 state:D stack:0     pid:5286  ppid:2      flags:0x00004000
> [135579.777266] Call Trace:
> [135579.785223]  <TASK>
> [135579.792124]  __schedule+0x6af/0x702
> [135579.803200]  ? __pfx_wbt_inflight_cb+0x40/0x40
> [135579.817139]  ? __pfx_wbt_cleanup_cb+0x40/0x40
> [135579.830818]  schedule+0x8b/0xbd
> [135579.840951]  io_schedule+0x12/0x38
> [135579.851745]  rq_qos_wait+0xe8/0x126
> [135579.862795]  ? __pfx_rq_qos_wake_function+0x40/0x40
> [135579.878021]  ? __pfx_wbt_inflight_cb+0x40/0x40
> [135579.891951]  wbt_wait+0x95/0xe4
> [135579.902022]  __rq_qos_throttle+0x23/0x33
> [135579.914398]  blk_mq_submit_bio+0x2b6/0x4dd
> [135579.927273]  __submit_bio+0x29/0x89
> [135579.938356]  submit_bio_noacct_nocheck+0x121/0x258
> [135579.953357]  ? __pfx_dmcrypt_write+0x40/0x40 [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135579.980432]  dmcrypt_write+0xd1/0xfd [dm_crypt 721219ef82f7f7c3ecde59f70e81b621d3b8f858]
> [135580.005323]  kthread+0xe8/0xf0
> [135580.015088]  ? __pfx_kthread+0x40/0x40
> [135580.026929]  ret_from_fork+0x24/0x36
> [135580.038259]  ? __pfx_kthread+0x40/0x40
> [135580.050266]  ret_from_fork_asm+0x1b/0x80
> [135580.062628]  </TASK>
> [135580.069774] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> 
> 
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
> 
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

