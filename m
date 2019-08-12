Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D68A554
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHLSGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 14:06:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55301 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfHLSGW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 14:06:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so385483wmf.5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4Y396TSD/u/Zf0NXmGYdFNwDpfJwZ713t3TiiSnVX4=;
        b=tXww7eeHEUJb3eY7ewRAWLk+VBF0cSYqhestxFhAAt50gNEz0KXjZMRE6eHlNxPoju
         KEKVgH3Vv9HR71NdA5loNgtLnxYiVKjQVXd1Q8WJayOvJFoD/GkA4MYoVszPg5DXlgAF
         gZ8QFX9mDGxrm3ASLDf2v3DNnDbr/ip2hIitl3pFyCSwlXSVWX2Tgc+ijM01YHuXJh46
         yhKz7hMMtzhEC5x8D8e8txfqdiuUQQFnLMMOlxC02S2OamcDD2pFOTtuYQMonQt8C0zi
         hd+enY5dz+S2naWBG2nlLezdxWJc4nF5VlZSVzeuPH+IwS5jLxXJg0gmtLimzrq7KXnX
         6h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4Y396TSD/u/Zf0NXmGYdFNwDpfJwZ713t3TiiSnVX4=;
        b=TL280OGPOvCczvuN23MKH1Az+7ZmpyVF33lLZQ/bxdof/ezmiURzHvPo8gJH5vZZn7
         IT4cXlba/PVnyUZ1MrBzxeSwlGluoOFSo++Gm40kTjypxJ5kuta0+taywpF4XEDRS9A9
         95g6w8qdaJOcnCelf8rHyCbEvMReXW1fwX/WmAbOpdH1qq4jVWXXPjLPY3vijo9PCL+R
         WYvRWqFCj9dhoTDBGnFLFVWbtaOxY3heKf3EIlPZ6v3ImvM5gXJePxAJ2enb/lsoxS+2
         cXir0iG2H8b/nRe/BXZ7d98hf+Nev9qQ9GaJ0Sa7gi5kdNBzjzFU1HLWmsqUA5zg9hs4
         r37Q==
X-Gm-Message-State: APjAAAW80XunjEteoZ/MaiqXezMmMSIx1S08iMWM4qIG2IQ3fyTV0pa5
        KOtgY3H1vPF85d6oxzb072CdtKpx
X-Google-Smtp-Source: APXvYqxCfKLsg1NLW/ePDBKDcK8el+Oltk+HrcrvQNkYwsrWQCyqj0o9AJU19ftqvi61KG8AijCFJA==
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr453906wmd.118.1565631492193;
        Mon, 12 Aug 2019 10:38:12 -0700 (PDT)
Received: from archlinux.localnet (65.red-83-34-150.dynamicip.rima-tde.net. [83.34.150.65])
        by smtp.gmail.com with ESMTPSA id c15sm53698659wrb.80.2019.08.12.10.38.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 10:38:11 -0700 (PDT)
From:   Diego Calleja <diegocg@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Remove unnecessary condition check
Date:   Mon, 12 Aug 2019 19:38:08 +0200
Message-ID: <6077041.Lag4Zllvab@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent_io.c:__extent_writepage_io has this code:

if (!compressed)
	...
else if (compressed)


Signed-off-by: Diego Calleja <diegocg@gmail.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1ff438fd5bc2..a53fb7b8a262 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3498,7 +3498,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 				btrfs_writepage_endio_finish_ordered(page, cur,
 							    cur + iosize - 1,
 							    1);
-			else if (compressed) {
+			else {
 				/* we don't want to end_page_writeback on
 				 * a compressed extent.  this happens
 				 * elsewhere
-- 
2.22.0




