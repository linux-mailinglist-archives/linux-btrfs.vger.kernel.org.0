Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3786E069A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDMF5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 01:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMF5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 01:57:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E892B72B5
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 22:57:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 913D91FD66
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681365456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9FJRMAVx9J3r6yvM2hyFAnQ6HjFbQeM1roM3s2I6a3E=;
        b=i4+hwhnpOFidHY92o/YJnXPgCyx8R2/vuvJT1q3DmUv9tpIfh0lJRwA8dM5eG0tBmqZAPQ
        +iSP3gUmNmnrnnv8AfB1O7ymp8ExIxR42L6Sn84u6yQziKhWQnfN7yWHVuwTrIr5WMooiZ
        4wAO8cNwRR38guD4j2Kna4PmlbcGqSg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F38371390E
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rEP3L8+ZN2QxVgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:57:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: reduce the duplicated reads during P/Q scrub
Date:   Thu, 13 Apr 2023 13:57:16 +0800
Message-Id: <cover.1681364951.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
It's a known problem that btrfs scrub for RAID56 is pretty slow.

[CAUSE]
One of the causes is that we read the same data stripes at least twice
during P/Q stripes scrub.

This means, during a full fs scrub (one scrub process for each device),
there will be quite some extra seeks just because of this.

[FIX]
The truth is, scrub stripes have a much better view of the data stripes.
As btrfs would firstly verify all data stripes, and only continue
scrubing the P/Q stripes if all the data stripes is fine after needed
repair.

So this means, as long as there is no new RMW writes into the RAID56
block group, we can re-use the scrub cache for P/Q verification.

This patchset would fix it by:

- Ensure the RAID56 block groups are marked read-only for scrub
  This is to avoid RMW in to the block group, or scrub cache is no
  longer reliable.

- Introduce a new interface to pass cached pages to RAID56 cache
  The only disadvantage is here we still need to do page copy, due to
  the uncertain lifespan of an rbio.

Qu Wenruo (2):
  btrfs: scrub: try harder to mark RAID56 block groups read-only
  btrfs: scrub: use recovered data stripes as cache to avoid unnecessary
    read

 fs/btrfs/block-group.c | 16 +++++++++++++--
 fs/btrfs/raid56.c      | 46 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h      |  3 +++
 fs/btrfs/scrub.c       | 16 ++++++++++++++-
 4 files changed, 78 insertions(+), 3 deletions(-)

-- 
2.39.2

