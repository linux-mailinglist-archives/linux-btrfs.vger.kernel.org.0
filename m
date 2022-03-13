Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8273B4D7446
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Mar 2022 11:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiCMKlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Mar 2022 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiCMKla (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Mar 2022 06:41:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96614004
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 03:40:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBF17212C7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647168020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F/KZyxi/NZJMza4/wdD2QSm8EBwVycMbrZO1yjcTDzU=;
        b=cWkE+kDxUCB89FPyzDG4I4HzQWnuh0vF1ieufENkzDnLx8d54zsXtJ0eAH3fd54Yml8p+0
        d3CJ92hoy0JEvlNmYKxpthWfgeSQ4FFmVgN2AiWjdmfKIsohgYFfEber1tp+aJgYtlryz8
        enyFfuzC5Hu6wc8SzF04Qoau59zACRU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3592F13AF7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MgCaOxPKLWLUFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: scrub: big renaming to address the page and sector difference
Date:   Sun, 13 Mar 2022 18:39:59 +0800
Message-Id: <cover.1647161284.git.wqu@suse.com>
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
v2:
- Rebased to misc-next directly, before scrub entrance refactor
  As this patchset is safer than entrance refactor.

  Minor conflicts due to scrub_remap() renaming.

v3:
- Get rid of the name "ssector", using "sector" directly.
  Previously we use names like "spage" to avoid confusion between MM
  layer page, and scrub page.
  But now since we rename it to scrub sector, and there is no naming
  conflicts, we are safe to use "sector" directly, without the eye
  hurting "ss".

- Use names like "sectors" to replace "pagev"
  Which is more close to our latest naming schema.

- Update involved comments to use latest style

- Use bitshift to convert from sectors to bytes


This patchset can be cherry-picked from my github repo:
https://github.com/adam900710/linux/tree/refactor_scrub

They are the first 3 patches after misc-next.

From the ancient day, btrfs doesn't support sectorsize < PAGE_SIZE, thus
a lot of the old code consider one page == one sector, not only the
behavior, but also the naming.

This is no longer true after v5.16 since we have subpage support.

One of the worst location is scrub, we have tons of things named like
scrub_page, scrub_block::pagev, scrub_bio::pagev.

Even scrub for subpage is supported, the naming is not touched yet.

This patchset will first do the rename, providing the basis for later
scrub enhancement for subpage.

This patchset should not bring any behavior change.

Qu Wenruo (3):
  btrfs: scrub: rename members related to scrub_block::pagev
  btrfs: scrub: rename scrub_page to scrub_sector
  btrfs: scrub: rename scrub_bio::pagev[] and related members

 fs/btrfs/scrub.c | 693 +++++++++++++++++++++++------------------------
 1 file changed, 346 insertions(+), 347 deletions(-)

-- 
2.35.1

