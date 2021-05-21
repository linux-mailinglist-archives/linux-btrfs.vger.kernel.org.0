Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5238CF36
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhEUUpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhEUUpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:45:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA4C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c10so16266744qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxrRymjE7rUMzl+xohv3yd7zKoKhvmPtDLmdYVqcYPM=;
        b=Ngnd5jSr2KIRtXwUv2qC1j1LzeBiFsusNBy6npU1E5dj7mOfRMJH48f9Ba9HUcVFe8
         m5b/SCFKrKmuy06W3LnOuIOgmlcjsE5Gfz8Z800sbyoudXpia58R0dhae6H5+1MTfGdH
         hEoPAPI7+iJEfgNDA5aTSvWMn9yHvrk/K6w+YD3wAWzbRznrviTVUwLzB7mwUxF+7XOp
         9ltPj7CyBKe2XFBQgrRxfE4O5WFpT3DZyrWh3+mwibllZM/jbRu7x4uOAE8p2VpYi6ts
         YgL8DFhuWAjbzP/4t+x1rh3+7ChyzpJQVDEcS+oQx+o+d8pAHPIBG9gLs/9VBy5H/G3s
         XReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxrRymjE7rUMzl+xohv3yd7zKoKhvmPtDLmdYVqcYPM=;
        b=fpg2WAVgIduClQbpd4fU4a1+aN7MpvUVmTGbPItGV9zUFYtNMDyID/k3+YkNf/0p2s
         QRaXL/n4Q8apng94HQOQheRvHz+bP4QjAQEg70kKY8JtX8no/Ecrkl6Cpa+HhjNCVJQK
         jIQ4oPjBKagAwCTegO4zkgIzKg0aOYrw8TIMmOA38zms+wuf1iMR+DnrbLRKucSqX0oS
         X/4EfAJp3gD9gZyrNoHcWi1pEOXNYfjvKp2gu3kglVIn/ACb1r0gYbWGD3GgHGBUZHUH
         qJNJhLeo7PA27PEpQEIskpIoKUw1n0yIZ6hH91vJAzNnoyGI1svRrBAc3tA2ij8f4Ryx
         kqRQ==
X-Gm-Message-State: AOAM532Gjit+BqrYvOIFUNaBiOsa2Kg63UQjXJR55NwpyiKdJmQrVmYs
        FL0mE9ODrDQqU008FAl5NE51pc3rfb7/3A==
X-Google-Smtp-Source: ABdhPJwaHOoWf/66gu35Y4scdHK3VnU97coxA7YcprEvxqrcQ0m3+yRSBkbakTXpy7c4ZIYVa4eFnw==
X-Received: by 2002:a05:622a:11cc:: with SMTP id n12mr13710933qtk.251.1621629851069;
        Fri, 21 May 2021 13:44:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 28sm5981106qkr.36.2021.05.21.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:44:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Delayed inode error handling fixes
Date:   Fri, 21 May 2021 16:44:06 -0400
Message-Id: <cover.1621629737.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Here are 3 straightforward fixes, but they rely on eachother so I'm sending them
as a series.  The first changes how we do cleanup so that it can do the right
thing in the case that we don't have an iref, this is to make the code cleaner
in the error case.  The second patch is to fix the error handling in
__btrfs_update_delayed_inode so it actually does the proper cleanup if there's
an error.  And finally the last patch add's the abort() we need in order to not
leave behind improper inode items that trip up fsck during error injection
testing.  Thanks,

Josef

Josef Bacik (3):
  btrfs: make btrfs_release_delayed_iref handle the !iref case
  btrfs: fix error handling in __btrfs_update_delayed_inode
  btrfs: abort transaction if we fail to update the delayed inode

 fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
2.26.3

