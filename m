Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449857A16F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 09:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjIOHK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjIOHKZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 03:10:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E71720
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 00:10:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31fe3426a61so1166720f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761817; x=1695366617; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj/m4c7N9nllQZGVTzq28yPmkPN78wJYzwR0LyfbIrA=;
        b=UdgBmM1HGsPb7Y9mTZPUMyJcjzzw5dPlnUhhuj9HwB/7Mb6e9w15JwnXNCvV0h87EX
         Y0vZawTn+2KrKFJbi/XC0/d6r9qQt5NwKpTZwRQVLhjTXWBk2nmET51CwXSrYk/gwD+a
         vqet27mV0WhCTR+I2dnShHCrGnQloFnjLihGc4ALc7lho2PWLwSMxSDzVLcAaQIKaIx7
         aTN0hk4FSD2BMyJjlxA7n+qnwo4EQmPgPW/vhhOulAVTkFU8+RiZF2QuVCXEhm9aTNtB
         FpQABMGceZGKYmf5kdm9TPpawRiEjpPmrAtOrSlKmirA4g5Hlq2iNe+Ly1m/l3CPG+rS
         u7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761817; x=1695366617;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj/m4c7N9nllQZGVTzq28yPmkPN78wJYzwR0LyfbIrA=;
        b=DbMSjnxDCgDxD1IbUzj60cntzYpJj6pFpIZrOch/QYj/mXfE9gfYT9B+IMAB5dgAWh
         uWNh+p89jYPWvntCw3n3tcqBIsawGEY8+ZG05kUyXBnpAcm8COJLYg31lR/B0aJnqFoe
         B/y8SMiu5lXpDrzlYZSGw38Tf6Yi2ImO8LbDXPQ4i7nzZsuY0kiw/0R14hBqTLdkgxtv
         ilU4h2Hoq1VQKexpuladEmU6tEgN5UohkrqqEz8pK1iR+Me3QA9Y8kEmczEOJCOejH/J
         /0nDh5tklGqfagqtRTBKCAhfn0fmXinPSvS1kf/ZXx0Vv8Lx/DTexJONKhU+wsQB+tdW
         liyw==
X-Gm-Message-State: AOJu0YyjV8jTPfPO9hvFAdxBkbxC0qu4REYeHSCh1l+kP+ZII6mrofyN
        a+revuSV/RhlqWx1ATz+zpZVPZKje7hHelUDbT8=
X-Google-Smtp-Source: AGHT+IEV2yDCABEZ+Ruem9VodwCpLGK4zFV9cVeNhseU2qwswVmV+Fskqe5HqclI7wghHYjkjnAvvg==
X-Received: by 2002:a5d:4dcf:0:b0:319:7472:f0b6 with SMTP id f15-20020a5d4dcf000000b003197472f0b6mr832828wru.15.1694761817528;
        Fri, 15 Sep 2023 00:10:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b0030fd03e3d25sm3635094wrt.75.2023.09.15.00.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:10:17 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:10:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: extent_io: do extra check for extent buffer read
 write functions
Message-ID: <b07914e7-137c-4549-97cb-2a0c3e757a04@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch f98b6215d7d1: "btrfs: extent_io: do extra check for extent
buffer read write functions" from Aug 19, 2020 (linux-next), leads to
the following Smatch static checker warning:

fs/btrfs/print-tree.c:186 print_uuid_item() error: uninitialized symbol 'subvol_id'.
fs/btrfs/tests/extent-io-tests.c:338 check_eb_bitmap() error: uninitialized symbol 'has'.
fs/btrfs/tests/extent-io-tests.c:353 check_eb_bitmap() error: uninitialized symbol 'has'.
fs/btrfs/uuid-tree.c:203 btrfs_uuid_tree_remove() error: uninitialized symbol 'read_subid'.
fs/btrfs/uuid-tree.c:353 btrfs_uuid_tree_iterate() error: uninitialized symbol 'subid_le'.
fs/btrfs/uuid-tree.c:72 btrfs_uuid_tree_lookup() error: uninitialized symbol 'data'.
fs/btrfs/volumes.c:7415 btrfs_dev_stats_value() error: uninitialized symbol 'val'.

fs/btrfs/extent_io.c
  4096  void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
  4097                          unsigned long start, unsigned long len)
  4098  {
  4099          void *eb_addr = btrfs_get_eb_addr(eb);
  4100  
  4101          if (check_eb_range(eb, start, len))
  4102                  return;
                        ^^^^^^^

Originally this used to memset dstv to zero but now it just returns.
I can easily just mark that error path as impossible.  These days
everyone with a brain zeros their stack variables anyway so it shouldn't
affect anyone who doesn't deserve it.

  4103  
  4104          memcpy(dstv, eb_addr + start, len);
  4105  }

Sample caller:

fs/btrfs/volumes.c
    7405 static u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
    7406                                  const struct btrfs_dev_stats_item *ptr,
    7407                                  int index)
    7408 {
    7409         u64 val;
    7410 
    7411         read_extent_buffer(eb, &val,
    7412                            offsetof(struct btrfs_dev_stats_item, values) +
    7413                             ((unsigned long)ptr) + (index * sizeof(u64)),
    7414                            sizeof(val));
--> 7415         return val;
    7416 }

regards,
dan carpenter
