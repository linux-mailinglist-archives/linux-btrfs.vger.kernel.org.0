Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335A6240A9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHJPms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgHJPmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:42:47 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F9C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:47 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so4435108qvw.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDniItYYkXQYgsiBsBS0xnv17LN0VPB+k0fVpmgZhg0=;
        b=UDCaoOvFNIlbt5vTOJqZSOa9Yg+NDumu2lXMoArX+MksXPOsKXcI39Ni2R36X3HWjE
         RRRoYHAupOQSEbyjEstPSGff3feV2iyMmzuo46YJwqueG2KoDcMRAEAT+7nBanSfaU1X
         64lsEjRiglny9/Cz++6Vw/NVl81E8Nc/5KU04gcfzSz3JBWoyLmXziS3ANXcKifBi7so
         lPaAtoLHktVRGLb6zrWv52vVbsYcCD3UKJT1EWYQUXlHzFkcR0lfr84+A4hrS/k7aRv7
         98PaGmIeIYKbJzX4uaoncOmhAgB570xSJGioihbS/ufdaujfO7yuzdScSn+eCL4w3vNh
         Tr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDniItYYkXQYgsiBsBS0xnv17LN0VPB+k0fVpmgZhg0=;
        b=EyfQFIQIK6C9OG4Wy/MfIqcJ58/uBen6QTO6sqZtlK4YHFTkh+UCU1GMTFQpfdPvc/
         RCvjLcCpepN1NDpQzvNe67CiVCwFTGwS2jla4FUuY1Ue1sH3IB/tDwJS7idgK4GmDy1P
         P8yjLjddEDgU0tA5kWX+sTwtVrdPUtTOebzIT762J+rYXnLmXNa8072GxA8oJuomttV1
         8EG2pe0X/nq4jxmNDLmW0W+qHSySDrcVh0eMf1ODqswQhgp8JXMQnBglvppa7yKckqjD
         qjUfUw+ySkf8WCY441lzAr8EgmJOltCEKYBT0hMgTOF277u6BoG7ztJxJyHd87xDWjtl
         7CLA==
X-Gm-Message-State: AOAM531L1kHgm2rLYua1QNO+4d9xfeZ1UFX2Hyzg3h6tpJnQgti6A1sC
        xLAbPEe0OrEiemuiK94KZt43LOzUqbfF9A==
X-Google-Smtp-Source: ABdhPJyv4F28tepQwxfEi80iReow2t0r6c6WX5iACdIDtDYEgyp8nWUIcSaGSxVZvY3/hmpP+vRwGA==
X-Received: by 2002:ad4:44e5:: with SMTP id p5mr28599443qvt.197.1597074165319;
        Mon, 10 Aug 2020 08:42:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c5sm15992973qtp.62.2020.08.10.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:42:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/17] Convert to an rwsem for our tree locking
Date:   Mon, 10 Aug 2020 11:42:25 -0400
Message-Id: <20200810154242.782802-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

tl;dr:
- Cleaner code.
- dbench 200 3x as fast.
- fio with < nr_cpus is 10% slower.
- fio with 2 * nr_cpus is 10% faster.
- fs_mark is the same ish (results have a 10% variance between runs).

When Chris originally wrote the locking code for Btrfs the performance of rwsem
was atroctios compared to his locking scheme.  In btrfs we can usually spin on
most accesses, because generally we won't need to block.  If we do need to block
we can simply flip over to a blocking lock.  This flexibility has meant that our
locking scheme generally outperforms any of the standard locking.  We also have
a unique usecase where in a specific case (the space cache) we need to be able
to recurse a tree lock.  It is safe to do this because we're just reading, and
we would currently be holding a write lock, but this is not something that the
generic locking infrastructure provides.

There are a few downsides

1) The code is complicated.  This generally isn't an issue because we don't
really have to touch the code that often.

2) We lose lockdep help.  As you can see the first 4 patches in this series are
fixing deadlocks that exist that were caught by having lockdep properly working
with our tree locking.

3) We actually perform really poorly in the highly contended case.  Because we
don't really do anything proper locks do like dealing with writer/read
starvation, we have a series of waitqueues that mass get woken up when we unlock
blocking.  This means our context switch counts can be stupid high, as we'll
wake everybody up, and whoever wins the race gets the lock.  Implementing proper
exclusive waitqueues is a possiblity, but would further complicate the code, and
likely introduce problems we'd spend the next 6 months figuring out.

It's #3 that actually brought me to this patch series, as changing to an rwsem
significantly improved a usecase I was investigating.  However the rwsem isn't
without drawbacks.  Namely that in less highly contended cases we can be slower
than baseline, around 9-10% on my test box.  However in the very highly
contended cases (> nr_cpus) we are the same, if not better.

Filipe and I have discussed this a bit over the last few days, we're both on the
fence about it currently.  On one hand we could likely make up the lost
performance in other areas, and there's certainly things that could be
investigated to see why exactly we're slower with the rwsem and maybe figure out
a way to fix those.  We also gain a lot with this new code.  But 9-10% isn't
nothing, so it needs to be taken into consideration.

The following is the set of benchmarks that I've run on my 80 CPU, 256 GIB of
ram, 2 TIB NVME drive machine.  If there's anything else people would like to
see I can easily do A/B testing to see.

fio was N threads with 1gib files, 64kib blocksize with a fsync after every
write.  The fs_mark was just create empty files with 16 threads.

			PATCHED		UNPATCHED	% DIFF
dbench 200		699.011 Mb/s	213.568 Mb/s	+227%
fs_mark			223 seconds	197 seconds	-11.65%
fio 64 threads		562 Mb/s	624 Mb/s	-9.9%
fio 100 threads		566 Mb/s	566 Mb/s	0.0%
fio 160 threads		593 Mb/s	576 Mb/s	+2.95%

Another thing not shown by the raw numbers is the number of context switches.
Because of the nature of our locking we wake up everything constantly, so our
context switch counts for the fio jobs are consistently 2-3x with the old scheme
vs the rwsem.  This is why my particular workload performed so poorly, the
context switching was actually quite painful for that workload.

The diffstat is as follows

 fs/btrfs/backref.c            |  13 +-
 fs/btrfs/ctree.c              | 168 ++++++---------
 fs/btrfs/ctree.h              |  10 +-
 fs/btrfs/delayed-inode.c      |  11 -
 fs/btrfs/dir-item.c           |   1 -
 fs/btrfs/disk-io.c            |  13 +-
 fs/btrfs/export.c             |   1 -
 fs/btrfs/extent-tree.c        |  41 ++--
 fs/btrfs/extent_io.c          |  24 +--
 fs/btrfs/extent_io.h          |  27 +--
 fs/btrfs/file-item.c          |   4 -
 fs/btrfs/file.c               |   3 +-
 fs/btrfs/free-space-tree.c    |   2 -
 fs/btrfs/inode-item.c         |   6 -
 fs/btrfs/inode.c              |  13 +-
 fs/btrfs/ioctl.c              |  31 ++-
 fs/btrfs/locking.c            | 469 +++++++-----------------------------------
 fs/btrfs/locking.h            |  80 ++++++-
 fs/btrfs/print-tree.c         |  11 +-
 fs/btrfs/qgroup.c             |  11 +-
 fs/btrfs/ref-verify.c         |   6 +-
 fs/btrfs/reflink.c            |   3 -
 fs/btrfs/relocation.c         |  15 +-
 fs/btrfs/scrub.c              | 122 ++++++-----
 fs/btrfs/super.c              |   2 -
 fs/btrfs/tests/qgroup-tests.c |   4 -
 fs/btrfs/transaction.c        |   7 +-
 fs/btrfs/tree-defrag.c        |   1 -
 fs/btrfs/tree-log.c           |   3 -
 fs/btrfs/volumes.c            |   8 +-
 30 files changed, 357 insertions(+), 753 deletions(-)

Thanks,

Josef


