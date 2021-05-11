Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490CF37A856
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhEKOBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 10:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhEKOBe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 10:01:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620741625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AtEZlmd3fH6fSCQ9hMUYAR0Kow0GgGOSp2OwoaiWtLM=;
        b=JLZCHKnVVhxNPX1wtiwXVEM7uF2zAY8e++G5qV+5aVbQk8A0mTEBr4dqSDm6+mr+lf3mqt
        QW97epGkvz63b38gQbpbXCgL4TpW6SE5S5AuB6AMZKSFefOu2C6OjyxZPPuY1czav0gyx+
        pc+wm+XZMgY1IGN6v18BHFnDMODfpZQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C32D1AF23;
        Tue, 11 May 2021 14:00:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78287DAF29; Tue, 11 May 2021 15:57:56 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.13-rc2, part 2
Date:   Tue, 11 May 2021 15:57:55 +0200
Message-Id: <cover.1620740882.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

here's a fix for code introduced by the fileattr merge, so it's separate
from the other btrfs patches and is based on v5.13-rc1.

- handle transaction start error in btrfs_fileattr_set

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.13-rc1-part2-tag

for you to fetch changes up to 9b8a233bc294dd71d3c7d30692a78ab32f246a0f:

  btrfs: handle transaction start error in btrfs_fileattr_set (2021-05-11 15:35:57 +0200)

----------------------------------------------------------------
Ritesh Harjani (1):
      btrfs: handle transaction start error in btrfs_fileattr_set

 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)
