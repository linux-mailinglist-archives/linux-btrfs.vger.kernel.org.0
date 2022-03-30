Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B44ECDDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiC3UNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiC3UNM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 16:13:12 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA06542E;
        Wed, 30 Mar 2022 13:11:26 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 64E53804E2;
        Wed, 30 Mar 2022 16:11:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648671086; bh=n0wWn1phLt+ulqPA8UStyX7a3bb5zuBWc1xXikWnhUc=;
        h=From:To:Cc:Subject:Date:From;
        b=qzv8escIqyeYmf/blTE/TtUim9RqDN8gCUGYdfE7oD190++EzK8c3D7bFGmCSIhZN
         fX1m+JyUlb2Lz2/yWKH1/pzuulnXc9W2wsOSKAbl4posVkEEjVKjOMfjEkNnhMqg7k
         rydwolY7jdbyfDQenhTGOgpI6PPwOzXTYTzDeIJmHb4VvU4P6wumS9P66DZi26PEdO
         dYY5GPZ9jr0otmB33Cddel/LL5qKEaB+UPKXd2Gdw31SG72IgG6FrULJFNQlil5Q1U
         8QzrmrxW6H7KyDjgY6g1A5ZGJcJPFdPWuOU+vi8kS5fESgOwbZnKpJfMrsKKKJI4K1
         1FY2RBqOVxlxg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 0/2] btrfs: allocate page arrays more efficiently
Date:   Wed, 30 Mar 2022 16:11:21 -0400
Message-Id: <cover.1648669832.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In several places, btrfs allocates an array of pages, one at a time.  In
addition to duplicating code, the mm subsystem provides a helper to
allocate multiple pages at once into an array which is suited for our
usecase. In the fast path, the batching can result in better allocation
decisions and less locking. This changeset first adjusts the users to
call a common array-of-pages allocation function, then adjusts that
common function to use the batch page allocator.

v3:
 - fixed up the other style comments from kdave's v1 comments
v2:
 - moved new helper to extent_io.[ch]; fixed title format
 - https://lore.kernel.org/linux-btrfs/cover.1648658235.git.sweettea-kernel@dorminy.me/ 
v1:
 - https://lore.kernel.org/linux-btrfs/cover.1648496453.git.sweettea-kernel@dorminy.me/

Sweet Tea Dorminy (2):
  btrfs: factor out allocating an array of pages
  btrfs: allocate page arrays using bulk page allocator

 fs/btrfs/check-integrity.c |  8 ++---
 fs/btrfs/compression.c     | 39 +++++++++------------
 fs/btrfs/extent_io.c       | 71 +++++++++++++++++++++++++++++---------
 fs/btrfs/extent_io.h       |  2 ++
 fs/btrfs/inode.c           | 10 +++---
 fs/btrfs/raid56.c          | 30 +++-------------
 6 files changed, 85 insertions(+), 75 deletions(-)

-- 
2.35.1

