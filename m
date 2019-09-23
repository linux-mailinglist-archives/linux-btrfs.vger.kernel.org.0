Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753B8BB62D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfIWOF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:05:29 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:40019 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729899AbfIWOF3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:29 -0400
Received: by mail-qt1-f169.google.com with SMTP id x5so17259550qtr.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfXQZNd5a88XnHq976IxtlJmvRQLRIMpenCWs060Rmo=;
        b=mR12qYBpbW8AaaAnqdn1ltVg5BsNV0o8ffNfTewK2eZPvFwyTm/Oqwtqg9Hawr4Oz/
         YZXPko6Oup/2kGNBuhE5zMFyigdfSS+9VO8AmCk+orzt+WhTfJiIKGT9EQMR8Fv5vgAl
         SezZyoLxVj7re8Vz/x82TCv8sjWUgm6zoKC7r4Ed8J94LXPWHz8uXPnd0kG3p07g70Ag
         81wFgar00XWQ/bpTkWRddQ3k8GHfkXLa6X8CLxB7SFSH+7mLAt7dsROjnFSku2AJuJHh
         u6uyEyYO3OXPbOUoxPrcs5u1zS6RrzNRiQJ4YW9oEDhMmBJms5jarxNGVZ3eQbGx8eL0
         SYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfXQZNd5a88XnHq976IxtlJmvRQLRIMpenCWs060Rmo=;
        b=heR9KHdT6eqyz/tZMXDJ7IJM/xE/4jHbuIoxEn2V1B7mxauYlIMMX1lz61KnhSmNWn
         YEb1S/IYCIbhgeVKJGPmk4LNxdFUjkk5l1L64TeTNPwZOXdjwuNxit3SjmNaym1XJwXW
         nJS0JQIj0clNiIw9skiFWkNnQ9nEMG5q/A7b7wZ7Py38H+cGMiIqZ6v+Rmqaanw3Qj8y
         8WoO9k/jHh+5N6ycSnRiGxI45SjpJ+befFEuLbhcFfVEFmADwH9yKet8mK/NAmZkxJgA
         ugXqVmr15nHsZsT2XJptd/qXZWSqO1R1ShqEO2OvpsSMMr+aHWRyGGROuSPClk9pAQ+X
         QMUA==
X-Gm-Message-State: APjAAAVzXy1UN7Jl21N3WNPG1rJIBdysjEP7PmrNqESj2rZWyuCuwfkF
        dKAiXgOqH8uD/9bS6RRRGjVVmNak5bbMHA==
X-Google-Smtp-Source: APXvYqwDvWQC1O+OQ/dYc7nbNACnfaua5GhXTgtVYt/MoKqT7V4VeZZNEX4t24snQMDSJvFh3PMDnw==
X-Received: by 2002:ac8:68c:: with SMTP id f12mr70306qth.252.1569247528042;
        Mon, 23 Sep 2019 07:05:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p53sm5995668qtk.23.2019.09.23.07.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:05:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9][V3] btrfs: break up extent_io.c a little bit
Date:   Mon, 23 Sep 2019 10:05:16 -0400
Message-Id: <20190923140525.14246-1-josef@toxicpanda.com>
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

