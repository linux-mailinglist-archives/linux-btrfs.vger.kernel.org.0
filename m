Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A47C412A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJJU0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjJJU03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:26:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65599
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:24 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso6436973276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969583; x=1697574383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqxbcnQrbhAM79ZT2haRQaI7x72trapZ/1y8f7sxESs=;
        b=aS+N6wlx+xKjokk7uje7jRN+GUm9S32+PZl4PCyqodSss5ROHhjsxHKsnHLbmVdvBT
         Lpv8aF0yPcv57/PdTu8W5AdU7EXU6ascZIXSTazTC5pawmzJjGXoAzdneEawIqf/pp+A
         MVtjSN/YA8wnF25MU6VQS8EyDLc4QHb7ZthTjzOr7bBQFG2DVFAunEqNpA3v3VPAdl0n
         UCy/ZGWUyqistraaqgbIxX6DFBDxrXClMA2rw/+ir9L8D6FuvadAjNfl7BqYlzD6A1ol
         qVWuh4XLUDJZweSpaIy+64miGup3zOmb0zQ/ss7U9ELFfQefpDetIPkRdJQ6kAceEX7L
         rr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969583; x=1697574383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqxbcnQrbhAM79ZT2haRQaI7x72trapZ/1y8f7sxESs=;
        b=suH1W+AoSVGuLAWvn4OWLXV8uM2XVvGhIj9HL0VDx0dHTZEDUnh8yT1jyinDRZSsUJ
         fBrFuvzNyBV0zBD09hE+IrTH68sbo8X/JJkhw6oMRwtsmrRiqrIeNZvw4UGOqtp4Zcql
         Jc7njzFV/nT61J4ilEoyjJOBbiy56mV9byf6TCLR6g5Toi2U4aMKiw8EQttD4Fhm4h+0
         AlT/9yI7OKO/dadjWizoRsi84IWIvOfN9Eh3pf26mSokvbMuA4wP+F+uR5p940f6Bnc/
         +0KPL92J+4mAa1/dNn7hnk+DL9e10j+fcWVZH0T1XWysDG555ZkMJR5jU9ZYcF4f5U8A
         jHzQ==
X-Gm-Message-State: AOJu0YwVtkxnOVYV5r6a6bKUiFFaB3dI1eRrGM96+/ui2jm3spCyJ6Me
        lojsdX4AEBKFObBb5HrNo7izfg==
X-Google-Smtp-Source: AGHT+IGw4kxDsOt6fa8BJi9L1FMTAuWa4xVaYHP5ZOTb9sMQ5tRzZ10wUFt1F7QiR+ugdbA5JanIRA==
X-Received: by 2002:a25:eb04:0:b0:d89:47d6:b4f9 with SMTP id d4-20020a25eb04000000b00d8947d6b4f9mr16849727ybs.23.1696969583309;
        Tue, 10 Oct 2023 13:26:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 85-20020a250d58000000b00d9a54e9b742sm748139ybn.55.2023.10.10.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:26:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 05/12] common/verity: explicitly don't allow btrfs encryption
Date:   Tue, 10 Oct 2023 16:25:58 -0400
Message-ID: <24a79bf71c105ebcff42868cdc7938022ca145d1.1696969376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969376.git.josef@toxicpanda.com>
References: <cover.1696969376.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Currently btrfs encryption doesn't support verity, but it is planned to
one day. To be explicit about the lack of support, add a custom error
message to the combination.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 common/verity | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/verity b/common/verity
index 03d175ce..4e601a81 100644
--- a/common/verity
+++ b/common/verity
@@ -224,6 +224,10 @@ _scratch_mkfs_encrypted_verity()
 		# features with -O.  Instead -O must be supplied multiple times.
 		_scratch_mkfs -O encrypt -O verity
 		;;
+	btrfs)
+		# currently verity + encryption is not supported
+		_notrun "btrfs doesn't currently support verity + encryption"
+		;;
 	*)
 		_notrun "$FSTYP not supported in _scratch_mkfs_encrypted_verity"
 		;;
-- 
2.41.0

