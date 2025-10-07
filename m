Return-Path: <linux-btrfs+bounces-17499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A50BC050F
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 08:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5793C1E62
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1720521FF48;
	Tue,  7 Oct 2025 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVu3MBFF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC934BA4B
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818096; cv=none; b=KFgFRMEHln/1Et6bqryK2llTiY6UatWpqosOpZrnpwHiEbQVK6fRRBiEQitsPU6gqHpO9yN4mQU/lDsk38WcrPeaf9PkYH77zdB2KAE+70SLJB6JovoJ7J2ObFZPahV/JDzcyEByQdBVuuw2UCsennuq1ofMkrAKDiTaZv4/h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818096; c=relaxed/simple;
	bh=SUoCxyMQz9tG0RfHT65OXjD1s43DvSt3ppIvbM7isf8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FmZc+MUEoBnd2e9igbm7DHZxM3W/fT8FrnmIEV0sNklJqDIFD1i3sejfF0hFbctKInQTjLN05cEnbDaZsB5HT/dfIceac/+XHwwRf2T4roecR+sqvCAMpxKnC4RKeFdsy2xCJwPnEpkYZ76SHqQTHLnts/+f9PuGnt616vE3QLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fVu3MBFF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=kGEtaM4J50fHbwda35T5Phxz7BWZhvdY1eK9ZdD1TaE=; b=fVu3MBFFFDbnAE5pbrpxGW0TdI
	LCdm0nNx9zJyKea0JlXWjpZcUKgTLikufCo021Crw6nscy77Gi/ubu58vvx/Q3uDW0NJhCC4UiJDu
	iIggbw+/rCdCSGlG1W/vK3nSBBqtYwKjGEednYK0efc3L2o7D8kJ7S5dQvUHl3cbnbMcbV6wrBXOk
	mQrNV1/TBvpy65Nz4x0C63bbWdH2VqTxByCH0B69nGhAT49ac2gEqZdivQIOboCaj3xjmu+EW2ZSZ
	G36OO7TMJuWCpLqm0dasJhny2XQyHMzweC5pDF4R/4SK2owyntwvljraYeRBKF9e3zLaHsCkTusx/
	n7pTx7jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v614o-00000001LiS-1y5Q
	for linux-btrfs@vger.kernel.org;
	Tue, 07 Oct 2025 06:21:34 +0000
Date: Mon, 6 Oct 2025 23:21:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux-btrfs@vger.kernel.org
Subject: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Message-ID: <aOSxbkdrEFMSMn5O@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

At least in my usual x86_64 test VM:

zbd/009 (test gap zone support with BTRFS)                  
[   21.102324] run blktests zbd/009 at 2025-10-07 06:10:44
[   21.251500] sd 3:0:0:0: [sda] Synchronizing SCSI cache
[   21.413634] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw )
[   21.414056] scsi host3: scsi_debug: version 0191 [20210520]
[   21.414056]   dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
[   21.415307] scsi 3:0:0:0: Direct-Access-ZBC Linux    scsi_debug 0191 PQ: 0 ANSI: 7
[   21.416384] scsi 3:0:0:0: Power-on or device reset occurred
[   21.416981] sd 3:0:0:0: Attached scsi generic sg1 type 20
[   21.417533] sd 3:0:0:0: [sda] Host-managed zoned block device
[   21.418153] sd 3:0:0:0: [sda] 262144 4096-byte logical blocks: (1.07 GB/1.00 GiB)
[   21.418676] sd 3:0:0:0: [sda] Write Protect is off
[   21.419017] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   21.419685] sd 3:0:0:0: [sda] permanent stream count = 5
[   21.420158] sd 3:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[   21.420593] sd 3:0:0:0: [sda] Optimal transfer size 4194304 bytes
[   21.421261] sd 3:0:0:0: [sda] 256 zones of 1024 logical blocks
[   21.456700] sd 3:0:0:0: [sda] Attached SCSI disk
[   21.523845] BTRFS: device fsid 9bcd6f4c-db2e-44d7-8597-4eb5774c1460 devid 1 transid 6 /dev/s)
[   21.528211] BTRFS info (device sda): first mount of filesystem 9bcd6f4c-db2e-44d7-8597-4eb570
[   21.528623] BTRFS info (device sda): using crc32c (crc32c-lib) checksum algorithm
[   21.530206] BTRFS info (device sda): host-managed zoned block device /dev/sda, 256 zones of s
[   21.530663] BTRFS info (device sda): zoned mode enabled with zone size 4194304
[   21.532601] BTRFS info (device sda): checking UUID tree
[   21.532909] BTRFS info (device sda): enabling ssd optimizations
[   21.533145] BTRFS info (device sda): enabling free space tree

[  242.795457] INFO: task kworker/u8:4:859 blocked for more than 120 seconds.
[  242.796028]       Tainted: G                 N  6.17.0+ #4047
[  242.796426] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.796941] task:kworker/u8:4    state:D stack:0     pid:859 tgid:859   ppid:2      task_f0
[  242.797667] Workqueue: writeback wb_workfn (flush-btrfs-2)
[  242.798065] Call Trace:
[  242.798227]  <TASK>
[  242.798369]  __schedule+0x524/0xb60
[  242.798601]  schedule+0x29/0xe0
[  242.798804]  io_schedule+0x4b/0x70
[  242.799024]  folio_wait_bit_common+0x126/0x390
[  242.799300]  ? filemap_get_folios_tag+0x247/0x2a0
[  242.800054]  ? __pfx_wake_page_function+0x10/0x10
[  242.800354]  extent_write_cache_pages+0x5c6/0x9c0
[  242.800631]  ? stack_depot_save_flags+0x29/0x870
[  242.800904]  ? set_track_prepare+0x45/0x70
[  242.801145]  ? __kmalloc_noprof+0x3a7/0x4e0
[  242.801391]  ? virtqueue_add_sgs+0x308/0x720
[  242.801644]  ? virtblk_add_req+0x81/0xe0
[  242.801875]  ? virtblk_add_req_batch+0x4b/0x100
[  242.802140]  ? virtio_queue_rqs+0x133/0x180
[  242.802385]  ? blk_mq_dispatch_queue_requests+0x155/0x180
[  242.802697]  ? blk_mq_flush_plug_list+0x73/0x160
[  242.802967]  ? preempt_count_add+0x4d/0xb0
[  242.803210]  btrfs_writepages+0x70/0x120
[  242.803636]  do_writepages+0xc5/0x160
[  242.803870]  __writeback_single_inode+0x3c/0x330
[  242.804154]  writeback_sb_inodes+0x21a/0x4d0
[  242.804436]  __writeback_inodes_wb+0x47/0xe0
[  242.804758]  wb_writeback+0x19a/0x310
[  242.805029]  wb_workfn+0x348/0x440
[  242.805248]  process_one_work+0x169/0x320
[  242.805487]  worker_thread+0x246/0x390
[  242.805711]  ? _raw_spin_unlock_irqrestore+0x1d/0x40
[  242.806003]  ? __pfx_worker_thread+0x10/0x10
[  242.806253]  kthread+0x106/0x220
[  242.806454]  ? __pfx_kthread+0x10/0x10
[  242.806683]  ? __pfx_kthread+0x10/0x10
[  242.806915]  ret_from_fork+0x11d/0x160
[  242.807145]  ? __pfx_kthread+0x10/0x10
[  242.807646]  ret_from_fork_asm+0x1a/0x30
[  242.807904]  </TASK>


