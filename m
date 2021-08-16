Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D13ECE3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 08:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhHPGBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 02:01:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38810 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhHPGBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 02:01:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 781BD21F39
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629093640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Hrmg3PeJYVM18/Rqftu9JBqBp5O78RZZwGDOExLDzos=;
        b=GLd8kMsVZRFvRz1lAeImhdkN8Iy92/PeF8VtN3aYd5hSdTaVhNbynBuQPL79itXHOOy90w
        hZfQ2X/AoH5fle7Zr0oiVetnDuzYvY9wXgvmpxZ4NgSmmot3QKn/UtO3z8dPH7/qhG7jpC
        dcjsXSbkX65z9gVzdmYS+9Rj6bS2IjQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA8C136A6
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 06:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0PJOFgf/GWE3UQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 06:00:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: subpage: pack all subpage bitmaps into a larger bitmap
Date:   Mon, 16 Aug 2021 14:00:34 +0800
Message-Id: <20210816060036.57788-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we use u16 bitmap to make 4k sectorsize work for 64K page
size.

But this u16 bitmap is not large enough to contain larger page size like
128K, nor is space efficient for 16K page size.

To handle both cases, here we pack all subpage bitmaps into a larger
bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
subpage usage.

This is the first step towards more page size support.

Although to really enable extra page size like 16K and 128K, we need to
rework the metadata alignment check first.
Which will happen in another patchset.


Qu Wenruo (2):
  btrfs: introduce btrfs_subpage_bitmap_info
  btrfs: subpage: pack all subpage bitmaps into a larger bitmap

 fs/btrfs/ctree.h     |   1 +
 fs/btrfs/disk-io.c   |  12 ++-
 fs/btrfs/extent_io.c |  58 +++++++++------
 fs/btrfs/subpage.c   | 172 ++++++++++++++++++++++++++++++++-----------
 fs/btrfs/subpage.h   |  41 +++++++----
 5 files changed, 201 insertions(+), 83 deletions(-)

-- 
2.32.0

