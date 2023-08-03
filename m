Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FBC76E046
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjHCGdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 02:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHCGdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 02:33:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35431724
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 23:33:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82873219B2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691044431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SHPywMMKT6M8Bzeemiwh3Ff8BksZPQAGjhU6qzmNbHc=;
        b=jWaJ4je6E8++CcDhKvQWEpGh69yV1udh8GzL+rej24xc3EPS+FzJfAJbp8KBbMwgls9PIq
        Dgrr2msxysWveLgqCoRT8sNYqdSrw4+ujLZ6xDIxNlcmfhA5ZsY1/jmVCX0SpfBncQhI8w
        fIU+atmPckt8OSbtR60MIW3EQKglcvM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5B5C134B0
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4yWZJ05Ky2SjGAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 06:33:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: scrub: improve the scrub performance
Date:   Thu,  3 Aug 2023 14:33:28 +0800
Message-ID: <cover.1691044274.git.wqu@suse.com>
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

[REPO]
https://github.com/adam900710/linux/tree/scrub_testing

[CHANGELOG]
v2:
- Fix a double accounting error in the last patch
  scrub_stripe_report_errors() is called twice, thus doubling the
  accounting.

v1:
- Rebased to latest misc-next

- Rework the read IO grouping patch
  David has found some crashes mostly related to scrub performance
  fixes, meanwhile the original grouping patch has one extra flag,
  SCRUB_FLAG_READ_SUBMITTED, to avoid double submitting.

  But this flag can be avoided as we can easily avoid double submitting
  just by properly checking the sctx->nr_stripe variable.

  This reworked grouping read IO patch should be safer compared to the
  initial version, with better code structure.

  Unfortunately, the final performance is worse than the initial version
  (2.2GiB/s vs 2.5GiB/s), but it should be less racy thus safer.

- Re-order the patches
  The first 3 patches are the main fixes, and I put safer patches first,
  so even if David still found crash at certain patch, the remaining can
  be dropped if needed.

There is a huge scrub performance drop introduced by v6.4 kernel, that 
the scrub performance is only around 1/3 for large data extents.

There are several causes:

- Missing blk plug
  This means read requests won't be merged by block layer, this can
  hugely reduce the read performance.

- Extra time spent on extent/csum tree search
  This including extra path allocation/freeing and tree searchs.
  This is especially obvious for large data extents, as previously we
  only do one csum search per 512K, but now we do one csum search per
  64K, an 8 times increase in csum tree search.

- Less concurrency
  Mostly due to the fact that we're doing submit-and-wait, thus much
  lower queue depth, affecting things like NVME which benefits a lot
  from high concurrency.

The first 3 patches would greately improve the scrub read performance,
but unfortunately it's still not as fast as the pre-6.4 kernels.
(2.2GiB/s vs 3.0GiB/s), but still much better than 6.4 kernels (2.2GiB
vs 1.0GiB/s).

Qu Wenruo (5):
  btrfs: scrub: avoid unnecessary extent tree search preparing stripes
  btrfs: scrub: avoid unnecessary csum tree search preparing stripes
  btrfs: scrub: fix grouping of read IO
  btrfs: scrub: don't go ordered workqueue for dev-replace
  btrfs: scrub: move write back of repaired sectors into
    scrub_stripe_read_repair_worker()

 fs/btrfs/file-item.c |  33 +++---
 fs/btrfs/file-item.h |   6 +-
 fs/btrfs/raid56.c    |   4 +-
 fs/btrfs/scrub.c     | 235 ++++++++++++++++++++++++++-----------------
 4 files changed, 169 insertions(+), 109 deletions(-)

-- 
2.41.0

