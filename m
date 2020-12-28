Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4EC2E3352
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Dec 2020 01:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgL1Acu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Dec 2020 19:32:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:53864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgL1Acu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Dec 2020 19:32:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609115523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=opiyRlgP8WdR3inTVAmZCPZEQjAAk6aeGaTtyQAw4Vg=;
        b=bjqYxvJS+V/M7N8tXSyLC3bJo8spyIFWU9FiTueMKpV0JXQyjndxVQlaWAuuUIe6J7mJ0E
        Dc/W/L3M5ZXGLRBynA3zAn7lWudrkdpYT7c4WWv9Wv5o496Q4H3FLipu7HePBkVsEZyVjC
        dwJJw5c9dw8kgqQLznuft7NNzoAeS4k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97876AE40
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Dec 2020 00:32:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/4] btrfs-progs: image: new data dump feature
Date:   Mon, 28 Dec 2020 08:31:55 +0800
Message-Id: <20201228003159.115343-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
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

Qu Wenruo (4):
  btrfs-progs: image: introduce framework for more dump versions
  btrfs-progs: image: introduce -d option to dump data
  btrfs-progs: image: reduce memory requirement for decompression
  btrfs-progs: image: fix restored image size misalignment

 image/main.c     | 349 ++++++++++++++++++++++++++++++++++-------------
 image/metadump.h |  13 +-
 2 files changed, 265 insertions(+), 97 deletions(-)

-- 
2.29.2

