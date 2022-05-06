Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C751E08B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 May 2022 22:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444308AbiEFVD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 May 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444310AbiEFVDY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 May 2022 17:03:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50F6EC48;
        Fri,  6 May 2022 13:59:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A0991F92C;
        Fri,  6 May 2022 20:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651870759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=zR674RhM0j/QUf3xPcIjeF4uS7iA8qT7AtuAdc1NKmY=;
        b=K83Qfgc5Cy41wq2LTtRvX2cCbmsZiTYl0v3QttKD901o33lIPGZ1YakjXpIFn7FbYkPQfA
        Ge9+p+NJp/yO9uG2Y7sXrN8RbVKFYG7laDV1eHf4jAUJebdxtGHmvVhkXxhzCzsjzpSqn3
        aAgBWRB6O6Nh5r1xQaTw4kmEfKxL9hA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5200613A1B;
        Fri,  6 May 2022 20:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CYAqEieMdWI1CAAAMHmgww
        (envelope-from <dsterba@suse.com>); Fri, 06 May 2022 20:59:19 +0000
Date:   Fri, 6 May 2022 22:55:06 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.18-rc6, part 2
Message-ID: <cover.1651860315.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more regular fixes and regression fixes. Please pull, thanks.

- regression fixes in zone activation:
  - move a loop invariant out of the loop to avoid checking space status

  - properly handle unlimited activation

- fixes:
  - for subpage, force the free space v2 mount to avoid a warning and
    make it easy to switch a filesystem on different page size systems

  - export sysfs status of exclusive operation 'balance paused', so the
    user space tools can recognize it and allow adding a device with
    paused balance

  - fix assertion failure when logging directory key range item

----------------------------------------------------------------
The following changes since commit 4b73c55fdebd8939f0f6000921075f7f6fa41397:

  btrfs: skip compression property for anything other than files and dirs (2022-04-27 22:20:21 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc5-tag

for you to fetch changes up to 3e1ad196385c65c1454aceab1226d9a4baca27d5:

  btrfs: sysfs: export the balance paused state of exclusive operation (2022-05-05 21:05:56 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: sysfs: export the balance paused state of exclusive operation

Filipe Manana (1):
      btrfs: fix assertion failure when logging directory key range item

Naohiro Aota (2):
      btrfs: zoned: move non-changing condition check out of the loop
      btrfs: zoned: activate block group properly on unlimited active zone device

Qu Wenruo (1):
      btrfs: force v2 space cache usage for subpage mount

 fs/btrfs/disk-io.c  | 11 +++++++++++
 fs/btrfs/sysfs.c    |  3 +++
 fs/btrfs/tree-log.c | 39 +++++++++++++++++++++++++--------------
 fs/btrfs/zoned.c    | 34 ++++++++++++++--------------------
 4 files changed, 53 insertions(+), 34 deletions(-)
