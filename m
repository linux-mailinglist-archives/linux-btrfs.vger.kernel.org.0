Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570AA618307
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiKCPlY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKCPlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 11:41:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A16713DD2;
        Thu,  3 Nov 2022 08:41:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A83821BF7;
        Thu,  3 Nov 2022 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667490081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lzXRoelaQpNOfPdsnWnywvovJbNUkTrxeUd8JkHPQyc=;
        b=HxFR8w2SepoxpGj57ONoePwAN74s58hiAl1o2dKnOQFbC7VIyRJKiI9xIIQdJnDIhOvHNH
        mpOeMPYpGCme6gFcWDZCt16CvK/JfPHnSnF4Rq3MTA5dk1xlZWUTghWU1slYIgzQdFk0oW
        JB0cfuw7hbdUrh9AMMofzkX1GQ9MF2U=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3CACD2C141;
        Thu,  3 Nov 2022 15:41:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8FBA1DA79D; Thu,  3 Nov 2022 16:41:02 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.1-rc4, part 2
Date:   Thu,  3 Nov 2022 16:41:00 +0100
Message-Id: <cover.1667488810.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a batch of error handling fixes for resource leaks, fixes for nowait
mode in combination with direct and buffered IO.  Please pull, thanks.

- direct IO + dsync + nowait could miss a sync of the file after write,
  add handling for this combination

- buffered IO + nowait should not fail with ENOSPC, only blocking IO
  could determine that

- error handling fixes
  - fix inode reserve space leak due to nowait buffered write
  - check the correct variable after allocation (direct IO submit)
  - fix inode list leak during backref walking
  - fix ulist freeing in self tests

----------------------------------------------------------------
The following changes since commit 76a66ba101329316a5d7f4275070be22eb85fdf2:

  btrfs: don't use btrfs_chunk::sub_stripes from disk (2022-10-25 10:17:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.1-rc3-tag

for you to fetch changes up to eb81b682b131642405a05c627ab08cf0967b3dd8:

  btrfs: fix inode reserve space leak due to nowait buffered write (2022-11-02 17:44:45 +0100)

----------------------------------------------------------------
Christophe JAILLET (1):
      btrfs: fix a memory allocation failure test in btrfs_submit_direct

Filipe Manana (7):
      btrfs: fix lost file sync on direct IO write with nowait and dsync iocb
      btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
      btrfs: fix inode list leak during backref walking at find_parent_nodes()
      btrfs: fix ulist leaks in error paths of qgroup self tests
      btrfs: remove pointless and double ulist frees in error paths of qgroup tests
      btrfs: fix nowait buffered write returning -ENOSPC
      btrfs: fix inode reserve space leak due to nowait buffered write

 fs/btrfs/backref.c            | 54 +++++++++++++++++++++++++++----------------
 fs/btrfs/ctree.h              |  5 +++-
 fs/btrfs/file.c               | 29 +++++++++++++++++------
 fs/btrfs/inode.c              | 16 +++++++++----
 fs/btrfs/tests/qgroup-tests.c | 36 +++++++++++++++--------------
 5 files changed, 91 insertions(+), 49 deletions(-)
