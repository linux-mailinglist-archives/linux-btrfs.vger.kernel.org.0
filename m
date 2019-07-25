Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D296749F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403800AbfGYJeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:34:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390556AbfGYJeJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2C35ABE9
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 09:34:08 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 0/4] Support xxhash64 checksums
Date:   Thu, 25 Jul 2019 11:33:47 +0200
Message-Id: <cover.1564046812.git.jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
prepared for an easy addition of new checksums, this patchset implements
XXHASH64 as a second, fast but not cryptographically secure checksum hash.

This still is in RFC state (especially the btrfs-progs side).

David Sterba (1):
  btrfs: sysfs: export supported checksums

Johannes Thumshirn (3):
  btrfs: turn checksum type define into a union
  btrfs: create structure to encode checksum type and length
  btrfs: use xxhash64 for checksumming

 fs/btrfs/Kconfig                |  1 +
 fs/btrfs/ctree.h                | 17 ++++++++++++-----
 fs/btrfs/disk-io.c              |  1 +
 fs/btrfs/super.c                |  1 +
 fs/btrfs/sysfs.c                | 35 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h |  5 ++++-
 6 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.16.4

