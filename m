Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23E636D5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKWWig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiKWWiO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:14 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C8D42F62
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:13 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id j26so6355254qki.10
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o03egyVaTEsE3CKcxFRLWKfxOgwMpxxdglBL5YDF05U=;
        b=GF2T0J9Wd8jvWSZBi+BMHcabDU3rNPzyoStpniQIy5SR7+DdAVlCxDikmmEoGSODiJ
         mVCRaySkinf1OZgfQ7AOEIkY9RJsHNBPI0MIaKDWfLVn51rRpesDNn+DHLXeNuyotncx
         iq54mnGJabXi0FztvtyMJ13eaRJYbU2srkT/2gTRx/ahIVyo9ru/UC/qVPVzuzPMGMe+
         mqY3iwIsQa3gzvmTwCV9x77J9tOc6xrQz7wmGtfqULNfffa4J8/8wA4m2K8EQXLT5AWJ
         ARVJnd4eyPhgXgZjmI+zQ8D32Tx032POc2gE83+ox2IEPCrSasWFPfAk312KwH/lfR7x
         Tt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o03egyVaTEsE3CKcxFRLWKfxOgwMpxxdglBL5YDF05U=;
        b=SnJgWbFdf8HzqtGzTWEvubSB6s1BuPNlA7lwchSSfunY6Hg9GDfXSZECUtV02ZnnwY
         3zBoG2dHN28qGKm9sSBN2DZSFxEckiXadaM4Dh9XXxwJHVVq57u2FkqBt14Up81PmZwA
         G5FoniWwpDDW4xbeJf1cAeGJaV3gbGgKoK/ip7CU3MBKauuQzGPLJe3hKLjxDGqch8yb
         un9NG7wrpG0/cVeKdUPc8cr+OBjSsunQjO+nVFAN4TUjLDrONXy7YT5auxu6PkejqBNh
         cpbMuMrm78PzRdxva6Luzad0QrKCRuob3QjM9x6PslUl35Zp8FN/T6Ews1IMC31H8GBE
         AnNA==
X-Gm-Message-State: ANoB5plmXch5D5RHHRhXFbaNgUsrLuV2aHBTIImzOFfxjc2JMZBga2U7
        YX3MLPy3jnfAQR0eN7NAqY6sNl0gVeYvIQ==
X-Google-Smtp-Source: AA0mqf65CKEz9F478vLowIKXJQv+RSnMkOUXeIcyPM8Qg1QCrTKKAAZWnVIiLoDuhIGQGWZYZegshg==
X-Received: by 2002:a05:620a:164a:b0:6f9:5ebe:2bba with SMTP id c10-20020a05620a164a00b006f95ebe2bbamr11911757qko.426.1669243092025;
        Wed, 23 Nov 2022 14:38:12 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bj26-20020a05620a191a00b006fa313bf185sm12882629qkb.8.2022.11.23.14.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:38:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 25/29] btrfs-progs: make write_extent_buffer take a const eb
Date:   Wed, 23 Nov 2022 17:37:33 -0500
Message-Id: <f06e555fe307ed805ccb65d1df4a36166658d205.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is what we do in the kernel, and while we're syncing individual
files we're going to have state where some callers are using a const,
but progs isn't.  So adjust write_extent_buffer to take a const eb in
order to make this less painful.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 4 ++--
 kernel-shared/extent_io.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 7074b75f..6f97312b 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -1059,10 +1059,10 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 	memcpy(dst, eb->data + start, len);
 }
 
-void write_extent_buffer(struct extent_buffer *eb, const void *src,
+void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len)
 {
-	memcpy(eb->data + start, src, len);
+	memcpy((void *)eb->data + start, src, len);
 }
 
 void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 88fb6171..d824d467 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -145,7 +145,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start, unsigned long len);
-void write_extent_buffer(struct extent_buffer *eb, const void *src,
+void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len);
 void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
-- 
2.26.3

