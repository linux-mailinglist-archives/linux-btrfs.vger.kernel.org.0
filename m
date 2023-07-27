Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1707B76522B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjG0LWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 07:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjG0LWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 07:22:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7145C110;
        Thu, 27 Jul 2023 04:22:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 08A41219DA;
        Thu, 27 Jul 2023 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690456960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HnJIghI2yuz/ZLIRsiqNbZ6xkeqzcrRYDH5qRLe+l70=;
        b=Qj4MP+NAVYgKRsiwSXcYiPD3KkEcRyH7UN1BlqTIvAml4KU+IB8WgnWT1p2rxC1pTJeTpJ
        QPkM7x1Iid3VLdS/oXCMjfsMVZiOV154Md+unxWrBYoCa95ie+SQITFZtFbMwdWXkEtILf
        aEB47zVGE20O9rMVdnGysBPY53QVKVc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E5D802C142;
        Thu, 27 Jul 2023 11:22:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F92BDA7FB; Thu, 27 Jul 2023 13:16:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.5-rc4
Date:   Thu, 27 Jul 2023 13:16:17 +0200
Message-ID: <cover.1690455145.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes and a correction of async discard for zoned mode.
Please pull, thanks.

- fix accounting of global block reserve size when block group tree is
  enabled

- the async discard has been enabled in 6.2 unconditionally, but for
  zoned mode it does not make that much sense to do it asynchronously as
  the zones are reset as needed

- error handling and proper error value propagation fixes

----------------------------------------------------------------
The following changes since commit aa84ce8a78a1a5c10cdf9c7a5fb0c999fbc2c8d6:

  btrfs: fix warning when putting transaction with qgroups enabled after abort (2023-07-18 03:14:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.5-rc3-tag

for you to fetch changes up to b28ff3a7d7e97456fd86b68d24caa32e1cfa7064:

  btrfs: check for commit error at btrfs_attach_transaction_barrier() (2023-07-26 13:57:47 +0200)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: account block group tree when calculating global reserve size
      btrfs: remove BUG_ON()'s in add_new_free_space()
      btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
      btrfs: check for commit error at btrfs_attach_transaction_barrier()

Naohiro Aota (1):
      btrfs: zoned: do not enable async discard

 fs/btrfs/block-group.c     | 51 ++++++++++++++++++++++++++++++----------------
 fs/btrfs/block-group.h     |  4 ++--
 fs/btrfs/block-rsv.c       |  5 +++++
 fs/btrfs/disk-io.c         |  7 ++++++-
 fs/btrfs/free-space-tree.c | 24 +++++++++++++++-------
 fs/btrfs/transaction.c     | 10 +++++++--
 fs/btrfs/zoned.c           |  3 +++
 7 files changed, 75 insertions(+), 29 deletions(-)
