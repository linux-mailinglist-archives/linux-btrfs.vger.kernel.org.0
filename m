Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9145619C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhKRRkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 12:40:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhKRRko (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 12:40:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B7C1E1FD38;
        Thu, 18 Nov 2021 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637257062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gr4vTY2qmq+4abZaqjY58lKDgGoIRxKbq/34OYSg12s=;
        b=DyyId0ieskvMDaBOVlUlhes5ODIBreBFDnHdGD7IDaGYOiyig/KYf4qN0eSxpgYmpyDmkm
        CJ+DLkBERnC0Gxr068PLrSGblt7+YF2DAv5V+YzYkF4v+QZQdvfFWaqYjd9QB4/ghoHQE5
        sRMkY0+pNLLanz6HdGqGczLVvZyNb4U=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AF43EA3B81;
        Thu, 18 Nov 2021 17:37:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37055DA735; Thu, 18 Nov 2021 18:37:38 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.16-rc2
Date:   Thu, 18 Nov 2021 18:37:37 +0100
Message-Id: <cover.1637255480.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

there are several fixes and one old ioctl deprecation. Namely there's
fix for crashes/warnings with lzo compression that was suspected to be
caused by first pull merge resolution, but it was a different bug.

The branch is based on the previous pull so there's still a conflict in
lzo.c but this time it's a trivial one (diff below). I've also tested
the branches with/without the fix and on both 64bit and 32bit hosts so
there should be no surprises.

The ioctl deprecation patch is new but it's just adding a warning
message, there's no reason to delay that for another full release.

Changes:

* regression, fix crash in lzo due to missing boundary checks of page
  array

* fix crashes on ARM64 due to missing barriers when synchronizing
  status bits between work queues

* silence lockdep when reading chunk tree during mount

* fix false positive warning in integrity checker on devices with
  disabled write caching

* fix signedness of bitfields in scrub

* start deprecation of balance v1 ioctl

Please pull, thanks.

Conflict resolution:

diff --cc fs/btrfs/lzo.c
index 65cb0766e62d,f410ceabcdbd..9febb8025825
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@@ -131,8 -132,10 +132,11 @@@ static int copy_compressed_data_to_page
  	u32 sector_bytes_left;
  	u32 orig_out;
  	struct page *cur_page;
 +	char *kaddr;
  
+ 	if ((*cur_out / PAGE_SIZE) >= max_nr_page)
+ 		return -E2BIG;
+ 
  	/*
  	 * We never allow a segment header crossing sector boundary, previous
  	 * run should ensure we have enough space left inside the sector.
@@@ -160,7 -162,9 +164,11 @@@
  		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
  				     orig_out + compressed_size - *cur_out);
  
 +		kunmap(cur_page);
++
+ 		if ((*cur_out / PAGE_SIZE) >= max_nr_page)
+ 			return -E2BIG;
+ 
  		cur_page = out_pages[*cur_out / PAGE_SIZE];
  		/* Allocate a new page */
  		if (!cur_page) {
@@@ -202,7 -202,7 +210,8 @@@ int lzo_compress_pages(struct list_hea
  	struct workspace *workspace = list_entry(ws, struct workspace, list);
  	const u32 sectorsize = btrfs_sb(mapping->host->i_sb)->sectorsize;
  	struct page *page_in = NULL;
 +	char *sizes_ptr;
+ 	const unsigned long max_nr_page = *out_pages;
  	int ret = 0;
  	/* Points to the file offset of input data */
  	u64 cur_in = start;

----------------------------------------------------------------
The following changes since commit d1ed82f3559e151804743df0594f45d7ff6e55fa:

  btrfs: remove root argument from check_item_in_log() (2021-10-29 12:39:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc1-tag

for you to fetch changes up to 6c405b24097c24cbb11570b47fd382676014f72e:

  btrfs: deprecate BTRFS_IOC_BALANCE ioctl (2021-11-16 16:51:19 +0100)

----------------------------------------------------------------
Colin Ian King (1):
      btrfs: make 1-bit bit-fields of scrub_page unsigned int

Filipe Manana (1):
      btrfs: silence lockdep when reading chunk tree during mount

Nikolay Borisov (2):
      btrfs: fix memory ordering between normal and ordered work functions
      btrfs: deprecate BTRFS_IOC_BALANCE ioctl

Qu Wenruo (1):
      btrfs: fix a out-of-bound access in copy_compressed_data_to_page()

Wang Yugui (1):
      btrfs: check-integrity: fix a warning on write caching disabled disk

 fs/btrfs/async-thread.c | 14 ++++++++++++++
 fs/btrfs/disk-io.c      | 14 +++++++++++++-
 fs/btrfs/ioctl.c        |  4 ++++
 fs/btrfs/lzo.c          | 12 +++++++++++-
 fs/btrfs/scrub.c        |  4 ++--
 fs/btrfs/volumes.c      | 18 +++++++++++++-----
 6 files changed, 57 insertions(+), 9 deletions(-)
