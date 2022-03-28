Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5A4EA131
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbiC1UQO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 16:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbiC1UQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 16:16:14 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C32655F;
        Mon, 28 Mar 2022 13:14:32 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1462A8067F;
        Mon, 28 Mar 2022 16:14:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648498472; bh=jvZ/M7nXu49knBA535WeV4u87bF3SfI+fTlPPOny4pI=;
        h=From:To:Cc:Subject:Date:From;
        b=PqYq9MWBNlPs93L+A4jUn+SiiOX4D83w0+tWZ2fcTHrtCw0XhaNedfsvgbupUIfQ9
         5svJX0hzOXFvrsWi2iRRFjfjVHwjk7t9hlyrq7C+B3h9l+9TAcPV5JJB4jn3NzusX4
         8QnGu+YLZJCizIzyLZ69j/6mApybDkXnvAqLqs6N14zZUGWAlCFlsFgcul/EiGWZ5x
         4loEbY2at99WbZr+OBIpgZyOMPpOmj2nQdnUnddXjCHqtn7Owh2hF1sdZqdepJx0tZ
         bxO7iFo5kv1tp1lafOE5/a61wwV7hXBET1jqx2zU8QSBM2Xk4px7VYA7nm26Zx2cdX
         j7hHojMzbTqlA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 0/2] btrfs: Allocate page arrays more efficiently.
Date:   Mon, 28 Mar 2022 16:14:26 -0400
Message-Id: <cover.1648496453.git.sweettea-kernel@dorminy.me>
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

Sweet Tea Dorminy (2):
  btrfs: Factor out allocating an array of pages.
  btrfs: Allocate page arrays using bulk page allocator.

 fs/btrfs/check-integrity.c |  8 +++-----
 fs/btrfs/compression.c     | 37 +++++++++++++++--------------------
 fs/btrfs/ctree.c           | 32 ++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h           |  2 ++
 fs/btrfs/extent_io.c       | 40 +++++++++++++++++++++++---------------
 fs/btrfs/inode.c           | 10 ++++------
 fs/btrfs/raid56.c          | 30 ++++------------------------
 7 files changed, 85 insertions(+), 74 deletions(-)

-- 
2.35.1

