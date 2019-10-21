Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9926DF37A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJUQpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:45:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfJUQpx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61AF5AF9F;
        Mon, 21 Oct 2019 16:45:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5D5BDA733; Mon, 21 Oct 2019 18:46:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: More checksumming algorithms for btrfs
Date:   Mon, 21 Oct 2019 18:45:49 +0200
Message-Id: <20191021164549.15404-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The work to add more checksums is nearly finished, we're now in a good state to
let interested users do some testing and benchmarking.

New hashes: xxhash64, sha256, blake2b-256

Quick start:

  git://github.com/kdave/btrfs-devel preview/checksums-5
  (build with CRYPTO_BLAKE2B=m)

  git://github.com/kdave/btrfs-progs devel

  $ mkfs.btrfs --csum blake2 /dev/sda
  $ mount /dev/sda /mnt

Warning: use only for testing!

The increased size of checksums is allocating more memory when the data are
being written so this can produce some warnings regarding size of the
allocation. This will be addressed later.


Selection results
~~~~~~~~~~~~~~~~~

fast hash: xxhash
- 64bit digest
- optimized for 64bit platforms, leveraging CPU pipelining

cryptographically strong hash 1: sha256
- 256bit digest
- FIPS certification

cryptographically strong hash 2: blake2
- blake2b with 256bit digest
- '2b' as it targets 64bit platforms


Microbenchmark
~~~~~~~~~~~~~~

  $ cd btrfs-progs.git
  $ make hash-speedtest
  $ ./hash-speedtest [iterations]

Block size: 4096
Iterations: 100000

    NULL-NOP: cycles:     53638797, c/i      536
 NULL-MEMCPY: cycles:     59547932, c/i      595
      CRC32C: cycles:    179251924, c/i     1792
      XXHASH: cycles:    137327470, c/i     1373
      SHA256: cycles:  10719756126, c/i   107197
     BLAKE2b: cycles:   2264316924, c/i    22643


Compatibility
~~~~~~~~~~~~~

There's no new incompat bit, the checksum algorithm is detected at mount time
and unknown type will fail to mount.

The crypto modules implementing the digests must be either built-in or
loadable, lack of thereof will fail mount. The actual digest implementation is
up to the crypto API to choose. Check /sys/fs/UUID/features/checksum .


Target release
~~~~~~~~~~~~~~

The plan is to queue the patches for 5.5, the blake2b patches seem to be on a
good track so both shall be in the same release.
