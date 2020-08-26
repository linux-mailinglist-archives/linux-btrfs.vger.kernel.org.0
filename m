Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57752524E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 03:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHZBDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 21:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgHZBDn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 21:03:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED204B16E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:53:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tests/fsck: add test image for inode transid repair
Date:   Wed, 26 Aug 2020 08:52:33 +0800
Message-Id: <20200826005233.90063-4-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826005233.90063-1-wqu@suse.com>
References: <20200826005233.90063-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image would contain an inode with invalid transid:

        item 4 key (257 INODE_ITEM 0) itemoff 15881 itemsize 160
                generation 6 transid 134217734 size 131072 nbytes 131072
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../bad_inode_transid.img.xz                     | Bin 0 -> 1888 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/bad_inode_transid.img.xz

diff --git a/tests/fsck-tests/043-bad-inode-generation/bad_inode_transid.img.xz b/tests/fsck-tests/043-bad-inode-generation/bad_inode_transid.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..91ee6947fd71b52d5426b7adeb20cb1f6fd2866b
GIT binary patch
literal 1888
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
a0lE%=7ytlV9#}ZB#Ao{g000001X)_Aj-k&0

literal 0
HcmV?d00001

-- 
2.28.0

