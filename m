Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC12CDD94
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502081AbgLCSZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502069AbgLCSZX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:23 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE4C094260
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:29 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so1443378qvb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNOtAisk0hN8omuiH6mLCn6ZjHq8m2odxb3m+HFyoKQ=;
        b=0gIA0/t7d5NlWJNCmHdawQB3PcealhhiK/rVVcrPb7y3LMRwk5wzI98yJy7HEgzf9d
         j6ur/Ev5eCe0r8fSzlwhIHI0j2aP8dG/bopiACUmK8R4QHqmu5dUIQtbuMBDQYGwtce8
         mfG2+nG30O6eZiDn3i+8XyjW9pa8l6JmZOYhlSIpHyRE0hVLe5CBhq8vQVVAyL50Zdyu
         S4QivUBzcqDeZuKZ9Fd6HW7ISv9QH7TUCfw1B2RjCW0BxmpalJHbLucLtBsLRueFbJB7
         bRxwNlNrXXMBC7FhqxtXEUaHmmnci0P1yG2LQYvdn/GdL9uPLMfFZv+JdLm5jDBzBQwF
         NTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNOtAisk0hN8omuiH6mLCn6ZjHq8m2odxb3m+HFyoKQ=;
        b=iig6gngsQZ90dgwZsp27JxXfRFA3aBdC40Sdiu1wPE8qcu4vf2Rm4WkrY/MQnohXTm
         hFsyoUR9HwWfxBrw0q3lEjMjo54G+5HpBusY3dnZaaDJq9hJYlYxQkrg5osD3Wp9dOeg
         U9mVHWqhyJyOIesUNlJpLw8MT2pPdf5oj4xDEMaaBcsNRkx9nLKCuIha4WaR8M5L4H9S
         hsJBauSpPjbfEjtTqKB5sygVkVxSgVINvP+rRejid7WDQcuQtXy5suMObcyjbsSQbdBb
         sJ7MGLDsvXIrEwOsoJmE5rOQQ32jHMWlW7eMlR87I7A1A7p10turUOllkgw5faRpDD4Q
         IkKQ==
X-Gm-Message-State: AOAM531eQC9gKvEqLPazvIUVQ90fVwG0ejZGHxWIe6FSMUKx7FMQSShZ
        6xuF3miYS36MJNh5Vp+Bx3mjWtUAH7RQrfsH
X-Google-Smtp-Source: ABdhPJyyVQrFWZAu7ntOj6Rf48VOXBnF4S+f790cst8dMgExcHC8StOEIYpSHy4NQM0VxxbZv+c5bA==
X-Received: by 2002:a0c:cdc9:: with SMTP id a9mr150478qvn.35.1607019868004;
        Thu, 03 Dec 2020 10:24:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a20sm1778669qta.6.2020.12.03.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v4 50/53] btrfs: do not WARN_ON() if we can't find the reloc root
Date:   Thu,  3 Dec 2020 13:22:56 -0500
Message-Id: <b316179ad242d816728420d699e2d09b1002fdbb.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any number of things could have gone wrong, like ENOMEM or EIO, so don't
WARN_ON() if we're unable to find the reloc root in the backref code.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 56f7c840031e..525815d2914b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2617,7 +2617,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		/* Only reloc backref cache cares about a specific root */
 		if (cache->is_reloc) {
 			root = find_reloc_root(cache->fs_info, cur->bytenr);
-			if (WARN_ON(!root))
+			if (!root)
 				return -ENOENT;
 			cur->root = root;
 		} else {
-- 
2.26.2

