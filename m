Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D884457CC9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiGUNuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiGUNu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9E65BF
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:50:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5160434013;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658411410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VxRzY/P4b+v5ogNO+jUobNSdlItNxObG1UyA7+2oaZ4=;
        b=nsrCAMr6Y8Qzw61rpUkO1f7JO1LAGw6jF/33VW3b171qYdP/+DsHVC6IeHsiMRD7lGsPye
        g/v4spl/fL6kDIseuGSI4gYpD2N96FOiCenqlJvCBQg80LSFn2Q1nZFXUyaQTCBe3fpGS/
        1ohzqP4ul8MZM5PfoBioLQOcbxdP0fQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1614713A1B;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Tm4XApJZ2WIPMgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Jul 2022 13:50:10 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Remove duplicate code in btrfs_prune_dentries/find_next_inode
Date:   Thu, 21 Jul 2022 16:50:03 +0300
Message-Id: <20220721135006.3345302-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both functions share similar logic to find a particular inode. So this series
first factors out the common code in btrfs_find_inode and subsequently uses it
to remove most of the internals of the two client functions. This greatly
streamlines the codeflow in the affected functions.

The changes survived a full xfstest run.

Nikolay Borisov (3):
  btrfs: introduce btrfs_find_inode
  btrfs: use btrfs_find_inode in btrfs_prune_dentries
  btrfs: use btrfs_find_inode in find_next_inode

 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/inode.c      | 75 ++++++++++++++++++++++++++++++-------------
 fs/btrfs/relocation.c | 54 +++++++++++--------------------
 3 files changed, 73 insertions(+), 57 deletions(-)

--
2.25.1

