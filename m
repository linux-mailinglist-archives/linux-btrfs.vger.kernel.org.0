Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447C53E9E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhHLFsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:48:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhHLFso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:48:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 314261FF10
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628747299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uKmIkkdr/apZR+5WUK1Toz6UcK1jqrt8YcEWop4hGIM=;
        b=VsiagpliZI64con+jfJy4aabeR3NLBkgNFiyrdJrplC+7RB0aZ43XwAqX5HOoOX9A5cT6/
        dlwj42roA3Zoff7MpJYe2ZBCu8k94OvOFVKYohqactJZ8M21yPogISvkl2i0Rlhp0kzUMp
        LHnVw6HzcvhvvE3LIs/UAXmplCbZLkA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6ADA913838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id adMECyK2FGG4ZwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:48:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 0/4] btrfs-progs: image: new data dump feature
Date:   Thu, 12 Aug 2021 13:48:11 +0800
Message-Id: <20210812054815.192405-1-wqu@suse.com>
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

Qu Wenruo (4):
  btrfs-progs: image: introduce framework for more dump versions
  btrfs-progs: image: introduce -d option to dump data
  btrfs-progs: image: reduce memory requirement for decompression
  btrfs-progs: image: fix restored image size misalignment

 image/main.c     | 349 ++++++++++++++++++++++++++++++++++-------------
 image/metadump.h |  13 +-
 2 files changed, 265 insertions(+), 97 deletions(-)

-- 
2.32.0

