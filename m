Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971A78B0C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfHMH0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 03:26:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35553 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfHMH0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 03:26:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so588401pfd.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZolOhzSa1lUkXTmuW7coS+Lw6yX5kpeQCFv7HRgJNCw=;
        b=mo09P3nidod0mp/W5mv/HGC8YVHDTVnZuiMME4t88/NQMP4EdIu+utqrSXiTjSArFH
         Q9J9W63t/qw5WFY7ZPa+cUSLJFI3ST49EltjJkW46D7pIGFeU79x8fJcgm5JsNw6aJEu
         IssEKajjuC2Rc5BoJkO6QneYKabk8Z1/3YKrT+/9qNF5yPzF+N/+jY8ldOwhYWvf7fD9
         tfabjAMxa+MhvRR6xaN/UdNkBd6eKHYIo0rdQd1GKCdiJW701OzMpcwdX66LtiYQZp4o
         HfDNHnr8JNEA1nG5MTHkJ4mlLOIw9WJa2e3C0EOtuzbBTNeakQbVlrEeRXvDHl3ax3w3
         5xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZolOhzSa1lUkXTmuW7coS+Lw6yX5kpeQCFv7HRgJNCw=;
        b=htbW/fpGrcNR8Ew00zZFeupAjkeqJLhLL/YzgRqIPdFyqf4iyvLhPpVD0yo8Zczld8
         P7hwHDG06BnW2O3AnAQvzl3hLnGXr8R1TWMk1LXmr3v7b/bsv/3FsLpMd6uUVqaycTt4
         fGvaB9X81ILE0vtqGN8C1Q+3/8ArnC4lqQNtzWHXM8qPRu6groXmeDFvZyuA/QXLIhIz
         0or7MEbcUk7k1RGumRO8LECl75N5YUC1mPg+8OiSYx+vvIAtJKjhkyi7Cn/jiHl5nqND
         E+EVbwzrSoGNVNUh0QSGOsCO9FnWa65qyWzqyK2rpB3W+uTnwXKLGGdqD5w2XgXfMClk
         Va/g==
X-Gm-Message-State: APjAAAXZwJVDH+qi1mZPM6X3am76d2g26MjlkbEpDewl0AMKfk0ZfnHt
        m8KWV768wAWkIENEuUVgVOIBUD5RF0s=
X-Google-Smtp-Source: APXvYqw4TBU+QSwDaGr/c6z/n4bULJtDuPLaQT64PXKBc0JiavF0FkNhlV6zkxh0NgtZs8vfWeOQ9g==
X-Received: by 2002:a63:3046:: with SMTP id w67mr34164717pgw.37.1565681172134;
        Tue, 13 Aug 2019 00:26:12 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::66b8])
        by smtp.gmail.com with ESMTPSA id b14sm43528151pga.20.2019.08.13.00.26.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 00:26:11 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/2] Btrfs: workqueue cleanups
Date:   Tue, 13 Aug 2019 00:26:02 -0700
Message-Id: <cover.1565680721.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These are a couple of cleanups for Btrfs workqueues as a follow-up to
"Btrfs: fix workqueue deadlock on dependent filesystems" [1]. They are
based on misc-next + that patch.

Patch 1 removes the previous, incomplete fix for the same issue fixed by
[1]. Patch 2 is more of a nitpick, but I think it makes things clearer.

Thanks!

1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/

Omar Sandoval (2):
  Btrfs: get rid of unique workqueue helper functions
  Btrfs: get rid of pointless wtag variable in async-thread.c

 fs/btrfs/async-thread.c      | 79 ++++++++++--------------------------
 fs/btrfs/async-thread.h      | 33 +--------------
 fs/btrfs/block-group.c       |  3 +-
 fs/btrfs/delayed-inode.c     |  4 +-
 fs/btrfs/disk-io.c           | 34 +++++-----------
 fs/btrfs/inode.c             | 36 +++++-----------
 fs/btrfs/ordered-data.c      |  1 -
 fs/btrfs/qgroup.c            |  1 -
 fs/btrfs/raid56.c            |  5 +--
 fs/btrfs/reada.c             |  3 +-
 fs/btrfs/scrub.c             | 14 +++----
 fs/btrfs/volumes.c           |  3 +-
 include/trace/events/btrfs.h |  6 +--
 13 files changed, 61 insertions(+), 161 deletions(-)

-- 
2.22.0

