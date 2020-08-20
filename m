Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90A24C1FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgHTPSp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgHTPSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5969C061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so1077164qvb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rP9p+cRiJXsFnnispQVcnWitvdjgsbgOZIx9kSQah40=;
        b=UWLAbWc+yXrS464wISK51PJiNuqPUa8w3oqYH91TxxoUF8LFYqaTBbT9KYgRjntC/I
         nCOoNeU18uoHi6d7C445avc8EfhA4MR6dGC7LLTpohQTZb/N6DjaMQIScpxjO7zS+I2X
         8QPB7X9JcGzcfA9yayABJ3ZKFbOzIJbMWd5mqVIC5u9FJ5T+NbtxRjzpGH+4WtP6YSzZ
         P/LNsbMYPrBEfIV4oFz5P6o+1P8eesjgP2md6CjEsxNYpzw+6GZHirns7LmBIwfuxZyv
         OOcJ7hIA6grfNeTYjk/X5pnfICzKO6kT3Tv6OvexXpvnf0Gg8br9QOJYTxVzQNsblLYB
         vCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rP9p+cRiJXsFnnispQVcnWitvdjgsbgOZIx9kSQah40=;
        b=pw8gdy6NzsXsvolWl3mr39XsO3OSYc20vHTLmio1ZZ68RC1BlJpVRCBocXC4j6/3P0
         w/BlTIk0s83qQENkHaxgGw+opai2LwqPMdB/GAsmYryNStOGC2tuQ2pEtkdXWJ6dxwzX
         qNnWXxmi3doXp9McYJXD+xyTZFaB5OnBsBuDYTPCqvXJZQ1mmtCe36LdONqF4BK+jzdI
         OAPtD4vRj+sS7bpA7hAtWMipMdXx6N3En671uck54ZAESun0pDohohNGbkOil+iUWJDF
         tiShf9lebWdPKKXPJ9L9vNRpAKuUfH+UfVCiPEq9ARvNE4ovE7gklyHiwPjbRthZD/Jv
         D5Eg==
X-Gm-Message-State: AOAM5302FBcJ5cGat7zbx9Gtdf1wLPltjuuX02D4E6xyjtsDB9vV0bFS
        c6pWuuyPudavwKYeFrikz/pL+iESutrasVWN
X-Google-Smtp-Source: ABdhPJz8C6pdHgOhI2AH9JpSwxiM5AcwQ6idNnrvIPZdCxLzZY3xjr0+lGqZGfUZX5vrBUKE4Yhv3w==
X-Received: by 2002:a0c:ea21:: with SMTP id t1mr3483038qvp.62.1597936713516;
        Thu, 20 Aug 2020 08:18:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i19sm2468629qkk.68.2020.08.20.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] Lockdep fixes
Date:   Thu, 20 Aug 2020 11:18:23 -0400
Message-Id: <cover.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While reworking the btrfs locking to use a rwsem I discovered a few more lockdep
issues because of the new locking.  These are stand alone fixes that are safe
enough to go into 5.9, so I've broken them out from the overall locking rework.
I addressed the issues that Filipe pointed out (I think I did anyway), and run
the whole series through xfstests and saw no more lockdep messages.
 
fs/btrfs/ctree.c       |   6 +-
 fs/btrfs/dev-replace.c |   6 +-
 fs/btrfs/extent-tree.c |   2 +-
 fs/btrfs/extent_io.c   |   8 +--
 fs/btrfs/extent_io.h   |   6 +-
 fs/btrfs/ioctl.c       |  27 ++++++---
 fs/btrfs/scrub.c       | 122 +++++++++++++++++++++++------------------
 fs/btrfs/volumes.c     |  23 ++++----
 fs/btrfs/volumes.h     |   3 +
 9 files changed, 121 insertions(+), 82 deletions(-)

Thanks,

Josef
