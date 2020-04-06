Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A719F861
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgDFO7K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 10:59:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38579 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgDFO7J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 10:59:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so13054063qtq.5
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ju0l/EkcWQi8E+ss5Xp9KfO3EILaY8HVWVSfugS0jDg=;
        b=lMXjtTErfi65FYr8blNUH5rIvDc+/2W2xk/ypm7xZxWa1IQRn1rLGcuapS1Ark/9lt
         yJ8H+fseFJHWBjE1pZmI7VICN16cTetFwano3eEtxNcvW6v9PteAssKn30i80a219WhG
         B0XhVGF2EemG+0FWlUIByUJNgkZLicWm2HxClzFle43zhMGqBHmu44nKXy3gpfMqXg0F
         QQFmTr7Ri2MKWdEX/TRyEohkhID5uLktdfQoduysygYXdGPh7o2WybW1O9Q7Vh1rAvcO
         rwa/8Ijauyr0XuXO2bBbeLiTBnuFcJvwP+ijY8Em/scyNv9El2ahdGiwiJ4SqPvT4rbk
         HswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ju0l/EkcWQi8E+ss5Xp9KfO3EILaY8HVWVSfugS0jDg=;
        b=NljtQo8soDyWuRXErrwcDg9X6QF0G4KCmlewBe2+nqiv3IiAv6RlzW9PvN85HUZn2g
         G9f1/B/nrYDYUCPGMJraomTMxBQ3oVeNShYwUkhe44wmPGgxKQ+M8mD4s0G9ge05Jr0R
         m/tZ/Gq4slN26F9+PbSL12Kj0C47kgZb73PHTnlfpr+cwa/+VIHON7GGwh6EN4ZuLBOD
         dwddI+StlkM6Oi5NZ1MCjsU6Ff9HrsDAddq/C68PCCRJEAet5E42aO/Qsxi9dWpKpKJV
         HUvmyhWjz0MPhp1sSU4f6UbHK0XRPIbjtnKCaA3heLSK7DTDlFzpy+S8RGvB78e+kY7x
         9wfw==
X-Gm-Message-State: AGi0PuYmT9Tg0WOdGaADodW/njt8j4HjU2IGjCi21lAWP71gVHIJvJ6T
        AYizJaxqStyHVFRR1Qmo17r2fxfkE6lihw==
X-Google-Smtp-Source: APiQypKOsmLGp/4I1KQK4wr1gqf3HHbEpKcJcbYuCgi+k1UgN8MoTJRoJht8UTHQf0jfv4mFTlEVqA==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr10928104qtr.265.1586185147153;
        Mon, 06 Apr 2020 07:59:07 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f14sm14383618qtp.55.2020.04.06.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:59:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix improper generation setting in parent node
Date:   Mon,  6 Apr 2020 10:59:05 -0400
Message-Id: <20200406145905.112078-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the delayed ref throttling patches I started getting a lot of
"parent transid mismatch" messages when running my snapshot+balance
torture test.  This turned out to be because we will unconditionally set
the generation of a relocated tree block to the current transaction.

This is generally true, but especially for mid-tree nodes we could have
cow'ed the block in a previous transaction, and only actually update
it's parents in a completely different transaction.  Thus we end up with
a parent transid that is in the future of the actual block.  Fix this by
using the generation for the extent buffer we're pointing to.

Fixes: 5d4f98a28c7d ("Btrfs: Mixed back reference  (FORWARD ROLLING FORMAT CHANGE)")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3ca98d7e4896..d4734337127a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2303,7 +2303,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_set_node_blockptr(upper->eb, slot,
 						node->eb->start);
 			btrfs_set_node_ptr_generation(upper->eb, slot,
-						      trans->transid);
+					btrfs_header_generation(eb));
 			btrfs_mark_buffer_dirty(upper->eb);
 
 			btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
-- 
2.24.1

