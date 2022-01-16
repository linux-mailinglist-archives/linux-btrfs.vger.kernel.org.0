Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7C48FBD3
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiAPIwz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPIwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:52:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED1C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:52:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v2so2250596ply.11
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fWXmG3G/AdLsle2fnK1sbGtWRrxKDcIMnaXvPH/92No=;
        b=GpJYW1GIs3EQt+SYlQux2eLjqdzoULo9vkvWgpwYBgGIjeBjvBBmgEo0WUYdAB8OCL
         5LlseI1l3WK9y7lu7aQBjFIZfNzfac+ZwCAbhfTAd8LXw0LpMYhaucps67wFYAPK2FYy
         PyXlkQlnPLW60RyrQuuDHxOD4rwSbaDOJDbCDKVCp41RQg8bh+S7laUtgIxbSteARTZQ
         zau/ybCN5U/krbWXZv2cy5PjNvE+42aLl98DwUnuUtS+HcmJZ0ogA0+lGzSP3PfOXhOT
         OB6c6zAy7afwvI6cUJ3P/gsewe3eaiH/UC1Sgo2o7zfx/IG1qo2wNmI4e3Zcb+IKvW4l
         nKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fWXmG3G/AdLsle2fnK1sbGtWRrxKDcIMnaXvPH/92No=;
        b=agRXpn81O9gzJrdPTVJANRcym/jnuSlZz6K9tz3EzUKSGbiaG+AkxIvMDW7CPW7cay
         wiEwlJ10fotvzVuhxb0h63+ZBaGf6KPxBUHTY4ZqEPHCjF5+8ouzjQ4jyKm4cztJA10j
         UtxQN618ET7Ujonoto189vr8Sy2w6FjWrEzHj26m2NnliL7a6Mb29XP4OW0LFtvPeHkp
         oiCXAtUejznHV3WP6RK61lhfsqgFOhdlsgupEkPgp/oVkdCWUKTcQfPZit7oXU5vMfZn
         2qrxfL7n6FVJlOWJNUtG9AGgX6DNWGQUPZDfUdVe+k/Sw9NRVr66SmTYGDcyY73MQTCe
         LsKQ==
X-Gm-Message-State: AOAM533AYBDlBtPdXuXoL/sccJK4mqGPU2cb9Kwy4MrvFwDNUTQF3dp9
        tlJ4p1XVzslMJC7o3BXM78Rm5PK+RNcIQeoP
X-Google-Smtp-Source: ABdhPJySxmBECDnKiCF/BqkqSTJ1mBECeJ11fdHEZdB5jV4F9isY2oczEZ6s7RfEHJEbT8UVFUua3w==
X-Received: by 2002:a17:90b:3ec5:: with SMTP id rm5mr6471655pjb.15.1642323174248;
        Sun, 16 Jan 2022 00:52:54 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id o15sm7016775pfg.176.2022.01.16.00.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:52:53 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH] btrfs-progs: allow user to insert property compression=none to file.
Date:   Sun, 16 Jan 2022 16:52:43 +0800
Message-Id: <1642323163-2235-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

1. If the user adds the property "compression=none" to the file,
remove the code that converts the None string to an empty string.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 cmds/property.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmds/property.c b/cmds/property.c
index b3ccc0f..ec1b408 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -190,8 +190,6 @@ static int prop_compression(enum prop_object_type type,
 	xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] = '\0';
 
 	if (value) {
-		if (strcmp(value, "no") == 0 || strcmp(value, "none") == 0)
-			value = "";
 		sret = fsetxattr(fd, xattr_name, value, strlen(value), 0);
 	} else {
 		sret = fgetxattr(fd, xattr_name, NULL, 0);
-- 
1.8.3.1

