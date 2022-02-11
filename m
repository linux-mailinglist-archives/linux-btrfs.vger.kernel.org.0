Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3954B1EA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 07:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiBKGmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 01:42:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBKGmE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 01:42:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46800E7B
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 22:42:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD4D121138
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644561721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tEI+QwfVicfafmH5xETaT1iwBKQNCt7hm+lE8sYcyDw=;
        b=Mdzdn0Rizqm0juCu7XXx4pGcrLRunJaClUHvZ11hVYICE48CDEa/knaQSMcpm5OmKkNFea
        q3HBRUc14zbpeLdwRzrh3rokUaP5qoe1b4ccnanTIwSn0VWz2mJ3ctVe8DtYAR6Wlmi3Dj
        AqHnVq3s8hNN0mlRoqj6dkolwSEamo0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40B4E13345
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id leeFAzkFBmLmUAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 06:42:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/5] btrfs: defrag: don't waste CPU time on non-target extent
Date:   Fri, 11 Feb 2022 14:41:38 +0800
Message-Id: <cover.1644561438.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Changelog:
v2:
- Rebased to lastest misc-next
  Just one small conflict with static_assert() update.
  And this time only those patches are rebased to misc-next, thus it may
  cause conflicts with fixes for defrag_check_next_extent() in the
  future.

- Several grammar fixes

- Report accurate btrfs_defrag_ctrl::sectors_defragged
  This is inspired by a comment from Filipe that the skip check
  should be done in the defrag_collect_targets() call inside
  defrag_one_range().

  This results a new patch in v2.

- Change the timing of btrfs_defrag_ctrl::last_scanned update
  Now it's updated inside defrag_one_range(), which will give
  us an accurate view, unlike the previous call site in
  defrag_one_cluster().

- Don't change the timing of extent threshold.

- Rename @last_target to @last_is_target in defrag_collect_targets()

v3:
- Add Reviewed-by tags

- Fix a wrong value in commit message of the 1st patch

- Make @orig_start const for the 3rd patch

- Fix a missing word "skip" in the 5th patch

- Remove one unnecessary assignment in the 5th patch
  As we don't return the defragged sectors to user space.

v4:
- Move the skip behavior before the btrfs_defrag_ctrl refactor
  So it can be backported to v5.16

- Slightly change how we use btrfs_defrag_ctrl::last_scanned
  Previously we use that value almost as range start, but that's not correct,
  as defrag_collect_targets() can update it before we do any defrag.

  Now we pass explicit range start/len to defrag_one_cluster(), without
  re-using ctrl::last_scanned.

- Remove one incorrect range skip in defrag_one_cluster()
  There used to be a check against last_scanned to skip certain ranges.
  But that is not correct, as the last_scanned can already be larger
  than the first target after the 1st defrag_collect_targets() call.

  Now last_scanned is only really utilized after one cluster is
  defragged.

  This also removes the reviewed-by tag for the refactor patch 

Qu Wenruo (5):
  btrfs: defrag: allow defrag_one_cluster() to skip large extent which
    is not a target
  btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
  btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
  btrfs: defrag: use btrfs_defrag_ctrl to replace
    btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
  btrfs: defrag: make btrfs_defrag_file() to report accurate number of
    defragged sectors

 fs/btrfs/ctree.h           |  22 +++-
 fs/btrfs/file.c            |  21 ++--
 fs/btrfs/ioctl.c           | 200 ++++++++++++++++++++++---------------
 include/uapi/linux/btrfs.h |   6 +-
 4 files changed, 155 insertions(+), 94 deletions(-)

-- 
2.35.0

