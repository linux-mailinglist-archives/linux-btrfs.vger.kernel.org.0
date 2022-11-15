Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF86294A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 10:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiKOJoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 04:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiKOJoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 04:44:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4DA440
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 01:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=odsTtYqYuYP//RhUZWiHpV3aHUzXNgqWulPZGOa27IU=; b=Z/lC3NAY95idmhd+uyMkVrZLXV
        cm2Ns8eDMV/0YZUSCLzsfoPUiyFRGK4v4F9b6u9EL4KY4uEZErSEtsy4wchaej2AkipMBJ/mH0s1z
        j3k09vs/AFcWtqjPe1XIBMSEEDFJsGuE8Q9ZM7CqHSmBSwoM3cKdLZQuVz8G592pxa38L8TTeABg9
        g3kLAbMj2YIXuJBBe3p4BGsLFlxtEYNJTiCi79g6tNZRPpseYxaKHneeayob788oITH48autFGX5W
        t5KBWWW9ngRv9ta0WslQKmg40RzxWhW4t5LBZ9f8MZMJCwI84P9zBsrFsyzaZuu/9q3v1bkher/Yt
        xr59fnpg==;
Received: from [2001:4bb8:191:2606:160:4e5a:8508:c11d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ousUD-009WpS-1O; Tue, 15 Nov 2022 09:44:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: move the low-level btrfs_bio code into a separate file v3
Date:   Tue, 15 Nov 2022 10:44:03 +0100
Message-Id: <20221115094407.1626250-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this small series creates a new bio.c file (and a bio.h header for it)
to contain all the "storage" layer code below btrfs_submit_bio.  The
amount of code sitting below btrfs_submit_bio will grow a lot with
the "consolidate btrfs checksumming, repair and bio splitting" series,
so this pure code move series triest to prepare for that by making
sure we have a neat file to add it to.

Changes since v2:
 - rebased against the rcu_string changes in misc-next

Changes since v1:
 - rebased to the latest misc-next branch
 - added a new patch to move struct btrfs_tree_parent_check into a new
   header to invoide include hell
