Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970217A128A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjIOAs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 20:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjIOAs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 20:48:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5BF2701
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 17:48:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41215efeb1aso9596501cf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694738931; x=1695343731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Womolcib5URMwFyFAQh+64A3zCjTa6snjpP67OrY8xM=;
        b=uFdAi6XMrYOOxFvb+M2n6FRGfhqRG4jgVXHhVJ+W0T9K0GzWxKG83vFHfMEXXD9eXs
         lOhilneSoB+o64U5aLoXVQV9JDbQXhU6sp5RmVwY6vcgaEwUBrYKlwojkZLDi3Is26Kq
         nf+5TwXdbmxEVyup/Q2+IaTMssU2I44TshDvcSgvL/xMNKtI2zQxRbDIIkJ0zr19FAr5
         hqcsGD+xvNZ5lR8YUpyeceM7n6jPvyMY00k/tWhrMIiTxtlfSbPzvJ+TKcdFpI4x2Wnp
         V4sX9N9RGQvt84VD4A2JJUqjlhx9k60ACcYkc5041+NNvWNPUzKlGeTkDyHimg2q7Cpl
         8GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694738931; x=1695343731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Womolcib5URMwFyFAQh+64A3zCjTa6snjpP67OrY8xM=;
        b=eVidIqheuT+kfKLeU/r1gnsCJXqT16x8myNwduJ1PQzqQXmrVa7i8o1V68+9T+QRn1
         2Eqhzwd+FMpZtIxS2oBJ6Kr/RXkM54uHLihiMpeO/HRPuEy0HY6PNjzIJJHmnXVpKPQn
         7EME9fEpA4TFa3zfEPPXGU+CTF5QwQkUIuRdA6d1cyTKci9Bb7v0bbg8q0dNEw2UFezw
         nX6TUdrjzDC2Yfqz16BSEwfREw2m6AKb9yRaGsmiUN6XIPGacPpukApk1kCnH2PnOVHP
         5B/0r/MdaqPIlUjZ/Qf743AyGsnY2yhy+jYBgzVN0SuMVo0DlVJ5foUotZ6ObASEPHeA
         EFOw==
X-Gm-Message-State: AOJu0Yy5A1cSnN3IR5I7SEpLspwl+2ZcpT+smSKi/CP7MS/dMvoqFyxk
        nwvmecef0fyhqAPCzFWZfdFXsEXNx82P464X64EhpA==
X-Google-Smtp-Source: AGHT+IEoRLy/d8dWr3MMr5dWNOGCqBfv/m8rFpQAZWiAAHtXb7MshEixBrw1F2K3EAu4PGovlP4Rxg==
X-Received: by 2002:ac8:5905:0:b0:3f8:4905:9533 with SMTP id 5-20020ac85905000000b003f849059533mr260545qty.50.1694738931575;
        Thu, 14 Sep 2023 17:48:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id hz11-20020a05622a678b00b0040fcf8c0aaasm812977qtb.54.2023.09.14.17.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 17:48:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        clm@fb.com, ebiggers@kernel.org, ngompa13@gmail.com,
        sweettea-kernel@dorminy.me, kernel-team@meta.com
Subject: [PATCH 3/4] fscrypt: disable all but standard v2 policies for extent encryption
Date:   Thu, 14 Sep 2023 20:47:44 -0400
Message-ID: <040503c718bab5ea5a95294c366f28dcc475cc3f.1694738282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694738282.git.josef@toxicpanda.com>
References: <cover.1694738282.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The different encryption related options for fscrypt are too numerous to
support for extent based encryption.  Support for a few of these options
could possibly be added, but since they're niche options simply reject
them for file systems using extent based encryption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/policy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index cb944338271d..3c8665c21ee8 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -198,6 +198,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 		return false;
 	}
 
+	if (inode->i_sb->s_cop->flags & FS_CFLG_EXTENT_ENCRYPTION) {
+		fscrypt_warn(inode,
+			     "v1 policies can't be used on file systems that use extent encryption");
+		return false;
+	}
+
 	return true;
 }
 
@@ -233,6 +239,12 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		return false;
 	}
 
+	if ((inode->i_sb->s_cop->flags & FS_CFLG_EXTENT_ENCRYPTION) && count) {
+		fscrypt_warn(inode,
+			     "Encryption flags aren't supported on file systems that use extent encryption");
+		return false;
+	}
+
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
 					policy->filenames_encryption_mode))
-- 
2.41.0

