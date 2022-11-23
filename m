Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE7636D50
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKWWiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKWWhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:50 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B024BE3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:45 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d13so7407184qvj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xut37ZRg8AL9c6FvBSSBdj8ccZSle/cxGR4xJZCoaQ=;
        b=QTnY50W3j4ZP9oOWcPqHlPp9Rdj0qRlST89Zyg+Yo14BLx35+SzPytJMTeMxvYnuZ0
         p85IiQil0JDF+UXxs2rUFzAHr0S82moldp0PyqNyOT1hzkF5HRrtvBQmpd0HDzM48qpz
         3lqh+S1Ehacem98L/6+4bJPP770G8SFg9t5xGAUZBBwToHyTJYsnOGQUknKUoxhOxSTB
         AhaIq3Flw8p0Z8IHp73M/1p+nUdUd516C45bm2aLTlhJGNyTzP2RxSuDxGac4yGoTF6S
         jtCBin0nYxhU3JdaT8BOi1mI2IEGM4utv9jag5iPcglyTZEbBmzy6E74iGdye4u+y4nq
         3UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xut37ZRg8AL9c6FvBSSBdj8ccZSle/cxGR4xJZCoaQ=;
        b=K7fc76dHt6qqlusZK6xkKI8NEc/LbStn9+wV8m/7WH4cbkCHn1mPRVHs9Q/1if9T9A
         93Z28F/ewtC4Hhmx8loHWzqInw4qcRD5AO/R4pZEsWBTqD4qVRdpsjgBihhE7IapFRvs
         gCGjc6CA5IyR0Ywtd6xQb+Eb9d1sOgdc1QX+64kTueRE8BLbsSwHyD2ekSs9VgIH2gPW
         NU5coBjOMkuwAPVTRwQBuefvw9cCcAPcaVr1U7kpZLVQioMMBc4m+gXl07VSA2cTRkMN
         kN06WIqCguuFEixTO1mq5BEP5nkknt1BRYvHzL93RaxozfdBqh5opi4kwG/2qN9uPy/+
         6qWA==
X-Gm-Message-State: ANoB5pljUo5G7jBj4zZ8ZJL8aXEGLZONyf5Mmsj7V1fkYvi38KE0rAeo
        93b7lM/M/bPHyhYO/aDmXjxkQjWB8otMMg==
X-Google-Smtp-Source: AA0mqf79aAO/4uy+Rv8UENDfBGCoamIHw9BbkX+Lu+Ng4aS2V+1AQW0IGXyytNcT/J3gZgo5SLTe5Q==
X-Received: by 2002:a05:6214:aab:b0:4bb:625c:e300 with SMTP id ew11-20020a0562140aab00b004bb625ce300mr10136511qvb.96.1669243064703;
        Wed, 23 Nov 2022 14:37:44 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d12-20020ac8060c000000b0039d085a2571sm10446669qth.55.2022.11.23.14.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 04/29] btrfs-progs: use -std=gnu11
Date:   Wed, 23 Nov 2022 17:37:12 -0500
Message-Id: <d14df29fe513f2ee0cd0290407da381824af239e.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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
index 475754e2..aae7d66a 100644
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

