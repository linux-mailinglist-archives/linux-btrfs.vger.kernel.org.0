Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB45F7945
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJGNx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJGNx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 09:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F79CF1A5;
        Fri,  7 Oct 2022 06:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0026C61D03;
        Fri,  7 Oct 2022 13:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58144C433D6;
        Fri,  7 Oct 2022 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665150833;
        bh=pzDfZjSIIxMWNT2LU3cI9FVcdmfchvhzl64DIRBVnVI=;
        h=From:To:Cc:Subject:Date:From;
        b=suR0olSRwixG63G7uM426lh1Cnet8nQqAXIsCV3mdYiQ3Ubr2eu6bcTXMRPV2WIyc
         i1PSJQVDJkNH9U69SeoVVz7Dux78UaBPcF37iQrsKUtzUXD8qjDtCBQsfCJzztYqDl
         qwZCqsil98NIzj2s3lKH8EDpozI1cta5efYoUMLs6Xyc8LQq26MzPDRWrerDC6bw6R
         zUSchhBCB6zdpciCqv/pQ9DbXu6h0l62R1Yknds2VqcDXsKSveGjG8OkNGFQZZvLJs
         aSgW7VlrbkoMKNMKpowgCw8UM3jUEbNFL40refR9H1pXVFsofJqdb1wY3oMIu31HZ0
         /ZUE+MfhxG9OA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/3] fstests: add a btrfs fiemap test and fiemap test group
Date:   Fri,  7 Oct 2022 14:53:33 +0100
Message-Id: <cover.1665150613.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a new btrfs test case to exercise fiemap in the presence of a
snapshot, and then add a fiemap test group, as well as some missing
'_require_xfs_io_command "fiemap"' calls in a few tests.

Filipe Manana (3):
  btrfs: test fiemap on large file with extents shared through a snapshot
  fstests: add missing require of xfs_io fiemap command to some tests
  fstests: add fiemap group

 doc/group-names.txt |   1 +
 tests/btrfs/004     |   2 +-
 tests/btrfs/079     |   2 +-
 tests/btrfs/137     |   2 +-
 tests/btrfs/140     |   2 +-
 tests/btrfs/199     |   2 +-
 tests/btrfs/200     |   2 +-
 tests/btrfs/211     |   2 +-
 tests/btrfs/257     |   3 +-
 tests/btrfs/258     |   3 +-
 tests/btrfs/259     |   3 +-
 tests/btrfs/260     |   2 +-
 tests/btrfs/263     |   2 +-
 tests/btrfs/276     | 124 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/276.out |  16 ++++++
 tests/ext4/001      |   2 +-
 tests/ext4/034      |   2 +-
 tests/ext4/308      |   2 +-
 tests/f2fs/002      |   2 +-
 tests/generic/009   |   2 +-
 tests/generic/012   |   2 +-
 tests/generic/016   |   2 +-
 tests/generic/017   |   2 +-
 tests/generic/021   |   2 +-
 tests/generic/022   |   2 +-
 tests/generic/032   |   2 +-
 tests/generic/043   |   2 +-
 tests/generic/044   |   2 +-
 tests/generic/045   |   2 +-
 tests/generic/046   |   2 +-
 tests/generic/047   |   2 +-
 tests/generic/048   |   2 +-
 tests/generic/049   |   2 +-
 tests/generic/058   |   2 +-
 tests/generic/060   |   2 +-
 tests/generic/061   |   2 +-
 tests/generic/063   |   2 +-
 tests/generic/064   |   2 +-
 tests/generic/092   |   2 +-
 tests/generic/094   |   2 +-
 tests/generic/110   |   2 +-
 tests/generic/111   |   2 +-
 tests/generic/115   |   2 +-
 tests/generic/177   |   2 +-
 tests/generic/225   |   2 +-
 tests/generic/255   |   2 +-
 tests/generic/301   |   2 +-
 tests/generic/302   |   2 +-
 tests/generic/305   |   2 +-
 tests/generic/316   |   2 +-
 tests/generic/326   |   2 +-
 tests/generic/327   |   2 +-
 tests/generic/328   |   2 +-
 tests/generic/352   |   2 +-
 tests/generic/353   |   2 +-
 tests/generic/372   |   2 +-
 tests/generic/414   |   2 +-
 tests/generic/425   |   2 +-
 tests/generic/473   |   2 +-
 tests/generic/483   |   2 +-
 tests/generic/516   |   2 +-
 tests/generic/519   |   2 +-
 tests/generic/540   |   2 +-
 tests/generic/541   |   2 +-
 tests/generic/542   |   2 +-
 tests/generic/543   |   2 +-
 tests/generic/578   |   2 +-
 tests/generic/654   |   2 +-
 tests/generic/655   |   2 +-
 tests/generic/677   |   2 +-
 tests/generic/679   |   2 +-
 tests/generic/695   |   2 +-
 tests/overlay/066   |   2 +-
 tests/shared/298    |   2 +-
 tests/xfs/180       |   2 +-
 tests/xfs/182       |   2 +-
 tests/xfs/184       |   2 +-
 tests/xfs/192       |   2 +-
 tests/xfs/193       |   2 +-
 tests/xfs/198       |   2 +-
 tests/xfs/200       |   2 +-
 tests/xfs/204       |   2 +-
 tests/xfs/207       |   2 +-
 tests/xfs/208       |   2 +-
 tests/xfs/209       |   2 +-
 tests/xfs/210       |   2 +-
 tests/xfs/211       |   2 +-
 tests/xfs/212       |   2 +-
 tests/xfs/213       |   2 +-
 tests/xfs/214       |   2 +-
 tests/xfs/231       |   2 +-
 tests/xfs/232       |   2 +-
 tests/xfs/252       |   2 +-
 tests/xfs/344       |   2 +-
 tests/xfs/345       |   2 +-
 tests/xfs/346       |   2 +-
 tests/xfs/347       |   2 +-
 tests/xfs/443       |   3 +-
 98 files changed, 240 insertions(+), 95 deletions(-)
 create mode 100755 tests/btrfs/276
 create mode 100644 tests/btrfs/276.out

-- 
2.35.1

