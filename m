Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2648F3F513D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhHWTYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHWTYO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:14 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926EC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id z2so5776249qvl.10
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iFW/pDK9cbnBp45FVHk//KL/ZwtG8AvKR1019hcGHZQ=;
        b=0nobWgXi4m2aPrFvmhv6cv3nBmPe3kOo+ror5Jmkifr3s5uQh3JIlMBrwd4cFsN9Re
         jLK9lHzEmD/4COnjokdtnf+hHXIyEkD4e/ZoHVNt6DXTdq6Ujt9q+H2gUumfwCrz0eyS
         w0lScIjRXzAZc+LvZrX5yrCQdR0nOE3q+3V9ExOxT2dyw/UCCCivIphPKOIfMghjFuOZ
         yNK2tJKeGIwBskhww2pTTzNyT8WduW5FjdH6J+nndLcYZMz6PkFxNDBP6Dyk0sdrdUuY
         XdhDx9Zf07u/6gjqLdveVPAweyOd4Z85gXViAPh+iU3xZruz2E/vsLwaHs6dEKWGSDfn
         e7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFW/pDK9cbnBp45FVHk//KL/ZwtG8AvKR1019hcGHZQ=;
        b=Kaqf4cfTe7tjrXRe5dwbVPYHVhhakWN2TNPLgyw1qEglzlXsS/fxTIeeJrghG5QSD9
         J3v8ccjbQn7gV7+W+XShjEEnuVSb1x13fVeo2WSusTyU7YiRGfTXZcIvdegSXipIrRaz
         LtZStB+jVsUwqYJN9mSvsOFQjJhQ7y4pqmpU1BUpyedhUg4dtUE/FsaMqq4d47acz+r2
         UOn3KI9rQhb46CsFB4B1nueBYEeDW11rPEd1xz/hATc+oBLNnpOweHKMw3NlGiIFwevs
         TuFOXCRQS5ItJu46n0I+kJKG+YQjIja9tP8ejx9J3O4x/pvuHaruupan4NA1OebYEt9Z
         sVzg==
X-Gm-Message-State: AOAM531OOYS6pdBBZIY3QoUEhV+VJIUXO9ox+XcNwQDDVhdeANoz3PY+
        UN+OrBSv9/0YhEbHRvRsgQ3pLkmKPp+g2w==
X-Google-Smtp-Source: ABdhPJzuJc0JNRPVlGzbwEfBKOhbzIb3Q88RedOkcvuYDxSIp4H4ub4NPxu4zYVh3iEeA3Epneqnug==
X-Received: by 2002:ad4:5c62:: with SMTP id i2mr35361425qvh.32.1629746610048;
        Mon, 23 Aug 2021 12:23:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a185sm9067214qkg.128.2021.08.23.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 8/9] btrfs-progs: test: add a test image with a corrupt block group item
Date:   Mon, 23 Aug 2021 15:23:12 -0400
Message-Id: <f55af588317b5c3f1d70634b0202c6fa19bb19a8.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This image has a broken used field of a block group item to validate
fsck does the correct thing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable

diff --git a/tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable b/tests/fsck-tests/050-invalid-block-group-used/.lowmem_repairable
new file mode 100644
index 00000000..e69de29b
-- 
2.26.3

