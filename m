Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32BA5FE953
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJNHRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNHRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 03:17:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57DF32D94
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 00:17:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 660081F383
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665731851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wng2OOsY7Tc0AtLoMCoPZRZjddAaOh6SkVp76Yi74Bc=;
        b=IyKwymtmQBs4SKMXd+6juTDL3CBR37Itw07MB0yzrc5DWyyzbRtigAleCGqdvXsE1rc4AV
        SeAkprYRftpPcLQDEcLWyWpEZ/JH7AexESFygR823h05bIm/GNg+LhkVoygP+DrpPmzfWv
        xLcJXiCFWagQb44GH/t1yFJGzg7TOfQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A73A313451
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VZumGgoNSWOsUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/5] btrfs: raid56: do full stripe data checksum verification and recovery at RMW time
Date:   Fri, 14 Oct 2022 15:17:08 +0800
Message-Id: <cover.1665730948.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing problem for all RAID56 (not only btrfs RAID56),
that if we have corrupted data on-disk, and we do a RMW using that
corrupted data, we lose the chance of recovery.

Since new parity is calculated using the corrupted sector, we will never
be able to recovery the old data.

However btrfs has data checksum to save the day here, if we do a full
scrub level verification at RMW time, we can detect the corrupted data
before we do any write.

Then do the proper recovery, data checksum recheck, and recovery the old
data and call it a day.

This series is going to add such ability, currently there are the
following limitations:

- Only works for full stripes without a missing device
  The code base is already here for a missing device + a corrupted
  sector case of RAID6.

  But for now, I don't really want to test RAID6 yet.

- We only handles data checksum verification
  Metadata verification will be much more complex, and in the long run
  we will only recommend metadata RAID1C3/C4 profiles to compensate
  RAID56 data profiles.

  Thus we may never support metadata verification for RAID56.

- If we found corrupted sectors which can not be repaired, we fail
  the whole bios for the full stripe
  This is to avoid further data corruption, but in the future we may
  just continue with corrupte data.

  This will need extra work to rollback to the original corrupte data
  (as the recovery process will change the content).

- Way more overhead for substripe write RMW cycle
  Now we need to:

  * Fetch the datacsum for the full stripe
  * Verify the datacsum
  * Do RAID56 recovery (if needed)
  * Verify the recovered data (if needed)

  Thankfully this only affects uncached sub-stripe writes.
  The successfully recovered data can be cached for later usage.

- Will not writeback the recovered data during RMW
  Thus we still need to go back to recovery path to recovery.

  This can be later enhanced to let RMW to write the full stripe if
  we did some recovery during RMW.


- May need further refactor to change how we handle RAID56 workflow
  Currently we use quite some workqueues to handle RAID56, and all
  work are delayed.

  This doesn't look sane to me, especially hard to read (too many jumps
  just for a full RMW cycle).

  May be a good idea to make it into a submit-and-wait workflow.

[REASON for RFC]
Although the patchset does not only passed RAID56 test groups, but also
passed my local destructive RMW test cases, some of the above limitations
need to be addressed.

And whther the trade-off is worthy may still need to be discussed.

Qu Wenruo (5):
  btrfs: refactor btrfs_lookup_csums_range()
  btrfs: raid56: refactor __raid_recover_end_io()
  btrfs: introduce a bitmap based csum range search function
  btrfs: raid56: prepare data checksums for later sub-stripe
    verification
  btrfs: raid56: do full stripe data checksum verification before RMW

 fs/btrfs/ctree.h      |   8 +-
 fs/btrfs/file-item.c  | 196 ++++++++++++--
 fs/btrfs/inode.c      |   6 +-
 fs/btrfs/raid56.c     | 608 +++++++++++++++++++++++++++++++-----------
 fs/btrfs/raid56.h     |  12 +
 fs/btrfs/relocation.c |   4 +-
 fs/btrfs/scrub.c      |   8 +-
 fs/btrfs/tree-log.c   |  16 +-
 8 files changed, 664 insertions(+), 194 deletions(-)

-- 
2.37.3

