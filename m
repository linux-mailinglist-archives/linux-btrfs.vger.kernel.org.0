Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08E1727F60
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjFHLtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbjFHLs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 07:48:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B82D56;
        Thu,  8 Jun 2023 04:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2491FDCA;
        Thu,  8 Jun 2023 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686224935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Uf/UTTWJLhcTogD3V9tpRQLUBS2lTLYRo2sYeoTITos=;
        b=Cj7FLe3pHINkBS4RPvE81ccQ7HUo4KTGnQtaEdmcxhVmFfWwvY/3gSlOyN3A16ktfUxyA7
        6xK4lrIJLrJGUosiRw5I+n2lnmMPCGOtHl6GPdxswH1rDG2Mc7KRTNbG1j75jC/CRK81h+
        jXwWAsDorLmmzMZLrVEK6/+bemGkEpk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22E13138E6;
        Thu,  8 Jun 2023 11:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bJz3NSXAgWT1LgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 08 Jun 2023 11:48:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all page caches are dropped
Date:   Thu,  8 Jun 2023 19:48:36 +0800
Message-Id: <20230608114836.97523-1-wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[BUG]
There is a chance that btrfs/266 would fail on aarch64 with 64K page
size. (No matter if it's 4K sector size or 64K sector size)

The failure indicates that one or more mirrors are not properly fixed.

[CAUSE]
I have added some trace events into the btrfs IO paths, including
__btrfs_submit_bio() and __end_bio_extent_readpage().

When the test failed, the trace looks like this:

 112819.764977: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=1 len=196608 pid=33663
                                    ^^^ Initial read on the full 192K file
 112819.766604: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=2 len=65536 pid=21806
				    ^^^ Repair on the first 64K block
					Which would success
 112819.766760: __btrfs_submit_bio: r/i=5/257 fileoff=65536 mirror=2 len=65536 pid=21806
				    ^^^ Repair on the second 64K block
				 	Which would fail
 112819.767625: __btrfs_submit_bio: r/i=5/257 fileoff=65536 mirror=3 len=65536 pid=21806
				    ^^^ Repair on the third 64K block
					Which would success
 112819.770999: end_bio_extent_readpage: read finished, r/i=5/257 fileoff=0 len=196608 mirror=1 status=0
					 ^^^ The repair succeeded, the
					     full 192K read finished.

 112819.864851: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=3 len=196608 pid=33665
 112819.874854: __btrfs_submit_bio: r/i=5/257 fileoff=0 mirror=1 len=65536 pid=31369
 112819.875029: __btrfs_submit_bio: r/i=5/257 fileoff=131072 mirror=1 len=65536 pid=31369
 112819.876926: end_bio_extent_readpage: read finished, r/i=5/257 fileoff=0 len=196608 mirror=3 status=0

But above read only happen for mirror 1 and mirror 3, mirror 2 is not
involved.
This means by somehow, the read on mirror 2 didn't happen, mostly
due to something wrong during the drop_caches call.

It may be an async operation or some hardware specific behavior.

On the other hand, for test cases doing the same operation but utilizing
direct IO, aka btrfs/267, it never fails as we never populate the page
cache thus would always read from the disk.

[WORKAROUND]
The root cause is in the "echo 3 > drop_caches", which I'm still
debugging.

But at the same time, we can workaround the problem by forcing a
cycle mount of scratch device, inside _btrfs_buffered_read_on_mirror().

By this we can ensure all page caches are dropped no matter if
drop_caches is working correctly.

With this patch, I no longer hit the failure on aarch64 with 64K page
size anymore, while before this the test case would always fail during a
-I 10 run.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
RFC:
The root cause is still inside that "echo 3 > drop_caches", but I don't
have any better solution if such fundamental debug function is not
working as expected.

Thus this is only a workaround, before I can pin down the root cause of
that drop_cache hiccup.
---
 common/btrfs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 344509ce..1d522c33 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -599,6 +599,11 @@ _btrfs_buffered_read_on_mirror()
 	local size=$5
 
 	echo 3 > /proc/sys/vm/drop_caches
+	# Above drop_caches doesn't seem to drop every pages on aarch64 with
+	# 64K page size.
+	# So here as a workaround, cycle mount the SCRATCH_MNT to ensure
+	# the cache are dropped.
+	_scratch_cycle_mount
 	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
 		exec $XFS_IO_PROG \
 			-c "pread -b $size $offset $size" $file) ]]; do
-- 
2.39.1

