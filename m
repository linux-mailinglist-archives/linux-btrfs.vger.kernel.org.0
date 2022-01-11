Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE748A5B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 03:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbiAKCey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 21:34:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52260 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244116AbiAKCex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 21:34:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F9E62114D
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641868492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c6IJejq/aI0u4HuIaB9FT8BiC9qSpTXullLK+RpgFX4=;
        b=h70qL8MPA+VdatEsVDbrlb1UMj3hTvFkHO4SxyTqYnwt5DpSsp6dAHz2VYndOpcfJANLQp
        tW6SOOs0RGW+6RaQuQsMIEE59MdoXlkVTWBF+eFtJ27CKvik1vUlsrnL+6SAc2zRyPHquU
        P4eV+fNsXORSV7OpswS16Idtp/PPTf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF59E13A42
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oi09KMvs3GERFAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 02:34:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: support more pages sizes for the subpage support
Date:   Tue, 11 Jan 2022 10:34:31 +0800
Message-Id: <20220111023434.22915-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The series can be fetched from github:
https://github.com/adam900710/linux/tree/metadata_subpage_switch

Previously we only support 64K page size with 4K sector size for subpage
support.

There are two reasons for such requirement:

- Make sure no matter what the nodesize is, metadata can be fit into one
  page
  This is to avoid multi-page metadata handling.

- We use u16 as bitmap
  That means we will waste extra memory for smaller page sizes.

The 2nd problem is already solved by compacting all bitmap into one
large bitmap, in commit 72a69cd03082 ("btrfs: subpage: pack all subpage
bitmaps into a larger bitmap").

And this patchset will address the first problem by going to non-subpage
routine if nodesize >= PAGE_SIZE.

This will still leave a small limitation, that for nodesize >= PAGE_SIZE
and sectorsize < PAGE_SIZE case, we can not allow a tree block to cross
page boundary.

Thankfully we have btrfs-check to detect such problem, and mkfs and
kernel chunk allocator have already ensured all our metadata will not
cross such page boundaries.

The following combinations has been tested:
(p: page_size s: sectorsize, n: nodesize)

- p=64K s=4K n=64K (aarch64, RK3399/CM4)
  To cover the new metadata path

- p=64K s=4K n=16K (aarch64, RK3399/CM4)
- p=4k s=4k n=16k (x86_64)
  The make sure no new bugs in the old path

- p=16K s=4K n=16K (aarch64, M1)
- p=16K s=4K n=64K (aarch64, M1)
  Special thanks to Su Yue. He contributes his VM on M1 to me to do
  extra tests, and exposed a bug in the btrfs_read_sys_array() affecting
  16K page size cases.

Changelog:
RFC->v1:
- Remove one ASSERT() which is causing false alert
  As we have no way to distinguish unmapped extent buffer with anonymous
  page used by DIO/compression.

- Expand the subpage support to any PAGE_SIZE > 4K
  There is still a limitation on not allowing metadata block crossing page
  boundaries, but that should already be rare nowadays.

  Another limit is we still don't support 256K page size due to it's
  beyond max compressed extent size.

v2:
- Add extra supported sectorsizes in sysfs interface
  Now for page size > 4K, all sector sizes up to page size will be
  supported.

- Fix a bug in btrfs_read_sys_array() that would cause false alert
  Now btrfs_read_sys_array() will use dummy eb, and
  set/clear_extent_buffer_uptodate() will handle both dummy and subpage
  cases properly.

- Fix a bug in check_eb_alignment() that would cause false alert
  Since we handle nodesize >= PAGE_SIZE cases with the same page based
  metadata routine, we need to make sure metadata is page aligned for
  that case.

Qu Wenruo (3):
  btrfs: use dummy extent buffer for super block sys chunk array read
  btrfs: make nodesize >= PAGE_SIZE case to reuse the non-subpage
    routine
  btrfs: expand subpage support to any PAGE_SIZE > 4K

 fs/btrfs/disk-io.c   |  20 ++++++---
 fs/btrfs/extent_io.c | 102 ++++++++++++++++++++++++++++---------------
 fs/btrfs/inode.c     |   2 +-
 fs/btrfs/subpage.c   |  30 ++++++-------
 fs/btrfs/subpage.h   |  25 +++++++++++
 fs/btrfs/sysfs.c     |  11 +++--
 fs/btrfs/volumes.c   |  27 ++----------
 7 files changed, 130 insertions(+), 87 deletions(-)

-- 
2.34.1

