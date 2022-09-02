Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF7C5AA4B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 02:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiIBAx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 20:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIBAxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 20:53:55 -0400
Received: from out20-157.mail.aliyun.com (out20-157.mail.aliyun.com [115.124.20.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59283BC3
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 17:53:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05089463|-1;BR=01201311R141S00rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00497932-0.000514933-0.994506;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.P5gytX5_1662080000;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P5gytX5_1662080000)
          by smtp.aliyun-inc.com;
          Fri, 02 Sep 2022 08:53:20 +0800
Date:   Fri, 02 Sep 2022 08:53:23 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
Message-Id: <20220902085320.642A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> From: Filipe Manana <fdmanana@suse.com>
> 
> We often get reports of fiemap and hole/data seeking (lseek) being too slow
> on btrfs, or even unusable in some cases due to being extremely slow.
> 
> Some recent reports for fiemap:
> 
>     https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
>     https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> 
> For lseek (LSF/MM from 2017):
> 
>    https://lwn.net/Articles/718805/
> 
> Basically both are slow due to very high algorithmic complexity which
> scales badly with the number of extents in a file and the heigth of
> subvolume and extent b+trees.
> 
> Using Pavel's test case (first Link tag for fiemap), which uses files with
> many 4K extents and holes before and after each extent (kind of a worst
> case scenario), the speedup is of several orders of magnitude (for the 1G
> file, from ~225 seconds down to ~0.1 seconds).
> 
> Finally the new algorithm for fiemap also ends up solving a bug with the
> current algorithm. This happens because we are currently relying on extent
> maps to report extents, which can be merged, and this may cause us to
> report 2 different extents as a single one that is not shared but one of
> them is shared (or the other way around). More details on this on patches
> 9/10 and 10/10.
> 
> Patches 1/10 and 2/10 are for lseek, introducing some code that will later
> be used by fiemap too (patch 10/10). More details in the changelogs.
> 
> There are a few more things that can be done to speedup fiemap and lseek,
> but I'll leave those other optimizations I have in mind for some other time.
> 
> Filipe Manana (10):
>   btrfs: allow hole and data seeking to be interruptible
>   btrfs: make hole and data seeking a lot more efficient
>   btrfs: remove check for impossible block start for an extent map at fiemap
>   btrfs: remove zero length check when entering fiemap
>   btrfs: properly flush delalloc when entering fiemap
>   btrfs: allow fiemap to be interruptible
>   btrfs: rename btrfs_check_shared() to a more descriptive name
>   btrfs: speedup checking for extent sharedness during fiemap
>   btrfs: skip unnecessary extent buffer sharedness checks during fiemap
>   btrfs: make fiemap more efficient and accurate reporting extent sharedness
> 
>  fs/btrfs/backref.c     | 153 ++++++++-
>  fs/btrfs/backref.h     |  20 +-
>  fs/btrfs/ctree.h       |  22 +-
>  fs/btrfs/extent-tree.c |  10 +-
>  fs/btrfs/extent_io.c   | 703 ++++++++++++++++++++++++++++-------------
>  fs/btrfs/file.c        | 439 +++++++++++++++++++++++--
>  fs/btrfs/inode.c       | 146 ++-------
>  7 files changed, 1111 insertions(+), 382 deletions(-)


An infinite loop happen when the 10 pathes applied to 6.0-rc3.

a file is created by 'pavels-test.c' of [PATCH 10/10]. 
and then '/bin/cp /mnt/test/file1 /dev/null' will trigger an infinite
loop.

'sysrq -l' output:

[ 1437.765228] Call Trace:
[ 1437.765228]  <TASK>
[ 1437.765228]  set_extent_bit+0x33d/0x6e0 [btrfs]
[ 1437.765228]  lock_extent_bits+0x64/0xa0 [btrfs]
[ 1437.765228]  btrfs_file_llseek+0x192/0x5b0 [btrfs]
[ 1437.765228]  ksys_lseek+0x64/0xb0
[ 1437.765228]  do_syscall_64+0x58/0x80
[ 1437.765228]  ? syscall_exit_to_user_mode+0x12/0x30
[ 1437.765228]  ? do_syscall_64+0x67/0x80
[ 1437.765228]  ? do_syscall_64+0x67/0x80
[ 1437.765228]  ? exc_page_fault+0x64/0x140
[ 1437.765228]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1437.765228] RIP: 0033:0x7f5a263441bb

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/02


