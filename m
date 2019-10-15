Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96986D7F45
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfJOSnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 14:43:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34614 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbfJOSnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 14:43:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id k20so5312697pgi.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmc2uqFTXS7y6XEsrcsDCYwdgmqWwAY8SMHNmlkmKrM=;
        b=Dym4Jaxnk6nfwi0ultp2/9vKwLGixaPsxxzJnjOiABpVtAnHJ/OF0fj17epI9P2brP
         52c2WRrYC/r51A/M8HcIF0u5cZ34GyLavJjqT3IxHfslWBDBA8h228P0WaxIYeD62wAt
         lt3qUHGiHPPfSOSK/Ve/xOl/tgv5SlGCjBFhfgPMMmyNQpeyl6qYHOsnu8D2HyypmZgJ
         UNcUa+UdAdHTDucS7Q4i09rkVPvEvrqb5DkqBVTkRrde7L1OvnmIuDEyPu8doWBAKhv9
         y92va/6P7EYfv3pYC3DKXD2xILvDhnQlodqRhmLDJ1dqvuHoPy+DD9pVBPRDViYfhI00
         P0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmc2uqFTXS7y6XEsrcsDCYwdgmqWwAY8SMHNmlkmKrM=;
        b=NBkhAJgH7uNc2HgYmFSfjKSlG0jUOowxMHBaYBxyZ84P8QBum5Vdli/Hv6o/HdVTYg
         8fCHH5wPW+M82h/ZusRQcpncJrtqUiuA3gAcIU8xFFoyyNNlhiB/nV/mCW7f8Ewpziun
         yph0KorWToaopMIYeKQczh7tcVN3KiMmxLWlEVDr3MTYMTloQNPbBQi0iZDyUzZXtwwa
         AkwSnZmRJ3eqbzHGgazg4ssw4287RFOqRKO/ADa4RyBv9RC6rcFWCPqueijg4hL3kQbT
         rHh7Eh0wU/cYV0rLlzF2zg1cinVolAwAgqnb6nWTVH3ItVS8yFMMj+jNazQpXR3QqKi4
         VhFg==
X-Gm-Message-State: APjAAAW2rnYJzeIMO2BmVvKI/PVqm284+xE66sdseZaY8pemTo/5qqEx
        voBT+N7pSkjeIXKBC1F9bdrpftQm/P8=
X-Google-Smtp-Source: APXvYqyChFQhR23NNc1bQdsgKcN0s8aZQvo0v5oKP/PG8o9x9+QNocgwvYpIJ2Cs9YlOreLN3VEHyw==
X-Received: by 2002:aa7:92c9:: with SMTP id k9mr40206853pfa.155.1571164984497;
        Tue, 15 Oct 2019 11:43:04 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id z3sm40396pjd.25.2019.10.15.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:43:04 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH v2 0/5] fs: interface for directly reading/writing compressed data
Date:   Tue, 15 Oct 2019 11:42:38 -0700
Message-Id: <cover.1571164762.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. It is based on my previous series which
added a Btrfs-specific ioctl [1], but it is now an extension to
preadv2()/pwritev2() as suggested by Dave Chinner [2]. I've included a
man page patch describing the API in detail. Test cases and examples
programs are available [3].

The use case that I have in mind is Btrfs send/receive: currently, when
sending data from one compressed filesystem to another, the sending side
decompresses the data and the receiving side recompresses it before
writing it out. This is wasteful and can be avoided if we can just send
and write compressed extents. The send part will be implemented in a
separate series, as this API can stand alone.

Patches 1 and 2 add the VFS support. Patch 3 is a Btrfs prep patch.
Patch 4 implements encoded reads for Btrfs, and patch 5 implements
encoded writes.

Changes from v1 [4]:

- Encoded reads are now also implemented.
- The encoded_iov structure now includes metadata for referring to a
  subset of decoded data. This is required to handle certain cases where
  a compressed extent is truncated, hole punched, or otherwise sliced up
  and Btrfs chooses to reflect this in metadata instead of decompressing
  the whole extent and rewriting the pieces. We call these "bookend
  extents" in Btrfs, but any filesystem supporting transparent encoding
  is likely to have a similar concept.
- The behavior of the filesystem when the decompressed data is longer
  than or shorter than expected is more strictly defined (truncate and
  zero extend, respectively).
- As pointed out by Jann Horn [5], the capability check done at
  read/write time in v1 was incorrect; v2 adds an explicit open flag
  (which can be changed with fcntl()). As this can be trivially combined
  with O_CLOEXEC, I did not add any sort of automatic clearing on exec.

I wanted to get the ball rolling on reviewing the interface, so the
Btrfs implementation has a couple of smaller todos:

- Encoded reads do not yet implement repair for disk/checksum failures.
- Encoded writes do not yet support inline extents or bookend extents.

This is based on v5.4-rc3

Please share any comments on the API or implementation. Thanks!

1: https://lore.kernel.org/linux-fsdevel/cover.1567623877.git.osandov@fb.com/
2: https://lore.kernel.org/linux-fsdevel/20190906212710.GI7452@vader/
3: https://github.com/osandov/xfstests/tree/rwf-encoded
4: https://lore.kernel.org/linux-btrfs/cover.1568875700.git.osandov@fb.com/
5: https://lore.kernel.org/linux-btrfs/CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com/

Omar Sandoval (5):
  fs: add O_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: generalize btrfs_lookup_bio_sums_dio()
  btrfs: implement RWF_ENCODED reads
  btrfs: implement RWF_ENCODED writes

 fs/btrfs/compression.c           |   6 +-
 fs/btrfs/compression.h           |   5 +-
 fs/btrfs/ctree.h                 |   9 +-
 fs/btrfs/file-item.c             |  18 +-
 fs/btrfs/file.c                  |  52 ++-
 fs/btrfs/inode.c                 | 663 ++++++++++++++++++++++++++++++-
 fs/fcntl.c                       |  10 +-
 fs/namei.c                       |   4 +
 include/linux/fcntl.h            |   2 +-
 include/linux/fs.h               |  14 +
 include/uapi/asm-generic/fcntl.h |   4 +
 include/uapi/linux/fs.h          |  26 +-
 mm/filemap.c                     |  82 +++-
 13 files changed, 851 insertions(+), 44 deletions(-)

-- 
2.23.0

