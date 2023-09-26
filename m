Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD17AF23C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjIZSDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjIZSDs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:48 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56A112A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64cca551ae2so55217726d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751420; x=1696356220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D//MPuNLkzciDWq9dR0jaALrWtf+3iz7sP2AlyCcVRQ=;
        b=KMQwh9l9axjwB8mxld6xIyW6q/O9O5mHNIWvQvB3EcighyRUuDI8LAgBDUJzvyEnmN
         fBuuU/TBGGGiurPVZDyRUud8CZA+2oTql6WwrQbZTIq60pUNKy+y9DXjbW9my9m949ev
         5PBc9z0SFd8hiLTBcSBrh1tKGETR5d8JwemZFrMyGnE0AxbhhWavJ94kT5J17/ZhkMim
         RiDUH8srVLGxlJUgNfUEEI9bm8TtR6cJki7PGejN4jDUKNwsWcDQJC1djFPwLSk+MDhU
         OzvSNZtfUw8XtsPGtYYrSYtshZGm8M3LkYsiDU7nL8qbpdEY7zswyMY97uzV6i5Quy61
         ch+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751420; x=1696356220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D//MPuNLkzciDWq9dR0jaALrWtf+3iz7sP2AlyCcVRQ=;
        b=K2CqXORpMTv1Us805zynCALufe2BKfu3OwWSKlujxzmLyOaM/cf6mG2qKcJCWJhDjQ
         Ng3S7ai0eBl+9PekHkUC+iSsBLP0E9V9fzfIU20eh1/U+Fp1MgY0SfO9HB4T60HpR3Zh
         /nRY1QmF/XXbhvdODG2vURKG9ji6JRklStWPe1Orvclmt3OrhM06i9GJz9vAgRI2zcYp
         necNxQ4tdQnSGidoPmQO4ybHq6tLdKRvL3aJNMg7HSJQNChWC6xkHykb0qQWTypVRof8
         GHFnOouFRzUvKhQXWOI5pMgULeKTMwr6jWVe63aF+4bOb51g/+obvb+snXTbnbG101jD
         aDNw==
X-Gm-Message-State: AOJu0Yyht6vSPWArAuB8MiEP7R290NtDUET02HEpBzAMoU6MvsJe5pQ8
        PQ+BrsjqKFwcLKwiyw4wYadKKW+IdpYiBXHoUxUwJw==
X-Google-Smtp-Source: AGHT+IHeHyWXXybZzqU0PeU94MZuzH8je++ilLv7T7ADS8MV7IzztIR/78JpnKNOKFTrstDNb/kijg==
X-Received: by 2002:a05:6214:f04:b0:655:d6af:1c32 with SMTP id gw4-20020a0562140f0400b00655d6af1c32mr13956040qvb.15.1695751420545;
        Tue, 26 Sep 2023 11:03:40 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c20-20020a0ce154000000b0065b31dfdf70sm279665qvl.11.2023.09.26.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Subject: [PATCH 24/35] btrfs: keep track of fscrypt info and orig_start for dio reads
Date:   Tue, 26 Sep 2023 14:01:50 -0400
Message-ID: <9428dcaea310bb715222e231b71e5ea39ea5d383.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We keep track of this information in the ordered extent for writes, but
we need it for reads as well.  Add fscrypt_extent_info and orig_start to
the dio_data so we can populate this on reads.  This will be used later
when we attach the fscrypt context to the bios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19831291fb54..89cb09a40f58 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -83,6 +83,8 @@ struct btrfs_dio_data {
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info;
+	u64 orig_start;
 	bool data_space_reserved;
 	bool nocow_done;
 };
@@ -7729,6 +7731,10 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 							       release_len);
 		}
 	} else {
+		dio_data->fscrypt_info =
+			fscrypt_get_extent_info(em->fscrypt_info);
+		dio_data->orig_start = em->orig_start;
+
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
@@ -7810,6 +7816,11 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		dio_data->ordered = NULL;
 	}
 
+	if (dio_data->fscrypt_info) {
+		fscrypt_put_extent_info(dio_data->fscrypt_info);
+		dio_data->fscrypt_info = NULL;
+	}
+
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
 	return ret;
-- 
2.41.0

