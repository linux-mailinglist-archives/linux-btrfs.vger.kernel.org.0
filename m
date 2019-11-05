Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA995EF2DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 02:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfKEBfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 20:35:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:48516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbfKEBfk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 20:35:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2316B03D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2019 01:35:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 0/2] btrfs: block-group: Bug fixes for "btrfs: block-group: Refactor btrfs_read_block_groups()"
Date:   Tue,  5 Nov 2019 09:35:33 +0800
Message-Id: <20191105013535.14239-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David reported some strange error in that patch.

One bug is from rebasing, and another one is from me. The first patch
will fix the bug.

The second patch will reduce stack usage for read_one_block_group().

Qu Wenruo (2):
  btrfs: block-group: Fix two rebase errors where assignment for cache
    is missing
  btrfs: block-group: Reuse the item key from caller of
    read_one_block_group()

 fs/btrfs/block-group.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.23.0

