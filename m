Return-Path: <linux-btrfs+bounces-18949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD58C58A33
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27FA3361E6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71214320A01;
	Thu, 13 Nov 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F4JcoRsw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A89cMZoK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F4JcoRsw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A89cMZoK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8893148B7
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049073; cv=none; b=C5hP4thfOvSo2kHqIpcw14Zd075jdcLUhZrvIWx3Rt3e63O0jMICAsElvkTSIT5WMWNTe0iuGKhPbSFN3KyMIYRuauXPpjWbaAzi66hBOyNZT1/GIkOd0EaAUtrUWIi7ZNMx5dbEkwExHtxc2IZHBvOfASuM44pz4N1qPBL9+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049073; c=relaxed/simple;
	bh=28ep1hq1w/JpK1zLrgTU7lD+m3PrVrfndJlhkMn4Izg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO+uvEZV9Ol4tFqoafcTNkTgtTNCA245HcZCcBaxG0Lwc1UAuBwK8AloqsoAdIXbMuA2CwME60ZLNc7CyJSrZ5B00L0/u5wA1Kb0Z1f7KKaPv9YzakRAa6b3Jv0GZRvhj8HfKdOAa3FndiKCuwkmteWqqAWZA5lAmZzooxCkFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F4JcoRsw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A89cMZoK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F4JcoRsw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A89cMZoK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A2181F395;
	Thu, 13 Nov 2025 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763049068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+lSi6pkLqsIGE6e7a4kmhZhjGsskfXhK2Gg5BoI2+w=;
	b=F4JcoRsw9YxfsmP4hI9VNhFqGMPaZFWcHb6V/w7tuLwIXdGUED19KZi+nEtnvioHDAxE/q
	rFVLPo0wv0aqPa3nUBaF1mHu4MydBBERI6OM3pi/w4d2BWijvql60vzz8Nly8pHjsjZuuN
	qgGdDV0rGPllwhO7xLeExaUSS4skxYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763049068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+lSi6pkLqsIGE6e7a4kmhZhjGsskfXhK2Gg5BoI2+w=;
	b=A89cMZoKIPjB3C0VP2rMDXafjXgjJitwEWtxERrwdBoRbzkmuhsk+ntOBAX0CUDqtKFra9
	WCsomc1CmF2IUaCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F4JcoRsw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A89cMZoK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763049068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+lSi6pkLqsIGE6e7a4kmhZhjGsskfXhK2Gg5BoI2+w=;
	b=F4JcoRsw9YxfsmP4hI9VNhFqGMPaZFWcHb6V/w7tuLwIXdGUED19KZi+nEtnvioHDAxE/q
	rFVLPo0wv0aqPa3nUBaF1mHu4MydBBERI6OM3pi/w4d2BWijvql60vzz8Nly8pHjsjZuuN
	qgGdDV0rGPllwhO7xLeExaUSS4skxYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763049068;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+lSi6pkLqsIGE6e7a4kmhZhjGsskfXhK2Gg5BoI2+w=;
	b=A89cMZoKIPjB3C0VP2rMDXafjXgjJitwEWtxERrwdBoRbzkmuhsk+ntOBAX0CUDqtKFra9
	WCsomc1CmF2IUaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 465633EA61;
	Thu, 13 Nov 2025 15:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jzT6EGz+FWlFdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 15:51:08 +0000
Date: Thu, 13 Nov 2025 16:51:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: riteshh@linux.ibm.com, linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [linux-next20251112]Kernel OOPs while running btrfs/023 test case
Message-ID: <20251113155107.GQ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <83749167-c479-46df-a749-e3f65ffc3964@linux.ibm.com>
 <65b02403-25e5-4ec3-8577-de1409b0a765@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65b02403-25e5-4ec3-8577-de1409b0a765@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7A2181F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,gmx.com,suse.com,canb.auug.org.au];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Nov 13, 2025 at 06:47:43PM +0530, Venkat Rao Bagalkote wrote:
> On 13/11/25 6:21 pm, Venkat Rao Bagalkote wrote:
> > Greetings!!!
> >
> > IBM CI has reported a kernel crash while running btrfs/023 test from 
> > xfstest suite on IBM Power11 system.
> >
> >
> > Traces:
> > [  184.714500] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> > devid 1 transid 8 /dev/loop1 (7:1) scanned by mkfs.btrfs (2697)
> > [  184.714612] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> > devid 2 transid 8 /dev/loop2 (7:2) scanned by mkfs.btrfs (2697)
> > [  184.714731] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> > devid 3 transid 8 /dev/loop3 (7:3) scanned by mkfs.btrfs (2697)
> > [  184.714825] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> > devid 4 transid 8 /dev/loop4 (7:4) scanned by mkfs.btrfs (2697)
> > [  184.714918] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> > devid 5 transid 8 /dev/loop5 (7:5) scanned by mkfs.btrfs (2697)
> > [  184.720659] BTRFS info (device loop1): first mount of filesystem 
> > b8c762d5-3f1a-4020-bca9-2e7e107e5363
> > [  184.720694] BTRFS info (device loop1): using crc32c (crc32c-lib) 
> > checksum algorithm
> > [  184.720708] BTRFS info (device loop1): forcing free space tree for 
> > sector size 4096 with page size 65536
> > [  184.725011] BTRFS info (device loop1): checking UUID tree
> > [  184.725060] BTRFS info (device loop1): enabling ssd optimizations
> > [  184.725068] BTRFS info (device loop1): turning on async discard
> > [  184.725075] BTRFS info (device loop1): enabling free space tree
> > [  184.735050] BUG: Unable to handle kernel data access at 
> > 0x6696fffdda1ea4c2
> > [  184.735072] Faulting instruction address: 0xc0000000007bd030
> > [  184.735087] Oops: Kernel access of bad area, sig: 11 [#1]
> > [  184.735101] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> > [  184.735118] Modules linked in: loop nft_fib_inet nft_fib_ipv4 
> > nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
> > nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
> > nf_defrag_ipv4 bonding tls ip_set rfkill nf_tables sunrpc nfnetlink 
> > pseries_rng vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi 
> > ibmveth scsi_transport_srp pseries_wdt
> > [  184.735316] CPU: 22 UID: 0 PID: 1948 Comm: systemd-udevd Kdump: 
> > loaded Tainted: G    B               6.18.0-rc5-next-20251112 #1 
> > VOLUNTARY
> > [  184.735342] Tainted: [B]=BAD_PAGE
> > [  184.735352] Hardware name: IBM,9080-HEX Power11 (architected) 
> > 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> > [  184.735369] NIP:  c0000000007bd030 LR: c0000000007bcef4 CTR: 
> > c000000000902824
> > [  184.735386] REGS: c00000006fdb7910 TRAP: 0380   Tainted: G B       
> >       (6.18.0-rc5-next-20251112)
> > [  184.735404] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> > 28004402  XER: 20040000
> > [  184.735460] CFAR: c0000000007bcf98 IRQMASK: 0
> > [  184.735460] GPR00: c0000000007bcef4 c00000006fdb7bb0 
> > c0000000026aa100 0000000000000000
> > [  184.735460] GPR04: 0000000000000cc0 000000013470ff60 
> > 00000000000006f0 c0000009906ff4f0
> > [  184.735460] GPR08: 669164fddb1e9c02 0000000000000800 
> > 000000098d420000 0000000000000000
> > [  184.735460] GPR12: c000000000902824 c000000991e0e700 
> > 0000000000000000 0000000000000000
> > [  184.735460] GPR16: 0000000000000000 0000000000000000 
> > 0000000000000000 0000000000000000
> > [  184.735460] GPR20: 0000000000000000 0000000000000000 
> > 0000000000000000 0000000000000000
> > [  184.735460] GPR24: 00000000000006ef 0000000000001000 
> > ffffffffffffffff c00c000000402680
> > [  184.735460] GPR28: c0000000008f312c 0000000000000cc0 
> > 6696fffdda1e9cc2 c00000000701e880
> > [  184.735688] NIP [c0000000007bd030] kmem_cache_alloc_noprof+0x4ac/0x708
> > [  184.735711] LR [c0000000007bcef4] kmem_cache_alloc_noprof+0x370/0x708
> > [  184.735729] Call Trace:
> > [  184.735738] [c00000006fdb7bb0] [c0000000007bcef4] 
> > kmem_cache_alloc_noprof+0x370/0x708 (unreliable)
> > [  184.735766] [c00000006fdb7c30] [c0000000008f312c] 
> > getname_flags.part.0+0x54/0x30c
> > [  184.735793] [c00000006fdb7c80] [c0000000009028a0] 
> > sys_unlinkat+0x7c/0xe4
> > [  184.735814] [c00000006fdb7cc0] [c000000000039d50] 
> > system_call_exception+0x1e0/0x450
> > [  184.735839] [c00000006fdb7e50] [c00000000000d05c] 
> > system_call_vectored_common+0x15c/0x2ec
> > [  184.735866] ---- interrupt: 3000 at 0x7fff9df366bc
> > [  184.735881] NIP:  00007fff9df366bc LR: 00007fff9df366bc CTR: 
> > 0000000000000000
> > [  184.735897] REGS: c00000006fdb7e80 TRAP: 3000   Tainted: G B       
> >       (6.18.0-rc5-next-20251112)
> > [  184.735913] MSR:  800000000280f033 
> > <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004402  XER: 00000000
> > [  184.735989] IRQMASK: 0
> > [  184.735989] GPR00: 0000000000000124 00007fffe0b3a3a0 
> > 00007fff9e037d00 0000000000000006
> > [  184.735989] GPR04: 000000013470ff60 0000000000000000 
> > 0000000000001000 00007fff9e0314b8
> > [  184.735989] GPR08: 0000000000000271 0000000000000000 
> > 0000000000000000 0000000000000000
> > [  184.735989] GPR12: 0000000000000000 00007fff9e8c4ca0 
> > 00000001161e5a78 00007fffe0b3ab10
> > [  184.735989] GPR16: 0000000000000003 0000000000000000 
> > 00000001161aaed0 00000001161e9750
> > [  184.735989] GPR20: 00007fffe0b3a780 00000001161eb260 
> > 00000001161eb320 0000000000000008
> > [  184.735989] GPR24: 00000001347061c0 0000000000000000 
> > 0000000000000009 00000001347061c0
> > [  184.735989] GPR28: 0000000000000006 00007fffe0b3a53c 
> > 0000000134715740 0000000000100000
> > [  184.736216] NIP [00007fff9df366bc] 0x7fff9df366bc
> > [  184.736231] LR [00007fff9df366bc] 0x7fff9df366bc
> > [  184.736251] ---- interrupt: 3000
> > [  184.736262] Code: f8610030 4082fccc 4bfffc28 2c3e0000 4182ff98 
> > 2c3b0000 4182ff90 60000000 3b40ffff 813f0030 e91f00c0 38d80001 
> > <7f7e482a> 7d3e4a14 79270022 552ac03e
> > [  184.736362] ---[ end trace 0000000000000000 ]---
> >

Thanks for the report.

> Mostly the issue got introduced by one of the below three commits. As 
> reverting these three, this issue is not seen.
> 
> 
> 9299051573d9 e8ea54f86241 cd93c0aad7e3

9299051573d9 btrfs: enable encoded read/write/send for bs > ps cases
e8ea54f86241 btrfs: make read verification handle bs > ps cases without large folios
cd93c0aad7e3 btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios

