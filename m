Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897BE465535
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhLASWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbhLASWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:22:16 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2554C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:18:54 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id n15so25027600qta.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rykeJEURYY+8Aa/E2Vbom349uFj/+pLul5anGpiNA8=;
        b=wEt1TZ9fhJ2wGq0JYY1/SiTsdYi+vABGq9rCB5fGEHTW4RemrjR2P1F5xhICUKAQHg
         FliaP+U9eYeRxuZ4UtK0D9VJKb6TTXk7+Ty9V2GGTX3BoZ9AeCIwMVnYPuqmlFDStVxr
         ld5HoHLvIaRIfJBFZjgIeIwZiIVRWXLuKFTew9WYA457Q5A+1e5PrN/Z0r8cCkKd7Rb6
         Qqf1CCOvhrrvHhN7bCtqs7CmrcnsXZxxPHuwAq65jUAtEtwOnP0ZO0BbCQna0HKtDiyy
         Uahhmsz8AVVGAPwcbCqPKoUk/1lDpEhE8smliLw0sYN8WtlCtCKKktsAUSiQTzQr0y3b
         Yvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rykeJEURYY+8Aa/E2Vbom349uFj/+pLul5anGpiNA8=;
        b=XOitFVXbHCconc1y6dUl8UdOrwvEQy7QE6RTeBz7T956DyB/0L1dzBR3DWD9izcwi9
         04o+2gvoNFwoGbVLYzZT6m8R6Qa+DWynCbJtAXMVr+iLsQSN/quF9rxXi3D2mo4BxX6J
         t8B2z+zr13U/NDfnXwJDcN65SMKTo3LqMyPSI6Y3gk6JhviDaNCf3l7RHtmVDr6LK8NY
         mxsHNmQj3P7mh6XGqAuagkcq/biMupV3Mj4achdgwC7D77J5PMRCTHni9osu1NJeKrO9
         j160mbaYxzOe8BcRlQSZR5oGCSGjii2H7seSxCgPA+kR/oloyt8bsx3BoNnNPxh0V/pB
         Bezg==
X-Gm-Message-State: AOAM531N8h5jAMq1uwff8aJPOE5ZX4fIcWqucHK0FyeC0BV1FEdExfiF
        sEhGTsPv+2cZLIYASxQhl1bkVGsSzaL+7A==
X-Google-Smtp-Source: ABdhPJxBIqgh1picyRW4lrWusJ2TZdIeMvGq1Rd9WzSW4v3844M9TWVFb9dalKEv/xPy4IsHrWiiiA==
X-Received: by 2002:ac8:5743:: with SMTP id 3mr9059118qtx.38.1638382733972;
        Wed, 01 Dec 2021 10:18:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y11sm283467qta.6.2021.12.01.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:18:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: UDEV_SETTLE_PROG before dmsetup create
Date:   Wed,  1 Dec 2021 13:18:52 -0500
Message-Id: <ebf63c27065c5fa676701184501353a9f2014832.1638382705.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've been seeing transient errors with any test that uses a dm device
for the entirety of the time that we've been running nightly xfstests
runs.  This turns out to be because sometimes we get EBUSY while trying
to create our new dm device.  Generally this is because the test comes
right after another test that messes with the dm device, and thus we
still have udev messing around with the device when DM tries to O_EXCL
the block device.

Add a UDEV_SETTLE_PROG before creating the device to make sure we can
create our new dm device without getting this transient error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/rc b/common/rc
index 8e351f17..35e861ec 100644
--- a/common/rc
+++ b/common/rc
@@ -4567,6 +4567,7 @@ _dmsetup_remove()
 
 _dmsetup_create()
 {
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG create "$@" >>$seqres.full 2>&1 || return 1
 	$DMSETUP_PROG mknodes >/dev/null 2>&1
 	$UDEV_SETTLE_PROG >/dev/null 2>&1
-- 
2.26.3

