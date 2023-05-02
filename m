Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE66F3B95
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjEBBCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjEBBCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 21:02:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DE3584
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 18:02:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 131E21F74D
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682989325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wDbGRNwE6kUez33ABZWd4e0bx3jyPcPMvE/S+COBPCM=;
        b=uTCdFnrveWb1HR1vdbiUy0LnuABpL2XHfKSZpQLFdj9feAwuqv/WZ1bFa4Om+6Ebg772Af
        71yVbeBtn5+MaATOOu5h2Hw82fUaZRdUelInGrN+CP/B0ceNg2DlveNdd0WebFaWqLKVQd
        WjCmq2YxNG7y83atG7GP5isgtbCzh28=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C0C013580
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 01:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOPuCAxhUGTldQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 01:02:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: add the ability to enable fst for btrfstune
Date:   Tue,  2 May 2023 09:01:43 +0800
Message-Id: <cover.1682988988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
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

At the beginning of free space tree feature, it's enabled by
"space_cache=v2" mount option.

However this introduced some problems:

- Lack of proper v1 cache clearing in the past
  In the past we didn't properly clear v1 cache before enabling v2.

- More and more complex v2 cache dependency
  Extent tree v2 and bgt all depend on v2 cache, but we have some
  mount options like clear_cache can screw this up.

Instead introducing some mount options to tinkering the filesystem
features (either compat_ro or incompat), we should always go through
btrfstune to enable new features (just like what we did in bgt).

This allows us to move the heavy lifting and proper checks into
btrfs-progs.

Although it's already late, it's still better than never, thus this
patchset introduce the --convert-to-free-space-tree feature to
btrfstune.

Unlike bgt, v1 cache is going to fade out soon, thus no rollback
functionality provided.

I hope we can deprecate the "space_cache=" mount option soon.

Qu Wenruo (3):
  btrfs-progs: make check/clear-cache.c to be separate from check/main.c
  btrfs-progs: tune: add --convert-to-free-space-tree option
  btrfs-progs: misc-tests: add test case to verify btrfstune
    --convert-to-free-space-tree option

 Documentation/btrfstune.rst                   |  5 ++
 Makefile                                      |  2 +-
 check/clear-cache.c                           | 84 ++++++++++---------
 check/clear-cache.h                           |  9 +-
 check/main.c                                  |  6 +-
 .../057-btrfstune-free-space-tree/test.sh     | 21 +++++
 tune/main.c                                   | 57 ++++++++++++-
 7 files changed, 135 insertions(+), 49 deletions(-)
 create mode 100755 tests/misc-tests/057-btrfstune-free-space-tree/test.sh

-- 
2.39.2

