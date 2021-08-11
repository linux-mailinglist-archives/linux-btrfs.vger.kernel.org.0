Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A203E97B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 20:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhHKSho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHKShn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 14:37:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD360C061765
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 11:37:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e15so2907669qtx.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3OyCvBAksC9CGFNH+U7o9yY7Jlkj2MGkTvyifoeK2E=;
        b=Mr404rv1Q2DqkjDkAIpuGV89+zg1q8PsaMaTlE99UL9s6KsIf3mYkUa8E89Ur4af2j
         j/xrYArMRAl+r8PzlVClveyqP9BB+H1uEnadzw2XVMPRlo+5UO1vR+KxSwDcgkqIcqfl
         4RxxN05prtk/Zh2qvQquC6ImW6AmL2Q6T/9tWaDoynhHuBTqkMCWwhczFJy1CDnlxyfa
         9+OfdLO+SJD9lzoRn4IBY57edRKBwaGahnRIQppR6SL24ayes6+mVs7w9lu7/dQnjXqG
         lPzpHccOTrzDSu+x2imjjMh76kyIQPN2nunJp+x/+ueFeeMP8yqmlj1UXsF352G2BHHu
         5FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3OyCvBAksC9CGFNH+U7o9yY7Jlkj2MGkTvyifoeK2E=;
        b=cOlju5RAudykdHKhIJ0SLl9loLR25DlTumFf//2QbYWENOuM9zFN0vN1Sj6C+Oas1W
         86EQwfhTrdNZDyQwZ0FVGYey4QP7xGa4/p8w6v0vQCvvPMDWULSpcfrdGwAcdow+johJ
         pE3YhqFs2C8w7m21NCYaAAzUVunFgrLQv2N7iTP8COQ++fPxjKygXqESLkWHqQ8DNvZX
         pmpQrKkXqaQ33zW56uw6xzPMjpbMChPXf2XD+SfnpIl4yq0phl3ka9WEr5vkc8As4yew
         CP34sZsk4mcDgqtagNi2DykcLUaWyNm+/ZoVeUgeJSkfaMMauKKrOv5subpOgHM1Ndnh
         CkvQ==
X-Gm-Message-State: AOAM532MPn+mozny1OVpldE6sqX312CtwQlnbaKtgKUoveAbv42sD1ic
        rxpKnRzxU6t/KsoRt9vRXoO9L76j0AMNOw==
X-Google-Smtp-Source: ABdhPJwWW2459Yd+3Ev2jXigJzD8dCaQz/cXB6FwjfN/76SDhssTMgLlwjdPuj/khCLvitwhX4oXig==
X-Received: by 2002:ac8:73c8:: with SMTP id v8mr100903qtp.85.1628707038363;
        Wed, 11 Aug 2021 11:37:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q6sm22156qtr.91.2021.08.11.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:37:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Preemptive flushing fixes
Date:   Wed, 11 Aug 2021 14:37:14 -0400
Message-Id: <cover.1628706812.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I thought I had fixed the preemptive flushing burning CPU's problem with my
previous set of fixes, but I was wrong.  However those tracepoints gave me the
information I needed to fix the problem properly.  The first patch

btrfs: reduce the preemptive flushing threshold to 90%

can go back to stable and make its way into the distros to stop the pain for the
current users having problems.  The second patch augments the fix with a little
less of a strong hammer.

The problem is for very full file systems on slower disks will end up with a
very small threshold to start preemptive flushing.  We were relying on sanity
checks to bail out ahead of time, however they were not strong enough.  These
problematic cases existed in the short area where there was enough space to
operate without needing to do synchronous flushing, but not enough space to
avoid flushing all of the time.

The fix is to adjust the sanity checks to something more reasonable to account
for these cases and avoid spinning doing preemptive flushing constantly.
Thanks,

Josef

Josef Bacik (2):
  btrfs: reduce the preemptive flushing threshold to 90%
  btrfs: do not do preemptive flushing if the majority is global rsv

 fs/btrfs/space-info.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.26.3

