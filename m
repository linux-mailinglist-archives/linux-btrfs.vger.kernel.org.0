Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EEB7AF22D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjIZSDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIZSDY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:24 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D242136
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7741b18a06aso552473885a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751397; x=1696356197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEpmLdsd71BpfsLvuAMqA7qaAsmnnp9uGs4TsFTYoJo=;
        b=dIRJlr/og8wRBSOw7jq66Uqs+QFeqZRIqJjFUjIiT8oWyeHM+d/LEj4sb65aFKrnQU
         eIDjYlSJydx1Tkjf5FqiQQtL8daYg2X6xLqHrGyx0arfkj+BDSoNZsOLzYmV2hH7dcYf
         ea/+2MtYSfk4L/XpLNKIdt/fp1aaqmKBicvaB9IfivoT8kjv0vwikWxhDkAZpWbemY/a
         LyFQt4hw5Le62cDmuAYhUfUI+WjIi12OFzRbfKNTsgmDFNX3HX240Wv2aMB3jG726pvF
         KjdL/sB+VC27giyshXilgHIun1BiIbjqU9RvbZNhP4UUKy2EzKa8IjatrGzxgsoZkTVa
         mt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751397; x=1696356197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEpmLdsd71BpfsLvuAMqA7qaAsmnnp9uGs4TsFTYoJo=;
        b=s4AkCP2TbkgtMEys5J0iIFlia9BOWKu7aOTeqtBILwXmPhjtaoxQIbKQy1WKD0gwX8
         VaVzCuSM5u0e5zk9aysw8sffi1layUZTxs3soQIiF+xkuCVBhLZIywTIMwnlbm0+4BlO
         9v3b5IzaBix6iN9mJByh9adZnhYi8O0AVtnujJXgKhXtV06QGAMmS21uE/CVm89qElUr
         FwTtb0KPrSX12MwEf5OmOUfaMIpYwQdfUhA9V7h0MiGAcKKYrMYdnxLpaT7fk9ulLm4L
         u5Hf0FRmrQTx4HmKMVbDo/4axlaMSSxgFnTtLQiRC+5yQ/sPHI3G+YfXtspmuUXuq0p2
         7Q9Q==
X-Gm-Message-State: AOJu0YzWMVYlQZnV4OkosXfT0/sj5Bc2KqI/6FtVGbmvpfqSF5SWvpQT
        w3oh3QK6FLZSpWivrjHNNF+fPjAYoHc1oRK2b2tc3Q==
X-Google-Smtp-Source: AGHT+IF0mKQpS6T1d8wH4tTeSy6fbusjTkiYCZU8OiOcNlGtAJV5M3Poeik33Kjjt4TwbPof9fL2YA==
X-Received: by 2002:a05:620a:1424:b0:76d:2725:f36f with SMTP id k4-20020a05620a142400b0076d2725f36fmr9709782qkj.71.1695751397077;
        Tue, 26 Sep 2023 11:03:17 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a124e00b00767dc4c539bsm4943739qkl.44.2023.09.26.11.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Subject: [PATCH 03/35] fscrypt: disable all but standard v2 policies for extent encryption
Date:   Tue, 26 Sep 2023 14:01:29 -0400
Message-ID: <e3c4c6b472513c922e3881f65ec9c631b461dc19.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
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
index 8b8da04068b8..38807d0ee742 100644
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

