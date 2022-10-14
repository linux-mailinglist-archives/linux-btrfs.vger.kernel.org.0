Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA76D5FEF96
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJNOCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJNOCK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 10:02:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD01D344D
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z8so3686461qtv.5
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cn4ctQDs25dy93Qu0l7omk6cgWB/17lYbUN0P+LFM+8=;
        b=Q3A0IKrXoULLJPkIspNwgta9TLdtRfL4jhZhk688Ip5QTH6jHlFVZzY1y+nuGEfjZF
         uvfoAZeamn2JQBpWG3E/1eRACqizPZX9FF7kuNDedewCzaD2VNw0RwpcNTAJUeq+ZHBI
         IISHSwu/bD6YHshF72BZOXSbRNLqGxxf74xNHZGzIPfNTmVwUKDXTzcxQlvSuxgr10TN
         9+jEUOgm2Fb7fvhIBfrrlT4nK9vH5z5QPgbvlCw3xBIzikroe2hy8UO95ZtZeVFs4cvo
         4dpre+lIE/R9CuOOcytluFRaJTLnuQd3MfwOuZ7ZFoWX37Apqv4H8RYWarG6kMeyXcTY
         hPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cn4ctQDs25dy93Qu0l7omk6cgWB/17lYbUN0P+LFM+8=;
        b=c+nroiyIHrg2gnBPVyx+eZZAcZcv2l3BFPdVNcdbyEQ6A1+KJpj1j9NYT4N0+NtG6c
         z4TM2+f0Hl9GNmaZg9JPsA9cXVfhEg7f97v81aLNdGsSbyJDdlyVcVJYItkc37QQZaS0
         IUFad+DgciCcH+X3pTfHhQ439xfI9JmN51PRZK5fYobcCmH8jEZ+RcpWB2IltBK7E3FH
         yXt8GSHQ6ORz6S3LlzGUXVB5gldPBP1Z4dnI7u9JUXg3iCfzG4zPNbcwgTO4JTdhYbGs
         /WJ6e+qZnzDGC51FLg2fLILfj44McG/3ma87osNYFZwgfGza9jlxZwUu0NM788fYyWKs
         5e1w==
X-Gm-Message-State: ACrzQf1RJ6/fAGqr5WIJy7uOYaZT/WtFE4oD26uPk9vtL13Bl6+VrJCm
        sQ9t11ntDTx/P4ICiYXW5efkYH+QhlraQA==
X-Google-Smtp-Source: AMsMyM5eQtOwTC7+UHSYjvDUB8zfp+XYgMPEytvSZjmBEttW8+ZbsPrJUsbYtk919OpIerstkFvCig==
X-Received: by 2002:ac8:7dce:0:b0:398:c5ab:6bc4 with SMTP id c14-20020ac87dce000000b00398c5ab6bc4mr4333671qte.347.1665756043841;
        Fri, 14 Oct 2022 07:00:43 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r187-20020a37a8c4000000b006d1d8fdea8asm2347379qke.85.2022.10.14.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:00:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: avoid GFP_ATOMIC allocation failures during endio
Date:   Fri, 14 Oct 2022 10:00:38 -0400
Message-Id: <cover.1665755095.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

As you can imagine we have workloads that don't behave super well sometimes, and
they'll OOM the box in a really spectacular fashion.  Sometimes these trip the
BUG_ON(!prealloc) things inside of the extent io tree code.

We've talked about switching these allocations to mempools for a while, but
that's going to require some extra work.  We can drastically reduce the
likelihood of failing these allocations by simply dropping the tree lock and
attempting to make the allocation with the original gfp_mask.

The main problem with that approach is we've been using GFP_ATOMIC in the endio
path for....reasons?  I *think* the read endio work used to happen in IRQ
context, but it hasn't for at least a decade, and in fact if we get read
failures we do our failrec allocations with GFP_NOFS, so clearly GFP_ATOMIC
isn't really required in this path.

So kill the GFP_ATOMIC allocations in the endio path, which is where we see
these panics, and then change the extent io code to simply do the loop again if
it can't allocate the prealloc extent with GFP_ATOMIC so we can make the
allocation with the callers gfp_mask.

This is perfectly safe, we'll drop the tree lock and loop around any time we
have to re-search the tree after modifying part of our range, we don't need to
hold the lock for our entire operation.

The only drawback here is that we could infinite loop if we can't make our
allocation.  This is why a mempool would be the proper solution, as we can't
fail these allocations without brining the box down, which is what we currently
do anyway.

Josef

Josef Bacik (3):
  btrfs: do not use GFP_ATOMIC in the read endio
  btrfs: remove unlock_extent_atomic
  btrfs: do not panic if we can't allocate a prealloc extent state

 fs/btrfs/extent-io-tree.c | 22 ++++++++++++++--------
 fs/btrfs/extent-io-tree.h |  7 -------
 fs/btrfs/extent_io.c      |  8 ++++----
 3 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.26.3

