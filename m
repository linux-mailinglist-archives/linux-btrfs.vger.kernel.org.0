Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF33D7D55
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhG0SVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 14:21:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0SVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 14:21:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9FC022217;
        Tue, 27 Jul 2021 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627410097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qENDo6Bxgyq0eajqdP5MtqStd1UZ7bmz+K83plfcBDg=;
        b=k73CZdUL7Ur9fp2N54N/S46VX4z8BIqJ/MiQGOYFGlHsUGrwrKbA7cD4v3jrwSFNHbH8cF
        dYzeLd/ytP3jkufR+H9aQ9IXNifbHs6SnXVleqyypjGXwx8p51mIeEfyT3G+FngyQj10uv
        0HmlpKHL2wPlTAZXOS/eWKY6MwRxVKc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C1A913A5D;
        Tue, 27 Jul 2021 18:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h82lNK9OAGFDGAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 27 Jul 2021 18:21:35 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2] btrfs/177: Ignore resize output message
Date:   Tue, 27 Jul 2021 15:21:25 -0300
Message-Id: <20210727182125.29210-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
readable") added the device id of the resized fs along with a pretty
printed size. Remove the resize output message from 117.out.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Qu, btrfs/217 is also ignoring the resize output, so I believe it would be
 easier if we do the same here. We would see other problems if the resize fail,
 so I think we are safe here.

 tests/btrfs/177     | 5 ++---
 tests/btrfs/177.out | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 966d29d7..f59f54a7 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -36,8 +36,7 @@ dd if=/dev/zero of="$SCRATCH_MNT/refill" bs=4096 >> $seqres.full 2>&1
 # Now add more space and create a swap file. We know that the first $fssize
 # of the filesystem was used, so the swap file must be in the new part of the
 # filesystem.
-$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | \
-							_filter_scratch
+$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" >>$seqres.full
 _format_swapfile "$swapfile" $((32 * 1024 * 1024))
 swapon "$swapfile"
 
@@ -55,7 +54,7 @@ $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2>&1 | grep -o "Text file b
 swapoff "$swapfile"
 
 # It should work again after swapoff.
-$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" | _filter_scratch
+$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" >>$seqres.full
 
 status=0
 exit
diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
index 63aca0e5..0293ee36 100644
--- a/tests/btrfs/177.out
+++ b/tests/btrfs/177.out
@@ -1,4 +1,2 @@
 QA output created by 177
-Resize 'SCRATCH_MNT' of '3221225472'
 Text file busy
-Resize 'SCRATCH_MNT' of '1073741824'
-- 
2.26.2

