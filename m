Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5164D8C11
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiCNTKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiCNTKf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:10:35 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E012AC71;
        Mon, 14 Mar 2022 12:09:25 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 087E4800B8;
        Mon, 14 Mar 2022 15:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647284964; bh=D65mw+VPjgm9JWYvPB45yIJYu6PVXrs9awDCVElvqKU=;
        h=From:To:Cc:Subject:Date:From;
        b=oqWNLfFMM0t5ScMbi/WPyX6ZvOi4rhNhgY/9LcB9hXP/lRZsjXcewTSRHxlYvXODO
         9wMdnCz6gkOY/01XMnaTWEDR+2nXdH8Q4zPFi7R9sLcWdNT6QWor5f+p3Klyvv++B8
         lvhL+GyGckUDhv/4bT6NtM70+O7h9bl4Z+Tw5oNMGfy0vl+kzjPPRS73gsYNKIpcsM
         AoWW1+Mv0H+wOlb3/Ck5Hy1bU06IaqUSnOPwElwSTMhtZ6fFUm9a8LhENZgFY1gFGT
         Hen0TVo2P4pzY7aBrxEOK8yJy9s6mkXSOHfxhwG/kKnGRPgmNLJAffLP7/6fZ5YllL
         tO92Ttv6QB2aA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] MAINTAINERS: btrfs: update development git tree location
Date:   Mon, 14 Mar 2022 15:09:07 -0400
Message-Id: <20220314190907.23279-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patches get pulled into a branch on github as listed, before eventually
making it into a pull request using the kernel.org git repository.
Development is expected to work off of the github branch, though, so
list it in MAINTAINERS as a secondary tree.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..38316c82f64a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4108,6 +4108,7 @@ W:	http://btrfs.wiki.kernel.org/
 Q:	http://patchwork.kernel.org/project/linux-btrfs/list/
 C:	irc://irc.libera.chat/btrfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
+T:	git https://github.com/kdave/btrfs-devel.git misc-next
 F:	Documentation/filesystems/btrfs.rst
 F:	fs/btrfs/
 F:	include/linux/btrfs*
-- 
2.35.1

