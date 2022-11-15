Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C1629D85
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiKOPcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiKOPbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:41 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A62E9C2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:34 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id g10so9685122qkl.6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ap0U0t2a02rBzC/AI3ISx1NCYFTi/tCv/+++Vvg9PaY=;
        b=0yBDa59jewMtqBkNMPEsnMLwR+7YtbQHsiuCyzjFAQ9L20IevO6Ict8m+DqlYUcvJn
         /EL6XiRNh/2TRdDxaRRwlL3a4gH+hqHqvg1/gZGq/oQk/a/NrLFAXFfNrPTLX7U3X2gk
         kjgdGmiXz9vJZ90qLjHKIvFPpmjoPdFXuORZM81xlqwUWw2UjC9IvBN3nmgWsAQyQ2na
         r5MVqbO9l7aYEmI7bJn1SIHQGtmkxR5QKZlfD4KTrQqhBXAXYpLtRY+3EJH1FDTHdLop
         I+ofbdFX0vmPlt7LQfB6oqvsa3Nj1rnhaae2P2XBRxo9E4fDFOcw5Y6UWeHL5Bi0Qu7t
         ySpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap0U0t2a02rBzC/AI3ISx1NCYFTi/tCv/+++Vvg9PaY=;
        b=4FId1eBWOOL43kOsnbYhymy38PNTfY1ZGKAe+uvy4/8mzcuz083h9bZaGatnSHiNpJ
         pVX1wLFibFyRNcv8e6FrVlcUy25L1N16Rz46130rRZyNBCVxH4X7hd1dOvxryZSYu3ww
         EFbU4ey5Dn+maG0UYMq53R4Qv/h5WiUGIMu35shnuALRJm9689FtsnNrZXpt3F3cjx+6
         Q9ZLTHEJuzLz9kcn0u2+k0PMM93UrhL5uVpcTdxa35fk0zXXpWOw/6UkUGt80TmbnRky
         C/yg+jW4DQ2XNXXwGpBmFfHOEvRefeARwZ71vFxS4cDvkB28QDqzjCy9mgC9lzWHIzwP
         zEyg==
X-Gm-Message-State: ANoB5pnjTMc9lD8+jE9C0Lo6iROp69knKW37wT3xsw20ORFEizbYOA6Q
        I7ue/61k0v9J1GkZ9n92ZACddkA2DG6D8A==
X-Google-Smtp-Source: AA0mqf7Jdue+IL86bp9J3jCJoAnbWUQw4MzXPJl5P9yAtKKIjlEVzLKlC85VGJAKQTInc407eeTiUQ==
X-Received: by 2002:ae9:e645:0:b0:6fa:9e9f:8f9c with SMTP id x5-20020ae9e645000000b006fa9e9f8f9cmr15652470qkl.694.1668526293146;
        Tue, 15 Nov 2022 07:31:33 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b0039d02911555sm7287282qtp.78.2022.11.15.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/18] btrfs-progs: use -std=gnu11
Date:   Tue, 15 Nov 2022 10:31:12 -0500
Message-Id: <b53b7358ad72a3640461a9ff110d85940ff2eb6b.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel switched to this recently, switch btrfs-progs to this as well
to avoid issues with syncing the kernel code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1777a22e..f25042f3 100644
--- a/Makefile
+++ b/Makefile
@@ -401,7 +401,7 @@ ifdef C
 			grep -v __SIZE_TYPE__ > $(check_defs))
 	check = $(CHECKER)
 	check_echo = echo
-	CSTD = -std=gnu89
+	CSTD = -std=gnu11
 else
 	check = true
 	check_echo = true
-- 
2.26.3

