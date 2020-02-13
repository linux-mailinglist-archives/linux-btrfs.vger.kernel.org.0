Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA415C47C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgBMPrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:47:45 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38480 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgBMPro (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:47:44 -0500
Received: by mail-qv1-f67.google.com with SMTP id g6so2819818qvy.5
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zaenaX+MsEq5QFPOTT1r8BMG2JGhZph2jZ8eABR49Lw=;
        b=PurAWdjAhLNhp5ZZ1i0j0jlftx5W4o/NKzhod/ol2flWEhdHZSMqs7LQ4EDWGE3rTV
         WurHdR4IVvK43lqDsheKyzTkLEjd5Rm1sXvnmfENAGhIk8a7Sy+e4i765PKA1yXftCys
         YAk8ejYRMBkubKH3M8e/EmA2AK3KybGKiGj6NioQ6CoQsypVUW/RdjhysA+19z2ncdIj
         klEtSmHL+i0vj9zDW/SmlnOW6ITssuYz2xwyqc4Zd/K4wsPH8VvuAaAUDPErDCt1sGv4
         boLk/zBqxBCTSBv1JeF0YO10u5u2twkc8hJmzia75sKVD+T2WA3Grauzr+1HfoQ81hs7
         F7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zaenaX+MsEq5QFPOTT1r8BMG2JGhZph2jZ8eABR49Lw=;
        b=LD/0vA5iHd3ll/0H0J7Q8sEFrUEOaqz6LfHwPqjRLil1B20htbTSEltG+L54vbSoxw
         A8XpxhfsKXgH0Hi/2uraGy6qvZFKgiuZ7nJYr6RQdpZ4lDqpqRZXDZxRkFaJ1SbL/mEu
         1KtrYSPyYr1ZMZO94x/ftoM8FACNNNzL5NptIMUKUe34VBmMMoT2IYzRWOyVp1ptdnI9
         +/JZVvXMdTuUuBccO6q6Gn+ouJ5LUNHgEclgsgFvRWjhFudoNC1DBlLobetaVh22+mFX
         s3IE4LvH75s/3+EhAWM+H8gcFE+z33dCQ9dhhTfO5EEA0vSwfeF6F0q5tNDo4BjSFZ4L
         wJZQ==
X-Gm-Message-State: APjAAAXw+OrsQohErJ4udLbpr6YOpP+Af3CjohffXejSFTKi1HFlnDXv
        MUzyD8Yz/Iq1MGWnWYk7czJZG7RXPys=
X-Google-Smtp-Source: APXvYqzHMtcvEQTdpfoI52DldnGy1ozBVp89EUXulKJRresLrm5H09YfwMQAn8Cv9wDSgVgZ+Z3PvA==
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr11595967qvp.210.1581608861953;
        Thu, 13 Feb 2020 07:47:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q6sm1468296qkm.46.2020.02.13.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:47:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 3/4] btrfs: handle logged extent failure properly
Date:   Thu, 13 Feb 2020 10:47:30 -0500
Message-Id: <20200213154731.90994-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213154731.90994-1-josef@toxicpanda.com>
References: <20200213154731.90994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're allocating a logged extent we attempt to insert an extent
record for the file extent directly.  We increase
space_info->bytes_reserved, because the extent entry addition will call
btrfs_update_block_group(), which will convert the ->bytes_reserved to
->bytes_used.  However if we fail at any point while inserting the
extent entry we will bail and leave space on ->bytes_reserved, which
will trigger a WARN_ON() on umount.  Fix this by pinning the space if we
fail to insert, which is what happens in every other failure case that
involves adding the extent entry.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c43acb329fa6..2b4c3ca5e651 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4430,6 +4430,8 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 
 	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
 					 offset, ins, 1);
+	if (ret)
+		btrfs_pin_extent(fs_info, ins->objectid, ins->offset, 1);
 	btrfs_put_block_group(block_group);
 	return ret;
 }
-- 
2.24.1

