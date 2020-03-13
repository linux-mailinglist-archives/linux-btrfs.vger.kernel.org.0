Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3561850FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCMVXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:55 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40275 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgCMVXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:54 -0400
Received: by mail-qv1-f65.google.com with SMTP id u17so5441732qvv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i1g8PvplrqHt5XBMdH9s/NUv6j6OUjCgqYZ2SvxGJJA=;
        b=du1PSM3oVNsvyhzZHHn0V/zvAb0s+LzRtKodVb87HK6Ygp0hkZgeBPwj8bt4lqZC9Z
         63KmOY08dCTKe+IeKX3a4W6+F5kQfV6dU8x8zmSm/BEWZoZ7D56ByXSNDnoOi7xOp9eQ
         mKNfTU41XJctur6Kc5SzHN30WsKJ3mzAFjgzvHQ8K6M1huzMiCE1CAPhb6TAXeP/X2qX
         YRwEpNFnrECpIM/inSJjITxngItv/A8tJyyaRhQl+RPDljRxSNgV9oAcjwPyDa9mpLQE
         FWkeeR3BMfpL/7jV1ql/4puME5Ut+zkZeW2OINujE5iDZjKaSoYjCR8W50Acu6rBn4Vs
         r/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1g8PvplrqHt5XBMdH9s/NUv6j6OUjCgqYZ2SvxGJJA=;
        b=cFzCDuz7eDb8PirsQ3EqiqczY1ZvJ/ZoMzblu3PjPvt4TzWlfWJWXHoBiN4i94ACGo
         WoSyHdVTDWN0gPaZwNi3DZabp5mDRP0O/15hHjpkgnFXKQnFGmphc1zQF0PQIBN+trUl
         lT9s57YExm+vW+pz90kG7VvB/KjITH3yGDgSsup8ThDGLU2eblN3XdAI8UZAgS5ja9aY
         ryhkKWBwRpi9qumRCjm2ZugorHsHakSD2FD0cFIjk7O0TkDXQRvYQFt+9USI389mA6ni
         ULapK3uDk0J1+9ogn/JVYNLlCdzVnHAk5GApWB0dGEoJdZzk7yL85eMkcW3p3yJub8vK
         nXzQ==
X-Gm-Message-State: ANhLgQ1XPSMv7t/P0MpD/QovOECKoUArfD0AD6WUJ+f7r+XUhG58URL5
        hGydgNeSneTXQrMgasxN4tGflGEC5N9yng==
X-Google-Smtp-Source: ADFU+vsckDP0Dvl431wH9uaUHyZsefqz41Ue7zk3ZqduMffgZs5KnudT4xkuMS4JDN2i/5ykYdd5Iw==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr14014394qvt.134.1584134632162;
        Fri, 13 Mar 2020 14:23:52 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u6sm1835931qtq.66.2020.03.13.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/13] btrfs: check delayed refs while relocating
Date:   Fri, 13 Mar 2020 17:23:28 -0400
Message-Id: <20200313212330.149024-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation can generate a serious amount of delayed refs, so we need to
throttle the relocation sometimes in order to keep up with the async
flusher.  We already have a mechanism to start over because of ENOSPC,
simply add delayed ref counts to the check as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 45268e50cb17..e3d6ba27663e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2797,6 +2797,16 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 	int ret;
 	u64 tmp;
 
+	/*
+	 * If we're generating too many delayed refs we should bail and allow
+	 * the delayed ref throttling stuff to catch up.
+	 */
+	if (btrfs_check_space_for_delayed_refs(fs_info) ||
+	    btrfs_should_throttle_delayed_refs(fs_info,
+					       &trans->transaction->delayed_refs,
+					       true))
+		return -EAGAIN;
+
 	num_bytes = calcu_metadata_size(rc, node, 1) * 2;
 
 	trans->block_rsv = rc->block_rsv;
-- 
2.24.1

