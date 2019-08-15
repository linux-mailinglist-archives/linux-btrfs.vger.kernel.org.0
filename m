Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278E08E28D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 04:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfHOCFl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Aug 2019 22:05:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34297 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfHOCFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Aug 2019 22:05:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so124990wrn.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 19:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gktrOLgK1cW8HxO1cePp+Bj06cm3Fvqf9Dpvbx1X9c=;
        b=chNELzuCnMxHpECYWhAI/8kqR/0qeXIWWU1UT7FR1yA71vE1+mF9p23lE8sqh+lm2X
         9STBCQmz5mdl1QH4DxFrlHRO6ijoIoBv5XJ4i9DQSUQLGAydtleBnmg2dskidWbRSWjY
         1Z4GbahmVMcZcm7bd+fEOlCqCpgvbmbnrwfHKRbuAjj38H5l10/BPrlJ6Ktir+6/q6ju
         wt0MUinXVjQ2RF2rbYQbyznQLdZ1jZuF95foXP7SwzOXvl+0ib5LS1Rzkrvrs8l5r4Ii
         cBQYbY9muvQPeWkWOGdaa0xPUmL+3Q+DRUL+majPiTjzcLpRju16MT/dNUJgnXjH6CXy
         dxJA==
X-Gm-Message-State: APjAAAViHqMUByNL/AgZ83qt9Cll9oZ0Kmk78DfhSLU2qp3+egMoB7Id
        L5YaIrX9tiCjs9yV97pWkq8in3fo/EU=
X-Google-Smtp-Source: APXvYqzfglhHpTh75iNsw3WYHsicSZo4qKwMsIZWdfO6z6EWj20OKF4SmA7OP0gZ8q2lipOeMdkpSQ==
X-Received: by 2002:adf:f481:: with SMTP id l1mr2511239wro.123.1565834739376;
        Wed, 14 Aug 2019 19:05:39 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id i93sm2130676wri.57.2019.08.14.19.05.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 19:05:38 -0700 (PDT)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH 0/1] btrfs: Simplify parsing max_inline mount option
Date:   Thu, 15 Aug 2019 02:04:52 +0000
Message-Id: <20190815020453.25150-1-git@thecybershadow.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A nit I noticed when writing the global_reserve_size patch.

I'm assuming that rejecting garbage in mount options (where it was
silently accepted before) does not break the first rule of kernel
development?

Vladimir Panteleev (1):
  btrfs: Simplify parsing max_inline mount option

 fs/btrfs/super.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

-- 
2.22.0

