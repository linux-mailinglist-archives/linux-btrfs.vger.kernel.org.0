Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502714BBBC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiBRPEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:04:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiBRPD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:59 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71DA29720E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:41 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id o5so15245785qvm.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NtZKz7Cx32aQtLDiD6WEsghbMySEkMy834upsIG5Ac=;
        b=jGP03yQhOGVaITvuwqoAhM2D8809frFpO5T8+rbD3vyMvQ96b6FyqhIv/rXF3dr2+j
         TvlWo3/BXfu/KEiRU1qUSlhDvaKIlaqlKo5G7FIOBcNK9A+J433nyy2hpY6NU2zYxPA1
         r3bHSuYbDrqybcIFqKlCoEVbJ6gvf9Lqp7j+bTBz89sn4a6zup2+28OZkZLe7VsjqhYQ
         mt0Tr1vxAiX+AxzaDa/RhINkLgSymIyk0F3zI+3kAnyTE4PEehEO7Cw3Jd7hicl6mPJX
         aJqtHI67R10SqY0/3liBcMO00EZ2DW5D4opsh5uQsyLFb6I5S1Gj/f2Zg1JTkDpwGd3C
         Rutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NtZKz7Cx32aQtLDiD6WEsghbMySEkMy834upsIG5Ac=;
        b=J4tTqleW4cAdTjjpmqW2Hbb5L9AdpMmYWVViWQzJEbdpMv1ttc8VyWNtgWo7DJds9p
         rvh4QR88GJafCTKyWtcHX3CmItsQXdpgBolMMC8fsax/SzwaSij/41Zd0CoB72WGGtOc
         4414nNKY+Jffdmr09meC601x/GmgZ1YGIGm4gj9EbkSL4J4G6m/WwaUfnr/ShLThQrjb
         BOi00Z9rtsvGMn7SuVXvVLwiBuUlvZIjIOAMS1fgCW4szXF8A1IEPfr8n/Gw4gMNcOxk
         JFYl0/iUALgMZtcXunCXyt2wyKCClCvalcn9bNUQXceyXeZYkT93SVpLu65wp0TYPAaa
         GstQ==
X-Gm-Message-State: AOAM530ZxsGV/cI/voYsGMRjBnOYm5e93IGvLr6HqxYrtCVXE8/LNkUl
        fLqeQM/86bjLZjBqPTrHod7v3PS8F+DRu1Ip
X-Google-Smtp-Source: ABdhPJy0DyVv1BsfeVWhaW2ORfPaXDP1NAMiFQ9bax9mZPnPD2xpIqieIXDszs4XM7noGDKSFTwp2A==
X-Received: by 2002:ad4:5288:0:b0:423:ba8c:8d4f with SMTP id v8-20020ad45288000000b00423ba8c8d4fmr6147252qvr.129.1645196620769;
        Fri, 18 Feb 2022 07:03:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w19sm19424439qkp.6.2022.02.18.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v2 7/8] btrfs: do not try to repair bio that has no mirror set
Date:   Fri, 18 Feb 2022 10:03:28 -0500
Message-Id: <a50b65b8ffe49f798825d7fb433a8f2336bb08c1.1645196493.git.josef@toxicpanda.com>
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

If we fail to submit a bio for whatever reason, we may not have setup a
mirror_num for that bio.  This means we shouldn't try to do the repair
workflow, if we do we'll hit an BUG_ON(!failrec->this_mirror) in
clean_io_failure.  Instead simply skip the repair workflow if we have no
mirror set, and add an assert to btrfs_check_repairable() to make it
easier to catch what is happening in the future.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bda7fa8cf540..29ffb2814e5c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2610,6 +2610,7 @@ static bool btrfs_check_repairable(struct inode *inode,
 	 * a good copy of the failed sector and if we succeed, we have setup
 	 * everything for repair_io_failure to do the rest for us.
 	 */
+	ASSERT(failed_mirror);
 	failrec->failed_mirror = failed_mirror;
 	failrec->this_mirror++;
 	if (failrec->this_mirror == failed_mirror)
@@ -3067,6 +3068,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 			goto readpage_ok;
 
 		if (is_data_inode(inode)) {
+			/*
+			 * If we failed to submit the IO at all we'll have a
+			 * mirror_num == 0, in which case we need to just mark
+			 * the page with an error and unlock it and carry on.
+			 */
+			if (mirror == 0)
+				goto readpage_ok;
+
 			/*
 			 * btrfs_submit_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
-- 
2.26.3

