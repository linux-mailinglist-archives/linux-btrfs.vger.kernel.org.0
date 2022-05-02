Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A6517515
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbiEBQzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386516AbiEBQzU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:55:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D363CB7D3;
        Mon,  2 May 2022 09:51:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F10B210ED;
        Mon,  2 May 2022 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651510309;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h3yJaFjxNAl9AQn6/ofob1hfEvkQkp6s5FBFQwXlFbg=;
        b=psR8BEe4WgPKlITinhBXu90hN7WYy+hCAvk299uZeILOj5+hc4WYAtgvA9/i6jQF8d+zWX
        0itgxEndCUKCVymwjxDzfh+QU54oHUwzzJZU1bqfntR4fGUdM1Y4pAxZPKghmk+bULhSiA
        RGl6b5RnWzxjm0Nyuu7tEePc1F+yzn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651510309;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h3yJaFjxNAl9AQn6/ofob1hfEvkQkp6s5FBFQwXlFbg=;
        b=krEiuPSV8UoWDZRq/3N1FRMFimQ1GUIOTvOmi1Dg4gY5ZJG8UHNGykJFksZh2Ut+Ppk0lV
        HFDrGstIk5a5V8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7037313491;
        Mon,  2 May 2022 16:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FCxvGiUMcGKDcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 May 2022 16:51:49 +0000
Date:   Mon, 2 May 2022 18:47:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.18-rc6
Message-ID: <cover.1651509134.git.dsterba@suse.com>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

a few more fixes mostly around how some file attributes could be set.
Please pull, thanks.

- fix handling of compression property
  - don't allow setting it on anything else than regular file or
    directory
  - do not allow setting it on nodatacow files via properties

- improved error handling when setting xattr

- make sure symlinks are always properly logged

----------------------------------------------------------------
The following changes since commit 5f0addf7b89085f8e0a2593faa419d6111612b9b:

  btrfs: zoned: use dedicated lock for data relocation (2022-04-21 16:06:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc5-tag

for you to fetch changes up to 4b73c55fdebd8939f0f6000921075f7f6fa41397:

  btrfs: skip compression property for anything other than files and dirs (2022-04-27 22:20:21 +0200)

----------------------------------------------------------------
Chung-Chiang Cheng (2):
      btrfs: export a helper for compression hard check
      btrfs: do not allow compression on nodatacow files

Filipe Manana (3):
      btrfs: always log symlinks in full mode
      btrfs: do not BUG_ON() on failure to update inode when setting xattr
      btrfs: skip compression property for anything other than files and dirs

 fs/btrfs/btrfs_inode.h | 11 ++++++++++
 fs/btrfs/inode.c       | 15 ++-----------
 fs/btrfs/props.c       | 59 +++++++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/props.h       |  4 +++-
 fs/btrfs/tree-log.c    | 14 +++++++++++-
 fs/btrfs/xattr.c       | 11 +++++++---
 6 files changed, 91 insertions(+), 23 deletions(-)
