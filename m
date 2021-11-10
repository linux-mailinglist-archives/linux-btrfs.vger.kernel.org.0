Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60DB44C610
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhKJRlj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 12:41:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36358 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJRli (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 12:41:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 369661FD47;
        Wed, 10 Nov 2021 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636565930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qXKuDVk/9tnJzkq1IP49R4NmxO9QDtAcFtG7RTfHNZ0=;
        b=FTKwF2ipVVAbgWyTgDwAZ2CSEBvmDuoZYerxPQnSTNmUtyb/G0drNL35UQdLaURPoY4eaF
        IKcUMrOfl0Q5PEzJl1+mpZZzOuP75WwbjRBFhxkTGdepB8FEciSNFCBBXfg7JCxVwjZ0aX
        wvGoNfMRSyNz9uPuYatwmMgCgu7bnpI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2EB1BA3B84;
        Wed, 10 Nov 2021 17:38:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FA48DA799; Wed, 10 Nov 2021 18:38:10 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs update, part 2
Date:   Wed, 10 Nov 2021 18:38:09 +0100
Message-Id: <cover.1636564333.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

here's a separate fix that depends on changes that landed last week (the
iomap + iov_iter merged as c03098d4b9ad).

The fix itself is for a deadlock when direct/buffered IO is done on a
mmaped file and a fault happens (details in the patch). There's a fstest
generic/647 that triggers the problem and makes testing hard.

No merge conflicts. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit c03098d4b9ad76bca2966a8769dcfe59f7f85103:

  Merge tag 'gfs2-v5.15-rc5-mmap-fault' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-02 12:25:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-deadlock-fix-tag

for you to fetch changes up to 51bd9563b6783de8315f38f7baed949e77c42311:

  btrfs: fix deadlock due to page faults during direct IO reads and writes (2021-11-09 13:46:07 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix deadlock due to page faults during direct IO reads and writes

 fs/btrfs/file.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 16 deletions(-)
