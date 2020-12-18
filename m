Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A412DDDC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 06:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgLRFRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 00:17:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgLRFRw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 00:17:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608268625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4bG8Xt36tzaD0ai3AuPmVcayJogscdE1hm//PrR3W5A=;
        b=Wgu2CQ/h7eUf40pUoToJugkDZPxV7OIuTXhzJxxBhQjgf8yHW5bP5fmZNj/9EpM28njuAG
        I6GsfVfYI4Jv/D+eNN18z33Az1vdxTW4RWSa+y3ptvhTnUb5DLOSD+2LFRZcwn53yrOz0F
        DZ9oHiUM4UKYEy/RLuRnMv5zxinj3do=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC605AEBE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 05:17:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: btrfs_dec_test_*_ordered_extent() refactor
Date:   Fri, 18 Dec 2020 13:16:59 +0800
Message-Id: <20201218051701.62262-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This small patchset is btrfs_dec_test_*_ordered_extent() refactor during
subpage RW support development.

This is mostly to make btrfs_dev_test_* functions more human readable
and prepare it for calling btrfs_dec_test_first_ordered_extent() in
btrfs_writepage_endio_finish_ordered() where we can have one or more
ordered extents for one bvec.

Qu Wenruo (2):
  btrfs: make btrfs_dio_private::bytes to be u32
  btrfs: refactor btrfs_dec_test_* functions for ordered extents

 fs/btrfs/btrfs_inode.h  |  2 +-
 fs/btrfs/inode.c        |  7 ++-
 fs/btrfs/ordered-data.c | 98 ++++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.h | 10 ++---
 4 files changed, 62 insertions(+), 55 deletions(-)

-- 
2.29.2

