Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30325EEB15
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 03:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiI2Bpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 21:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiI2Bpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 21:45:49 -0400
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 18:45:48 PDT
Received: from sender4-pp-o98.zoho.com (sender4-pp-o98.zoho.com [136.143.188.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E767C8416;
        Wed, 28 Sep 2022 18:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664415941; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FvaLE4nGk8D4go257QiGS523zlp8+oqh2oo5A7UkP8LYAWVxmSdkdF+OpZLjN6V4hjRKRqhqrJVAEk8SUUK3KpGjycJPt4DC2vABykXVF0duRQN5VUjRY8ozqMXqXZ+sVhWUzvO3Who/eTfUTbmNYInwNWOnMuKN5NjLMghOg7I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664415941; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=w65lv5IW2MbTBlo+u0sGaPp2dO9vOUwB+fVpwpX60lU=; 
        b=KOkOLsgpcrX545yNLvXHJ/rP9aEQzHak7Lc1CdrtcShI9obGfpebzckmqlQWfdWB9LTU+EcqgHKEBYr9ifK2tq3KT46+u4emu3aKFLq095OFr/CspY9Fj4M+aMTJ4WoKF9oyp9D2foLtq6GM2JX1T7gMsV8o+CArVP7xf3Iatdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=vkrHvLykmZw/Hdkq5wrHIACHu37hBMm8/6gu5BQBOyP8fXGcBXZZ6htntBR0a6OZySE49gVSX4ZY
    W84HqudfSXwuz3YOKTeea/a+SyrbKs3PRETMGa1hnIDV2/RiELsP  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664415941;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=w65lv5IW2MbTBlo+u0sGaPp2dO9vOUwB+fVpwpX60lU=;
        b=DoI2EXhddcrhyTvKXry8+bx7cn+aPVY0xQ6YGl4VmuSiCvtn251NXao9A7fUXJvA
        w8fW0nyuACIG9wlsNrYEUQRhp91eNPLa4HshcEMaUdiXSAwu/A3LSqOEHuONsTxqh7N
        BKHXitEvX1vf2mokdHKP3p4RvweKOnQmOfcQjhEo=
Received: from localhost.localdomain (58.247.201.74 [58.247.201.74]) by mx.zohomail.com
        with SMTPS id 1664415939708176.12767775060115; Wed, 28 Sep 2022 18:45:39 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     wqu@suse.com
Cc:     hmsjwzb@zoho.com, stringbox8@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs:remove redundant index_rbio_pages in raid56_rmw_stripe
Date:   Thu, 29 Sep 2022 09:44:01 +0800
Message-Id: <20220929014402.2450-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
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

  The index_rbio_pages in raid56_rmw_stripe is redundant.
  It is invoked in finish_rmw anyway.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 fs/btrfs/raid56.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f6395e8288d69..44266b2c5b86e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1546,8 +1546,6 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	if (ret)
 		goto cleanup;
 
-	index_rbio_pages(rbio);
-
 	atomic_set(&rbio->error, 0);
 	/* Build a list of bios to read all the missing data sectors. */
 	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
-- 
2.37.0

