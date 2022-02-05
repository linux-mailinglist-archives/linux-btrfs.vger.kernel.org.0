Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48574AA6F7
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 06:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiBEFsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 00:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiBEFsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 00:48:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40345C061346
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 21:48:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 403081F38A
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Feb 2022 05:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644039684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EpgGWMdZMEW9RWb7Ef0G32eDOKcFXQdCiqLiXC/KPyo=;
        b=lAS1dF9FQ5s4W25MxW3HqPJ3DyUbTAzrUpJBOzp1oWzkQ0N9TbYph4iiIh3Dw+0sgBCREp
        SnRp/M+9QoSro2oaOZ+Tpo6FnfsWzA4cowSXUHh3/uswZgoBK4a7mjOT6v2K9nX02Vl0oY
        7oHtA1SLqjn121rTJhVhFlQ/ap1Q5g8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95DD713A6D
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Feb 2022 05:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LXIlGAMO/mFCQAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Feb 2022 05:41:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/5] btrfs: defrag: don't waste CPU time on non-target extent
Date:   Sat,  5 Feb 2022 13:41:01 +0800
Message-Id: <cover.1644039494.git.wqu@suse.com>
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

In the rework of btrfs_defrag_file() one core idea is to defrag cluster
by cluster, thus we can have a better layered code structure, just like
what we have now:

btrfs_defrag_file()
|- defrag_one_cluster()
   |- defrag_one_range()
      |- defrag_one_locked_range()

But there is a catch, btrfs_defrag_file() just moves the cluster to the
next cluster, never considering cases like the current extent is already
too large, we can skip to its end directly.

This increases CPU usage on very large but not fragmented files.

Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
will reports where next search should start from.

If the current extent is not a target at all, then we can jump to the
end of that non-target extent to save time.

To get the missing optimization, also introduce a new structure,
btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
@max_to_defrag around.

This also remove weird behaviors like reusing range::start for next
search location.

And since we need to convert old btrfs_ioctl_defrag_range_args to newer
btrfs_defrag_ctrl, also do extra sanity check in the converting
function.

Such cleanup will also bring us closer to expose these extra policy
parameters in future enhanced defrag ioctl interface.
(Unfortunately, the reserved space of the existing defrag ioctl is not
large enough to contain them all)

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

Qu Wenruo (5):
  btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
  btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
  btrfs: defrag: use btrfs_defrag_ctrl to replace
    btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
  btrfs: defrag: make btrfs_defrag_file() to report accurate number of
    defragged sectors
  btrfs: defrag: allow defrag_one_cluster() to skip large extent which
    is not a target

 fs/btrfs/ctree.h           |  22 +++-
 fs/btrfs/file.c            |  17 ++-
 fs/btrfs/ioctl.c           | 219 ++++++++++++++++++++++---------------
 include/uapi/linux/btrfs.h |   6 +-
 4 files changed, 163 insertions(+), 101 deletions(-)

-- 
2.35.0

