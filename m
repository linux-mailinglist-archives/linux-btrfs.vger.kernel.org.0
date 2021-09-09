Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D7405833
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356238AbhIINr7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 09:47:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354364AbhIINoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 09:44:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAD0A1FDF7;
        Thu,  9 Sep 2021 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631194965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3ISr5Wy3LjLhnW/1KWlACzvbvjuhuLsSDnIci94YHJc=;
        b=jQI0PMTvL7GnqDENDwSEJRencQrKafOHTloMw/HeF15Cg18d0jrX+W8SNZXDpNlyMmiyZv
        itBocKHCZhZNNFEd8y88xAxGEwr/AYvxbrxQDh5fMOs2+58diyUd9eEIxLgqPf55yMISpz
        LkvuJ7mWafOu6nsG82B7Sifn8SNUyM4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E400FA4407;
        Thu,  9 Sep 2021 13:42:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CC359DA7A9; Thu,  9 Sep 2021 15:42:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.15-rc1
Date:   Thu,  9 Sep 2021 15:42:37 +0200
Message-Id: <cover.1631193109.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few fixes that don't need to be delayed, though I don't mind if you
merge this post rc1. Please pull, thanks.

* fix max_inline mount option limit on 64k page system

* lockdep fixes
  * update bdev time in a safer way
  * move bdev put outside of sb write section when removing device
  * fix possible deadlock when mounting seed/sprout filesystem

* zoned mode: fix split extent accounting

* minor include fixup

----------------------------------------------------------------
The following changes since commit 0d977e0eba234e01a60bdde27314dc21374201b3:

  btrfs: reset replace target device to allocation state on close (2021-08-23 13:57:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-tag

for you to fetch changes up to f79645df806565a03abb2847a1d20e6930b25e7e:

  btrfs: zoned: fix double counting of split ordered extent (2021-09-07 14:30:41 +0200)

----------------------------------------------------------------
Anand Jain (2):
      btrfs: fix upper limit for max_inline for page size 64K
      btrfs: fix lockdep warning while mounting sprout fs

Josef Bacik (2):
      btrfs: update the bdev time directly when closing
      btrfs: delay blkdev_put until after the device remove

Kari Argillander (1):
      btrfs: use correct header for div_u64 in misc.h

Naohiro Aota (1):
      btrfs: zoned: fix double counting of split ordered extent

 fs/btrfs/disk-io.c      | 48 ++++++++++++++++++++++++------------------------
 fs/btrfs/ioctl.c        | 15 +++++++++++----
 fs/btrfs/misc.h         |  2 +-
 fs/btrfs/ordered-data.c |  8 ++++++++
 fs/btrfs/volumes.c      | 48 +++++++++++++++++++++++++++++++-----------------
 fs/btrfs/volumes.h      |  3 ++-
 6 files changed, 77 insertions(+), 47 deletions(-)
