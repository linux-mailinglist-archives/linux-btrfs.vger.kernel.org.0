Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD59123EC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLRFSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:18:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:18:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so594806pgk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlDVK//oWjjmU839ndmuKVmUgnPUAK2JQSUuWsV3E3A=;
        b=DNSIFC4yxwbihlPJuaeJ+jWnULqsuxA76zUPVQcWvzo/XdD8MHlNJRzy0vGSMAGbOe
         rQUFV9RbDJIfw8jpBaION4pzllSe8ZP9LcSNeDhVPWTwtPUYzzEm66uEOpkCZGZ+XeGD
         QiaYgE2KwNW0sR+Hsdaw8anrUkZZRccVy/ctQifVEDibkiLSS7rlHbcHp3T/VztjCCBT
         4Qw8flPeENxEf1g5Xi4RIzJVw5S2Ghj88rQMlg6VuSyX3vjOuHi6vttrKVkf3Dq2cJ6Q
         mSJ4FKKYMKC5eJxU+ypoYff/SYqVZ+4SXVKeoDv7beWund/a6iRFmAMH+Lp9Fi3DD7X1
         XubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlDVK//oWjjmU839ndmuKVmUgnPUAK2JQSUuWsV3E3A=;
        b=ZsWwAw+IrSY98dhlx82r0/R5aAGO6CYEAihkTCYTD2kQRHoQ53DEjnPgtfyv5D68aQ
         KWmsDTizeClSuzvMrAbzdogmE13NoPJZ5I2pyCcRxT5/sV0DukfYxcse0jl7adlXJGzW
         UHAyKGGL4LTNLKaDLLwGHOJ63Jmlipb1uJQqYA2fJHk/PjZq0H2axrmdBnj0YPu7CB6B
         RB3GurASnhuL4B5hkWJrFCcCbmOk8EDyCf4aLheS1K+aQHMrIxM8AZQFDrpMH+VVwqWL
         A1lHkbxOJ7Wz6mDRW91hUXVcituMklJkIrVeHdHei5kw8Hlzr9ASoauPUrjDk2TAeLAV
         Xp4Q==
X-Gm-Message-State: APjAAAXA9PTW7ssamozbHMsZDMFlfVu7zAAMDPOX1lc/j6icncPGmNsv
        WybVDnzqutDelUHi1Jw1Ul4wtT6EuZQ=
X-Google-Smtp-Source: APXvYqz2xEab62PC6b1akyWfdCFQ3h/scgReLELpfKGYcS+hRr6bCNolNv8KP59G5MZPleMnoVanAg==
X-Received: by 2002:a65:5608:: with SMTP id l8mr882393pgs.210.1576646333901;
        Tue, 17 Dec 2019 21:18:53 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:18:53 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH V2 00/10] unify origanization structure of block group cache
Date:   Wed, 18 Dec 2019 13:18:39 +0800
Message-Id: <20191218051849.2587-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

In progs, block group caches are stored in btrfs_fs_info::block_group_cache
whose type is cache_extent. All block group caches adding/finding/freeing
are done in the misleading set/clear_extent_bits ways. However, kernel
side uses red-black tree structure in btrfs_fs_info directly. The
latter's structure is more reasonable and intuitive.

This patchset transforms structure of block group caches from cache_extent
to red-black tree and list.

patch[1] handles error to avoid warning after reform.
patch[2-6] are about rb tree reform things in preparation.
patch[7-8] are about dirty block groups linked in transaction in preparation.
patch[9] does replace works in action.
patch[10] does cleanup.

This patchset passed progs tests and did not cause any regression.

---
Changelog:
v2:
   Adjust block group cache tree seach and lookup functions to
   progs behaviors.
   Use rbtree_postorder_for_each_entry_safe() in patch[9] (Qu WenRuo).
   Add reviewed-by tags.

Su Yue (10):
  btrfs-progs: handle error if btrfs_write_one_block_group() failed
  btrfs-progs: block_group: add rb tree related memebers
  btrfs-progs: port block group cache tree insertion and lookup
    functions
  btrfs-progs: reform the function block_group_cache_tree_search()
  btrfs-progs: adjust ported block group lookup functions in kernel
    version
  btrfs-progs: abstract function btrfs_add_block_group_cache()
  block-progs: block_group: add dirty_bgs list related memebers
  btrfs-progs: pass @trans to functions touch dirty block groups
  btrfs-progs: reform block groups caches structure
  btrfs-progs: cleanups after block group cache reform

 check/main.c                |   6 +-
 check/mode-lowmem.c         |   6 +-
 cmds/rescue-chunk-recover.c |  10 +-
 ctree.h                     |  29 ++--
 disk-io.c                   |   4 +-
 extent-tree.c               | 304 +++++++++++++++---------------------
 extent_io.h                 |   2 -
 image/main.c                |  10 +-
 transaction.c               |   8 +-
 transaction.h               |   3 +-
 10 files changed, 165 insertions(+), 217 deletions(-)

-- 
2.21.0 (Apple Git-122.2)

