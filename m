Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F04C027
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFSRr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43330 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSRr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so57040qka.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=Gp/MuR4tqTF41cujCrm0d73CWf91Zlxetcrri4jkMMA=;
        b=qXIaE+QHS+ulyy+rloI242oMrcmF0hc3g6TE2+zh0AKj9VJ3Vt5JtTyeDmejG0UDeB
         +wSpfQeXa8YoQN1xF3C/HzqXgXwsUSi1MTFovsqTEvr6b3S8VQYritLIoFg7d0psWmDo
         3Bfdi53hTGORDJSVK+1/1BjIK6zgYueTt5jMx1xzhQPG/3UuW7kDxGeR8QMft+75u4Vq
         kuPErAz7KkX1lzB8qu5KszvvN18QHfUncuI4FgsNiSwh9hc1wj5XOVxVm9Y9hqlmn67W
         VwyDvI5RlQA3gZ7GkD5F8xIUVGWChJ51oaTYrMJOia5LGqvRwaKvAEfnNHldlnZPRoIx
         hwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Gp/MuR4tqTF41cujCrm0d73CWf91Zlxetcrri4jkMMA=;
        b=ktdyUEkrd2vUVBo8Oimb6+BBMO9atqgwmhv6pK6D9vxT8e8bJg5vG/gaQm9Y0rZiTl
         8BsHkw+QXkzfN7MNZOpw9e+QQFHqBT6c6uu4xiQLq3tzp1h8bXN6wzgJLgqChKSLnkwX
         62LGGMTb4rE6j6XgjKPrELE15/1zf1zpEswXMsyHJoiUb/nY2aQuo8Df3HMktTBzquY0
         TIPOQgzXN1OU+9fqis7A0iS5tzz1zXXf8lHnJlraZ0oDUBinDvapa9w5OLyiZ9erOqf1
         Jx9yVQrpDom7APJh7nKWWjgVrdQdBctK/6ZTsjCd+h5KjrnBqZHed7yBCC5/01oOlh/a
         H1sA==
X-Gm-Message-State: APjAAAUVYH6MTdid6KDS65VWZMwvGsa5sjOiW/vN4h74APbuGJ0trgje
        PHWjuARWABbJGOp2nP7N7vScEOXhntCDEw==
X-Google-Smtp-Source: APXvYqxpFr70tunArh3XwFX2Lk5dJhlJB/z1lHn/NonKUJhSJhzTVCkP2Npq2fYtASBB5xySiv7dew==
X-Received: by 2002:a05:620a:152:: with SMTP id e18mr99240766qkn.101.1560966447483;
        Wed, 19 Jun 2019 10:47:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s44sm13672283qtc.8.2019.06.19.10.47.26
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: move the block_rsv code out of extent-tree.c
Date:   Wed, 19 Jun 2019 13:47:16 -0400
Message-Id: <20190619174724.1675-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset depends on the space_info migration patchset.  This is the next
logical chunk of things to move out of extent-tree.c  With these sets of patches
we're down below 10k loc in extent-tree.c.  This chunk was much easier to move
as we had exported a lot of these functions already.  There is 1 code change
patch in here and that's to cleanup the logic in __btrfs_block_rsv_release so it
could be used more globally by everybody.  The rest is just exporting and
migrating code around.  Again I specifically didn't clean anything else up, I'm
just trying to re-organize everything.  The diffstat of the series is as follows

 fs/btrfs/Makefile      |   3 +-
 fs/btrfs/block-rsv.c   | 429 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-rsv.h   | 104 ++++++++++++
 fs/btrfs/ctree.h       |  70 +-------
 fs/btrfs/extent-tree.c | 452 ++-----------------------------------------------
 5 files changed, 549 insertions(+), 509 deletions(-)

Thanks,

Josef
