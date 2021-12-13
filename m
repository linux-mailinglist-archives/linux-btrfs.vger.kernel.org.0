Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADDE472CE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 14:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbhLMNLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 08:11:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41306 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhLMNLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 08:11:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F39CB1F3BA
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639401073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ROcWf4YFeUxBKOuaaLWsy/azmfGgqbHHcrl5rmIlmvw=;
        b=I4GV7sraK53r/fNu9q+ryBpal2sZuGDkP9TPkNTULm6SFRLmRLjfgEdhti6Lm5mPQYLxjw
        7blD+bge8SA2HzyzfVZrjW6wc/oZ61fYD4T8khLNKXLv76KWeHxt6HSKjRgszYqLlxbkFa
        CGw88xoRaPHdBQr1wo6T+um0zOnncb0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 542A913D6E
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3JP7B3BGt2EFCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 13:11:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: use btrfs_path::reada to replace the
Date:   Mon, 13 Dec 2021 21:10:51 +0800
Message-Id: <20211213131054.102526-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEMS]
The metadata readahead code is introduced in 2011 (surprisingly, the
commit message even contains changelog), but now there is only one user
for it, and even for the only one user, the readahead mechanism can't
provide all it needs:

- No support for commit tree readahead
  Only support readahead on current tree.

- Bad layer separation
  To manage on-fly bios, btrfs_reada_add() mechanism internally manages
  a kinda complex zone system, and it's bind to per-device.

  This is against the common layer separation, as metadata should all be
  in btrfs logical address space, should not be bound to device physical
  layer.

  In fact, this is the cause of all recent reada related bugs.

- No caller for asynchronous metadata readahead
  Even btrfs_reada_add() is designed to be fully asynchronous, scrub
  only calls it in a synchronous way (call btrfs_reada_add() and
  immediately call btrfs_reada_wait()).
  Thus rendering a lot of code unnecessary.

[ALTERNATIVE]
On the other hand, we have btrfs_path::reada mechanism, which is already
used by tons of btrfs sub-systems like send.

[MODIFICATION]
This patch will use btrfs_path::reada to replace btrfs_reada_add()
mechanism.

[BENCHMARK]
The conclusion looks like this:

For the worst case (no dirty metadata, slow HDD), there will be around 5%
performance drop for scrub.
For other cases (even SATA SSD), there is no distinguishable performance
difference.

The number is reported scrub speed, in MiB/s.
The resolution is limited by the reported duration, which only has a
resolution of 1 second.

	Old		New		Diff
SSD	455.3		466.332		+2.42%
HDD	103.927 	98.012		-5.69%


[BENCHMARK DETAILS]
Both tests are done in the same host and VM, the VM has one dedicated
SSD and one dedicated HDD attached to it (virtio driver though)

Host:
CPU:	5900X
RAM:	DDR4 3200MT, no ECC

	During the benchmark, there is no other active other than light
	DE operations.

VM:
vCPU:	16x
RAM:	4G

	The VM kernel doesn't have any heavy debug options to screw up
	the benchmark result.

Test drives:
SSD:	500G SATA SSD
	Crucial CT500MX500SSD1
	(With quite some wear, as it's my main test drive for fstests)

HDD:	2T 5400rpm SATA HDD (device-managed SMR)
	WDC WD20SPZX-22UA7T0
	(Very new, invested just for this benchmark)

Filesystem contents:
For filesystems on SSD and HDD, they are generated using the following
fio job file:

  [scrub-populate]
  directory=/mnt/btrfs
  nrfiles=16384
  openfiles=16
  filesize=2k-512k
  readwrite=randwrite
  ioengine=libaio
  fallocate=none
  numjobs=4
  
Then randomly remove 4096 files (1/16th of total files) to create enough
gaps in extent tree.

Finally run scrub on each filesystem 5 times, with cycle mount and
module reload between each run.

Full result can be fetched here:
https://docs.google.com/spreadsheets/d/1cwUAlbKPfp4baKrS92debsCt6Ejqvxr_Ylspj_SDFT0/edit?usp=sharing

[CHANGELOG]
RFC->v1:
- Add benchmark result
- Add extent tree readahead using btrfs_path::reada

Qu Wenruo (3):
  btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
  btrfs: remove reada mechanism
  btrfs: use btrfs_path::reada for scrub extent tree readahead

 fs/btrfs/Makefile      |    2 +-
 fs/btrfs/ctree.h       |   25 -
 fs/btrfs/dev-replace.c |    5 -
 fs/btrfs/disk-io.c     |   20 +-
 fs/btrfs/extent_io.c   |    3 -
 fs/btrfs/reada.c       | 1086 ----------------------------------------
 fs/btrfs/scrub.c       |   65 +--
 fs/btrfs/super.c       |    1 -
 fs/btrfs/volumes.c     |    7 -
 fs/btrfs/volumes.h     |    7 -
 10 files changed, 18 insertions(+), 1203 deletions(-)
 delete mode 100644 fs/btrfs/reada.c

-- 
2.34.1

