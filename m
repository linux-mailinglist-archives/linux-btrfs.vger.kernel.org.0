Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0023F593F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhHXHnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:43:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhHXHmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:42:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28FB120042
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629790873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bnnxj4eq5QsHHidub5oQKGfXxeNLydmqIrPiz1ocbnA=;
        b=Oix4DjM6H0NjG9SLQ8X5FS+DDYPRbbybqy0AbpEjUT1hZw9tZxVbz2xHBCUK4REoZNS/wg
        2L2lx416GrJZTODTRfovxvaLiwE2UohmKXiBvhwOJhHqS/KU8kWZSGewAJNxOR9/3FKWtu
        Mu0D4MjkdGqCfnpBHjUIXzpwgYpBEQ4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1C34A13942
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kQtRLpeiJGF8bwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 0/4] btrfs-progs: image: new data dump feature
Date:   Tue, 24 Aug 2021 15:41:04 +0800
Message-Id: <20210824074108.44759-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset includes the following features:

- Introduce data dump feature to dump the whole fs.
  This will introduce a new magic number to prevent old btrfs-image to
  hit failure as the item size limit is enlarged.
  Patch 1 and 2.

- Reduce memory usage for compressed data dump restore
  This is mostly due to the fact that we have much larger
  max_pending_size introduced by data dump(256K -> 256M).
  Using 4 * max_pending_size for each decompress thread as buffer is way
  too expensive now.
  Use proper inflate() to replace uncompress() calls.
  Patch 3

- A fix for small dev extent size mismatch with superblock
  This no longer affects single device dump restore, thus it's only
  for multi-device dump restore.
  Patch 4

Changelog:
v2:
- New small fixes:
  * Fix a confusing error message due to unpopulated errno
  * Output error message for chunk tree build error
  
- Fix a regression of previous version
  Patch "btrfs-progs: image: Rework how we search chunk tree blocks"
  deleted a "ret = 0" line which could cause false early exit.

- Reduce memory usage for data dump

v2.1:
- Rebased to devel branch
  Removing 4 already merged patches from the patchset.

- Re-order the patchset
  Put small and independent patches at the top of queue, and put the
  data dump related feature at the end.

- Fix -Wmaybe-uninitialized warnings
  Strangely, D=1 won't trigger these warnings thus they sneak into v2
  without being detected.

- Fix FROM: line
  Reverted to old smtp setup. The new setup will override FROM: line,
  messing up the name of author.

v3:
- Fix a wrong option in error string
- Fix a bug that we always dump data extents

v4:
- Rebased to latest devel branch
- Add a new small fix to kill the tiny dev extent size mismatch.

v5:
- Rebased to latest devel branch
- Checkpatch fixes

v6:
- Rebased to latest devel branch
  No conflicts at all.

v7:
- Rebased to latest devel branch
  No conflicts at all.

- Hide the data dump feature behind the experimental features
  Now to make "btrfs-image -d" work, one must enable experimental
  features, or "btrfs-image -d" will only output an error message.

  And if experimental features are not enabled, the new header format
  will also be disabled, so that btrfs-image can't detect the new format
  either.

  Although the "-d" option is still enabled for the non-experimental
  build.

  This only affects the 2nd patch, the remaining patches are not
  touched.

Qu Wenruo (4):
  btrfs-progs: image: introduce framework for more dump versions
  btrfs-progs: image: introduce -d option to dump data
  btrfs-progs: image: reduce memory requirement for decompression
  btrfs-progs: image: fix restored image size misalignment

 image/main.c     | 358 ++++++++++++++++++++++++++++++++++-------------
 image/metadump.h |  12 +-
 2 files changed, 273 insertions(+), 97 deletions(-)

-- 
2.32.0

