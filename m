Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A8716E89
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjE3UTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjE3UTw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 16:19:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A3FC;
        Tue, 30 May 2023 13:19:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2EE5D1F855;
        Tue, 30 May 2023 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685477989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9hCpFN0vqvdPJ3z80+H8nYjC0nMkp8foyuu05XQKxeo=;
        b=OQe0IK22eS/noq7o1Ksa1DKjQSdTVRIR/PXkfzZWIKXqmvYPrfVqJWhqrmDoVM7gJJjZQ3
        0sBFGg4eO8AF9PjCRzOJF9ONr0t5gpy7KxmJUmOi11KYGmfaTVScRV3fB+zUdyl85uKgSH
        /HsnDFQ0hAU71KgLw4pjqa7G454VNrg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1C9A62C141;
        Tue, 30 May 2023 20:19:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E155DA82D; Tue, 30 May 2023 22:13:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.4-rc5
Date:   Tue, 30 May 2023 22:13:38 +0200
Message-Id: <cover.1685474426.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull one bug fix and two build warning fixes, thanks.

- call proper end bio callback for metadata RAID0 in a rare case of an
  unaligned block

- build warning fixes
  - fix uninitialized variable (reported by gcc 10.2)
  - fix warning about potential access beyond array bounds on mips64
    with 64k pages (runtime check would not allow that)

----------------------------------------------------------------
The following changes since commit 597441b3436a43011f31ce71dc0a6c0bf5ce958a:

  btrfs: use nofs when cleaning up aborted transactions (2023-05-17 13:08:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc4-tag

for you to fetch changes up to 5ad9b4719fc9bc4715c7e19875a962095b0577e7:

  btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds (2023-05-26 23:24:55 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work

Shida Zhang (1):
      btrfs: fix an uninitialized variable warning in btrfs_log_inode

pengfuyuan (1):
      btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds

 fs/btrfs/bio.c      | 2 +-
 fs/btrfs/disk-io.c  | 2 +-
 fs/btrfs/tree-log.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
