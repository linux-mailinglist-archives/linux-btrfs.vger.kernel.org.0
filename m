Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545FF2D34A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgLHUyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 15:54:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgLHUyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Dec 2020 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 640DFACF5;
        Tue,  8 Dec 2020 18:42:44 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 0/2] Fix direct write with respect to inode locking
Date:   Tue,  8 Dec 2020 12:42:39 -0600
Message-Id: <cover.1607449636.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

In my previous attempt to fix direct I/O using iomap, the inode locks
were pushed into respective direct and buffered writes. However, in case
of fallback to buffered write, direct-io would release the inode lock and
reacquire it for buffered. This can cause corruption if another process
acquires the lock in between and writes around the same offset. Change
the flow so that the lock is acquired at the begining and release only
after the fallback buffered is complete.


Goldwyn Rodrigues (2):
  btrfs: Fold generic_write_checks() in btrfs_write_check()
  btrfs: Make btrfs_direct_write atomic with respect to inode_lock

 fs/btrfs/file.c | 86 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

-- 
2.29.2

