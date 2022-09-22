Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50BD5E5938
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 05:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiIVDLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 23:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiIVDKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 23:10:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C784982D39
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 20:10:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b23so7932028pfp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9y2lxcjKWi6kM02eOSoQVeQPXSl5vobQ22c95G6mEc4=;
        b=agBKCvV0iC7GQIcf8sz7UOH3dVItREZG7jPdBvtdPy2YLOE0+XAy2KLGvZyzWCldr+
         eBmNfNQZyJ71RW93/RqEBJpErudlrwRKiB3G8SDyrXVW40aMl2oo1k6YG1lfeIUUjh9P
         GUamhTzL1Eje9pLqolXG4/wF2iRxonrtVdIpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9y2lxcjKWi6kM02eOSoQVeQPXSl5vobQ22c95G6mEc4=;
        b=nTobGyH1GovBCqpQOX0F9Ty+f1lfOY4c4lW8QHYYAYqK9lumw2Ju0yrLK+SxpEHW2J
         uAE23xu6oHGW+1Bb0gUeYf1NCt27r/JSTBG4iMZJfNm1PUlpNB5i+93d4Ed2Ya8obcV1
         WPjZBk5E5faswHMYYAouqnzNnE/PLLjPNA5pbhQzEtQ8Y990E2/D4yzGElfxz1PV6GyK
         8BP80AHtOXuRbBRRQ6Yr3bVdKYIEX1ArGGYzXHAcMU+39dYUXyrFarUj4Wa8XuWaN4ya
         /aaVvM/rdp2MvGGPIWYANZn5dyYKrt2TNgumI1mWiXowALOpRCcFW5rFjKdXOPBCHDvu
         Udkw==
X-Gm-Message-State: ACrzQf24MZqQXwhlqv8QbmBrtXPfnjk+uDVKQ1CwNaBYqrwc2TWFxNmw
        XBActrQVfj+E/jB/oF7gSdh4nA==
X-Google-Smtp-Source: AMsMyM7fmjxAfGTycH9CaoCA2DJAnd13bu5HArBXnwB99jjW/VrHSPoTFEUdZfu+ReZxNaNi1nSSsA==
X-Received: by 2002:a05:6a00:14d3:b0:546:e93c:4768 with SMTP id w19-20020a056a0014d300b00546e93c4768mr1278425pfu.36.1663816226130;
        Wed, 21 Sep 2022 20:10:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15-20020a63d30f000000b004393cb720afsm2684116pgg.38.2022.09.21.20.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:10:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>, Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 03/12] net: ipa: Proactively round up to kmalloc bucket size
Date:   Wed, 21 Sep 2022 20:10:04 -0700
Message-Id: <20220922031013.2150682-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922031013.2150682-1-keescook@chromium.org>
References: <20220922031013.2150682-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; h=from:subject; bh=N6cTYse7nKSOYOPwHuuyZ39Ee5FBmcRJBaahsbeuoYs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjK9ISVSHfuaLwQgHhIfT+G4+ZNlvTp+tw3ysmjP49 mcPajiqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyvSEgAKCRCJcvTf3G3AJoHDD/ 9MEz1x/p8W1mV4RgWnzrofQu8Rnt8S3z6RAn+Qe1cSDrxAzlEofmKXpYWiJ+/LrW8d+DMyEPH/qhiv Z0a3iYatcr1nh3CMNcUGNtMmB0uLZf4MMZQ184oh/sUT8PfviA8YvnEqJsU39RxjaNFpvevCU+UIhE ampATmMNn3x9mz3MinyvwRAeCqjlprv9qGhZP19uivXAzi7A5LdGcnY9/yU4NERLhAyGSQzZMoevL5 foxanGNGMhF7lJpEQx7SiHJ5/UGNfHDmQUAWnnIkH/iu4aw6z8wFCMrDe26riTARf1OhVgycx3C53y RsfcyayukdwLx9qBoxlSnrXwcUJmn8ly2s9mOX2jMHadZIKMM3erpLkcz5K5LzoAcHlMME0ZTa6H4I r+U57Oid2/dp01vdDgMvdb84JzOixL5JoQHu938RHKYP30IYQwkmhzBuFTkeMJzZsGS4WER47knxxd 45A6nI1zHNqipyFcbwqyCP0c9FHuUWJex4p1UkuPhpfl9BEy2OV28T7pqLJh6gYsDDqnVtz/7bvacg zQ8eV1paLCDfmSbshlpEBTxLnGWlSfPt0cPNLOqHf+Rw64Ee8lJY4M1B9xEIc9508QU/bABpMn7ngE vWtwJ0BkH0HMufph7v+73fhgqm8PD3cLFKaT53fQXDIr4zxoPqlAoJbGBvtQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of discovering the kmalloc bucket size _after_ allocation, round
up proactively so the allocation is explicitly made for the full size,
allowing the compiler to correctly reason about the resulting size of
the buffer through the existing __alloc_size() hint.

Cc: Alex Elder <elder@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ipa/gsi_trans.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 18e7e8c405be..cec968854dcf 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -89,6 +89,7 @@ int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
 			u32 max_alloc)
 {
 	void *virt;
+	size_t allocate;
 
 	if (!size)
 		return -EINVAL;
@@ -104,13 +105,15 @@ int gsi_trans_pool_init(struct gsi_trans_pool *pool, size_t size, u32 count,
 	 * If there aren't enough entries starting at the free index,
 	 * we just allocate free entries from the beginning of the pool.
 	 */
-	virt = kcalloc(count + max_alloc - 1, size, GFP_KERNEL);
+	allocate = size_mul(count + max_alloc - 1, size);
+	allocate = kmalloc_size_roundup(allocate);
+	virt = kzalloc(allocate, GFP_KERNEL);
 	if (!virt)
 		return -ENOMEM;
 
 	pool->base = virt;
 	/* If the allocator gave us any extra memory, use it */
-	pool->count = ksize(pool->base) / size;
+	pool->count = allocate / size;
 	pool->free = 0;
 	pool->max_alloc = max_alloc;
 	pool->size = size;
-- 
2.34.1

