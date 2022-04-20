Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD3508328
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376633AbiDTILf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbiDTILd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:11:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31336283
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:08:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E28CF1F385
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650442126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OzE2h51pF7min95rPR9LYnwycmjVjn46MOPXMlErTG8=;
        b=XQQCMFXh3Qp4Z1lIRwcXu+iFy6VX3pRTRApBZN7sWMIQffvOsHPfPfrzZ6Co4Hb++zjca0
        KdwrF89/skfSz0sEBf9LLtvdi1JjoxNQEuUiSy+DKVWM2BgDQfDyPf3jFBz6MX7jblovqE
        r+1yLUc3EvUPoLjx9+wJPDJwCIMdi+I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AB4513AD5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yU0IN42/X2JEbAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:08:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: re-define btrfs_raid_types
Date:   Wed, 20 Apr 2022 16:08:26 +0800
Message-Id: <cover.1650441750.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
Changelog:
v2:
- Fix the start value of BTRFS_RAID_RAID0

v3:
- Introduce more static sanity checks
  They are kinda overkilled, but they are only compile time checks, it
  should be fine.

- Keep btrfs_bg_flags_to_raid_index() as regular function

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
  To make them match their value order.

- Use ilog2() to convert them into index

- Extra static_assert()s to make sure RAID0 is always the least
  significant bit in PROFILE_MASK


Qu Wenruo (2):
  btrfs: move definition of btrfs_raid_types to volumes.h
  btrfs: use ilog2() to replace if () branches for
    btrfs_bg_flags_to_raid_index()

 fs/btrfs/space-info.h           |  2 ++
 fs/btrfs/volumes.c              | 24 ++++++----------------
 fs/btrfs/volumes.h              | 35 +++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h | 13 ------------
 4 files changed, 43 insertions(+), 31 deletions(-)

-- 
2.35.1

