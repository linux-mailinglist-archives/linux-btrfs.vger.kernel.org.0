Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5E4627FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhK2XR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 18:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhK2XRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2033FC0698DF;
        Mon, 29 Nov 2021 15:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5788B811FF;
        Mon, 29 Nov 2021 23:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD33C53FC7;
        Mon, 29 Nov 2021 23:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638226929;
        bh=gQtwsEVzREE4KcYJDuCzQXVBOxEstYUWRl/JUmE5QcI=;
        h=From:To:Cc:Subject:Date:From;
        b=BlFZ1o6jps8ek7NNDHaMPoVdVLBQJ2S5IvdQI3Hxqku6W5Q+NEYL4T+fem2+kUC8J
         r1u1L803KFc+9naGHNl9XrKbyqKrDgKCboeY18Tq6OULD+VZlyFQHa8HdkudtcPL6/
         jV4O93j2e5MleQQDcd93+xyumvcXNnR/na0Vps0pHig4zM3jykKMuXL7QJVfCWhNC4
         ibNqGI1dJuaa41/b2jnEHpO1ROSPk9znsDTEtckul4AKibAn/WPL8lUoUcz4MXCt0v
         6DUbICrzX41JiEn3gIOfGmlzSpv3P0WnrqK7OKbSHpKG2U+2LMp45N/qLCd2cE2FTU
         n0GRHjNP2/EkQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Fix CONFIG_TEST_KMOD with 256kB page size
Date:   Mon, 29 Nov 2021 16:01:38 -0700
Message-Id: <20211129230141.228085-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel test robot reported a build error [1] from a failed assertion
in fs/btrfs/inode.c with a hexagon randconfig that includes
CONFIG_PAGE_SIZE_256KB. This error is the same one that was addressed by
commit b05fbcc36be1 ("btrfs: disable build on platforms having page size
256K") but CONFIG_TEST_KMOD selects CONFIG_BTRFS without having the
"page size less than 256kB dependency", which results in the error
reappearing.

The first patch introduces CONFIG_PAGE_SIZE_LESS_THAN_256KB by splitting
it off from CONFIG_PAGE_SIZE_LESS_THAN_64KB, which was introduced in
commit 1f0e290cc5fd ("arch: Add generic Kconfig option indicating page
size smaller than 64k") for a similar reason in 5.16-rc3.

The second patch uses that configuration option for CONFIG_BTRFS to
reduce duplication.

The third patch resolves the build error by adding
CONFIG_PAGE_SIZE_LESS_THAN_256KB as a dependency to CONFIG_TEST_KMOD so
that CONFIG_BTRFS does not get enabled under that invalid configuration.

This series could go through either btrfs or -mm, as arch/Kconfig and
lib/Kconfig.debug have no formal maintainer. I have sent it to the
maintainers of both so that they can decide who will take it.

[1]: https://lore.kernel.org/r/202111270255.UYOoN5VN-lkp@intel.com/

Nathan Chancellor (3):
  arch/Kconfig: Split PAGE_SIZE_LESS_THAN_256KB from
    PAGE_SIZE_LESS_THAN_64KB
  btrfs: Use generic Kconfig option for 256kB page size limit
  lib/Kconfig.debug: Make TEST_KMOD depend on PAGE_SIZE_LESS_THAN_256KB

 arch/Kconfig      | 4 ++++
 fs/btrfs/Kconfig  | 3 +--
 lib/Kconfig.debug | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)


base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
-- 
2.34.1

