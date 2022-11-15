Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B13629D83
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiKOPcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiKOPbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF062E6A8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:32 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id e15so9997863qvo.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=lzQ2EzHmgk7XL5b99yAS7qPwvJeyHw9rJOJHZ5V5jgtnqJhYL9I1h6ZUnouPGF/yOn
         ce7+OskOp8XEZy2F8RNojxOY6ReE6eKbDjAz9mzuTMM98R3nuq92azqnnOIH+auMD24f
         myltK3unOLdc0yR0whP8cpzCFn4AuLMZGafNzRK4+vL6Nb2WwHL7DM1d/m/rUIgZHctN
         kXhwaX4GB4Vi02VuyoluTEJCBN31kDdd9FniVeH5jB/qahTpwMTLPnYasWMiSCthmQQG
         5Wcf/Jgo6RlOcfUdtcQoPAf6QqVRkVpxsruzWjLInvWDY+OcKwLwjIxjjhdAxRy5Sqm/
         Wohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=IuWz8CGA86V8JrozHQrsC9YnjnUYriKhoYwswk8I0is7zdi9qDZn/SFYZ+MgNAC6WO
         FTc0eiLuygM24lhd8q9Y5wx/3TQFjEnc7T2JNTxIklzxHaZFWGrFK2hyGXU1J382eKBh
         psuahr8akfGK9QGCZdJGrZJvZajrTWKKRA0pLGhaX0cHQzFkzVEtg1Lu/way8GKvH6mD
         MfxvVVINybVrM+qMp9iADbt+PQj4EQvm6PHgYGGEf+AftrS0JoVZWjdRSmL6DnWO/RV9
         LpnDlq51+FU/Lq/qdtzyleNgL00vTU9CfiS48o7jxD8e8OlggX3PcAHauXWWO7ou/e/q
         pEqQ==
X-Gm-Message-State: ANoB5pkXbbpc9eOJ34D+5Df5VF3cYABtQH8oq3ciywwYUUk4vIIfRyrt
        PJsE3Bbh3v8Du0fWRPpc+o+qYl4eRQBXzw==
X-Google-Smtp-Source: AA0mqf4WFccSGUq+2HapafJxZasZKVynBDpwiWZ/ZhLBrAGiP9gkQpQbJ0Xf+cOLopY/1jtsaTt4nA==
X-Received: by 2002:a05:6214:a4c:b0:4c6:281a:f2a8 with SMTP id ee12-20020a0562140a4c00b004c6281af2a8mr14421896qvb.103.1668526291657;
        Tue, 15 Nov 2022 07:31:31 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006eed47a1a1esm8340568qkn.134.2022.11.15.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/18] btrfs-progs: properly test for send_stream_version
Date:   Tue, 15 Nov 2022 10:31:11 -0500
Message-Id: <e2742a8d9f88ccd7d46086dfff5d861579abfa0a.1668526161.git.josef@toxicpanda.com>
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

We want to notrun if this test fails, not if it succeeds.  Additionally
we want -s, as -q will still print an error if it gets ENOENT from the
file we're trying to grep.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/misc-tests/053-receive-write-encoded/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/misc-tests/053-receive-write-encoded/test.sh b/tests/misc-tests/053-receive-write-encoded/test.sh
index a3e97a73..74b745ca 100755
--- a/tests/misc-tests/053-receive-write-encoded/test.sh
+++ b/tests/misc-tests/053-receive-write-encoded/test.sh
@@ -11,7 +11,7 @@ check_prereq btrfs
 setup_root_helper
 prepare_test_dev
 
-if grep -q '1$'  "/sys/fs/btrfs/features/send_stream_version"; then
+if ! grep -s '1$'  "/sys/fs/btrfs/features/send_stream_version"; then
 	_not_run "kernel does not support send stream >1"
 	exit
 fi
-- 
2.26.3

