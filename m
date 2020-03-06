Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993C717C46A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCFRaO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 12:30:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFRaN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 12:30:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDD71B46F;
        Fri,  6 Mar 2020 17:30:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75940DA728; Fri,  6 Mar 2020 18:29:48 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.6-rc5
Date:   Fri,  6 Mar 2020 18:29:47 +0100
Message-Id: <cover.1583514264.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

one fixup for DIO when in use with the new checksums, a missed case
where the checksum size was still assuming u32. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit a5ae50dea9111db63d30d700766dd5509602f7ad:

  Btrfs: fix deadlock during fast fsync when logging prealloc extents beyond eof (2020-02-21 16:21:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc4-tag

for you to fetch changes up to e7a04894c766daa4248cb736efee93550f2d5872:

  btrfs: fix RAID direct I/O reads with alternate csums (2020-03-03 15:26:08 +0100)

----------------------------------------------------------------
Omar Sandoval (1):
      btrfs: fix RAID direct I/O reads with alternate csums

 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
