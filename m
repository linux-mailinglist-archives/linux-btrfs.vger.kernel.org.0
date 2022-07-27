Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80915822EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiG0JRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiG0JRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 05:17:46 -0400
Received: from sender4-pp-o93.zoho.com (sender4-pp-o93.zoho.com [136.143.188.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739D3B95B;
        Wed, 27 Jul 2022 02:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658913454; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jvtsXujE1niNFpJmnKma3mexAyKwPimFZXpVFIVSmsfDiOhsm8A7TD5QYYgNr/YrJZd1qdJhzNwyGs2Emmj7DlQGtpRb+9kUEBwUPIqetEgiIayK1rVlSF7CWMBw9cyibAe76nMP3Gewzw+ABM3nf1XU9NW4Ix8XFqXldc2rV2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658913454; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tbBLibR6scgO9qEy5TFmX57B29Vru5orCKKuf3M47YM=; 
        b=lo5Z7a8FvTU6AflmKqCNI2YWDwUK8VAjiCH2USoa2kzjDJB4HGTcVaKXXiayh78GPrRVypJT19wdKa1Ug7Y5GVFgKQiBfiE3wrzz/MepQ+BNq+xnzsr/q2H0bWk+DphQjFLIks/cVAuet9K0OIPupHKwYRgoDqt3rwJIOBdmABk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version; 
  b=fL0WfHL8yINXRurDjRoeO6YIXlhhtk18YeT5GSN4LkdLivlfdR8S0nqzLsQcc1lLJVQ5jk4q4xgX
    XX7TqrwanG/+j/ZwANEMJVSQ0F2P58NXY1BBG/13iP4+fmbTeHig  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658913454;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=tbBLibR6scgO9qEy5TFmX57B29Vru5orCKKuf3M47YM=;
        b=FjNjkRgfi4H2Uhr/qLddGWBe5DjkQycgj89wXafu/sV/dLfBN1KQ4huZou4hZKcY
        ZdlPcdGPAmsmUC9qmDqP5zoUs1kwcfHTskBmNYtUindzjBwJ67eu3sXgKyHpSLHpWzk
        jt4evuDxIXvQfSc5qreYmhquB5IjMwt9eEO90LGU=
Received: from localhost.localdomain (58.247.201.117 [58.247.201.117]) by mx.zohomail.com
        with SMTPS id 1658913450622251.66284437874526; Wed, 27 Jul 2022 02:17:30 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     dsterba@suse.cz, nborisov@suse.com, josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs/219: fix problems with mount old generation
Date:   Wed, 27 Jul 2022 17:16:57 +0800
Message-Id: <20220727091657.4998-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
References: <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay & David,

As we discussed, I changed the test btrfs/219 to make it pass.

This test try to mount btrfs filesystem with old generation.

Devices are matched by UUID in btrfs filesystem. The mount of btrfs with
old generation should be failed on purpose.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 tests/btrfs/219     | 3 +--
 tests/btrfs/219.out | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 528175b8..5152fa91 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -73,8 +73,7 @@ _mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
 $UMOUNT_PROG $loop_mnt
 
 _mount -o loop $fs_img2 $loop_mnt > /dev/null 2>&1 || \
-	_fail "We couldn't mount the old generation"
-$UMOUNT_PROG $loop_mnt
+	echo "We couldn't mount the old generation"
 
 _mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
index 162074d3..6fe85f24 100644
--- a/tests/btrfs/219.out
+++ b/tests/btrfs/219.out
@@ -1,2 +1,3 @@
 QA output created by 219
+We couldn't mount the old generation
 Silence is golden
-- 
2.37.0

Thanks
