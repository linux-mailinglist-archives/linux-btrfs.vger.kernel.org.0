Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8770984
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfGVTPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 15:15:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36650 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbfGVTPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 15:15:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so19597627plt.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/Ym6wVi0gaeGMb3G2cZ5Y3s+yUHGOR4CBESBMLsDTM=;
        b=DfxufxAstQh6Ox3PzWpYxkteJTR+DcSTfcfYxdT8UGEKMofMM2SME0Gx6z7RTpMlxh
         NS1lHVxq8nvdyytzYIJWrQ6G7M7QlwlCjXk4Zz9kHBrhJNiJPPqPpdqEQjtXo/0p2MqI
         T61cH3FPJoOJA3up8oU0Es4gvo+Fcq+bqfeuFHoc1+J/ewlPVKmeWE3PhX0ooTYZOcFQ
         JuwCeQMuQMjCvmhCC5ouSr6YgpsNlOu/7qS82r/ejUWh36CJ2mGBODKXqRBFwhbFY4rK
         7KBeBe6XfK3TF+ik+Wyt9R6ZzI8FOwF/B35CjppT1mjg8KNnAm4r+odP1ki2BiGnBHh9
         qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/Ym6wVi0gaeGMb3G2cZ5Y3s+yUHGOR4CBESBMLsDTM=;
        b=Ee0D4FDSST0dN4liSZMjSnJzIgkyO4jurhI2CCBviOWgEMBNPAhrEx75xpBEs2lgq0
         f8mI4/4e2Wr+rC3gDeRn4mYISVrXMhECk4NK7kcO7DuVHUjhmYOTFjTO5Bl3fIoWJk5B
         HncAtcrCRyhwCV/kuRs5IZEn+udfgWFA6cbTH9/GVlOC/6ZGB4aWaSAoP3FeBZ0uyc0E
         WAoS9gZrF5AEd2UuPQrkSIYxN3xQiWo8GG8vGJjHSYQ+zeT+zi+DEkEWTZmdzURQWwtn
         iC39umy8CFusUlzA5Lh+gxn9evpOYA+orl9D0FCd4yHtR0IXUbx+VF21cfIMPXrGNaJh
         +5Wg==
X-Gm-Message-State: APjAAAU5vd3B0TG6Sod9kl6G3PEGRyF07pM/5rnDOg/vRj4boDUVIYCP
        hMjHZT3ZRDrGVhe8Unkd8R6IYXs4+Bo=
X-Google-Smtp-Source: APXvYqzgSMZvYbLbDhMVMcgSW5fH2tM0RcQwnUb1qJRQuuTEM6wnlR0Tu6cEKAGKpPumGOUNjvUgiw==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr77287705plq.43.1563822912561;
        Mon, 22 Jul 2019 12:15:12 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:a31b])
        by smtp.gmail.com with ESMTPSA id t11sm47262048pgb.33.2019.07.22.12.15.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:15:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 1/4] btrfs-progs: receive: remove commented out transid checks
Date:   Mon, 22 Jul 2019 12:15:02 -0700
Message-Id: <3035988eb320d8582006bbbfa0e872c0c4532889.1563822638.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563822638.git.osandov@fb.com>
References: <cover.1563822638.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The checks for a subvolume being modified after it was received have
been commented out since they were added back in commit f1c24cd80dfd
("Btrfs-progs: add btrfs send/receive commands"). Let's just get rid of
the noise.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/receive.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index b97850a7..830ed082 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -344,15 +344,6 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 			parent_subvol->path[sub_len - root_len - 1] = '\0';
 		}
 	}
-	/*if (rs_args.ctransid > rs_args.rtransid) {
-		if (!r->force) {
-			ret = -EINVAL;
-			fprintf(stderr, "ERROR: subvolume %s was modified after it was received.\n", r->subvol_parent_name);
-			goto out;
-		} else {
-			fprintf(stderr, "WARNING: subvolume %s was modified after it was received.\n", r->subvol_parent_name);
-		}
-	}*/
 
 	if (*parent_subvol->path == 0)
 		args_v2.fd = dup(rctx->mnt_fd);
@@ -770,22 +761,6 @@ static int process_clone(const char *path, u64 offset, u64 len,
 			goto out;
 		}
 	} else {
-		/*if (rs_args.ctransid > rs_args.rtransid) {
-			if (!r->force) {
-				ret = -EINVAL;
-				fprintf(stderr, "ERROR: subvolume %s was "
-						"modified after it was "
-						"received.\n",
-						r->subvol_parent_name);
-				goto out;
-			} else {
-				fprintf(stderr, "WARNING: subvolume %s was "
-						"modified after it was "
-						"received.\n",
-						r->subvol_parent_name);
-			}
-		}*/
-
 		/* strip the subvolume that we are receiving to from the start of subvol_path */
 		if (rctx->full_root_path) {
 			size_t root_len = strlen(rctx->full_root_path);
-- 
2.22.0

