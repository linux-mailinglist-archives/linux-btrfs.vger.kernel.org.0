Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED475A0224
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 21:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiHXTcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbiHXTcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 15:32:13 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C36D57F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 12:32:12 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id n14so10419024qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=8KPESFWU5UIn8wId02P5On0WlsbHa3z2dVUFPCoebWQ=;
        b=jAfGaOMRelepkAyLur+R1KtR0asI2NysU2p6uKzuMA6bhNa4FYVvXR0gKzFJ1Gorxd
         vniMUtf46YAb1J63MFhEy6HMR7Jh59p68qV6sdX/UFGHRU9iccAzg164VfyuufQ0LXig
         LXx1UFpIuyB45GqHtncX8rQCSkyKiSZEnCO+KnSBH1r/dZF0qYv6q9slE0IZUPlYCa7g
         RjwHH5FxmRNU9Ojk0aiAxXQUrNPLnPU1ry0rYqHRqK+bWeJTOcJSVWLMeOXTVni7eJvh
         XicB768+J8gREak9EdsY1cDmYw2W90d949gI7XU8qlvDDFOODNwF7V47SynGYNMiZoIf
         fxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=8KPESFWU5UIn8wId02P5On0WlsbHa3z2dVUFPCoebWQ=;
        b=fsn2iFc4tz/kTOOdZJ9CAxvYbpIDChkq47FlvK3PqqfC2jCU5LhI68S0L2ar1DOwmt
         dxnmGX99jFzlaRaWnCMDq9pEEFMHF7MuNzM0e0sloFCtQ4kLncoGrQpEjaEoFq5bCWSo
         08pOSO1+XifsVesZ/Q50TnjOGVthIAAABfd4HpJ7DMhn175DN6I0HJ5X7zufqzeKAwDv
         cUUOHRWoF3sKPj/CcPjMDWvynkR8IZ2xyA54LAs8oKko1+FLHkc/Iv+sgV/CN8N2qdNs
         9xN8dpPMLKB8HfEIbL1UPJxh4I3PRficaMf5VvI1VqFH4fOrDiDVGPt4t4uqsZ0EDExt
         CaJw==
X-Gm-Message-State: ACgBeo2Q31rXsQxZarIeR4X8bT5lyfc2JsrcTMPT17JnAMQ4VWY/gyDd
        lhj69V/bIADPkAfXqtnWgF0gtA==
X-Google-Smtp-Source: AA6agR7lk/Mz07J9qvXY4hRvMsIr/TeJFx83p11qbWK79PvSlGItE8J6BTtnZuBb6ipHVOBEAoxbdA==
X-Received: by 2002:a0c:b298:0:b0:473:8d6a:df00 with SMTP id r24-20020a0cb298000000b004738d6adf00mr648761qve.71.1661369531965;
        Wed, 24 Aug 2022 12:32:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006bb9125363fsm16367930qki.121.2022.08.24.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:32:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: get section config after RUN_SECTION checks
Date:   Wed, 24 Aug 2022 15:32:10 -0400
Message-Id: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

While trying to do

./check -s <some section>

I was failing because I had a section defined higher than <some section>
that had TEST_DEV=/some/nonexistent/device, since I was using the other
section to test an experimental drive.  This appears to be because we
run through all of the sections, and when getting the section config we
check to see if it's valid, and in this case the section wasn't valid.

The section I was actually trying to use was valid however.  Fix check
to see if the section we're trying to run is in our list of sections to
run first, and then if it is get the config at that point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 0b2f10ed..ad0ab3cf 100755
--- a/check
+++ b/check
@@ -678,7 +678,6 @@ function run_section()
 
 	OLD_FSTYP=$FSTYP
 	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
-	get_next_config $section
 
 	# Do we need to run only some sections ?
 	if [ ! -z "$RUN_SECTION" ]; then
@@ -708,6 +707,8 @@ function run_section()
 		fi
 	fi
 
+	get_next_config $section
+
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
 		echo "failed to create results directory $RESULT_BASE"
-- 
2.26.3

