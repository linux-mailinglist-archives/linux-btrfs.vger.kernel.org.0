Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C195E7DC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiIWO62 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIWO6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 10:58:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD514115F4F
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:58:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso183768wmq.2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Yh3OpQCaoJehRHNQj5q95C9RX+gHobzAOdyLpPk5C08=;
        b=PpVj2fMu/pQ3DhGkT6BzIkzbz0EVNl5ejq9AKTBtThfK3E169Tf6L4SKBtgjZu5LVw
         Kkd4VSKKBUaYqjPl7gUtpY312wYkWQToLc0cONfgRpQRcM3bg0z5yt9pq73Ecnp0w9Dl
         Bx4tfL5yqChTjXD5pVuBsn2RtWyPZjXVjuDNNcMB4BcKCEqSnVjbdPynvHRqmSH0ZdcU
         9vbjGNkKNKuGFJm2IjufYg265YB3j9VF0CtNSWXeJJH3C0bSCPlu8eSqpavVXkHpjbLM
         zp1yJMoDfO8BVKQ0g7lVyFYGAc+hkrouDA5grPDd5dAQ342YF5a5NS8vY3iG3Bgnj5aQ
         B9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Yh3OpQCaoJehRHNQj5q95C9RX+gHobzAOdyLpPk5C08=;
        b=AMVbQVl5xWA++YvZuxk8/NT5TMTsMcL1aJPHAptLvlpO/+DSAJjx8EJgAuMbRHD+rs
         OZ2Oa2UCtegE69fRBifWn4Emjeiqn4i0itQhXVAa9wYd1ji6eDFnLbuCKn6sjz7BfOJC
         WC9gLKCyh0HZWLrT8m7W4/50YPCRIF7DgBCnUNtjaO8I696aATJC6zQrOdoMpeYyEvO8
         y65uXhTyvhrbqXshsk1I5QVpMBNv2OWwpKFPVdFM7XpxDIqiTAMi8GMQJdEyzDn8/Sdr
         XkYN6e4eQ8Z18Jv9f3Oiuh30WUB6lLOHJjS8R4wJNdbemRUfeC633tIsTURVfaEar5bh
         +00w==
X-Gm-Message-State: ACrzQf35kOcX6/Duz7dmcqqxt3xFAwg21+XxpbfsDIw4Vjk6eSc32b20
        YmLZ3+ZMmp3bcy6FSfaSPS3qgcFOo/mp4jIQS/oO3qU5IY6ZIw==
X-Google-Smtp-Source: AMsMyM5e7NySKByMMbtrEvIiR0FtkoIZpeBQVS+vINXLTaSX33Y8YfD/ncIDCJrZdSvYd0oAsGU6/WdTXs5oKqDvgJo=
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1dd with SMTP id
 h17-20020a05600c351100b003b4bb85f1ddmr6290620wmq.42.1663945103521; Fri, 23
 Sep 2022 07:58:23 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Fri, 23 Sep 2022 22:58:12 +0800
Message-ID: <CAPm50aK090Ebkg4aVqzBxaN1W-=_z9ZU7KxppmURhWeczJb2Ag@mail.gmail.com>
Subject: [PATCH] btrfs: adjust error jump position
To:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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
