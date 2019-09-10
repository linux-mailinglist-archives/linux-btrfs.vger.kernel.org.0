Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB3AE4C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfIJHkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 03:40:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729189AbfIJHkY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 03:40:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E670B011
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:40:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] Small code style cleanup for ctree.c
Date:   Tue, 10 Sep 2019 15:40:16 +0800
Message-Id: <20190910074019.23158-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some small enhance found during the btrfs_verify_level_key() rework.

Qu Wenruo (3):
  btrfs: ctree: Reduce one indent level for btrfs_search_slot()
  btrfs: ctree: Reduce one indent level for btrfs_search_old_slot()
  btrfs: ctree: Remove stalled comment of setting up path lock

 fs/btrfs/ctree.c | 211 +++++++++++++++++++++++------------------------
 1 file changed, 101 insertions(+), 110 deletions(-)

-- 
2.23.0

