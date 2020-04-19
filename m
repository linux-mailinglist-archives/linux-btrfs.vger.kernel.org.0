Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616751AFB6D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDSOgx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Apr 2020 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSOgw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Apr 2020 10:36:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88993C061A0C;
        Sun, 19 Apr 2020 07:36:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so1268986pjw.0;
        Sun, 19 Apr 2020 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IDIECCisquzaV8ZCzfD3JDX13iNAOofTEfjuBz5AXHs=;
        b=GoZcy8G1ywtTQai2IObTXbl++Y9rRnRU3A0UVS9ItQ2F3pYP12laql/O2+D0uUnnAs
         INkylgOVCm7RYiMtbuSf9+6v1tN1eZRJWhubmClUmht5XC6YN0/i4jJFrIWlPF9BtDE7
         JD7hsWIPd1SmgO4b/y4Vq4ZGmGhsxcZoFViqKI7a89hamwjefuh9CjAj4HH6AHZ0YNhO
         OYuhSdUacmlppvSFoHMdEJyJAxg8m2p1c4Gk12t7f+ifLrCi1Ui5UHWx/SdnjO/SGPF7
         pAWirrJQU3QczQtFALznAhRuR/aMEUaGX+ld7z7FAiagzw7UUjodpEDhoxcJsJYkZqs5
         1wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IDIECCisquzaV8ZCzfD3JDX13iNAOofTEfjuBz5AXHs=;
        b=tqNBpFnfVTfJC3T2EXWdpFhRDwet+i/PNFOtWH0qtFK8obZxgBrpjBRn66oE1OXVLO
         YsgOtaRIRGIq8bMYY6ySSTA4JLf6/4Aa+aA1pbN5gsGvLqlcoIsPO6xKXMKKip7UvDN1
         NlUIMQnUMB9M17twhfW3Iv7yhDQS3sYWpaDEJWPI5uBETnxvRpAXVn1ertc3wc1hBuNI
         BxQR3s3OyeNWESoCWYXCJ8hL5tq04WNk1VcPG6LUlTlDeSxGyXh8MgKXRrAm2gnIAnMB
         WcrefbvTIFpmIgN+Z4cpRRkPXxti5MsWfluqm8Gt0jtNYzYxS9p0/mFgxt7VPhWnUBGj
         2QBw==
X-Gm-Message-State: AGi0Pubzs5GPt4Gakj99Qxduz137Z843FIRb9MgsKwDXx1Sy5+KuG4gd
        tJ1I+TRpfMaivTV3am8h7r4=
X-Google-Smtp-Source: APiQypLX6UyHOrp4l0hfC8oGW73twHo8Vy3OBCU5kUBGmwSiZ357qU52NzltC7QC4kWIJmEV7EpfQQ==
X-Received: by 2002:a17:90a:2bc9:: with SMTP id n9mr10246750pje.131.1587307011956;
        Sun, 19 Apr 2020 07:36:51 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id g2sm24672403pfh.193.2020.04.19.07.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 07:36:51 -0700 (PDT)
Date:   Sun, 19 Apr 2020 20:06:44 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Use the correct style for SPDX License Identifier
Message-ID: <20200419143640.GA8776@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Btrfs File System support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/btrfs/discard.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 21a15776dac4..353228d62f5a 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef BTRFS_DISCARD_H
 #define BTRFS_DISCARD_H
-- 
2.17.1

