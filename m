Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8C659B26
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Dec 2022 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiL3R4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Dec 2022 12:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiL3R4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Dec 2022 12:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77B1C939
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Dec 2022 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672422917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DcgUbPIWI7ACQCz0hToO0OmWlNxXVdCOLs0FtdD5bpM=;
        b=A0uCkjgODmrW+SNiScL0hyZ1oa3VBFfnnkOgZG1XxR4HxWZeFTbH+DrekFd45QOqZhZel0
        kt67RLEVLxSpmgXcpO9CE7m4ltsDrxMBFcPgM7lXebPh3ZkO8IPnh1+dhb09EL9i5BnvJz
        eF7Kl2e9oGFVszbd7wlUYypB8OS6hV8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-ZCfGMBDtO2mNBDQFK9YDiw-1; Fri, 30 Dec 2022 12:55:16 -0500
X-MC-Unique: ZCfGMBDtO2mNBDQFK9YDiw-1
Received: by mail-qt1-f199.google.com with SMTP id bt4-20020ac86904000000b003a96b35e7a8so8480846qtb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Dec 2022 09:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcgUbPIWI7ACQCz0hToO0OmWlNxXVdCOLs0FtdD5bpM=;
        b=Zq3x0q9wvKTJbGhXgTPC4TzRwYZGoBcW3bcIUgrMImXdVcYjEteDlU4Y6ovp00ckB1
         s84bO4vRWeYXUZMqoR/53qdovWvsHUNNKKmkrg5LkMijVWILfJiHuUjUnSVFxu2M9KlP
         Yz0DMxEHsV76cvkfGafUr6YE26jkJ2EPG9L3Y8xADk87H2EfDPb6mYsME0SgqK/r9s1D
         eSp/9kD4Igp9GYaPedVBve7ygDB5rGKCFlHAf7mEh9CAK3QCOfFmpGjQGA5UJp6sg98G
         U9Yp6PuEF5hSWVQk4OGAwjiuicrHl6zuMFC4Bs+z0bCVMVP92roEVnYqHUsRqn1TVRlc
         WW6w==
X-Gm-Message-State: AFqh2koJ/Wo7GgOSixVK/AJ1aWenyt6UKk0wxecuQqYjGRh4qAKe6l31
        zFP6lejaifaXDtC7pGI5B5s1V6uwiwBQ4uyjb4xICLwn0mcHhXYtdZ/d4g9Lw6dHMbv5Gle2ZXi
        23LG9TEMTwyjJ1/ZJmrKdjNo=
X-Received: by 2002:a05:622a:4810:b0:3a5:4e34:fafe with SMTP id fb16-20020a05622a481000b003a54e34fafemr51046833qtb.68.1672422915589;
        Fri, 30 Dec 2022 09:55:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu3L2gBHQTmFP9l37NiSRftBM+1axb4Yfr+fA30go/BvbrBtsr+vpD9VbEOgJ2o+/iv7KWmXA==
X-Received: by 2002:a05:622a:4810:b0:3a5:4e34:fafe with SMTP id fb16-20020a05622a481000b003a54e34fafemr51046815qtb.68.1672422915408;
        Fri, 30 Dec 2022 09:55:15 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a244b00b006cebda00630sm15766857qkn.60.2022.12.30.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 09:55:15 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com, wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: handle -Wmaybe-uninitialized with clang
Date:   Fri, 30 Dec 2022 12:55:07 -0500
Message-Id: <20221230175507.1630431-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The clang build reports this error
error: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Werror,-Wunknown-warning-option]
make[3]: *** [scripts/Makefile.build:252: fs/btrfs/super.o] Error 1

-Wmaybe-uninitialized is a gcc only flag.  Move to setting with cc-option.

Fixes: 1b19c4c249a1 ("btrfs: turn on -Wmaybe-uninitialized")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index eca995abccdf..460eced3f5bd 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -7,12 +7,12 @@ subdir-ccflags-y += -Wmissing-format-attribute
 subdir-ccflags-y += -Wmissing-prototypes
 subdir-ccflags-y += -Wold-style-definition
 subdir-ccflags-y += -Wmissing-include-dirs
-subdir-ccflags-y += -Wmaybe-uninitialized
 condflags := \
 	$(call cc-option, -Wunused-but-set-variable)		\
 	$(call cc-option, -Wunused-const-variable)		\
 	$(call cc-option, -Wpacked-not-aligned)			\
-	$(call cc-option, -Wstringop-truncation)
+	$(call cc-option, -Wstringop-truncation)		\
+	$(call cc-option, -Wmaybe-uninitialized)
 subdir-ccflags-y += $(condflags)
 # The following turn off the warnings enabled by -Wextra
 subdir-ccflags-y += -Wno-missing-field-initializers
-- 
2.27.0

