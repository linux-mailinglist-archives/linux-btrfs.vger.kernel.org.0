Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED1460DA6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiJZFGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZFGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3DF4F643
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5288D2203D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+8IGIc1eL2rb+7OjLb6MLeVvxmqr9Kj/ys/syAjW2/I=;
        b=CmXySlRmJmHTPTddv89iR9NiPita8L7ig3Ys6VNNYATSHGRjWGLSUULW7sik2ihzArZLby
        JJsTko5vwXVguYTUqaJbPUVesrzXUxotNmYwsGBncrZJJRPkgcpDiTQQ4X+QMQ4rE+SbpV
        QQBvEZfZurcDGcXmzXBf0JiOMmuKHHI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8F4513A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u7vrHFrAWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: raid56: use submit-and-wait method to handle raid56 writes
Date:   Wed, 26 Oct 2022 13:06:24 +0800
Message-Id: <cover.1666760699.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs raid56 is have many and very chaotic function entrances:

- full_stripe_write()
  For full stripe write, will try to lock the full stripe and then do
  the write.

- finish_rmw()
  For rbio which holds the full stripe lock, only do the writes, for
  either full stripe write, or sub-stripe write with cached rbio.

- raid56_rmw_stripe()
  For sub-stripe write which owns the full stripe lock.

Furthermore we are using endio functions to go the next stage of the
work, it's really hard to properly follow the workflow.


The truth is, full-stripe is just a subset of a full RMW cycle, there
really not that much difference to treat full-stripe that differently
(except skip the plug).


This patchset will rework the raid56 write path (recover and scrub path
is not touched yet) by:

- Introduce a main function for raid56 writes
  The main function will be called run_one_write_rbio(), and it always
  executed in rmw_worker workqueue.

- Unified handling for all writes (full/sub-stripe, cached/non-cached,
  degraded or not)
  For full stripe write, it skips the read, and go into write part
  directly.

  For sub-stripe write, we will try to read the missing sectors first,
  and wait for it (we may not read anything if it's cached).

  Then check if we have some missing devices for the above read.
  If so, do recovery first.

  Finally we have everything needed, can submit the write bios, and wait
  for the write to finish.

- No more need for end_io_work
  Since we don't rely on endio functions to jump to the next step.

  Unfortunately rbio::end_io_work can only be removed when recovery
  and scrub path are also migrated to the new single main thread way.

By this, we have unified entrance for all raid56 writes, and no extra
jumping/workqueue mess to interrupt the workflow.

This would make later destructive RMW fix much easier to add, as the
timing of each step in RMW cycle should be very easy to grasp.

Thus I hope this series can be merged before the previous RFC series of
destructive RMW fix.


Qu Wenruo (8):
  btrfs: raid56: extract the vertical stripe recovery code into
    recover_vertical()
  btrfs: raid56: extract the pq generation code into a helper
  btrfs: raid56: introduce a new framework for RAID56 writes
  btrfs: raid56: implement the read part for run_one_write_rbio()
  btrfs: raid56: implement the degraded write for run_one_write_rbio()
  btrfs: raid56: implement the write submission part for
    run_one_write_bio()
  btrfs: raid56: implement raid56_parity_write_v2()
  btrfs: raid56: switch to the new run_one_write_rbio()

 fs/btrfs/raid56.c | 1199 +++++++++++++++++++++++++++------------------
 fs/btrfs/raid56.h |    4 +
 2 files changed, 727 insertions(+), 476 deletions(-)

-- 
2.38.1

