Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D001145F0FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378169AbhKZPsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Nov 2021 10:48:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45524 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354267AbhKZPqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Nov 2021 10:46:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36E102191E;
        Fri, 26 Nov 2021 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637941369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hs+OViqGHngS3KJzx7vMZHD09b5UaCJE4IqzDvjyyYE=;
        b=vPAuGnEYmsjCDyjYB71IGZ3RfTBrd1DXylHGOMFz9tRroKtjiSOLknVXLpx9PlrpaSK1ri
        dDX0rtbwBOAn6xwf+O/+ByKbpSbozTWOeylrGl2ZftFYU304teFH8WPs7XzomqfEvAHQox
        0x0JCHmtj6jOILAD0NIDzsakcWYS6Zc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2EC50A3B8F;
        Fri, 26 Nov 2021 15:42:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65A90DA735; Fri, 26 Nov 2021 16:42:40 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.16-rc3
Date:   Fri, 26 Nov 2021 16:42:39 +0100
Message-Id: <cover.1637940049.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

one more fix to the lzo code, a missing put_page causing memory leaks
when some error branches are taken.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 6c405b24097c24cbb11570b47fd382676014f72e:

  btrfs: deprecate BTRFS_IOC_BALANCE ioctl (2021-11-16 16:51:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc2-tag

for you to fetch changes up to 504d851ab360dc00e2163acef2e200ea69ac800a:

  btrfs: fix the memory leak caused in lzo_compress_pages() (2021-11-26 14:32:40 +0100)

----------------------------------------------------------------
Qu Wenruo (1):
      btrfs: fix the memory leak caused in lzo_compress_pages()

 fs/btrfs/lzo.c | 2 ++
 1 file changed, 2 insertions(+)
