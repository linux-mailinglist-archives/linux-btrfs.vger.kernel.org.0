Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BE50FDB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 14:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiDZMzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347096AbiDZMxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 08:53:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A736393DB;
        Tue, 26 Apr 2022 05:50:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB879210EC;
        Tue, 26 Apr 2022 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650977436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=EKOmFko0GdDGtyq09DwRA113ihOOGmE2oTxsGnphnPw=;
        b=hCLvJRG3urqKfQKX374sh75sS1o3flOR7BGkp35EQ5b3iqG/V8bZd8EQwYGdTUSuweYvdz
        zFEYOgdILYra1rg7vBS97xQl/lJxVuxK04f3541mMlZrWFjWhnbtHydWG57phTsZluobCU
        cUYaM2ApvboTfnwC7o9gBTzDwcWpA28=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8091813AD5;
        Tue, 26 Apr 2022 12:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /OMxHpzqZ2KTGwAAMHmgww
        (envelope-from <dsterba@suse.com>); Tue, 26 Apr 2022 12:50:36 +0000
Date:   Tue, 26 Apr 2022 14:46:29 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.18-rc5
Message-ID: <cover.1650923679.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes, please pull, thanks.

- direct IO fixes:
  - restore passing file offset to correctly calculate checksums when
    repairing on read and bio split happens
  - use correct bio when sumitting IO on zoned filesystem

- zoned mode fixes:
  - fix selection of device to correctly calculate device capabilities
    when allocating a new bio
  - use a dedicated lock for exclusion during relocation
  - fix leaked plug after failure syncing log

- fix assertion during scrub and relocation

----------------------------------------------------------------
The following changes since commit acee08aaf6d158d03668dc82b0a0eef41100531b:

  btrfs: fix btrfs_submit_compressed_write cgroup attribution (2022-04-06 00:50:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc4-tag

for you to fetch changes up to 5f0addf7b89085f8e0a2593faa419d6111612b9b:

  btrfs: zoned: use dedicated lock for data relocation (2022-04-21 16:06:24 +0200)

----------------------------------------------------------------
Christoph Hellwig (3):
      btrfs: fix and document the zoned device choice in alloc_new_bio
      btrfs: fix direct I/O read repair for split bios
      btrfs: fix direct I/O writes for split bios on zoned devices

Filipe Manana (2):
      btrfs: fix leaked plug after failure syncing log on zoned filesystems
      btrfs: fix assertion failure during scrub due to block group reallocation

Naohiro Aota (1):
      btrfs: zoned: use dedicated lock for data relocation

 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/dev-replace.c |  7 ++++++-
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent_io.c   | 44 +++++++++++++++++++++++++++++---------------
 fs/btrfs/inode.c       | 18 ++++++++----------
 fs/btrfs/scrub.c       | 26 +++++++++++++++++++++++++-
 fs/btrfs/tree-log.c    |  1 +
 fs/btrfs/volumes.h     |  3 +++
 fs/btrfs/zoned.h       |  4 ++--
 9 files changed, 76 insertions(+), 29 deletions(-)
