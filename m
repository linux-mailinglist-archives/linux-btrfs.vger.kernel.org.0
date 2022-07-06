Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08589568922
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiGFNPj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiGFNPi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 09:15:38 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 06:15:37 PDT
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137225F1;
        Wed,  6 Jul 2022 06:15:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 791051BA2363A;
        Wed,  6 Jul 2022 21:10:08 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1657113009; bh=7Ow7q0OE+V2ezcJYBI6yuyQyioUIMwsO6+48RC1L7nk=;
        h=From:To:Cc:Subject:Date;
        b=m7Ed0l9BZRERmpnawm3hW48qeAx6CZPmQqU1yUuLigny3rB0KkGQFOPeL4ab+y95C
         V8yaOC/s2C4fsap0zGApsqOZiGmxhJfw8eYr47D5NvlXQEXuZ5NKPrZB21+P4i336R
         uzosslY0weE22GBQRtgQlc8SsX7DCUpG2hDpmhlk=
From:   bingjingc <bingjingc@synology.com>
To:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH 0/2] btrfs: send: fix a bug that sending a link command on existing file path
Date:   Wed,  6 Jul 2022 21:09:01 +0800
Message-Id: <20220706130903.1661-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.0
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

btrfs_ioctl_send processes recorded btrfs_keys in a defined order. (First,
we process a btrfs_key with a samller objectid. If btrfs_keys have the same
objectid, then we compare their types and offsets accordingly.) However,
reference paths for an inode can be stored in either BTRFS_INODE_REF_KEY
btrfs_keys or BTRFS_INODE_EXTREF_KEY btrfs_keys. And due to the limitation
of the helper function - iterate_inode_ref, we can only iterate the entries
of ONE btrfs_inode_ref or btrfs_inode_extref. That is, there must be a bug
in processing the same reference paths, which are stored in different ways.

Please see the second commit for the details.

bingjingc (2):
  btrfs: send: introduce recorded_ref_alloc and recorded_ref_free
  btrfs: send: fix a bug that sending a link command on existing file
    path

 fs/btrfs/send.c | 194 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 14 deletions(-)

-- 
2.37.0

