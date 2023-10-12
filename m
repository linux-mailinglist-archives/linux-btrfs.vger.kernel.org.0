Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47E7C69E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjJLJnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJLJnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 05:43:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2391
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 02:43:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso8119305e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697103779; x=1697708579; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHzUG3KG/eLX+tQ6CVjg3fSs3TGh4qhPLNWOVCZfljQ=;
        b=RufdTUbWBmdcKlPoMEnJScb391/ZXiCKalYPbljVJU3tYmjuG5iqfVDxRRjYcglCJ1
         ZoCuatx5xuAcZfVTQ74W8abFF3MDxMPeLM0WdEyLHRC9Nc5UvfY5FfFpxs1LwqzCqcZr
         a32TcsC9z7fjQLKsUNtHgq5tMCs4YefWVl2fHVcA5yV21vUtJJ0cHKz+BmywltTuGahe
         MF/sVdIQ8sYoXCogiKI+YQj+3qbPou7GnPZg+MbniG332ANYIlPuBMx6xOqi0HQaIIRH
         v+qLgDZEy6U+AqW/45GWgu2QSeuAUAn45pPxNkPj1/41SeAPgGrQCbB5glK2Ynd5D1rX
         iE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103779; x=1697708579;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHzUG3KG/eLX+tQ6CVjg3fSs3TGh4qhPLNWOVCZfljQ=;
        b=VU12F16C06MdUxPypTSNjO4r+x0+IQdNUhV0eeCual63ydV7SOguN61pjMJHRho3n1
         5VziFsyOZHm0tH1vBNFMPjvyEKBFkABsWbtye3fkQIdBSJImNx498ZfA9yghkLNGiWK8
         Ahcv51wKPaXMGm8s9IgYmN+vxnzNqW34Lg91Vv25fNhYHot3G4bMHiIwGzkj8hFZGdWG
         Yyd/+JsqCCmq9jgUTk7qlCAhLeA77awxZIUTSg7y6/9OxQw85DA8VHWQMVE/mpzatfXt
         8pZKhQr/ElyFuBmhOvD8DZWwuhK6GMXHADMcyyzIJ3b+VAyhpzsziWv29InkSa/s8WJv
         HQOg==
X-Gm-Message-State: AOJu0Yyq0fAcEPOT0R5DNr7AZ+KO1h7zNpuwJE36Vk++e3vKGuyVsMl8
        sBhJ8pO3xpeluAhvjA5aaZXlhA==
X-Google-Smtp-Source: AGHT+IGk0wIPTIZeyYH2T4fl1g6pwNLVcvlBW+S1aM+ZDTz5C7asBiHdruKBDKex0lJyzF2ybiKYjA==
X-Received: by 2002:a7b:cd0a:0:b0:405:3dbc:8821 with SMTP id f10-20020a7bcd0a000000b004053dbc8821mr19997461wmj.22.1697103779372;
        Thu, 12 Oct 2023 02:42:59 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003feea62440bsm19005198wmi.43.2023.10.12.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:42:59 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:42:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: clean up an error code in btrfs_insert_raid_extent()
Message-ID: <ce098f42-f12c-4bc2-b37f-2f35c572eecf@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's more obvious to return a literal zero instead of "return ret;".
Plus Smatch complains that ret could be uninitialized if the
ordered_extent->bioc_list list is empty and this silences that
warning.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/raid-stripe-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 944e8f1862aa..9589362acfbf 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -145,7 +145,7 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 		btrfs_put_bioc(bioc);
 	}
 
-	return ret;
+	return 0;
 }
 
 int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
-- 
2.39.2

