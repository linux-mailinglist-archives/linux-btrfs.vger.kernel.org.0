Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4185ABDCE
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiICIVh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiICIVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:21:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A817046
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:21:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BE2A1F9F0
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N8nI+YlCx49TjY/sxok9zyipJyF1tv/QgbRnb68V64o=;
        b=cv9gp3U/z+WjELnxhBCfQkxRxX/YlB1MwJ1Sow0hBejC9E6SmDVRCqmh91E156C8wjAtIE
        IWT+uJI0UnPMVFY1uN0vWDfdY5ezIO+YE5IvSd/I27jJ4Ywha0v77eq8Nzb6MEqHbVyE0X
        Emxd4O7rZPMdkESjPUv0IUNsEvYd8JI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7760139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C7yBHI0OE2NHawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:21:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH POC 0/2] btrfs-progs: experimental support for scrub_fs ioctl
Date:   Sat,  3 Sep 2022 16:21:13 +0800
Message-Id: <cover.1662193185.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is really a very limited support for scrub_fs ioctl.

It's not only hidden behind experimental flag, it doesn't provide full
"scrub start" options support.

Currently it just call the scrub_fs ioctl, and output the scrub progress
result.

No support for background scrub nor scrub status file.

Qu Wenruo (2):
  btrfs-progs: introduce BTRFS_IOC_SCRUB_FS family of ioctls
  btrfs-progs: scrub: add an experimental entrance for scrub_fs

 cmds/scrub.c |  79 +++++++++++++++++++++++
 ioctl.h      | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+)

-- 
2.37.3

