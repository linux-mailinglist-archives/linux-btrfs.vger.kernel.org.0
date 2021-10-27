Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D543C21F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 07:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhJ0F0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 01:26:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50418 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbhJ0F0p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 01:26:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 779ED1FD40
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635312259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qo4mnz+GgeWNUgbilcAJhBG+SxrmOOilSpXFNt56VME=;
        b=Mm3KYuG+GVoKYFdjzT8KuXmE17gHvAikEK0vNxdSLXEi9JXe8V5MHxZdHNdJ1+NLHyJo4b
        6mMs+vhUODc/ZZ7s382DD1Q4AwFlSo+Xu9BWmdwv5LMWPIUbJwf+iTmNeBb4Bfhrhbl9wU
        yf7mqjToRc+54XQjUgUL5hqMd+/qFAY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE9DF13D13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UF7PIILieGE/RQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 05:24:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: re-define btrfs_raid_types
Date:   Wed, 27 Oct 2021 13:23:59 +0800
Message-Id: <20211027052401.43248-1-wqu@suse.com>
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

