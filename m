Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40EA5EEB0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Sep 2022 03:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiI2BjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 21:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2BjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 21:39:22 -0400
Received: from sender4-pp-o98.zoho.com (sender4-pp-o98.zoho.com [136.143.188.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4711E0C1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 18:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664415554; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=e6lQRBbZKw02xaH7iR7rJvgkrfaLzCOpGZJIQzKF6rQ4upXX1pGU41Kf6FcV5BNj5XZAy7v0KbxeSXzqJpvTwvUSHHxWX0lPJ+6OeD0M7JScn1ZzUfGAAsqf24SCdHSe+6eDosXg8nxniK7ALGRZDveDXNoiLePUfoLZx1jC7vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664415554; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=w65lv5IW2MbTBlo+u0sGaPp2dO9vOUwB+fVpwpX60lU=; 
        b=gTBYFSI1AtqNxb3TBNFHbwdLzKsP1cp3NuBvtic512yYeTmPpJiNaD47lB85CYCR9ix3J8h6ENWR+LcDLzk622rQJJd4IN++IZk/vt0JN3fQjWMmIRiH9MRMuGlQMS7M3uAkuK99+aR8xJ+OiI+/r4qXMbus06UQm9mOYx1Z5As=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=mNFcDLdQhDJCESt1vKUQhwVd0UyFMjniS/stQoALd0pN09qJZ0bQ+JSEzurPnOm61D9s/hXYvs0g
    LLFJg5WX+2/c/5ojnibJQlEDjHXdqBTP7yD50yp0aYsoIFvlj1Dj  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664415554;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=w65lv5IW2MbTBlo+u0sGaPp2dO9vOUwB+fVpwpX60lU=;
        b=KDNunc1eI0SxO3i3Hj+0m4eCb95pZ+cRW/KmO3iO2lrsmO3fVcdC9VOCUapBgvwT
        zSOovqlvvwyrknd3+Pj+Zo2gWStpCKYqXQdfAkX4ze7SOoi9VPxCxH1cIOtqImKZLq7
        TmifIU5sejYb/YxZkY8JMM4Z5e39CU4pqr1SGsms=
Received: from localhost.localdomain (58.247.201.74 [58.247.201.74]) by mx.zohomail.com
        with SMTPS id 1664415553033387.3221280548281; Wed, 28 Sep 2022 18:39:13 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     wqu@suse.com
Cc:     hmsjwzb@zoho.com, stringbox8@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH]btrfs:remove redundant index_rbio_pages in raid56_rmw_stripe
Date:   Thu, 29 Sep 2022 09:37:33 +0800
Message-Id: <20220929013733.2148-1-hmsjwzb@zoho.com>
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

