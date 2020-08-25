Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E782511AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgHYFsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 01:48:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgHYFsU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 01:48:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1C39ACCF
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 05:48:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/4] btrfs: basic refactor of btrfs_buffered_write()
Date:   Tue, 25 Aug 2020 13:48:04 +0800
Message-Id: <20200825054808.16241-1-wqu@suse.com>
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

  This time we kill that max(nrptrs, 8), and replace it to a fixed size
  up limit (64K), which should bring the same performance for different
  page sized.

  The limit can be changed if the 64K is not large enough for certain
  buffered write.

- Refactor the main loop into process_one_batch()
  No functional change, just plain refactor.

- Remove the again: tag by integrating page and extent locking
  The new function lock_pages_and_extent() will handle the retry so we
  don't need the tag any more in the main loop.

Changelog:
v2:
- Fix a bug that ENOSPC error is not returned to user space
  It's caused by a missing assignment for (copied < 0) branch in the 2nd
  patch.

v3:
- Rename get_nr_pages() to calc_nr_pages()
- Remove unnecessary parameter for calc_nr_pages()
- Change the upper limit of calc_nr_pages() in a separate patch


Qu Wenruo (4):
  btrfs: refactor @nrptrs calculation of btrfs_buffered_write()
  btrfs: refactor btrfs_buffered_write() into process_one_batch()
  btrfs: remove the again: tag in process_one_batch()
  btrfs: avoid allocating unnecessary page pointers

 fs/btrfs/file.c | 572 ++++++++++++++++++++++++++----------------------
 1 file changed, 305 insertions(+), 267 deletions(-)

-- 
2.28.0

