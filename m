Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE24CB3EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiCCAkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 19:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCCAj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 19:39:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440AB5A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 16:39:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id x15so5280523wru.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 16:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqAe+sPqwBGxRdu+oY9Wtd7w94J15UEtgaEnFjVeyPg=;
        b=lmrCVxJMwVGb4B2gwSHdSF3Q9gAGpUIykunr2QntjZYIJZdeL89tpwXIzwnnqXJYRI
         OKth+U6l/easJSLtJg/ZaVwGWd8/bivKkfUhKTPFUUQBHjoUgKpyjWw99tYL4HWp/LGe
         x4RCm3rskTg7RYDYxBh+b7jP25LMt3XA/k5lWj8owk4A+WiU9YZwISNUUmL7RW8Xxpnf
         gfYOK85ZJ65hfpz+aQEoCElBoKibR72z/cN9+5qSUr4Iwf8gP9DCst91USIhsU4GzHyh
         tcvJ5BvECGU759+0OoekDnDwj7UudkxFwiuhAjSLr8298Ogu6wyRlZTvNbof7Dt5nIPj
         hBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqAe+sPqwBGxRdu+oY9Wtd7w94J15UEtgaEnFjVeyPg=;
        b=scPcFwlF7G9J21WDFPDscfdxG+EIeTfLVQhdw8vPBViXMwaWSzjKwQ+o1CswX1PAOr
         7mH4WxN+cpq9pvkC/ZIFlh91bzBnWzED4o9LGg6u6fEdF380czyF4i7oCo1u7za+BpND
         nUkuGNqrJ/u/XoST7PlsE6eOBCJ1TUuGoVp+EAhkEYIFWaFEhB+t5e6YbXtqc8VXnlim
         1YmpX3T+T+hs1ZPn15oc/3hTejr7SF0D+XVrpakufxL1b/LEoflCsER2iWbplHkmWAtk
         NN8ODGiF0siVe4SVZYvBZqCzKkKnanBadx4b5f2EETMxnNjTsnmmxXF9wnNlVOSZ2U0d
         NxtQ==
X-Gm-Message-State: AOAM531XQYJio38uMeQhkhN25Eyll65btDFd0fGmjyQ1PBSvJdX+vQek
        v/eQfBRvykS/Mmcw6M8xbgo9iJ9JPplbZQ==
X-Google-Smtp-Source: ABdhPJxDybKZRSBR3xEtc2+FTQ5XcVD0FviJLCpBhoOWD902Tn7AeaAr4CuIKom9TyzQW1u8AniK2Q==
X-Received: by 2002:adf:a34e:0:b0:1f0:1a15:c9b2 with SMTP id d14-20020adfa34e000000b001f01a15c9b2mr7156297wrb.662.1646267953138;
        Wed, 02 Mar 2022 16:39:13 -0800 (PST)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm7350702wmj.5.2022.03.02.16.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:39:12 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Niels Dossche <dossche.niels@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: add lockdep_assert_held to need_preemptive_reclaim
Date:   Thu,  3 Mar 2022 01:38:39 +0100
Message-Id: <20220303003838.7328-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a previous patch ("btrfs: extend locking to all space_info members
accesses") the locking for the space_info members was extended in
btrfs_preempt_reclaim_metadata_space because not all the member
accesses that needed locks were actually locked (bytes_pinned et al).

It was then suggested to also add a call to lockdep_assert_held to
need_preemptive_reclaim. This function also works with space_info
members. As of now, it has only two callsites which both hold the lock.
It was suggested to add this to be better safe than sorry regarding the
locking on bytes_pinned et al, in order to prevent similar issues in the
future.

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Changes since v1:
 * Made commit message clearer
 * Changed initialization of thresh back to the original way

 fs/btrfs/space-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 294242c194d8..3122aad03e20 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -737,6 +737,8 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	u64 thresh = div_factor_fine(space_info->total_bytes, 90);
 	u64 used;
 
+	lockdep_assert_held(&space_info->lock);
+
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved +
 	     global_rsv_size) >= thresh)
-- 
2.35.1

