Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEA2690DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgINP5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 11:57:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgINP5d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 11:57:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0863FAD64;
        Mon, 14 Sep 2020 15:57:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79037DA86B; Mon, 14 Sep 2020 17:56:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.9-rc6
Date:   Mon, 14 Sep 2020 17:56:17 +0200
Message-Id: <cover.1600098180.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

one of the recent lockdep fixes introduced a bug that breaks the search
ioctl, which is used by some applications (bees, compsize). The patch
made it to stable trees so we need this fixup to make it work again.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 2d892ccdc163a3d2e08c5ed1cea8b61bf7e4f531:

  btrfs: fix NULL pointer dereference after failure to create snapshot (2020-09-07 21:18:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc5-tag

for you to fetch changes up to 1c78544eaa4660096aeb6a57ec82b42cdb3bfe5a:

  btrfs: fix wrong address when faulting in pages in the search ioctl (2020-09-14 17:27:16 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix wrong address when faulting in pages in the search ioctl

 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
