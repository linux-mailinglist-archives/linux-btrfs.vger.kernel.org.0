Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F53F8535
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 12:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhHZKTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 06:19:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56700 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhHZKTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 06:19:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 130392017A;
        Thu, 26 Aug 2021 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629973125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ENOg+DLwI+IVUsb6INfCzAyMbURqpjRPsVPb3bU0s4M=;
        b=fWFv3oZhsigK5PX2TjCC8g9DHgY+WCaJGU1r6/VU1blEkK98uakfy/dcXgu5+WUaJ4yyey
        bspRq+eWorbDgMIb8c0tqAJWyhca2NcOmgtZsjKOCaUXg8GdLzfFNUIVWxcSWhHW5BQMQo
        CuHMlWlIwNFYTMrf+l8O297xlVjEyBI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0CC42A3B94;
        Thu, 26 Aug 2021 10:18:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 17A0BDA7FB; Thu, 26 Aug 2021 12:15:56 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.14-rc
Date:   Thu, 26 Aug 2021 12:15:55 +0200
Message-Id: <cover.1629897022.git.dsterba@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

here's one more fix that I think qualifies for a late merge. It's a
revert of a one-liner fix that meanwhile got backported to stable
kernels and we got reports from users.

The broken fix prevents creating compressed inline extents, which could
be noticeable on space consumption.

Technically it's a regression as the patch was merged in 5.14-rc1
but got propagated to several stable kernels and has higher exposure
than a "typical" development cycle bug.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 3f79f6f6247c83f448c8026c3ee16d4636ef8d4f:

  btrfs: prevent rename2 from exchanging a subvol with a directory from different parents (2021-08-16 13:33:23 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.14-rc7-tag

for you to fetch changes up to 4e9655763b82a91e4c341835bb504a2b1590f984:

  Revert "btrfs: compression: don't try to compress if we don't have enough pages" (2021-08-25 15:08:19 +0200)

----------------------------------------------------------------
Qu Wenruo (1):
      Revert "btrfs: compression: don't try to compress if we don't have enough pages"

 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
