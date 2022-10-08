Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B442B5F82E9
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 06:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJHEHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Oct 2022 00:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJHEHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Oct 2022 00:07:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC45D0D2
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 21:07:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so9792551wrs.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yh3OpQCaoJehRHNQj5q95C9RX+gHobzAOdyLpPk5C08=;
        b=onhshFzFDlsd8pQS58rRbHkFGSR0IhF/U4rcRDa7TMaxflHXdok55xxLkQiti3wsKS
         0OARUohxPRtZHAB/n8tbsjM8cHempDQORoOsEI9MAfNbkyRezOHf9z7xN9C9UOxQIJJb
         ZC6T/jGfRTk5bYqGnq6Uxpb1uIjgpYzNZdmP/05YPrkSPrHe1NXI5XhgXG3hegheoVnD
         Wy7sF8a+BlO0KUW8d+CDlaBUwJq9eNWtETa7jeEG5RtbfsRHgFGNoBPqYpg5UO4aepcJ
         5WlyWpSWFCtSwGFC8K3xWJZ4Q98ncKyoH8t4MS1yHTyg3c/GsYEc9uBkq06iCakCAM0G
         pSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh3OpQCaoJehRHNQj5q95C9RX+gHobzAOdyLpPk5C08=;
        b=SB79mnhyMdzO1cfEUHHDSDJ3N95NYKJjcOojCBjqwiPXSRtoUygQErrmbdv44oKie0
         j4GiTd28Ii0gI0WAeAXnkT0FfVN652mRuPcNXzLOFbjgieN5lIlGIkHbtAbOyNhArFxm
         7aTph6sbJise1hb3nggOOFMqcFYE0dM6SwSxZhXNRCP63oAisyhihqkYLpBFn5/RKLxD
         ZPdTZbc1H66eljq9j2G3jwpAdlR/48Gi5QFT4L1RVAVj3o5qtr0oRcteKoz9QuuFxxTu
         Rm5xTmdr2EVW0Vm5kS00xEULPDvrHhrOlb2ouXyqZbRem7z1K/I/btHvnMgzVobH2kEN
         MOjw==
X-Gm-Message-State: ACrzQf0Kvf4ZbnpcGbL5MsGSHoDgyzbnH6W1+egOdNYDVVpJyF1F4y2j
        EB7l12hlclS/DpX/1xzmz5R8iS/O4YaToF3c0tWQjnllrMWoNA==
X-Google-Smtp-Source: AMsMyM5qhwmxB+oqNDd9mWm9VBiH3kROqnP3gqRXLQQnfdVu8gcJOIZtdCWDNyOMt81pzIVPIkxW54ikAeXsqfbnBzc=
X-Received: by 2002:a5d:59a7:0:b0:22a:47e3:a1b with SMTP id
 p7-20020a5d59a7000000b0022a47e30a1bmr4903399wrr.319.1665202028960; Fri, 07
 Oct 2022 21:07:08 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Sat, 8 Oct 2022 12:03:39 +0800
Message-ID: <CAPm50aKjtUtJCyprRvzU80Pj+P3uQ7YPdoEygoc=RBQEEsu6Xg@mail.gmail.com>
Subject: [RESEND PATCH] btrfs: adjust error jump position
To:     dsterba@suse.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Peng Hao <flyingpeng@tencent.com>

Since 'em' has been set to NULL, you can jump directly to out_err.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f0c97d25b4a0..b5c408ed888a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8146,7 +8146,7 @@ static void btrfs_submit_direct(const struct
iomap_iter *iter,
                if (IS_ERR(em)) {
                        status = errno_to_blk_status(PTR_ERR(em));
                        em = NULL;
-                       goto out_err_em;
+                       goto out_err;
                }
                ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
                                            logical, &geom);
--
2.27.0
