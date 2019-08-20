Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C72966F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTQ6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfHTQ6R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 622D1AEE0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:58:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D954DA7DA; Tue, 20 Aug 2019 18:58:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Extent buffer accessor macros cleanup
Date:   Tue, 20 Aug 2019 18:58:41 +0200
Message-Id: <cover.1566320094.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove some conditions from eb accessors, eg. when the token pointer is
known to be valid, or when the eb/token pair does not change inside the
functions.

David Sterba (3):
  btrfs: define separate btrfs_set/get_XX helpers
  btrfs: assume valid token for btrfs_set/get_token helpers
  btrfs: tie extent buffer and it's token together

 fs/btrfs/ctree.c        | 27 +++++++--------
 fs/btrfs/ctree.h        | 19 ++++-------
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/struct-funcs.c | 73 ++++++++++++++++++++++++++++++++++-------
 fs/btrfs/tree-log.c     |  7 ++--
 5 files changed, 83 insertions(+), 45 deletions(-)

-- 
2.22.0

