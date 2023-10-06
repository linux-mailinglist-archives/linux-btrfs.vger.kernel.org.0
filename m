Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD587BB922
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjJFNeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjJFNef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 09:34:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E595;
        Fri,  6 Oct 2023 06:34:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC7651F45F;
        Fri,  6 Oct 2023 13:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696599272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hTL0BamYDOnnqQ9SM6lUuG4nmeHU2Ka02gJ7n7S/EZI=;
        b=UHdObYVPNTnac2reylDMJUMns/y7DXmW68mD5W6a81Vj5txW8IndZfeJBCGA5krpH7Nppu
        d+OXtgTw3S7L1ikWkk11Ejwv7WfUGYzh23b53tAuesj0Ulexikovead3yMJ0UwsI/RiLX6
        ukWK/OY5iK4OrOKA9VEEduU9DlKNf0M=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id ABA282C142;
        Fri,  6 Oct 2023 13:34:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61F1CDA8C1; Fri,  6 Oct 2023 15:27:50 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.6-rc5
Date:   Fri,  6 Oct 2023 15:27:47 +0200
Message-ID: <cover.1696529195.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull a few more fixes. Thanks.

- reject unknown mount options

- adjust transaction abort error message level

- fix one more build warning with -Wmaybe-uninitialized

- proper error handling in several COW-related cases

----------------------------------------------------------------
The following changes since commit b4c639f699349880b7918b861e1bd360442ec450:

  btrfs: initialize start_slot in btrfs_log_prealloc_extents (2023-09-21 18:52:23 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc4-tag

for you to fetch changes up to e36f94914021e58ee88a8856c7fdf35adf9c7ee1:

  btrfs: error out when reallocating block for defrag using a stale transaction (2023-10-04 01:04:33 +0200)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: always print transaction aborted messages with an error level
      btrfs: error out when COWing block using a stale transaction
      btrfs: error when COWing block from a root that is being deleted
      btrfs: error out when reallocating block for defrag using a stale transaction

Josef Bacik (1):
      btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Qu Wenruo (1):
      btrfs: reject unknown mount options early

 fs/btrfs/ctree.c       | 52 +++++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/super.c       |  4 ++++
 fs/btrfs/transaction.h |  4 ++--
 4 files changed, 47 insertions(+), 17 deletions(-)
