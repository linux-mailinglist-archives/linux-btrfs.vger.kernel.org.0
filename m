Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4575AC52
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 12:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGTKsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGTKsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 06:48:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABF1986
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 03:48:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1532A20684
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689850114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ycvdadbwffAiN+IRqjAQ7MeMst2wfTWa/zL1x5yKyWc=;
        b=GxJ38/faXguVz+hHy8AzaNGe6kyx1oMT6C02uHuFgh+IDiJG5+2IQjaslZS9EhYgCVbEZh
        C+8taUpTZI18ylYFxooal3wef8X58Psl4tWQGInWl64P27TF9wGjlKhXhZXdetvKmrG44X
        ydiztm+Umwttg3YMZhGc79uzDsGuOQA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51814133DD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wR8LBgERuWQBcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 10:48:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: scrub: fix the scrub performance regression caused by unnecessary extent/csum tree searchs
Date:   Thu, 20 Jul 2023 18:48:10 +0800
Message-ID: <cover.1689849582.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although patch "btrfs: scrub: fix grouping of read IO" fixed one of the
major performance regression of scrub, it still only get the performance
back to 2GiB/s, it's still only 66% of the old 3GiB/s.

During my local debug, I found that the data csum fulfilling by itself
can be a big bottleneck.
If I completely skip the data csum fulfilling, it can already improve
the performance to around 2.6GiB/s (but of course it makes no sense
without data csums).

This reminds me a big factor, since we're doing scrub in stripe unit,
it would cause a lot of more extent/csum tree search.

In fact, the old code is doing csum search for every 512KiB, while we're
doing the same search for every 64KiB, causing 8x increase in csum tree
search.

Thus this patch would reduce the extent/csum tree search by re-using the
paths.

This two points along would already improve the performance to a much
more acceptable 2.5GiB/s. (83% of the old performance).

And those two patches are small enough for backports.

The remaining 3 patches are mostly cleanups.

Qu Wenruo (5):
  btrfs: scrub: avoid unnecessary extent tree search preparing stripes
  btrfs: scrub: avoid unnecessary csum tree search preparing stripes
  btrfs: scrub: move write back of repaired sectors into 
    scrub_stripe_read_repair_worker()
  btrfs: scrub: don't go ordered workqueue for dev-replace
  btrfs: scrub: extract the stripe group submission into a helper

 fs/btrfs/file-item.c |  33 +++++----
 fs/btrfs/file-item.h |   6 +-
 fs/btrfs/raid56.c    |   4 +-
 fs/btrfs/scrub.c     | 156 +++++++++++++++++++++++++++++--------------
 4 files changed, 133 insertions(+), 66 deletions(-)

-- 
2.41.0

