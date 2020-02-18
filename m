Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B218C1628ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgBRO4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 09:56:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgBRO4M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 09:56:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33B77C12F;
        Tue, 18 Feb 2020 14:56:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Minor UUID cleanup
Date:   Tue, 18 Feb 2020 16:56:06 +0200
Message-Id: <20200218145609.13427-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is a short series that removes one indirect call in btrfs_uuid_tree_iterate
and making uuid rescan functions private to disk-io.c since they are used only
during mount. 

Nikolay Borisov (3):
  btrfs: Call btrfs_check_uuid_tree_entry directly in
    btrfs_uuid_tree_iterate
  btrfs: export btrfs_uuid_scan_kthread
  btrfs: Make btrfs_check_uuid_tree private to disk-io.c

 fs/btrfs/ctree.h     |  4 +--
 fs/btrfs/disk-io.c   | 35 +++++++++++++++++++
 fs/btrfs/uuid-tree.c | 50 ++++++++++++++++++++++++---
 fs/btrfs/volumes.c   | 82 +-------------------------------------------
 fs/btrfs/volumes.h   |  2 +-
 5 files changed, 84 insertions(+), 89 deletions(-)

-- 
2.17.1

