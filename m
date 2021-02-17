Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEA31DA02
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhBQNNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 08:13:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:56704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhBQNNi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 08:13:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613567572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QrZph8XWa+nkM4LhPbrfxxVS5/Vr2ZtTgmwC+q1VqaU=;
        b=QeN+jyV6ZVVbIe1U+Sj6yyw7McUIwcOi/f0hlX17DkkqQ3OoKejt7mN+XI/6TQrlOGX6BC
        VgT5VgoVP7Ma/csdSTxIT1IcMwJGzTiMp3i9vYv6sDFh+o3jwAZC2TCiwpJsXh8B6w9xqw
        ulTmEmFssxCo/mK4FsC/Ry9F2JGJZyY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F650B122;
        Wed, 17 Feb 2021 13:12:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/4] Couple of misc patches
Date:   Wed, 17 Feb 2021 15:12:46 +0200
Message-Id: <20210217131250.265859-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 4 patches which are independent of one another. The first 2 just
change two more function to take btrfs_inode. Patch 3 just extends the usage of
in_range which renders offset_in_entry redundant thus removing the function.
Final patch just restructures btrfs_inc_block_group_ro to use a do{} while() loo
rather than a label-based. This doesn't introduce extra nesting so I don't know
why the label approach was chosen in the first place.

Nikolay Borisov (4):
  btrfs: Make btrfs_replace_file_extents take btrfs_inode
  btrfs: Make find_desired_extent take btrfs_inode
  btrfs: Replace offset_in_entry with in_range
  btrfs: Replace opencoded while loop with proper construct

 fs/btrfs/block-group.c  | 42 ++++++++++++++------------
 fs/btrfs/ctree.h        |  5 ++--
 fs/btrfs/file.c         | 66 ++++++++++++++++++++---------------------
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ordered-data.c | 19 +++---------
 fs/btrfs/reflink.c      | 10 +++----
 6 files changed, 68 insertions(+), 76 deletions(-)

--
2.25.1

