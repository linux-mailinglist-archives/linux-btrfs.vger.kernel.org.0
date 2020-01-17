Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874701412C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgAQV0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:07 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:34737 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:07 -0500
Received: by mail-qk1-f175.google.com with SMTP id j9so24186987qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HSv1AHkh/8Rs5/GAdIyRxzjbENu/Ec1VAz3bzFH8jO0=;
        b=G0+myEuHtfmQ/wTs7NTMEcaoqHs8V9TKFWpAkKgR45dBhaSduPNGoLkJu2ltHzEeEs
         SlDtH/3Jq894zo1QTrm/Wa3dn7bUXfD3F3SuuWMQe+DXPfBhYZ2JICm/4KuDgIuCsSAS
         TQbDxO4bCNawOu8tfIWwIGehqoXDiYr13IABOETToWUvB4eJobnXFm2D8NC07brCx0ei
         Z54XW/x4ZZVRErcL7f20XjICgVYQPmvrlYOHOYK+tZZwPmLPRDAP1B64Sd/98qqDIl/d
         8ct82VGS0XM1RdbLMcmMbVrm20ejlir3GTy/mH+Erm0+zPKn8frzgAiM7bj2pkOdHLd9
         p6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HSv1AHkh/8Rs5/GAdIyRxzjbENu/Ec1VAz3bzFH8jO0=;
        b=Uo7D1RH76dumabUzyshGdxBqrO+A/uDiQxgROZZCLu72J8IsNF9LPleOObdsCHOryO
         ZOo2wW+vcLgEWpy2JxQ510tDXom8XGgZ6zB5YV7IXuaabWpTdfAqx2NkGnxK/M60Vgqf
         lDamcUiluphPD/91egyKWIIoLJPu7ug3pVq0ki82R80RXExZQn4y4mBfT8RoiJWhDM7j
         5bnlfBxqm1MM5F3K2bd8sMrsfyTvmX4StQLpOxZfNPWsFGaXW3iZLYEncGhA8HNMAP75
         zU0uyAeXJeVNST0WCG9pXFHrCEHnBOvO9wIww5Ouf2kWNe4mhDKKrVrTneJ8Ug3j6sgU
         GeDw==
X-Gm-Message-State: APjAAAUPU3Bl9mMvy/nri1ZK7jRMa0iGZthxjrZU7TzAJLFiWG0oIN1j
        X7Z0snaBMth5oPZFD2rovapuFWkDrOfTZQ==
X-Google-Smtp-Source: APXvYqxqBB/smwJEcuL+Evsp2aipiVDfMJ3ArruLdoy82muwjUNFNKBU5glEk4TC3NFP5TuYHW2koQ==
X-Received: by 2002:a37:a348:: with SMTP id m69mr37949013qke.343.1579296365642;
        Fri, 17 Jan 2020 13:26:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i90sm13633638qtd.49.2020.01.17.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/43][v4] Cleanup how we handle root refs, part 1
Date:   Fri, 17 Jan 2020 16:25:19 -0500
Message-Id: <20200117212602.6737-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- "btrfs: hold a ref on the root in build_backref_tree" I fixed it so the
  backref nodes hold the ref for their respective roots, but I missed a case
  where we grab the reloc_root, and thus freed the reloc root too soon and it
  resulted in tears when I ran my stress testing on my tiny box.

v2->v3:
- Rebased onto the latest misc-next, so the snapshot aware defrag related
  patches got dropped.

v1->v2:
- Fixed a error missed put in an error condition in relink_extent_backref
- Added "btrfs: make the init of static elements in fs_info" so that we could
  clean up fs_info init and make the leak detectors work for the self tests.

-- original email --
In testing with the recent fsstress I stumbled upon a deadlock in how we deal
with disappearing subvolumes.  We sort of half-ass a srcu lock to protect us,
but it's used inconsistently so doesn't really provide us with actual
protection, mostly it just makes us feel good.

In order to do away with this srcu thing we need to have proper ref counting for
our roots.  We currently refcount them, but only to handle the actual kfree, it
doesn't really control the lifetime of the root.  And again, this is not done in
any sort of consistent manner so it doesn't actually protect us.

This is the first set of patches, and yes I realize there are a lot of them.
Most of them are just "hold a ref on the root" in all of the call sites that
called btrfs_read_fs_root*() variations.  Now that we're going to actually hold
references to roots we need to make sure we put the reference when we're done
with them, so these patches go through each callsite and make sure we drop the
references appropriately.

Then there's a variety of cleanups and consolidations to make things clearer and
make it so we only have 1 place to get roots.

Finally there's the root leak detection patch.  I used this with a bunch of
testing to make sure I was never leaking roots with these patches.  I've been
testing these for several weeks cleaning up all the corners, so they should be
in relatively good shape.  Most of the patches are small so straightforward to
review.

This is just part 1, this is the prep work we need to make the root lifetime a
little saner, and will allow us to drop the subvol srcu, as well as the inode
rbtree.  It doesn't really fundamentally change how roots are handled other than
making the refcounting actually protect us from freeing the root while we're
using it.  That work will come later.  Thanks,

Josef


