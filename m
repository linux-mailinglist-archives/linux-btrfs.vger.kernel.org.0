Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81AC3BF94D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGHLuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:50:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59852 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHLuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:50:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6E6E321FB4;
        Thu,  8 Jul 2021 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625744860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vBEvCVNuVJk/4BGijECpDVqlE8BWJ3rPax75QRUN+Nw=;
        b=rVVRtJhTs8i1L6lPr5FVAlDZN2NNP15aGJpBO4ovZwdEsFJMTcJ2P8mDL8zpIjXDB8SHug
        JQ0pqS8NZiI37fdl+UOra1TlXG8h5PlmPdX0Khc0Bic7Bak9Is3bX1tzaSfx2hVzNILcZ9
        tsbLKy2NkZkrnq6Hz/edslJuTvjNY8s=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66D3DA3B89;
        Thu,  8 Jul 2021 11:47:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 465D7DAF79; Thu,  8 Jul 2021 13:45:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
Date:   Thu,  8 Jul 2021 13:45:06 +0200
Message-Id: <cover.1625043706.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The highmem was maybe was a good idea long time ago but with 64bit
architectures everywhere I don't think we need to take it into account.
This does not mean this 32bit won't work, just that it won't try to use
temporary pages in highmem for compression and raid56. The key word is
temporary. Combining a very fast device (like hundreds of megabytes
throughput) and 32bit machine with reasonable memory (for 32bit, like
8G), it could become a problem once low memory is scarce.

David Sterba (6):
  btrfs: drop from __GFP_HIGHMEM all allocations
  btrfs: compression: drop kmap/kunmap from lzo
  btrfs: compression: drop kmap/kunmap from zlib
  btrfs: compression: drop kmap/kunmap from zstd
  btrfs: compression: drop kmap/kunmap from generic helpers
  btrfs: check-integrity: drop kmap/kunmap for block pages

 fs/btrfs/check-integrity.c | 11 +++-------
 fs/btrfs/compression.c     |  6 ++----
 fs/btrfs/inode.c           |  3 +--
 fs/btrfs/lzo.c             | 42 +++++++++++---------------------------
 fs/btrfs/raid56.c          | 10 ++++-----
 fs/btrfs/zlib.c            | 42 +++++++++++++-------------------------
 fs/btrfs/zstd.c            | 33 +++++++++++-------------------
 7 files changed, 49 insertions(+), 98 deletions(-)

-- 
2.31.1

