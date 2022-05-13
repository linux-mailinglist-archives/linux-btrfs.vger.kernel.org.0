Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC0525DA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378344AbiEMIej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378323AbiEMIeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:34:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8664BD0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:34:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C656F1F45F
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652430874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JotUGzWA5d2xTy2NPHj0R8Ai/TdljhZeBsJEjaZItJY=;
        b=WyY4TF0qZmKdMmWrOmyxgXK2Uqxlij4QG7GijM+xfXPUqiOk5Dk3Rgoipx4njPndGt205P
        ON9b26VTC1ZRh8Xlx0oZ3lkMLVErfJkkwQOJrxlmbu58y3mh2NR+9RwXKRWV002hqIvVx0
        Vdm19cz3d8hXbWA9xWdZQrLyw7U02ig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26B8313446
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zwp+OBkYfmI2YQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 08:34:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: cleanups and preparation for the incoming RAID56J features
Date:   Fri, 13 May 2022 16:34:27 +0800
Message-Id: <cover.1652428644.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since I'm going to introduce two new chunk profiles, RAID5J and RAID6J
(J for journal), if we're relying on ad-hoc if () else if () branches to
calculate thing like number of p/q stripes, it will cause a lot of
problems.

In fact, during my development, I have hit tons of bugs related to this.

One example is alloc_rbio(), it will assign rbio->nr_data, if we forgot
to update the check for RAID5 and RAID6 profiles, we will got a bad
nr_data == num_stripes, and screw up later writeback.

90% of my suffering comes from such ad-hoc usage doing manual checks on
RAID56.

Another example is, scrub_stripe() which due to the extra per-device
reservation, @dev_extent_len is no longer the same the data stripe
length calculated from extent_map.

So this patchset will do the following cleanups preparing for the
incoming RAID56J (already finished coding, functionality and on-disk
format are fine, although no journal yet):

- Calculate device stripe length in-house inside scrub_stripe()
  This removes one of the nasty mismatch which is less obvious.

- Use btrfs_raid_array[] based calculation instead of ad-hoc check
  The only exception is scrub_nr_raid_mirrors(), which has several
  difference against btrfs_num_copies():

  * No iteration on all RAID6 combinations
    No sure if it's planned or not.

  * Use bioc->num_stripes directly
    In that context, bioc is already all the mirrors for the same
    stripe, thus no need to lookup using btrfs_raid_array[].

With all these cleanups, the RAID56J will be much easier to implement.

Qu Wenruo (4):
  btrfs: remove @dev_extent_len argument from scrub_stripe() function
  btrfs: use btrfs_chunk_max_errors() to replace weird tolerance
    calculation
  btrfs: use btrfs_raid_array[] to calculate the number of parity
    stripes
  btrfs: use btrfs_raid_array[].ncopies in btrfs_num_copies()

 fs/btrfs/raid56.c  | 10 ++--------
 fs/btrfs/raid56.h  | 12 ++----------
 fs/btrfs/scrub.c   | 13 +++++++------
 fs/btrfs/volumes.c | 35 +++++++++++++++++++++--------------
 fs/btrfs/volumes.h |  2 ++
 5 files changed, 34 insertions(+), 38 deletions(-)

-- 
2.36.1

