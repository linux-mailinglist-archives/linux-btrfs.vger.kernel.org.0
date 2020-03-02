Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C176617632C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCBSsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34149 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCBSsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id 11so762807qkd.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/79K2r7UQ+IPOm8ecXEGWT7bCqmELihCcGR8UpaCun4=;
        b=O1bn8CHs6HcYmw9x+BWZrn6A5pn8TMzL1V7HPXxJtuP2MGmGtVyPwyvVETnER/DSYS
         fIoGDH4Bj7jZBiuhTrw/jr0RZL0DrnqLnMxfnbhhowP5aTTqfl5JWnQG7GGQsU/hNboi
         cg83TYNHjv9oGHfl99WLGTSvQx7aWlsyA0oMHWuEPtTijkFDP5fvOWz7hVinK9VCpAMW
         IT1AkmgD1QoUwEG/IwDlVtz3QdMw2cB1E/Vs3I+CYdbIx9na8Z3EOK380TGcLEEe4g5B
         To8jiZ4jf0oatSpnYgBGXH30uPcgNB0v4WtQju3f7PTll0yplxzXVA16XaBa7MnMu7G/
         NfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/79K2r7UQ+IPOm8ecXEGWT7bCqmELihCcGR8UpaCun4=;
        b=GRXRl0JxQd0gkG5ZSiGbJ1NBd7einEMD+dyMx7D/Z6PyW16pgOH1CgwxIxoouq+xrt
         OY4VKU+x3z00qN//2AsHthqwoTayqVM8+1iLduIidoU9aefiAPfbY3ScPVt8p+PM1PNZ
         Ca8oxDM6W8IFTVCRy/GxEfhWFzdR8vEwb66AM2IzZU4bSxQK88jXD/t9+qkOn0tZb6Zz
         t8oo6Or2BPMj231Ob10z50FLzbuhZ8e3tNXjkbwXU6FZo0KwvuiRBoraGQyOOiCT5t0K
         Xi1FD7EXV+qlBHJHz7Hr9iPep9dEkEOBXLjrtuiROCTr25bB5eNb2W0di86/kUcShqdI
         BQIA==
X-Gm-Message-State: ANhLgQ0dL5iplIL5nf4FwZcMqNcaNp57hv4szmuwU0b5FZkEBlykzp7q
        AkT/ccjL8QHKaPsEfp7dKvIyRqTjigA=
X-Google-Smtp-Source: ADFU+vs0R/9APYv+Egx4vFP0PQ+NYjDEM2REVU4N0tM51BlFYOhRVxBlPiI9tCqm3ACWwQwQqH0NXQ==
X-Received: by 2002:a05:620a:13a9:: with SMTP id m9mr610448qki.359.1583174885347;
        Mon, 02 Mar 2020 10:48:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w83sm9890243qkb.83.2020.03.02.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: splice rc->reloc_roots onto reloc roots in recover
Date:   Mon,  2 Mar 2020 13:47:53 -0500
Message-Id: <20200302184757.44176-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have an error while processing the reloc roots we could leak roots
that were added to rc->reloc_roots before we hit the error.  Handle this
by splicing rc->reloc_roots onto our local reloc_roots list so they are
properly cleaned up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 173fc7628235..f42589cb351c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4710,6 +4710,9 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	if (ret < 0 && !err)
 		err = ret;
 out_free:
+	mutex_lock(&fs_info->reloc_mutex);
+	list_splice_init(&rc->reloc_roots, &reloc_roots);
+	mutex_unlock(&fs_info->reloc_mutex);
 	kfree(rc);
 out:
 	if (!list_empty(&reloc_roots))
-- 
2.24.1

