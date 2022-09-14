Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4B5B8104
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 07:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiINFdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiINFdM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 01:33:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7FE6BD73
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 22:33:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 762105CBE3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663133589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pDPjlNtd+iflG8Zi9HquD3Ksq0kmpJdrm95hIOQKM3Q=;
        b=IxYy3C98ik52SAmr7Tg9D0kCnP1ncrS1Fs29APiWP6zsWE5Hhaei8MLcqfTZa9z/1rvvMO
        LjntZT9R3oZz/SFiVD866NgpOXiOsi/euyCpekj3G9I4uXK0L7Pi/5w26EpuyljSGXehKp
        xHMKMycUbByDj0rtfiZCNKd7tLnJ5nM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A3A013486
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x1SSMZRnIWO6RQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: do most metadata parentnesss check at endio time
Date:   Wed, 14 Sep 2022 13:32:49 +0800
Message-Id: <cover.1663133223.git.wqu@suse.com>
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

[BACKGROUND]

Btrfs metadata and data verification are both done at endio time.

But metadata has its own extra verifiaction, mostly related to
parentness check, done at btrfs_read_extent_buffer() and
read_tree_block().

This is not a big deal, but if we want to make metadata read-repair to
share the same code base with data, we may want the metadata parentness
check also to happen at endio time.

[ENHANCEMENT]

This patchset will move all the parentness check code into
btrfs_validate_metadata_buffer().

As the first step, the first patch will concentrate all the existing
parentness check into one structure.

Then the second patch will pass all the parentness info into btrfs_bio,
using the shared space of data csum, so at endio time we can grab all
the metadata parentness info and do the verification.

This means the following mismatch at read time would be rejected
directly:

- First key mismatch
- Transid mismatch
- Level mismatch
- Owner root mismatch

Since all the read-time parentness check is all done at endio now,
btrfs_read_extent_buffer() can do less verification work for new extent
buffers which is going to be read from disk.

But please note that, we still do parentness check for cached extent
buffer, to avoid some cached/stale extent buffer read by other parent
tree blocks to cause problems.

Thankfully that part will not trigger read repair thus won't affect us
for now.

[TODO]
Make metadata and data share the same code base to do read-repair.

The main blockage here is, we have a lot of pending patches changing
the read-repair code, thus it's going to cause conflicts for the already
lengthy pending patches.

Thus the refactor part is sent out first, then after read-repair is
settled down, I can work on the unified read-repair code.

Qu Wenruo (2):
  btrfs: concentrate all tree block parentness check parameters into one
    structure
  btrfs: move tree block parentness check into validate_extent_buffer()

 fs/btrfs/backref.c      |  15 +++--
 fs/btrfs/ctree.c        |  28 +++++----
 fs/btrfs/disk-io.c      | 125 +++++++++++++++++++++++++++-------------
 fs/btrfs/disk-io.h      |  36 ++++++++++--
 fs/btrfs/extent-tree.c  |  12 ++--
 fs/btrfs/extent_io.c    |  18 ++++--
 fs/btrfs/extent_io.h    |   5 +-
 fs/btrfs/print-tree.c   |  13 +++--
 fs/btrfs/qgroup.c       |  18 ++++--
 fs/btrfs/relocation.c   |  11 +++-
 fs/btrfs/tree-log.c     |  25 +++++---
 fs/btrfs/tree-mod-log.c |   9 ++-
 fs/btrfs/volumes.h      |  25 +++++++-
 13 files changed, 248 insertions(+), 92 deletions(-)

-- 
2.37.3

