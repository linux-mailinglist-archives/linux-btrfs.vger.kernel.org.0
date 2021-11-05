Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA29445CD6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhKEAC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhKEAC6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 20:02:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D66C061203
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 17:00:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id r5so10005880pls.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 17:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UA0mPJJ0u0DYEI3KJNY4+zI+ygxZmfbtEQj5gChrj4=;
        b=DDOy3OKcTysbAR03SHEyCew13Et6zvtmPAoF38kifWBfkhXkB9Vu1iJRrP/5sSUXIK
         N6TJCYzDn4p7Cknsn4CZrNKQ7j475M5Te2eBbFx2hM2k6k8K5K9rOQya+oQDc5CazK4A
         WL1SjqftpeTuhuuLNThIgKkrVEEkYU1pixUs36n6f00rOpvzmL1u2U3ue2QVHV3eC1h5
         8wZKomPtY3OG8R84LY/dkXDAQFwW8854A7Mu3nSp8VZXCUs/8bNhgd9+AyxOFFEVERlc
         7o9mXRZlnHwU5vOmIA/gxU1mxJ3F7+Vu8LMMOxheDxhE6oiFxDJy2nDiJ9hK3797zX52
         XrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UA0mPJJ0u0DYEI3KJNY4+zI+ygxZmfbtEQj5gChrj4=;
        b=ePzWmLK7TOwTV2LivUq0edyIBTmo2g/0HHQHeJAXozeXPQUWqsMC2iTYFTmnwvSYk3
         BvIlQBaw8aFRKpyqXozswIK5P4ytGBHj+wMc6SNAyuJBZ2g6SEQx7FDYCa32RD0Xj/I4
         nL6/sM/Hi+ox9/fyHfK7YsSOWwPIVsPheoJLhr2t2wAiHEooevd4MvVBE493F73+TgPe
         m6sJk2ovCToearDaNEzAIvwAFZyxdBz2TI8SCiX9AiFTdQ0bz0rnoGidp9bPMbkNKw50
         Fc+3ErkTIBMHWjTzcHDtakIUOXVFM5+hliQ1pGQ3iNzQN5a4K1tALMkJiz4ewoWS+rQX
         JqPQ==
X-Gm-Message-State: AOAM531HEQbYfqsS7LY6o1AyjRF6ZabUanwqYvDyzjQxvTOPMGH92A8Y
        DoUBcH78iwbOwptUDquoemgi4tl1tEeTRw==
X-Google-Smtp-Source: ABdhPJxb/i9T3Dv3y4bBfYuVhcOkkM/vXmxEXGmiZqIJkLmKuMCpxL1pZX8U5W/v0EPUjWH81EI4xQ==
X-Received: by 2002:a17:90b:1643:: with SMTP id il3mr18634067pjb.182.1636070417819;
        Thu, 04 Nov 2021 17:00:17 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:294c])
        by smtp.gmail.com with ESMTPSA id b28sm4620962pgn.67.2021.11.04.17.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 17:00:17 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: send: two tiny unused parameter cleanups
Date:   Thu,  4 Nov 2021 17:00:11 -0700
Message-Id: <cover.1636070238.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

I encountered some places where we pass around btrfs_dir_type()
unnecessarily while I was working on fscrypt support. I might need to
stuff a flag in btrfs_dir_type() for fscrypt, so using dir_type in less
places makes it easier to audit that change. Either way, these are
unused parameters so we should just drop them as a cleanup.

Omar Sandoval (2):
  btrfs: send: remove unused found_type parameter to
    lookup_dir_item_inode()
  btrfs: send: remove unused type parameter to iterate_inode_ref_t

 fs/btrfs/send.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

-- 
2.33.1

