Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465F2D9ED4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 19:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440731AbgLNSUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 13:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440717AbgLNSUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 13:20:25 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64DBC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:44 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id s6so8241611qvn.6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnwuPwU2bhXdzPwpchIW2/tQK7NrMbmzqytxSYYzPok=;
        b=JmDuJ5nErsW9HV5hpHyZHI8+Brh7UGAnm3m/rZtJ3twrm9lZbHjOvcJmh9q4nmB08l
         SIMz2MSCENCfYur1cVhzJ0IJP+ekWF8fj40BhVrlu5GbzibnHpuaziscHUFWZGR8mXgM
         y7k6CljLym2ymPFkZb5IroV12j0uRkXHbgXz5YgwsSw8p5YU8Ws3FvlkVzBMxn159asp
         mN9330tINQB19rh7M8+GJmvwWzE9G1ecRhnnGBB+43S9YW0o/Em4cDrIMK/egm+NO+vl
         lOpxSnEBUpqyMNGywKlinDNdyGQeGlD9wyBoGi1qYFqF/8DiUW5Fs6ZRH2CK2VqlQe2B
         VpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnwuPwU2bhXdzPwpchIW2/tQK7NrMbmzqytxSYYzPok=;
        b=Iljs83hi1Waxf0n75rWLWoSdYdxb+8vF41eFb2tCvA8CDxAPkeZIEVxDV1mjU5f2nT
         8gmyaNhu/5HvpxxHPxSg+9mI+zuEESPjpnRO7fngGyAUDMUYTg54JLk92KQo7D++41Y3
         dtfEzsZkuNbOIOaBIxUrWrElBYoa/R8acgrK88v+5w4qqNq5ZDerzaRgJkCtG6df3dm8
         ZA35IeWzY03iUwrlD4WeYBF+b3VML8TnnsxYZytrDEHByn4GqcmQYL4ubrl/BhTkocCq
         gHzld9b3dglMuvwRxuL+LTNtTfjZ+dnkcP8O1KGIGfSWTp0vmgFMEiiv7yUi0iCVJMRU
         oJcA==
X-Gm-Message-State: AOAM530hKMx1Ea2a9fECq21odZSGylpA2rlveXJKHR4s5XZfCiieKw5/
        qasb2zjHgTPEsf9cmnCkyxFYLhJvB++xUz2J
X-Google-Smtp-Source: ABdhPJzx5AwefUEQYhriIlWJi0kcV0tA+c45UPOoOSxvUoH/TmrFl9EsaMGtDJ7dRQd7LO2Hazdl/g==
X-Received: by 2002:ad4:4f11:: with SMTP id fb17mr2264268qvb.46.1607969983420;
        Mon, 14 Dec 2020 10:19:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w7sm15271681qkd.92.2020.12.14.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:19:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] Introduce a mmap sem to deal with some mmap issues
Date:   Mon, 14 Dec 2020 13:19:37 -0500
Message-Id: <cover.1607969636.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Both Filipe and I have found different issues that result in the same thing, we
need to be able to exclude mmap from happening in certain scenarios.  The
specifics are well described in the commit logs, but generally there's 2 issues

1) dedupe needs to validate that pages match, and since the validation is done
   outside of the extent lock we can race with mmap and dedupe pages that do not
   match.
2) We can deadlock in certain low metadata scenarios where we need to flush
   an ordered extent, but can't because mmap is holding the page lock.

These issues exist for remap and fallocate, so add an i_mmap_sem to allow us to
disallow mmap in these cases.  I'm still waiting on xfstests to finish with
this, but 2 hours in and no lockdep or deadlocks.  Thanks,

Josef Bacik (4):
  btrfs: add a i_mmap_lock to our inode
  btrfs: cleanup inode_lock/inode_unlock uses
  btrfs: exclude mmaps while doing remap
  btrfs: exclude mmap from happening during all fallocate operations

 fs/btrfs/btrfs_inode.h   |  1 +
 fs/btrfs/ctree.h         |  1 +
 fs/btrfs/delayed-inode.c |  4 ++--
 fs/btrfs/file.c          | 20 ++++++++++----------
 fs/btrfs/inode.c         | 10 ++++++++++
 fs/btrfs/ioctl.c         | 26 +++++++++++++-------------
 fs/btrfs/reflink.c       | 30 ++++++++++++++++++++++++------
 fs/btrfs/relocation.c    |  4 ++--
 8 files changed, 63 insertions(+), 33 deletions(-)

-- 
2.26.2

