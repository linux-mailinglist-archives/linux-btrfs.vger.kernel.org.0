Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A709B34BAAD
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhC1EWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhC1EVe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:34 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202AC061762;
        Sat, 27 Mar 2021 21:21:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 7so9356895qka.7;
        Sat, 27 Mar 2021 21:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOOp0h2yVPN/f0Eod/KKvQYmCFRRcb0rcd4xmykcQJs=;
        b=Vsoi6NNETbFsZ6eFciLqoimy4OcE5kjqBhejIN4frrqM+XYxjW7lEuFfglq5eXZU3S
         Ay8shb+zO7DO8yQY9uz7irke6ckBsin6e73Fi5EidCFWFcos10m9yhzejzqsY7dbT711
         ej3M8cnYOOdqEPW+GzZGtJdtd/Oaz3Ulo/XbWKEnzyJPeCqrrHZriJ4MjvepXPYwkSxY
         CegRhwYMyT+sKm0hYEWNamm3mlOKHoRlWzs2biFHNInAaxCLhPQB7x4F1V9xgbnz7KWk
         Hw7UAci/YQ2XI/A5aEZs1DJpObqVRbccJYsrpU0wVd8LawuytfvuYf3WWAkrn7JDhjkR
         FquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOOp0h2yVPN/f0Eod/KKvQYmCFRRcb0rcd4xmykcQJs=;
        b=LcSqQ98gUiBM9cxWvXQTRRYuhXp83pJuF7kEI5AHwgCopRx2ulx/nN1K+VHkdGypT4
         LrtNzlouBtS4c/imTkub1JPQBzJ2xLfG4E456JA1Rk4haLM9eYZ+g8NISVkJA0nQjzG/
         3nHDis5HlktvZ6gHCpUdcCqflfvlI5Hs1B6AJMYUEk2343TuF/9G9XRoFJnt1mWtak9y
         rGexpfNM5A4RhUpIRFWxHO/4ru0ad9ptHF3KdQ0z4mwxt/ARnJSBgNqaJwGte7iAsFM4
         VUyZtFt3zns1N3HRL2X3+grc7CqhvIy+V7f4VjtoCjFdhN9+lCC/s4eX5mXKXWXv33Sy
         PoSA==
X-Gm-Message-State: AOAM530ZUrYmwZQqpQQrhwzfadvwSXsScHRv+Fjuw52DBC8jwFhaM6Sr
        kikSY157pHvVWsXpxrQu7d0=
X-Google-Smtp-Source: ABdhPJzh97Po64m6fSxl5LvpcheBVIWr4k4YFBHHztS8K9cXM232RAd1CmnvQBlUwOjiImLZxDaemg==
X-Received: by 2002:a37:a183:: with SMTP id k125mr20157241qke.332.1616905293946;
        Sat, 27 Mar 2021 21:21:33 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:33 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] scrub.c: Fix a typo
Date:   Sun, 28 Mar 2021 09:48:30 +0530
Message-Id: <d9da818223f9e4a82d6a4260347915d2407d822a.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/reponsible/responsible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3d9088eab2fc..14de898967bf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2426,7 +2426,7 @@ static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *su
  * the csum into @csum.
  *
  * The search source is sctx->csum_list, which is a pre-populated list
- * storing bytenr ordered csum ranges.  We're reponsible to cleanup any range
+ * storing bytenr ordered csum ranges.  We're responsible to cleanup any range
  * that is before @logical.
  *
  * Return 0 if there is no csum for the range.
--
2.26.2

