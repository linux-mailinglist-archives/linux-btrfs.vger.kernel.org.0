Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6454143BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhIVI3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 04:29:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40886 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhIVI2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 04:28:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C915B22274
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632299244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2W9qkNOcDOGcaGCHJJ+wABzHr9RyBsRxGE1hsaekF5A=;
        b=aCEb08c3HJx/uX1+3FTrNgROvEKrxRqBilqZTc5PhRB876Qa9N2Uk71+qRqbCOIXAOA76L
        MWjssK7oL0O0rvuNbwj9AM/uXEW9d32jBgNX/W8K3UoN6VGESZZQj2UuKPImiBbaahJYd8
        pGvXq6mGmm3129k4GG9zP2pdJ/chtgQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C86013D65
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id maFsL+voSmEPDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 08:27:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/3] btrfs: refactor how we handle btrfs_io_context and slightly reduce memory usage for both btrfs_bio and btrfs_io_context
Date:   Wed, 22 Sep 2021 16:27:03 +0800
Message-Id: <20210922082706.55650-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_io_context is utilized as both bio->bi_private for
mirrored stripes, and stripes mapping for RAID56.

This makes some members like btrfs_io_context::private to be there.

But in fact, since almost all bios in btrfs have btrfs_bio structure
appended, we don't really need to reuse bio::bi_private for mirrored
profiles.

So this patchset will:

- Introduce btrfs_bio::bioc member
  So that btrfs_io_context don't need to hold @private.
  This modification is still a net increase for memory usage, just
  a trade-off between btrfs_io_context and btrfs_bio.

- Replace btrfs_bio::device with btrfs_bio::stripe_num
  This reclaim the memory usage increase for btrfs_bio.

  But unfortunately, due to the short life time of btrfs_io_context,
  we don't have as good device status accounting as the old code.

  Now for csum error, we can no longer distinguish source and target
  device of dev-replace.

  This is the biggest blockage, and that's why it's RFC.

The result of the patchset is:

btrfs_bio:		size: 240 -> 240
btrfs_io_context:	size: 88 -> 80

Although to really reduce btrfs_bio, the main target should be
csum_inline.

Qu Wenruo (3):
  btrfs: add btrfs_bio::bioc pointer for further modification
  btrfs: remove redundant parameters for submit_stripe_bio()
  btrfs: replace btrfs_bio::device member with stripe_num

 fs/btrfs/compression.c |  6 ++----
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent_io.c   |  2 --
 fs/btrfs/inode.c       | 30 +++++++++++++++++++++++++++---
 fs/btrfs/raid56.c      |  1 -
 fs/btrfs/volumes.c     | 23 +++++++++++++----------
 fs/btrfs/volumes.h     | 11 ++++++++---
 7 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.33.0

