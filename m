Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84000591E5A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 06:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiHNE7b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Aug 2022 00:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiHNE7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 00:59:30 -0400
Received: from out20-37.mail.aliyun.com (out20-37.mail.aliyun.com [115.124.20.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FA11AD8B
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 21:59:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04449362|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00585442-0.000257268-0.993888;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OsysDjc_1660453124;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OsysDjc_1660453124)
          by smtp.aliyun-inc.com;
          Sun, 14 Aug 2022 12:58:44 +0800
Date:   Sun, 14 Aug 2022 12:58:45 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Uncorrectable error during multiple scrub (raid5 recovery).
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <a113ec67-18fe-276f-d065-307d2bb292b0@gmx.com>
References: <20220814111026.25EF.409509F4@e16-tech.com> <a113ec67-18fe-276f-d065-307d2bb292b0@gmx.com>
Message-Id: <20220814125845.80E1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/8/14 11:10, Wang Yugui wrote:
> > Hi,
> >
> > Uncorrectable error during multiple scrub (raid5 recovery).
> >
> > This reproducer is based on some reproducer [1],
> > but it seems a new problem, so I open a new thread.
> >
> > reproducer:
> >
> > mkfs.btrfs -f -draid5 -mraid1 ${SCRATCH_DEV_POOL}
> > SCRATCH_DEV_ARRAY=($SCRATCH_DEV_POOL)
> > mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o compress=zstd,noatime
> 
> Please remove unnecessary comments if it's not explaining anything.
> 
> It just makes the test case much harder to read.
> >
> > /bin/cp -a /usr/bin $SCRATCH_MNT/
> > #(OK)dd if=/dev/urandom bs=1M count=1K of=$SCRATCH_MNT/1G.img
> > du -sh $SCRATCH_MNT
> >
> > for((i=1;i<=15;++i)); do
> >
> > 	#(OK)umount $SCRATCH_MNT; mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o compress=zstd,noatime
> > 	sync; sleep 5; sync; sleep 5; sync; sleep 25;
> 
> If you really want to provide a reproducer, either explain why this is
> needed or it will just waste time of everyone who is trying this test.
> 
> >
> > 	# change the device to discard in every loop
> > 	j=$(( i % ${#SCRATCH_DEV_ARRAY[@]} ))
> > 	/usr/sbin/blkdiscard -f ${SCRATCH_DEV_ARRAY[$j]} # --offset 2M
> >
> > 	btrfs scrub start -Bd $SCRATCH_MNT | grep 'summary\|Uncorrectable'
> >
> > done
> >
> > This problem will not happen if we change the test data to simpler one.
> > # about 220M data of '/usr/bin' to single 1G file
> >
> > This problem will not happen if we clear cache with 'umount; mount'
> > between multiple loop.
> > # 'sync; sleep 5; ...' to  'umount; mount'
> >
> > so it seems that some info in memory is wrong after RAID5 recovery?
> >
> > [1]
> > Subject: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
> > during raid5 recovery
> > https://lore.kernel.org/linux-btrfs/9dfb0b60-9178-7bbe-6ba1-10d056a7e84c@gmx.com/T/#t
> 
> That case is in fact not related to RAID56, and we already have the fix
> for it:
> https://lore.kernel.org/linux-btrfs/1d9b69af6ce0a79e54fbaafcc65ead8f71b54b60.1660377678.git.wqu@suse.com/

This problem still happen on  linux 5.20(20220812) with the flowing patches.

Subject: btrfs: scrub: properly report super block errors in system log
Subject: btrfs: scrub: try to fix super block errors
(v2)Subject: btrfs: don't merge pages into bio if their page offset is not

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/14


