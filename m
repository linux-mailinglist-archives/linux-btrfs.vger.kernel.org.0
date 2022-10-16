Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F565FFE6E
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Oct 2022 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJPJ3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Oct 2022 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPJ3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Oct 2022 05:29:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D1167C5
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 02:29:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r18so8048321pgr.12
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fycnDUKd+eXDIKYLcLXM6CRwrhtVVXuyE+s/oQMr/Kg=;
        b=d02PREHe8ydmY5ERLZhdR6laYo2LTLY+pD+H4G2z5VRD5PLX32dncurn412esPlZCC
         lNk/rsncglyvAtetBtJ9iswz1JhanBQELpaeNe1hvJ9O/OMAZCku7it+dtMgmHD9cBYQ
         bqOQpcPOQQNRS2xnbwp8KAShWGAEDtyyCYA6GMpmZrduXWqQywtBUGPVIjgkGOXS0p04
         qCzZygKfKf0kmnVGsV6OQy6azw2CrtCkn7j4dg2XC1x/Hvc0Wrzp5ukhnMbMA2jbsy8H
         fqeuPvlqI19w9ikAfOyLAw21UiAcuG3IOBZPOECffaFJrAFiyDuBrzfOkS6Pfom756un
         e3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fycnDUKd+eXDIKYLcLXM6CRwrhtVVXuyE+s/oQMr/Kg=;
        b=Ra5+YO729O7lshdzuVYXk/Vcyx6P7eTbwsJW18wVCN1LevAWKHjrCLbiNvt/h92LgG
         x4HUgCvxy9Gsr2ZKIe+klJMciu08FFiiTh9xmn41DLsNGK1d2tA4ulR8snwiHzijYUg+
         woJL5PjMUuGqpIzYvyVw+rUohHBhPj1MwuCxpqu90mFtbGEx5dfTfgyclKAh+ZsgBm0p
         EZW0CPrtcG5SVyTY6PKJKg3bWQ0S4r6A00zOrlwfnBbgppf+2k7LjsAYFlD4bF0koGvz
         4xl+GjCFy7FdiY9MRuREhAV4HW6ygquoZVduUvWYxkfQhBac1wUFXUWfSH1wyvlilExa
         2r1Q==
X-Gm-Message-State: ACrzQf0UG3siFsqAB8bY6XaM2SoB1Vm0wjv3a+kbS2hjC86F11bzVIO7
        Cppz5+Jokfbcl9s0PtHkU+HyLNT4EpUV9Q==
X-Google-Smtp-Source: AMsMyM4kkDOZyxmr2jyLBn3T3Ph6Csja4w7eJ0POvypE84HnPlBSMHHCtisFHHZOGIURVlU1UrPQjA==
X-Received: by 2002:a05:6a00:174c:b0:565:c73a:9117 with SMTP id j12-20020a056a00174c00b00565c73a9117mr6582394pfc.23.1665912579135;
        Sun, 16 Oct 2022 02:29:39 -0700 (PDT)
Received: from realwakka-vm.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id h5-20020a63c005000000b004639c772878sm4197537pgg.48.2022.10.16.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 02:29:38 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Wang Yugui <wangyugui@e16-tech.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: cmds: resize: fix check_resize_args() return value
Date:   Sun, 16 Oct 2022 09:29:27 +0000
Message-Id: <20221016092927.200916-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

check_resize_args() function checks user argument amount and should
returns it's validity. But now the code returns only zero. This patch
make it correct to return ret. It also needs to set to zero after
checking argument length.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7c8323d9..ecd5cd8f 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1122,6 +1122,7 @@ static int check_resize_args(const char *amount, const char *path) {
 		ret = 1;
 		goto out;
 	}
+	ret = 0;
 
 	sizestr = amount_dup;
 	devstr = strchr(sizestr, ':');
@@ -1208,7 +1209,7 @@ static int check_resize_args(const char *amount, const char *path) {
 
 out:
 	free(di_args);
-	return 0;
+	return ret;
 }
 
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
-- 
2.34.1

