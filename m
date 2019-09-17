Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3DB5583
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfIQSns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:43:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37766 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfIQSns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id d2so5722722qtr.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfXQZNd5a88XnHq976IxtlJmvRQLRIMpenCWs060Rmo=;
        b=Yp1UsqC96Xlm8C8nhOKTTjPiteHCSOaKu3TKZU76tgiGJPnEzWeNkvk/jckNaaoXvg
         kHXQ+FlQcBeK/HdqsNWRzU36LkOXiJxgSOWwlnjIKwpJ84e63fijCKFUZko8BHFCbBJ2
         QXntGeQSv/RWH4NeUsyqqtGXBeqBEi7Su0PoQw5dN7ZtvMenItbuiW8ToDiofyB34RSR
         LsEG1MXc5wS/2V0E3ic0wXDovg7A0y4LVrvndK80cNHBQVk4OTQTAxFC4SEYOKf1lZzH
         BSedfqtaxacYgybYA7ht4gO6/KS4h0ohzpA8nj05h/jNnU9LKbxdTCrV42wouC6iDFEj
         rhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfXQZNd5a88XnHq976IxtlJmvRQLRIMpenCWs060Rmo=;
        b=ntyZUpRsZlR/epK4rnRYGaJnXxexbgbvW+t40H4wY1MnJ0891H/OYFfUKvT3LWzjHP
         1k8nwPAHnzhDET83MMg2wPXqI8o/5tAKBf8TXTeDRV+0R0Cj1wf7uwMRqOPwsvrDgbmv
         69LnbA7AkzPvwSczpDrFUsJPDid2id+jWauxoGXILxfWiHNW2THDLrARaU5FZe+UIEAw
         NdlsjVI8T42YabXxbnymxYGVvngps9QDvWxgSNhFNC+wj8kteXnR/ds+fBqFg4Plo14f
         lS9O73fZ3XaUEgHdem/2DivvqCP0BjO9cuvxb4JR4R4l0OX6WDJGZQVeqh7MBz1YKixX
         kkwA==
X-Gm-Message-State: APjAAAX0BX0mjUYVQLomqFhqQi3JV+LgH6Vy/oLNDFVvMUZSBfBGQmwY
        QBdmYJ7VLXxZjzUEoB0Km2SFeDPZDW7muQ==
X-Google-Smtp-Source: APXvYqwhfGWsflhtR1QMSwSHGUQO+DAIlonIXOawCl2kptygihpsXVMEHRnaQ6kPQ/ZX8QRkcSY41Q==
X-Received: by 2002:ac8:611a:: with SMTP id a26mr251847qtm.68.1568745826857;
        Tue, 17 Sep 2019 11:43:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j5sm1497160qkd.56.2019.09.17.11.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:43:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9][V2] btrfs: break up extent_io.c a little bit
Date:   Tue, 17 Sep 2019 14:43:34 -0400
Message-Id: <20190917184344.13155-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- renamed find_delalloc_range to btrfs_find_delalloc_range for now.

-- Original email --
 
Currently extent_io.c includes all of the extent-io-tree code, the extent buffer
code, the code to do IO on extent buffers and data extents, as well as a bunch
of other random stuff.  The random stuff just needs to be cleaned up, and is
probably too invasive for this point in the development cycle.  Instead I simply
tackled moving the big obvious things out into their own files.  I will follow
up with cleanups for the rest of the stuff, but those can probably wait until
the next cycle as they are going to be slightly more risky.  As usual I didn't
try to change anything, I simply moved code around.  Any time I needed to make
actual changes to functions I made a separate patch for that work, so for
example breaking up the init/exit functions for extent-io-tree.  Everything else
is purely cut and paste into new files.  The diffstat is as follows

 fs/btrfs/Makefile         |    3 +-
 fs/btrfs/ctree.h          |    3 +-
 fs/btrfs/disk-io.h        |    2 +
 fs/btrfs/extent-buffer.c  | 1266 ++++++++
 fs/btrfs/extent-buffer.h  |  152 +
 fs/btrfs/extent-io-tree.c | 1955 ++++++++++++
 fs/btrfs/extent-io-tree.h |  248 ++
 fs/btrfs/extent_io.c      | 7555 +++++++++++++--------------------------------
 fs/btrfs/extent_io.h      |  372 +--
 fs/btrfs/super.c          |   16 +-
 10 files changed, 5843 insertions(+), 5729 deletions(-)

Thanks,

Josef

