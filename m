Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB343C235
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 07:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbhJ0Fbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 01:31:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbhJ0Fbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 01:31:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 629EA21963
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635312557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mgkyF4mS0Y2ITlX3YMEgtLRpsJJgGjN+AykTcY/FdV0=;
        b=kHFezMx1y5wuH/il6fZQTPtUQykpiKDURadpEql+JFL7w/ioDYT08sEXBaqH4ozgSdW8w+
        PQa52cwl60dPRlJJ2nu+hfkgsbiyCrzCuyGwImj/Phpamf30uC43ADFrsLldW22UOJ8aIO
        C06IdYngEKoaj56bajGE1euzRUzz4/A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8A4413D13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id acIKG6zjeGH3RgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:29:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: re-define btrfs_raid_types
Date:   Wed, 27 Oct 2021 13:28:57 +0800
Message-Id: <20211027052859.44507-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By the nature of BTRFS_BLOCK_GROUP_* profiles, converting the flag into
an index should only need one bits AND, one if () check for SINGLE
profile, one right shift to align the values, one ilog2() call which is
normally converted into ffs() assembly code.

But we're using a lot of if () branches to do the convert.

This patch will re-define btrfs_raid_types by:

- Move it to volumes.h
  btrfs_raid_types are only used internally, no need to be exposed
  through UAPI.

- Re-order btrfs_raid_types
  To make them match their value order

- Use ilog2() to convert them into index

- Inline btrfs_bg_flags_to_raid_index()
  It's just 5 assembly commands now.

Changelog:
v2:
- Fix the start value of BTRFS_RAID_RAID0

Qu Wenruo (2):
  btrfs: move definition of btrfs_raid_types to volumes.h
  btrfs: use ilog2() to replace if () branches for
    btrfs_bg_flags_to_raid_index()

 fs/btrfs/space-info.h           |  2 ++
 fs/btrfs/volumes.c              | 26 -----------------------
 fs/btrfs/volumes.h              | 37 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/btrfs_tree.h | 13 ------------
 4 files changed, 38 insertions(+), 40 deletions(-)

-- 
2.33.1

