Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD97A9CE7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfHZLsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbfHZLsj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13876AF8D
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:38 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 0/4] btrfs: support xxhash64 checksums
Date:   Mon, 26 Aug 2019 13:48:30 +0200
Message-Id: <20190826114834.14789-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
prepared for an easy addition of new checksums, this patchset implements
XXHASH64 as a second, fast but not cryptographically secure checksum hash.

For changes since v2, please see the individual patches.

David Sterba (1):
  btrfs: sysfs: export supported checksums

Johannes Thumshirn (3):
  btrfs: turn checksum type define into a enum
  btrfs: create structure to encode checksum type and length
  btrfs: use xxhash64 for checksumming

 fs/btrfs/Kconfig                |  1 +
 fs/btrfs/ctree.h                | 14 +++++++++-----
 fs/btrfs/disk-io.c              |  1 +
 fs/btrfs/super.c                |  1 +
 fs/btrfs/sysfs.c                | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h |  5 ++++-
 6 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.16.4

