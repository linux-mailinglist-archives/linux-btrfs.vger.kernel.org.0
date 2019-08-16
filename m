Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D054903D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfHPOT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:19:58 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41973 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfHPOT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:19:58 -0400
Received: by mail-qt1-f177.google.com with SMTP id i4so6224909qtj.8
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS6sU0SIUpfCSpbUDvqPwX250iSP0KR7XXpbICfqR3I=;
        b=V2IEUh+R+SabSd51LLIIK7itaV3gsQT5zaVq8TkY14qs3aVc+SD8xmrvnl0nABGqkE
         m0ePChlq5syukRn7D58xbvDwiu6A5V1KSq5n45MUs/61tcdqgHqhnXOoi4swFDFZdB2g
         wDyCUM0Y1dydezQEzZzF8fGfJDMTvqTiB2B5BbQs1V7nkDgbpks0BskQBZtcEErHJwhM
         gWDqHUzGdcZIH3QOLag5yY+tNpknhVVDlHd2O23hGdfujJvim7kkrq7C6u4hNBGDu50r
         3BpvahNdXnCyad/reQ1gBsDSl9sszkUlDb4Ye2Th5gz+Ls8U4w8DtMDqrCPaBHMSuSqR
         ef6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS6sU0SIUpfCSpbUDvqPwX250iSP0KR7XXpbICfqR3I=;
        b=fkgg3t3wfVSPtSgClEpqZtH0bqMmhTjfY4+UF2+VlyMRH1C7cRg0jGQGXM3d1MasvZ
         VwzZfQSTjWxyGPNHPAEtSJb8AW/z2mRDIdPKl8ZK9XLzQ8930R3RoNKUfvOAtAJ4EdUa
         0adNRHWJrrr8qnnPDstZMUzGeYmK7F9mxSfk2NAAIbd0VeqD0vF47EoZ817aJhxVHWSa
         3KsfXyG9VRr2s4YKdbpJMVv995NVfcGxV6E6l0AbTU+QzDo2Pytn8YySbzyFlh5cc3uv
         Cqovh6krvDmHQkU2Of4kxqgZ+x3y4Vvwt2P8huVeoUtoZZbNWyu/0+KmOI45Qfby4NCU
         O5TQ==
X-Gm-Message-State: APjAAAWfsAizPJds9tdk7rN37SK6qsIo3eQb/L9ygmoU92zc2mt1R1Gh
        nZ6NXM0sjBV4MinDZw1XvaTJb9TXkNEX3w==
X-Google-Smtp-Source: APXvYqzGSLfTR5/D5YyahGpOuqZvNEP9ALWIzqPqI6bwbeKHBk4j7akoA2YZeCZhBZ6fsIcVQmupFA==
X-Received: by 2002:ac8:2c5c:: with SMTP id e28mr9094983qta.159.1565965196416;
        Fri, 16 Aug 2019 07:19:56 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f12sm2903585qkm.18.2019.08.16.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:19:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8][v2] Rework reserve ticket handling
Date:   Fri, 16 Aug 2019 10:19:44 -0400
Message-Id: <20190816141952.19369-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Just some minor tweaks that needed to be added to fix issues introduced by the
next series of enospc fixes.

v1->v2:
- added "btrfs: fix may_commit_transaction to deal with no partial filling"
- fixed "btrfs: refactor the ticket wakeup code" to return true if we find a
  smaller ticket than our first ticket in the list.

Updated diffstat for the new series

 fs/btrfs/block-group.c    |   5 +-
 fs/btrfs/block-rsv.c      |   5 --
 fs/btrfs/delalloc-space.c |   4 --
 fs/btrfs/extent-tree.c    |  13 +---
 fs/btrfs/space-info.c     | 176 ++++++++++++++++++----------------------------
 fs/btrfs/space-info.h     |  30 +++++---
 6 files changed, 92 insertions(+), 141 deletions(-)

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

