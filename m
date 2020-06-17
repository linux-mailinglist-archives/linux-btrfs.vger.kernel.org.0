Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F71FC9A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFQJR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 05:17:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFQJRW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 05:17:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9923EAE0E;
        Wed, 17 Jun 2020 09:17:25 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Refactor prealloc_file_extent_cluster
Date:   Wed, 17 Jun 2020 12:10:41 +0300
Message-Id: <20200617091044.27846-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those 3 minor patches refactor prealloc_file_extent_cluster by:

1. Removing useless check
2. Re-order code around to make heavyweight operations outside of inode lock,
(not that it matters for performance) and also get rid of the out label
3. Switch a while to a for loop to make the loop intentino more explicit.


Nikolay Borisov (3):
  btrfs: Remove hole  check in prealloc_file_extent_cluster
  btrfs: Perform data management operations outside of inode lock
  btrfs: Use for loop in prealloc_file_extent_cluster

 fs/btrfs/relocation.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

--
2.17.1

