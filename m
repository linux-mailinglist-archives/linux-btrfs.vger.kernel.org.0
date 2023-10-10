Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429957C4170
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjJJUlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjJJUlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F3AF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:09 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7db1f864bso2044087b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970469; x=1697575269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrb2x4Nys7RjPe3v/rGBGWIlt1Z2rhPrxm8XK7K5cwQ=;
        b=m15I01bX++RnRJ2N6taEInQ8ysuvzm5drw4IvDneNm0y35/ESqV4aFEvWWzL/Cm6RY
         GEAtzAR+9aj6ih/+RUbcPnvZj6oDGj7tCKb5ITIFxr44LlegRM4ff6cvNkIftoiBFT4c
         d2j6IeLh6bKT1tqJ7oPXFX2x9w2MdrwlPWNfr9n87RVs0i05LO2UEPMLad7bdQWAxmlE
         Vo2NuQ9TO2QMGlsSuENGttx29QRx+RDj8UlNVRel8G3HFEEuTdrBXNNdTlvvowRV37JE
         8m+fkDb2bH2piMbXm7GrNTsAJloAEDTdTZFYWjKpyQB4qy5fWQpJWHWaAWaeMZGFvM+/
         CpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970469; x=1697575269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrb2x4Nys7RjPe3v/rGBGWIlt1Z2rhPrxm8XK7K5cwQ=;
        b=gqIvg+rJA1raVXcut9y4iEj4oFWyxpX5XSV8+fJajVwWpUQ/uk+3lSVuOHVSo1wxPZ
         y9Pc6o4ra0OT+y9RSeca0L6NtAdS1KIxvWEOsFnFuV+iCLb4vtOs4e31HggWU0FZkchh
         er42JTRUI2f0Er+9WUnh/d78ae40niXiEJr0+I5oOC/baM+uHQCSDMTKouH7qxXYGU8V
         ZbkhHyVEU5nWD2qJ4lDwd0JesekQ88F/U5dk/IVpF+1qK0SW+HEaoj9cV7vchlyw0+6w
         R/c2WHiujryFPmHUqC8TrjuUFoHG6rs8t21snpLMdMQva0hhLIsdgLffd8BltaVBDIk2
         gHnA==
X-Gm-Message-State: AOJu0Yx2KDjQIn++BLIQUW0iJFMCzhh8IM1Te/jxlZrhaKUKiVWU3xdF
        Vs8320iBP5iWRSqSaBRpxUE/wB4d2fi2mzcb00IHJA==
X-Google-Smtp-Source: AGHT+IEsUZ8erj5VJUQi36nUP18bhs4RN8p0sJyQDvO1xm2DGVPUtjgqSMHSC1IGo7/9xFp31iPXkA==
X-Received: by 2002:a81:73c1:0:b0:59b:5d6b:5110 with SMTP id o184-20020a8173c1000000b0059b5d6b5110mr20946525ywc.21.1696970468986;
        Tue, 10 Oct 2023 13:41:08 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d184-20020a0ddbc1000000b00586108dd8f5sm4608386ywe.18.2023.10.10.13.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/36] fscrypt: disable all but standard v2 policies for extent encryption
Date:   Tue, 10 Oct 2023 16:40:19 -0400
Message-ID: <39faa5d97713d44564249b50518c0212e5bf04cc.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4729f21e21d8..75a69f02f11d 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -209,6 +209,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 		return false;
 	}
 
+	if (inode->i_sb->s_cop->has_per_extent_encryption) {
+		fscrypt_warn(inode,
+			     "v1 policies can't be used on file systems that use extent encryption");
+		return false;
+	}
+
 	return true;
 }
 
@@ -269,6 +275,12 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		}
 	}
 
+	if ((inode->i_sb->s_cop->has_per_extent_encryption) && count) {
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

