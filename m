Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96AC24F28C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgHXGbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 02:31:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHXGbo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 02:31:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D590AE56
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 06:32:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: basic refactor of btrfs_buffered_write()
Date:   Mon, 24 Aug 2020 14:31:36 +0800
Message-Id: <20200824063139.70880-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset will refactor btrfs_buffered_write() by:
- Extra the nrptrs calculation into one function
  The main concern here is the batch number of pages.
  Originally there is a max(nrptrs, 8), which looks so incorrect that my
  eyes change it to min(nrptrs, 8) automatically.

  This time we kill that max(nrptrr, 8), and replace it to a fixed size
  up limit (64K), which should bring the same performance for different
  page sized.

  The limit can be changed if the 64K is not large enough for certain
  buffered write.

- Refactor the main loop into process_one_batch()
  No functional change, just plain refactor.

- Remove the again: tag by integrating page and extent locking
  The new function lock_pages_and_extent() will handle the retry so we
  don't need the tag any more in the main loop.

Qu Wenruo (3):
  btrfs: change how we calculate the nrptrs for btrfs_buffered_write()
  btrfs: refactor btrfs_buffered_write() into process_one_batch()
  btrfs: remove the again: tag in process_one_batch()

 fs/btrfs/file.c | 568 +++++++++++++++++++++++++-----------------------
 1 file changed, 301 insertions(+), 267 deletions(-)

-- 
2.28.0

