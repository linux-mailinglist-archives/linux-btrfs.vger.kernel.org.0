Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747A4C047D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiBVWXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:11 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08FF6A052
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:44 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g24so1862263qkl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njlbxYX0L+wdgUt1m5ZveAdm0rXbgIyt4YFncpSVbag=;
        b=IXKBrpaYVDCzE2KO7rz1LjCh4WWE9ExE67udBUO5ZwcfgWghMA/gqL0luTbKgXm13h
         cimVmZUgOJSuhqHsFuCxfX3yTE7IWJTUCY98S6bzidAU6eVphmRILYcKo9/amf1DxOhj
         HxozlqB+2HdBUG7Jw7eZE1VXmzF+oLmfCIr4r7PU2qnU8sy8HJKpNAnyCgV6NaRjfw9R
         YJv2vv58wv0MiUjMXZsEwCbvfkYS9l3N0u/iHm/FsuIckbtK8hVzH6lbQyaE/h6NIaQi
         hyPCJLtY094OdZhdv9NYY4uLAuPeWF8FrHIL1PSv3NUkBQXpqp+oRvufYCJxwSuVPvUB
         /8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njlbxYX0L+wdgUt1m5ZveAdm0rXbgIyt4YFncpSVbag=;
        b=4RM5H+5MNXq/lbyw/lRf2WXezUnKzURnWeJ3ppROUQBJkai0WrYzMR6W0b/d3yhitF
         hWn8d+V3G1OqMu+eywD650R0QjRTNnDFc8K9HCH5CGq3Mz51x0yfD7vf7iF70gEKOI3Q
         0OcRE58x3IL8EyBxnj0J14jSYRy1vrAZ+OCGxhat1u1ZlLUKHosIJdA9jWi5cFPkatkx
         CwNqCEWpV/lxHYTYu6SELDYI4rno1QyFLyp+omZkZ1uqDAE7mViC+tpf6Z977fNClS1h
         U6t4qk8uo2oW1ueGr3f9Swc3ebyZJWnu6HzK91nIjlPthU5PP6NaDS8G0X4jPxZ2Pyit
         bNOg==
X-Gm-Message-State: AOAM533A6tXoYpWFAEN4jqWJc3bHcXDLbokNEWnbUYlAZrn7RYuVijTj
        iRY/5H4693VrwTf/B3ykQP2GjjvwQSjx1Y0C
X-Google-Smtp-Source: ABdhPJwg9jWmYAnWPpoYw2ggQpTi40l1rpHT9epn5fOPzqNDfjNdp7DdNsPMAu//wnt8G/IfVTfoow==
X-Received: by 2002:ae9:ef09:0:b0:506:aadb:1f1b with SMTP id d9-20020ae9ef09000000b00506aadb1f1bmr17000958qkg.609.1645568563800;
        Tue, 22 Feb 2022 14:22:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p5sm571267qkg.76.2022.02.22.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7] btrfs-progs: various regression fixes
Date:   Tue, 22 Feb 2022 17:22:35 -0500
Message-Id: <cover.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

In trying to test my new extent tree v2 patches I noticed I had regressed a few
of these tests with my previous prep patches.  I'm not entirely sure how I
missed this before as I generally run the tests, but there are some clear things
that need fixing.  I've based these patches on the devel branch, with them in
place everything passes as it should.  Thanks,

Josef

Josef Bacik (7):
  btrfs-progs: check: fix check_global_roots_uptodate
  btrfs-progs: fuzz-tests: use --force for --init-csum-tree
  btrfs-progs: repair: bail if we find an unaligned extent
  btrfs-progs: properly populate missing trees
  btrfs-progs: don't check skip_csum_check if there's no fs_info
  btrfs-progs: do not try to load the free space tree if it's not
    enabled
  btrfs-progs: inspect-tree-stats: initialize the key properly

 check/main.c                                  | 34 +++++++++++++-
 cmds/inspect-tree-stats.c                     |  2 +-
 common/repair.c                               | 17 +++++--
 kernel-shared/disk-io.c                       | 47 ++++++++++++++++++-
 .../003-multi-check-unmounted/test.sh         |  2 +-
 5 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.26.3

