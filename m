Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1A45CD05
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 20:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbhKXTTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 14:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbhKXTSc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 14:18:32 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC64C0613F3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 11:14:28 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id m25so3706448qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5xsno8CVnZhZB/ZfdmuKA1u39KM6FI72HYKEfX4WRQ=;
        b=lhjIyC/9tE6ViuNgFnxaWQvHAxL+u05SHEDaBiyY46uQls0xBpJTfQJRzvybZ+C2jO
         sOHNhp8wdw5fukwyXd5Jm8uVYBj8oub5Wshba4Kd5OP2fhIvnB/XYi0fIS3AA7jUCqoB
         Zph1RCrCRbez9bsrA5ZaHODf78UjiDunvF4GeTMjgkOmU4p2vPwiF9K3EqBlhCwBYu7U
         MAQs07cQkSmljA7mY8HqOCX+7CCJZmPF3S29LGxFfpuj6ijvQ8fDrhA4LX50GudU/0f5
         KtTAV3vS4GY9VHq91RcKEe6pjCuMufpydFX7RsaPxNmzzz+Gpx6mE1ccryOLE6rNWM/p
         K16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5xsno8CVnZhZB/ZfdmuKA1u39KM6FI72HYKEfX4WRQ=;
        b=6S7HL6x9OOpX7yXm2G4Qgto1OtUfqSGp9iTummZXAFm5QZIkRr0G0Q9z2d4pNSr8PW
         0y1JrHnurJc9Fd7wKAPTC0Hk39hECWROj3aVh3/xfLb6u4eAO0d24EkaKEv42Pk5yMXO
         KdNYatRXDi1+u1KvnPko1vYDZMihAjcogDhKG5XLSD8dSS1pDjmlSE5we5JjQuSEXcsf
         eYJdHowtCxWak7B7YtuTSjyAzkAISzcqvxHQb03P5LAiuOBQmfXdHP7GrQ7pF7AwPmzZ
         HlQGAjGDvGYdu5w/0GaspoIltaUZiUTIt2aWIkVEN3WrMXeK4v7QqB2cldhzjYeNSqkS
         Vhgw==
X-Gm-Message-State: AOAM532OoldqayFT63+Auu0LNnTNE2oiCvQuo/sTZrBZm5i9R+D9evvx
        bC6qpQcksLZlcZOzl/TSNC+dL9GgzCuhPQ==
X-Google-Smtp-Source: ABdhPJyMyqOW0sprA45iAeIMYuZeDGNn3w/LPrWiFddSAKXnNaw0ivXmLXopRDKkKO3QV+bwAlbWpQ==
X-Received: by 2002:a05:622a:19aa:: with SMTP id u42mr1415718qtc.443.1637781266755;
        Wed, 24 Nov 2021 11:14:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y18sm373154qtx.19.2021.11.24.11.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:14:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/3] Metadata IO error fixes
Date:   Wed, 24 Nov 2021 14:14:22 -0500
Message-Id: <cover.1637781110.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- I was debugging generic/484 separately because I thought it was data related,
  but it turned out to be metadata related as well, so I've added the patch
  "btrfs: call mapping_set_error() on btree inode with a write error" to the
  series.

--- Original email ---

Hello,

I saw a dmesg failure with generic/281 on our overnight runs.  This turned out
to be because we weren't getting an error back from btrfs_search_slot() even
though we found a metadata block that shouldn't have been uptodate.

The root cause is that write errors on the page clear uptodate on the page, but
not on the extent buffer itself.  Since we rely on that bit to tell wether the
extent buffer is valid or not we don't notice that the eb is bogus when we find
it in cache in a subsequent write, and eventually trip over
assert_eb_page_uptodate() warnings.

This fixes the problem I was seeing, I could easily reproduce by running
generic/281 in a loop a few times.  With these pages I haven't reproduced in 20
loops.  Thanks,

Josef

Josef Bacik (3):
  btrfs: clear extent buffer uptodate when we fail to write it
  btrfs: check the root node for uptodate before returning it
  btrfs: call mapping_set_error() on btree inode with a write error

 fs/btrfs/ctree.c     | 19 +++++++++++++++----
 fs/btrfs/extent_io.c | 14 ++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.26.3

