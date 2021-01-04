Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB782E97F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 16:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhADPBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 10:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhADPBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 10:01:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C6C06179A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 07:00:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so18738054wmi.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 07:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zX8HfL31wQZp5jl2djKi9uuAu6EFw+BifBJL8TfPFYI=;
        b=iZ+iMncSyLwlAaQXDZtSclG1TAiabyBIgpxpm6gwMhtwbK9uLIPw0KJkoz4mOk9f0F
         rHnD2/9O68rmG8J+8w2HgaVnFZ5OEFNHNYLnPI+b1SbXBAU263EFyuSKd5cB4ybDV2Tk
         Q2Ucnog/Ug5GYE+l8FlOnNY6Dt/g0EgWKtnjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zX8HfL31wQZp5jl2djKi9uuAu6EFw+BifBJL8TfPFYI=;
        b=nduVNL9y4qO+otWSJEmVPWyLuTiEsu/m/UeMXM7ZbmuA+5Ots0+Ix15svwSMLIkPhs
         2Nvnt+fimQgl/qf9jqADZgqw6VD9jgMND8L+MUOHrBuCeLSLKbUlsgjvzOEnMTAIQYir
         jFTLT+8kMXOykQUWc/hnLmyottDPrvETdqgNANKp8EAXrDfi3bIhblTLXKv7eB/3qHk2
         /fgmAdujm4HZXOHPBot/4ZOVXOGvNKByKyFKTGyhdIWk9UU/wamuSYApbckwmOQk36S8
         fPcbXlSdJUF/nunOBEXpPm3WnilWrbCFG1jkBibqHwLpR3ufsTj1YI5QWUkuFCGFgAt6
         H0cA==
X-Gm-Message-State: AOAM531Fo0VG3aZZaLBzGt+hzWRkL1TSK0GZ6cu/c9FtVwUSZZmjeXV0
        mpTqTam5EWxk5YlmVTXDGimfKg==
X-Google-Smtp-Source: ABdhPJyZ7mnenRW8F7aJHWIfVzmZOehv2AMU4Up9FryPAzuecSePdIqVbZnPsKBWirVBfeRygVofGw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr26716903wme.72.1609772404590;
        Mon, 04 Jan 2021 07:00:04 -0800 (PST)
Received: from dev.cfops.net (165.176.200.146.dyn.plus.net. [146.200.176.165])
        by smtp.gmail.com with ESMTPSA id r1sm94445954wrl.95.2021.01.04.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:00:03 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        mail@maciej.szmigiero.name
Subject: [PATCH v3 0/2] dm crypt: some fixes to support dm-crypt running in softirq context
Date:   Mon,  4 Jan 2021 14:59:46 +0000
Message-Id: <20210104145948.1857-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Changes from v1:
  * 0001: handle memory allocation failure for GFP_ATOMIC

Changes from v2:
  * reordered patches
  * 0002: crypt_convert will be retried from a workqueue, when a crypto request
    allocation fails with GFP_ATOMIC instead of just returning an IO error to
    the user

Ignat Korchagin (2):
  dm crypt: do not wait for backlogged crypto request completion in
    softirq
  dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq

 drivers/md/dm-crypt.c | 138 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 15 deletions(-)

-- 
2.20.1

