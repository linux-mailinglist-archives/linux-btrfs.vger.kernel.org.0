Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34629C249
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 08:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfHYGFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 02:05:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYGFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 02:05:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so12802535wme.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 23:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRq1qe6ZnFoLM38sBgMYIEDf7LhJqImQEAoEoK61Jdw=;
        b=eyj7YN20TP/jseuOVaw+lVh62qZ1a7DjkG6hCzoXiMUXWn1gtYb0krwoAm2i7U/Daz
         b6pf2MIR8NX2RMuETWO6MWrI74LiyltH1BDgMcRal+Ifcek1Oidn1kdyivdXKtxFZ/MZ
         3pyn1YZkdbIQTR7x4vQp3wKxxoewvn6WGmPJI2uyq1ym/nn+Ca5cs+IBFEzTS5vyqM52
         GDVcwHKEji+5c7cPVAgvGx8XyytL4YLd78rFUu9y4YmOAI9j76ABUojR0L+Q28lW1Wtx
         jNxBQ7wn3nrs/24rHZgRS+2YUW3vzJZ2N/UIfq8kbpRXv62fy21vPPqsmZ3IcrTIrasf
         vu9g==
X-Gm-Message-State: APjAAAWXbLLCIeEohPWKsTCiFPe8uGJIt2xDQLSZg+wArOlId1Xs57yk
        WICKN+u8+AqDqzqDDEzETuiPiRkU
X-Google-Smtp-Source: APXvYqzzFXWaqYUa4ITBosNHRjQXUhXlkm8tXQSwI4gU6Wu+SBrDDNKU5u+89B6cxfDLV3tepHF3jw==
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr14988542wml.64.1566713114490;
        Sat, 24 Aug 2019 23:05:14 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id u186sm20217232wmu.26.2019.08.24.23.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 23:05:13 -0700 (PDT)
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>
Subject: [PATCH 1/1] btrfs-progs: docs: document btrfs-balance exit status in detail
Date:   Sun, 25 Aug 2019 06:02:56 +0000
Message-Id: <20190825060256.20529-2-git@vladimir.panteleev.md>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825060256.20529-1-git@vladimir.panteleev.md>
References: <20190825060256.20529-1-git@vladimir.panteleev.md>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
---
 Documentation/btrfs-balance.asciidoc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-balance.asciidoc b/Documentation/btrfs-balance.asciidoc
index bfb76742..8afd76da 100644
--- a/Documentation/btrfs-balance.asciidoc
+++ b/Documentation/btrfs-balance.asciidoc
@@ -354,8 +354,16 @@ This should lead to decrease in the 'total' numbers in the *btrfs filesystem df*
 
 EXIT STATUS
 -----------
-*btrfs balance* returns a zero exit status if it succeeds. Non zero is
-returned in case of failure.
+Unless indicated otherwise below, all *btrfs balance* subcommands
+return a zero exit status if they succeed, and non zero in case of
+failure.
+
+The *pause*, *cancel*, and *resume* subcommands exit with a status of
+*2* if they fail because a balance operation was not running.
+
+The *status* subcommand exits with a status of *0* if a balance
+operation is not running, *1* if the command-line usage is incorrect
+or a balance operation is still running, and *2* on other errors.
 
 AVAILABILITY
 ------------
-- 
2.23.0

