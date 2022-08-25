Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF65A09A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 09:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiHYHJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 03:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiHYHJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 03:09:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082AAA1D67
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 00:09:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B254D1FB04
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 07:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661411368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VUBiticGAoOWTB1Kb6/h+BgPBCRUA0nClKIEBR48+VA=;
        b=nltLarRTYmWMaEc5j9YKKzLKHNvb5fLLb2hlN9wdIvyv9NRNCGBgxfPkCo7PsbxykOU2Q9
        JhRq5gsQUiM97eJ/xmZHP4tiyemuKFUpxQMd5NFFI8gWkCe3y6bTIhuHer2xnnYFLmjaO4
        EXqS6ZPMhGs5Tjm27pI7fWcA6cYD1Ok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09EB113A47
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 07:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LBi/MScgB2PZRgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 07:09:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: output more info for -ENOSPC caused transaction abort
Date:   Thu, 25 Aug 2022 15:09:08 +0800
Message-Id: <cover.1661410915.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Changelog]
v3:
- Drop the multi-line output change
  The biggest problem is, for the space info dump, it can be ratelimited
  especially for enospc_debug mount option.
  Thus multi-line can be more confusing when it's related-limited or
  interrupted by other lines.

  So this version will reuse the old single line output.

v2:
- Add a new line to show the meaning of the metadata dump.
  Previous output only includes the reserved bytes and size bytes,
  but not showing which is which, thus still need to check the code

We have some internal reports of transaction abort with -ENOSPC.

Unfortunately it's really hard to debug, since we really got nothing
other than the error message for most cases.

Also we have helpers like __btrfs_dump_space_info(), it needs enospc_debug
mount option which only makes sense if the user can reproduce the bug
and retry with that mount option.

Considering ENOSPC should not happen for critical paths which failure
means transaction abort, we should dump all space info for debug purpose
if the transaction arbot is caused by -ENOSPC.

One example of the output at transaction abort time:

 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -28)
 WARNING: CPU: 8 PID: 3366 at fs/btrfs/transaction.c:2137 btrfs_commit_transaction+0xf81/0xfb0 [btrfs]
 <call trace skipped>
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device dm-1: state A): dumping space info:
 BTRFS info (device dm-1: state A): space_info DATA has 6791168 free, is not full
 BTRFS info (device dm-1: state A): space_info total=8388608, used=1597440, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
 BTRFS info (device dm-1: state A): space_info METADATA has 257114112 free, is not full
 BTRFS info (device dm-1: state A): space_info total=268435456, used=131072, pinned=180224, reserved=65536, may_use=10878976, readonly=65536 zone_unusable=0
 BTRFS info (device dm-1: state A): space_info SYS has 8372224 free, is not full
 BTRFS info (device dm-1: state A): space_info total=8388608, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
 BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 reserved 3670016
 BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved 0
 BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved 0
 BTRFS info (device dm-1: state A): delayed_block_rsv: size 4063232 reserved 4063232
 BTRFS info (device dm-1: state A): delayed_refs_rsv: size 3145728 reserved 3145728
 BTRFS: error (device dm-1: state A) in btrfs_commit_transaction:2137: errno=-28 No space left
 BTRFS info (device dm-1: state EA): forced readonly


Qu Wenruo (2):
  btrfs: output human readable space info flag
  btrfs: dump all space infos if we abort transaction due to ENOSPC

 fs/btrfs/ctree.h      |  6 +++--
 fs/btrfs/space-info.c | 52 +++++++++++++++++++++++++++++++++++--------
 fs/btrfs/space-info.h |  2 ++
 fs/btrfs/super.c      |  4 +++-
 4 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.37.2

