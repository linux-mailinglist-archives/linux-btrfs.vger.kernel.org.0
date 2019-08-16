Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC99048A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfHPPUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:20:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38429 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so6466369qts.5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFb/hLBTJ0jfbLGZd0wratcv4Kln66kPYDBf6JRs95s=;
        b=uDCqdz2LgXc3YqK+YYMQHIobFJPXz94KAcoY4XXNEBokI1Zs1EWWOu7lO39mh/YtMH
         /LQYW60mFI9TYzjlwTqqTC6WDW95rODk9Yf2ZNFel42V+thpRJ1BPZStfki8HsBNmMrK
         YorniyoPCcfHcKAH838cDCjkyliAzxM07xW34dBLRmHXdjvOqDqe/ziO99C8/kaANk/H
         eRwJG4FTLDLxdu7DnvQif1uIPf7W5T2M85HZ4GaK/e+vsnvmbYtU+uBxZ9SXHoyo4VNY
         tTzsujwFyNNevS//PlhHbd3a8yW8blM6O4brv2To9BN5p+PqFQiwPWzXrHee5+w1guGH
         EWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFb/hLBTJ0jfbLGZd0wratcv4Kln66kPYDBf6JRs95s=;
        b=ODOaLJoCwiTrMB1kDSHoML/QsY7z2fyd/hKMJi24VZe4e2IBTdG1mGNsVFU4/LAktN
         YBst1GwOJE4LbA2aHtAF3d1mhFlu3ut95DKbUGKkm3Oec0p8H62NRk3t6RI3U0eXm+ku
         3XVfA9enSzEA+ISnkTLHoSSbn9lP08AkgppwgCwWCD0RTncD/Qj7MCaNEOFib/1ITNj3
         NriSLAjgqfkmIV36br5gVDdc46EuVft9ESAqc782ztnu6MBMYPqbp+d89ozlhOrXl2lp
         NsIRWoYTpahYgyfDPxUlHgMPFVvpmhQQXQy6lE3TrMEZJf9z//R0fzDjtglXtvmN/2l5
         EqrA==
X-Gm-Message-State: APjAAAXU30vWBfsnhcLI3ZfVeQOGiVpFjcoC7KNEp2Iu4vN7vLtrf4cE
        Fv9fa/Yx6C6+49Kg+dGr/VscikM2toKiqA==
X-Google-Smtp-Source: APXvYqxPg7XGTvl4QGAK5Y9HpY/BhhqdhzxrYl05iWzrLE4WiIbGFMSpZLPbz4rirpnMMTY0vK1+pg==
X-Received: by 2002:aed:34a6:: with SMTP id x35mr8941015qtd.187.1565968822274;
        Fri, 16 Aug 2019 08:20:22 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z18sm661330qtn.87.2019.08.16.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:20:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] Fix global reserve size and can overcommit
Date:   Fri, 16 Aug 2019 11:20:14 -0400
Message-Id: <20190816152019.1962-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We hit a pretty crappy corner case in production that resulted in boxes slowing
down to a crawl.

can_overcommit() will not allow us to overcommit if there is not enough "real"
space to satisfy the global reserve.  This is for hysterical raisins, we used to
not be able to allocate block groups a transaction commit time, so running out
of real space for the global reserve would result in an aborted transaction.

However that limitation was fixed years ago, so we no longer need to impose that
limitation on ourselves and can just overcommit with reckless abandon.

But this change exposed a bunch of corner cases in how we deal with very small
file systems.  A lot of enospc related xfstests make very tiny file systems.
Btrfs by default gives you an 8mib metadata chunk.  We default to having a
minimum global reserve size of 16mib.  This is problematic.

Before we would allocate a new metadata chunk, which actually meant we were
"passing" these tests with 24mib metadata chunks but 256kib of used metadata,
and drastically less data space than was intended.  With my change we started
failing these tests because we were no longer allocating the extra metadata
chunks.

The changes to the global reserve are to make it so we pass these xfstests, as
well as add some real hard logic to the minimum size of the global reserve,
rather than just an arbitrary 16mib.  In practice those changes won't affect
real users because real users use more than 8mib of metadata and will get full
chunks.

These patches fix the original problem I intended to fix, and also have the nice
side-effect of making a bunch of the enospc xfstests finish _much_ faster.  The
diffstat is as follows

 fs/btrfs/block-rsv.c  | 43 ++++++++++++++++++++++++++++++-------------
 fs/btrfs/space-info.c | 51 +++++++++++++++++++++++++--------------------------
 2 files changed, 55 insertions(+), 39 deletions(-)

Thanks,

Josef


