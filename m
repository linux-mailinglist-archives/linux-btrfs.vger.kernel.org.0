Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C120587749
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiHBGxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiHBGx3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 02:53:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454595FFC
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 23:53:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61DEA3465D
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659423203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ATyHcvsn2cZzii0+eSr7qjUEsOZgVGkXDMd7Q7/F1DM=;
        b=ZPDpRA5hYlMRXqEwVtYKk1T5NUTyAPQmWvSR1JgsOW6icObXZrSmMRZBmtx0EuUTf4b3vg
        FsIpELazzNLVOcjodo3DN/4Sf9SM+jp3rpIhnIoW4l2OL1hznMCeW50zOnjWsSt9gHVMc2
        NkCDOBLMXnkWpVdy6c6Hn74giPIQnX4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A10131345B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eTrAGeLJ6GKVHwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 06:53:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: scrub: small enhancement related to super block errors
Date:   Tue,  2 Aug 2022 14:53:01 +0800
Message-Id: <cover.1659423009.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently during a new test case to verify btrfs can handle a fully
corrupted disk (but with a good primary super block), I found that scrub
doesn't really try to repair super blocks.

And scrub doesn't report super block errors in dmesg either.

So this small patchset is to fix the problems by:

- Add explicit error messages for super block errors
- Try to fix super block errors by committing a transaction

Qu Wenruo (2):
  btrfs: scrub: properly report super block errors in dmesg
  btrfs: scrub: try to fix super block errors

 fs/btrfs/scrub.c | 71 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

-- 
2.37.0

