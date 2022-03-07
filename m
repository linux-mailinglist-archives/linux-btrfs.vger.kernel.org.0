Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A534D0AD5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbiCGWSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbiCGWSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:51 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53139403E1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:17:56 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id r127so2280476qke.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yC0y4G0klsx/QK0E2hnXoBQOCIXJqrM2tzAT+Oq2hgA=;
        b=tCY8emB5QUYUpcaAj/4TR3Cy4FQMUYfRCbjul+19XvURPK9CALe+8qtnx/Tg/Lvr3g
         9rfKldjeMIZU+OUVmm+v45hnE5+hAmhlo1qYPyUqew5t29dByVsG2vtW5eDeQ/ihUXj5
         AYNvAk9hyBQ5qmtRQJUDhLiYZDCVd7fxJ07uh08s3v3SCD5JHnbulRe5SpChAOZNC/tC
         e0rfuNQLRlR9OGk2MKSJLGAkuS9HAklUB2OVMuBlGNNrc6RIUsu889fdcKreOg2vSyY9
         8FRXiH/MpU7FTr6sCrJbRVkywgfg6pwOcgy5PPP9+sccedhqU/I0k3Ux8iw3a3wKlDQl
         pMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yC0y4G0klsx/QK0E2hnXoBQOCIXJqrM2tzAT+Oq2hgA=;
        b=Yd/p3dZPwzCr58i1j+PNf+CxJubv0bFMnUDKwPve3GexbVv2xQI+Yhgf7hqs1S38gt
         UtoSxakgutnaR99TAlwB7OWUvwWoTAj1/VNWALfesnGKEsdM/IvE0tK/f7bsBmXZNNky
         +/7tgsm4Fd97imJc2X1zQ9BUCzcPceWNb73KNZbBtXsLIKYec4z1Goshdu1Ip7QpiVpg
         aH++R+Za6PaNFFnpncitmUVuZISvpD6bBQghWpxS905B1JauSxXm7UE6rXdPSFmEEyyE
         7e2d+coWf6VjDp/+a0qxdUF6/+EeLzf/D0SZC68sQPYcv/sNtE7gS3aRG/rsywPcGGIj
         gI0w==
X-Gm-Message-State: AOAM533mb24tiERRm6SNJ19E5iC5H9H9nN1bWK2nBCdBIFfp+L97tU9v
        1cbmhgXUm6gJ5+H6YDS7xssrl674Xsp8nPi1
X-Google-Smtp-Source: ABdhPJxBNTUj1kw+YLwpmrEAwcG/cA/35XTmoSEuSXpqno7GMnzbDoWkoFE4T5BW6DedAac3eBFi5A==
X-Received: by 2002:a37:ba07:0:b0:47e:15a4:231a with SMTP id k7-20020a37ba07000000b0047e15a4231amr8421621qkf.472.1646691475184;
        Mon, 07 Mar 2022 14:17:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w7-20020a05620a148700b0067b1ee562edsm2134935qkj.100.2022.03.07.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/15] btrfs-progs: image: use the appropriate offset helpers
Date:   Mon,  7 Mar 2022 17:17:37 -0500
Message-Id: <3b5c0bc05855fbcd999f75019585d24c5f491efa.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

We are using the size of the ondisk structures to figure out where we
need to zero out the buffers we're copying.  Fix this by using the
appropriate helpers instead so that it's extent tree v2 compatible.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 image/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/image/main.c b/image/main.c
index c6af0cc2..600fc360 100644
--- a/image/main.c
+++ b/image/main.c
@@ -355,7 +355,7 @@ static void copy_buffer(struct metadump_struct *md, u8 *dst,
 	nritems = btrfs_header_nritems(src);
 
 	if (nritems == 0) {
-		size = sizeof(struct btrfs_header);
+		size = btrfs_leaf_data(src);
 		memset(dst + size, 0, src->len - size);
 	} else if (level == 0) {
 		size = btrfs_leaf_data(src) +
@@ -364,8 +364,7 @@ static void copy_buffer(struct metadump_struct *md, u8 *dst,
 		memset(dst + btrfs_item_nr_offset(src, nritems), 0, size);
 		zero_items(md, dst, src);
 	} else {
-		size = offsetof(struct btrfs_node, ptrs) +
-			sizeof(struct btrfs_key_ptr) * nritems;
+		size = btrfs_node_key_ptr_offset(src, nritems);
 		memset(dst + size, 0, src->len - size);
 	}
 	csum_block(dst, src->len);
-- 
2.26.3

