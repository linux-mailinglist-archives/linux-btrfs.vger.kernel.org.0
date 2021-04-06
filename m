Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E29355ED1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhDFWbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 18:31:33 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42131 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhDFWba (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 18:31:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A50151320;
        Tue,  6 Apr 2021 18:31:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Apr 2021 18:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=Z1BgTJZdeL7+BOo1IbSHhddddP
        gPms2c+hNoRKLpc44=; b=qoLq60tw44LBNpErchzBr0mmz0Rd+d5TpX2aZaNTa2
        WR0j5lMdIYeVuR5a6ABy/aY4C15NDPeV48nlOvvnwkvkV+VZ+JWiJFrE1m5uxZEd
        pxkRstfk9bS6w+2bT5GpGm+OT3rnGEOPpDFvw7SPtI/LbvJfsNSP5SSvUAzSsz67
        YmhOW5ghOw7opNXtL7NbnAgcQ67sUxjWbePAePxQB4GzQ5WVteaSrHWicRiyNf5j
        Z6wJcdtP+/Z3U4tIUSk5wlYAqtx/5TaNS9gYhVUpvOcceQ3K0arUnXcLW1HQlQ5m
        mXPrGTyLTg2YFIdJbY3ZP7F1FQ9MXlHTiZMHppz97NQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Z1BgTJZdeL7+BOo1I
        bSHhddddPgPms2c+hNoRKLpc44=; b=j73DXepwQH+Tu7q/iRcFy+sFXD9jUHcy/
        QXtCi1J70548vysrS9/0Gm8haUJxXBJJF2It9jbLzBIV9cQWJVd0b9FmCQX6mGrB
        o8bFiZGzNzyiL4KTLPVrUhwLRNMPc+jDS7r3galY46NrI7PFcQDlRWtSAcS5dDXp
        AhiiG9SmsmIk6XbQWrzUuYwcpSxiDJpIGLtS8XfhfbeoSGxe1qvMjcG9HbpvKZjM
        JU37TOl6btf9ajWtUNySAedVou/HCB+8Vz1H93dajq77ahPvu26emB/wnz6/JNp4
        t2rFmDykzAlRTwLTsW5vo+n8hpSSWWiR8KU3TaFQ3mU4eiUs8cK7w==
X-ME-Sender: <xms:N-FsYJWjS4blsdm7Y_wNX4SSVWRBJ0ldA9Ddk7NpwfZ1OoHDcf_9Ow>
    <xme:N-FsYDM3HQKLNPy5BnrZS3zXelK4WTttS_fTPZVCO3RTaah3DtsA7k4ay1POeDDMY
    PSPgwJvui6b0vPAsuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepvddtjedrheefrddvheefrdejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrih
    ho
X-ME-Proxy: <xmx:N-FsYFZK3vT7vU17PyUi13_AB1yNUAHylqldd9LI1a3uHYv7iZm7gw>
    <xmx:N-FsYPryNEkOBWWRcAx04JSg346NUXu5vhcbyDnIMeqEWmzDP0boag>
    <xmx:N-FsYBaUGnFFUCsQ2zaHVkSxvsFjiw2DVvm4H5eQmXJFYAjWpgQu2w>
    <xmx:OOFsYDUmfi4EUenjmUnVnbLBlQP5E6M6xlzL4uAJq785vcgKdn6pdw>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A58D240057;
        Tue,  6 Apr 2021 18:31:19 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: return whole extents in fiemap
Date:   Tue,  6 Apr 2021 15:31:18 -0700
Message-Id: <274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

`xfs_io -c 'fiemap <off> <len>' <file>`
can give surprising results on btrfs that differ from xfs.

btrfs spits out extents trimmed to fit the user input. If the user's
fiemap request has an offset, then rather than returning each whole
extent which intersects that range, we also trim the start extent to not
have start < off.

Documentation in filesystems/fiemap.txt and the xfs_io man page suggests
that returning the whole extent is expected.

Some cases which all yield the same fiemap in xfs, but not btrfs:
dd if=/dev/zero of=$f bs=4k count=1
sudo xfs_io -c 'fiemap 0 1024' $f
  0: [0..7]: 26624..26631
sudo xfs_io -c 'fiemap 2048 1024' $f
  0: [4..7]: 26628..26631
sudo xfs_io -c 'fiemap 2048 4096' $f
  0: [4..7]: 26628..26631
sudo xfs_io -c 'fiemap 3584 512' $f
  0: [7..7]: 26631..26631
sudo xfs_io -c 'fiemap 4091 5' $f
  0: [7..6]: 26631..26630

I believe this is a consequence of the logic for merging contiguous
extents represented by separate extent items. That logic needs to track
the last offset as it loops through the extent items, which happens to
pick up the start offset on the first iteration, and trim off the
beginning of the full extent. To fix it, start `off` at 0 rather than
`start` so that we keep the iteration/merging intact without cutting off
the start of the extent.

after the fix, all the above commands give:
0: [0..7]: 26624..26631

The merging logic is exercised by xfstest generic/483, and I have
written a new xfstest for checking we don't have backwards or
zero-length fiemaps for cases like those above.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7ad2169e7487..5b2a8a314adf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4975,7 +4975,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len)
 {
 	int ret = 0;
-	u64 off = start;
+	u64 off = 0;
 	u64 max = start + len;
 	u32 flags = 0;
 	u32 found_type;
-- 
2.30.2

