Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3582041D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 22:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgFVUSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 16:18:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41151 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgFVUSw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 16:18:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id 9so20860992ljc.8;
        Mon, 22 Jun 2020 13:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNztvp0y9WnrV/6OJszLJ+zxeRefbXjStepSV3r3pcQ=;
        b=VwyXMURRnPU3CnmdNrL1N2CI60QOhf/ozrl9KbaDdBA++w+NO5BkMgTrHRcL196tR/
         eIelApMOP2UC91bTKyEWclWnbBNx2uYla2/VGf/pbHtAQqw5x595cRLba4omIxmoaKMS
         sKurEHe4istVAYHMAqXws5RLGD+XPdpl32iNSEDpgqA4dETCZO2nVbz7HMoxP0Ne/upU
         tYGvMC2EgeF2VZt+zcVRkSmkm4hSF2MxnHIHoO8vM01KwzlYVPM7AJNktJby91ohOd/9
         3ij09hYQi7k1cH/TGsbF+10HOY2Yn23fblkQpldnS1xsc7P9auANJ12wK59Jy25501bh
         B9Yw==
X-Gm-Message-State: AOAM533ouPHGni/fD0zvkGmx53fqqa44kT7SGEqxvrj4ZvasdzDNXt+f
        KOnBBDGiaJGGzTnWOsUIKRI=
X-Google-Smtp-Source: ABdhPJymwQ9uzayysJ0jgxj7hL3v8z/vMxy33glj9jWAw6E1e+I96FlO8TKdFHfFexX7n2lrStW5Ew==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr9011236ljd.52.1592857129320;
        Mon, 22 Jun 2020 13:18:49 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id x11sm3678333lfq.23.2020.06.22.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:18:48 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: tests: remove if duplicate in __check_free_space_extents()
Date:   Mon, 22 Jun 2020 23:18:41 +0300
Message-Id: <20200622201841.14619-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

num_extents is already checked in the next if condition and can
be safely removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/btrfs/tests/free-space-tree-tests.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 914eea5ba6a7..2c783d2f5228 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -60,8 +60,6 @@ static int __check_free_space_extents(struct btrfs_trans_handle *trans,
 				if (prev_bit == 0 && bit == 1) {
 					extent_start = offset;
 				} else if (prev_bit == 1 && bit == 0) {
-					if (i >= num_extents)
-						goto invalid;
 					if (i >= num_extents ||
 					    extent_start != extents[i].start ||
 					    offset - extent_start != extents[i].length)
-- 
2.26.2

