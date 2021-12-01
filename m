Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1B465334
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 17:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351583AbhLAQss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 11:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351663AbhLAQse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 11:48:34 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC59C06175D
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 08:45:11 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id j9so22217229qvm.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awOk+s2CSznU+iXvWStAXFkMyWLMIfcvoAONwAoiQR8=;
        b=cjoXfq1lrXoe8unrzUqY/y+35OOuhuDgDGfY3pt+S5RgQfTvwNxU/QkT4vnYk4Nft6
         fb5Jl0OZZ9ek1/WdQEsCsbkt2PacM5ko3lVb6OxqNO48Ypn45CzmvX+I4gdvP1ZK5DkL
         tMcSvN0s+LgMJVr2m4Wcjea6F5gFxh/Ix2/hJfwoXgDLVyjM6NRaMQZH+RgbyKw3Dv8M
         8wNiTT3uqFpozdXY8W4WmkF3hj2IGUE/D7Bsp/WtQEBCllolvaiDaxZ9jeC3NxAQyhbq
         8f683OpoxpFqSORB5+N0RNBHfNzXY7Hj0YqiIiiJECiJIjBwNn/bSVRchF6GbAQXcPIp
         f2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=awOk+s2CSznU+iXvWStAXFkMyWLMIfcvoAONwAoiQR8=;
        b=tr7/mlwyxFOlcKVe1y6KcGNUgaGbUSiJxxwWFt52AdNh+XKIEfhXoQsOdpxeuyYAyo
         3pTj/eKf40yqZStP7MHrim1bzS6tTJgF0emQcx+B8bUuUyAFOh09bkBCtXdBwFtBl9Hq
         /pD94zBu3+ITcfBr8qkYLdVf6o4j3Evni5h0DYYz7K302MhBaaLMExzmzbCFRemyugE8
         /qQE1HtEl6Vdys5afGq++rT7B1crIrBZHL/MF4bJFWpX0qRXlQPZAvkTksOd1qruPFkQ
         YX4u2Hkz2Sn5JgtOLekiuyy8WL0Czxy4IPeJ8M6gIL69eN3GAKu1LpSGFQHnRrJ4YlPU
         Yoaw==
X-Gm-Message-State: AOAM531Jfu/fKsrRZ8OWspmYZWjKYnvGpB+UNXDGdZc8987uRW7AjbTo
        TrP57kd/TaCs2tNz43QD6b32ybO+o9tqpw==
X-Google-Smtp-Source: ABdhPJwuHiZZk6YV1VYphb9FzHO8xdEPyhLmUQS8yUaqVVWuqgq9BQ9psAsaBIvBHc9ywtCLpH+fkg==
X-Received: by 2002:a05:6214:cc7:: with SMTP id 7mr7339518qvx.55.1638377110779;
        Wed, 01 Dec 2021 08:45:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm141131qkn.131.2021.12.01.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:45:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Free space tree space reservation fixes
Date:   Wed,  1 Dec 2021 11:45:07 -0500
Message-Id: <cover.1638376835.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Filipe reported a problem where he was getting an ENOSPC abort when running
delayed refs for generic/619.  This is because of two reasons, first generic/619
creates a very small file system, and our global block rsv calculation doesn't
take into account the size of the free space tree.  Thus we could get into a
situation where the global block rsv was not enough to handle the overflow.

The second is because we simply do not reserve space for the free space tree
modifications.  Fix this by making sure any free space tree root has their block
rsv set to the delayed refs rsv, and then make sure if we have the free space
tree enabled we're reserving extra space for those operations.

With these patches the problem Filipe was hitting went away.  Thanks,

Josef

Josef Bacik (2):
  btrfs: include the free space tree in the global rsv minimum
    calculation
  btrfs: reserve extra space for the free space tree

 fs/btrfs/block-rsv.c   | 31 ++++++++++++++++++-------------
 fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.26.3

