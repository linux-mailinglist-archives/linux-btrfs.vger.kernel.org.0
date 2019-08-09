Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBC87B32
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407103AbfHINdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:33:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34151 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405928AbfHINdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:33:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so26634046qtq.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdWFpG1V1ZZZ7a+mKcpK4NaooJD1ZlM/t3IdK+lR17Y=;
        b=aYCu+IHBGaTO0fOrhpDCwah8nt3ntidKa9t7Zg1CVu1FJg+BeWcblbB0s9T+OkMDVD
         uMU+DdYeSqq9xohf7k4yOxgHD8P5ALEwsPMs5Jckg5sAt4Rx0owZAdlqTzi5fKa2PBvc
         tjRWHpooSRPy3hqC1MiXUNMQJHFfodzNKVHvtdCKNhqZr/o2WgZGI7sRUolGaaxClAuL
         HlWUhYdKrZCr72bFHrHzGnenh4e385eMnmyrD7daa0N6Upxp+SWlvmEb+wzXKGWmzqtv
         6qSXtpf/pfXrxC94eGJrrqolD/tRT4uxFGzwVaUppkfsWgFoSrCHV4VV3il1hzaxprdT
         v5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdWFpG1V1ZZZ7a+mKcpK4NaooJD1ZlM/t3IdK+lR17Y=;
        b=MjYJCt0xDCF2ql0iqMwkDhSuQVM/P3x/ytKkS/R47C7pngbWElKdMC7Dhg6oJUFW1m
         9Z5ZSdMBmUJC00h5Rvr1MnncHmAU5n9Vm3zBktPXhpy67FLy7T3Ws+2JBiDNXIvhJ6q7
         FotStxjrh2yDWjVJwvSJh5lzw5NbVyvvehtjPZlkgH/NrSd4DpIi9xYjLSesNQFmeHdw
         03HsO328w8UpWpIKCAUrhW8b938iEBopsiky9MDLoFTyGF5pavSPeNHPJIy2T6EuQVaX
         lXzsoS0YcnsCNn23iaEp5IYbXFT/q2OJx03c3Le06rG7S9PMgnRNk2VZFUPCtt9YSRZA
         /o/A==
X-Gm-Message-State: APjAAAWtPBPPHIkASqdxctWR8/j9WzOT+XTKTgbDUSCd11Fve2kWEk/c
        5CFaOQJyLlMp2mBE0ObD5fYwRCKSSXeuGA==
X-Google-Smtp-Source: APXvYqw7DluSyanzBerxwgn1tWnJVZhHSeTUaLT/5v0Gy02WSvkUYZFLWfr548s4oxWvF15H1NMYPQ==
X-Received: by 2002:a0c:9163:: with SMTP id q90mr18401739qvq.37.1565357609905;
        Fri, 09 Aug 2019 06:33:29 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k21sm2830169qki.50.2019.08.09.06.33.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:33:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/7] Rework reserve ticket handling
Date:   Fri,  9 Aug 2019 09:33:20 -0400
Message-Id: <20190809133327.26509-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
the upcoming changesets.

 fs/btrfs/block-group.c    |   5 +-
 fs/btrfs/block-rsv.c      |   5 --
 fs/btrfs/delalloc-space.c |   4 --
 fs/btrfs/extent-tree.c    |  13 +----
 fs/btrfs/space-info.c     | 140 +++++++++++-----------------------------------
 fs/btrfs/space-info.h     |  30 ++++++----
 6 files changed, 56 insertions(+), 141 deletions(-)

Thanks,

Josef

