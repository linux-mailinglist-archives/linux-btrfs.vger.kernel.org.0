Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738258FA6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiHKKJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKKJ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 06:09:27 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B490C75;
        Thu, 11 Aug 2022 03:09:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 4AF2F2C86848D;
        Thu, 11 Aug 2022 18:09:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1660212564; bh=uv86+t4HgCDX8AgiBqiKnXGoEwaie1XcX3Kph50O2KQ=;
        h=From:To:Cc:Subject:Date;
        b=BEkyajqEU0N2G0wBYg6XsEOvisCXW/MfXaECfBnwDg5bbMekIfpVBKYlWaMeJC794
         0Rwue/BU4409/cOHpSzsnT12wRXE19isWB7E2ZR6S9318xz87cVoWqQTxlxtVtJzEz
         rXNGqv0K5Md11vm6JO5MMC2MKG5PVLlsZOkTES7U=
From:   bingjingc <bingjingc@synology.com>
To:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH v2 0/2]  btrfs: send: fix failures when processing inodes with no links
Date:   Thu, 11 Aug 2022 18:09:10 +0800
Message-Id: <20220811100912.126447-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

There is a bug causing send failures when processing an orphan directory
with no links. In commit 46b2f4590aab ("Btrfs: fix send failure when root
has deleted files still open")', the orphan inode issue was addressed. The
send operation fails with a ENOENT error because of any attempts to
generate a path for the inode with a link count of zero. Therefore, in that
patch, sctx->ignore_cur_inode was introduced to be set if the current inode
has a link count of zero for bypassing some unnecessary steps. And a helper
function btrfs_unlink_all_paths() was introduced and called to clean up old
paths found in the parent snapshot. However, not only regular files but
also directories can be orphan inodes. So if the send operation meets an
orphan directory, it will issue a wrong unlink command for that directory
now. Soon the receive operation fails with a EISDIR error. Besides, the
send operation also fails with a ENOENT error later when it tries to
generate a path of it.


BingJing Chang (2):
  btrfs: send: refactor get_inode_info()
  btrfs: send: fix failures when processing inodes with no links

 fs/btrfs/send.c | 364 +++++++++++++++++++++---------------------------
 1 file changed, 162 insertions(+), 202 deletions(-)

-- 
2.37.1

