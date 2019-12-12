Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2511C110
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLLAHL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 19:07:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfLLAHL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 19:07:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so141848pfb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 16:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BdojZLFJxmmDpUIPH7dzE/S8OwIW1C0dvcQsxuGcVYc=;
        b=XV74+ZT62/NWdyccHrB8STpZYGyJhZ0kemS/NrwvtAHng46S1VHxw5RyHkwhHczzNj
         lXIoEAn53piWHf0rECzNqLwa2KohuqNj0HoLFPOPSBxF8NAsP1wH0ePZRI7nwprzMNBj
         6Hr5o7QGbRG/ZUqKT6xsBK8QWML40T4lMBlEGgXh3xJyY1xsnUcM3UGg/LgGAUnT5VVi
         +Ac4oTS0+x67cv56D3Qraua/8szpn2P1HPWNRaQL/QlaffKbihkKb9E0GukYbkBK0Ewq
         CKH1s6PUcpRKJkHbdsdQoPEYaL+nzL36ixEd3sab+U++7ingUPNq5PGt+jfhCFUnW3qV
         7Z2g==
X-Gm-Message-State: APjAAAWU6hxw+LG/79cT7NwyXtGFnF1KAfjedtl8rJLb9GKuRisZTWSX
        ERKwbUcAk+8zEoGzByjwMra05bVFiVs=
X-Google-Smtp-Source: APXvYqyx++3SjBYk4AKB7m+R3n2y/5Z3RVUFuYTYNGvbBFLz83BCkjKLkCLZUtHFoxNz6FaK2gZAZQ==
X-Received: by 2002:a63:c207:: with SMTP id b7mr7283147pgd.422.1576109230390;
        Wed, 11 Dec 2019 16:07:10 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id q3sm4470153pfc.114.2019.12.11.16.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 16:07:09 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 1/2] btrfs: punt all bios created in btrfs_submit_compressed_write()
Date:   Wed, 11 Dec 2019 16:07:06 -0800
Message-Id: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compressed writes happen in the background via kworkers. However, this
causes bios to be attributed to root bypassing any cgroup limits from
the actual writer. We tag the first bio with REQ_CGROUP_PUNT, which will
punt the bio to an appropriate cgroup specific workqueue and attribute
the IO properly. However, if btrfs_submit_compressed_write() creates a
new bio, we don't tag it the same way. Add the appropriate tagging for
subsequent bios.

Fixes: ec39f7696ccfa ("Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios")
Cc: Chris Mason <clm@fb.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/compression.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ed05e5277399..4ce81571f0cd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -491,6 +491,10 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			bio->bi_opf = REQ_OP_WRITE | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
+			if (blkcg_css) {
+				bio->bi_opf |= REQ_CGROUP_PUNT;
+				bio_associate_blkg_from_css(bio, blkcg_css);
+			}
 			bio_add_page(bio, page, PAGE_SIZE, 0);
 		}
 		if (bytes_left < PAGE_SIZE) {
-- 
2.17.1

