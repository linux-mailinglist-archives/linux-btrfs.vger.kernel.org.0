Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865E758D24
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 07:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjGSFbB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 01:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSFa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 01:30:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A68C119
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 22:30:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 971191F8BE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689744646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=R9+dhcpCV4bsHifr1/11Ls0H9L7Ow1xOGoHLiogSkrU=;
        b=nrIDK68axzwlVWb3GY1K2Wj8UFV1aWXcbf+prQI1XxW/th7fviQ5Xw6mYgOLkJbVjTlxtE
        Vu2JXjz8Fl1dCA7upjmhRCDau/+ri0R3FaGZ6qKfUvk6vNuFFpzLZKZDnY8/INHpyj+my3
        RDR22Wf49iDa73JB/ChHb31EtnOiDmo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8695138EE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0OTdKwV1t2R7JQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/4] btrfs: scrub: make sctx->stripes[] a ring buffer
Date:   Wed, 19 Jul 2023 13:30:22 +0800
Message-ID: <cover.1689744163.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

!!! DO NOT MERGE !!!

This is the attempt to increase the queue depth of the scrub behavior.

Although it has a slight increase on the queue depth, it's not enough to
cause any obvious performance increase.

It's still short of 2GiB/s.

The patchset's idea is to avoid any unnecessary wait, by making
sctx->stripes[] a ring buffer, callers just grab the current slot and
queue the stripe.

The wait only happens when the current slot is still under scrub.

Unfrotauntely the benchmark doesn't help much, meaning the bottleneck is
not at the deidcated wait when the sctx->stripes[] are full.

Thus this patch is mostly sent asking for better ideas.

I'll try manually merging the read requests to see if we can get
anything better.

Qu Wenruo (4):
  btrfs: scrub: move write back of repaired sectors into
    scrub_stripe_read_repair_worker()
  btrfs: scrub: don't go ordered workqueue for dev-replace
  btrfs: scrub: use btrfs workqueue to synchronize the write back for
    dev-replace
  btrfs: scrub: make sctx->stripes[] array work as a ring buffer

 fs/btrfs/fs.h    |   2 +-
 fs/btrfs/scrub.c | 493 ++++++++++++++++++++++++-----------------------
 2 files changed, 249 insertions(+), 246 deletions(-)

-- 
2.41.0

