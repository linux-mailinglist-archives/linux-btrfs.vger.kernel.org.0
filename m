Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECC817E9E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCIUXc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:23:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37053 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgCIUXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 16:23:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id l20so6403796qtp.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+11tuGa5ypmlSF2o5NuLqbvlL8n4BkqYzntbvS9at/0=;
        b=0yEnZzAEOjSEyZIqvpLCT8glZagXPcAk3ZrgdvpAdoQUTOL0dNLbuGdUz0XKtCkZ1+
         jAzaPYAd8p53GFD5yEjZV1U3s9gQWg8EEZ0hANAsLeVlow9aaNWXAFmEVrVSS8SSHhK0
         bpp0yEkk7iceS9N5E9/NV83AdzTb1m71haf4weF/NKQA41bAF9yx9hSN20WpNiEwRYIC
         2+vdYAEJYtSue1YUKIOhGdS8qYRty0mC91cLVr43HyihvUoZkguwp3/pmLEr2UcGioSB
         hs8mQB68/ophuxUfuUEroMin3kx4YZ09W8C6Ch/Di2LPIQff3y1IeqXU+Xq5OMps6h19
         InVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+11tuGa5ypmlSF2o5NuLqbvlL8n4BkqYzntbvS9at/0=;
        b=Nlt6RDVn0fONGG5U8ws1usAdOaUPp5dMaYVDd3y8kxiyTAgBLCEKXB5Tt/7Ze/NsnY
         I6Tnh0kErm+Yaekf9dhxam4n0+YDdoJpANiK0vW2Ig7qO48/CkY3Bym9BUrDvd1pRoeJ
         8fxTQqXBKVe7ies50TJ6fQ7v2VR1KLMd6dqNWAOosnl+5R2OEABfDHh7faB5YZ4hpj03
         aniJkJmltnElFuiN6OWDCuq1YHqTcI50GoQlNSUMBSFzT86WhX/rd00W5o5AOzGdeJI7
         T188njw7gIT6GGI0bGjOP73C4h6Nqpfm3xZZi4aobr/LpBr/ez0bUaMkNAZ6dokg0wJ+
         6yFg==
X-Gm-Message-State: ANhLgQ0XDnpCJ35MJMqqWBSR4gWegX5t2nl6h1WfHflN85bHTH5ZK9xr
        zDrkIvOjP8yeft4SEJo4f9ZZUdrD5kQ=
X-Google-Smtp-Source: ADFU+vu9CXjCyVQrIJ4z1ucqqR+XevCaNUXt49duTd0vsTnsehucTFuA+TnihWGlZ714vJTts458Fw==
X-Received: by 2002:ac8:5497:: with SMTP id h23mr7454399qtq.226.1583785409116;
        Mon, 09 Mar 2020 13:23:29 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p35sm3056449qtk.2.2020.03.09.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:23:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: Account for trans_block_rsv in may_commit_transaction
Date:   Mon,  9 Mar 2020 16:23:19 -0400
Message-Id: <20200309202322.12327-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309202322.12327-1-josef@toxicpanda.com>
References: <20200309202322.12327-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On ppc64le with 64k page size (respectively 64k block size) generic/320
was failing and debug output showed we were getting a premature ENOSPC
with a bunch of space in btrfs_fs_info::trans_block_rsv.

This meant there were still open transaction handles holding space, yet
the flusher didn't commit the transaction because it deemed the freed
space won't be enough to satisfy the current reserve ticket. Fix this
by accounting for space in trans_block_rsv when deciding whether the
current transaction should be committed or not.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9c9a4933f72b..8d00a9ee9458 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -575,6 +575,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 reclaim_bytes = 0;
 	u64 bytes_needed;
@@ -637,6 +638,11 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock(&delayed_refs_rsv->lock);
 	reclaim_bytes += delayed_refs_rsv->reserved;
 	spin_unlock(&delayed_refs_rsv->lock);
+
+	spin_lock(&trans_rsv->lock);
+	reclaim_bytes += trans_rsv->reserved;
+	spin_unlock(&trans_rsv->lock);
+
 	if (reclaim_bytes >= bytes_needed)
 		goto commit;
 	bytes_needed -= reclaim_bytes;
-- 
2.24.1

