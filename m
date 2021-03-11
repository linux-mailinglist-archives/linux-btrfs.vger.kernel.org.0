Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C946337938
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 17:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhCKQXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhCKQXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 11:23:21 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500DC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:20 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h3so2801172qvh.8
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 08:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NM3nnOE1zLE0lT6z8sOa23/HrGz4g7tEBeuXVUEo6j4=;
        b=Aua/4VDPTLesJHtQG+88bC1dM2szh7qQl/Efgl6UTUgquF73rdKCMOgcHckudk/Akn
         FgeVK0Pvo8vZt46S6EJ7OjMc/GbU11FeYUxZfk9MJWp173/UYLOZph/HRjIyE2QV4pRD
         zkBcXazr13UPNc8kM+RtpzQ921fW6ORwV3WBH0k0A1fbP9t+9pLdvPA5DL63ou8r2YVh
         aU0wOXsE9ugFeAhXX3+a5D74T4PSoKCgdGGkK5eGSW7DhX+DmUQZrljzp/0qGnZm/OcW
         Q9bvBYMqwyH8vmGKlRHzw6AYtRR+mm9QqDtayhVYYtz4GftO8+PRPycSMMIlJyenNVD8
         VE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NM3nnOE1zLE0lT6z8sOa23/HrGz4g7tEBeuXVUEo6j4=;
        b=U3ix0vZa4wp0kAvzMMGUjqbPh+dMno6mPvtqUMABhTZpRNOu5978x+NG2TDm6Hl4Ao
         UPzxfsSprAY4ojl08AvdU/QkTZv60/xiAGbLeKWpRMYktiIZekb+zbGrDxizuwNbvqeR
         28JT6hsOHXX+f18hkvn7gssrZTLx/SFio+WHUdv1VidWXeBa15t/2uHDgSacvWgOWL/Q
         PCgBAb6Fk/KGhbJKZoXSThuhDOnSTa4lseoaiU8Ugrh7vZguAKEDOUKOqUwrJsZaZNK8
         L5HvRBtPJRvUZRq5RD5GqXmltclHA+w9h3AuvPxdiDZZuDTM9ewnMrTCE90lSyBlIXLd
         /vJQ==
X-Gm-Message-State: AOAM530jpRY0t2uC37MxsKP3PuyFoIAwvuFO32Ma7y2r4os+/nLIfEl4
        MNyh35+tTPK3LThdxhQ9EUPdlJldK8yEoPMN
X-Google-Smtp-Source: ABdhPJw54Cxof2ybQ/2SQsjr6Jc9s+XvS1RWNjbWDNdG5pEMbHg5fXTkmFqVEaH7Cu+i3vmC7LLV3w==
X-Received: by 2002:a05:6214:1424:: with SMTP id o4mr8445713qvx.34.1615479798968;
        Thu, 11 Mar 2021 08:23:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v4sm2041946qte.18.2021.03.11.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:23:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Handle bad dev_root properly with rescue=all
Date:   Thu, 11 Mar 2021 11:23:13 -0500
Message-Id: <cover.1615479658.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

My recent debugging session with Neal's broken filesystem uncovered a glaring
hole in my rescue=all patches, they don't deal with a NULL dev_root properly.
In testing I only ever tested corrupting the extent tree or the csum tree, since
those are the most problematic.  The following 3 fixes allowed Neal to get
rescue=all working without panicing the machine, and I verified everything by
using btrfs-corrupt-block to corrupt a dev root of a file system.  Thanks,

Josef

Josef Bacik (3):
  btrfs: init devices always
  btrfs: do not init dev stats if we have no dev_root
  btrfs: don't init dev replace for bad dev root

 fs/btrfs/dev-replace.c | 3 +++
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/volumes.c     | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.26.2

