Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21D3D8453
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 01:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhG0Xxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhG0Xxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 19:53:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAEC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 16:53:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt6so2453734pjb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nTXQ225dkvNuhcJseg5ElvxGWKUpE/BUcGemJDMZ8E=;
        b=y2MibQWKAqN44saBEAWek5COsH1Fy0uh9y44Uf45IARqDLGVOuUFT6wftNO49SP+5x
         ivFEUC7PtkxUMhkkQPbTghjNBX0rNsEgUsZVb6e7+d8eTZEMCkg5r0bE3dM+VdIqYmZs
         RkfkRO/ipNAoipOjfaac7m2LGjpmI9S2CYyKpp3C0Bd0FABwrIYxQKsoxmQlm/Xzt5AD
         vkyTeRrp4E+MFjUTXbc/jBAyA6RRh8gVHKWn5BliSe87v0Ltm4i3+nU7hy6q1Mr4/07D
         oBTcuZ73XIgVx0/8+Yz+G8Jdi5IyfSVt7jeSXkQo9T607heemFJ6mL2NGOfq1bIjiQmZ
         0xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nTXQ225dkvNuhcJseg5ElvxGWKUpE/BUcGemJDMZ8E=;
        b=jfpLbzLPUyVnc6AX8/qheh8BnoJ5seIg2rBA7qE8jbDhGidgm/wc8n9GL1X+K3zei5
         7pksmIEvJ+tzzRz16HgD5/kEO2hYInVqSJKTp73NIq8m1Tdkz5dEggqORn0YCBur64P/
         gW0ybWpqN9jAeCvF3wHZEZ517vFP4jOIOt/0kYQ1HnlwEDtRabHE+9Xg8y1GqbCDBsOs
         AesjJUc80UBNbDQIY3H46g3hiXDuKShIXoBV8oJP494F00QLGlSqalWal0cVTY+41HkW
         AXWxUGXSgUhZy4Ym+k6lUekBYDlaHXW0z50Tlrp8qz2GI0QaxWUJwbbyt1dD+JYD+mm+
         WjjQ==
X-Gm-Message-State: AOAM533Z5naZjimrUcF/G6PjQMA5Pvkxy6liaRux0nBiqMdhOF8OX+N/
        4JPzWZm7J/NzOcGTeKZyN/9a2DVsf98kkA==
X-Google-Smtp-Source: ABdhPJzCKvgavbySq4c8sPnMq7t5W37Uyznfn9any3RPz1ki6k31s+zjqGyFDwYiif2naHgmHXs5jg==
X-Received: by 2002:aa7:80d1:0:b029:399:ce3a:d617 with SMTP id a17-20020aa780d10000b0290399ce3ad617mr12418012pfn.16.1627430017722;
        Tue, 27 Jul 2021 16:53:37 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:86fd])
        by smtp.gmail.com with ESMTPSA id v25sm4740114pfm.202.2021.07.27.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:53:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH] libbtrfsutil: fix race between subvolume iterator and deletion
Date:   Tue, 27 Jul 2021 16:53:28 -0700
Message-Id: <1b0ba76b40a8fc22f8a97124ddcc83d3164f1836.1627429989.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Subvolume iteration has a window between when we get a root ref (with
BTRFS_IOC_TREE_SEARCH or BTRFS_IOC_GET_SUBVOL_ROOTREF) and when we look
up the path of the parent directory (with BTRFS_IOC_INO_LOOKUP{,_USER}).
If the subvolume is moved or deleted and its old parent directory is
deleted during that window, then BTRFS_IOC_INO_LOOKUP{,_USER} will fail
with ENOENT. The iteration will then fail with ENOENT as well.

We originally encountered this bug with an application that called
`btrfs subvolume show` (which iterates subvolumes to find snapshots) in
parallel with other threads creating and deleting subvolumes. It can be
reproduced almost instantly with the following script:

  import multiprocessing
  import os

  import btrfsutil

  def create_and_delete_subvolume(i):
      dir_name = f"subvol_iter_race{i}"
      subvol_name = dir_name + "/subvol"
      while True:
          os.mkdir(dir_name)
          btrfsutil.create_subvolume(subvol_name)
          btrfsutil.delete_subvolume(subvol_name)
          os.rmdir(dir_name)

  def iterate_subvolumes():
      fd = os.open(".", os.O_RDONLY | os.O_DIRECTORY)
      while True:
          with btrfsutil.SubvolumeIterator(fd, 5) as it:
              for _ in it:
                  pass

  if __name__ == "__main__":
      for i in range(10):
          multiprocessing.Process(target=create_and_delete_subvolume, args=(i,), daemon=True).start()
      iterate_subvolumes()

Subvolume iteration should be robust against concurrent modifications to
subvolumes. So, if a subvolume's parent directory no longer exists, just
skip the subvolume, as it must have been deleted or moved elsewhere.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 libbtrfsutil/subvolume.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index e30956b1..32086b7f 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -1469,8 +1469,16 @@ static enum btrfs_util_error subvolume_iterator_next_tree_search(struct btrfs_ut
 		name = (const char *)(ref + 1);
 		err = build_subvol_path_privileged(iter, header, ref, name,
 						   &path_len);
-		if (err)
+		if (err) {
+			/*
+			 * If the subvolume's parent directory doesn't exist,
+			 * then the subvolume was either moved or deleted. Skip
+			 * it.
+			 */
+			if (errno == ENOENT)
+				continue;
 			return err;
+		}
 
 		err = append_to_search_stack(iter,
 				btrfs_search_header_offset(header), path_len);
@@ -1539,8 +1547,12 @@ static enum btrfs_util_error subvolume_iterator_next_unprivileged(struct btrfs_u
 		err = build_subvol_path_unprivileged(iter, treeid, dirid,
 						     &path_len);
 		if (err) {
-			/* Skip the subvolume if we can't access it. */
-			if (errno == EACCES)
+			/*
+			 * If the subvolume's parent directory doesn't exist,
+			 * then the subvolume was either moved or deleted. Skip
+			 * it. Also skip it if we can't access it.
+			 */
+			if (errno == ENOENT || errno == EACCES)
 				continue;
 			return err;
 		}
-- 
2.32.0

