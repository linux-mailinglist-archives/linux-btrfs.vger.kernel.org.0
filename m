Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158935A63D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiH3MsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 08:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiH3MsC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 08:48:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA112F55F
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 05:47:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u22so10989542plq.12
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+04iQhdQZQHxxsTrOqcSsXyV/KCRf7XI44Q+BtZ4MfY=;
        b=WwXTyjUzMz2hGHBGnT1tGxZGy71z94PYb1Z85TpkpD3+eJIhdDgU52d2BQZINgM2md
         2dhsLhIKd6bfJaJLw3L4o9U0unFPLNRPNLD954sECEKwmUhg7PKSjVguCQdmyCxbu0Zu
         IrKDQc6KnaRtydlaDWz/RlIeDQXcyfkrXniQ/PNU224Pn7xIycyOjT6NLNY/9qfxqjAa
         AjS2OfheFVAy+K8+uPTF51IKmfnGmuAhww6otNTfHjHV6dtBcDnbKOjb0KTToPF7d9me
         uYVB0KtOSeV6toPhDBiZVzCsuxuZWb234yp6ru/3tIunyZawzhai/9VS1vfjB9OD46RP
         CfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+04iQhdQZQHxxsTrOqcSsXyV/KCRf7XI44Q+BtZ4MfY=;
        b=oASp3jd7wmisbcc7BvZM8ei6Fi9kFWdCB+0gjJc9NYJv36ydF5QMhxQhBc6Np6bsTU
         IWNSyw0G1DFDrEROFu1eg6E/ghzAyHU1L+288J5K0Da4qVMPj2V/GP2h1t6V/sUjYkHU
         w9/6mfquLStA9IzdEqBCf1IvzySdw/nXpTofgtzHgoOUstfpnvaUpY2w+jfST+wUpSsF
         82m3BXSdrpUFiFgpLwE4p2b3TmO/ZoAILC1GMcysksorFWTLBH5yH1YwmSYGqJziTRkS
         SrZrbLVo2s7IUm0Eei8YWfGgzP8bg7wYvEWaNrnMYVyHQUUahffLhKjjT2rRqsQdkLmm
         cAyA==
X-Gm-Message-State: ACgBeo0v8JFqXi0t7PMc2JlUs4wNIDZ3B6/xPfsWb7sOyKg4PMwxiVWy
        tbFcHbSDyyG8TliHb5mZscbWmi02o+MCLA==
X-Google-Smtp-Source: AA6agR5RybrJEJYSfFQYpBRf/+8JLSVNGm/fRCZpTz5uUcrkloE1xaJ4MSTcfi6jtA2VyfLZFSWevg==
X-Received: by 2002:a17:90b:1c12:b0:1fd:b28d:a98f with SMTP id oc18-20020a17090b1c1200b001fdb28da98fmr12508901pjb.24.1661863678154;
        Tue, 30 Aug 2022 05:47:58 -0700 (PDT)
Received: from damenlys-MBP.lan ([103.117.102.23])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709026e0100b001618b70dcc9sm9497609plk.101.2022.08.30.05.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Aug 2022 05:47:57 -0700 (PDT)
From:   Su Yue <glass@fydeos.io>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, Su Yue <glass@fydeos.io>
Subject: [PATCH] btrfs-progs: free extent buffer after repairing wrong transid eb
Date:   Tue, 30 Aug 2022 20:47:52 +0800
Message-Id: <20220830124752.45550-1-glass@fydeos.io>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In read_tree_block, extent buffer EXTENT_BAD_TRANSID flagged will
be added into fs_info->recow_ebs with an increment of its refs.

The corresponding free_extent_buffer should be called after we
fix transid error by cowing extent buffer then remove them from
fs_info->recow_ebs.

Otherwise, extent buffers will be leaked as fsck-tests/002 reports:
===================================================================
====== RUN CHECK /root/btrfs-progs/btrfs check --repair --force ./default_case.img.restored
parent transid verify failed on 29360128 wanted 9 found 755944791
parent transid verify failed on 29360128 wanted 9 found 755944791
parent transid verify failed on 29360128 wanted 9 found 755944791
Ignoring transid failure
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
extent buffer leak: start 29360128 len 4096
enabling repair mode
===================================================================

Fixes: c64485544baa ("Btrfs-progs: keep track of transid failures and fix them if possible")
Signed-off-by: Su Yue <glass@fydeos.io>
---
 check/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check/main.c b/check/main.c
index 0ba38f73c0a4..0dd18d07ff5d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10966,6 +10966,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				      struct extent_buffer, recow);
 		list_del_init(&eb->recow);
 		ret = recow_extent_buffer(root, eb);
+		free_extent_buffer(eb);
 		err |= !!ret;
 		if (ret) {
 			error("fails to fix transid errors");
-- 
2.37.1

