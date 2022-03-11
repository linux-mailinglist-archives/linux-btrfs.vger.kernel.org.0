Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85904D65F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350217AbiCKQWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 11:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiCKQWC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 11:22:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E21D17A3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 08:20:59 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id t18so7702744qtw.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kCYIhViP+XSeAfiACXplInyBsYNkNRkbi7wV2i5KgZc=;
        b=0Q8IEBJ1wTteiopE2BhexmMj37SdGE6TmjB5KyzrwXQSDaBB8H0Z7C1tWcahj3Mrkt
         cBZxO5fx2d3a5C4dwfmRdaya63/G5TsW9C38A8bAfGBfHqdq3SaRFXii3s/JmZ7tvWCg
         xPKxllJf+8ESqjsiRJsxfR7CHbbaca3zhIt8ybqyue6zFlFfbxzg8nPj1j7vHxMD+kHe
         OJnYfTiF78Ge5sQjK29dNKI8EpqNN9AkCA4ykeesK9S7EAI3rW6NPipPemf61bv8JaK7
         ubAkQCOo8oTuEhIxXDVkTirMqpwXWTFRHLZA3HGloyJ1qxVYBfhi3mKq4YiwUocjsD38
         NC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCYIhViP+XSeAfiACXplInyBsYNkNRkbi7wV2i5KgZc=;
        b=zXNhKwizmwH/P5FQNgyxA0rIK51/GTFduSJBFgW50UvMaIr8ytkM821/gzDcoycpB2
         E9UWPoyVghqxasu0WnK3Odav6EJBKKfEKtIJcSlW7OTyR1IbynQdI8R7B41KXB90weks
         skE+1dmqGNi5Ur3gLLvuzXC4reXyDUcUIHsIZIQvuVWmqgAwix1QOwozdRcFHQ0MVdKx
         izsH9TLoKrvf5NhMr8DCNJXtIQRvK8Fr4lePpL0/hFCuhn7Sxk7XlKLTylTEYEBbLVx4
         jnzuPj4p6CmyZ9t0pK4Ryk+eCaOvznixGisTv9Bp447X3gLmPRRYfRakhyUD1pROhg5r
         Ec+A==
X-Gm-Message-State: AOAM533F4TXCpy9PqkQewIALxJGsFhTu/fWyIAnmIlsC9Xwf4PzoCxmD
        Rf154rejSMC3Puh/lAfJ9t0dO2srZk1x3o2z
X-Google-Smtp-Source: ABdhPJyIcgkjhclg/axQKN4+9wHTipWKdIzim5UdcmgIHqm9xHwc2IB8LD/4ev+vEN7jgWVnXogdeg==
X-Received: by 2002:ac8:130c:0:b0:2dd:d52d:325 with SMTP id e12-20020ac8130c000000b002ddd52d0325mr9069325qtj.376.1647015658240;
        Fri, 11 Mar 2022 08:20:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c35-20020a05620a26a300b0067d4eed36desm2769758qkp.130.2022.03.11.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:20:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs/029: delete the cross vfsmount checks
Date:   Fri, 11 Mar 2022 11:20:54 -0500
Message-Id: <e7af5d9833d0bd1cf58a03c8fbec874a141d728a.1647015560.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1647015560.git.josef@toxicpanda.com>
References: <cover.1647015560.git.josef@toxicpanda.com>
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

We now allow cross vfsmount reflinks, remove this portion of the test
from btrfs/029.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/029     | 9 +--------
 tests/btrfs/029.out | 6 ------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 1bdbc951..26ca8938 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -5,8 +5,7 @@
 # FS QA Test No. 029
 #
 # Check if creating a sparse copy ("reflink") of a file on btrfs
-# expectedly fails when it's done between different filesystems or
-# different mount points of the same filesystem.
+# expectedly fails when it's done between different filesystems.
 #
 # For both situations, these actions are executed:
 #    - Copy a file with the reflink=auto option.
@@ -59,12 +58,6 @@ _create_reflinks()
 echo "test reflinks across different devices"
 _create_reflinks $SCRATCH_MNT/original $reflink_test_dir/copy
 
-echo "test reflinks across different mountpoints of same device"
-rm -rf $reflink_test_dir/*
-_mount $SCRATCH_DEV $reflink_test_dir
-_create_reflinks $SCRATCH_MNT/original $reflink_test_dir/copy
-$UMOUNT_PROG $reflink_test_dir
-
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/029.out b/tests/btrfs/029.out
index f1c88780..93044342 100644
--- a/tests/btrfs/029.out
+++ b/tests/btrfs/029.out
@@ -5,9 +5,3 @@ reflink=auto:
 42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/test-029/copy
 reflink=always:
 cp reflink failed
-test reflinks across different mountpoints of same device
-reflink=auto:
-42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/original
-42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/test-029/copy
-reflink=always:
-cp reflink failed
-- 
2.26.3

