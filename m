Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A491812C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 09:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCKIR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 04:17:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39594 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKIR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 04:17:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id s2so762647pgv.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tl2qJYqkoq4i0n0WsdxJLNjkYfr/WIVsn6+CVSKBFjI=;
        b=wbxAHfruQH/vcRRjglHiArYt/WnMn4plu+Wyopb/+KWogNypv7iiA3o9rwQlQ8HQ52
         Xex2FKZ+fTCJw5QJ0q0rURxnk+P3tx6mWrGLB3bQ05I3JLcclgS7I81Wjf+akGatQcdU
         iuNGnppgoI1Q9guRdtgF709KTb2VMLOK0Q+5/NRpdldEY42XftggqfxaBmWgEu8sHUfH
         GuDf5xd6K9Gevx5OSMG27z3UJ4hK4bwlmc1v6nwAQf7WpRDQEWPZTTYkiHDQnjNQcf0l
         dSxYjBwAV6XsHh3QsAy+l54OWX/fLFFu9lZIcAVQxwSWb9ovVOFWvFf6oIDmDD1F+79q
         IHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tl2qJYqkoq4i0n0WsdxJLNjkYfr/WIVsn6+CVSKBFjI=;
        b=aQYGOkDVcGegZzAFRkj4AmTlXFKuywMZEnb6mjmFTiE0ogZ7dX6xK4+IrfYaFhqIB0
         MH0/OwGE7tAFtzcEniLKznPOdglhEvmMb5IVgRR0TvReVKVHRl1Wb6AvQbvn0uKaVtsV
         +Q2p/nu5LGhc/CUu3ldEfBv+iTQGXZYHK5pp/1SK4U6puRGuqCJMWjYnSAB+1c7V5BDu
         7QhlEiw0QHBlQhw42dZs6TMAIMOYf66rW1kGflbf3/b4G1Ddavb1FMwpOmA/KQj0MXKu
         yilgIIc815kl34NeJASftwgFp5KjInr6lo4AkJqpxAFo4A5+STUQQXufjP640E0VbawG
         e19Q==
X-Gm-Message-State: ANhLgQ0lZP0wCfsBkji33fyqJQVgkUDIWOSdF9FT0S7L5n7ygEJRPIml
        1FqVX4wfdIgcDIgWRA27skVejnh/Va8=
X-Google-Smtp-Source: ADFU+vuuNe4DkelaAWPBqUnLEESrSQpYMdSFW1/ZSdGe/A1SyI9Cx03vfOWrzMTxQY5FVzl6dZbsaQ==
X-Received: by 2002:a65:6787:: with SMTP id e7mr1678613pgr.98.1583914643822;
        Wed, 11 Mar 2020 01:17:23 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id j8sm4692039pjb.4.2020.03.11.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:17:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Filipe Manana <fdmanana@gmail.com>
Subject: [PATCH RESEND v2 1/3] btrfs-progs: receive: remove commented out transid checks
Date:   Wed, 11 Mar 2020 01:17:09 -0700
Message-Id: <ba4cd47585197cb490afbd5ad22725adfd909381.1583914311.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583914311.git.osandov@fb.com>
References: <cover.1583914311.git.osandov@fb.com>
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
index c4827c1d..a4bf8787 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -345,15 +345,6 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
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
@@ -771,22 +762,6 @@ static int process_clone(const char *path, u64 offset, u64 len,
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
2.25.1

