Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A575ABDC9
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiICITy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiICITw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:19:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2A2A401
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:19:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5735B336D9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8u4HtklBAPyBnAXcs/8pY2+qVagTDz5ckSkBMpM4b+U=;
        b=Ot/x8y64TkO18VkDV06L8Z5FtpzHDL8H7KskuLJvV7zaibp5ynzGo/aQEiyHr9rAv/LfkH
        HtgftB35kRBOPU9XOZuT/d9IQeRmtAMQCQ75J68j/mdT8S/1BrxFqe9Z5TJoL3rzGDTfny
        j27CKer/A7ZnrF4maxM/WrKatdnU8eE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E704139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gl4iGSQOE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:19:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 0/9] btrfs: scrub: introduce a new family of ioctl, scrub_fs
Date:   Sat,  3 Sep 2022 16:19:20 +0800
Message-Id: <cover.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Depite the write-hole problem of RAID56, scrub is neither RAID56
friendly in the following points:

- Extra IO for RAID56 scrub
  Currently data strips of RAID56 can be read 2x (RAID5) or 3x (RAID6).

  This is caused by the fact we do one-thread per-device scrub.

  Dev 1    |  Data 1  | P(3 + 4) |
  Dev 2    |  Data 2  |  Data 3  |
  Dev 3    | P(1 + 2) |  Data 4  |

  When scrubbing Dev 1, we will read Data 1 (treated no differently than
  SINGLE), then read Parity (3 + 4).
  But to determine if Parity (3 + 4) is correct, we have to read Data 3
  and Data 4.

  On the other hand, Data 3 will also be read by scrubbing Dev 2,
  and Data 4 will also be read by scrubbing Dev 3.

  Thus all data stripes will be read twice, causing slow down in RAID56
  scrubbing.

- No proper progress report for P/Q stripes
  The scrub_progress has no member for P/Q error reporting at all.

  Thus even if we fixed some P/Q error, it will not be reported at all.

To address the above problems, this patchset will introduce a new
family of ioctl, scrub_fs ioctls.

[CORE DESIGN]
The new scrub_fs ioctl will go block group by block group, to scrub the
full fs.

Inside each block group, we go BTRFS_STRIPE_LEN as one scrub unit (will
be enlarged later to improve parallel for RAID0/10).

Then we read the full BTRFS_STRIPE_LEN bytes from each mirror (if there
is an extent inside the range).

The read bios will be submitted to each device at once, so we can still
take advantage of parallel IOs.

But the verification part still only happens inside the scrub thread, no
parallel csum check.

Also this ioctl family will rely on a much larger progress structure,
it's padded to 256 bytes, with parity specific error reporting (not yet
implemented though).

[THE GOOD]
- Every stripe will be iterated at most once
  No double read for data stripes.

- Better error reports for parity mismatch

- No need for complex bio form shaping
  Since we already submit read bios in BTRFS_STRIPE_LEN unit, and wait
  for them to finish, there are only at most nr_copies bios at fly.
  (For later RAID0/10 optimization, it will be nr_stripes)

  This behavior will reduce the IOPS usage by nature, thus no need to
  do any bio form shaping.

  This greatly reduce the code size, just check how much code are spent
  for bio form shaping in the old scrub code.

- Less block groups marked for read-only
  Now there is at most one block group marked read-only for scrub,
  reducing the possibility of ENOSPC during scrub.

- Can check NODATASUM data between different copies
  Now we can compare NODATASUM data between different copies, to
  determine if they match.

[THE BAD]
- Slower for SINGLE profile
  If some one is using SINGLE profile on multiple devices, scrub_fs will
  slower.

  Dev 1:   | SINGLE BG 1 |
  Dev 2:   | SINGLE BG 2 |
  Dev 3:   | SINGLE BG 3 |

  The existing scrub code will scrub single BG 1~3 at the same time.
  But the new scrub_fs will scrub single BG 1 first, then 2, then 3.
  Causing much slower scrub for such case.

  Although I'd argue, for above case, the user should go RAID0 anyway.

[THE UGLY]
Since this is just a proof-of-concept patchset, it lacks the following
functionality/optimization:

- Slower RAID0/RAID10 scrub.
  Since we only scrub BTRFS_STRIPE_LEN, it will not utilize all devices
  from RAID0/10.
  Although it can be easily enhanced by enlarging the scrub unit to a
  full stripe.

- No RAID56 support
  Ironically.

- Very basic btrfs-progs support
  Really only calls the ioctl and gives an output.
  No background scrub or scrub status file support.

- No drop-in full fstests run yet


Qu Wenruo (9):
  btrfs: introduce BTRFS_IOC_SCRUB_FS family of ioctls
  btrfs: scrub: introduce place holder for btrfs_scrub_fs()
  btrfs: scrub: introduce a place holder helper scrub_fs_iterate_bgs()
  btrfs: scrub: introduce place holder helper scrub_fs_block_group()
  btrfs: scrub: add helpers to fulfill csum/extent_generation
  btrfs: scrub: submit and wait for the read of each copy
  btrfs: scrub: implement metadata verification code for scrub_fs
  btrfs: scrub: implement data verification code for scrub_fs
  btrfs: scrub: implement recoverable sectors report for scrub_fs

 fs/btrfs/ctree.h           |    4 +
 fs/btrfs/disk-io.c         |   83 ++-
 fs/btrfs/disk-io.h         |    2 +
 fs/btrfs/ioctl.c           |   45 ++
 fs/btrfs/scrub.c           | 1424 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  173 +++++
 6 files changed, 1705 insertions(+), 26 deletions(-)

-- 
2.37.3

