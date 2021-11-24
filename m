Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB45A45CB2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhKXRke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349228AbhKXRkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:31 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F38EC061748
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 09:37:22 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id jo22so2274017qvb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 09:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBQIvxdSpH68K03slsprqKJ08tFrjpP8WOh6b4i6QSs=;
        b=MQ2B7Al/fo0oYK9/wL6t6/BeBJwX9jDMIow77GaLklJALe9iaIPBPtJnYwm93idazc
         EYDztEQ4iDUlMsRYbNv/p9Udvpj11PoHIlk6FEflquhYXw6jON03XaQcyQdF8GHWnS0T
         lK0u6hJW/dj3TBOUY+z6pFq5bK4/V05c1UZ83h/tDMM8kLcgyY/sP96Okv19VF6D+5ui
         aLyAmgmHs327cTGySO8ecHgvZvEjPDGdsh+VsbdWgfDYwDpK9nuONE83potcBDhVv7+Y
         pMCPNQbLhDvZ1uUY53W/lp+kxwenxVGXTCMa80rH+NQ5ptkvZByBop+ye1Tq1zqcP5Mv
         F/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBQIvxdSpH68K03slsprqKJ08tFrjpP8WOh6b4i6QSs=;
        b=vzK/qWDvGD9rvwqTfBUQiS1p0pzQxZYsbbdk2m0AmtLzxZAU1gUdqOZduoe1+TpLzx
         Xn3ZlTWKtJRuiM5Mo+nSPQgoNL4nFsoHYaNYSqM1NCiheXZarzLlvOj3HDyUPF8P0KG5
         dmL3wO3FFMeHHysNy03Jlg5Qc3SrhzPHVyxyg4e2WtQi+p2F8O4ZJEgDfEVqxIbOvBHK
         jtakQt4gvGvRW9dNfQgHxIZf6BQOEHfiFP8IcBDwC6ua7rse2rwjPLgDE5ZkN2m96mXG
         MoMiUT/NAGyAogVbFIgSWBnEs+yTT7/BoudP1OuRaYECcFvWg222mlioybV19ZFbfkvm
         m6GQ==
X-Gm-Message-State: AOAM533ohqKRtZZLJG5+rMjA9k5mEPhBDFC190PTQ+FfnjVmaQJ7j/3l
        xo0faAN6fXfq6JgKg9toHno+i/zPOF5oOA==
X-Google-Smtp-Source: ABdhPJxE8lUgu/8ErjFaz8AQr8XnxHcUOmI+lSdYVINeeR9XoQ+QCrvBfoBs3orxGEWVOoWOPjZTtg==
X-Received: by 2002:ad4:57b1:: with SMTP id g17mr9572734qvx.56.1637775440795;
        Wed, 24 Nov 2021 09:37:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x188sm173957qkd.31.2021.11.24.09.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:37:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Metadata IO error fixes
Date:   Wed, 24 Nov 2021 12:37:16 -0500
Message-Id: <cover.1637775291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Josef Bacik (2):
  btrfs: clear extent buffer uptodate when we fail to write it
  btrfs: check the root node for uptodate before returning it

 fs/btrfs/ctree.c     | 19 +++++++++++++++----
 fs/btrfs/extent_io.c |  6 ++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.26.3

