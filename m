Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7724A178
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgHSOQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 10:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgHSOQg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 10:16:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76A620639;
        Wed, 19 Aug 2020 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597846595;
        bh=9n2Tz8P1Ic48NjIEsW71svrvFH7LMG59R0fLbII/i2k=;
        h=From:To:Cc:Subject:Date:From;
        b=DoJN1kYZeD/BywFRkC/ip1FjED1mx0O+9zCYdMuCs/ydtJ7NqDPV3zrYPRKW5h6M7
         Ro+l3+Dpb+w2EmbzVZkTN4UvijRXRQ68OrVwfnmFFwhJ1AX3anJaBfDxNMNDnBrsvY
         Q9Gh7uI1VznZePsclFbj05jHtl7KsWdkkdmlgv7M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fixes to GCC warnings while compiling with W=1 level
Date:   Wed, 19 Aug 2020 17:16:27 +0300
Message-Id: <20200819141630.1338693-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

The series of trivial fixes for GCC warnings seen while compiling with W=1.

Thanks

Leon Romanovsky (3):
  fs/btfrs: Fix -Wunused-but-set-variable warnings
  fs/btrfs: Fix -Wignored-qualifiers warnings
  fs/btrfs: Fix -Wmissing-prototypes warnings

 fs/btrfs/compression.c | 35 -----------------------------------
 fs/btrfs/compression.h | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.c       |  2 +-
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/sysfs.c       |  7 +++----
 fs/btrfs/sysfs.h       |  2 +-
 6 files changed, 41 insertions(+), 42 deletions(-)

--
2.26.2

