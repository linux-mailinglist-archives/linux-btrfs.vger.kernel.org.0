Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6FF61EC1B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiKGHcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 02:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiKGHcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 02:32:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F1AE
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 23:32:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8780322652
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667806369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=33CdSjVGo0ImpVsiGpb5qB1eNlR9Dv+0LXeoyVFa8r8=;
        b=JTSjq3Ectm4YIuOoTtP+XVHEKZYC7H1atcwk/Z9w+dihzQyP1dea3xu6aj/8XKNC0I9e3q
        ZrHEeh6IsZfzrbqcMCz7F7W29v5Z+A2fOkfzA18uV5UO92IyvxJsLaIzMDwErvZgXEvjLK
        YlDCyBJDog0ROAYNX4TYu9sQdC6hTD4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA02C13AC7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1xM4I6C0aGMmDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 07:32:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: raid56: make raid56 to use more accurate error bitmap for error detection
Date:   Mon,  7 Nov 2022 15:32:28 +0800
Message-Id: <cover.1667805755.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs raid56 uses stripe based error detection.

This means, any error (which vary from single sector csum mismatch, to a
missing device) will mark the whole horizontal stripe as error.

This can lead to some unexpected behavior, for example:


             0        32K       64K
     Data 1  |XXXXXXXX|         |
     Data 2  |        |XXXXXXXXX|
     Parity  |        |         |

When reading data 1 [0, 32K), we got csum mismatch and go RAID56
recovery path.

If going the old path, we will mark the whole data 1 [0, 64K) all as
error, and recover using data 2 and parity.

But since data 2 [32K, 64K) is also corrupted, the recovered data will
also be corrupted.

Thankfully such problem will be mostly avoided after commit f6065f8edeb2
("btrfs: raid56: don't trust any cached sector in
__raid56_parity_recover()"), as when we read the sectors in data 2 [32K,
64K), we will recover discarding all the cached result.


This patchset will change the behavior by introducing an error bitmap,
recording corrupted sector one by one, so for above case, at least we
won't try to recover data 1 [32K, 64K) using incorrect data.

The true solution to this destructive RMW problem will be read time csum
verification, but this patchset introduces the basis to handle extra
csum mismatch error better (csum mismatch will also be marked as error,
but only for the offending sectors).

This patchset itself doesn't improve the raid56 destructive RMW
situation by itself, but would make later destructive RMW fix much
easier to implement.

Qu Wenruo (3):
  btrfs: raid56: introduce btrfs_raid_bio::error_bitmap
  btrfs: raid56: migrate recovery and scrub recovery path to use
    error_bitmap
  btrfs: raid56: remove the old error tracing system

 fs/btrfs/raid56.c | 572 ++++++++++++++++++++++++++--------------------
 fs/btrfs/raid56.h |  19 +-
 2 files changed, 334 insertions(+), 257 deletions(-)

-- 
2.38.1

