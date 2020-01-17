Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73012140B5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAQNsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:02 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:39839 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:01 -0500
Received: by mail-qk1-f175.google.com with SMTP id c16so22690524qko.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbMx0zXOpZrfd63TuxI5Lj+u5aAI/72tFJCdY/EdqEI=;
        b=J5naBsMHrC9GqOcuURZfFQ0G83W5wmI4K7izfq0qW6JjQwua9k9uBRUhgYI8/ZiF43
         ptC2hl6EGxZGz+jRbbgmLQhfYsg5Kb522BObnUx5LYNAA8MdwgAOirUJHj2A0qU/RGml
         ir++apfeOTJpCd4/FQCNPBob4K36bZOg+7dPeN/lV6CsIs60GTbnM9z43eqqP34HVf2O
         bPyd8B6Z87E6tcJitcM7tcPe5Iby4W79ySu0H6DYHaOsqDcVnolUURXPpKYxgOR41IGL
         tAf0VyZksPH5vAeNiJJiycvUJ29mxIfZjJ/fBmCMYnpYmEL9jDdjCZSamkhGIaItJF9Q
         ZHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbMx0zXOpZrfd63TuxI5Lj+u5aAI/72tFJCdY/EdqEI=;
        b=qSMxoDlfYPVIR/wqB0rltQ+xtnZuCMkSfuKHW6FWCj38u5kSLRSgw9EAeNRzkWKXuP
         kiIcml+kN+QwpUIGRqmf6e1+Xn5YM04A+7ob0DZXiedLcNDYhYB4c2eKhMLZlSjuap7Y
         xjkaaBQEubo4emu6xbBms/d+ugp0nWNMXJa+Qt8fKsGu0m3okbbV3nwMt19k2AffyF1e
         rMkKtNvGxTlEeBm1AOev5zcRJQ0xMbsU5SLlx9QNeLjCo44A+ylH5bu2e1XE7OTZpb7Q
         KGL9FDYnGhZI+HbaIIj+GAHrD6DZON8WcXFAwpkPXbQWVLx13gvUpffVIUfdkgH3SeuS
         3o7w==
X-Gm-Message-State: APjAAAWJ1i7Vy7rpt3LBiNI+uN0jsPXJVEfSyCvZMt7ZLANpmVAEegOn
        q2NJd80T2RDaP61CdeZqjfzutG53ku7dxQ==
X-Google-Smtp-Source: APXvYqwgjY3/7IBmT3GfFrCgrIfPlAw7Gb9jvFKkQWD4pnngdCbRyyzdSfKw+Xv5rXMOVAVXjIBiiQ==
X-Received: by 2002:a37:de05:: with SMTP id h5mr38751511qkj.474.1579268880574;
        Fri, 17 Jan 2020 05:48:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f19sm11654502qkk.69.2020.01.17.05.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:47:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/43][v3] Cleanup how we handle root refs, part 2
Date:   Fri, 17 Jan 2020 08:47:15 -0500
Message-Id: <20200117134758.41494-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

