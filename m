Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493AA4D0B2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbiCGWev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343796AbiCGWep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:45 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476DA473BD
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:50 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z66so13288988qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y4iInL5FQNaa30XCeT0tTHXymZTDrydvlJrkTwbx8rw=;
        b=lwwheomXk0y2YxYuEtjHenSuY7O2fKAm94+q/LXEmUtPru9dYxfirRlho0z4EtNm4f
         FSSpZQUi2wudac4adcOLzoG34ga7jYg5O1ef2hZ85tQLm5LVBCkQua7Pb/WtG1hz+5Hf
         IcS8N6prRNMSotzk3p0zev6ylviG3tYHAd09WliWa6S96ZFfu/CS74tlXoJ+wm742OlU
         8veS4dk1Udv6vnybIn2a6b1fisW+Z+PyavPYiw5WJBjHMSz5XZ1lT3nBEJCTmcUjoMsL
         trcexiiJO6bLinJ/wZJLb2Ti1Dps0hyjkzFhcnwA1uaI/hlZb7sgi8IwY2+HRkFT8+PN
         bP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4iInL5FQNaa30XCeT0tTHXymZTDrydvlJrkTwbx8rw=;
        b=6mWPawybtbscZ0iA7ayF6aoLlWbApH7xI0mtkjEkb5NB1Txc4b3+etTG42aiz+Tn8T
         L+NiKwDmnOf+d5lHoMu0rZwGzIEcMViBBgvXuBVN8Vi41pKa1a8RhcFn6eLuWASoUSev
         WGxff0WF/I0JoGzP2UYiiZTa/Ahu08qjAHTvUpX5al9bnKrDb4jLtieMvr87p4BVS5dR
         AHwTK38FZ3wPeZ6/G+eTj+x32DMZE69D3daTzB9ZuqPnoRkxEO/MkKWKGEDkHXvb7mhV
         zYEAzNs+5wEjl6uQj8G7Ea36IVzahkXMqo3B10/hAkviPpHCVxkRwL7oQZINorYyrTLn
         JGpA==
X-Gm-Message-State: AOAM532bJVIkjxOTYgjn+o869i3rC95tMd+By+d8dLFHO1HdeAIlmr4/
        IR92fRSTeLrjpze0pFLTqP0qMgyrkuDovKBI
X-Google-Smtp-Source: ABdhPJzhqR0FwgU4Lx2jnJ7qj4k4zl9wvjR56UEOCxyJzOr++j7JtcJofWUw0pCT2BmYECQs+vDl0A==
X-Received: by 2002:a05:620a:1713:b0:67b:3b91:e91b with SMTP id az19-20020a05620a171300b0067b3b91e91bmr2883765qkb.534.1646692429196;
        Mon, 07 Mar 2022 14:33:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b128-20020a378086000000b0067c65e0897fsm527579qkd.59.2022.03.07.14.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/12] btrfs: use _offset helpers instead of offsetof in generic_bin_search
Date:   Mon,  7 Mar 2022 17:33:31 -0500
Message-Id: <51de9fc987057bc50097fd217e8a3fa51068a49c.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The starting offset for the items/keys are going to be dependent on
extent tree v2, use the helpers instead of offsetof directly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a6f24baf33b..6e8c02eec548 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -781,10 +781,10 @@ static noinline int generic_bin_search(struct extent_buffer *eb, int low,
 	}
 
 	if (btrfs_header_level(eb) == 0) {
-		p = offsetof(struct btrfs_leaf, items);
+		p = btrfs_item_nr_offset(eb, 0);
 		item_size = sizeof(struct btrfs_item);
 	} else {
-		p = offsetof(struct btrfs_node, ptrs);
+		p = btrfs_node_key_ptr_offset(eb, 0);
 		item_size = sizeof(struct btrfs_key_ptr);
 	}
 
-- 
2.26.3

