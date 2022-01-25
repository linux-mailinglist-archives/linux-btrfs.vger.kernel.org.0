Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7849ACC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 07:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379056AbiAYGyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 01:54:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51464 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376760AbiAYGvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 01:51:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2C91F380
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643093475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ugNvKOBkmY27RDEUc2KApONONbrpA11xd7xxlMPmOfU=;
        b=pbxwmhcG846djIyyB4aHCJWHuFLQhI4c+BgD5M8fDFR4pHVl7/Dk5SoxkciQHS2tNxBBLk
        2gpUe7Pn7L8FStprc26Ap4NTQFlPWNvSitlqI4o79zE80HbradOF3aToCqZdVPEG4PNJoh
        4CMddZQuZFvZRQiVNtNLr/c/cq3YcQA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C660C13BAA
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8mxeJOKd72H5AQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 06:51:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
Date:   Tue, 25 Jan 2022 14:50:55 +0800
Message-Id: <20220125065057.35863-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

** DON'T MERGE, THIS IS JUST A PROOF OF CONCEPT **

There are several reports about v5.16 btrfs autodefrag is causing more
IO than v5.15.

But it turns out that, commit f458a3873ae ("btrfs: fix race when
defragmenting leads to unnecessary IO") is making defrags doing less
work than it should.
Thus damping the IO for autodefrag.

This POC series is to make v5.15 kernel to do proper defrag of all good
candidates while still not defrag any hole/preallocated range.

The test script here looks like this:

	wipefs -fa $dev
	mkfs.btrfs -f $dev -U $uuid > /dev/null
	mount $dev $mnt -o autodefrag
	$fsstress -w -n 2000 -p 1 -d $mnt -s 1642319517
	sync
	echo "=== baseline ==="
	cat /sys/fs/btrfs/$uuid/debug/io_accounting/data_write
	echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_trigger
	sleep 3
	sync
	echo "=== after autodefrag ==="
	cat /sys/fs/btrfs/$uuid/debug/io_accounting/data_write
	umount $mnt

<uuid>/debug/io_accounting/data_write is the new debug features showing
how many bytes has been written for a btrfs.
The numbers are before chunk mapping.
cleaer_trigger is the trigger to wake up cleaner_kthread so autodefrag
can do its work.

Now there is result:

                | Data bytes written | Diff to baseline
----------------+--------------------+------------------
no autodefrag   | 36896768           | 0
v5.15 vanilla   | 40079360           | +8.6%
v5.15 POC       | 42491904           | +15.2%
v5.16 fixes	| 42536960	     | +15.3%

The data shows, although v5.15 vanilla is really causing the least
amount of IO for autodefrag, if v5.15 is patched with POC to do proper
defrag, the final IO is almost the same as v5.16 with submitted fixes.

So this proves that, the v5.15 has lower IO is not a valid default, but
a regression which leads to less efficient defrag.

And the IO increase is in fact a proof of a regression being fixed.

Qu Wenruo (2):
  btrfs: defrag: don't defrag preallocated extents
  btrfs: defrag: limit cluster size to the first hole/prealloc range

 fs/btrfs/ioctl.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

-- 
2.34.1

