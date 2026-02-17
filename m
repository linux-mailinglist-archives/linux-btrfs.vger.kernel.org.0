Return-Path: <linux-btrfs+bounces-21736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPTvK9bslGnUIwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21736-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:33:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18361151835
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02320302C916
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BC3C2D;
	Tue, 17 Feb 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="bLFJlmEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/hfAIO2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C9284890
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367603; cv=none; b=uhU7voBCIwxoLgCVSgbrjEtpQKiXtVbOwd7spXpGiznrRNkpdqv3ZgakqXC/DD0MK2tSE0HZGQ+88Fgk3HK2ri1EiuGgLADszZxsD8rX56EhLKXwLCft1s1wc+2jh+eKExfn2U7GfvyrU63+/yS51Z8LT3x0DIN015MJihy8B5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367603; c=relaxed/simple;
	bh=+RlANODy1eKoBjHiOrFr4mDyM76F0XZZGpqhF+CAszo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF0+Ner7ktP7spW0dfZ9nPp6HPUHrtEKG7tPfaorLymIUCniyI34u91uly8O5vSuiokvnrFjHwozAU8BLtn9baESDGgKudJqEOGlQice7i0y6KzNfV+hmW8MxsWgQmCllwqI9GfXB6r1/41aug9nZZN9nuRVsODZcgh9pecGO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=bLFJlmEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/hfAIO2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 670147A010D;
	Tue, 17 Feb 2026 17:33:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 17:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1771367601; x=1771454001; bh=UmAYyT41qu
	CIzwpighEfb98dBHpye4zttXr+pvQsNsA=; b=bLFJlmEG2ZoB9Bi8kqQ0s14zFu
	QRJiZhcI7pXahREgJ+iyw3EMf3YZ+4gDw07ZtQHKF9WgbPNGcJ+TjoSjwa8TSLdR
	MUFhLGAF0coYEbL423Jg720/3N2IVYjofWxjbuGVCzM/P3bhiLoUoGW8KvYjbrwt
	RvFxvQUsVawQ0LTROTnQ9TV+COn1sXbokNCNpaVL7ztJ5EK2emFN0VaDtIT2Nvi4
	2yu5FAJLtm39d3gZBYYTdB1RECzgAv8IrM/5/WK2F3NaR9Wi5cjV5l8L3Cfxc/aA
	m/8KR5v7E/yjPWALJ6wiq8mX+Djoe9nKTCYR9+aM1RFQssyfug1aOZLFwhYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771367601; x=1771454001; bh=UmAYyT41quCIzwpighEfb98dBHpye4zttXr
	+pvQsNsA=; b=s/hfAIO2j5VXYi3D0tPhbErNtAGi++LjISiCqf+X+nKTA8F049W
	qtgYY0Wsjrf3E74IHssjy4I89bTYPfKrsKtgeTs8tBxRCnYJWhv4xapqkgyAnmJ6
	eUGQX2NO6ZyD+/26GWcsV3V74T0vLGttHdmtOFdsYp7rOCkSwxSGf64SDByfzBok
	pf4gAChDncrFHsHkgaQhTeAoqMChJgSCaMoO4wv+1GW1fvymM+DV/rEVN0iOhj91
	3zSx3JfQqwBywggWymTm0P1Hx0XDzYtt7a+kMi+6rjKJZL/V2FtoPFaeEzFFUWuV
	2PygfGL6OFS5Eh9OdAQypojXccdFtYLLwkg==
X-ME-Sender: <xms:sOyUabLQt6y1Y0I4m71zsOc7Hl8-N-M1eDIcVxkvZwqhaNwou53eVg>
    <xme:sOyUaVJnb0hrSLhvnO4IvIrySgoxIrPxUh0MqKkz202_Go1SLmR1DJrNuvt0WTJrk
    3x2PbncPFiInml6_TjBf8NOekjVn6nSVh7xpX4S19s1vuO-QyFkqbgh>
X-ME-Received: <xmr:sOyUaRWgI36NZahTNDWRVJbze9jfMeCp4zhph3hRRCSvmlKQEO_WOGvrjDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepuefgfeetffefgfduvedvvedtfffgudefgfeuffejff
    ehheduueeiudetkeegffehnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    fhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsth
    hrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sOyUafhPNKgjwwxNURTUtTLwXnY7mQABobQ3U-vGpMFCjxfeEGweYw>
    <xmx:seyUaU9ahVAEN08NDUXO5rXHahZd6BJmNDkdkBOo4mqhEvPBgBzKlg>
    <xmx:seyUaRBZVnh0TrLfOV6FKP42zSzFVeNIAYnZJzl6oX4H3iClODVFkw>
    <xmx:seyUaZL-HKf-1iVoLvQUVLMigS3WiWyTgmrbQjpi7LPJ-VuEwOiJNQ>
    <xmx:seyUaa8cp3yHBctynAWHuKPPdfglDeYKjWQbdeMwl2v_vkQ8hzwb1OTx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 17:33:20 -0500 (EST)
Date: Tue, 17 Feb 2026 14:33:18 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reserve transaction space for qgroup ioctls
Message-ID: <aZTsohkDalxCEg9N@devvm12410.ftw0.facebook.com>
References: <6b9fa2e018d777f48b3d6ed4b8160d932616297b.1771002477.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9fa2e018d777f48b3d6ed4b8160d932616297b.1771002477.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[test.sh:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	R_DKIM_ALLOW(0.00)[bur.io:s=fm1,messagingengine.com:s=fm3];
	TAGGED_FROM(0.00)[bounces-21736-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,test.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: 18361151835
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 06:35:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently our qgroup ioctls don't reserve any space, they just do a
> transaction join, which does not reserve any space, neither for the quota
> tree updates nor for the delayed refs generated when updating the quota
> tree. The quota root uses the global block reserve, which is fine most of
> the time since we don't expect a lot of updates to the quota root, or to
> be too close to -ENOSPC such that other critical metadata updates need to
> resort to the global reserve.
> 
> However this is not optimal, as not reserving proper space may result in a
> transaction abort due to not reserving space for delayed refs and then
> abusing the use of the global block reserve.
> 
> For example, the following reproducer (which is unlikely to model any
> real world use case, but just to illustrate the problem), triggers such a
> transaction abort due to -ENOSPC when running delayed refs:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/nullb0
>   MNT=/mnt/nullb0
> 
>   umount $DEV &> /dev/null
>   # Limit device to 1G so that it's much faster to reproduce the issue.
>   mkfs.btrfs -f -b 1G $DEV
>   mount -o commit=600 $DEV $MNT
> 
>   fallocate -l 800M $MNT/filler
>   btrfs quota enable $MNT
> 
>   for ((i = 1; i <= 400000; i++)); do
>       btrfs qgroup create 1/$i $MNT
>   done
> 
>   umount $MNT
> 
> When running this, we can see in dmesg/syslog that a transaction abort
> happened:
> 
>   [160436.490890] BTRFS error (device nullb0): failed to run delayed ref for logical 30408704 num_bytes 16384 type 176 action 1 ref_mod 1: -28
>   [160436.493276] ------------[ cut here ]------------
>   [160436.494166] BTRFS: Transaction aborted (error -28)
>   [160436.495088] WARNING: fs/btrfs/extent-tree.c:2247 at btrfs_run_delayed_refs+0xd9/0x110 [btrfs], CPU#4: umount/2495372
>   [160436.497219] Modules linked in: btrfs loop (...)
>   [160436.508357] CPU: 4 UID: 0 PID: 2495372 Comm: umount Tainted: G        W           6.19.0-rc8-btrfs-next-225+ #1 PREEMPT(full)
>   [160436.510497] Tainted: [W]=WARN
>   [160436.511085] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>   [160436.513260] RIP: 0010:btrfs_run_delayed_refs+0xdf/0x110 [btrfs]
>   [160436.514515] Code: 0f 82 ea (...)
>   [160436.518476] RSP: 0018:ffffd511850b7d78 EFLAGS: 00010292
>   [160436.519544] RAX: 00000000ffffffe4 RBX: ffff8f120dad37e0 RCX: 0000000002040001
>   [160436.520893] RDX: 0000000000000002 RSI: 00000000ffffffe4 RDI: ffffffffc090fd80
>   [160436.522245] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffc04d1867
>   [160436.523612] R10: ffff8f18dc1fffa8 R11: 0000000000000003 R12: ffff8f173aa89400
>   [160436.524960] R13: 0000000000000000 R14: ffff8f173aa89400 R15: 0000000000000000
>   [160436.526289] FS:  00007fe59045d840(0000) GS:ffff8f192e22e000(0000) knlGS:0000000000000000
>   [160436.527812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [160436.528868] CR2: 00007fe5905ff2b0 CR3: 000000060710a002 CR4: 0000000000370ef0
>   [160436.530096] Call Trace:
>   [160436.530527]  <TASK>
>   [160436.530916]  btrfs_commit_transaction+0x73/0xc00 [btrfs]
>   [160436.531753]  ? btrfs_attach_transaction_barrier+0x1e/0x70 [btrfs]
>   [160436.532557]  sync_filesystem+0x7a/0x90
>   [160436.533025]  generic_shutdown_super+0x28/0x180
>   [160436.533584]  kill_anon_super+0x12/0x40
>   [160436.534083]  btrfs_kill_super+0x12/0x20 [btrfs]
>   [160436.534560]  deactivate_locked_super+0x2f/0xb0
>   [160436.534983]  cleanup_mnt+0xea/0x180
>   [160436.535388]  task_work_run+0x58/0xa0
>   [160436.535804]  exit_to_user_mode_loop+0xed/0x480
>   [160436.536308]  ? __x64_sys_umount+0x68/0x80
>   [160436.536764]  do_syscall_64+0x2a5/0xf20
>   [160436.537196]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [160436.537780] RIP: 0033:0x7fe5906b6217
>   [160436.538192] Code: 0d 00 f7 (...)
>   [160436.540303] RSP: 002b:00007ffcd87a61f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>   [160436.541133] RAX: 0000000000000000 RBX: 00005618b9ecadc8 RCX: 00007fe5906b6217
>   [160436.541886] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005618b9ecb100
>   [160436.542704] RBP: 0000000000000000 R08: 00007ffcd87a4fe0 R09: 00000000ffffffff
>   [160436.544022] R10: 0000000000000103 R11: 0000000000000246 R12: 00007fe59081626c
>   [160436.544950] R13: 00005618b9ecb100 R14: 0000000000000000 R15: 00005618b9ecacc0
>   [160436.545729]  </TASK>
>   [160436.545988] ---[ end trace 0000000000000000 ]---
> 
> Fix this by changing the qgroup ioctls to use start transaction instead of
> joining so that proper space is reserved for the delayed refs generated
> for the updates to the quota root. This way we don't get any transaction
> abort.
> 

LGTM, thanks!
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ioctl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 38d93dae71ca..9fa4eca4c788 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3680,7 +3680,8 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
>  		}
>  	}
>  
> -	trans = btrfs_join_transaction(root);
> +	/* 2 BTRFS_QGROUP_RELATION_KEY items. */
> +	trans = btrfs_start_transaction(root, 2);
>  	if (IS_ERR(trans)) {
>  		ret = PTR_ERR(trans);
>  		goto out;
> @@ -3752,7 +3753,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
>  		goto out;
>  	}
>  
> -	trans = btrfs_join_transaction(root);
> +	/*
> +	 * 1 BTRFS_QGROUP_INFO_KEY item.
> +	 * 1 BTRFS_QGROUP_LIMIT_KEY item.
> +	 */
> +	trans = btrfs_start_transaction(root, 2);
>  	if (IS_ERR(trans)) {
>  		ret = PTR_ERR(trans);
>  		goto out;
> @@ -3801,7 +3806,8 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
>  		goto drop_write;
>  	}
>  
> -	trans = btrfs_join_transaction(root);
> +	/* 1 BTRFS_QGROUP_LIMIT_KEY item. */
> +	trans = btrfs_start_transaction(root, 1);
>  	if (IS_ERR(trans)) {
>  		ret = PTR_ERR(trans);
>  		goto out;
> -- 
> 2.47.2
> 

