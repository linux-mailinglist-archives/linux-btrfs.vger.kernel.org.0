Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DF15DFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 09:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEGHT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 03:19:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbfEGHT2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 03:19:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B269ABD0
        for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2019 07:19:27 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 0/3] Ordered extent flushing refactor
Date:   Tue,  7 May 2019 10:19:21 +0300
Message-Id: <20190507071924.17643-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is v2 of factoring out common code when flushing ordered extent. The main
change in this version is the switch from inode to btrfs_inode for  function 
interfaces as per David's feedback. 

Nikolay Borisov (3):
  btrfs: Implement btrfs_lock_and_flush_ordered_range
  btrfs: Use newly introduced btrfs_lock_and_flush_ordered_range
  btrfs: Always use a cached extent_state in
    btrfs_lock_and_flush_ordered_range

 fs/btrfs/extent_io.c    | 29 ++++----------------------
 fs/btrfs/file.c         | 14 ++-----------
 fs/btrfs/inode.c        | 17 ++--------------
 fs/btrfs/ordered-data.c | 45 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  4 ++++
 5 files changed, 57 insertions(+), 52 deletions(-)

-- 
2.17.1

