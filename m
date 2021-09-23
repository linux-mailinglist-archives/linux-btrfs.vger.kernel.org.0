Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19B741678D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbhIWVi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 17:38:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33694 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243232AbhIWVi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 17:38:26 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C6041FDA8;
        Thu, 23 Sep 2021 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632433013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YfiVNDupuJkAqDYA2q22AZZjU99YDJbsaYRL3NKp75A=;
        b=GV7BD1WbtmjrItUKvVdZnKVflzhkd2EFQf4XdVCcZS7BRxH4jW2jthl6x2gzDM5ysfFinV
        Ozip+JHyv6lNw3qrLptCKoPxKic9bF9PjiaKFnFrdu2KR5gAw6R+/r/2oMTD8azh2rRDQq
        CPHoMs/AgcRpdTzFGSwLfQ0J6+Gb3TI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 83C6D25D3C;
        Thu, 23 Sep 2021 21:36:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 187CBDA7A3; Thu, 23 Sep 2021 23:36:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.15-rc3
Date:   Thu, 23 Sep 2021 23:36:38 +0200
Message-Id: <cover.1632432123.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few fixes, please pull. Thanks.

- regression, fix leak of transaction handle after verity rollback
  failure

- properly reset device last error between mounts

- improve one error handling case when checksumming bios

- fixup confusing displayed size of space info free space

----------------------------------------------------------------
The following changes since commit f79645df806565a03abb2847a1d20e6930b25e7e:

  btrfs: zoned: fix double counting of split ordered extent (2021-09-07 14:30:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc2-tag

for you to fetch changes up to 0619b7901473c380abc05d45cf9c70bee0707db3:

  btrfs: prevent __btrfs_dump_space_info() to underflow its free space (2021-09-17 19:29:54 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix transaction handle leak after verity rollback failure
      btrfs: fix mount failure due to past and transient device flush error

Qu Wenruo (2):
      btrfs: replace BUG_ON() in btrfs_csum_one_bio() with proper error handling
      btrfs: prevent __btrfs_dump_space_info() to underflow its free space

 fs/btrfs/file-item.c  | 13 ++++++++++++-
 fs/btrfs/space-info.c |  5 +++--
 fs/btrfs/verity.c     |  6 ++++--
 fs/btrfs/volumes.c    | 13 +++++++++++++
 4 files changed, 32 insertions(+), 5 deletions(-)
