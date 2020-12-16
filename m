Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E32DC3E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgLPQTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgLPQTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:19:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34AC061794
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:50 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g24so5167688qtq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1YCv29jaX0KFbUE5V4IevCXr7qO6nyHvD1R0kPKnF8=;
        b=YpubfP9iN3eHRSTPSLYfspU+O8ghXhawbda9DluQ+HbmZnX9/Gm8CHQwgTJPE+XXyU
         E/GYLC8zo3pReqXADsPs8FqCftiCBO5TTFhic99HP8LB5fMWvSBr0L5Am9P6jqAaQQmq
         16BFME321YjuiLKWtbuYsfvAhQ4N/Ws5kbA2pfmhmnF+PC/Tednv8DNX2rbIs7xOaHKt
         v2+TOCsk2+nlIFH24BffpVX3jVSUoDcxe5G0S9AY0zoe4OzniQMaajoADCmVzyNRmatY
         LKuQHxflunhAxn83QN4N+j6369X4WSqwLkSjm8D9aW5jcm6s4aPqLGL5N5g8B5B9gVH4
         EUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1YCv29jaX0KFbUE5V4IevCXr7qO6nyHvD1R0kPKnF8=;
        b=Nvahgn+YT8NmAr3psMt5qLjQvNMEEoZefv4AGHVlNeXvwKlbdRdoAqL1Cs/5gmvmq/
         C2M9U6p3fKSUuZyWPAH5FrEh9/UvfL90KwnV4UMpz+mhSS0sRI6Nm6B1QwPoVf6hl5Lf
         x4p8vuf5NioSDVoTAEpPKAsUHO0aP3UMcEqLKWH1eiwnwDldXz6eF+/j1QFJdL6NLyzW
         fjduo1Cj5mCZ6RJKsehnL4v9uzdIEyjnqc/8kJXSbd94kaYgZpNs6+DHiKfXZ8MNZlAg
         QvUA6gw2lo42xvACz8dHw0Pqy2joYx5vtcV6uKRwMl8KAeHeiS+y/lkGVUYaS+qadsmK
         Unag==
X-Gm-Message-State: AOAM530AwWYzzWz73Ecdj7ke4vEw3NzF22NuA5oHySLUC6VPGfxKHfHs
        Fma7a8nqlPcMzYoEMDFD7dG+uXkOrhfRGFZw
X-Google-Smtp-Source: ABdhPJy13bC+gJxwC9Qt+RiScfb/jM8k+PzwIk0Q5OlxLa7QthgmFkIFiJOQxV1yWAbaOZD+EBwlxg==
X-Received: by 2002:ac8:46c8:: with SMTP id h8mr19766111qto.17.1608135529455;
        Wed, 16 Dec 2020 08:18:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d25sm1343753qkl.97.2020.12.16.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:18:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] Fixes and tweaks around error handling
Date:   Wed, 16 Dec 2020 11:18:42 -0500
Message-Id: <cover.1608135381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

These patches were originally in my reloc error handling patches that have been
broken out on their own.  They stand on their own and are simple and don't
affect the code in a real way.  Simply fixing some cosmetic stuff, or allowing
error injection in certain places.  They were patches I needed while running
error injection.  Thanks,

Josef

Josef Bacik (5):
  btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
  btrfs: print the actual offset in btrfs_root_name
  btrfs: noinline btrfs_should_cancel_balance
  btrfs: pass down the tree block level through ref-verify
  btrfs: make sure owner is set in ref-verify

 fs/btrfs/ctree.c      |  2 ++
 fs/btrfs/disk-io.c    |  2 +-
 fs/btrfs/print-tree.c | 10 +++++-----
 fs/btrfs/print-tree.h |  2 +-
 fs/btrfs/ref-verify.c | 43 ++++++++++++++++++++++---------------------
 fs/btrfs/relocation.c |  2 +-
 6 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.26.2

