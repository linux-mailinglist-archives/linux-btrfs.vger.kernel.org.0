Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC34E7032
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358513AbiCYJon (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 05:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358498AbiCYJom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 05:44:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413BF559D
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 02:43:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01653210F1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648201387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UZltufxYfz/WqLoThe+He1eTNnQ+pMByluLn8C2bCL4=;
        b=Q0fvvI57ERISzppSqXW1qQyMauqLYZz4hGq/Eqbb9mHXJ+ivt/k8B/HhyjoVoC0xWBJ1p9
        l0/rcYTi/ZQ90rGW3jj3QcgghfuRz+Znb6fw/0yWoNd4jHaYCXe772IRhD6xQQt4UZ0Vhn
        MlLLlt+uZ7S8BuDBbayvwasMcDT8xLA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58A31132E9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5vYJCqqOPWInCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs: make read repair work in synchronous mode
Date:   Fri, 25 Mar 2022 17:42:47 +0800
Message-Id: <cover.1648201268.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first patch is just a preparation for the 2nd patch, which is also
the core.

It will make repair_one_sector() to wait for the read from other copies
finish, before returning.

This will make the code easier to read, but huge drop in concurrency and
performance for read-repair.

My only justification is read-repair should be a cold path, and we may
be able to afford the change.

Qu Wenruo (2):
  btrfs: introduce a pure data checksum checking helper
  btrfs: do data read repair in synchronous mode

 fs/btrfs/ctree.h     |   2 +
 fs/btrfs/extent_io.c | 111 ++++++++++++++++++++++++++++++-------------
 fs/btrfs/extent_io.h |   3 +-
 fs/btrfs/inode.c     |  73 ++++++++++++++--------------
 4 files changed, 120 insertions(+), 69 deletions(-)

-- 
2.35.1

