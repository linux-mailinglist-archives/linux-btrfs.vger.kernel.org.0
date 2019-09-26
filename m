Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D042BF1DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfIZLj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:47060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfIZLj4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:39:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B43FAE0C;
        Thu, 26 Sep 2019 11:39:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Improve btrfs llseek implementation
Date:   Thu, 26 Sep 2019 14:39:50 +0300
Message-Id: <20190926113953.19569-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series aims to speed up and refactor btrfs_file_llseek. This is realized 
thanks to the fact there is no need to hold the inode locked when modifying the 
cursors of an opened file descriptor.

Patch 1 implements that and it results in around ~85% performance improvement
on a synthethic, fseek-heavy workload. Details on why this is safe are in the
patch's changelog alongside benchmarking information. 

Patch 2 streamlines btrfs_file_llseek and makes it similar to its counterparts
in ext4/xfs. Main change is that the 'out' label in the function is removed 
and the SEEK_END/SEEK_CUR are handled in the 'default' case. 

Patch 3 refactors find_desired_extent with the main goal of returning the found
offset as a function return value rather than into a pointer parameter.

This series survived xfstest.

Nikolay Borisov (3):
  btrfs: Speed up btrfs_file_llseek
  btrfs: Simplify btrfs_file_llseek
  btrfs: Return offset from find_desired_extent

 fs/btrfs/file.c | 58 ++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

-- 
2.17.1

