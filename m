Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA3D7A05
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfJOPma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfJOPma (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A85BB519;
        Tue, 15 Oct 2019 15:42:28 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/8] tree reading cleanups in mount
Date:   Tue, 15 Oct 2019 18:42:16 +0300
Message-Id: <20191015154224.21537-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, 

Here is the second version of the tree reading code which gets executed during 
mount. This goes a bit further than the previous posting in that it not only 
introduces a new function but also refactors the code which decides which backup
root to use. Overall I think the semantics are now much cleaner and centralised
in a single function - init_tree_roots rather than split between mount and 
backup root write out. 

The series starts gradually by simplifying find_newest_super_backup and its
callers (patches 1-2). 

It then paves the way forward by introducing read_backup_rooti (patch 3) which
supersedes (patch 4) next_root_backup, the latter is then removed (patch 6). While
at it I also remove the unnecessary objectid mutex during mount (patch 5). 

The final 2 patches streamlines how btrfs_fs_info::backup_root_index is being
initialised. 

This patchset has been tested by simulating (via btrfs-corrupt-block) corruption
of the primary root and resorting to using usebackuproot mount option. I've also 
added a regression test to btrfs-progs that will follow shortly. 

Nikolay Borisov (8):
  btrfs: Cleanup and simplify find_newest_super_backup
  btrfs: Remove newest_gen argument from find_oldest_super_backup
  btrfs: Add read_backup_root
  btrfs: Factor out tree roots initialization during mount
  btrfs: Don't use objectid_mutex during mount
  btrfs: Remove unused next_root_backup function
  btrfs: Rename find_oldest_super_backup to init_backup_root_slot
  btrfs: Streamline btrfs_fs_info::backup_root_index semantics

 fs/btrfs/disk-io.c | 252 ++++++++++++++++++++-------------------------
 1 file changed, 113 insertions(+), 139 deletions(-)

-- 
2.17.1

