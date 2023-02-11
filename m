Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD6693081
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBKLux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 06:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjBKLuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 06:50:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19011E80
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:50:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23BAF5D3FB
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676116250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b721bYHgGMSe/pKBnz8Gt7dNOFiWG83UCwOunjHtOgw=;
        b=UIU0BUX/pYdex2jaLGkVm3euSUxDyYesJnMC5rz1Xa+TlJPTUTL8riEFyrkCt9m8fieHmO
        CEQioluHz8KZZABHUVigidYpCh2zVRKR/9utYfoD2/XEE+UbcTywdUGnLzjJRagnJ60JLp
        0xq2bb+H2wnlpkggOOOGb7JxTNc/3/0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79D2A13A10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ue4jERmB52ObVgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: fix btrfs/249 failure
Date:   Sat, 11 Feb 2023 19:50:29 +0800
Message-Id: <cover.1676115988.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test case btrfs/249 fails from its introduction, as the fix is not
merged.

The root cause can be found in the first patch, which also introduced an
extra safe net to properly exclude the missing seed device.

However that safe net can only work with root privilege (as it goes
tree-search ioctl), that is good enough for the test case, but not the
best solution.

Instead a new kernel patch is introduced to expand the ability of dev
info ioctl (in a compatible way).

This patch would utilize that new member (and can fallback to the
tree-search if kernel doesn't support), so with newer kernel, fi-usage
can work without root privilege.

This patchset relies on the kernel patch titled:

  btrfs: ioctl: allow dev info ioctl to return fsid of a device

I really hope this won't cause extra delays, as the test case btrfs/249
is really causing too much hassle than it should.

Qu Wenruo (3):
  btrfs-progs: filesystem-usage: handle missing seed device properly
  btrfs-progs: sync ioctl from kernel
  btrfs-progs: filesystem-usage: use btrfs_ioctl_dev_info_args::fsid to
    determine if a device is seed

 cmds/filesystem-usage.c | 129 ++++++++++++++++++++++++++++++++++++----
 ioctl.h                 |  13 +++-
 libbtrfs/ioctl.h        |  13 +++-
 3 files changed, 141 insertions(+), 14 deletions(-)

-- 
2.39.1

