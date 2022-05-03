Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73F5517FD8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiECIkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiECIkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:40:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD3340ED
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:36:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C76E91F74A;
        Tue,  3 May 2022 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651566999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MmSsS/mhYGDBNFyJNxiK02TJEOrjA85IhTTxqmqeXvs=;
        b=uvrtJdNW8O8QNlmwfgWhOcr25M0gzTwodY1GHrKcS1UkX1TKlndr72qt1E41zGdaRvPTtZ
        xN6VHlbr9lbXP+8ijv71zSh6AnSTX51EWmyCeOaJzGaiCQyY+gCsQyKe5CQjIesNdz3SCU
        xKdtfHlypDj1q210KDPS/UJIBen4tGE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AC1C13ABE;
        Tue,  3 May 2022 08:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q1w7H5fpcGIQPgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 03 May 2022 08:36:39 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/2] Refactor btrfs_ioctl_balance
Date:   Tue,  3 May 2022 11:36:35 +0300
Message-Id: <20220503083637.1051023-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
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

A recent bug report about a memleak as a result from my refactoring of
btrfs_ioctl_balance clearly demonstrated that the function has become quite
unwieldy and fragile. This stems from the fact that it involves some fairly
convoluted logic in order to acquire the necessary locks (balance_mutex and the
exclusive ops) and the requirement to handle in-progress or paused balance.

In order to simplify btrfs_ioctl_balance this series first factors out the locking
code as it's de-facto separate functionality. It then replaces the open-coded
locking logic with the newly introduced helper. This makes the code-flow in
btrfs_ioctl_balance more linear and simple to follow.

Nikolay Borisov (2):
  btrfs: Introduce btrfs_try_lock_balance
  btrfs: Use btrfs_try_lock_balance in btrfs_ioctl_balance

 fs/btrfs/ioctl.c | 118 +++++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 46 deletions(-)

--
2.25.1

