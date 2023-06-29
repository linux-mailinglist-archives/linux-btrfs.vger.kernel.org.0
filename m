Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3A741CC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 02:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjF2AKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 20:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjF2AKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 20:10:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E926B6;
        Wed, 28 Jun 2023 17:10:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A03122185C;
        Thu, 29 Jun 2023 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687997428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oWyWVgTSEV3MFabbeKzbDXd1Vdi5iQSxxpY/L5jsuOw=;
        b=s8V4Sn1YTgDq+wvR65+wfyyCHeEq9f5ubYgjQqr3cb1NEuxpXKCCnIl7d0IJEC9oE9dlGS
        3uONLBzGHXxtgYtMcMhejeBMyJf0Es6kOEwRbPuIimwBIprVW1rZXD5rLBHusSq58opF+p
        gPExEqka2TN9dGEKMx2JNZiSCsLnw58=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E5181348C;
        Thu, 29 Jun 2023 00:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5dYvFvPLnGRTFQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 29 Jun 2023 00:10:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] common/btrfs: handle dmdust as mounted device in _btrfs_buffered_read_on_mirror()
Date:   Thu, 29 Jun 2023 08:10:10 +0800
Message-ID: <20230629001010.36235-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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
After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
ensure all page caches are dropped"), the test case btrfs/143 can fail
like below:

 btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstests/results//btrfs/143.out.bad)
    --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
    +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.575033899 +0100
    @@ -1,37 +1,6 @@
     QA output created by 143
     wrote 131072/131072 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................

[CAUSE]
Test case btrfs/143 uses dm-dust device to emulate read errors, this
means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.

As it would go mount $SCRATCH_DEV, not the dm-dust device to
$SCRATCH_MNT.
This prevents us to trigger read-repair (since no error would be hit)
thus fail the test.

[FIX]
Since we can mount whatever device at $SCRATCH_MNT, we can not use
_scratch_cycle_mount in this case.

Instead implement a small helper to grab the mounted device and its
mount options, and use the same device and mount options to cycle
$SCRATCH_MNT mount.

This would fix btrfs/143 and hopefully future test cases which use dm
devices.

Reported-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use findmnt command to grab mount options and source device
---
 common/btrfs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 175b33ae..0fec093d 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -601,8 +601,17 @@ _btrfs_buffered_read_on_mirror()
 	# The drop_caches doesn't seem to drop every pages on aarch64 with
 	# 64K page size.
 	# So here as another workaround, cycle mount the SCRATCH_MNT to ensure
-	# the cache are dropped.
-	_scratch_cycle_mount
+	# the cache are dropped, but we can not use _scratch_cycle_mount, as
+	# we may mount whatever dm device at SCRATCH_MNT.
+	# So here we grab the mounted block device and its mount options, then
+	# unmount and re-mount with the same device and options.
+	local dev=$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
+	local opts=$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
+	if [ -z "$dev" -o -z "$opts" ]; then
+		_fail "failed to grab mount info of $SCRATCH_MNT"
+	fi
+	_scratch_unmount
+	_mount $dev -o $opts $SCRATCH_MNT
 	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
 		exec $XFS_IO_PROG \
 			-c "pread -b $size $offset $size" $file) ]]; do
-- 
2.39.0

