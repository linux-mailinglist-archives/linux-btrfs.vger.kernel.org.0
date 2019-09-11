Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04769AFFEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfIKP0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40704 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfIKP0Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so13130085qkb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNb7DbbrBs4Q/sjx+irj78rxpSw/TMwuHd+gxwka/Es=;
        b=IKFSk14SH5Gv6JjXUQ3YqE4nVGzmcITl5dsrkwq1JXp9tVFi+8mUrn/aBcuuT3wyuv
         zLkQDer7yyB0fO6dJZvDB1WrTMR6ihL9sWhqrJ+DPer6XDkTQAlm90p3Xi4qKRsVvv59
         thr+n2mnd8nBfM/BddsmoWsUh0/5BbJEDUrL5M9GfswKaqtqCY5Ha9hQTZ98I+7I/+f2
         5g/T2FDqBJwW1g3uIuYAwKQZK1U7oiJRp49RzvCmp9LImWF1CI2cA3K5aMQeDlzWVE3P
         Rrvq60Hu3yRyJKX9ff5DSGvKLKoF/tcNAd8H5palwOR06AxCN2AJh4nGd6h1B84laiqM
         ovmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNb7DbbrBs4Q/sjx+irj78rxpSw/TMwuHd+gxwka/Es=;
        b=dwlIKD3wt/ZGn//BwDLLrKt/dQgijLn+ms/bhbvGsffsj256rKJPpYn+wh4XNkmcaP
         yXod1NhUZ9OMSkbEDbu2FmUTYeopfw2wXelcU15JUQrjyTJbes7Wc5W6ttMHWLeBet+I
         0sCAW6JcEtjqz6Cqa+I4S2fkLfXfjsRROBh9aBjFOu0V2YG87zhTRObubxaNSzdhnBEp
         C6cfH/U4Fu+HKuoTHaN9EDAQ10wGq2dHeueex7dporRJ2iQTxlbkXDZBhPVOUNH9vWfR
         eX1cJSorrwtyp4koE5L8JB+V4H3W6WqJT7aQLuc5ek3JUCUrcsd79Fm+cQ9uEt7MJSoY
         4oOA==
X-Gm-Message-State: APjAAAXczuODN5En74JsfOuGNNsBw2lCSpLs+fTxbg2eJuwHsxjGTGUs
        WAmmj4rcjWl2APpEvsdJLNsWYuS/TR8oeg==
X-Google-Smtp-Source: APXvYqwOCDm8uKeRsK2baHTVwHNNcV/dsdXjncFeEgI03T/Gng+dSsx/lzGzIHx1s/qIuN58T5g5tw==
X-Received: by 2002:a37:6dc7:: with SMTP id i190mr36397919qkc.12.1568215574859;
        Wed, 11 Sep 2019 08:26:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i25sm10045061qkl.99.2019.09.11.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/9] btrfs: break up extent_io.c a little bit
Date:   Wed, 11 Sep 2019 11:26:02 -0400
Message-Id: <20190911152611.3393-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

