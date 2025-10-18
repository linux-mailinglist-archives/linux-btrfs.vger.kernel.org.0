Return-Path: <linux-btrfs+bounces-17982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B571BBEC759
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A33354E991A
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE646263C7F;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me/BbR3U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55421448E0;
	Sat, 18 Oct 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762182; cv=none; b=dmd3NBdcpbaA304xPsoHvwK570KuKEHP2P4DFxn7pEfgEiiACj0j9QHL8myKUsExrLHKsvQshMgSVZz5wmzvwev5ASYvuT/KG9VO1HCqwI72+qfpyCgu9kdAyqmE8F5WsUgh0H5+9oqpwA7OCNzdB+69KjxLyeEo1AWvhBYGWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762182; c=relaxed/simple;
	bh=R2ZmkLZLT5vSLhRdOwMmMQDA/rfzi0lJEVz7S0mxo6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVnKVJKgb+sn+R9CscJI9R2J7FmEu4dLSv2ZVt1fLLgDcHmvO6NG5g7pTgqglcNlkBSwDQBggZ7Cjz0aJBnqspJS+0Ekp93wRJJmliZhxoZ+233q+izeahH6PO4j9pB8Ko7Q67mLbp300ou8pp0bgfEY8fKKWspNL5myqzdS5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me/BbR3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB896C4CEF8;
	Sat, 18 Oct 2025 04:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762181;
	bh=R2ZmkLZLT5vSLhRdOwMmMQDA/rfzi0lJEVz7S0mxo6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=Me/BbR3UVAnLpPZmzqKrz+oPn31cgyUK4LdVv4SViFAzQ8XrhYTRMuLZjd215fZzZ
	 ijd0WbdXZNb3OhRcrG9eBAiK4cO9HV5zSxCPj7WJopAbHwFwihCkOCD1jcoIOwHq7m
	 O5o3tDG30b/r+eULTcEkIBP1rcEKWMeg9eaufwqt3u2uTTO6PQ3exbsW1b2bOkvkgK
	 DcSdMC94X9N6dDObpGIgFWWhIMii3e3ne2cXn6h9dg8oGSj+Ax1X4qC2tNw/3+EOUA
	 eoHuV6VsCbjm7SoydAu+9IrPJUeSkdMMujYSH9Ab7qdSU4mV2N+WKsk2Lo4hLbRSnS
	 9zybRE+W3q15Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 00/10] BLAKE2b library API
Date: Fri, 17 Oct 2025 21:30:56 -0700
Message-ID: <20251018043106.375964-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series can also be retrieved from:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git blake2b-lib-v1

This series adds BLAKE2b support to lib/crypto/ and reimplements the
blake2b-* crypto_shash algorithms on top of it.

To prepare for that, patches 1-4 clean up the BLAKE2s library code a
bit, and patch 5 adds some missing 64-bit byteorder helper functions.
Patches 6-8 add the BLAKE2b library API (closely mirroring the BLAKE2s
one), and patch 9 makes crypto_shash use it.  As usual, the library APIs
are documented (with kerneldoc) and tested (with KUnit).

With that done, all of btrfs's checksum algorithms have library APIs.
So patch 10 converts btrfs to use the library APIs instead of shash.
This has quite a few benefits, as detailed in that patch.

Patches 1-9 are targeting libcrypto-next for 6.19.  Patch 10 can go
through the btrfs tree later.

Eric Biggers (10):
  lib/crypto: blake2s: Adjust parameter order of blake2s()
  lib/crypto: blake2s: Rename blake2s_state to blake2s_ctx
  lib/crypto: blake2s: Drop excessive const & rename block => data
  lib/crypto: blake2s: Document the BLAKE2s library API
  byteorder: Add le64_to_cpu_array() and cpu_to_le64_array()
  lib/crypto: blake2b: Add BLAKE2b library functions
  lib/crypto: arm/blake2b: Migrate optimized code into library
  lib/crypto: tests: Add KUnit tests for BLAKE2b
  crypto: blake2b - Reimplement using library API
  btrfs: switch to library APIs for checksums

 arch/arm/crypto/Kconfig                       |  16 -
 arch/arm/crypto/Makefile                      |   2 -
 arch/arm/crypto/blake2b-neon-glue.c           | 104 ------
 crypto/Kconfig                                |   3 +-
 crypto/Makefile                               |   3 +-
 crypto/blake2b.c                              | 111 ++++++
 crypto/blake2b_generic.c                      | 192 ----------
 crypto/testmgr.c                              |   4 +
 drivers/char/random.c                         |   6 +-
 drivers/net/wireguard/cookie.c                |  18 +-
 drivers/net/wireguard/noise.c                 |  32 +-
 fs/btrfs/Kconfig                              |   8 +-
 fs/btrfs/compression.c                        |   1 -
 fs/btrfs/disk-io.c                            |  68 +---
 fs/btrfs/file-item.c                          |   4 -
 fs/btrfs/fs.c                                 |  97 ++++-
 fs/btrfs/fs.h                                 |  23 +-
 fs/btrfs/inode.c                              |  13 +-
 fs/btrfs/scrub.c                              |  16 +-
 fs/btrfs/super.c                              |   4 -
 fs/btrfs/sysfs.c                              |   6 +-
 include/crypto/blake2b.h                      | 143 ++++++--
 include/crypto/blake2s.h                      | 126 +++++--
 include/crypto/internal/blake2b.h             | 101 ------
 include/linux/byteorder/generic.h             |  16 +
 lib/crypto/Kconfig                            |  11 +
 lib/crypto/Makefile                           |  10 +
 .../crypto/arm}/blake2b-neon-core.S           |  29 +-
 lib/crypto/arm/blake2b.h                      |  41 +++
 lib/crypto/arm/blake2s-core.S                 |  14 +-
 lib/crypto/arm/blake2s.h                      |   4 +-
 lib/crypto/blake2b.c                          | 174 +++++++++
 lib/crypto/blake2s.c                          |  66 ++--
 lib/crypto/tests/Kconfig                      |   9 +
 lib/crypto/tests/Makefile                     |   1 +
 lib/crypto/tests/blake2b-testvecs.h           | 342 ++++++++++++++++++
 lib/crypto/tests/blake2b_kunit.c              | 133 +++++++
 lib/crypto/tests/blake2s_kunit.c              |  39 +-
 lib/crypto/x86/blake2s.h                      |  22 +-
 scripts/crypto/gen-hash-testvecs.py           |  29 +-
 40 files changed, 1333 insertions(+), 708 deletions(-)
 delete mode 100644 arch/arm/crypto/blake2b-neon-glue.c
 create mode 100644 crypto/blake2b.c
 delete mode 100644 crypto/blake2b_generic.c
 delete mode 100644 include/crypto/internal/blake2b.h
 rename {arch/arm/crypto => lib/crypto/arm}/blake2b-neon-core.S (94%)
 create mode 100644 lib/crypto/arm/blake2b.h
 create mode 100644 lib/crypto/blake2b.c
 create mode 100644 lib/crypto/tests/blake2b-testvecs.h
 create mode 100644 lib/crypto/tests/blake2b_kunit.c


base-commit: 123fa1574bccee87da735d13e89c931e88288b40
-- 
2.51.1.dirty


