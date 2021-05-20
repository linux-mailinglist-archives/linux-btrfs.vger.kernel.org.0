Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABBB38B2F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhETPXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhETPW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 11:22:58 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA493C06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:36 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v8so16562257qkv.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwzMKrp8JrQO9lL73rktvmj/QTbBn2HDL0mVGIvBieA=;
        b=v4i3tXI+o1bqTz/6ZqR6NQQUr/jG1b1tTTlKKsbbZGYDxq0UtGhH09GtTLa2saeyuX
         pqBpnbMiptiiuXrvfeCo92yu9pZD1jQif81MLHKGRpBScllsDhy7OtMsVIaCWXsx7O9w
         T7PG/QZbrXdOUUEfOMqxipeyXa7kFm3L9ARGudIxFZzBKPYYcB6/bgGse+12ov3l4FYx
         V8zCjUedWp1Cb4/pwRnPdeREFxDoWQ7nwEqATeYzV/jp0rvPH64F76x6uHPmcdwDV5wH
         X0KYZcxI1JtHjgDwsM5atkrfx6N0hE2CAnxCK7W3Moh6yuNF/GWSuwbQ0JGzXTYe7KIu
         14Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwzMKrp8JrQO9lL73rktvmj/QTbBn2HDL0mVGIvBieA=;
        b=YMVnFoos1gm/+b6BzRXW4VOgpZs72lIr8c1sjuhqcLtdZOtB/Qls52aRwuaskOi6K4
         eLMufvPN7AUJrfMEDROxqezG2gGbbuW9uGSHpmBcZkMi/cnzcAwxaLkaqwel9kzG00Px
         xpj650d+/xNQOQVJouc0jFCGmlh4ww8nYXcFoZ0AQIfrpzdwkG5Z1uBqU1amPC0j+MyB
         GuOPcR8VgNzC5egJnt3pSyffYNCkJHv3l7m5gDngHnX7fX3ZNhjQbElLbJNIWPyhBGw0
         g4RUanSdSs7lwHsO9U1RkcYJjR+/u+Qnu/Jb7hSXXQou4wBXOgg9YpLmZjZ8Jjih7OAG
         cALQ==
X-Gm-Message-State: AOAM530U2d71KF3Cd4bLUMWLoqJv4S7Cn0cY/6Ss0TG5+Z8OmTgGM3fO
        XMqnybqsXCtrbjkUsP+HpYTVmx45JH6H8A==
X-Google-Smtp-Source: ABdhPJzOU2nWxwCY3JktnJQptX8PH0GmMQ6WUzNCiXIggSJB8ApiEOecnsIja8TzgkWy2cHOoF1prw==
X-Received: by 2002:a37:ef08:: with SMTP id j8mr5451225qkk.24.1621524095403;
        Thu, 20 May 2021 08:21:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j16sm2038844qtr.27.2021.05.20.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:21:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Rework fs error handling
Date:   Thu, 20 May 2021 11:21:30 -0400
Message-Id: <cover.1621523846.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This series brings together 3 patches I had sent separately, because they mostly
depend on eachother.  The first is

	btrfs: always abort the transaction if we abort a trans handle

Which changes our behavior for trans handles that haven't modified any metadata.
Our dependency chain can be complex, and thus we may rely on a particular async
action happening and rely on the transaction actually aborting if it fails.
Previously if nothing occurred we'd just let the transaction conitue, but this
could put us in a bad state.  We need to simply always abort the transaction for
safety reasons.

That patch allows us to use the next patch

	btrfs: add a btrfs_has_fs_error helper

Now that we can rely on FS_STATE_ERROR always being set if something is wrong,
we can wrap that check in a helper and convert all the open coded checks for
FS_STATE_ERROR and FS_STATE_ABORTED to the new helper.

And finally an actual fix

	btrfs: do not infinite loop in data reclaim if we aborted

The async data path could infinite loop if we aborted because it only broke in
the case of space_info->full, which would never happen if we weren't full and
had aborted the transaction.  This is fine stand alone, but I took advantage of
the helpers here so I want to make sure the fix goes along with its
dependencies.  Thanks,

Josef

Josef Bacik (3):
  btrfs: always abort the transaction if we abort a trans handle
  btrfs: add a btrfs_has_fs_error helper
  btrfs: do not infinite loop in data reclaim if we aborted

 fs/btrfs/ctree.c       |  5 +----
 fs/btrfs/ctree.h       |  5 +++++
 fs/btrfs/disk-io.c     |  8 +++-----
 fs/btrfs/extent-tree.c |  1 -
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       |  6 +++---
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/space-info.c  | 29 ++++++++++++++++++++++++-----
 fs/btrfs/super.c       | 13 +------------
 fs/btrfs/transaction.c | 19 +++++--------------
 fs/btrfs/transaction.h |  1 -
 fs/btrfs/tree-log.c    |  2 +-
 13 files changed, 46 insertions(+), 49 deletions(-)

-- 
2.26.3

