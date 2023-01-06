Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBF66026F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 15:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjAFOnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 09:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjAFOnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 09:43:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD480ADD;
        Fri,  6 Jan 2023 06:43:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F183122AA5;
        Fri,  6 Jan 2023 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673016212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VXOo+m2Ayjo47a4HPksQJilkMyb9b8UgnRO64hze/N4=;
        b=Ek5WxsnVwShIhYVlxeIoKUYDktam2tv201i/QHJuRhLqWjv1ShId8QEP0ubSZk+zNvS7IW
        E4RgUCCsJTS/324zFivq8HWEGZMMMfhJVzQSLG1ZKqYyzNzQs0Mq+jb4Cmji8kxvtP391M
        nlo4CerUbzzEAvMWQIApeJ2ucHo3uYY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E5D5F2C141;
        Fri,  6 Jan 2023 14:43:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0CC6DA7A3; Fri,  6 Jan 2023 15:38:01 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.2-rc3, part 2
Date:   Fri,  6 Jan 2023 15:38:00 +0100
Message-Id: <cover.1672944066.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more regression and regular fixes. Please pull, thanks.

- regressions:
  - fix assertion condition using = instead of ==
  - fix false alert on bad tree level check
  - fix off-by-one error in delalloc search during lseek

- fix compat ro feature check at read-write remount

- handle case when read-repair happens with ongoing device replace

- updated error messages

----------------------------------------------------------------
The following changes since commit fee4c19937439693f2420a916169d08e88576e8e:

  btrfs: fix fscrypt name leak after failure to join log transaction (2022-12-20 19:43:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc2-tag

for you to fetch changes up to 2ba48b20049b5a76f34a85f853c9496d1b10533a:

  btrfs: fix compat_ro checks against remount (2023-01-03 16:22:13 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix off-by-one in delalloc search during lseek

Qu Wenruo (5):
      btrfs: add error message for metadata level mismatch
      btrfs: fix false alert on bad tree level check
      btrfs: handle case when repair happens with dev-replace
      btrfs: always report error in run_one_delayed_ref()
      btrfs: fix compat_ro checks against remount

Tanmay Bhushan (1):
      btrfs: fix ASSERT em->len condition in btrfs_get_extent

 fs/btrfs/bio.c            | 11 ++++++++++-
 fs/btrfs/disk-io.c        | 11 ++++++++---
 fs/btrfs/disk-io.h        |  2 +-
 fs/btrfs/extent-io-tree.c |  2 +-
 fs/btrfs/extent-tree.c    |  7 +++++--
 fs/btrfs/extent_io.c      | 30 +++++++++++++++++++++++++-----
 fs/btrfs/file.c           |  2 +-
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/super.c          |  2 +-
 9 files changed, 53 insertions(+), 16 deletions(-)
