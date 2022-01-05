Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7654F484C78
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 03:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiAEC2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 21:28:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiAEC2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 21:28:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 985F51F37B
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 02:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641349711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t7VSAmOMVcXn2D1BlN+AsLTB1GVACvZWV6KWNTEUkIg=;
        b=h+SRDAiVMt6Pq1gfOIrTeCWWqDU9ENdjd7WKzl+3qTJ6BTtLl2uk1nVr0xbu8c0+bFlgGG
        UiVhBRuNC8SVhULvAEX+Gu768awcIlgAKK3M1basvx595v0eXMVBTn8B2GzHbH575aUixk
        6dRZq6cfHBy5OwEBT0ETs3OfAx2E+oQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDF7213B71
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 02:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k6Y1I04C1WHLKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 02:28:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: support more pages sizes for the subpage support
Date:   Wed,  5 Jan 2022 10:28:10 +0800
Message-Id: <20220105022812.45698-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

I have only tested the following combinations:

- aarch64 64K page size, 4K sectorsize, 64K nodesize
  To cover the new metadata path

- aarch64 64K page size, 4K sectorsize, 16K nodesize
- x86_64 4K page size, 4K sectorsize, 16K nodesize
  The make sure no new bugs in the old path

Unfortunately I don't have aarch64 platform which supports 16K page
size, thanks to Su Yue, he is doing the test on VM on Apple M1 chips,
and he didn't find new regressions.

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

Qu Wenruo (2):
  btrfs: make nodesize >= PAGE_SIZE case to reuse the non-subpage
    routine
  btrfs: expand subpage support to any PAGE_SIZE > 4K

 fs/btrfs/disk-io.c   | 20 +++++++----
 fs/btrfs/extent_io.c | 80 ++++++++++++++++++++++++++------------------
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/subpage.c   | 30 ++++++++---------
 fs/btrfs/subpage.h   | 25 ++++++++++++++
 5 files changed, 102 insertions(+), 55 deletions(-)

-- 
2.34.1

