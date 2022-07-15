Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03A575BE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiGOG6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOG6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 02:58:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD35007B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 23:58:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A76233EF6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657868286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sHzM5TgUmaBnzl50oI6vjVWgAxkvbXotY11bUEcvsHw=;
        b=TfQIhK8vIrB747JDLxWG7XhiYU3p8OU7t20Ac808cA39vWUZNqmIYjIfcV6IwsSaJtf3OH
        B85kes0w3MLPGyzQ9dDl7mGahEK2bYWdj5MTCLp2ORI/RSO7M2H66lRow4CC0ysA7MpDO/
        yNf6zl7La0IWnjzOmqihA92l98jPv6o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80EED13754
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8tbnEf0P0WKtfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: output more info for -ENOSPC caused transaction abort and other enhancement
Date:   Fri, 15 Jul 2022 14:57:43 +0800
Message-Id: <cover.1657867842.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have some internal reports of transaction abort with -ENOSPC.

Unfortunately it's really hard to debug, since we really got nothing
other than the error message for most cases.

Also we have helpers like __btrfs_dump_space_info(), it needs enospc_debug
mount option which only makes sense if the user can reproduce the bug
and retry with that mount option.

Considering ENOSPC should not happen for critical paths which failure
means transaction abort, we should dump all space info for debug purpose
if the transaction arbot is caused by -ENOSPC.

And since we're here, also enhance the output of
__btrfs_dump_space_info().

Now it should be more human readable, the exmaple would look like this:

 BTRFS info (device dm-1: state A): dumpping space info:
 BTRFS info (device dm-1: state A): space_info DATA has 1175552 free, is not full
 BTRFS info (device dm-1: state A):   total:         8388608
 BTRFS info (device dm-1: state A):   used:          7163904
 BTRFS info (device dm-1: state A):   pinned:        49152
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       0
 BTRFS info (device dm-1: state A):   read_only:     0
 BTRFS info (device dm-1: state A): space_info META has 263798784 free, is not full
 BTRFS info (device dm-1: state A):   total:         268435456
 BTRFS info (device dm-1: state A):   used:          180224
 BTRFS info (device dm-1: state A):   pinned:        196608
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       4194304
 BTRFS info (device dm-1: state A):   read_only:     65536
 BTRFS info (device dm-1: state A): space_info SYS has 8372224 free, is not full
 BTRFS info (device dm-1: state A):   total:         8388608
 BTRFS info (device dm-1: state A):   used:          16384
 BTRFS info (device dm-1: state A):   pinned:        0
 BTRFS info (device dm-1: state A):   reserved:      0
 BTRFS info (device dm-1: state A):   may_use:       0
 BTRFS info (device dm-1: state A):   read_only:     0
 BTRFS info (device dm-1: state A): dumpping metadata reservation:
 BTRFS info (device dm-1: state A):   global:          (3670016/3670016)
 BTRFS info (device dm-1: state A):   trans:           (0/0)
 BTRFS info (device dm-1: state A):   chuunk:          (0/0)
 BTRFS info (device dm-1: state A):   delayed_inode:   (0/0)
 BTRFS info (device dm-1: state A):   delayed_refs:    (524288/524288)
 BTRFS: error (device dm-1: state A) in cleanup_transaction:1971: errno=-28 No space left
 BTRFS info (device dm-1: state EA): forced readonly

---

Would this be a candidate for stable kernels?
I believe there will be a lot of conflicts, but I think the extra debug
info would be worthy the effort.

Furthermore, any recommendation on extra info needed would be
appreciated, as I'm not 100% sure if the space info dumps would be
enough.
E.g. for metadata over-commit cases, the META space info would not make
much sense.

Qu Wenruo (4):
  btrfs: output human readable space info flag
  btrfs: make __btrfs_dump_space_info() output better formatted
  btrfs: make DUMP_BLOCK_RSV() to have better output
  btrfs: dump all space infos if we abort transaction due to ENOSPC

 fs/btrfs/ctree.h      |  6 ++--
 fs/btrfs/space-info.c | 82 ++++++++++++++++++++++++++++++++-----------
 fs/btrfs/space-info.h |  2 ++
 fs/btrfs/super.c      |  4 ++-
 4 files changed, 71 insertions(+), 23 deletions(-)

-- 
2.37.0

