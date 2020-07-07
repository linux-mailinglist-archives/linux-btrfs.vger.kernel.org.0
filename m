Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5D2172AA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgGGPmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:42:51 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55303C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:42:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id o38so32080569qtf.6
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoL++V4wF6ueYRcoxQ9f0HpXI5UAyYvT/W16ZHf+/Hc=;
        b=v4F8l7A8PfZTc+lNA2Nm0JHX5c8pfqk04quzGauXiDqktN4TPo8yOpIRt2U+vXtJJI
         9hVHBuZ1M+i8QRUZ/7XdyO+ImIWcvlwHrWaCe5dTZKTORwNnlGsyhswmKLhTHynQf2HU
         N91lX6CNbTiQ04IB0bbKI8jwLXUkAntxuo21BwqHqC7NsJh3v2apN++G8sb7qaSb8qzA
         3E1/cWTIvsiLPzuSj1fLNkZiGYudqFlHIulDHYHKbo/nZ9G+2bv9hmevIQZWUlwJEFwf
         Ovfn4yherSyaFkJibnX6kw8rrnz0V7xNXr1xpok/Gg9XkqhW59ObpVN5vZxfGRAbwgHn
         K+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoL++V4wF6ueYRcoxQ9f0HpXI5UAyYvT/W16ZHf+/Hc=;
        b=RJY/5epqZVrBNyOI764fiuaD/nlFzD33a+eLXIFTVnigHjF/Mue+N61lg0asJ/tvM/
         2330clUm6f0Uj1UQnaDidO6b2XM2CbJiBWAYDs6rsPhgAdwT/6NznQEtREqZIxZ4WYoV
         tsHHCLytUzNI+C6VGDn7b2NLtCQNBUyFSuAEvvhabARNlEPnOmJGX9VbMQlDenE4IatT
         WdVq8J2cqUPuENJzEL167vhEipH2O6cJEqRC36avjsX8tRxOXO8SphpFDdSRlCMdJiNF
         TpskEOJ9pt3LTLHJg1vmNA018H+kn4Z7ysKLGFyQeOpwe9rhLGJhgY/H5zrZmc7JKbFn
         ypSQ==
X-Gm-Message-State: AOAM531oXHh1ost0bJrAihhsG3nrNhN33TV+Zjfbb18rNp2bBalbLif6
        B/Yr5H8IGaBL/yaZqCRt6WU+QZOynxNW+A==
X-Google-Smtp-Source: ABdhPJzlU2oqSBrwbSWRJwca36yFlllNyc7M0niJQRxK6nwWbFPINSAlmzp8DBC7q2mruNzUOS1AGw==
X-Received: by 2002:aed:2987:: with SMTP id o7mr36613674qtd.385.1594136570268;
        Tue, 07 Jul 2020 08:42:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i57sm29160854qte.75.2020.07.07.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/23][v2] Change data reservations to use the ticketing infra
Date:   Tue,  7 Jul 2020 11:42:23 -0400
Message-Id: <20200707154246.52844-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Adjusted a comment in may_commit_transaction.
- Fixed one of the intermediate patches to properly update ->reclaim_size.

We've had two different things in place to reserve data and metadata space,
because generally speaking data is much simpler.  However the data reservations
still suffered from the same issues that plagued metadata reservations, you
could get multiple tasks racing in to get reservations.  This causes problems
with cases like write/delete loops where we should be able to fill up the fs,
delete everything, and go again.  You would sometimes race with a flusher that's
trying to unpin the free space, take it's reservations, and then it would fail.

Fix this by moving the data reservations under the metadata ticketing
infrastructure.  This gets rid of that problem, and simplifies our enospc code
more by consolidating it into a single path.  Thanks,

Josef


