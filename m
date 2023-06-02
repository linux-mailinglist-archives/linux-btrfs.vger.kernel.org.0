Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773C77209C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbjFBTYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjFBTYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 15:24:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12298;
        Fri,  2 Jun 2023 12:24:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E6FE421A60;
        Fri,  2 Jun 2023 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685733841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6BU7WsNkshb0I4BCgfXSlKgcNLRX8mR1SS/yIWTtajw=;
        b=VzFpHjfzzp/FrmHXcrLOS7PsCdL1iZXojLbsVEDiWgHxbWZqR1lzeITlk1sskQOTUK7X28
        IwDhNfIn1GS1MLYp8+P3pLIPmC7SAuFFgdyio4Of4FFNpDP6SQpV88ALUtyQb9N5rC+Buf
        JKMIBRoQPuoRn+U/Y/jBjom/2IISZxc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D2F482C141;
        Fri,  2 Jun 2023 19:24:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45580DA85A; Fri,  2 Jun 2023 21:17:50 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.4-rc5, part 2
Date:   Fri,  2 Jun 2023 21:17:49 +0200
Message-Id: <cover.1685730530.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please pull one regression fix. The rewrite of scrub code in 6.4 broke
device replace in zoned mode, some of the writes could happen out of
order so this had to be adjusted for all cases.  Thanks.

----------------------------------------------------------------
The following changes since commit 5ad9b4719fc9bc4715c7e19875a962095b0577e7:

  btrfs: fix csum_tree_block page iteration to avoid tripping on -Werror=array-bounds (2023-05-26 23:24:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc4-tag

for you to fetch changes up to b675df0257bb717082f592626da3ddfc5bdc2b6b:

  btrfs: zoned: fix dev-replace after the scrub rework (2023-06-01 15:12:02 +0200)

----------------------------------------------------------------
Qu Wenruo (1):
      btrfs: zoned: fix dev-replace after the scrub rework

 fs/btrfs/bio.c   |  4 ----
 fs/btrfs/scrub.c | 48 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 20 deletions(-)
