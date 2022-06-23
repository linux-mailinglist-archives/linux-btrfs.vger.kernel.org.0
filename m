Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE11557E62
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiFWPBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiFWPBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 11:01:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16326577
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 08:01:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC7421F8F2;
        Thu, 23 Jun 2022 15:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655996495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1wq6kzNY23EQIMcuO5opg1KxQMu51nb2MN/zWjbBwHk=;
        b=E1TWQRr5YZnx9EzYp9hZgoNmjwx/wM8++ePt6HsX+fYIYIbAKy8CYiHTEV6e6s98l6nKru
        XiZmINjDIq3UtyMtnDR/ghg0R1YG92RECt1T1/h3Y0CAdd/C7lu8h0ZIixAxyXJzFA8ruK
        sIIXoEjtNbYQndnfFp8jRm+dLvuY1cw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C486E2C142;
        Thu, 23 Jun 2022 15:01:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95C43DA82F; Thu, 23 Jun 2022 16:56:58 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Profile mask and calculation cleanups
Date:   Thu, 23 Jun 2022 16:56:58 +0200
Message-Id: <cover.1655996117.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are still some instances of hardcoded values repeating what we
have in the raid attr table or using a similar expresion to calculate
things that can be simplified.

David Sterba (2):
  btrfs: use mask for all RAID1* profiles in btrfs_calc_avail_data_space
  btrfs: merge calculations for simple striped profiles in
    btrfs_rmap_block

 fs/btrfs/block-group.c | 5 ++---
 fs/btrfs/super.c       | 8 ++------
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.36.1

