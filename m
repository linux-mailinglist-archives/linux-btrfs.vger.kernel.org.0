Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D326E5C5E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDRIpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDRIpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 04:45:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EC635B5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 01:45:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b8b19901fso1020279b3a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1681807532; x=1684399532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXHb7zcoIMcah9OhL0EsZJ0KcZpsv1nGgP9EmVCgNf8=;
        b=R39QhcZI7kk1jswQOY0R/ypr+OIiUJ0mU0gXmei0odNwcegReAiHw8+Be5X5SDKXO1
         aJFkVlNY9Scx4adwjaAPseHHzU0OEUdSstnv5+op9SrVolJJnWyf6e96xiWofLKyNAxn
         eULkVrwQcxv7tJJ2qnt9YpL1+1Ak/X4mOdatDBgF25epBgE1X6NanznyBFKWUoves73F
         lrQYhHV8LMGXVLebNTe+p1V3CAtLHiDRmjlNqyRRoEfZfPYM/Mgeq3/2djX3gBBOVlfc
         kHqThgI5hwt6eprwMCVaFpDQwHqQm014czmYyuX7b0g3nUH3xbIEWPtFm6Pu4eKhFGc2
         gLGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1681807532; x=1684399532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXHb7zcoIMcah9OhL0EsZJ0KcZpsv1nGgP9EmVCgNf8=;
        b=Hu4hKEOhnxdv+zy2noZHN14cYk0VnxyWgBWQlIdRwzhmL3jM6X3lAgT3jRXrZclkEI
         3zQnmQvpduY6dPasJNQJFkKiUMFzB9HpQOgfMkxM6hoM9X7taS7sBl2gZgkNJPac7B8S
         gcx36ZlKxSuhAXAd20CmCT+IBxKDreCnNL0vqfYqoCM3p1IyQiPrllcvxmkAqLvKZyUr
         jiQVYoTj42+P42T1z4bS2/iwTn1qDmiI2TAAs93+C2s+6pjJduCL9ag6Yg4tvfjm1cUC
         e1AIrhHqMYIDVMfaExBnI5COFori9cdlGrVFNEXdYmJTgYk8xSk+27ls6Tyrb+9kb6h6
         weKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681807532; x=1684399532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXHb7zcoIMcah9OhL0EsZJ0KcZpsv1nGgP9EmVCgNf8=;
        b=iYzFU7uDyJJ0TRgGvIdfdMsfNliblzet81XNXxhmpfjav+8HbVmj2K8BHCJ+AtsRQx
         IUzict+Bqbw8Rnvnu1hhOybTO7+MkulujKb/Y0bZX8Y+IuZEaWdG0/WkDPndL5eBZytZ
         u2/po+7xj5tCTIFuXQJLdAu1Vvcpvj/6Imd3agJbW0yq6IyYqKnqXRBOY3zABxsIG3E5
         9I1GB45iXvdV7MHl11nTml2In4Pd/d3o7lp3WyoJUcHCCxKYom2lZJ/icXoKKgsKRU73
         fzaLJ9bEj1h/xaaIkt2A0Bc1bnb1pDO6vbqoIPOiVlDBNdVEWOQ2mHoR0dN5DsnfO53x
         5g8w==
X-Gm-Message-State: AAQBX9fvSoZmcwF+ZRHeZkAcoHHyC0vm4MzGjEVyZesFFgpaSPKzny7L
        BmqrDk8070MXWeu3A779dDegyMezIp5ZntU+VSjz9EHmVYshcGJOtQClmm0Od2qqGp5OOBOiAHX
        aLwRrahkDQofUBaB9A3grxT1KQL28PsPpWq/OnyA6E30NYhyGfYmM0stM5CsSddnoDbGBo3IBYA
        wwLbadNXeYJsse
X-Google-Smtp-Source: AKy350ax2x27iWYTMQVwQOs7tU5Dz3GxDwfEGS72ezAzZqDAaJi9A5fsd9kxaeweQ/3/4PZaht1MYA==
X-Received: by 2002:a05:6a00:c93:b0:63b:8df5:f8d with SMTP id a19-20020a056a000c9300b0063b8df50f8dmr9863587pfv.3.1681807532020;
        Tue, 18 Apr 2023 01:45:32 -0700 (PDT)
Received: from naota-xeon.. (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78c51000000b0063b79bae907sm5598523pfd.122.2023.04.18.01.45.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:45:31 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix bitops api misuse
Date:   Tue, 18 Apr 2023 17:45:24 +0900
Message-Id: <fc21b3d5ddf062b746bc55425672969f897d685d.1681801005.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

find_next_bit and find_next_zero_bit take @size as the second parameter and
@offset as the third parameter. They are specified opposite in
btrfs_ensure_empty_zones(). Thanks to the later loop, it never failed to
detect the empty zones. Fix them and (maybe) return the result a bit
faster.

Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2b160fda7301..55bde1336d81 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1171,12 +1171,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
-- 
2.40.0

