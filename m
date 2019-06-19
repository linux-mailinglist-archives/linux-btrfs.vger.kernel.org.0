Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812E74C146
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSTMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 15:12:05 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:42392 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSTMF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 15:12:05 -0400
Received: by mail-qt1-f170.google.com with SMTP id s15so321214qtk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=U8nfu6q2evIReZ3FbowVbnn4Frm07rtpKxcf3V5gLF8=;
        b=oiOkOWVGEt4Dpsd8/NWh0vWpY2/b8uHlL3K2LuNqq0Sc4Kh5bd6sXyVq05rwrTozRr
         EWZD7JmOzvUfMJdH3/1elsXU3jo9bMGvmTez6DMIldTtF1caXfWYOVpJN4+aCS4X3W/Q
         +yQLKjfAyllmdbCYqj6BgUzDsTW6WgcJnC4ht6EJ6vzV3CB+rhcN93HSe0xnZCAtpLDU
         QuhePI2ltRp6CqcAhU56Ydf97d0UPursv7Q3eyqyA2zBXcuX+itkDQbBZPNENiykgzNe
         TnxIWjV6TMLVVszDs2iH5AbXtPEToRPgTK42gI/qKunkHzKrd26pNLkPHtQm2HblB6rW
         4SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=U8nfu6q2evIReZ3FbowVbnn4Frm07rtpKxcf3V5gLF8=;
        b=m1dWiNIif4yALftUn46xe2piSCDUxKEADlR25wJqk8xk1UnGFLqdBNzae9ONANNWjO
         AMzrwdoJkOwaXajvvEPWjJAKa0rGcdHel6BeXapzCDdawweARbMNIn9lGTUrqALeM8wn
         2Exg39EfEs7StTwfeg+OqN5i3SMArB5qPLdC66Zi356xi3/2J0SfO36l5teKiIRt7xKc
         MO+T11rnhzLtmekguIN8uZL+Eh5UxQftB80DHIIYtAz1hwdRC4NpddUwv8LgxbeIb3Gv
         yQk3GAtueXvYuvAgaIMBe46rSTGf903VVxAWR/z7Ypg7Vz66J5pR82bTZLEYXOEleL5L
         XzVg==
X-Gm-Message-State: APjAAAWXG+C05H4VT/L1dKMRv6g7CI8QqMGQH7NZggWflm2v+PwIYbYf
        lj2NwOdX+XmSCPggVhZneYCvGxlAPwROKg==
X-Google-Smtp-Source: APXvYqwWFk6yk3i5ZaSaKnzqQlPOUsyE5g0ynTUnwBdxbm7RiBj/LYMDrJhMHOjOfv927uc8mdEgYA==
X-Received: by 2002:a0c:89b2:: with SMTP id 47mr35321664qvr.203.1560971523767;
        Wed, 19 Jun 2019 12:12:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q29sm11527986qkq.77.2019.06.19.12.12.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:12:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: move random block rsv code around
Date:   Wed, 19 Jun 2019 15:11:57 -0400
Message-Id: <20190619191201.16689-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have some specialized block rsvs, like the inode rsv and the delayed refs
rsv, that have their own special oddities.  These don't fit in extent-tree.c, so
migrate them to different places.  Most of them go to existing files, but the
delalloc stuff gets its own file because it's a lot of code, and inode.c and
file.c are relatively large already.

This depends on the previous two chunks of migrations.  These are relatively
small and straightforward since all of the functions were exported already as
they are used throughout the entire codebase.  The diffstat is as follows

 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/ctree.h            |  24 --
 fs/btrfs/delalloc-space.c   | 497 ++++++++++++++++++++++++++++++
 fs/btrfs/delalloc-space.h   |  25 ++
 fs/btrfs/delayed-ref.c      | 177 +++++++++++
 fs/btrfs/delayed-ref.h      |  10 +
 fs/btrfs/extent-tree.c      | 733 +-------------------------------------------
 fs/btrfs/file.c             |   1 +
 fs/btrfs/free-space-cache.c |   1 +
 fs/btrfs/inode-map.c        |   1 +
 fs/btrfs/inode.c            |   1 +
 fs/btrfs/ioctl.c            |   1 +
 fs/btrfs/ordered-data.c     |   1 +
 fs/btrfs/relocation.c       |   1 +
 fs/btrfs/root-tree.c        |  56 ++++
 fs/btrfs/transaction.c      |  18 ++
 fs/btrfs/transaction.h      |   1 +
 17 files changed, 793 insertions(+), 757 deletions(-)

Thanks,

Josef
