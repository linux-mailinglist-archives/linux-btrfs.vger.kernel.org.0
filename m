Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3615F871
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgBNVLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:11:51 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:40177 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbgBNVLv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:11:51 -0500
Received: by mail-qt1-f174.google.com with SMTP id v25so7918511qto.7
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B24HfK+o9CTNCzVYw3SyD8kq0cXDzCk4jSUqcYFoC9M=;
        b=KcA5k+IediA9V8a4/V4Iczn7zm3kdAhA3kkgK/lm40Mzr0lOqANHQJKf4coba8qNhT
         gmXzYnGcp4cxj2152BCU96uH+pyJgPWBl3dz04T/f3pjwwwbU7u4SnRPabLAl88e75iG
         8w2yMzrB5gjhN0bNJZjBlqY7pL2xtmFYBeiETh6IPYV//eLw5XpE39cFwqkj9yFISo7G
         A5y4qYQ9rnuafgn5Hts7qBZjKihwea92z0k68Ax9PdvnZ3F22q2eAN0CMyA0q040sbje
         1ppjtm2qGg/rmc6rPfIL9sLOUILEHvKUF6y1oO/BalEcbBr2M7HXtdh5T/V2/VxoQZn5
         Ieqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B24HfK+o9CTNCzVYw3SyD8kq0cXDzCk4jSUqcYFoC9M=;
        b=JSnyL/Ns9CSWlZs8qsZuFQ+LTyUwS8TZ7T2FEjRRSXsZOI973H9DAuuPOHGp5KNY7D
         gifULLop0WEjmYo0VSX7XtM7pNOj6xQiGXnRw4YzFw3AknIZX5Td7goCZ4MgKsW4ISgy
         gq1ZvwnCMBXyX3lorYA/UxH5vyu1psHEwBEp2ZPP1uyRL7QRVawq/yWDCUgnG0AQz8R1
         rcZiQ+7vtFvr8Ge4PCFoP34agyvY6KHWrm/VCs322byKizSPd+pB5LyrWGu7EEFnUa2p
         nJp1xPe43QjNSjphbwswaymPtrwqOQ/SVzbpEtfb8XgXX3ha9+VCmPPTqLfpeGSI/COq
         7n2Q==
X-Gm-Message-State: APjAAAW6chVL9EJKbiB0UBi5XlehOZ2r5f14nBufHtjegiSVWsh3GGnf
        wDB6gJT327DOb5j1em2rcDBbjbOUeb0=
X-Google-Smtp-Source: APXvYqyF6M/PTsIO3eE836SOrabv9ZSOyTcGYxJRyW7FqNpRxpJsqEWvnO7ygqSrUdDDO/fo0as/KQ==
X-Received: by 2002:aed:3ee5:: with SMTP id o34mr4235806qtf.164.1581714709884;
        Fri, 14 Feb 2020 13:11:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h20sm4092658qkk.64.2020.02.14.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:11:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8][v4] Cleanup how we handle root refs, part 2
Date:   Fri, 14 Feb 2020 16:11:39 -0500
Message-Id: <20200214211147.24610-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- Rebased onto the latest misc-next, there were some subtle conflicts and
  weirdness with the automatic merge, so resending.

v2->v3:
- Rebased onto the latest misc-next, so the snapshot aware defrag related
  patches got dropped.

v1->v2:
- Fixed a error missed put in an error condition in relink_extent_backref
- Added "btrfs: make the init of static elements in fs_info" so that we could
  clean up fs_info init and make the leak detectors work for the self tests.

-- original email --
In testing with the recent fsstress I stumbled upon a deadlock in how we deal
with disappearing subvolumes.  We sort of half-ass a srcu lock to protect us,
but it's used inconsistently so doesn't really provide us with actual
protection, mostly it just makes us feel good.

In order to do away with this srcu thing we need to have proper ref counting for
our roots.  We currently refcount them, but only to handle the actual kfree, it
doesn't really control the lifetime of the root.  And again, this is not done in
any sort of consistent manner so it doesn't actually protect us.

This is the first set of patches, and yes I realize there are a lot of them.
Most of them are just "hold a ref on the root" in all of the call sites that
called btrfs_read_fs_root*() variations.  Now that we're going to actually hold
references to roots we need to make sure we put the reference when we're done
with them, so these patches go through each callsite and make sure we drop the
references appropriately.

Then there's a variety of cleanups and consolidations to make things clearer and
make it so we only have 1 place to get roots.

Finally there's the root leak detection patch.  I used this with a bunch of
testing to make sure I was never leaking roots with these patches.  I've been
testing these for several weeks cleaning up all the corners, so they should be
in relatively good shape.  Most of the patches are small so straightforward to
review.

This is just part 1, this is the prep work we need to make the root lifetime a
little saner, and will allow us to drop the subvol srcu, as well as the inode
rbtree.  It doesn't really fundamentally change how roots are handled other than
making the refcounting actually protect us from freeing the root while we're
using it.  That work will come later.  Thanks,

Josef


