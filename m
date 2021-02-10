Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4B317311
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhBJWPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhBJWPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:20 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B55C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:40 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id u20so3400987qku.7
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xMiLUXO46VbMtw0qUdle5q+FT0Do4agePdodVJfQEdE=;
        b=FjbVdN1wi52aRcNV33SprLFOw8h7Zt29n0oejB7vafWuSBl8NJ5McJxVo8WC2yWr/L
         XFVLXTSoRQ5U0nIOnxVcOtN+tumS5mM8uiMZY/RrbTPvgb0iF/XJ8An9Lx0u7VJbrmRq
         jDHy0qDUWyJCeRNBS4Z7H8qvUekXohVPPP27kP/RtK92I5ukRHaU2c/sNgopO7qbNqB1
         +vtTq5c8DM29jJDzdi1N2bThRXCQIFe6syHcRJBC9aXcEzrxeuT9DKfbh9LKPVnDBZb3
         WfNeHoN9mSND5n+l52il3QFKAjskSmANtn1yrP5OFpyNKj72+C3g3mqdyiWfWTu+/lOg
         QR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xMiLUXO46VbMtw0qUdle5q+FT0Do4agePdodVJfQEdE=;
        b=FuBslTsiMSiYw9UmTJquaiZdQsi8iORe4dSSfFCTkpEHhf3u+FS7g0NPszKb5C7NOK
         KA62q8HretCXu4CFWIwabgxOYcOzlZ4LKBNXiWvKqdpOsoH3ta6IVbLKvcLmEMkuIZ9l
         Bw28s5o0cntC205vaMMPkwIpWa+gRRkOm0lR9UUsrpWTqV2RntsIkRj1dg31J60Zcc+J
         cTPfh+9X95cNagz+/LV9OSnvYexLt6SgSgJaLpnKrU9EC24jjBpCwDbPBMI8FSlvnBNY
         S9VeKWjrcxi6Q/kJawglhqL2Sbs8tMfo6fOkjngmPpMHPlBCPXGOCpYKkLTPWlqc93Jv
         jLQg==
X-Gm-Message-State: AOAM533QJX1TxeOPsa2HsXd1X5UQs3ZAwZklw4TVOOB8+agmIQHQPqMK
        pHxbhGj7ovXut4woWtsWfUxYb6OPjb4D4ApI
X-Google-Smtp-Source: ABdhPJxlmd35QjGb/EXO8WTwl8xeA904B9QByZwACeH/1H8SZ7MAVdTcwrwMfwbQQA5v7up57wcn3A==
X-Received: by 2002:a37:8446:: with SMTP id g67mr5616809qkd.110.1612995278860;
        Wed, 10 Feb 2021 14:14:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m186sm2398194qkd.111.2021.02.10.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/4] Introduce a mmap sem to deal with some mmap issues
Date:   Wed, 10 Feb 2021 17:14:32 -0500
Message-Id: <cover.1612995212.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebase against misc-next.
- Add Filipe's reviewed-bys.

--- Original email ---

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

