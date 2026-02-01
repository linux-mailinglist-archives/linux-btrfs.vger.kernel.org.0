Return-Path: <linux-btrfs+bounces-21272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGAWH/lAf2nwmQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21272-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 13:03:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99DC5D54
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 13:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C0C3013786
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Feb 2026 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EA33AD8C;
	Sun,  1 Feb 2026 12:02:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEE2D7D41
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Feb 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769947372; cv=none; b=LueVdY0b0DFTNd8He1Rcu1XU8RaO9dLMbgkOYr+P/YfKJjNlZQzBTDpq4Tdr1adxwPJk4S2FrnpyahnlvOv7lYys0Q4WXGY/VZ61kSz0c2/yWREtBnn5OQGfG/2Z03vAcM789QpcSV6WjJcaGgd1DlGRBBdh2/Jnd87D+UXmTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769947372; c=relaxed/simple;
	bh=lN7Auei0uyhMreURT1/trGOIthR845ReUaqC2MZJFuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PF633fVe2njMRdLTN4bIPpCRXrhl5XMiOhfOJPFFv1bEn/C+ey3aoonPKZGnOQYdvyk7I4K4B9U2FzvhgIJD3rGTI8q8xsaEwLtW9FwGH1Zw4TtHWRxAt7EGUIdXtb+yj9ml5Zt+dWVyjjLeXHbo6ovnbOlmUuGTEyfZ1CTSawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from [172.16.223.35] (unknown [222.212.92.118])
	by APP-03 (Coremail) with SMTP id rQCowAAnSeDiQH9p1o5vBw--.19787S2;
	Sun, 01 Feb 2026 20:02:43 +0800 (CST)
Message-ID: <f667717a-1ca2-41c4-bd43-b7149ff74532@mails.ucas.ac.cn>
Date: Sun, 1 Feb 2026 20:02:42 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [BUG] ZONED: Transaction aborted (ENOSPC) during
 auto-reclaim/balance on 6.18.7-200.fc43
From: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <914f64a8-d51c-4424-97dd-f8b917e72acf@mails.ucas.ac.cn>
Content-Language: en-US
Autocrypt: addr=yanqiyu17@mails.ucas.ac.cn; keydata=
 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
 Ywog7hj32UG3g6tAUN7D
In-Reply-To: <914f64a8-d51c-4424-97dd-f8b917e72acf@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSeDiQH9p1o5vBw--.19787S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw1DJF13ZFyrJFWxJr4rGrg_yoW3tF4fpF
	WfKFs093ykJrn3Jw4xWa1UG3s0gr4jyw1UXr97Gry2va13Jw4rWF1Fq34Yg3yDJrWkA3Wq
	vF12q34FvrsrKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVA0820Y
	0xCF62I06xkIj41lx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjTRK38nDUUUU
X-CM-SenderInfo: 51dq1xl1xrlqxpdlz24oxft2wodfhubq/1tbiCQ4FB2l++RRmJAAAs9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanqiyu17@mails.ucas.ac.cn,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21272-lists,linux-btrfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA99DC5D54
X-Rspamd-Action: no action

And for your reference, the output of sudo blkzone report /dev/sda| grep 
-vE '(fu|nw)' is following (full output is too long to paste it here)

   start: 0x020000000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x040000000, len 0x080000, cap 0x080000, wptr 0x074730 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x200000000, len 0x080000, cap 0x080000, wptr 0x074730 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x4ad380000, len 0x080000, cap 0x080000, wptr 0x07fff8 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x4ad400000, len 0x080000, cap 0x080000, wptr 0x07ffe8 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x600200000, len 0x080000, cap 0x080000, wptr 0x07ffb0 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x635280000, len 0x080000, cap 0x080000, wptr 0x07fff8 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x64f700000, len 0x080000, cap 0x080000, wptr 0x07fff8 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x662f80000, len 0x080000, cap 0x080000, wptr 0x07ff70 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x663000000, len 0x080000, cap 0x080000, wptr 0x07ffd0 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x66ec00000, len 0x080000, cap 0x080000, wptr 0x07fff0 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x671880000, len 0x080000, cap 0x080000, wptr 0x07fff8 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x674b00000, len 0x080000, cap 0x080000, wptr 0x04cac0 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x674b80000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x686300000, len 0x080000, cap 0x080000, wptr 0x07ff40 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x686380000, len 0x080000, cap 0x080000, wptr 0x07ff40 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6ba200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6bc500000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6bcd00000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6bdb80000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6bfd80000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6d2000000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x6d3100000, len 0x080000, cap 0x080000, wptr 0x018ca8 reset:0 
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
   start: 0x918580000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]

在 2026/2/1 15:13, Qiyu Yan 写道:
> Hi all,
>
> I am reporting an issue where a Btrfs filesystem on a zoned device 
> forced itself into a read-only state due to an ENOSPC error (-28) 
> during a background block group reclaim/relocation process. The 
> related logs can be found at: 
> https://gist.github.com/karuboniru/4eb8835507f97a6d57f4addf25fab7f7
>
> The environment I am on is Fedora 43 with kernel 
> 6.18.7-200.fc43.x86_64, the drive is WD HC650. The issue happened soon 
> after after upgrading to 6.18 series from 6.17.
>
> The system automatically started relocating block groups (via 
> btrfs_reclaim_bgs_work). During this process, a transaction was 
> aborted with errno -28 (No space left), despite btrfs filesystem usage 
> indicating significant unallocated space and free capacity.
>
> Best,
> Qiyu
>
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> BTRFS: error (device sda state A) in __btrfs_free_extent:3237: 
> errno=-28 No space left
> WARNING: CPU: 16 PID: 472499 at fs/btrfs/extent-tree.c:3237 
> __btrfs_free_extent.isra.0+0x49d/0xc80
> BTRFS info (device sda state EA): forced readonly
> BTRFS error (device sda state EA): failed to run delayed ref for 
> logical 46726206365696 num_bytes 4096 type 184 action 2 ref_mod 1: -28
> ...
>  ? srso_return_thunk+0x5/0x5f
>  btrfs_run_delayed_refs_for_head+0x2b0/0x380
>  ? srso_return_thunk+0x5/0x5f
>  ? btrfs_select_ref_head+0xda/0x140
>  __btrfs_run_delayed_refs+0xb8/0x140
>  btrfs_run_delayed_refs+0x3b/0x120
>  btrfs_start_dirty_block_groups+0x30a/0x5b0
>  ? kmem_cache_alloc_noprof+0x14b/0x5a0
>  btrfs_commit_transaction+0xb1/0xd20
>  ? srso_return_thunk+0x5/0x5f
>  ? start_transaction+0x228/0x840
>  prepare_to_relocate+0x135/0x1d0
>  relocate_block_group+0x6b/0x530
>  ? srso_return_thunk+0x5/0x5f
>  ? do_zone_finish+0x372/0x400
>  btrfs_relocate_block_group+0x256/0x450
>  btrfs_relocate_chunk+0x44/0x170
>  btrfs_reclaim_bgs_work+0x428/0x570
> ...
>
> BTRFS info (device sda state EA): dumping space info:
> BTRFS info (device sda state EA): space_info DATA (sub-group id 0) has 
> 216444928 free, is not full
> BTRFS info (device sda state EA): space_info total=12228040327168, 
> used=10905359462400, pinned=0, reserved=0, may_use=0, readonly=0 
> zone_unusable=1322464419840
> BTRFS info (device sda state EA): space_info METADATA (sub-group id 0) 
> has -34808119296 free, is full
> BTRFS info (device sda state EA): space_info total=918049259520, 
> used=64758857728, pinned=147456, reserved=1421541376, 
> may_use=34808119296, readonly=239616000 zone_unusable=851629096960
> BTRFS info (device sda state EA): space_info SYSTEM (sub-group id 0) 
> has 196608 free, is not full
> BTRFS info (device sda state EA): space_info total=268435456, 
> used=6455296, pinned=114688, reserved=49152, may_use=0, readonly=0 
> zone_unusable=261619712
> BTRFS info (device sda state EA): global_block_rsv: size 536870912 
> reserved 536870912
> BTRFS info (device sda state EA): trans_block_rsv: size 0 reserved 0
> BTRFS info (device sda state EA): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sda state EA): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sda state EA): delayed_refs_rsv: size 4676581195776 
> reserved 34267054080
> BTRFS: error (device sda state EA) in __btrfs_free_extent:3237: 
> errno=-28 No space left
> BTRFS error (device sda state EA): failed to run delayed ref for 
> logical 46726206337024 num_bytes 4096 type 184 action 2 ref_mod 1: -28
> BTRFS: error (device sda state EA) in btrfs_run_delayed_refs:2161: 
> errno=-28 No space left
> BTRFS error (device sda state EA): error relocating chunk 48256373489664
>
> $ sudo btrfs fi us /run/media/cold
> Overall:
>     Device size:          18.19TiB
>     Device allocated:          12.79TiB
>     Device unallocated:           5.40TiB
>     Device missing:             0.00B
>     Device slack:             0.00B
>     Device zone unusable:       1.98TiB
>     Device zone size:         256.00MiB
>     Used:              10.04TiB
>     Free (estimated):           6.60TiB    (min: 3.90TiB)
>     Free (statfs, df):           6.60TiB
>     Data ratio:                  1.00
>     Metadata ratio:              2.00
>     Global reserve:         512.00MiB    (used: 0.00B)
>     Multiple profiles:                no
>
> Data,single: Size:11.12TiB, Used:9.92TiB (89.18%)
>    /dev/sda      11.12TiB
>
> Metadata,DUP: Size:855.00GiB, Used:60.31GiB (7.05%)
>    /dev/sda       1.67TiB
>
> System,DUP: Size:256.00MiB, Used:6.16MiB (2.40%)
>    /dev/sda     512.00MiB
>
> Unallocated:
>    /dev/sda       5.39TiB
>


