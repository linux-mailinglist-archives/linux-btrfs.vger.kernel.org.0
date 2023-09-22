Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D37AA729
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 04:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjIVCzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 22:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIVCzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 22:55:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99471192
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 19:55:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74F2322166
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695351340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CMiW+gvG3ARs0XSiBb+Jmx1QhHxYypaSRFA27NV2/Bc=;
        b=pQMUzJjXnqip3SCP6Zqo522jhqKouZS5ztXWVfqPpRpVA64wSxbu5BXx/bcsh5LFWNN4gN
        Mz8vx79JNbZms57N+OxX4WO3eNhyQimyAWxnvuo/Q5NYknHg69huzCndn+kLE/oSDYeIxo
        UA7fPJErlJ6nupW+DRyAU5ZAgT8uWDg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9275913438
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aA5MEysCDWV6LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: introduce "abort=" groups for more strict error handling
Date:   Fri, 22 Sep 2023 12:25:18 +0930
Message-ID: <cover.1695350405.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During a very interesting (and weird) debugging session, it turns out
that btrfs will ignore a lot of write errors until we hit some critical
location, then btrfs started reacting, normally by aborting the
transaction.

This can be problematic for two types of people:

- Developers
  Sometimes we want to catch the earlies sign, continuing without any
  obvious errors (other than kernel error messages) can make debugging
  much harder.

- Sysadmins who wants to catch problems early
  Dmesg is not really something users would check frequently, and even
  they check it, it may already be too late.
  Meanwhile if the fs flips read-only early it's not only noisy but also
  saves the context much better (more relevant dmesgs etc).

On the other hand, I totally understand if just a single sector failed
to be write and we mark the whole fs read-only, it can be super
frustrating for regular end users, thus we can not make it the default
behavior.

So here we introduce a mount option group "abort=", and make the
following errors more noisy and abort early if specified by the user.

- Any super block write back failure
  Currently we're very loose on the super block writeback failure.
  The failure has to meet both conditions below:
  * The primary super block writeback failed
  * Total failed devices go beyond tolerance
    The tolerance is super high, num_devices - 1. To me this is
    too high, but I don't have a better idea yet.

  This new "rescue=super" may be more frequently used considering how
  loose our existing tolerance is.

- Any data writeback failure
  This is only for the data writeback at btrfs bio layer.
  This means, if a data sector is going to be written to a RAID1 chunk,
  and one mirror failed, we still consider the writeback succeeded.

There would be another one for btrfs bio layer, but I have found
something weird in the code, thus it would only be introduced after I
solved the problem there, meanwhile we can discuss on the usefulness of
this patchset.

Qu Wenruo (3):
  btrfs: explicitly mark BTRFS_MOUNT_ enum as 64bit
  btrfs: introduce "abort=super" mount option
  btrfs: introduce "abort=data" mount option

 fs/btrfs/disk-io.c   | 12 ++++++
 fs/btrfs/extent_io.c |  8 +++-
 fs/btrfs/fs.h        | 64 +++++++++++++++---------------
 fs/btrfs/inode.c     |  9 ++++-
 fs/btrfs/super.c     | 94 +++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 149 insertions(+), 38 deletions(-)

-- 
2.42.0

