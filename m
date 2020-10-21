Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1214D294D8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441719AbgJUNca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 09:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441716AbgJUNca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 09:32:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEA6C0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:32:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x20so2441942qkn.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiOiiCPvJSIa7tehI74N8PmMEZA1PCW98746rpaIrJ0=;
        b=bZ7KpPgyBa2Y7xjmhBzKSuLPIBfDKMaCKeKLrjprzv5jP68BdeyCJocLVRUFoO90jr
         +Iqi9fWGjbiUOgfL9E2KtRMiEZdSxCk6djL/QTSwqFeUrnkNsnjUS7W4jif2bloRzPUc
         YDqHvvB5Tc7S08RV6BmdMIOduIoi+3L+q6024grEnk6c0zYIWSJD5uGFR5SsU52lrtVU
         RX9BFSm7Qc4YSgWCF7kMyw0+q0rHpb9FyStEazIFD8EpzFxiZaUDPmurDcVrBaegFwW+
         wwRuQSX+gMhBOhbpozb5lJlkw+3oEsPZeKddTX7kaklujEAqlGKhgWdQ5Diqj0ccwdHJ
         ejZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiOiiCPvJSIa7tehI74N8PmMEZA1PCW98746rpaIrJ0=;
        b=my9mfDA3AD/d/pmyU9TR2w/XczTEjwoIRoHdhv1CvALN88MTeIevkgelDU1ySSdlq2
         yEmPrnXeKHjYU4BUc5gDZf/39eq8GpjaKXrVRslsOemQklnO7N/T2A9/iwiYxmW/V6JJ
         hvYzuGtLCEdx2yHGw4NdiFbnrKooOAzKvY1AOkR2S1Kqx+L+bc63vqX+5hATLYQkoYci
         OdhRHx84v1lf7QcNxv3DjKGYV2Ff1xZsOCw0cmasqg4VFQneBqYf3FV8J7YGKRAz/lTw
         AwxWATZOBokrhmN9VBSKuYwxFHP4RjRqQOwuaqNn2WKpWIyevzTA5FittuCEUSE6Rk08
         2oGA==
X-Gm-Message-State: AOAM532JYEPj2WEnmIr5qkeg+gmWDJLGezwyDEuEHCEeDEKcCD5izHKx
        9sQ+g+MP6+PkkitHTL6mm0SyQXKVb38YVLx5
X-Google-Smtp-Source: ABdhPJy2ZVTvmtnT6An70PGAbqg9fkyQxopvZ+b3DOKANA0ar9xTEzuVKgJGpRIyT38ZoQ0HZgssmA==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr3167946qkm.183.1603287148851;
        Wed, 21 Oct 2020 06:32:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6sm1212591qki.112.2020.10.21.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:32:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] ->total_bytes_pinned fixes for early ENOSPC issues
Date:   Wed, 21 Oct 2020 09:32:24 -0400
Message-Id: <cover.1603286785.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Nikolay discovered a regression with generic/371 with my delayed refs patches
applied.  This isn't actually a regression caused by those patches, but rather
those patches uncovered a problem that has existed forever, we just have papered
over it with our aggressive delayed ref flushing.  Enter these two patches.

The first patch is more of a refactoring and a simplification.  We've been
passing in a &old_refs and a &new_refs into the delayed ref code, and
duplicating the

if (old_refs >= 0 && new_refs < 0)
	->total_bytes_pinned += bytes;
else if (old_refs < 0 && new_refs >= 0)
	->total_bytes_pinned -= bytes;

logic for data and metadata.  This was made even more confusing by the fact that
we clean up this accounting when we drop the delayed ref, but also include it
when we actually pin the extents down properly.  It took me quite a while to
realize that we weren't mis-counting ->total_bytes_pinned because of how weirdly
complicated the accounting was.

I've refactored this code to make the handling distinct.  We modify it in the
delayed refs code itself, which allows us to clean up a bunch of function
arguments and duplicated code.  It also unifies how we handle the delayed ref
side of the ->total_bytes_pinned modification.  Now it's a little easier to see
who is responsible for the modification and where.

The second patch is the actual fix for the problem.  Previously we had simply
been assuming that ->total_ref_mod < 0 meant that we were freeing stuff.
However if we allocate and free in the same transaction, ->total_ref_mod == 0
also means we're freeing.  Adding that case is what fixes the problem Nikolay
was seeing.  Thanks,

Josef


Josef Bacik (2):
  btrfs: handle ->total_bytes_pinned inside the delayed ref itself
  btrfs: account for new extents being deleted in total_bytes_pinned

 fs/btrfs/block-group.c |  11 ++--
 fs/btrfs/delayed-ref.c |  60 ++++++++++++-------
 fs/btrfs/delayed-ref.h |  16 +++--
 fs/btrfs/extent-tree.c | 129 ++++++++++-------------------------------
 fs/btrfs/space-info.h  |  17 ++++++
 5 files changed, 103 insertions(+), 130 deletions(-)

-- 
2.26.2

