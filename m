Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD066B8342
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 21:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCMU7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMU67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 16:58:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B9848F0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:58:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cf14so14674322qtb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1678741098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y0ivY2v3WxqqkWWUMmjTmjQrs6jrFIxl/WjoKHQe54=;
        b=kmOLAxmvw5PkE3r7oeBZFmITKrfLPc0FbI9xbBo6EfWlZNzGTqviY/qqH6g8z5FZgo
         pS2LLQNZpJlPbXjoXkAbKH2XhyzLO8BxVstyy40nNpmjoj2/HH898qFwgobqOoUJq4rU
         biVkRtAWQ67OtVF6A8hzDNVZiHykmJq/8k1oBPgM3g69D+r+aiqSoiMf8CNUrwKqqp+e
         HK925Se9IQ9cLQ+WmDWCzljY5Z9gU1kH91N6nrf927czKIHIhWxwr5eB2k8BgNoBq4Zh
         hdEcnU0AMxreKS54PCqavDEQDL0UNCba2UsPMyEy8oO3OK/5W23twnTPvr4Byhe4N9hT
         I/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y0ivY2v3WxqqkWWUMmjTmjQrs6jrFIxl/WjoKHQe54=;
        b=zFEvCUjmtH5InSddSmU+qjxIIrrUjFz9q7GiTyDFIJhQ3uh/0/yBBLcwrF+JRB/Ngw
         +SG60DTS2fMzMusX2AoEC6DwwfwiOmiZ6Bxk4VIeG0RD2Orz6WHctDJqGEfNqalv8Tj1
         mJslS8SGS8tWzjmNM4Vu4KFooo7u3jLfxeHxPs113SfR+I0e8aM/IMiid1Yhn+tqqoNQ
         PAC5wPa6XWft4VPPSvRHqMbYUk6ycW6eeHAWwO8FKX4R+ArT9EanRKERuxro24+x5kWh
         1PSgLcxEPPw56vSNSOUcF+y77/+xff6esHRPF+dE9iLU4X9IrAtxJj+IbL2IGInhG48n
         JUVw==
X-Gm-Message-State: AO0yUKWQ+Be7UX43zM0I5G/gtuAEo4ijIWg25tn4VdkHqPxg9NnjFOt+
        zGfBub8BN8ROwb+FQS8enRxqURJldJrL/w6IYUFulg==
X-Google-Smtp-Source: AK7set++Uw3BL4fL3S5jmrLAynQI9xsOzkdqY62MQWP9n48BSiGpeuUspjeGNdnr69dzdY+uWSmHMQ==
X-Received: by 2002:ac8:7dcb:0:b0:3bf:b70b:7804 with SMTP id c11-20020ac87dcb000000b003bfb70b7804mr26258141qte.25.1678741097819;
        Mon, 13 Mar 2023 13:58:17 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r8-20020a37a808000000b00741a8e96f25sm403901qke.88.2023.03.13.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:58:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: fix btrfs filesystem usage on older kernels
Date:   Mon, 13 Mar 2023 16:58:16 -0400
Message-Id: <88f58821cecf10db0fc419319cd26cb5bf56fa71.1678741088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Commit 32c2e57c ("btrfs-progs: read fsid from the sysfs in
device_is_seed") introduced a regression on older kernels where we don't
have the fsid exported for devices in sysfs.  Being unable to open this
file means that we don't get the device fsid and then fail to find any
devices to show.  Fix this by dealing with an error from opening the
sysfs file, which this patch we can now pass make test-mkfs on older
kernels.

Fixes: 32c2e57c ("btrfs-progs: read fsid from the sysfs in device_is_seed")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/filesystem-usage.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 57eec98c..45d4ea39 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -724,9 +724,7 @@ static int device_is_seed(int fd, const char *dev_path, u64 devid, const u8 *mnt
 		fsid_str[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
 		ret = uuid_parse(fsid_str, fsid);
 		close(sysfs_fd);
-	}
-
-	if (ret) {
+	} else {
 		ret = dev_to_fsid(dev_path, fsid);
 		if (ret)
 			return ret;
-- 
2.26.3

