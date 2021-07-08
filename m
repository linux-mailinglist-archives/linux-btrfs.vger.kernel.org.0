Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636CD3C13FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhGHNPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 09:15:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42294 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhGHNPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 09:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625749957; x=1657285957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nWtyhCb7dS+Dg9n3hRx6LlJZ3mZVgdbPHDJlobS6lHw=;
  b=X8oT9+3NqeGwOfqGqdC+R6cfqiAaa8ShAe2UIEcqp1BzTY3hcvHNEo9T
   d8lce7TPCK08l7jFWXY9O5aWXtKDmZpEbxfZ4nnWgAvpcND+9k7+VhZsD
   nV1siFGr4H/fAGRlVl10/0mgibDPLu2dB+h5rnazrJIGTYVkZuejbfRRM
   guVxuUYfMFcfI4rIJEa+antabaKngUOuD+dZU8Pbm6Oiqgjua4/df1bnm
   /4Z9/IkghFwDMqror9pU//aYAj7TZ/tsSYQc7DI28w+2svmrJh5XhLINW
   SmuF0kczNz5h45WlaclB7BNMsKYQbnGIBVoi4sb6m+ojj5y10rhss2d6v
   A==;
IronPort-SDR: vkrF57WcqKqmUZsiUC0qNr7k3KGqGc2/B+ROcLCInRw9HnCb/NOHRPKmS/YThIBzu2+HIQnfd8
 bSS1qON54fRG1VVZDR7U9lNA1qHaWKvxueER+vEi6/n5/cIvxPdoFw2bVItOMQddUclWKJ/X0w
 m1XeQAsx7z9hD2Ge/WaAA+WtWWvg8Xn/1ZxKdexCtNKYb8A/qPwEc0z+OUxWvzBvSjxEx0wLh8
 AmWGYK3bqgjjQR2418r37nFfF2DxSHAyUvEbDadEH1jgmvSN22puXJEniey38iLL0wLsQxBNh9
 7gE=
X-IronPort-AV: E=Sophos;i="5.84,222,1620662400"; 
   d="scan'208";a="285562708"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2021 21:12:36 +0800
IronPort-SDR: 1fac1nnRXNgUuZYPTa/RnmygpqgmOgHXGo54Sm570ERLjyuvugEeXAza92mutLiiOtv/le58WO
 HgicC8zWa5knWTWqhoEjAutYLYdupmDOfhxNuH8bBmTABAeZsJYQLoiIxOh8r6KwFhqq7M+Mix
 81wnW8MuoS3v3PwndeNutkFA3Ntr5OUKo/W0dcNZf0ghsEVImwimf2XvOmyRGo08Lig5CNp+1h
 ZNYXZ4Re4PelwmaOUmSkexpn+vlhnhvbx/AxT98wmRKY1i8DU6Ugcpl8nU6RtYa9n89Qce+uAb
 If5OrW6IQyoAcNwbUk7twuw1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 05:49:34 -0700
IronPort-SDR: z4D3x52j96aOjYhJBr2TBF630/KjE7N397mktHkDdQkZ/0yS1oLwcRWwDXAC+jVFKTzu58lOiU
 iAx9L7ykoa+Ob8JUOZ7NKAq6hMNxxvqmjdGUw0jctFkgvM83+hzJKDxeGMaCYdNR7Rtb6KNIdZ
 Dl0tdQzJL4NGqhKLYn5Ixww4kLgFsRfT550AoS7d7VRRi6lgTIffSHnO3oLW4+gMwCH9cTH6HB
 zh5yymG5rtWv6M28KSdv83rktSn3LzSJkr7vIr1fKbOS6n9oqf0vw2ND3bOZ+8KEws7NleQJOl
 KBE=
WDCIronportException: Internal
Received: from b1j4fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.95])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jul 2021 06:12:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] btrfs: fix argument type of btrfs_bio_clone_partial()
Date:   Thu,  8 Jul 2021 22:10:56 +0900
Message-Id: <20210708131057.259327-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708131057.259327-1-naohiro.aota@wdc.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

The offset and can never be negative use unsigned int instead of int type
for them.

Tested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 fs/btrfs/extent_io.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f947e24091a..082f135bb3de 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3153,7 +3153,8 @@ struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
+struct bio *btrfs_bio_clone_partial(struct bio *orig, unsigned int offset,
+				    unsigned int size)
 {
 	struct bio *bio;
 	struct btrfs_io_bio *btrfs_bio;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..f78b365b56cf 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -280,7 +280,8 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
+struct bio *btrfs_bio_clone_partial(struct bio *orig, unsigned int offset,
+				    unsigned int size);
 
 int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
-- 
2.32.0

