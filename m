Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455BC99F7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfHVTLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:07 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:44254 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbfHVTLG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:06 -0400
Received: by mail-qk1-f169.google.com with SMTP id d79so6096110qke.11
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06ZL86zNKBP2+A+y7dDmZd+1AD66mj3VlyL5QgCiVB0=;
        b=WemCFZxRNCViDVQAz9+iURUDnmA1TE1qpkUqrqiIrMs2fdMOUzd0+663IR8OpkcrvO
         F6hta+ta9XIoloPoFyWrd94PdsqLf0uXgsCuHNY/jdULtGQjuk17Z7aPE3rXHMRj3Q/j
         0B1gr1rN+HIAG1OeATgNv+AXdbZdYc8SSnA/oQRsHO/AqG2JbgAnXj9m31/Dc+oVQBfR
         q4WBLK0mZeMJQpqLFV1j/2UCHERMCgDjZ8yFPlrftftJ3Lc7PQTMeoEKwJ7c7YUImu3Y
         o1i2D5yJBDov1NVVuSqx5JAv69cuno4Vb9F83GDls82rf5ViyuAo7sYEy9edPYwYASbU
         2pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06ZL86zNKBP2+A+y7dDmZd+1AD66mj3VlyL5QgCiVB0=;
        b=WU7boHfBuyTrckmmsALyxp+2PobZUoPP4RI+MdE2FsfZPS6NBZgyFCRAOxSP9BR9n+
         t1gkm7RfPbeQqG+6IXTySChtIhJzeOIZc4EaD8tM1wKQtScEA2kwLyGUY36sQRwytD+h
         GevADrPbtZO1uOZeu8pLQCHjiOK2d4KodAHZRo0FFndampTENjxM4eTF6p/88zBdmM7X
         pCdcmU4l3p7hikOtGlAIaCEavsOec7hVH5JnlZOowhbGSwKN/0OYAuaM2YPBhl7Ale6E
         XM4lKUZEQ5cjlcMy9cWEAJTT6tVI8zdP9xQyGoH3vsvwT79fQ+v4y7qNeL/PpEWrrBDY
         WGMQ==
X-Gm-Message-State: APjAAAV2/zukmG2qw6NArDjZa51sYRXseqVsouqn2Y3eWzblahCnqLdq
        63i/CLjOh/faW94DYW9ZVBrKzP69PfP8eA==
X-Google-Smtp-Source: APXvYqyP9iYT4BL83vpydkT1IQnkaFlUSmrzbpRgf7F5hM6+r9xmdDmQYdsyhNLwMYaLjbFcd0BnUw==
X-Received: by 2002:ae9:c00c:: with SMTP id u12mr526763qkk.75.1566501065820;
        Thu, 22 Aug 2019 12:11:05 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r205sm272250qke.115.2019.08.22.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9][v3] Rework reserve ticket handling
Date:   Thu, 22 Aug 2019 15:10:53 -0400
Message-Id: <20190822191102.13732-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the next round of my reserve ticket refinements.  Most of the changes
are just fixing issues brought up by review.  The updated diffstat is as follows

 fs/btrfs/block-group.c    |   5 +-
 fs/btrfs/block-rsv.c      |  10 +--
 fs/btrfs/delalloc-space.c |   4 --
 fs/btrfs/delayed-ref.c    |   2 +-
 fs/btrfs/extent-tree.c    |  13 +---
 fs/btrfs/space-info.c     | 171 +++++++++++++++++++---------------------------
 fs/btrfs/space-info.h     |  30 +++++---
 7 files changed, 98 insertions(+), 137 deletions(-)

v2->v3:
- added 9/9 to rename btrfs_space_info_add_old_bytes as per discussions with
  Nikolay.
- added a few comments.
- made the logic clearer in the may_commit_transaction patch.
- a few lockdep_assert_held()'s.
- added the reviewed-by's.

v1->v2:
- added "btrfs: fix may_commit_transaction to deal with no partial filling"
- fixed "btrfs: refactor the ticket wakeup code" to return true if we find a
  smaller ticket than our first ticket in the list.

- Original email -
While cleaning up some things around the global reserve and can_overcommit I
started getting ENOSPC's with plenty of space to make reservations.  The root
cause of the problem has to do with how we satisfy ticket reservations.

Previously we would add any space we were returning to the space info to the
first ticket we found.  The reason we did this was because new reservations just
check the counters to see if they can continue, so we didn't want them to get
reservations when we had waiters already queued up.  So instead of returning the
bytes to the space info, I'd add it to the ticket.  Then if we failed to satisfy
that ticket reservation we'd take any space we found and add it to the next guy
in case it satisfied the next ticket reservation.

This works generally well in practice, but there are several xfstests that run
ENOSPC tests against very small file systems.  These tests uncovered a corner
case when it comes to overcommitting.  If we overcommit the space, and then are
no longer allowed to overcommit, we won't actually give any returned space to
the tickets, because that would be really bad.  Instead we return that space to
the space_info and carry on.

What was biting us in these test cases was the fact that we had very small
metadata area, 8mib, and unlink asks for about 2mib of space.  If we had
overcommitted 8.1mib, we'd give back almost 2mib of space to the space_info,
which could have instead been used for the reservation.  This would result in an
early ENOSPC.

Since we are only doing this partial filling dance to avoid racing with new
reservations we just fix that race by checking if we have pending reservations
on the list, closing that race.  Then we are free to use the normal checks to
see if a ticket can be woken up.  This simplifies the code a bunch, we no longer
have to keep track of how much space the tickets were given and return those
bytes, and I could consolidate the wakeup code into one function instead of two.

The diffstat is as follows, this all passes xfstests, and sets us up nicely for
the upcoming changesets.  Thanks,

Josef

