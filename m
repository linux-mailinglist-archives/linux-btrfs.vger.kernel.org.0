Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5098C4AB6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfFRUJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:32 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:44091 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:31 -0400
Received: by mail-qk1-f180.google.com with SMTP id p144so9402355qke.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=xjtd/c8AXofoD9DS7J4AQ6Tj2df/16UX9QRAB3hqfTg=;
        b=F72MBKLPodGFxnrohMhfkKzWq3NxxEWgAauB2y4K5IVmummIiBgRKGrdNZYyHNXWDW
         SW12YstcbyQKJbzbSNpZUFnGrWJ4eHnsqIqjwFnTsv+sqIaf6eQsEl6WYFJeUV7XdgRi
         FyZD83bsFjtI/iphnsR4WiQ6UmT0hPbiy0QvaS9QvTBgwp/tDZzdRL+1O6OHLvp6af5C
         y8ABq7Y5gmQF/piWyxJADRvz9//TbkIlqRT4KfJw0yAj58HnzgzY4FSVID9pawESAFI+
         kkxsBCiqW+gd6qo0ksB5fQY9jVq1RRIhGQKE6ym0u7nqDSfO4a01a+AWS0DcRjVVEKcg
         KYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xjtd/c8AXofoD9DS7J4AQ6Tj2df/16UX9QRAB3hqfTg=;
        b=ih7Q6qOSe+C8r47D0nRWRX+KMbX6UUlUMikTkRN67ZOBjjaD9riWwl4z3/cp/MW0jG
         SQZSTW9MFLqDEtkj2kMxP6oUm+Tc1s+j0JIfYTfw6mSkd6nNqAnmvuYqVnV6IttEaSZt
         mrwm469THjEB5svsoBJJxHvn4gmoMy5g2gZrSGmN6CmTYZ2JaXJj4Ct9DIOSDfa/ey23
         uYbKqyX2g54eu+Ntz7rglXdOfFVGeVLZELN7zgDDoGEaQNfUjP+n5A1TGZkD3N7QliUe
         0/UY615MH4K5wfyMvQhx7p30tOtfQ+1N9v7lHjv5RxJce2YKQ6Oyj/vzznngF4vcldER
         pJkw==
X-Gm-Message-State: APjAAAVnbMy5hPClS0Nh/E77Ge53Y3pdht2ipm/NZoHx1OarhCiiG4ET
        A/Fm87+8NTWM5eRFdeXnWcwNHOcFpjm9ig==
X-Google-Smtp-Source: APXvYqxAeABI4gnTfYe6T/wmS2XT5hwnCTt7/vD+9c8GRxMW66qCGyJeiCCzeLgxr+tLpHB+iS1KfQ==
X-Received: by 2002:a37:b3c2:: with SMTP id c185mr96605585qkf.44.1560888570271;
        Tue, 18 Jun 2019 13:09:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r186sm8178138qkb.9.2019.06.18.13.09.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: move the space_info code out of extent-tree.c
Date:   Tue, 18 Jun 2019 16:09:15 -0400
Message-Id: <20190618200926.3352-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the first pass at making extent-tree.c much smaller.  I've purposefully
done no other cleanups or changes.  The places where I needed to modify callers
were done in separate patches.  The only time I moved and changed callers in
large chunks was the moving of reserve_metadata_bytes out of extent-tree.c, and
that was just to rename the users of reserve_metadata_bytes to
btrfs_reserve_metadata_bytes.

There is 0 functional change in this series.  The next step is to move the other
space reservation code that is specific to delayed_refs, inodes, etc.  But I
wanted to start with this to make sure we're all onboard with this approach
before I do other things.

The diffstat for the whole series is the following

 fs/btrfs/Makefile           |    2 +-
 fs/btrfs/ctree.h            |   97 +---
 fs/btrfs/extent-tree.c      | 1277 +++----------------------------------------
 fs/btrfs/free-space-cache.c |    1 +
 fs/btrfs/ioctl.c            |    1 +
 fs/btrfs/space-info.c       | 1103 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h       |  135 +++++
 fs/btrfs/super.c            |    1 +
 fs/btrfs/sysfs.c            |    1 +
 fs/btrfs/volumes.c          |    1 +
 10 files changed, 1343 insertions(+), 1276 deletions(-)

Thanks,

Josef
