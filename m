Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A3535A67
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiE0H2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiE0H2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 03:28:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF966AE0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 00:28:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B82DF1F946
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653636517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l4m1suISxoHwjisJdYCwoMTFtBf0EWMuXBum4OxQt/8=;
        b=YzMJcrforW+OChn4hF/zTFBZZXUiRXngts8SPEim6/CKvT1Pi235hY27+vA37UKI1oY5Ue
        /AYzlr69XoiZMIYWofXzBcPAl71tUNerHLM6tSZ2QcxGQ3mNa8PlQHbO4EZY/jKkLmg4XN
        XnS7aVyV9xg9vnlX3mra2j6iq1XOHSM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2969913A84
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EYrwOqR9kGLFIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:28:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: raid56: reduce unnecessary parity writes
Date:   Fri, 27 May 2022 15:28:16 +0800
Message-Id: <cover.1653636443.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

If we have only 8K partial write at the beginning of a full RAID56
stripe, we will write the following contents:

                    0  8K           32K             64K
Disk 1	(data):     |XX|            |               |
Disk 2  (data):     |               |               |
Disk 3  (parity):   |XXXXXXXXXXXXXXX|XXXXXXXXXXXXXXX|

|X| means the sector will be written back to disk.

This is due to the fact that we don't really check if the vertical
stripe has any data (aka, range from higher level bio) for parity
stripes.

The patchset will convert it to the following write pattern:

                    0  8K           32K             64K
Disk 1	(data):     |XX|            |               |
Disk 2  (data):     |               |               |
Disk 3  (parity):   |XX|            |               |

This is done by fully utilize btrfs_raid_bio::dbitmap which is only
utilized by scrub path.

Now write path (either partial or full write) will also populate
btrfs_raid_bio::dbitmap, and then only assemble sectors marked in
dbitmap for submission.

The first two patches is just to make previous bitmap pointers into
integrated bitmaps inside the bbtrfs_raid_bio and scrub_parity.

This saves 8 bytes for each structure.

The final patch does the most important work, by introducing a new
helper, rbio_add_bio() to mark the btrfs_raid_bio::dbitmap.
Then in finish_rmw() only add sectors which has bit in dbitmap marked to
change the write pattern.


Qu Wenruo (3):
  btrfs: use integrated bitmaps for btrfs_raid_bio::dbitmap and
    finish_pbitmap
  btrfs: use integrated bitmaps for scrub_parity::dbitmap and ebitmap
  btrfs: only write the sectors in the vertical stripe which has data
    stripes

 fs/btrfs/raid56.c | 89 ++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/scrub.c  | 32 +++++++----------
 2 files changed, 78 insertions(+), 43 deletions(-)

-- 
2.36.1

