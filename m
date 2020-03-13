Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05F184A90
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCMPXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:23:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgCMPXY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:23:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31188AD39;
        Fri, 13 Mar 2020 15:23:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Removal of BTRFS_SUBVOL_CREATE_ASYNC support
Date:   Fri, 13 Mar 2020 17:23:17 +0200
Message-Id: <20200313152320.22723-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Having deprecated this feature in 5.4 now it's time to actually delete it.

First patch removes the user-visible support. The other 2 remove unneeded
arguments and code.

Nikolay Borisov (3):
  btrfs: Remove BTRFS_SUBVOL_CREATE_ASYNC support
  btrfs: Remove transid argument from btrfs_ioctl_snap_create_transid
  btrfs: Remove async_transid
    btrfs_mksubvol/create_subvol/create_snapshot

 fs/btrfs/ioctl.c           | 73 +++++++++-----------------------------
 include/uapi/linux/btrfs.h |  7 ++--
 2 files changed, 18 insertions(+), 62 deletions(-)

--
2.17.1

