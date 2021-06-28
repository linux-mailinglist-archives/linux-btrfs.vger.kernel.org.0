Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07C23B5C58
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhF1KTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 06:19:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35900 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhF1KTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 06:19:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02586223FC
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624875401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jawy5Oqlubhnz4Hqgdcj2xjqloaDi4ElVxtwWJAT5HQ=;
        b=cMfdiRDoGfkuUr3wpcKvBGIzFp2ZrQeHX7TJ7/3V4RGzWLSb1eQLgq1SbpVT1f9Subr8QF
        PcYYucPG84zb+n2NuWK/9iwLCLZ/32Eof6V0wFMwB7etXUv/42YX2Rj/diyU7Esbt7UHL7
        0yQ3vQhJwlQv6ewM6EoOiw4iaLUT8Ko=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 0E741A3B8E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume
Date:   Mon, 28 Jun 2021 18:16:34 +0800
Message-Id: <20210628101637.349718-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're busting ghost subvolumes, the branch is now called
ghost_busters:
https://github.com/adam900710/linux/tree/ghost_busters

The first two patches are just cleanup found during the development.

The first is a missing check for subvolid range, the missing check
itself won't cause any harm, just returning -ENOENT from dentry lookup,
other than the expected -EINVAL.

The 2nd is a super old dead comment from the early age of btrfs.

The final patch is the real work to allow patched "btrfs subvolume delete -i"
to delete ghost subvolume.
Tested with the image dump of previous submitted btrfs-progs patchset.

Qu Wenruo (3):
  btrfs: return -EINVAL if some user wants to remove uuid/data_reloc
    tree
  btrfs: remove dead comment on btrfs_add_dead_root()
  btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume

 fs/btrfs/ioctl.c       | 81 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/transaction.c |  7 ++--
 2 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.32.0

