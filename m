Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8E1AD226
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgDPVqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728101AbgDPVqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D87C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b7so139717pju.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPZuR72F02rQGqhEWVqzRAKfTQzb0eGqbphi6uIjTj4=;
        b=St/lV/oAi7duAF6usLQZ1lN3EhwvJoOlk0MxBTA0tsMbrrCC/D0aJ4SvIo/tCg9wW0
         CUiEGbvfXv6Mbmo4lm/E3h3E8s91aPok/NauvyRl8OLHgeZu2c0HfMEH3aYy/6tJs1we
         U56gL9whcThiE6LAnlAhsZzxmSEAJTbegscL0Y/T7FNkoUzNpnJOCNhNqZraGXaRyVwt
         4+Zfy5XgywL4rljXs4vOL4ZJknyBBo2Fu7uFCL7arbXnmGzMNPdeSrrFPJoqj4WsEFVi
         Qz5z+Kg3y25hYOueWES4bcZelak0pv5WyP0VV7Z6YAlqTagPdnMZCKSlNGa86EqxHL9l
         hjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPZuR72F02rQGqhEWVqzRAKfTQzb0eGqbphi6uIjTj4=;
        b=KN6mdHjAa1BRXLjjSDkejYnXvAR2M0wX8urdnnrhs+Ed8oGH4cEVKp3QmpRolU+Cb+
         Rz7vUrPUHWz8XObRZKpC6BP2vaEw4oEGqcawc7ZIDuw7EVB31SZtKBY4tUPsfbgRT7+P
         PO0NJdo2OYUFX8VqqcwTtKfbE3ccjMYCainhcburZ5ID8/F8N/wOUMlK3hqcs7J8go9M
         UGY+ammgHuz+03/DsMDGanTsGRz29QfuZCcTGkgCwkE8NfAxqjFXvh6DmUb49Q2aDnQ+
         si7lEptNVlAa06EbScQQPVk4gFxuJ9M6lkQDpHc3L74T5knLGWOBDpQmB6C/HHfruji/
         TRfw==
X-Gm-Message-State: AGi0PuZHZrKf+zQbKA3css1DrNenmuLa3+VZ0bXTBTMayn7+HvMC8+bN
        +D0f+awOZhYpfjtxiZH+nPhLSeklCnc=
X-Google-Smtp-Source: APiQypLYPwwQPDZOTvZigY2h6B9yJEBvewmAhMVcWsq7aA1i8kPe9NcU/W9XUlWF4C7c8kueXdZ+mw==
X-Received: by 2002:a17:90a:6f22:: with SMTP id d31mr494776pjk.14.1587073603735;
        Thu, 16 Apr 2020 14:46:43 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:43 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/15] btrfs: kill btrfs_dio_private->private
Date:   Thu, 16 Apr 2020 14:46:19 -0700
Message-Id: <2b1b2a0790cad01da9887392c25e4f9b6bbf1b5c.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We haven't used this since commit 9be3395bcd4a ("Btrfs: use a btrfs
bioset instead of abusing bio internals").

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/btrfs_inode.h | 1 -
 fs/btrfs/inode.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 27a1fefce508..ad36685ce046 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -301,7 +301,6 @@ struct btrfs_dio_private {
 	u64 logical_offset;
 	u64 disk_bytenr;
 	u64 bytes;
-	void *private;
 
 	/* number of bios pending for this dio */
 	atomic_t pending_bios;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb3fcdc7c337..d7cf248dd634 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7923,7 +7923,6 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	bio->bi_private = dip;
 	btrfs_io_bio(bio)->logical = file_offset;
 
-	dip->private = dio_bio->bi_private;
 	dip->inode = inode;
 	dip->logical_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
-- 
2.26.1

