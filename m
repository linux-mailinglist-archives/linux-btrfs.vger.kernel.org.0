Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38D75B13D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGTOah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGTOag (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 10:30:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9CB1BF7;
        Thu, 20 Jul 2023 07:30:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8AAE2069D;
        Thu, 20 Jul 2023 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689863430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AZbFMJrusxAsOegzVjMRp7OsThURtoOEqT0By6fQ3ZA=;
        b=FJYMBIDSjp7SSi0uLjwr/TNpPVHjPbkPEInKC0zTps+DiybS9GFlMjpx6DsS9vYIoDW0Wm
        FdANQqP9MxYNy85XR25Kx0a56xan85oT3cUf90+UOiFawB/Id6gHUmosWzbTlVkdr2B5II
        JqPDwxCCxXNG2orZic88OwTlvN53Zio=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B48572C142;
        Thu, 20 Jul 2023 14:30:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C9BFDA90C; Thu, 20 Jul 2023 16:23:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.5-rc3
Date:   Thu, 20 Jul 2023 16:23:50 +0200
Message-Id: <cover.1689800327.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull the following fixes, backports for stable and two regression
fixes. Thanks.

Fixes:

- fix race between balance and cancel/pause

- various iput() fixes

- fix use-after-free of new block group that became unused

- fix warning when putting transaction with qgroups enabled after abort

- fix crash in subpage mode when page could be released between map and
  map read

- when scrubbing raid56 verify the P/Q stripes unconditionally

- fix minor memory leak in zoned mode when a block group with an
  unexpected superblock is found

Regression fixes:

- fix ordered extent split error handling when submitting direct IO

- user irq-safe locking when adding delayed iputs


----------------------------------------------------------------
The following changes since commit 8a4a0b2a3eaf75ca8854f856ef29690c12b2f531:

  btrfs: fix race between quota disable and relocation (2023-06-19 20:29:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc2-tag

for you to fetch changes up to aa84ce8a78a1a5c10cdf9c7a5fb0c999fbc2c8d6:

  btrfs: fix warning when putting transaction with qgroups enabled after abort (2023-07-18 03:14:11 +0200)

----------------------------------------------------------------
Christoph Hellwig (2):
      btrfs: be a bit more careful when setting mirror_num_ret in btrfs_map_block
      btrfs: fix ordered extent split error handling in btrfs_dio_submit_io

Filipe Manana (6):
      btrfs: fix use-after-free of new block group that became unused
      btrfs: zoned: fix memory leak after finding block group with super blocks
      btrfs: fix double iput() on inode after an error during orphan cleanup
      btrfs: fix iput() on error pointer after error during orphan cleanup
      btrfs: use irq safe locking when running and adding delayed iputs
      btrfs: fix warning when putting transaction with qgroups enabled after abort

Josef Bacik (2):
      btrfs: fix race between balance and cancel/pause
      btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand

Qu Wenruo (1):
      btrfs: raid56: always verify the P/Q contents for scrub

 fs/btrfs/block-group.c | 14 +++++++--
 fs/btrfs/block-group.h |  5 ++++
 fs/btrfs/inode.c       | 77 ++++++++++++++++++++++++++++++++++----------------
 fs/btrfs/qgroup.c      |  1 +
 fs/btrfs/raid56.c      | 11 ++------
 fs/btrfs/volumes.c     | 17 ++++-------
 6 files changed, 79 insertions(+), 46 deletions(-)
