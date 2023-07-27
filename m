Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F876466E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 08:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjG0GIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 02:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjG0GIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 02:08:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EFE42
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 23:08:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D42521B85
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690438093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QCAlZCzVSfPILO+NEKghCnYlz34+6W36rx7AElSODUg=;
        b=b2uN3M1XVp/fvN73jeuER9ktuCsF8hYU1/AbNTGgyDbh2BKpHw3R5rFib9tQFljBYZ2gtL
        H0ad0D57ySmBj4xqcDK06609EipuQfNONhbvnaA7Atgrg/gyE7CTYNPKoRamW+9I+C7xfS
        e3QFfrbqNKpsb0XUACGh84hiUP3EsYk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4898713902
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WMYHA8wJwmQdDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: do not commit transaction to avoid deadly ENOSPC trap
Date:   Thu, 27 Jul 2023 14:07:52 +0800
Message-ID: <cover.1690437675.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

There is a report that a user hits a deadly ENOSPC trap, where the fs
would immediately falls read-only when commit any transaction.

To make the case worse, the fs is using RAID1C4 (later converted to
RAID1C3), this makes it impossible to add any extra disks.

As the kernel would commit the current transaction after just adding the
first device, while RAID1C4 needs 4 new disks, this would still trigger
ENOSPC during transaction committing.

The first patch would address the problem by not committing the
transaction adding a new device.

This would cause a behavior change, would need to co-operate with
btrfs-progs to allow end users to determine if they want to sync the fs
after adding all devices.

The second patch is to address a rare corner case hit by the same
reporter, that canceling a suspended replace would also trigger the
deadly ENOSPC trap.

Qu Wenruo (2):
  btrfs: do not commit transaction after adding one device
  btrfs: do not commit transaction canceling a suspended replace

 fs/btrfs/dev-replace.c | 10 ----------
 fs/btrfs/volumes.c     | 12 ++----------
 2 files changed, 2 insertions(+), 20 deletions(-)

-- 
2.41.0

