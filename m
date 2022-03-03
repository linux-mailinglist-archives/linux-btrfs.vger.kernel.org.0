Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441014CC9FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiCCXUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiCCXUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FD15DB3A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:26 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so6291139pjb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tReRS13ZknTO9C24t31RpzlXcQLneIA5Zqr6TCVa0D4=;
        b=tuUAV6Tj0tEDhDbuowXQ84HUHAS9rakT/h8JFMtWzNmvQL7WejCXXBYkaqKCZFxgpH
         LvBDpb4A4Bu5MyGNH6G0d2SeEdbhDG6Z7n64/hFKxFJ+/sZa1AdhjspLMQ9QiyV39aW6
         35sQRW2HC4rLMfE7hHsjuKorwXris1gy2Dw2GshGW7/JbSn/jxBTqItTcKRIyz2g0UAA
         9PBLQc+3ik1ONdM50HK8JZhQRj8NP5O0bqY/Cyc7F3R3J47m8h8ZAycbKvGzJ4RygAvZ
         4O/KyIWjKsbIsB7vDLwLDTkR8Tz4KwhwuZf39hsL509gBlCKRGvPwbv3FP1JsBgqFS/y
         QO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tReRS13ZknTO9C24t31RpzlXcQLneIA5Zqr6TCVa0D4=;
        b=yrE+ck5RlockI1QNdMgx/b00PcPlYFbyw/U4f0j2lubLwlm3RuvYnu1dr8tk75xKEq
         czKrtJfQmAGL0r/C34QQ5peeMjV6ThkBPVhr6w5dfYw5KqrWZewCTyx6acgNRJNbjRbc
         7wCB9S94E3a+zX2AVVnEFT9hG30WSSUChj96kYODwc0tdan80hmo4+tag2/+5aHiozX5
         jdeK0cpnZ0+pI1Mx0Ll+c4Jj2aNUAco0BtmX4RUN3vCUEC/6EIoVklqiY2vwAnBRlJkF
         Ev04UQwgX5h3fI7En/XZ+f8oIYoTowd49HnbIfISpG4bx5ejQ13XsxkJbycsaEBOav2X
         xWmw==
X-Gm-Message-State: AOAM533ZN93BAjUvFFFY1nPB5REAA2ofhoSqX2iuXxHpWe7JEvprAB8A
        Pddp+5lZ0jSBlDuHpdJvLewmWFo8Soo1Cg==
X-Google-Smtp-Source: ABdhPJxoKaZYLPXLgl03n5Qe0cFrWwOpl14vm0hV4QhEUTGDe0km00I3Y2uy37GH3Y9U3bQ9PoinFQ==
X-Received: by 2002:a17:90a:5505:b0:1b8:ebd4:d602 with SMTP id b5-20020a17090a550500b001b8ebd4d602mr7688457pji.147.1646349565504;
        Thu, 03 Mar 2022 15:19:25 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:25 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 05/12] btrfs: remove unnecessary inode_set_bytes(0) call
Date:   Thu,  3 Mar 2022 15:18:55 -0800
Message-Id: <af52df4e9745cef933f5bd877f466e4ac23f29da.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
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

From: Omar Sandoval <osandov@fb.com>

new_inode() always returns an inode with i_blocks and i_bytes set to 0
(via inode_init_always()). Remove the unnecessary call to
inode_set_bytes() in btrfs_new_inode().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 244e8d6ed5e4..b7d54b0b2fb5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6207,7 +6207,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 		goto fail_unlock;
 
 	inode_init_owner(mnt_userns, inode, dir, mode);
-	inode_set_bytes(inode, 0);
 
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
-- 
2.35.1

