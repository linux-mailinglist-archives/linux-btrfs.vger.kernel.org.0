Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8F2CC6E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgLBTnt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLBTns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:43:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056BEC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:43:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so11711855wmb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wgBfabbjppL1ty/8xY8ZaEZm4HnPJAonwn8OJgihTs=;
        b=KYysYyQGe88hneu+/IvfJppD462OB97PBIz9PRwhrpwznpbEBiloYhHRXk/p2yseje
         Tmzim1eCgtvMWRoD76m7+jQJaz8SSkSoyy2khFiOhy1LK9erUGahy+ki3FryIFkWYQBT
         h29xKzC5+Loo8slc84xl/PDC/+bJs3+dLISA9E6hYX8LaED3h594J09zKcPBjocXaxoe
         9sIRSJjth9d1XImtvuO9OdahsHqtMZptb8YCS0BS60WXqUSiI1R9Sf8NqHw/J0LwpdXZ
         ZioKbxgsJnRqkwlBh61Et/Wr2kJSZxlffdK8FSV/87CyWo11DZ8RvgF2Poxcg1UG0KR6
         UYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wgBfabbjppL1ty/8xY8ZaEZm4HnPJAonwn8OJgihTs=;
        b=i9gwHD/u3IrWlH16fXkL3/P8hBgQxv+DGhYGS04VzHZGHRvCvMnUrOBonXqjMrZTVv
         RCEalrdgfxnz1NYDk1Xth+n67MAdluL5WKI1qIoy1xvJT6mOuSsBTaTNrZGa7s7U7SvF
         sz5h6N0B9KPbEUjwhCXCq+EocVq0zG7o0IX3svmfki0k4yWZ0EgyjVNktImch3bqyrfg
         1ASDYTRbVygRSUD4m5pPZbTfMgT8SOhslFeXUtxQR6o/LDnvv+TXikJ4oDQexPRF8C/u
         DlN46P3j9YfM0t7YZI3KcKwFWIc4fIsasRFRO5o0w2eMcgW0y0jbLFu6ROf8gsLYLlou
         2ZTw==
X-Gm-Message-State: AOAM532szWJg3nh8dZIiBfLSMHeX5wdUCaBB+yxp3BtZas7XI4WU3p4f
        SMG6fTfhTuIV388kSYcQaew=
X-Google-Smtp-Source: ABdhPJyR6YBoExGeQ2K6FHJaYXaqhQWxbuTgJRMVdB/JyJbcmc1jiOjJYVA0xOgljWtB4mmaDxOE8Q==
X-Received: by 2002:a1c:2c88:: with SMTP id s130mr4787589wms.79.1606938186696;
        Wed, 02 Dec 2020 11:43:06 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q16sm3251540wrn.13.2020.12.02.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:43:06 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs async discard fixes & improvements
Date:   Wed,  2 Dec 2020 19:39:40 +0000
Message-Id: <cover.1606937659.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2: fix async discard stalls [1/3]

Two others are same but rebased on top. [2/3] fixes not important
stats torn reads, [3/3] saves a bit of locking.

note: based on for-next

Pavel Begunkov (3):
  btrfs: fix async discard stall
  btrfs: fix racy access to discard_ctl data
  btrfs: don't overabuse discard lock

 fs/btrfs/discard.c | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

-- 
2.24.0

