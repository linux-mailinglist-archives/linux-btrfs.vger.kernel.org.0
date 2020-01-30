Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4014DB19
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 13:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgA3M7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 07:59:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgA3M7t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 07:59:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F59FB053;
        Thu, 30 Jan 2020 12:59:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH v2 0/2] Refactor snapshot vs nocow writers locking
Date:   Thu, 30 Jan 2020 14:59:43 +0200
Message-Id: <20200130125945.7383-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130125945.7383-1-nborisov@suse.com>
References: <20200130125945.7383-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Here is the second version of the DRW lock for btrfs. Main changes from v1:

* Fixed all checkpatch warnings (Andrea Parri)
* Properly call write_unlock in btrfs_drw_try_write_lock (Filipe Manana)
* Comment fix.
* Stress tested it via locktorture. Survived for 8 straight days on a 4 socket
48 thread machine.


I'm resending this one since it's been quite a while. Additionally Valentin
Schneider has created a more accurate spec of the algorithm than the one I had
initially submitted. It can be found here
https://lore.kernel.org/lkml/2dcaf81c-f0d3-409e-cb29-733d8b3b4cc9@arm.com/


I've been running with those patches on my custoom tree for a couple of months
and haven't observed any issues.

Nikolay Borisov (2):
  btrfs: Implement DRW lock
  btrfs: convert snapshot/nocow exlcusion to drw lock

 fs/btrfs/ctree.h       | 10 ++---
 fs/btrfs/disk-io.c     | 46 ++++++----------------
 fs/btrfs/extent-tree.c | 44 ---------------------
 fs/btrfs/file.c        | 11 +++---
 fs/btrfs/inode.c       |  8 ++--
 fs/btrfs/ioctl.c       | 10 ++---
 fs/btrfs/locking.c     | 87 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h     | 21 ++++++++++
 8 files changed, 134 insertions(+), 103 deletions(-)

--
2.17.1

