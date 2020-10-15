Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7426528F876
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbgJOS0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733056AbgJOS0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:06 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC57CC061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h19so70370qtq.4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyAds3OOnz6zboTVBw727hLUyPdhU7m05Bbz4O6dQT0=;
        b=aHs0c0s9ijEC/HS1gl+89zYKKxKN/nxS60VPyNvgCj7iVoltHM0Z2tfHbY47ZR6+Wg
         EWohBnY5rnXrlROUOYsPMAhUtNy4ZuG+RLpQf6hiRRfnRplFcP9ny+5p1OxbKbS1YNg4
         Dtgxeb9hoVzBYk/UoZjm9Z9O5GT6kR7rF14DeaHE35ZIGin/I00gRnS/YIZpgBdn6lnV
         dxSShelAh2f48ApAG7DZiROjLrpEQrfx/qmxgFktqigk7dntFPv+EotKhYzyEVWZnMdw
         Mb9eug66eMiUf8Tny0sEuIHxiUGQK8C+MdLptz6NR/Os1k+P5/0Tks+11apOuLmzGNs8
         FoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyAds3OOnz6zboTVBw727hLUyPdhU7m05Bbz4O6dQT0=;
        b=qNIfG7J7B3tu47lEcume6VdQST3HSuxqx9iTJ0FNe4iIRnNflshDuo7Own0bpAVbTz
         0psOVWabOK+mNkBxgWs9rGHMwB9DdEGurt39DHR/hZ1vpmMQ/da5j3EX6MD6xIJWO8Re
         3lSvEy3p+bmbAaDQZgsGjEErovGuETQE08QSEz7w8o1JfdzLLBNwRqzu1m6G/3EIF2py
         G7mn+8pDD2hvmp6okdflxoSVY3NJFtokiAGyrzKgf9c9rhyDMfreruDg4EQeWYq+OfPr
         vNIL5KVZoBTJYB7XFhFyrfmR8BvR0YXr1KhV+ojt7qRqs38eaXRgXmmhbfYXxPqlLQ3M
         PvVA==
X-Gm-Message-State: AOAM531hcsgWu9l698uRds1PbMI1tKOv21mgtfXjQZKzV9Rl3n44jkA6
        H97jdUOO0O7lN1rHVtkvX/B64jIZF8EFVmb4
X-Google-Smtp-Source: ABdhPJz5cjw/UfBo5VdfhvpZE+nUNd84tSvFEuWIR/rh/YjS0jmOCTxKNFg6uU5ZCZ97lRhtUNor1Q==
X-Received: by 2002:aed:2706:: with SMTP id n6mr5408517qtd.280.1602786364737;
        Thu, 15 Oct 2020 11:26:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g1sm26107qtp.74.2020.10.15.11.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/6] A variety of lock contention fixes
Date:   Thu, 15 Oct 2020 14:25:56 -0400
Message-Id: <cover.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've been running some stress tests recently in order to try and reproduce some
problems I've tripped over in relocation.  Most of this series is a reposting of
patches I wrote when debugging related issues for Zygo that got lost.  I've
updated one of them to make the lock contention even better, making it so I have
to ramp up my stress test loops because it now finishes way too fast.  Thanks,

Josef

Josef Bacik (6):
  btrfs: do not block on deleted bgs mutex in the cleaner
  btrfs: only let one thread pre-flush delayed refs in commit
  btrfs: delayed refs pre-flushing should only run the heads we have
  btrfs: only run delayed refs once before committing
  btrfs: run delayed refs less often in commit_cowonly_roots
  btrfs: stop running all delayed refs during snapshot

 fs/btrfs/block-group.c | 11 +++++--
 fs/btrfs/delayed-ref.h | 12 +++----
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/transaction.c | 73 ++++++++++++++++--------------------------
 4 files changed, 43 insertions(+), 55 deletions(-)

-- 
2.24.1

