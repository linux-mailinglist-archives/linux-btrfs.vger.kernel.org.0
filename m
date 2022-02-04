Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3424A94E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 09:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245562AbiBDIMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 03:12:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiBDIMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 03:12:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A622F1F382
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643962337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V5EvyhxoMk0ohlLOVZeUknPr+rYsaGPY6YaR+WfTBRE=;
        b=H0wdRe04iwKeA3U35TJlBtuJ9C0velVSLAF9nL+havB+1lp6MgNiyLC7SKiMmo1jw5+kv3
        j+3gBw29KQwHLW7Vr+ULlzBFmc3Q92cTb5Wbu26KLo9iB0Keyh85Fbd4fPhLTxWzIzDglr
        t68/zvcEg8oHxSsCcoKZx7xyxtfHcig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0477A132DB
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RKvrL+Df/GFUVwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 08:12:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: defrag: don't waste CPU time on non-target extent
Date:   Fri,  4 Feb 2022 16:11:54 +0800
Message-Id: <cover.1643961719.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


Qu Wenruo (5):
  btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
  btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
  btrfs: defrag: use btrfs_defrag_ctrl to replace
    btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
  btrfs: defrag: make btrfs_defrag_file() to report accurate number of
    defragged sectors
  btrfs: defrag: allow defrag_one_cluster() to large extent which is not
    a target

 fs/btrfs/ctree.h           |  22 +++-
 fs/btrfs/file.c            |  17 ++-
 fs/btrfs/ioctl.c           | 224 ++++++++++++++++++++++---------------
 include/uapi/linux/btrfs.h |   6 +-
 4 files changed, 168 insertions(+), 101 deletions(-)

-- 
2.35.0

