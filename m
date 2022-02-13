Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3664B3A00
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Feb 2022 08:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiBMHnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Feb 2022 02:43:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiBMHm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Feb 2022 02:42:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844733B
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 23:42:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E820E1F37F
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644738171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IIB7Tfm9wawbCicYYHtNDmp+mKkbXvulD5AoRqXqS9E=;
        b=NnJiRQh22+/FlmLEN8kg1U5l608LpLFvm8KeAqiXKDyHH3oNPI+z8FSNudiAXA7NgpkXy1
        aC9SFWTaYLK1WPgkze00vVLZZRIpIIwURHjlbg0uFsSoGX4EBxvDNaEQ2ddJRfoC4An/v0
        BiQAiJ5ay+hUG9hOuQWqkysz/4/p2m4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 306261331A
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hv/iOXq2CGI+dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: make autodefrag to defrag and only defrag small write ranges
Date:   Sun, 13 Feb 2022 15:42:29 +0800
Message-Id: <cover.1644737297.git.wqu@suse.com>
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

When a small write reaches disk, btrfs will mark the inode for
autodefrag, and record the transid of the inode for autodefrag.

Then autodefrag uses the transid to only scan newer file extents.

However this transid based scanning scheme has a hole, the small write
size threshold triggering autodefrag is not the same extent size
threshold for autodefrag.

For the following write sequence on an non-compressed inode:

 pwrite 0 4k
 sync
 pwrite 4k 128k
 sync
 pwrite 132k 128k 
 sync.

The first 4K is indeed a small write (<64K), but the later two 128K ones
are definite not (>64K).

Hoever autodefrag will try to defrag all three writes, as the
extent_threshold used for autodefrag is fixed 256K.

This extra scanning on extents which didn't trigger autodefrag can cause
extra IO.

This patchset will try to address the problem by:

- Remove the inode_defrag re-queue behavior
  Now we just scan one file til its end (while keep the
  max_sectors_to_defrag limit, and frequently check the root refs, and
  remount situation to exit).

  This also saves several bytes from inode_defrag structure.

  This is done in the 3rd patch.

- Save @small_write value into inode_defrag and use it as autodefrag
  extent threshold
  Now there is no gap for autodefrag and small_write.

  This is done in the 4th patch.

The remaining patches are:

- Removing one dead parameter

- Add extra trace events for autodefrag
  So end users will no longer need to re-compile kernel modules, and
  use trace events to provide debug info on the autodefrag/defrag ioctl.

Unfortunately I don't have a good benchmark setup for the patchset yet,
but unlike previous RFC version, this one brings very little extra
resource usage, and is just changing the extent_threshold for
autodefrag.

Changelog:
RFC->v1:
- Add ftrace events for defrag

- Add a new patch to change how we run defrag inodes
  Instead of saving previous location and re-queue, just run it in one
  run.
  Previously btrfs_run_defrag_inodse() will always exhaust the existing
  inode_defrag anyway, the change should not bring much difference.

- Change autodefrag extent_thresh to close the gap, other than using
  another extent io tree
  Now it uses less resource, keep the critical section small, while
  can almost reach the same objective.

Qu Wenruo (4):
  btrfs: remove unused parameter for btrfs_add_inode_defrag()
  btrfs: add trace events for defrag
  btrfs: autodefrag: only scan one inode once
  btrfs: close the gap between inode_should_defrag() and autodefrag
    extent size threshold

 fs/btrfs/ctree.h             |   3 +-
 fs/btrfs/file.c              | 165 +++++++++++++++--------------------
 fs/btrfs/inode.c             |   4 +-
 fs/btrfs/ioctl.c             |   4 +
 include/trace/events/btrfs.h | 127 +++++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 97 deletions(-)

-- 
2.35.0

