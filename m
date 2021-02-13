Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1952831AB7F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 14:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBMNFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Feb 2021 08:05:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:60876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhBMNFI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Feb 2021 08:05:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613221467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lsj8fWioa3/gnYZ3JH7AM5XH13FFuoB9q//X8+9iYzo=;
        b=AmV+/2w7/H7GaTW/VIyX6Q/XW2v9kGDPSk4AxIpHJwQ8kw+b/mLFQAi7NjByTQ8UtaVQp5
        PndTY0OV+hyC2lrJ/FSkkx8VvWY6T0TaRiDzM8ueM+wRUgPRKd1EDdoPRJv/dkSPiwfB0Z
        DkLj+kSu1RI5eomMDa1mX6tWCA1+PWA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBC5DAC90;
        Sat, 13 Feb 2021 13:04:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DBA6DA6EF; Sat, 13 Feb 2021 14:02:31 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.11-rc8
Date:   Sat, 13 Feb 2021 14:02:31 +0100
Message-Id: <cover.1613141613.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a regression fix caused by a refactoring in 5.11. A corrupted superblock
wouldn't be detected by checksum verification due to wrongly placed
initialization of the checksum length, thus making memcmp always work.

I've verified it manually and ran other test suites before sending this.
Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 9ad6d91f056b99dbe59a262810cb342519ea8d39:

  btrfs: fix log replay failure due to race with space cache rebuild (2021-01-25 18:44:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc7-tag

for you to fetch changes up to 83c68bbcb6ac2dbbcaf12e2281a29a9f73b97d0f:

  btrfs: initialize fs_info::csum_size earlier in open_ctree (2021-02-12 14:48:24 +0100)

----------------------------------------------------------------
Su Yue (1):
      btrfs: initialize fs_info::csum_size earlier in open_ctree

 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
