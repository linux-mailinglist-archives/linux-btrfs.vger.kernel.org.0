Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91F60F5E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiJ0LHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJ0LHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 07:07:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DC201B1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 04:07:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC2EC1FDF7;
        Thu, 27 Oct 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666868834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EL2qmiWGA0fbV7fIbZW+c94wioMX5HM2/gDXKcjfkAE=;
        b=jbgLB8OUyOzgdxT6TpBD8G2dAI/faBjzBxK1xjDXY1ys8Dq0f9L8u27eshOqEyWNsUZ92+
        BBdozVfOcmOLIE21PBFn5+LE3cWc9HzBcZ4o1c5FuykzBGZR/bov9riXpjObMVDKn0jEe+
        NO7CHZ9nk6+PXk85cszVIUxI4MCgEuI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E3EAF2C141;
        Thu, 27 Oct 2022 11:07:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48BFCDA79B; Thu, 27 Oct 2022 13:07:01 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Merge extent_page_data and bio_ctrl
Date:   Thu, 27 Oct 2022 13:07:01 +0200
Message-Id: <cover.1666868739.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent_page_data structure has shrunk over time and does not make
much sense to have it separately from bio_ctrl.

David Sterba (2):
  btrfs: switch extent_page_data bit fields to bools
  btrfs: merge struct extent_page_data to btrfs_bio_ctrl

 fs/btrfs/extent_io.c | 121 +++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 63 deletions(-)

-- 
2.37.3

