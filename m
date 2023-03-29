Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B342E6CD2AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjC2HKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjC2HKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF2530ED
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0E86219DA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YCxHLa+Rh4q5Y3ZAE3dVR4O/x1WpbqpY4NAZwqpmf4M=;
        b=qCb3nxIZWWf2lIYir2DG01bXTUZPNqh+aNfJD+FMAY5CTC3ufMedn6hkDp0umulurZl963
        QQ8TWYgNIzCWzBdaW1ItnqW6GuVFFPuRHkljDrpbrrtaFJn3Uk57ZAVLnLLdclVyBs04Cd
        YM2OK66irIw5oFPlEs7DF/Q4j6Hp47o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EA84138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RJ+NM0/kI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: scrub: finish the switch to scrub_stripe and cleanup the old code
Date:   Wed, 29 Mar 2023 15:09:44 +0800
Message-Id: <cover.1680073696.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series is based on my previous patchset "v7 btrfs: scrub: use a
more reader friendly code to implement scrub_simple_mirror()", the whole
series can be fetched from github:

  https://github.com/adam900710/linux/tree/scrub_stripe

After the mentioned patchset, only one path, scrub_raid56_parity(), is
still using the old facility.

[PATCH SPLIT]

This series would firstly migrate the only path to the new scrub_stripe
based solution.
The change should only affect RAID56, thus zoned mode should not be affected.

Then the remaining 5 patches to remove all the remaining code.
I have tried my best to split the cleanup, starting from RAID56 specific
code, to writeback, then approach the core scrub_bio facility.

If the split is not preferred, it should still be possible to fold all
the last 5 patches into one big cleanup.

[CODE SIZE REDUCTION]

The number of deletion should explain itself, and even with my previous
patchset included, it is still a big win:

 9 files changed, 1488 insertions(+), 2931 deletions(-)

Still a net reduce of almost 1500 lines.

Qu Wenruo (6):
  btrfs: scrub: use scrub_stripe to implement RAID56 P/Q scrub
  btrfs: scrub: remove scrub_parity structure
  btrfs: scrub: remove the old writeback infrastructure
  btrfs: scrub: remove the old scrub recheck code
  btrfs: scrub: remove scrub_block and scrub_sector structures
  btrfs: scrub: remove scrub_bio structure

 fs/btrfs/block-group.c |   11 -
 fs/btrfs/block-group.h |    8 -
 fs/btrfs/fs.h          |    1 -
 fs/btrfs/scrub.c       | 2740 ++++------------------------------------
 4 files changed, 212 insertions(+), 2548 deletions(-)

-- 
2.39.2

