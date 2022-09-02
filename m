Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A35AADD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiIBLlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 2 Sep 2022 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiIBLlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 07:41:11 -0400
Received: from out20-193.mail.aliyun.com (out20-193.mail.aliyun.com [115.124.20.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0D8034D
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 04:41:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04746784|-1;BR=01201311R121S24rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0314378-0.000192597-0.96837;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.P6ByU5w_1662118866;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P6ByU5w_1662118866)
          by smtp.aliyun-inc.com;
          Fri, 02 Sep 2022 19:41:06 +0800
Date:   Fri, 02 Sep 2022 19:41:07 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
In-Reply-To: <CAL3q7H79BWAJVk2ecWqa4mbW0+WFJrEX-=a+Zg9FOc_UcAKjLg@mail.gmail.com>
References: <20220902085320.642A.409509F4@e16-tech.com> <CAL3q7H79BWAJVk2ecWqa4mbW0+WFJrEX-=a+Zg9FOc_UcAKjLg@mail.gmail.com>
Message-Id: <20220902194107.8878.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_QP_LONG_LINE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Fri, Sep 2, 2022 at 2:09 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi,
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > We often get reports of fiemap and hole/data seeking (lseek) being too slow
> > > on btrfs, or even unusable in some cases due to being extremely slow.
> > >
> > > Some recent reports for fiemap:
> > >
> > >     https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> > >     https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> > >
> > > For lseek (LSF/MM from 2017):
> > >
> > >    https://lwn.net/Articles/718805/
> > >
> > > Basically both are slow due to very high algorithmic complexity which
> > > scales badly with the number of extents in a file and the heigth of
> > > subvolume and extent b+trees.
> > >
> > > Using Pavel's test case (first Link tag for fiemap), which uses files with
> > > many 4K extents and holes before and after each extent (kind of a worst
> > > case scenario), the speedup is of several orders of magnitude (for the 1G
> > > file, from ~225 seconds down to ~0.1 seconds).
> > >
> > > Finally the new algorithm for fiemap also ends up solving a bug with the
> > > current algorithm. This happens because we are currently relying on extent
> > > maps to report extents, which can be merged, and this may cause us to
> > > report 2 different extents as a single one that is not shared but one of
> > > them is shared (or the other way around). More details on this on patches
> > > 9/10 and 10/10.
> > >
> > > Patches 1/10 and 2/10 are for lseek, introducing some code that will later
> > > be used by fiemap too (patch 10/10). More details in the changelogs.
> > >
> > > There are a few more things that can be done to speedup fiemap and lseek,
> > > but I'll leave those other optimizations I have in mind for some other time.
> > >
> > > Filipe Manana (10):
> > >   btrfs: allow hole and data seeking to be interruptible
> > >   btrfs: make hole and data seeking a lot more efficient
> > >   btrfs: remove check for impossible block start for an extent map at fiemap
> > >   btrfs: remove zero length check when entering fiemap
> > >   btrfs: properly flush delalloc when entering fiemap
> > >   btrfs: allow fiemap to be interruptible
> > >   btrfs: rename btrfs_check_shared() to a more descriptive name
> > >   btrfs: speedup checking for extent sharedness during fiemap
> > >   btrfs: skip unnecessary extent buffer sharedness checks during fiemap
> > >   btrfs: make fiemap more efficient and accurate reporting extent sharedness
> > >
> > >  fs/btrfs/backref.c     | 153 ++++++++-
> > >  fs/btrfs/backref.h     |  20 +-
> > >  fs/btrfs/ctree.h       |  22 +-
> > >  fs/btrfs/extent-tree.c |  10 +-
> > >  fs/btrfs/extent_io.c   | 703 ++++++++++++++++++++++++++++-------------
> > >  fs/btrfs/file.c        | 439 +++++++++++++++++++++++--
> > >  fs/btrfs/inode.c       | 146 ++-------
> > >  7 files changed, 1111 insertions(+), 382 deletions(-)
> >
> >
> > An infinite loop happen when the 10 pathes applied to 6.0-rc3.
> 
> Nop, it's not an infinite loop, and it happens as well before the patchset.
> The reason is that the files created by the test are very sparse and
> with small extents.
> It's full of 4K extents surrounded by 8K holes.
> 
> So any one doing hole seeking, advances 8K on every lseek call.
> If you strace the cp process, with
> 
> strace -p <cp pid>
> 
> You'll see something like this filling your terminal:
> 
> (...)
> lseek(3, 18808832, SEEK_SET)            = 18808832
> write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 4096) = 4096
> read(3, "a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 4096) = 4096
...
> lseek(3, 18857984, SEEK_SET)            = 18857984
> (...)
> 
> It takes a long time, but it finishes. If you notice the difference
> between each return
> value is exactly 8K.
> 
> That happens both before and after the patchset.

Yes. It takes a long time, but it finishes.
Thanks for the advice of 'strace -p <cp pid>'

more tests show that the performance depends on whether the data is
cached.

When data is not cached (echo 3 >/proc/sys/vm/drop_caches),
'/bin/cp /mnt/test/file1 /dev/null' take 97.37s.

When data is cached (/bin/cp again),
'/bin/cp /mnt/test/file1 /dev/null' take 2056.53s.

/mnt/test/file1 is 512M created by that producer.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/02

