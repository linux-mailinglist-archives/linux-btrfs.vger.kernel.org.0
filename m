Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4574F30ECE9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 08:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhBDHES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 02:04:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:56448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhBDHEO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 02:04:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612422208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NcwHYhXuHym6jP3grhGmMjB+ciojQqUypl7jPfUihGo=;
        b=NEWxSVjQ72GZY7Qhzs7zyeJZOXpZiUyHFQyCvp0Ei6i+y2AAgxgNjHBDbGpT4Dn3zyl+4m
        2grX9Jn6lTDi3w/nPTgbUoq1dX683G/MLRC5Q70C/KD+QPQMgYo39fkmQhaVfB5ULrR4D+
        Hy4sgA0cMLn3QM0Qp1e9IlBde9Djmsw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 239DFABD5
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 07:03:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: add proper subpage compress read support
Date:   Thu,  4 Feb 2021 15:03:22 +0800
Message-Id: <20210204070324.45703-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During the long time subpage development, I forgot to properly check
compression code after just one compression read success during early
development.

It turns out that, with current RO support, the compression read needs
more modification to make it work.

Thankfully, the patchset is small, and should not cause problems for
regular sectorsize == PAGE_SIZE case.

Thanks Anand for exposing the problems.

Qu Wenruo (2):
  btrfs: make btrfs_submit_compressed_read() to be subpage compatible
  btrfs: make check_compressed_csum() to be subpage compatible

 fs/btrfs/compression.c | 67 ++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 19 deletions(-)

-- 
2.30.0

