Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A3258E81
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgIAMsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgIAMJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 08:09:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C3C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 05:09:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so614005qke.12
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08tuYLwwxyxSZta6Qh42p7yX3/8dEiYCWxoMsNIkKpo=;
        b=hkUlrTrVMERRXkG4aHzey/soDWXWVMxqjwzFIOmJRdnPE5s1sED3hKFplPXN+Y/OK8
         ISTilwx2t+P0WP8/Jxp7OabwO1mXTuI3beqRiK0y//kNGivxWPHRClfNgTg+ldAx/KaX
         CTNSKCbnx5bYGV6WgdX56pvFUegU9EYyMTwZDEm1xkfJyQjHxxPgGn1jJffc1jE+mLUm
         1TJv7UGOE9DxfEyaPsNl8y/MRQaLmb+qhMQDF1Y7Ricp5vh0psVnYdPPRlYJuAGnKd8O
         7Wg+hU0Mj9ew1kF3lhO1JdTEIpYWnsZdUdR5RmhWiKalpTDFH2rigj2ZMEuKlXqmLxh5
         OAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08tuYLwwxyxSZta6Qh42p7yX3/8dEiYCWxoMsNIkKpo=;
        b=tkwBu3bszDrEAPQs5aL34Bxk08bg4coHx1u/LOAgum4fINzbhYbupL/78+DhkY6yZi
         8NC0BwbWq/NlNCYat7q9UIeL75HMxYu55bD4GYRdqZFNKRloq7FfqA8OmbvoMo3CqQTg
         2luxTWIjwvVcVCASLy/Xh8kQPuIZuMAnjjEdtxZ09uPWd6ehojGBnb+q+oma/T+4WwCB
         MEtvlYs5EeQA+KVuKc1ivA0sbRo5hTWxyzkHDrIwY6wV1eyu7FvMDKgtHnIbtoG7kqfV
         QOtPOnRgCwXefdlE6R3ujQioYGU99XXA1xbXoyz6jbfr8RNdcqevelEZ1Ern4JanDW97
         Y4XA==
X-Gm-Message-State: AOAM5303A0ZMA228HaU3hi2k1arnfqpb8HbcxrIGOqwVfIC3ByTlGkWO
        IdC0kwUrPZhFMGsXx+XRoFuUBZXF9YQCV6ut
X-Google-Smtp-Source: ABdhPJwFCfizDP+XnF7Pkb4dqwkV8JKMVG+/Qsr4/bPIHYfpg7RLronUzPRiwJbL5t1sEHLIZ+chfw==
X-Received: by 2002:a37:b204:: with SMTP id b4mr1535728qkf.50.1598962144433;
        Tue, 01 Sep 2020 05:09:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t8sm1145397qtt.95.2020.09.01.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 05:09:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] A couple of lockdep fixes
Date:   Tue,  1 Sep 2020 08:09:00 -0400
Message-Id: <cover.1598961912.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

These are the last two lockdep splats I'm able to see in my testing.  We have
like 4 variations of the same lockdep splat that's addressed by 

btrfs: do not create raid sysfs entries under chunk_mutex

Basically this particular dependency pulls in the kernfs_mutex under the
chunk_mutex, and so we have like 4 issues in github with slightly different
splats, but are all fixed by that fix.  With these two patches (and the one I
sent the other day for add_missing_dev) I haven't hit any lockdep splats in 6
runs of xfstests on 3 different VMs in the last 12 hours.  That means it should
take Dave at least 2 runs before he hits a new one.  Thanks,

Josef Bacik (2):
  btrfs: init sysfs for devices outside of the chunk_mutex
  btrfs: do not create raid sysfs entries under chunk_mutex

 fs/btrfs/block-group.c | 23 +++++++++++++++++++----
 fs/btrfs/sysfs.c       | 25 +++++++++++++++++++++++--
 fs/btrfs/volumes.c     |  7 ++++---
 3 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.26.2

