Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5339611A39D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 06:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfLKFAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 00:00:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:45498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfLKFAL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 00:00:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77B68AE07
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 05:00:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
Date:   Wed, 11 Dec 2019 13:00:01 +0800
Message-Id: <20191211050004.18414-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Due to commit d2311e698578 ("btrfs: relocation: Delay reloc tree
deletion after merge_reloc_roots"), reloc tree lifespan is extended.

Although we always set root->reloc_root to NULL before we drop the reloc
tree, but that's not multi-core safe since we have no proper memory
barrier to ensure other cores can see the same root->reloc_root.

The proper root fix should be some proper root refcount, and make
btrfs_drop_snapshot() to wait for all other root owner to release the
root before dropping it.

But for now, let's just check the DEAD_RELOC_ROOT bit before accessing
root->reloc_root.

Qu Wenruo (3):
  btrfs: relocation: Fix a KASAN use-after-free bug due to extended
    reloc tree lifespan
  btrfs: relocation: Fix KASAN report on create_reloc_tree due to
    extended reloc tree lifepsan
  btrfs: relocation: Fix a KASAN report on btrfs_reloc_pre_snapshot()
    due to extended reloc root lifespan

 fs/btrfs/relocation.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.24.0

