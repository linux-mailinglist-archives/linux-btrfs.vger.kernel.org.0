Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15A9E6FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfH0Lqe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:46:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfH0Lqd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:46:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7ED7AF19
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 11:46:32 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Cleanup btrfs_find_name_in* functions
Date:   Tue, 27 Aug 2019 14:46:27 +0300
Message-Id: <20190827114630.2425-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series cleans up the calling convention of the 2 function used to search 
the INODE_REF items for the presence of particular name. Namely, I switch the 2
functions to directly return a struct btrfs_inode_(ext)?ref. This reduces the 
number of parameters when calling the functions. 

While doing the aforementioned cleanup I stumbled upon backref_in_log which was 
opencoding btrfs_find_name_in_backref hence I just refactored the function. 

This series survived xfstest. 

Nikolay Borisov (3):
  btrfs: Make btrfs_find_name_in_backref return btrfs_inode_ref struct
  btrfs: Make btrfs_find_name_in_ext_backref return struct
    btrfs_inode_extref
  btrfs: Use btrfs_find_name_in_backref in backref_in_log

 fs/btrfs/ctree.h      | 15 +++++-----
 fs/btrfs/inode-item.c | 62 ++++++++++++++++++-----------------------
 fs/btrfs/tree-log.c   | 65 +++++++++++++------------------------------
 3 files changed, 54 insertions(+), 88 deletions(-)

-- 
2.17.1

