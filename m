Return-Path: <linux-btrfs+bounces-14643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA27AD8CC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0540D3BC213
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE074126C03;
	Fri, 13 Jun 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlRAq42N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48BA72624;
	Fri, 13 Jun 2025 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819917; cv=none; b=Z33VNyerA+OTGwg/kAMeDBE7bb5+MCXpNpN3uhNSTtbIiW1kBJRS4veWq/hG1qEwnf2GpScRNWK76nuU/qyjF8/6cERW/dM9Y88UMYcGAJp4iSm/6CyhNOjhekl6ipEDsZxwdbkBAEMHLKJ9jPdsKJhUJjA0bB+wnZUQATFg6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819917; c=relaxed/simple;
	bh=9H4N+0A27l7oPWRLbvwrLjYzczFJozB4rzn1W0vQu14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5KivdN0noQhj8UPXBwQpPVe7HFn3fytIxZyuS5CE0DL2XaPbqDhjs7grW+sHFOt6vnPosheJFg3uu8Kax9voxssRtEuD1Tbpvdj0b0LI4OdB7HNrsDuKlTeS0Q6jXdy94VcDtwp/E9a3VwPR8R3B4pA3Aj0Vd5E3CPQhHR3C8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlRAq42N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F9C4CEE3;
	Fri, 13 Jun 2025 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749819916;
	bh=9H4N+0A27l7oPWRLbvwrLjYzczFJozB4rzn1W0vQu14=;
	h=From:To:Cc:Subject:Date:From;
	b=MlRAq42NDBP54ZdGDLh7VfDlGKcT6UVX9iMT0A4UMsZGfAgoITju+VR1YFDSto3Pr
	 v/gqfpbTHGIaFIt6gzHDMTj/VltXYRXlzHAA/Ypb8enq7yBulVLoRcCMBRl/XNtdE9
	 ErRwGxOvmnvzrBjPVQ1CTSBgXMNNBEUodInoFYCw69Fa25mj+VYO8GnW9N3Epm3R+8
	 tYj8ETJpYoBsT4WJakzj9C8/FkS6MuEAqZZv4h5+ClDLDu+o4ofHQ2SZ82iio56Mfz
	 yL4CHge94oKMXskI9c44GAZDtWUd8fbkzdRsHaz8IB7YYIwuLPvuktMvsKwXsH0GUi
	 HQH1u5yCWwZ9Q==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/300: set umask to avoid failure on systems with a different umask
Date: Fri, 13 Jun 2025 14:05:08 +0100
Message-ID: <4ae9bff4369f3d0700ba0ae2afddce01bd0ffc62.1749819852.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test is assuming a umask of 0022, which is the default on many Linux
setups, but often we can find other umasks such as in recent Debian box
I have where the default umask is 0002, and this makes the test fail like
this:

  $ ./check btrfs/300
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian7 6.16.0-rc1-btrfs-next-200+ #1 SMP PREEMPT_DYNAMIC Thu Jun 12 16:07:55 WEST 2025
  MKFS_OPTIONS  -- /dev/sdb
  MOUNT_OPTIONS -- /dev/sdb /scratch

  btrfs/300 2s ... - output mismatch (see /xfstests/results//btrfs/300.out.bad)
    --- tests/btrfs/300.out	2024-05-20 11:27:55.949395116 +0100
    +++ /xfstests/results//btrfs/300.out.bad	2025-06-12 22:58:20.449228230 +0100
    @@ -2,16 +2,16 @@
     Create subvolume './subvol'
     Create subvolume 'subvol/subsubvol'
     drwxr-xr-x fsgqa fsgqa ./
    -drwxr-xr-x fsgqa fsgqa ./subvol
    --rw-r--r-- fsgqa fsgqa ./subvol/1
    --rw-r--r-- fsgqa fsgqa ./subvol/2
    --rw-r--r-- fsgqa fsgqa ./subvol/3
    ...
    (Run 'diff -u /xfstests/tests/btrfs/300.out /xfstests/results//btrfs/300.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        94628ad94408 btrfs: copy dir permission and time when creating a stub subvolume

  Ran: btrfs/300
  Failures: btrfs/300
  Failed 1 of 1 tests

  $ diff -u /xfstests/tests/btrfs/300.out /xfstests/results//btrfs/300.out.bad
  --- /xfstests/tests/btrfs/300.out	2024-05-20 11:27:55.949395116 +0100
  +++ /xfstests/results//btrfs/300.out.bad	2025-06-12 22:58:20.449228230 +0100
  @@ -2,16 +2,16 @@
   Create subvolume './subvol'
   Create subvolume 'subvol/subsubvol'
   drwxr-xr-x fsgqa fsgqa ./
  -drwxr-xr-x fsgqa fsgqa ./subvol
  --rw-r--r-- fsgqa fsgqa ./subvol/1
  --rw-r--r-- fsgqa fsgqa ./subvol/2
  --rw-r--r-- fsgqa fsgqa ./subvol/3
  -drwxr-xr-x fsgqa fsgqa ./subvol/subsubvol
  --rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/4
  --rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/5
  --rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/6
  -drwxr-xr-x fsgqa fsgqa ./snapshot
  --rw-r--r-- fsgqa fsgqa ./snapshot/1
  --rw-r--r-- fsgqa fsgqa ./snapshot/2
  --rw-r--r-- fsgqa fsgqa ./snapshot/3
  +drwxrwxr-x fsgqa fsgqa ./subvol
  +-rw-rw-r-- fsgqa fsgqa ./subvol/1
  +-rw-rw-r-- fsgqa fsgqa ./subvol/2
  +-rw-rw-r-- fsgqa fsgqa ./subvol/3
  +drwxrwxr-x fsgqa fsgqa ./subvol/subsubvol
  +-rw-rw-r-- fsgqa fsgqa ./subvol/subsubvol/4
  +-rw-rw-r-- fsgqa fsgqa ./subvol/subsubvol/5
  +-rw-rw-r-- fsgqa fsgqa ./subvol/subsubvol/6
  +drwxrwxr-x fsgqa fsgqa ./snapshot
  +-rw-rw-r-- fsgqa fsgqa ./snapshot/1
  +-rw-rw-r-- fsgqa fsgqa ./snapshot/2
  +-rw-rw-r-- fsgqa fsgqa ./snapshot/3
   drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol

The mismatch with the golden output is because the test is expecting an
umask of 0022 where the write bit is not set for owner group, but with
a umask of 0002 for example, the write bit is set for the owner group.

Fix this by making the test set a umask of 0022, so that it works for
any system or user defined umask.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/300 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/300 b/tests/btrfs/300
index 7fcb444a..218ed831 100755
--- a/tests/btrfs/300
+++ b/tests/btrfs/300
@@ -36,6 +36,7 @@ chown $qa_user:$qa_group $test_dir
 # sets the namespace for the running shell. The test must run in one user
 # subshell to preserve the namespace over multiple commands.
 _user_do "
+umask 0022;
 cd ${test_dir};
 unshare --user --keep-caps --map-auto --map-root-user;
 $BTRFS_UTIL_PROG subvolume create subvol;
-- 
2.47.2


