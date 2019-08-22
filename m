Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F199FB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfHVTTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:19:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40629 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTTH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:19:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id g7so2962839ybd.7
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXorIhtEraUabtVXUsHPWJ8hhlT+ReNfBtd8To7Nhig=;
        b=Od+CYBBsH6ym9O0g7/YJVUsVi+WoZ56S9qOed1POF6pEItLNfktuCoWQt2YIVyzZhw
         NmiJwtr9SKKPSF/n+nk80n0wZQuNxLwkXbtYXis/GnRf1XgKIgESbSioX5Qc3OkTdhIY
         6yEjEcarzqUJRuYX8oMSu4BdmDhbbi3oi64rKRFdRxMcHOzHHA3plbJ3Ii9RNJnsQbOD
         RaynPf/bsYtcnlocahQYvK3Zk52yzTcf9IuFLIdEzyeWMxOixBYDQqCD1Fukxu3GIDeB
         xalVam20nu1SOxjnJufOpwY6G4GD7t6IECIRKL9yO1FN4UlLWXsC9nvjwkq/M3/8v4Do
         tOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXorIhtEraUabtVXUsHPWJ8hhlT+ReNfBtd8To7Nhig=;
        b=TT53q3JkaPqq+rRiRtIov+mnn8W+IzK5UJHq1L8I4vspX0wOARct94FYJv7cmHzxAw
         s/x5WbkML3pzoMVA/0B6i8aYoOgHrY+hBrrTr/0ihGUAmk4tHEUBBJzNRTMcDnf7tAaR
         G5s8T4lryHkK/fTeKD6icqnJcagqmfD1xiHoh4JE67koLt2nH1BGYpaJN8SuRbvtUmM0
         J3jZBsF8kywzz1IDlPrUNOkGVs1gC8E6m6WBh1cGON7wo7fkrlM/zJFebkCd8kf1VAar
         M0bpGr12Ers33ZaMQD//SrTsogrzBgbToFmLWQzlIaWFJV7amzD+j9EdVyzOFCxkiFav
         mwig==
X-Gm-Message-State: APjAAAW+6JG7cWBeH/R7xS4Te6AIlCFNehkEuu0/684E1KqCLuhk2xRK
        3TYjk+ZBr3GS0mGxly62DV7RUTqMWici2A==
X-Google-Smtp-Source: APXvYqy5+zDlMN+TQ+v2p61e9f84P8Lm6/CL6qsRTgwyVtf4OaYLaM29uERzCJqlCNYQORIOqercDw==
X-Received: by 2002:a25:ada8:: with SMTP id z40mr380594ybi.147.1566501546485;
        Thu, 22 Aug 2019 12:19:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k68sm112879ywa.80.2019.08.22.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:19:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5][v2] Fix global reserve size and can overcommit
Date:   Thu, 22 Aug 2019 15:18:59 -0400
Message-Id: <20190822191904.13939-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This didn't series didn't change much, but I did move things around a little bit
in previous series so these needed to be updated.

 fs/btrfs/block-rsv.c  | 36 ++++++++++++++++++++++++++----------
 fs/btrfs/space-info.c | 51 ++++++++++++++++++++++++++-------------------------
 2 files changed, 52 insertions(+), 35 deletions(-)

v1->v2:
- Rebased with the new name changes from previous patches.
- Added the reviewed-by's.
- Added a few lockdep_assert_held()'s.
- Patch " btrfs: use btrfs_try_granting_tickets in update_global_rsv" fixed to
  just use btrfs_try_granting_tickets directly since we're already holding the
  space_info->lock.

-- Original email --
We hit a pretty crappy corner case in production that resulted in boxes slowing
down to a crawl.

can_overcommit() will not allow us to overcommit if there is not enough "real"
space to satisfy the global reserve.  This is for hysterical raisins, we used to
not be able to allocate block groups a transaction commit time, so running out
of real space for the global reserve would result in an aborted transaction.

However that limitation was fixed years ago, so we no longer need to impose that
limitation on ourselves and can just overcommit with reckless abandon.

But this change exposed a bunch of corner cases in how we deal with very small
file systems.  A lot of enospc related xfstests make very tiny file systems.
Btrfs by default gives you an 8mib metadata chunk.  We default to having a
minimum global reserve size of 16mib.  This is problematic.

Before we would allocate a new metadata chunk, which actually meant we were
"passing" these tests with 24mib metadata chunks but 256kib of used metadata,
and drastically less data space than was intended.  With my change we started
failing these tests because we were no longer allocating the extra metadata
chunks.

The changes to the global reserve are to make it so we pass these xfstests, as
well as add some real hard logic to the minimum size of the global reserve,
rather than just an arbitrary 16mib.  In practice those changes won't affect
real users because real users use more than 8mib of metadata and will get full
chunks.

These patches fix the original problem I intended to fix, and also have the nice
side-effect of making a bunch of the enospc xfstests finish _much_ faster.  The
diffstat is as follows

 fs/btrfs/block-rsv.c  | 43 ++++++++++++++++++++++++++++++-------------
 fs/btrfs/space-info.c | 51 +++++++++++++++++++++++++--------------------------
 2 files changed, 55 insertions(+), 39 deletions(-)

Thanks,

Josef

