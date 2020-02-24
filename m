Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1061E169E21
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 07:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgBXGCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 01:02:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXGCJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 01:02:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DE67B24E
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 06:02:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: relocation: build_backref_cache() refactor part 2
Date:   Mon, 24 Feb 2020 14:01:57 +0800
Message-Id: <20200224060200.31323-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from:
https://github.com/adam900710/linux/tree/backref_cache_new

Since it is based on previous btrfs_backref_iter facility, it's
recommended to fetch from above repo.

This patchset mostly refactors the backref handling code out of the bit
loop in build_backref_cache().

Now build_backref_tree() can be easily divided into 4 small parts:
- Basic structure allocation
- Breadth-first search for backrefs
- Handling edges of upper nodes
- Removing useless nodes

Qu Wenruo (3):
  btrfs: relocation: Use wrapper to replace open-coded edge linking
  btrfs: relocation: Specify essential members for alloc_backref_node()
  btrfs: relocation: Remove the open-coded goto loop for breadth-first
    search

 fs/btrfs/relocation.c | 241 ++++++++++++++++++++++++------------------
 1 file changed, 138 insertions(+), 103 deletions(-)

-- 
2.25.1

