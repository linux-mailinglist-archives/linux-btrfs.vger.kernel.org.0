Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71CB6273D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiKNA1M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 19:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNA04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 19:26:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AEBE001
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 16:26:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B08171FBA5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668385612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QqOEXIBkBYrXnKXqokzTt9amltzXjruoqdwQfUVD5Jw=;
        b=AlpILxGZo8wrVZihP+XA/sdXyP8BdaDA7rZ3iY2q0inC8jNAIaNQUa4g00BS1sLTA2iAP0
        0mJ4sHwREoNLLf1iJlnTqJsbZ3ys7P3Wn/+9tCdeuhPg5lrMeiTQZN+E9jHqojIYVCp+56
        gGQH25MaxZFFxeSTLxFVdNvT7hGM0Rw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02E9A13A18
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ahbWLkuLcWN9dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 00:26:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: raid56: destructive RMW fix for RAID5 data profiles
Date:   Mon, 14 Nov 2022 08:26:29 +0800
Message-Id: <cover.1668384746.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[DESTRUCTIVE RMW]
Btrfs (and generic) RAID56 is always vulnerable against destructive RMW.

Such destructive RMW can happen when one of the data stripe is
corrupted, then a sub-stripe write into other data stripes happens, like
the following:


  Disk 1: data 1 |0x000000000000| <- Corrupted
  Disk 2: data 2 |0x000000000000|
  Disk 2: parity |0xffffffffffff|

In above case, if we write data into disk 2, we will got something like
this:

  Disk 1: data 1 |0x000000000000| <- Corrupted
  Disk 2: data 2 |0x000000000000| <- New '0x00' writes
  Disk 2: parity |0x000000000000| <- New Parity.

Since the new parity is calculated using the new writes and the
corrupted data, we lost the chance to recovery data stripe 1, and that
corruption will forever be there.

[SOLUTION]
This series will close the destructive RMW problem for RAID5 data
profiles by:

- Read the full stripe before doing sub-stripe writes.

- Also fetch the data csum for the data stripes:

- Verify every data sector against their data checksum

  Now even with above corrupted data, we know there are some data csum
  mismatch, we will have an error bitmap to record such mismatches.
  We treat read error (like missing device) and data csum mismatch the
  same.

  If there is no csum (NODATASUM or metadata), we just trust the data
  unconditionally.

  So we will have an error bitmap for above corrupted case like this:

  Disk 1: data 1: |XXXXXXX|
  Disk 2: data 2: |       |

- Rebuild just as usual
  Since data 1 has all its sectors marked error in the error bitmap,
  we rebuild the sectors of data stripe 1.

- Verify the repaired sectors against their csum
  If csum matches, we can continue.
  Or we error out.

- Continue the RMW cycle using the repaired sectors
  Now we have correct data and will re-calculate the correct parity.

[TODO]
- Iterate all RAID6 combinations
  Currently we don't try all combinations of RAID6 during the repair.
  Thus for RAID6 we treat it just like RAID5 in RMW.

  Currently the RAID6 recovery combination is only exhausted during
  recovery path, relying on the caller the increase the mirror number.

  Can be implemented later for RMW path.

- Write back the repaired sectors
  Currently we don't write back the repaired sectors, thus if we read
  the corrupted sectors, we rely on the recover path, and since the new
  parity is calculated using the recovered sectors, we can get the
  correct data without any problem.

  But if we write back the repaired sectors during RMW, we can save the
  reader some time without going into recovery path at all.

  This is just a performance optimization, thus I believe it can be
  implemented later.

Qu Wenruo (5):
  btrfs: use btrfs_dev_name() helper to handle missing devices better
  btrfs: refactor btrfs_lookup_csums_range()
  btrfs: introduce a bitmap based csum range search function
  btrfs: raid56: prepare data checksums for later RMW data csum 
    verification
  btrfs: raid56: do data csum verification during RMW cycle

 fs/btrfs/check-integrity.c |   2 +-
 fs/btrfs/dev-replace.c     |  15 +--
 fs/btrfs/disk-io.c         |   2 +-
 fs/btrfs/extent-tree.c     |   2 +-
 fs/btrfs/extent_io.c       |   3 +-
 fs/btrfs/file-item.c       | 196 ++++++++++++++++++++++++++----
 fs/btrfs/file-item.h       |   8 +-
 fs/btrfs/inode.c           |   5 +-
 fs/btrfs/ioctl.c           |   4 +-
 fs/btrfs/raid56.c          | 243 ++++++++++++++++++++++++++++++++-----
 fs/btrfs/raid56.h          |  12 ++
 fs/btrfs/relocation.c      |   4 +-
 fs/btrfs/scrub.c           |  28 ++---
 fs/btrfs/super.c           |   2 +-
 fs/btrfs/tree-log.c        |  15 ++-
 fs/btrfs/volumes.c         |  16 +--
 fs/btrfs/volumes.h         |   9 ++
 17 files changed, 451 insertions(+), 115 deletions(-)

-- 
2.38.1

