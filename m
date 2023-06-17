Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD5733E23
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjFQFHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQFHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:07:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487761BDF
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:07:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B21501FD63
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686978464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pmEhJ0ymZNkoTZNP6PufO9zK2MedrBMa3Ruk3C6pmLk=;
        b=MILTen1rwe5K/TAQARUQx0EVG56iWQ2ggs2nD3IaNb81YT7/qjewnOfcFYphB2VYniuci+
        xtttF06uacy3jmajBHCDMDVXRqxtKosw26gq5ew4BBA4lz3FrFQXXhc7i7nGEyXvebBcX1
        CDhWMolwAXdDJ+iooQZyTFWBeClp4qI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2027213915
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gWD/N58/jWTFEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:07:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/5] btrfs: scrub: introduce SCRUB_LOGICAL flag
Date:   Sat, 17 Jun 2023 13:07:21 +0800
Message-ID: <cover.1686977659.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
Scrub originally works in a per-device basis, that means if we want to
scrub the full fs, we would queue a scrub for each writeable device.

This is normally fine, but some behavior is not ideal like the
following:
		X	X+16K	X+32K
 Mirror 1	|XXXXXXX|       |
 Mirror 2	|       |XXXXXXX|

When scrubbing mirror 1, we found [X, X+16K) has corruption, then we
will try to read from mirror 2 and repair using the correct data.

This applies to range [X+16K, X+32K) of mirror 2, causing the good copy
to be read twice, which may or may not be a big deal.

But the problem can easily go crazy for RAID56, as its repair requires
the full stripe to be read out, so is its P/Q verification.


There are also some other minor problems, like due to the difference in
the disk read speed, we may be scrubbing different block groups on
different devices.
This can lead to reduced available space and higher chance of false
-ENOSPC.

[ENHANCEMENT]
Instead of the existing per-device scrub, this patchset introduce a new
flag, SCRUB_LOGICAL, to do logical address space based scrub.

Unlike per-device scrub, this new flag would make scrub a per-fs
operation.

This allows us to scrub the different mirrors in one go, and avoid
unnecessary read to repair the corruption.

This also makes user space handling much simpler, just one ioctl to
scrub the full fs, without the current multi-thread scrub code.

[TODO]
The long todo list is the main reason for RFC:

- Missing RAID56 handling
  Unlike pure mirror based profiles, RAID56 repair now needs to be
  handled inside scrub (or some new raid interfaces to handle fully
  cached stripes).

  This can be some extra investment, and add an exception for the
  elegant and simpler mirror based read-repair path.

- Better progs integration
  In theory we can silently try SCRUB_LOGICAL first, if the kernel
  doesn't support it, then fallback to the old multi-device scrub.

  But for current testing, a dedicated option is still assigned for
  scrub subcommand.

  And currently it only supports full report, no summary nor scrub file
  support.

- More testing
  Currently only very basic tests done, no stress tests yet.

Qu Wenruo (5):
  btrfs: scrub: make scrub_ctx::stripes dynamically allocated
  btrfs: scrub: introduce the skeleton for logical-scrub
  btrfs: scrub: extract the common preparation before scrubbing a block
    group
  btrfs: scrub: implement the basic extent iteration code
  btrfs: scrub: implement the repair part of scrub logical

 fs/btrfs/disk-io.c         |   1 +
 fs/btrfs/fs.h              |  12 +
 fs/btrfs/ioctl.c           |   6 +-
 fs/btrfs/scrub.c           | 757 ++++++++++++++++++++++++++++++-------
 fs/btrfs/scrub.h           |   2 +
 include/uapi/linux/btrfs.h |  11 +-
 6 files changed, 647 insertions(+), 142 deletions(-)

-- 
2.41.0

