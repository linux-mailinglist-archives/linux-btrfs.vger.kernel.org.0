Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96FB289924
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbgJIUJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391552AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CDC0613AC
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id w5so5351812qvn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ac1qx01ErdfXoxCL4GvK14Cn43Znmfo8Fb5I7SlNNaw=;
        b=ZPuCPVJ/paSRfPK6S3L9XUrnwNyk57xs6AxsJpfU9BCV0PaFUerOcc/iSh1lSEY0SW
         WCJEUtLENth5tWGNFhjTgtAcMXjD05fXO/t7zjrij0a+htQ+bJnyhkS7gMA0oBEtalW3
         F6QMzERRVM7oSU87hkcZEwBh0B3jsPeKdAc/bnAklx5WP6yFZUbpNX6b27JpY8oCoFFA
         VGdhVeEDO1hv5rmT5Tj4CUWkYWOpk2EUIxg26UyuWtCkU+ri+/Te6ELTbVWy6PiXIi4N
         wYUIe0iMKEabtW+2a1TCF7TWlYhg9niGsczEJaBu3ucMUpc3rt8jLvgBU0agAyNdPypE
         cymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ac1qx01ErdfXoxCL4GvK14Cn43Znmfo8Fb5I7SlNNaw=;
        b=lu81KE+32ZZKNx1l6LY7BlA55d1B5J+6/QX/K10FlIfkkQwrzUFcnmj/fbssMNQIhP
         Lm6LKOgxc+ldWuiGYh7OJdbxHpeCHFtGTkPCY254cXvzLxugFhuaL6AI2dbwonk50zqf
         Tf+VB/y/EVw6SRZHEn/rYZEBPIwyVVG8/D4uDotrgq8MG5wthQ91S51Fe2yQYbu+AFoh
         UxaPBpgNrivZLU+nJv8vSjknpmK/GaPmebrlNPLiJ8vhECMFe9rqoSJh12J8/2/ROpuy
         WukckKxBEJMjZGDr7/AZiJjK7xr/7co1O5AMPY+pvovHOTE8wUqDd3tz2hf0so9r1/lS
         OVbw==
X-Gm-Message-State: AOAM531vQkcM/i8oj1Zxt5z3hUr9MYDjgDujL0piws77Bpunj/+fb0T8
        WbwrPV1OgDMC9BBVXv/oTsUqMrMpArUJI1kn
X-Google-Smtp-Source: ABdhPJzbdxGI87U6N1UNdZGU0Rbq+ff1G3MzCFzHtlmZVi4vpoh8eLdR6BdvGr5xbccKLaxO04Y4Cw==
X-Received: by 2002:a0c:8b02:: with SMTP id q2mr14853299qva.48.1602274051684;
        Fri, 09 Oct 2020 13:07:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l134sm7130842qke.17.2020.10.09.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
Date:   Fri,  9 Oct 2020 16:07:17 -0400
Message-Id: <64b9c0fc1b1bdf7bbf8630ffa31f3f296e63ccf3.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This got missed somehow, so add it in.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index be56fe15cd74..833b7eb91536 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1436,6 +1436,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
 	print_rescue_option(NOLOGREPLAY, "nologreplay");
+	print_rescue_option(USEBACKUPROOT, "usebackuproot");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.26.2

