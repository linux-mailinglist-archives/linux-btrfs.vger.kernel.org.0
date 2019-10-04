Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8EACB75C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfJDJbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 05:31:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfJDJbi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 05:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD9F1B0A5
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 09:31:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: tree-checker: False alerts fixes for log trees
Date:   Fri,  4 Oct 2019 17:31:30 +0800
Message-Id: <20191004093133.83582-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a false alerts of tree-checker when running fstests/btrfs/063
in a loop.

The bug is caused by commit 59b0d030fb30 ("btrfs: tree-checker: Try to detect
missing INODE_ITEM").
For the full error analyse, please check the first patch.

The first patch will give it a quick fix, so that it can be addressed in
v5.4 release cycle.

The 2nd patch is a more proper patch, with refactor to reduce duplicated
code and add the check to INODE_REF item.
But it's pretty large (+72, -41), not sure if it's suitbale for late
-rc.

Also current write-time tree checker error message is too silent, can't
be caught by fstests nor a quick glance of dmesg. And it doesn't contain
enough info to debug.

So to enhance the error message, and make it more noisy, the 3rd patch
will enhance the error message.

Qu Wenruo (3):
  btrfs: tree-checker: Fix false alerts on log trees
  btrfs: tree-checker: Refactor prev_key check for ino into a function
  btrfs: Enhance the error outputting for write time tree checker

 fs/btrfs/disk-io.c      |   2 +
 fs/btrfs/tree-checker.c | 111 ++++++++++++++++++++++++++--------------
 2 files changed, 74 insertions(+), 39 deletions(-)

-- 
2.23.0

