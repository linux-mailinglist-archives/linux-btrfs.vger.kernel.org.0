Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA20F14892B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392743AbgAXOdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:06 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:33152 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbgAXOdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:05 -0500
Received: by mail-qv1-f48.google.com with SMTP id z3so992284qvn.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+YK1j5t6wMoCZuRgu/nSc3+OCHwo7lVekMtrOTxSFU=;
        b=PbEUkXrzuWlO1lac8U9NvE71atjnodKWihgrfi8MQMFngz0wxbDpzLRbszVxyiOE0T
         VHmMFckqjK3X4EGDahF3X9u1dNhylfLYYBVxh+AmLbaPvudLmLe0yWpODTZl+G842iI/
         uRlI1HdHE3GsSLoaUpR4c4SPsDQIH940k1vvU58pr/s2XU8eo3RvMqG+/AORjgpqV4+1
         HA+hlHHVsQcrkTY/NhaAtdL6Cup65RfiAuKYO37SDo1eCHmTenvS2CepzYus7wtafFzV
         O+/sFkOr1DYuUPnCYHZ5v5qTMtWUuSirEb4T/UdVBvBbTJaijMfDL75DNt6GXNQeAFza
         qE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+YK1j5t6wMoCZuRgu/nSc3+OCHwo7lVekMtrOTxSFU=;
        b=DRsSADl7cWLPyqu3PnUPm1jvLwvKeHOmqibuYL27P+doAMhDsOjybxegaLgxOx8AGN
         /tK5PYnImYSl1lTxXs9/e7BPWhR+pVhs9ePlBUEgSQ5BdF/TXh0crphhS5qI+ukSshbu
         fcMg6uSHsFDkkPyXkS52eyz3n0/l7xOWN9vldf4YNNwDqqxUbjwcZT1EtcvZmstHHpAn
         CXlFOS6fFYC7yQRkaimFYG8W4ZrXzOSO0Y5nie/jY9WP/QWRZjXzVPIyF3mVjkE6mvtl
         JU2Eln9LnUDsczBa3FYfT0Fhk3Z6r1xIh26yCmC4p5BbXjzAx7zbjDNhmOcTKwR5Spcx
         43Ag==
X-Gm-Message-State: APjAAAVRecnr11SmALhZ1LQe8LLQmRn0dLp0dqtTsRU+SXakdZpKcu78
        J9WrmoJYQ+oDrtGg18P8Uz9KgQ==
X-Google-Smtp-Source: APXvYqz0YPx6845r+htl/Onc+uJ6IKXnt8Cy7r+ncCqxXvr5a/F2I7maEjzkNyNNaM/D1fQMus5R0A==
X-Received: by 2002:ad4:4dce:: with SMTP id cw14mr3109854qvb.162.1579876384268;
        Fri, 24 Jan 2020 06:33:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g77sm511120qke.129.2020.01.24.06.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 00/44][v5] Cleanup how we handle root refs, part 1
Date:   Fri, 24 Jan 2020 09:32:17 -0500
Message-Id: <20200124143301.2186319-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4->v5:
- split out the btrfs_free_fs_info() moving around into it's own patch.
- updated a comment in btrfs_get_root() to describe why we are initializing part
  of the fs_info

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


