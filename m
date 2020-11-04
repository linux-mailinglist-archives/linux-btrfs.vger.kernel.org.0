Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6494B2A60E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKDJtJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 04:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDJtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 04:49:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6FC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 01:49:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h22so1726460wmb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OqlgeG5PMY1fCKRWEP+B9ZVotNTjqilRPUFt0ZjjI48=;
        b=tmKeQ6ETWEcFaTRck95ZxpXO9OVXVhkugV9sd6x29ZURk45kf9AsfEjN8PqCKO9C2X
         sunxurPYifzS03ChRj1QzT8RSYWX3BAtk58KX7vu87THG+wFn1YWKUvXd56+mUE7ry71
         yYg7TQSv1O3sCU/5doCmyaQxdUJryk7oZ/NYZF4reO5Td4Pkjlxtw2N+hSCktgpAyOR6
         kHK2VbO2pDcZ0U2MlmgGxAR+Cc7923r0+Ztmh6Z/+GBsIIcS1To351rA81vdF5Zhh+lc
         Y5HWeAPimdLDI07Z2eE3anUoh5u+55RKyTU9E45bfcHUENklufogdwpli7SDT11g3WG8
         4J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OqlgeG5PMY1fCKRWEP+B9ZVotNTjqilRPUFt0ZjjI48=;
        b=NYnRgVHJetzomm2KC27jPtnJ1d0jELEZCZmuCHLxleyHADwGs3RZS2zNB1UtYIwFJ3
         2WPiGoOsQcB88YtL844PO6azLKLJoF9o6g8WWf10PHo+cd8vroWhMXk6IirHmUj0/YuY
         Kh0lwzCQTAD7Zs+RF7/23YJ/kfKPWr2uICotsCgQeEG42uO3O/fuapbloKW6X/55gZpx
         2p0cAIcVuKYcNg8fn9rj/umrqLcyKJ1yihLvamwTs5rdhYg8ExdfApvCjOym3zjJ30IW
         y+vTAhbp8o7/NMb6OzvolHn8IxU1cNxeIZpzlXGrQZBSHzndBlCIwc0SO5oACNmRDoEH
         VIKA==
X-Gm-Message-State: AOAM531Hw6xlBhVdrPaJXnEeUjXiNO9zoi9NqezADi6sYEDA4IkjVB3B
        /C8EBbYLM3fzBOHlZV3CHWjNeY1Kyz3q7Q==
X-Google-Smtp-Source: ABdhPJwkIvfY7IdKi4vrAENvvJJyMyXe5oNkakVIPVAQcy1tIZGYF8950B46u5s0FVdwUP5oqv/XtQ==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr3642350wmb.150.1604483346747;
        Wed, 04 Nov 2020 01:49:06 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id 3sm1478081wmd.19.2020.11.04.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:49:06 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] fixes for btrfs async discards
Date:   Wed,  4 Nov 2020 09:45:50 +0000
Message-Id: <cover.1604444952.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several fixes for async discards. The first patch might increase discard
rate, drastically in some cases. That may be a suprise for those
assuming that hitting iops_limit is rare and rarther outliers. Though,
it still stays in allowed range, so should be fine.

Pavel Begunkov (4):
  btrfs: discard: speed up discard up to iops_limit
  btrfs: discard: save discard delay as ns not jiffy
  btrfs: don't miss discards after override-schedule
  btrfs: discard: reschedule work after param update

 fs/btrfs/ctree.h   |  3 ++-
 fs/btrfs/discard.c | 35 +++++++++++++++++++++++------------
 fs/btrfs/sysfs.c   |  5 +++--
 3 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.24.0

