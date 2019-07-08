Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B336261B4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 09:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfGHHd4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 03:33:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:53536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfGHHd4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 03:33:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 847C4AC47
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2019 07:33:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: Fix delayed ref leakage
Date:   Mon,  8 Jul 2019 15:33:50 +0800
Message-Id: <20190708073352.6095-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have several bug reports of btrfs-convert failure in
btrfs_run_delayed_refs().

The bug turns out to be a incorrect backport of delayed ref handling in
transaction commit.

In kernel we have a loop to exhause both delayed refs and dirty blocks,
as btrfs_write_dirty_block_groups() can generate new delayed refs, while
btrfs_run_delayed_refs() can re-dirty block groups.

This feedback could cause missing delayed refs, and bite later transaction
just like the btrfs-convert report.

Furthermore, such lost delayed refs causes memory leakage and reserved
space leakage, the later one can be detected by commit c31edf610cbe
("btrfs-progs: Fix false ENOSPC alert by tracking used space
correctly").

The first patch will fix the long existing bug.

The second patch will try to reduce the feedback between
btrfs_write_dirty_block_groups() and btrfs_run_delayed_refs().

Changelog:
v2:
- Use a loop to exhaust both delayed refs and dirty block groups
  Thanks Nikolay for pointing out the feedback between them.

- Add a new patch to reduce above feedback 

- Handle the error from btrfs_write_dirty_block_groups()

Qu Wenruo (2):
  btrfs-progs: Exhaust delayed refs and dirty block groups to prevent
    delayed refs lost
  btrfs-progs: Avoid unnecessary block group item COW if the content
    hasn't changed

 extent-tree.c | 26 +++++++++++++++++++++++++-
 transaction.c | 27 +++++++++++++++++++++------
 2 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.22.0

