Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2912A2DC48F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgLPQri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLPQri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:47:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C34C06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:46:58 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 4so11633496qvh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jov9CPuCWs4UHbh4kIXNiorA1YLwLileDa+I2Yb5ZiE=;
        b=T2ADMgAzDowu9ySYddCQWksgfXh/dWyP3YAFNSqLlNKNJ0cxnAtjVubiZ3LOC4Cx5m
         Bi8tNOGnB+01l5oq3kpbhGwRkzCr5wVp9YBql7abN0mXLCL4cyJC9jMcq8rXFh2W+4ss
         iVJhl02pbbuxuUElmiaIXL2fS7yUoYGBYXJZT2jAzdpMgpfHLsTFK7U7cPZETO7n7UWl
         HcpUDaqJJYIRKx3eWBzsZyYCCILL+0W01SjQSNNwGz8MzRY+RbgdkEimbjBZCpH7lDLC
         mZwluxXYI2iQE1cxGa3OIGd6X1XiLnoF1+QoC7chKVUU+BM9FYCHuulmuVsFwQSw+gwa
         eAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jov9CPuCWs4UHbh4kIXNiorA1YLwLileDa+I2Yb5ZiE=;
        b=ABN4dzTv09l3XBmiqEoQ+cewf9wgNc5qVr1BojppfV4NGtQFEy5w4GtufSePSL9UG+
         GKGrcWBv6YowuslM48Gmbr12Y7ab1WmVY26xPGkisj1vam2Sn/fFgSz9qR5cYYH/TwsC
         hhlmytVGjkob/hD7OpTDCZcVGhlltAwCYumTSxcMGsCDjKLZYp3dicMGLYDprhr8h0h+
         zS28I2aFh7Pyi0F3l5m/yb2VFMMu579rVV4RvJ5YKN5fHyPHhzILMxrpRNf4XHsUrwGU
         gvS8hCz0aE7c1cR6tPxbtZ3kK8yKlU8eXlL4B6H/xz7/sy2gZPkPCYGkbbRehDntdixM
         TITg==
X-Gm-Message-State: AOAM53122t5yhqC2g/4zgBZp3ZlZXn5vJ7cEtWkYgELOoVgEZI9IKVkY
        WRCwh1YSayji9EwrsWuLAA+w0tndezO/4Xyt
X-Google-Smtp-Source: ABdhPJxP3VPchil9QBPBhgJfvAOYOdkqPvJkgWa9z9kV25hbolTlWr+0FhW2UrenC2U7QMlPr6eFzQ==
X-Received: by 2002:a0c:e6e7:: with SMTP id m7mr44949390qvn.11.1608137216857;
        Wed, 16 Dec 2020 08:46:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h1sm1268056qtr.1.2020.12.16.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:46:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] ->total_bytes_pinned fixes for early ENOSPC issues
Date:   Wed, 16 Dec 2020 11:46:52 -0500
Message-Id: <cover.1608137123.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Rebase onto latest misc-next.
- Added Nikolay's reviewed-by for the first patch.

--- Original email ---
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

