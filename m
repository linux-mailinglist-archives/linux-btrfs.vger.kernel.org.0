Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087B831CE12
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 17:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhBPQ3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 11:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhBPQ3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 11:29:32 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D151FC061786
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 08:28:51 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id j12so6431752pfj.12
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMjqqsXDMD4fu1LFs66Qit+rAtkNPsP0N3lwG5GFPCs=;
        b=Ow3TC9NoYJDntavnvFNj1MNkQMfFQAZMLlbenmBhtWAfWtKgKHCF2D/XOpyag3XYeH
         huqW9p1AkrB5+v0a1S8FHJeDX99YpaJ/0p8Tdn4/2WaaJoOLibGCdDGaVWGR3G6B51Mh
         s4/qMXR+UU/bM3dai870KKuRytE+RrZ8qa2HO1YKayJ/WP6zKu0lcCOZu+hM1BYqiFZK
         6CzG58HkGwGN20azPWDGbB3isVFnbny7RwN4dGQX7OrSR9Sngye8i7ZDyecW2l+5AboS
         Ax83Xi7nSnjsJUFd5481GvVqrE+ZOhUNi+Sj9aMs6rHcty+kCWdZKFM5pEwaGY0dThGA
         8ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMjqqsXDMD4fu1LFs66Qit+rAtkNPsP0N3lwG5GFPCs=;
        b=rVWhE4BCQjsaEiKVeTww3aw29QrWjjZGA71sKVp6chZjSCPq/cNiAeShG/vnwm8m2L
         krqpVNVLY725IAh8SPKwiDkJC/XcmixgYDl/iLCpSGgxUXkk47+3q7Va6L6nAP9Hk6CE
         Sq9LaAuWKoT3AY6foBElNPy+ilIzDN3oIUuXoZD55bbz8vRfdRwIyus6G9iCzeTxPRuc
         NQ2e3V1vNsIUwqV2AupxGilNU4i92tePOP5kf9ut7ttSXmIqjRezJb4F0vgBsTVNf/T2
         YhEb8KUbTxWPnYrWR1JqFawwerRaiFbHp3vT6t1Bdddhpm2UkDhSRYeGNanRx+v2GRWW
         IUOQ==
X-Gm-Message-State: AOAM531nZn+i6H56Xl3JiAssuM4fRxTgXRHqyABx2qkDu3HLJXl2mdkK
        DF66epZ3fa3BkTR+65ODrmpWni69DBFQJg==
X-Google-Smtp-Source: ABdhPJyUHvDKZVjCwMPT0oaOagj0a6OUl8m4eZWWvXtsyyQ3V8gYAHGagZLgdR+dlaxiPOBFQJynig==
X-Received: by 2002:a65:4082:: with SMTP id t2mr3045632pgp.140.1613492931350;
        Tue, 16 Feb 2021 08:28:51 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id a78sm23445944pfa.10.2021.02.16.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:28:51 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz,
        Filipe Manana <fdmanana@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC] btrfs-progs: format-output: remove newline in fmt_end text mode
Date:   Tue, 16 Feb 2021 16:28:40 +0000
Message-Id: <20210216162840.167845-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove a code that inserting new line in fmt_end() for text mode.
Old code made a failure in fstest btrfs/006.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
Hi, I've just read mail that Filipe written that some failure about fstest.
I'm worried about this patch makes other problem. So make it RFC. Thanks.
---
 common/format-output.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/format-output.c b/common/format-output.c
index f5b12548..96e0dfef 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -124,9 +124,7 @@ void fmt_end(struct format_ctx *fctx)
 
 	/* Close, no continuation to print */
 
-	if (bconf.output_format & CMD_FORMAT_TEXT)
-		putchar('\n');
-	else if (bconf.output_format & CMD_FORMAT_JSON) {
+	if (bconf.output_format & CMD_FORMAT_JSON) {
 		fmt_dec_depth(fctx);
 		fmt_separator(fctx);
 		printf("}\n");
-- 
2.25.1

