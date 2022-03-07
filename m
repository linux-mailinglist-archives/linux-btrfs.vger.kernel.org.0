Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E843B4D0B3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbiCGWiS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbiCGWiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:10 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C636158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:15 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 85so5233230qkm.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ajCLA11gT1QtAo1A+I7az8R9MpOAhtGJqs4HuqYpc/E=;
        b=5hv9FD1Ce60tCYcF2Ytfoxa7PL9pwxDYc4KnzYubYJlmIfXW9MC4NJfrvnhOYt19yX
         07is/vanpMznXqr80/B+jqwVEeptK2zcK7bhrA2Jj0VdmGYD/whj5toD3+6SDwA59eEf
         wZJW2IRA/vaESHs7ylGumbxM7ragXaR4VS2n/H5PvGBsyIXKGiiyLqF7XfXIjp3b68io
         krZVwDeSPlQXiRCTQRw3uzlb+Ne7PTCp8TfOjW8apksjpPoID22NBFrZucR6TMK4Q3WF
         M4hfHBF53gtgR8BCHDsXjoEA2vYJm+63GgiFU0yPBeiHgTil+FyaOM2ixXHuqJTovscx
         LBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajCLA11gT1QtAo1A+I7az8R9MpOAhtGJqs4HuqYpc/E=;
        b=LaK8IEZNVDTgHB8zPM6aTHE2+SUptouTNIEPvg6DDFfMvNLYXoincLaLJojpMHaVlI
         Ah7ABUVHW0w1TE21BrnQjBuujkaRvk4DJMrH4TgEgAmvvmvRYdlkPNIqaE5SmwyN9uxW
         9yZmMpU2znKlP9iHbbmjLFtET2VuvjZ1i9/Npr2eTevYRTJksaGr0LmJkE013pjm5kaZ
         ZfjZ9ycInR7lq7wMMmoYf8SriaXNKWxsHQe9p2EGzD7mSrts2fpTzUwqTTZ+4yQGVOEn
         pBSAtEN31OuboAkifDFbxqpj7owWK3bxzYA5qU91EZR97nYlTMJ2eBKHRyrl5ELVxEZp
         axMA==
X-Gm-Message-State: AOAM530fwYK/SdqlgScOyfKYDBn8L7w2ajBw+HZYHwKuR5c5UqtLsAlR
        ctvXGp+RzV2htTUbI/rMUN5T9qrDm8kw8AM0
X-Google-Smtp-Source: ABdhPJywfYx+RCPnI7XrJixOODSSQQ4d+FCFqX4ueqzpB7Q2XVDJ6NK3bDGXZigWbP1irLirdZYP/Q==
X-Received: by 2002:a05:620a:c55:b0:67b:3e7:b033 with SMTP id u21-20020a05620a0c5500b0067b03e7b033mr7222478qki.9.1646692634200;
        Mon, 07 Mar 2022 14:37:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i20-20020ac85c14000000b002de4b6004a7sm9380801qti.27.2022.03.07.14.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/11] btrfs: add a debug range check for header_v2
Date:   Mon,  7 Mar 2022 17:36:58 -0500
Message-Id: <2d74a1a84f8b2ed6c3a6ba594fb75ceba54ede59.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

There's a few places where we modify the extent buffer data that I
missed in my initial conversion.  This check helped me catch the places
I missed.  Simply check to see if the eb has FLAG_V2 set and then make
sure we're not overlapping access with the header_v2.  This will go away
in the future, but is handy while I'm working on the code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 31309aba3344..88dc53595192 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6736,6 +6736,25 @@ static inline int check_eb_range(const struct extent_buffer *eb,
 	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
 		return report_eb_range(eb, start, len);
 
+#ifdef CONFIG_BTRFS_DEBUG
+	/*
+	 * Catch places where we may have the wrong header math, this can go
+	 * away later.
+	 */
+	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_V2)) {
+		if (start >= sizeof(struct btrfs_header_v2))
+			return false;
+		if (start == 0 && len == eb->len)
+			return false;
+		if (start + len > sizeof(struct btrfs_header_v2)) {
+			btrfs_warn(eb->fs_info,
+			   "access overlaps the header_v2 on eb %llu start %lu len %lu",
+			   eb->start, start, len);
+			return true;
+		}
+	}
+#endif
+
 	return false;
 }
 
-- 
2.26.3

