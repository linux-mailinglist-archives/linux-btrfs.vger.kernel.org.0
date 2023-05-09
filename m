Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA786FCAC2
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjEIQIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjEIQIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 12:08:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615C1724;
        Tue,  9 May 2023 09:08:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 74A1F1F86C;
        Tue,  9 May 2023 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683648511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2cPwDGRVO7/+D7PHuk70YOKQsgUCagngy/gIClOvSQ0=;
        b=clGGe4J7YvAWJmHiUdEM+dmbhmqj4oBnGae0H5t1AXTCbcgtMkk7BGGaqI1LFerONeqkrH
        Io7sJvAWx/A0lf/rqHK+mMBFUievOZowuIIOO3/eHEKhCM1eBT91/G0JRU/AOcA8mcsoWk
        L7C2QYiNktxaInJatQdecUdOEggS+Do=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 608CC2C141;
        Tue,  9 May 2023 16:08:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9C257DA7A0; Tue,  9 May 2023 18:02:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.4-rc2
Date:   Tue,  9 May 2023 18:02:32 +0200
Message-Id: <cover.1683645063.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

first batch of fixes, mostly stable material. Please pull, thanks.

- fix backward leaf iteration which could possibly return the same key

- fix assertion when device add and balance race for exclusive
  operation

- fix regression when freeing device, state tree would leak after device
  replace

- fix attempt to clear space cache v1 when block-group-tree is enabled

- fix potential i_size corruption when encoded write races with send v2
  and enabled no-holes (the race is hard to hit though, the window is a
  few instructions wide)

- fix wrong bitmap API use when checking empty zones, parameters were
  swapped but not causing a bug due to other code

- prevent potential qgroup leak if subvolume create does not commit
  transaction (which is pending in the development queue)

- error handling and reporting:
  - abort transaction when sibling keys check fails for leaves
  - print extent buffers when sibling keys check fails

----------------------------------------------------------------
The following changes since commit f372463124df5f980de6ee0cd6000a3e43df0e01:

  btrfs: mark btrfs_assertfail() __noreturn (2023-04-17 19:52:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc1-tag

for you to fetch changes up to d246331b78cbef86237f9c22389205bc9b4e1cc1:

  btrfs: don't free qgroup space unless specified (2023-05-03 16:37:56 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix encoded write i_size corruption with no-holes

Filipe Manana (4):
      btrfs: fix btrfs_prev_leaf() to not return the same key twice
      btrfs: fix leak of source device allocation state after device replace
      btrfs: abort transaction when sibling keys check fails for leaves
      btrfs: print extent buffers when sibling keys check fails

Josef Bacik (1):
      btrfs: don't free qgroup space unless specified

Naohiro Aota (1):
      btrfs: zoned: fix wrong use of bitops API in btrfs_ensure_empty_zones

Qu Wenruo (1):
      btrfs: properly reject clear_cache and v1 cache for block-group-tree

xiaoshoukui (1):
      btrfs: fix assertion of exclop condition when starting balance

 fs/btrfs/block-rsv.c |  3 ++-
 fs/btrfs/ctree.c     | 38 +++++++++++++++++++++++++++++++++++++-
 fs/btrfs/file-item.c |  5 +++--
 fs/btrfs/ioctl.c     |  4 +++-
 fs/btrfs/super.c     |  7 ++++++-
 fs/btrfs/volumes.c   |  1 +
 fs/btrfs/zoned.c     |  6 +++---
 7 files changed, 55 insertions(+), 9 deletions(-)
