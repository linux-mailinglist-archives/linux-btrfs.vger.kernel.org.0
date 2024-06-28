Return-Path: <linux-btrfs+bounces-6044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B591C45F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BDE1F22200
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5571C2324;
	Fri, 28 Jun 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghI23IKn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C541CB33B;
	Fri, 28 Jun 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594300; cv=none; b=ozxWv23MujZs3J4i94Ay7AtljctZaC3SX0RwfbfOH8XX6RQ7Zj/s19M5aaoZOfL86104aoHoJ0Uggrn6ExUrEwjTvHoXy33SKw43qykkIvWDz+B2G8t4JoaEP5Z9CPTq/1ea4ZhB4VxyE8/2J5asCW925l3QJl55MCuF1BQoJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594300; c=relaxed/simple;
	bh=xySLRgPVJEPnNBQNZieFU189xHYdEw/OjjEOCBhlQgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RswLl1XtYODbvUGPGazxKWK73b2nn7dv+ShY5a+goyI3ygpEL+oApc8mbmAAISeHo+PF3RDx+mEaEE3IeHLZMtoX0o4csMFbDVbRket/HWWo68MF04FGcVsua9r4qiJEvQ7w/Gm5wPOvSYztL78OuJIx0/E/hdQYBuKaZBlY+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghI23IKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF243C32786;
	Fri, 28 Jun 2024 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594299;
	bh=xySLRgPVJEPnNBQNZieFU189xHYdEw/OjjEOCBhlQgk=;
	h=From:To:Cc:Subject:Date:From;
	b=ghI23IKn5ZT8sQXGzWYwN/t7cWWFFulUpONhyRj/F6tyLHbzIrGnI49Gnr1qPfkQC
	 myzeiR1to9FewmZqUhV5p0BTlWWA8Rz7in89AQTYtL1TrAb9PTAOKpbTMGOP8M8811
	 sKv2wg0AWxhzOmR/B6R1mIgfzzrCviPt3jSdOd69oLKqRMLmDuIQzJO7kltSoj3/O5
	 4wIShtIiu3tBbxQruMIDaDYtJ600a7eyG0Ty0h6YlvWL5vm0eNuETPkzW1w1j6252V
	 FsP+SFJTtAefZB9h9AzkdvFsk1Ry2ji8amLoYajTXleVpFymaaYoOkJ2hHbA4Cwl6J
	 7riKgk+XbkFfg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/081: wait for reader process to exit before cycle mounting
Date: Fri, 28 Jun 2024 18:04:49 +0100
Message-ID: <bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We send a kill signal to the reader process, check the md5sum of the
files and then cycle mount the scratch device. Most of the time the
reader process has already terminated before we attempt the cycle mount,
but sometimes it may still be alive in which case the cat command
executed by the reader process may fail because the scratch fs was
unmounted and the target file doesn't exist. This makes the cat command
print an error message and the test fail like this:

     Verifying file digests after cloning
     14968c092c68e32fa35e776392d14523  SCRATCH_MNT/foo
     14968c092c68e32fa35e776392d14523  SCRATCH_MNT/bar
    +cat: /opt/scratch/bar: No such file or directory
    +cat: /opt/scratch/bar: No such file or directory
    +cat: /opt/scratch/bar: No such file or directory
    +cat: /opt/scratch/bar: No such file or directory
    ...
    (Run diff -u /opt/xfstests/tests/btrfs/081.out

Fix this by making the test wait for the reader to terminate after
sending it the kill signal.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/081 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/081 b/tests/btrfs/081
index c3f84c77..64544da3 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -82,6 +82,7 @@ $CLONER_PROG -s 0 -d 0 -l $(($num_extents * $extent_size)) \
 	$SCRATCH_MNT/foo $SCRATCH_MNT/bar
 
 kill $reader_pid > /dev/null 2>&1
+wait $reader_pid
 
 # Now both foo and bar should have exactly the same content.
 # This didn't use to be the case before the btrfs kernel fix mentioned
-- 
2.43.0


