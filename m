Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C502C550A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 14:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbgKZNKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 08:10:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:58856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389842AbgKZNKm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 08:10:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606396241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jKTP0B655iewq7kJFqwf9PwZncNtf2KH6kSSwfupk6Q=;
        b=UsganEp0pPNw+yqraV4XfIuP68aQqc8Nk/RoUf1wyBFK9KEnJfknbviaPsWm78fZW4ODi4
        o2wi/bGfFevf3TcxYxKJg1tFGaFrh6OltfEZICQ8dxf5v2OMEl55C9D5MAu1Xk6la/iAf2
        0QIpA4+nKgUXCNfIHMaVAoul3zFuXAE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D194AD21;
        Thu, 26 Nov 2020 13:10:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Remove deprecated inode cache feature
Date:   Thu, 26 Nov 2020 15:10:36 +0200
Message-Id: <20201126131039.3441290-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset removes inode cache feature which has been deprecated since kernel
v5.9 release. First 2 patches move code around and replace calls of functions
which are to be removed. Patch 3 finally removes inode cache for good.

I tested this under xfstest and didn't observe any new regressions.

Nikolay Borisov (3):
  btrfs: Move btrfs_find_highest_objectid/btrfs_find_free_objectid to
    disk-io.c
  btrfs: Replace calls to btrfs_find_free_ino with
    btrfs_find_free_objectid
  btrfs: Remove inode cache feature

 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/ctree.h            |  15 +-
 fs/btrfs/disk-io.c          |  78 +++--
 fs/btrfs/disk-io.h          |   2 +
 fs/btrfs/free-space-cache.c | 177 -----------
 fs/btrfs/free-space-cache.h |   6 -
 fs/btrfs/inode-map.c        | 582 ------------------------------------
 fs/btrfs/inode-map.h        |  16 -
 fs/btrfs/inode.c            |  23 +-
 fs/btrfs/ioctl.c            |   1 -
 fs/btrfs/relocation.c       |   1 -
 fs/btrfs/super.c            |   8 -
 fs/btrfs/transaction.c      |  19 --
 fs/btrfs/tree-log.c         |   1 -
 14 files changed, 66 insertions(+), 865 deletions(-)
 delete mode 100644 fs/btrfs/inode-map.c
 delete mode 100644 fs/btrfs/inode-map.h

--
2.25.1

