Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924544BBBBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiBRPDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBRPDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:49 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015123C848
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:33 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id d7so15233818qvk.2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sak7ORvKv5zRFK3M1OHTuzhqbmVDL0prtexzCMNEGpY=;
        b=OU+GB7LLgHTqvAwwKX0U9frcnkBFGHP9m2OEmU+Crk1sbWkT4wBCc+QaYVevt+XGZB
         eiiDjis7CxMviDwyV7yO0R0s3AW8DRf+O58uLS0IVZPj6ZdSepBcNyGtOQqOXSClrv/D
         qyA3piO6xYxJSFAN4imgulEnOluPE7KpZHAcvOP339ygKWJaWgF4USvdrDFeEMGAqRW4
         VHHLOTL9WWUcVkEqZVSN2AXU1+gmqPoQ/4DMegeAu6G0Pq+0MnujEQT62iJD9+fdw5pQ
         Lj2qReHK+klI3LsvgH/SA1pXenZVDOQH73h3XsciIQffE3hiy9+cf9sLdapCxmUz7VcC
         YDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sak7ORvKv5zRFK3M1OHTuzhqbmVDL0prtexzCMNEGpY=;
        b=dhasXQ1L8EqfzKejLckz87AncW1dxxdPWd3gpfnKOf7p6sx9fDEhUVWYM2ZXkM4SYs
         FY9riQdkbNY1OkcLcoepeZjoEQ/ZZLT+H4e+E2IKLWqmHwIMZJoYmo0EUMatjmspso/Y
         7cbL2t3QSMJR8O4a1ASnq1LY2NvSDEmAcjYz4ABP00/b/DbJOwaQ0JC72ih46y8LaKHS
         hr1FP6N4jBNe4h3QX3CrPtyx+1ssRJIbeT4V5wp0bdW1Uez599iko00zRxKnWz+Y6Sf1
         B0jKs/fAaMM2r7jEKboZx6IhsPVrMX+gnGiM6BvvCy9C5JJd2Dcg0tySTArp3ePnkh8r
         FbJw==
X-Gm-Message-State: AOAM530qEoJtlCe0WTZ7SEIYEL60QbcnnMHQ7hbg0lfINzEA8XPscTmf
        JtYXuHA17SZEzPGSfgFOYiElB1fcyUErnISs
X-Google-Smtp-Source: ABdhPJyEauWrrOvbtXynOp6/QUN4RkGsCzrBJyeXYeeeqcvSHVw9Tt99ztqAiQd4axdZu4kbFXJ7Ew==
X-Received: by 2002:ad4:4711:0:b0:42b:fcfa:a2ef with SMTP id k17-20020ad44711000000b0042bfcfaa2efmr5985233qvz.68.1645196612084;
        Fri, 18 Feb 2022 07:03:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u21sm24794317qtw.80.2022.02.18.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/8] btrfs: make search_csum_tree return 0 if we get -EFBIG
Date:   Fri, 18 Feb 2022 10:03:22 -0500
Message-Id: <ab01e07c1c1ca420a69eae4d4676c05a7a2ca9f6.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
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

We can either fail to find a csum entry at all and return -ENOENT, or we
can find a range that is close, but return -EFBIG.  In essence these
both mean the same thing when we are doing a lookup for a csum in an
existing range, we didn't find a csum.  We want to treat both of these
errors the same way, complain loudly that there wasn't a csum.  This
currently happens anyway because we do

	count = search_csum_tree();
	if (count <= 0) {
		// reloc and error handling
	}

however it forces us to incorrectly treat EIO or ENOMEM errors as on
disk corruption.  Fix this by returning 0 if we get either -ENOENT or
-EFBIG from btrfs_lookup_csum() so we can do proper error handling.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9a3de652ada8..efb24cc0b083 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -305,7 +305,7 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
 			ret * csum_size);
 out:
-	if (ret == -ENOENT)
+	if (ret == -ENOENT || ret == -EFBIG)
 		ret = 0;
 	return ret;
 }
-- 
2.26.3

